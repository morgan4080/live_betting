defmodule LiveBettingWeb.SportsComponent do
  use LiveBettingWeb, :live_component

  import LiveBettingWeb.CoreComponents
  alias Phoenix.LiveView.JS
  alias LiveBetting.Schema.Sport
  alias LiveBetting.Context.Sports

  # LiveComponent is a stateful component, compartmentalize state, markup, and events
  # Lifecycle
  # 1. mount(socket): called once, when the component is first added to the page
  # 2. update(assigns, socket)
  # 3. render(assigns)

  attr :current_path, :string, default: "/"

  def render(assigns) do
    ~H"""
    <div id={"#{@id}"}>
      <div class="-mt-12 px-4 sm:px-6 lg:px-8 flex justify-start items-center overflow-x-scroll gap-4">
        <button
          :for={{_id, sport} <- @streams.sports}
          class="my-1 group inline-flex items-center h-9 rounded-full text-xs font-semibold whitespace-nowrap px-3 focus:outline-none focus:ring-2 bg-indigo-50 text-indigo-600 hover:bg-indigo-200 hover:text-indigo-700 focus:ring-indigo-500 dark:bg-slate-700 dark:text-slate-100 dark:hover:bg-slate-600 dark:hover:text-white dark:focus:ring-slate-500"
          type="button"
        >
          <%=sport.name%>
          <span class="sr-only">, responsive design</span>
          <img class="w-3 overflow-visible ml-2 text-indigo-300 group-hover:text-indigo-400 dark:text-slate-500 dark:group-hover:text-slate-400" src={sport.logo_url} width="36" />
        </button>
        <button
          phx-click="add_sport"
          phx-target={@myself}
          type="button"
          class="border group inline-flex items-center h-9 rounded-full text-xs font-semibold whitespace-nowrap px-3 focus:outline-none focus:ring-2 bg-indigo-50 text-indigo-600 hover:bg-indigo-200 hover:text-indigo-700 focus:ring-indigo-500 dark:bg-slate-700 dark:text-slate-100 dark:hover:bg-slate-600 dark:hover:text-white dark:focus:ring-slate-500"
          href="/"
        >
          Add sport
          <span class="sr-only">, responsive design</span>

          <svg class="w-4 h-6 overflow-visible ml-1 text-indigo-300 group-hover:text-background dark:text-slate-500 dark:group-hover:text-slate-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m6-6H6"></path>
          </svg>
        </button>
      </div>
      <.modal
        :if={@modal_active}
        id="contact-dialogue"
        show
        on_cancel={JS.navigate(@current_path)}
        bg_classes="!bg-gray-900/50 backdrop-blur backdrop-filter transition-opacity"
      >
        <div>
          <div>
            <h1 class="text-2xl font-bold tracking-tight text-gray-900 dark:text-gray-200 capitalise">
              Create Sport
            </h1>
            <p class="text-sm text-slate-500 hover:text-slate-600">Creating sport.</p>
          </div>
          <.simple_form
            for={@form}
            id="create_sport_form"
            phx-target={@myself}
            phx-submit="save"
            phx-change="validate"
            phx-trigger-action={@trigger_submit}
            class="-mt-4 bg-transparent"
          >
              <.input field={@form[:name]} label="Sport name" placeholder="Valorant" type="text" required />
              <.input field={@form[:description]} label="Description" placeholder="Description..." type="textarea" required />
              <.input field={@form[:logo_url]} label="Icon" type="file" accept="image/png, image/jpeg" uploads={@uploads.logo_url} required />
              <%= for {file, i} <- Enum.with_index(@files) do %>
                <.live_component id="logo_url" callback={JS.push("remove", value: %{"uuid" => ""})} module={LiveBettingWeb.ImageEntryComponent} file={file} index={i} />
              <% end %>
              <:actions>
                <.button phx-disable-with="Sending..." class="w-full">
                  Save Sport
                </.button>
              </:actions>
          </.simple_form>
        </div>
      </.modal>
    </div>
    """
  end

  def assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "sport")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end

  def mount(socket) do
    {
      :ok,
      socket
      |> assign(:modal_active, false)
      |> assign(:trigger_submit, false)
      |> assign(:uploaded_files, [])
      |> assign(name: "", description: "", logo_url: "")
      |> assign(:files, [])
    }
  end

  def update(assigns, socket) do
    {:ok,
      socket
      |> assign(assigns)
      |> allow_upload(:logo_url, accept: ~w(.jpg .jpeg .png), max_entries: 1, auto_upload: false)
      |> assign_form(Sport.sport_changeset(%Sport{}, %{}))
      |> stream(
           :sports,
           Sports.list_sports()
         )
    }
  end

  def handle_event("add_sport", _, socket) do
    {:noreply, socket |> assign(modal_active: !socket.assigns.modal_active)}
  end

  def handle_event("validate", params, socket) do
    %{ "_target" => logo_url, "sport" => %{"description" => description, "name" => name} } = params

    cond do
      logo_url == ["logo_url"] ->
        {_done, in_progress} = uploaded_entries(socket, :logo_url)

        %{description: desc, name: sport_name} = socket.assigns

        new_socket =
          Enum.reduce(in_progress, socket, fn entry, _acc ->
            IO.inspect(entry)
            changeset = Sport.sport_changeset(%Sport{}, parse_file_name(entry.client_name) |> Map.put_new(:description, desc) |> Map.put_new(:name, sport_name))
            socket |>
              assign(:files, [entry]) |>
              assign_form(Map.put(changeset, :action, :validate)) |>
              assign(logo_url: parse_file_name(entry.client_name).logo_url)
          end)

        {:noreply, new_socket}
      true ->
        %{logo_url: lg} = socket.assigns
        changeset = Sport.sport_changeset(
          %Sport{},
          %{"description" => description, "name" => name, "logo_url" => lg}
        )

        {:noreply, socket |> assign_form(Map.put(changeset, :action, :validate)) |> assign(description: description, name: name)}
    end
  end

  @impl Phoenix.LiveView
  def handle_event("save", %{"sport" => sport_params}, socket) do
    uploaded_files = consume_uploaded_entries(socket, :logo_url, fn %{path: path}, entry ->
       dest = Path.join([
         :code.priv_dir(:live_betting),
         "static",
         "uploads",
         Path.basename(path) <> parse_extension(entry.client_name)
       ])
       File.cp!(path, dest)
       {:ok, "/uploads/#{Path.basename(dest)}"}
    end)

    %{"name" => name, "description" => description} = sport_params

    sport = %Sport{name: name, description: description, logo_url: Enum.at(uploaded_files, 0)}

    Sports.create_sport(Sport.sport_changeset(sport, sport_params))

   {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end

  defp parse_extension(name) do
    # Define a regex pattern to match the file extension (dot followed by letters)
    file_extension_pattern = ~r/\.[a-zA-Z]+$/
    case Regex.run(file_extension_pattern, name) do
      [ext] -> ext
    end
  end

  def parse_file_name(name) do
    case Regex.split(~r/[-–]/, Path.rootname(name), parts: 1) do
      [url] -> %{logo_url: String.trim(url)}
    end
  end
end