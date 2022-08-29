(define (problem problem1)
(:domain sample)
(:objects
    square1 square2 square3 square4 square5 square6 square7 square8 square9 - square
    one two three four five six seven eight - numbers
    space - space
)

(:init
    (connec square1 square2)
    (connec square1 square4)
    (connec square2 square3)
    (connec square2 square5)
    (connec square3 square6)
    (connec square4 square5)
    (connec square4 square7)
    (connec square5 square6)
    (connec square5 square8)
    (connec square6 square9)
    (connec square7 square8)
    (connec square8 square9)
    (at square1 two)(at square2 eight)(at square3 five)(at square4 seven)(at square5 space)(at square6 six)(at square7 three)(at square8 one)(at square9 four)
)

(:goal
    (and
    (at square1 one) 
    (at square2 two) 
    (at square3 three)
    (at square4 four) 
    (at square5 five) 
    (at square6 six)
    (at square7 seven)
    (at square8 eight)
    (at square9 space)
    )
)
)
