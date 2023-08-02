defmodule KalenderWeb.KalenderController do
  use KalenderWeb, :controller
  alias HTTPoison

  def index(conn, %{"year" => year_string, "month" => month_string}) do
    with {year, ""} <- Integer.parse(year_string),
         {month, ""} <- Integer.parse(month_string),
         true <- year in 1903..2998,
         true <- month in 1..12 do
      case HTTPoison.get("https://calendar-api.akerud.se/#{year}/#{month}") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          data = body |> Jason.decode!()
          render(conn, "index.html", layout: false, year: year, month: month, data: data)

        {:ok, %HTTPoison.Response{status_code: status_code}} ->
          send_resp(conn, 500, "Something went wrong")

        {:error, %HTTPoison.Error{reason: _reason}} ->
          send_resp(conn, 500, "Internal server error")
      end
    else
      _ -> send_resp(conn, 400, "Invalid year or month")
    end
  end

  def home(conn, _params) do
    date = DateTime.utc_now()
    year = Map.fetch!(date, :year)
    month = Map.fetch!(date, :month)
    redirect(conn, to: ~p"/#{year}/#{month}")
  end
end
