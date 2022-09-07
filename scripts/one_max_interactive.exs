defmodule OneMax do
  @moduledoc false
  @behaviour Problem

  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..10, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: length(genes)}
  end

  @impl true
  def fitness_function(chromosome) do
    IO.inspect(chromosome.genes)

    IO.gets("Rate from 1 to 10: ")
    |> String.trim()
    |> String.to_integer()
  end

  @impl true
  def terminate?([best | _], _generation, _temperature), do: best.fitness == 10
end

solution = Genetic.run(OneMax, population_size: 4)

IO.puts("Solution:")
IO.inspect(solution)
