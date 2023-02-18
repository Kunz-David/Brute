using Base: is_file_tracked
using Brute
using Test

# prevents error loggin in methods
Base.CoreLogging.with_logger(Base.CoreLogging.NullLogger()) do

    @testset "Brute.jl" begin

        # @brute "Name of the tested homework" begin
        #     @description "Homework 1, will test some basic stuff"
        #     @max_points 1



        #     @test_group "test group name" begin
        #         @title "title"
        #         @type :Mandatory
        #         @deps :list :of :depependent :test_groups
        #         @description "now we will test functionality # 1"
        #         @max_points 12



        #     end

        #     "basic_test.jl"
        # end
        path = "student.jl"
        bad_path = "asdf.jl"
        wrong_path = "wrong_file.md"

        @testset "Metatests" begin
            # should work
            @test file_exists(path)
            @test is_file_runnable!(path)
            # nonexistant file
            @test file_exists(bad_path) == false
            @test is_file_runnable!(bad_path) == false
            # wrong file
            @test file_exists(wrong_path)
            @test is_file_runnable!(wrong_path) == false
        end

        @testset "Existance of types and methods" begin
            is_file_runnable!(path)
            @test definition_exists(:pdf, Function)
            @test definition_exists(:pdf, Type) == false
            @test definition_exists(:Gauss, Type)
            @test definition_exists(:Gauss, Function) == false
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
            @test Brute.remove_comments_fun(content) == content_no_comments
            @test Brute.hide_hidden_blocks(content, remove_comments=false) == content_hidden_block_processed
        end

    end
end