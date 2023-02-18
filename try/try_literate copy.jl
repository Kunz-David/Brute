#hideblock begin
using Brute;

# evaluation = Evaluation(name="Homework #1", url="https://www.markdownguide.org/cheat-sheet/", maxpoints=10) #outmd


is_file_runnable!("studnt.jl")


#hideblock end

is_file_runnable!("studnt.jl")


# # Rational numbers
#
# In julia rational numbers can be constructed with the `//` operator.
# Lets define two rational numbers, `x` and `y`:

x = 1 // 3
#-
y = 2 // 5
y = 2 // 5

#=
Hello this should be markdown

# H1
## H2

<details>
  <summary>
    summary
  </summary>
  details
</details>
=#

# When adding `x` and `y` together we obtain a new rational number:

# <details>
#   <summary>
#     summary
#   </summary>
z = x + y #hide
# </details>


#--
#hideblock begin
z = x + y + 123 * 123
a = x + y + 123 * 123
#hideblock end