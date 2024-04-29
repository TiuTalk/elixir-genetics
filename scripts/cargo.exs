defmodule Cargo do
  alias Types.Chromosome

  @behaviour Problem

  @profits [6, 5, 8, 9, 6, 7, 3, 1, 2, 6]
  @weights [10, 6, 8, 7, 10, 9, 7, 11, 6, 8]
  @weight_limit 40

  def weights, do: @weights

  @impl true
  def genotype do
    genes = for _ <- 1..10, do: Enum.random(0..1)

    %Chromosome{genes: genes, size: Enum.count(genes)}
  end

  @impl true
  def fitness_function(chromosome) do
    potential_profit =
      chromosome.genes
      |> Enum.zip(@profits)
      |> Enum.map(fn {c, p} -> c * p end)
      |> Enum.sum

    over_limit? =
      chromosome.genes
      |> Enum.zip(@weights)
      |> Enum.map(fn {c, w} -> c * w end)
      |> Enum.sum
      |> Kernel.>(@weight_limit)

    profits = if over_limit?, do: 0, else: potential_profit
    profits
  end

  @impl true
  def terminate?(_, generation), do: generation == 1000
end

solution = Genetic.run(Cargo)
weight = Enum.zip(solution.genes, Cargo.weights) |> Enum.map(fn {c, w} -> c * w end) |> Enum.sum

IO.puts("\n")
IO.inspect(solution)
IO.puts("Total weight: #{weight}")
