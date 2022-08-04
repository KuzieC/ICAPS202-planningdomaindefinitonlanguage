
(define (domain logistic)
    (:requirements :negative-preconditions :disjunctive-preconditions :durative-actions :fluents :numeric-fluents)

    ; un-comment following line if constants are needed
    ;(:constants )

    (:predicates ;todo: define predicates here
        (driver ?driver)
        (truck ?truck)
        (package ?package)
        (wp ?wp)
        (plane ?plane)
        (planeat ?wp)
        (planehave ?package)
        (ship ?ship)
        (shipat ?wp)
        (shiphave ?package)
        (empty ?truck)
        (loaded ?truck)
        (loaded1 ?plane)
        (loaded2 ?ship)
        (packageat ?wp ?package)
        (truckat ?wp ?truck)
        (driverat ?wp ?driver)
        (connected ?wp1 ?wp2)
        (airconnected ?wp1 ?wp2)
        (seaconnected ?wp1 ?wp2)
        (truckhave ?truck ?package)
    )
    (:functions
        (dis ?wp1 ?wp2)
    )
    (:durative-action loadship
        :parameters (?ship ?wp ?package)
        :duration (= ?duration 10)
        :condition (and
            (at start (and
                    (shipat ?wp)
                    (not (loaded2 ?ship))
                    (packageat ?wp ?package)
                ))
            (over all (and
                    (wp ?wp)
                    (ship ?ship)
                    (package ?package)
                ))
        )
        :effect (and
            (at end (and
                    (loaded2 ?ship)
                    (shiphave ?package)
                    (not (packageat ?wp ?package))
                ))
        )
    )
    (:durative-action unloadship
        :parameters (?ship ?wp ?package)
        :duration (= ?duration 10)
        :condition (and
            (at start (and
                    (shipat ?wp)
                    (loaded2 ?ship)
                    (shiphave ?package)
                ))
            (over all (and
                    (wp ?wp)
                    (ship ?ship)
                    (package ?package)
                ))
        )
        :effect (and

            (at end (and
                    (not (loaded2 ?ship))
                    (not (shiphave ?package))
                    (packageat ?wp ?package)
                ))
        )
    )
    (:durative-action loadair
        :parameters (?plane ?wp ?package)
        :duration (= ?duration 10)
        :condition (and
            (at start (and
                    (planeat ?wp)
                    (not (loaded1 ?plane))
                    (packageat ?wp ?package)
                ))
            (over all (and
                    (wp ?wp)
                    (plane ?plane)
                    (package ?package)
                ))
        )
        :effect (and
            (at end (and
                    (loaded1 ?plane)
                    (planehave ?package)
                    (not (packageat ?wp ?package))
                ))
        )
    )
    (:durative-action unloadair
        :parameters (?plane ?wp ?package)
        :duration (= ?duration 10)
        :condition (and
            (at start (and
                    (planeat ?wp)
                    (loaded1 ?plane)
                    (planehave ?package)
                ))
            (over all (and
                    (wp ?wp)
                    (plane ?plane)
                    (package ?package)
                ))
        )
        :effect (and

            (at end (and
                    (not (loaded1 ?plane))
                    (not (planehave ?package))
                    (packageat ?wp ?package)
                ))
        )
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
    (:durative-action fly-to
        :parameters (?plane ?wp1 ?wp2)
        :duration (= ?duration (/(dis ?wp1 ?wp2) 2))
        :condition (and
            (at start (and
                    (planeat ?wp1)
                ))
            (over all (and
                    (wp ?wp1)
                    (wp ?wp2)
                    (plane ?plane)
                    (or
                        (airconnected ?wp1 ?wp2)(airconnected ?wp2 ?wp1)
                    )
                ))

        )
        :effect (and
            (at start (and
                    (not (planeat ?wp1))
                ))
            (at end (and
                    (planeat ?wp2)
                ))
        )
    )
    (:durative-action ship-to
        :parameters (?ship ?wp1 ?wp2)
        :duration (= ?duration (/(dis ?wp1 ?wp2) 1.5))
        :condition (and
            (at start (and
                    (shipat ?wp1)
                ))
            (over all (and
                    (wp ?wp1)
                    (wp ?wp2)
                    (ship ?ship)
                    (or
                        (seaconnected ?wp1 ?wp2)(seaconnected ?wp2 ?wp1)
                    )
                ))

        )
        :effect (and
            (at start (and
                    (not (shipat ?wp1))
                ))
            (at end (and
                    (shipat ?wp2)
                ))
        )
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
            (at start(not (truckat ?wp1 ?truck)))
        )

    )

    ;define actions here

)