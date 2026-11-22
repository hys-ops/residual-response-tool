import Std

/- A level acts on the truth table of a unary context.  The source gate and
   its realization on raw coordinates are proved separately in the note. -/
namespace TournamentLookup

def step {α : Type} (w : List α) (b : α) := w.reverse ++ [b]

def table : List Bool → List Bool
  | [] => [false, true]
  | b :: rest => step (table rest) b

def decode : Nat → List Bool → List Bool
  | 0, _ => []
  | n + 1, w =>
    match w.reverse with
    | [] => []
    | b :: rest => b :: decode n rest

theorem decode_table (p : List Bool) : decode p.length (table p) = p := by
  induction p with
  | nil => rfl
  | cons b p ih => simp [decode, table, step, ih]

theorem table_length (p : List Bool) : (table p).length = p.length + 2 := by
  induction p with
  | nil => rfl
  | cons b p ih => simp [table, step, ih, Nat.add_assoc]

theorem table_injective {p q : List Bool} (h : table p = table q) : p = q := by
  have ht := congrArg List.length h
  simp only [table_length] at ht
  have hl : p.length = q.length := by omega
  calc p = decode p.length (table p) := (decode_table p).symm
       _ = decode q.length (table q) := by rw [hl, h]
       _ = q := decode_table q

-- At each height the two active rows test exactly these alternatives.
def twoRows (Q h blocker q : Nat) : Prop :=
  h < Q - q ∨ (h = Q ∧ blocker < Q - q)

theorem section_formula (Q h e q : Nat) (hQ : h ≤ Q) (he : e < Q)
    (hq : 0 < q) (hqQ : q < Q) :
    twoRows Q h (Q - 1 - e) q ↔
      q ≤ (if h = Q then e else Q - 1 - h) := by
  unfold twoRows
  split <;> omega


def MiddleOK (w : Nat → Bool) (c : Nat) : Prop :=
  w c = true → w (c-1) = true ∧ w (c+1) = true

def capped (H D E : Nat) (w : Nat → Bool) (h : Nat) : Bool :=
  if h = H+1 then w E else w (min D (H-h))

theorem preserve_middle (w : Nat → Bool) (H c D E : Nat)
    (hc : 0 < c) (hcH : c < H) (hp : MiddleOK w c) :
    MiddleOK (capped H D E w) (H-c) := by
  have hmid : H-c ≠ H+1 := by omega
  have hleft : H-c-1 ≠ H+1 := by omega
  have hright : H-c+1 ≠ H+1 := by omega
  have m : H-(H-c) = c := by omega
  have l : H-(H-c-1) = c+1 := by omega
  have r : H-(H-c+1) = c-1 := by omega
  simp only [MiddleOK, capped, ite_eq_right hmid, ite_eq_right hleft, ite_eq_right hright, m, l, r]
  by_cases hs : D < c
  · have h₁ : min D c = D := by omega
    have h₂ : min D (c+1) = D := by omega
    have h₃ : min D (c-1) = D := by omega
    simp [h₁, h₂, h₃]
  · have h₁ : min D c = c := by omega
    have h₃ : min D (c-1) = c-1 := by omega
    rw [h₁, h₃]
    intro h
    obtain ⟨left, right⟩ := hp h
    refine ⟨?_, left⟩
    by_cases he : D = c
    · simpa [he] using h
    · have hh : min D (c+1) = c+1 := by omega
      simpa [hh] using right

