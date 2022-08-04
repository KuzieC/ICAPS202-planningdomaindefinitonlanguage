(define (problem solve)
    (:domain cleanning-robot)
    (:objects
        rooma roomb roomc robot
    )

    (:init
        (room rooma)
        (room roomb)
        (room roomc)
        (robot robot)
        (not(cleaned rooma))
        (not(cleaned roomb))
        (not(cleaned roomc))

        (charged robot)
        (at robot rooma)
        ;todo: put the initial state's facts and numeric values here
    )

    (:goal
        (and
            (cleaned rooma)
            (cleaned roomb)
            (cleaned roomc)
            ;todo: put the goal condition here
        ) 
    )

    ;un-comment the following line if metric is needed
    ;(:metric minimize (???))
)