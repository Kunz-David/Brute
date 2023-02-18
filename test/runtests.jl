using Base: is_file_tracked
using Brute
using Test: @test as @run_test, @testset



# prevents error loggin in methods
Base.CoreLogging.with_logger(Base.CoreLogging.NullLogger()) do

    @testset "Brute.jl" begin
        path = "student.jl"
        bad_path = "asdf.jl"
        wrong_path = "wrong_file.md"

        @testset "Metatests" begin
            # should work
            @run_test file_exists(path)
            @run_test is_file_runnable!(path)
            # nonexistant file
            @run_test file_exists(bad_path) == false
            @run_test is_file_runnable!(bad_path) == false
            # wrong file
            @run_test file_exists(wrong_path)
            @run_test is_file_runnable!(wrong_path) == false
        end

        @testset "Existance of types and methods" begin
            is_file_runnable!(path)
            @run_test definition_exists(:pdf, Function)
            @run_test definition_exists(:pdf, Type) == false
            @run_test definition_exists(:Gauss, Type)
            @run_test definition_exists(:Gauss, Function) == false
        end

        @testset "preprocessing" begin
            content = """
                #hideblock begin
                using Brute;

                file_exists("run_literate.jl")
                evaluation = Evaluation(name="Homework #1", url="https://www.markdownguide.org/cheat-sheet/", maxpoints=10) #outmd
                # evaluation = HyperParams(asdf=12)

                #hideblock end
                """
            content_no_comments = """

                using Brute;

                file_exists("run_literate.jl")
                evaluation = Evaluation(name="Homework #1", url="https://www.markdownguide.org/cheat-sheet/", maxpoints=10) #outmd



                """
            content_hidden_block_processed = """
                #hideblock begin #hide
                using Brute; #hide
                 #hide
                file_exists("run_literate.jl") #hide
                evaluation = Evaluation(name="Homework #1", url="https://www.markdownguide.org/cheat-sheet/", maxpoints=10) #outmd #hide
                # evaluation = HyperParams(asdf=12) #hide
                 #hide
                #hideblock end #hide
                """
            @run_test Brute.remove_comments_fun(content) == content_no_comments
            @run_test Brute.hide_hidden_blocks(content, remove_comments=false) == content_hidden_block_processed
        end

    end
end