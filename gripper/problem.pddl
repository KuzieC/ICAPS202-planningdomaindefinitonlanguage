(define (problem solve) (:domain gripper-strips)
(:objects 
    rooma roomb balla ballb leftgrip rightgrip
)       

(:init
    (room rooma)
    (room roomb)
    (ball balla)
    (ball ballb)
    (gripper leftgrip)
    (gripper rightgrip)
    (free leftgrip)
    (free rightgrip)
    (at balla rooma)
    (at ballb roomb)
    (at-lobby rooma)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    ;todo: put the goal condition here
    (at balla roomb)
    (at ballb rooma)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
