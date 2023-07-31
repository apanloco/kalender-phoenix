defmodule Month do
  def to_name(month) do
    month_names = %{
      1 => "Januari",
      2 => "Februari",
      3 => "Mars",
      4 => "April",
      5 => "Maj",
      6 => "Juni",
      7 => "Juli",
      8 => "Augusti",
      9 => "September",
      10 => "Oktober",
      11 => "November",
      12 => "December"
    }

    Map.get(month_names, month)
  end
end
