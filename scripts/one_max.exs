defmodule OneMax do
  alias Types.Chromosome

  @behaviour Problem

  @impl true
  def genotype do
    genes = Enum.map(1..42, fn _ -> Enum.random(0..1) end)
    %Chromosome{genes: genes, size: Enum.count(genes)}
  end

  @impl true
  def fitness_function(chromosome), do: Enum.sum(chromosome.genes)

  @impl true
  def terminate?([best | _]), do: best.fitness == Enum.count(best.genes)
end

solution = Genetic.run(OneMax)

IO.puts("\n")
IO.inspect(solution)
