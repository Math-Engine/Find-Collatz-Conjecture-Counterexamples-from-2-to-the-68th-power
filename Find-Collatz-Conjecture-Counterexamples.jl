run(`git pull origin main`)

startNum = parse(BigInt, read("max", String)) + 1
endNum = startNum;

if length(ARGS) < 1
    endNum = endNum
else
    endNum = endNum + parse(BigInt, ARGS[1]) - 1
end

for i in startNum:endNum
  bigint_i = BigInt(i)
  n = bigint_i
  if n%2 == 0
    # println("[$(n), $(n//2), \"...\", 1]")
    continue
  else
    HailStoneNumber = Any[n]
    while (n != 1)
      if n%2 == 0
        n = n//2
      else
        n = n*3 + 1 # 3n + 1
      end
      if n < bigint_i
        append!(HailStoneNumber, ["...", 1])
        break
      end
    end
    push!(HailStoneNumber, n)
  end
  # println(HailStoneNumber)
end

open("max", "w") do file
    write(file, string(endNum))
end

run(`git config user.name "github-actions[bot]"`)
run(`git config user.email "github-actions[bot]@users.noreply.github.com"`)

commitMessage = ""
if (endNum - startNum) > 1
  commitMessage = "Calculated from $(startNum) ~ $(endNum), no counterexamples"
else
  commitMessage = "Calculated $(endNum), no counterexample"
end

run(`git add .`)
run(`git commit -m $(Base.shell_escape(commitMessage))`)
run(`git push`)
