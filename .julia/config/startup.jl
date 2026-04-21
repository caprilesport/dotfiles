using Pkg
Base.atreplinit() do repl
    @eval begin
        Pkg.develop(path="/home/vport/projects/JuliaUtils")
        @async @eval using Revise
        @async @eval using BenchmarkTools
        import OhMyREPL as OMR
        import Crayons as C
        using JuliaUtils
        promptfn() = "(" * splitpath(Base.active_project())[end-1] * ") julia> "
        OMR.input_prompt!(promptfn)
        OMR.colorscheme!("OneDark")
        OMR.enable_pass!("RainbowBrackets", false)
        OMR.Passes.BracketHighlighter.setcrayon!(C.Crayon(foreground=:blue))
    end
end