theorem realize_middle (t : Nat → Bool) (H c : Nat)
    (hc : 0 < c) (hcH : c < H) (ht : MiddleOK t (H-c)) :
    ∃ w D E, MiddleOK w c ∧ D ≤ H ∧ E ≤ H ∧
        ∀ h, h ≤ H+1 → capped H D E w h = t h := by
  classical
  by_cases occurs : ∃ e, e ≤ H ∧ t (H-e) = t (H+1)
  · obtain ⟨e, he, hit⟩ := occurs
    refine ⟨fun j => t (H-j), H, e, ?_, by omega, he, ?_⟩
    · intro mid
      obtain ⟨a,b⟩ := ht mid
      have hx : H-(c-1) = H-c+1 := by omega
      have hy : H-(c+1) = H-c-1 := by omega
      exact ⟨by simpa [hx] using b, by simpa [hy] using a⟩
    · intro h hh
      unfold capped
      split
      next hlast => simpa [hlast] using hit
      next hlast =>
        have hmin : min H (H-h) = H-h := by omega
        have rev : H-(H-h) = h := by omega
        simp [hmin, rev]
  · have miss (j : Nat) (hj : j ≤ H) : t j ≠ t (H+1) := by
      intro eq
      apply occurs
      refine ⟨H-j, by omega, ?_⟩
      have rev : H-(H-j) = j := by omega
      simpa [rev] using eq
    have same (j : Nat) (hj : j ≤ H) : t 0 = t j := by
      have h1 := miss 0 (by omega)
      have h2 := miss j hj
      revert h1 h2
      cases t 0 <;> cases t j <;> cases t (H+1) <;> decide
    let w := fun j : Nat => if j = 0 then t 0 else if j = H then t (H+1) else false
    have hc0 : c ≠ 0 := by omega
    have hcHn : c ≠ H := by omega
    have hH0 : H ≠ 0 := by omega
    refine ⟨w, 0, H, ?_, by omega, by omega, ?_⟩
    · simp [MiddleOK, w, hc0, hcHn]
    · intro h hh
      by_cases last : h = H+1
      · simp [capped, w, hH0, last]
      · simpa [capped, w, last] using same h (by omega)

def triple (a b c : Bool) (h : Fin 3) : Bool :=
  if h.val = 0 then a else if h.val = 1 then b else c

def baseChoices (a b c : Bool) : Prop :=
  (∃ k : Bool, ∀ h : Fin 3, triple a b c h = k) ∨
  (∃ D E : Fin 2, ∀ h : Fin 3, triple a b c h =
    (if h.val = 2 then (E.val == 1) else (min D.val (1-h.val) == 1)))

theorem base_iff : ∀ a b c : Bool,
    baseChoices a b c ↔ (b = true → a = true ∧ c = true) := by
  unfold baseChoices triple
  decide

-- n = d-1; the old maximum height at this stage is n+2.
def middle : Nat → Nat
  | 0 => 1
  | n+1 => n+2-middle n

theorem middle_bounds (n : Nat) : 0 < middle n ∧ middle n < n+2 := by
  induction n with
  | zero => decide
  | succ n ih => simp only [middle]; omega

theorem middle_value (n : Nat) : middle n = (n+2)/2 := by
  induction n with
  | zero => decide
  | succ n ih => simp only [middle, ih]; omega

def generated : Nat → (Nat → Bool) → Prop
  | 0, t => baseChoices (t 0) (t 1) (t 2)
  | n+1, t =>
    (∃ b : Bool, ∀ h, h ≤ n+3 → t h = b) ∨
    (∃ w D E, generated n w ∧ D ≤ n+2 ∧ E ≤ n+2 ∧
       ∀ h, h ≤ n+3 → capped (n+2) D E w h = t h)

theorem exact_language (n : Nat) (t : Nat → Bool) :
    generated n t ↔ MiddleOK t (middle n) := by
  induction n generalizing t with
  | zero => exact base_iff _ _ _
  | succ n ih =>
    have ⟨hc, hH⟩ := middle_bounds n
    constructor
    · rintro (⟨b, con⟩ | ⟨w,D,E,old,hD,hE,eq⟩)
      · simp only [middle, MiddleOK]
        rw [con _ (by omega), con _ (by omega), con _ (by omega)]
        simp
      · have ok := preserve_middle w (n+2) (middle n) D E hc hH ((ih w).mp old)
        simp only [MiddleOK] at ok
        rw [eq _ (by omega), eq _ (by omega), eq _ (by omega)] at ok
        exact ok
    · intro ht
      obtain ⟨w,D,E,old,hD,hE,eq⟩ := realize_middle t (n+2) (middle n) hc hH ht
      exact Or.inr ⟨w,D,E,(ih w).mpr old,hD,hE,eq⟩

#print axioms exact_language
#print axioms middle_value

#print axioms realize_middle

#print axioms preserve_middle

#print axioms section_formula
#print axioms table_injective
#print axioms decode_table
end TournamentLookup
