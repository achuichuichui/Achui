;;; cad_script.lsp — Building outline (plan view)
;;; Dimensions: length 20 m x width 10 m x height 5 m
;;; Units: meters
;;;
;;; Usage:
;;;   (load "cad_script.lsp")
;;;   BUILDING-OUTLINE
;;;
;;; What it draws:
;;;   1. Layer BUILDING-OUTLINE (created and set current)
;;;   2. Footprint rectangle 20 x 10
;;;   3. Linear dimensions: 20 m and 10 m
;;;   4. Text label (height 5 m shown as text only in plan view)

(defun C:BUILDING-OUTLINE ( / )
  ;; 1. Ensure layer exists and set it current
  (if (not (tblsearch "LAYER" "BUILDING-OUTLINE"))
    (command "_.-LAYER" "_NEW" "BUILDING-OUTLINE" "")
  )
  (setvar "CLAYER" "BUILDING-OUTLINE")

  ;; 2. Building footprint rectangle: 20 m x 10 m
  (command "_RECTANG" (list 0.0 0.0 0.0) (list 20.0 10.0 0.0))

  ;; 3. Dimension settings (readable at meter scale)
  (setvar "DIMTXT" 1.5)
  (setvar "DIMASZ" 0.75)
  (setvar "DIMEXO" 0.5)
  (setvar "DIMEXE" 0.75)

  ;; 4. Length dimension (bottom edge): 20 m
  (command "_DIMLINEAR" (list 0.0 0.0 0.0) (list 20.0 0.0 0.0) (list 10.0 -3.0 0.0))

  ;; 5. Width dimension (right edge): 10 m
  (command "_DIMLINEAR" (list 20.0 0.0 0.0) (list 20.0 10.0 0.0) (list 23.0 5.0 0.0))

  ;; 6. Text label
  (command "_TEXT" "J" "M" (list 10.0 12.0 0.0) 2.0 0.0 "Building Outline: 20 x 10 x 5 m")

  ;; 7. Zoom to extents
  (command "_.ZOOM" "_E")

  (princ "\nBuilding outline drawn (20 x 10 x 5 m).")
  (princ)
)

;;; Load message
(princ "\ncad_script.lsp loaded — run BUILDING-OUTLINE to draw.")
(princ)