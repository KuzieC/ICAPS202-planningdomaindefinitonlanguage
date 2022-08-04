
(define (domain logistic)
    (:requirements :negative-preconditions :disjunctive-preconditions :durative-actions :fluents :numeric-fluents)

    ; un-comment following line if constants are needed
    ;(:constants )

    (:predicates ;todo: define predicates here
        (driver ?driver)
        (truck ?truck)
        (package ?package)
        (wp ?wp)
        (empty ?truck)
        (loaded ?truck)
        (packageat ?wp ?package)
        (truckat ?wp ?truck)
        (driverat ?wp ?driver)
        (connected ?wp1 ?wp2)
        (truckhave ?truck ?package)
    )
    (:functions
        (dis ?wp1 ?wp2)
    )
    (:durative-action load
        :parameters (?package ?truck ?wp)
        :duration (= ?duration 10)
        :condition (and
            (over all(package ?package))
            (over all(truck ?truck))
            (over all(wp ?wp))
            (at start (not (loaded ?truck)))
            (at start (packageat ?wp ?package))
            (at start (truckat ?wp ?truck))
            
        )
        :effect (and
            (at end(loaded ?truck))
            (at end(not(packageat ?wp ?package)))
            (at end(truckhave ?truck ?package))
            )
    )
    (:durative-action unload
        :parameters (?package ?truck ?wp)
        :duration (= ?duration 10)
        :condition (and
            (over all(package ?package))
            (over all(truck ?truck))
            (over all(wp ?wp))
            (at start(loaded ?truck))
            (at start(truckat ?wp ?truck))
            (at start(truckhave ?truck ?package))
        )
        :effect (and
            (at end(not(loaded ?truck)))
            (at end(packageat ?wp ?package))
            (at end(not (truckhave ?truck ?package)))
            )
    )
    (:durative-action walkto
        :parameters (?wp1 ?wp2 ?driver)
        :duration (= ?duration (/ (dis ?wp1 ?wp2) 0.5))
        :condition (and
            (over all (wp ?wp1))
            (over all(wp ?wp2))
            (over all(driver ?driver))
            (at start(driverat ?wp1 ?driver))
            (over all(or(connected ?wp1 ?wp2)(connected ?wp2 ?wp1)))
        )
        :effect (and
            (at end(not (driverat ?wp1 ?driver)))
            (at end(driverat ?wp2 ?driver))
        )
    )
    (:durative-action geton
        :parameters (?driver ?truck ?wp)
        :duration (= ?duration 10)
        :condition (and
            (over all(driver ?driver))
            (over all(truck ?truck))
            (over all(wp ?wp))
            (at start(empty ?truck))
            (at start(truckat ?wp ?truck))
            (at start(driverat ?wp ?driver))
        )
        :effect (and
            (at end(not (empty ?truck)))
            (at end(not (driverat ?wp ?driver))))
    )
    (:durative-action getoff
        :parameters (?driver ?wp ?truck)
        :duration (= ?duration 10)
        :condition (and
            (over all(driver ?driver))
            (over all(wp ?wp))
            (over all(truck ?truck))
            (at start(not (empty ?truck)))
            (at start(truckat ?wp ?truck))
        )
        :effect (and
            (at end(empty ?truck))
            (at end(driverat ?wp ?driver)))
    )
    (:durative-action move
        :parameters (?truck ?wp1 ?wp2)
        :duration (= ?duration (dis ?wp1 ?wp2))
        :condition (and
            (over all(truck ?truck))
            (over all(wp ?wp1))
            (over all(wp ?wp2))
            (at start(truckat ?wp1 ?truck))
            (over all(or
                (connected ?wp1 ?wp2)(connected ?wp2 ?wp1)
            ))
            (at start(not (empty ?truck))))
        :effect (and
            (at end(truckat ?wp2 ?truck))
            (at end(not (truckat ?wp1 ?truck)))
        )

    )

    ;define actions here

)