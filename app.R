# ISA 401 Midwest Airbnb Chat: ask questions, get SQL, a table, or a chart back

con = DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

client = ellmer::chat_openai(
  model  = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

qc = querychat::querychat(
  con, "listings",
  client             = client,
  tools              = c("filter", "query", "visualize"),
  greeting           = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities.",
  data_description   = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)

ui = bslib::page_sidebar(
  title = "Midwest Airbnb Explorer",
  
  theme = bslib::bs_theme(
    version = 5,
    bootswatch = "flatly"
  ),
  
  sidebar = qc$sidebar(width = 350),
  
  bslib::card(
    bslib::card_header(shiny::textOutput("title")),
    DT::DTOutput("table")
  ),
  
  bslib::accordion(
    open = FALSE,
    
    bslib::accordion_panel(
      "SQL",
      shiny::verbatimTextOutput("sql")
    ),
    
    bslib::accordion_panel(
      "About",
      "This app was built by Joseph Sher for ISA 401 at Miami University. The data come from Inside Airbnb and include Airbnb listings from Chicago, Columbus, and the Twin Cities MSA. The Chicago snapshot is from 2026-07-20, the Columbus snapshot is from 2026-07-23, and the Twin Cities MSA snapshot is from 2026-07-21. The dataset contains 14,887 listings and 29 columns."
    )
  )
)

server = function(input, output, session) {
  
  vals = qc$server()
  
  output$title = shiny::renderText(
    vals$title() %||% "All listings"
  )
  
  output$table = DT::renderDT(
    vals$df(),
    options = list(pageLength = 10)
  )
  
  output$sql = shiny::renderText(
    vals$sql() %||% "Ask a question to generate SQL."
  )
}

shiny::shinyApp(ui, server)