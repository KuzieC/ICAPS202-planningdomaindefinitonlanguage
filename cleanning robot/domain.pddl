;Header and description

(define (domain cleanning-robot)
    (:requirements :negative-preconditions)



; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
(room ?room)
(robot ?robot)
(at ?robot ?room)
(cleaned ?room)
(charged ?robot)
)


(:action cleaning
    :parameters (?robot ?room)
    :precondition 
    (and 
    (not (cleaned ?room))
    (charged ?robot)
    (room ?room)
    (robot ?robot)
    (at ?robot ?room)
    )
    :effect 
    (and 
    (cleaned ?room)
    (not(charged ?robot))
    (at ?robot ?room)
    )
)
(:action charging
    :parameters (?robot)
    :precondition( and
    (not (charged ?robot))
    
    )
    :effect ( and
    (charged ?robot)
    )
)
(:action move
    :parameters (?robot ?rooma ?roomb)
    :precondition (and 
    (at ?robot ?rooma)
    (not (at ?robot ?roomb)))
    :effect (and 
    (at ?robot ?roomb)
    (not (at ?robot ?rooma)))

)



;define actions here

)