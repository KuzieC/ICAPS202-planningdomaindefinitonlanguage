(define (domain sample)
(:requirements :typing  :disjunctive-preconditions)

(:types
    location locatable - object
    square - location
    space numbers - locatable
    
)

(:predicates
    (at ?square - location ?numbers - locatable)
    (connec ?square1 ?square2 - square)
)

(:action switch
    :parameters ( ?numbers - numbers ?space - space ?square1 ?square2 - square)
    :precondition (and 
    (or(connec ?square1 ?square2)(connec ?square2 ?square1))
    (and (at ?square1 ?numbers)(at ?square2 ?space)))
    :effect (and 
    (at ?square1 ?space)
    (at ?square2 ?numbers)
    (not (at ?square1 ?numbers))
    (not (at ?square2 ?space))
    )
    )

)


