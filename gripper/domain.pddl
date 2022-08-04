;Header and description

(define (domain gripper-strips)


(:predicates 
(room ?r)
(ball ?obj)
(at ?b ?r)
(at-lobby ?r)
(gripper ?g)
(carry ?b ?g)
(free ?g)
 ;todo: define predicates here
)


(:action pick
    :parameters (?objects ?room ?gripper)
    :precondition (
        and
        (ball ?objects)
        (room ?room)
        (gripper ?gripper)
        (free ?gripper)
        (at ?objects ?room)
        (at-lobby ?room)
    )
    :effect (and 
    (not(free ?gripper))
    (carry ?objects ?gripper)
    (not (at ?objects ?room))
    )
)
(:action  move
        :parameters (?from ?to )
        :precondition (and 
        (room ?from)
        (room ?to)
        (at-lobby ?from))
        :effect (and 
        (at-lobby ?to)
        (not(at-lobby ?from)))
)
(:action drop
        :parameters (?room ?ball ?gripper)
        :precondition (and
        (at-lobby ?room)
        (ball ?ball)
        (room ?room)
        (not (free ?gripper))
        (gripper ?gripper)
        (carry ?ball ?gripper) )
        :effect (and 
        (not(carry ?ball ?gripper))
        (free ?gripper)
        (at ?ball ?room))
)
    
      
;define actions here

)