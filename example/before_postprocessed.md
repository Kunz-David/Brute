````julia





````

````
WARNING: replacing module student.
WARNING: replacing module teacher.

````

# Homework #1 Evaluation!


````julia
test1 = @test evaluation student.pdf(student.Gauss(1, 2), 1) teacher.pdf(teacher.Gauss(1, 2), 1) (optionality=mandatory, access=public) #onlymd
````

````
## Test #1 ✔️

*#1 is public and mandatory (max. 1 point(s)).*

### Result

Nice! public test passed! 🎉

<details>
    <summary>
    Results
    </summary>

| call                                | result                |
|-------------------------------------|-----------------------|
| teacher.pdf(teacher.Gauss(1, 2), 1) | `0.19947114020071635` |
| student.pdf(student.Gauss(1, 2), 1) | `0.19947114020071635` |


</details>



<details>
    <summary>
    Your Output
    </summary>

```

```


</details>



````

````julia
test2 = @test evaluation student.pdf(student.Gauss(1, 2), 1) teacher.pdf(teacher.Gauss(1, 2), 1) (optionality=mandatory, access=public) #onlymd
````

````
## Test #2 ✔️

*#2 is public and mandatory (max. 1 point(s)).*

### Result

Nice! public test passed! 🎉

<details>
    <summary>
    Results
    </summary>

| call                                | result                |
|-------------------------------------|-----------------------|
| teacher.pdf(teacher.Gauss(1, 2), 1) | `0.19947114020071635` |
| student.pdf(student.Gauss(1, 2), 1) | `0.19947114020071635` |


</details>



<details>
    <summary>
    Your Output
    </summary>

```

```


</details>



````

the following test is for ...

````julia
@test evaluation student.pdf_mistake(student.Gauss(1, 2), 1) teacher.pdf(teacher.Gauss(1, 2), 1) (optionality=optional, access=private) #onlymd
````

````
## Test #3 ❌

*#3 is private and optional (max. 1 point(s)).*

### Result

Yikes! private test failed. 😞 Try the following...

| call                                        | result                |
|---------------------------------------------|-----------------------|
|         teacher.pdf(teacher.Gauss(1, 2), 1) | `0.19947114020071635` |
| student.pdf_mistake(student.Gauss(1, 2), 1) |  `1.1994711402007163` |





````

````julia
@test evaluation student.pdf(student.Gauss(1, 2), 1) teacher.pdf(teacher.Gauss(1, 2), 1) (optionality=mandatory, access=private) #onlymd
````

````
## Test #4 ✔️

*#4 is private and mandatory (max. 1 point(s)).*

### Result

Nice! private test passed! 🎉

<details>
    <summary>
    Results
    </summary>

| call                                | result                |
|-------------------------------------|-----------------------|
| teacher.pdf(teacher.Gauss(1, 2), 1) | `0.19947114020071635` |
| student.pdf(student.Gauss(1, 2), 1) | `0.19947114020071635` |


</details>





````

````julia
print(create_summary(evaluation)) #onlymd
````

````
# *Homework #1 - Summary:*

**You have passed!**

| name    | passed | status | gained | optionality | access    |
|---------|--------|--------|--------|-------------|-----------|
| Test #4 |   true |  `ran` |    1/1 | `mandatory` | `private` |
| Test #2 |   true |  `ran` |    1/1 | `mandatory` |  `public` |
| Test #3 |  false |  `ran` |    0/1 |  `optional` | `private` |
| Test #1 |   true |  `ran` |    1/1 | `mandatory` |  `public` |


Total points gained: 3

````

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

