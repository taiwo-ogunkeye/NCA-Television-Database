# Television Database System – NCA Digitalization Project

This project designs and documents a database system for the National Communication Authority (NCA) of Ghana to manage and regulate television broadcasting activities. The database aims to streamline the NCA’s regulatory activities, provide transparency, and support policy-making for the television ecosystem in Ghana.

## Project Objectives

- Digitalize and centralize data about TV stations, programs, advertisements, sponsors, producers, and presenters.

- Provide an easy way to query key metrics such as number of TV stations, program counts, advertisement costs, and program airing schedules.

- Enable data-driven policy development and revenue estimation for taxation purposes.

🏗 Database Features

- Manage contact information of presenters, producers, and sponsors.

- Track advertisements, their costs, and sponsoring entities.

Record program schedules, including news and documentary air times.

- Generate revenue estimates by aggregating advertisement costs.

- Filter ads based on cost thresholds.

📊 Design

- EER Diagram: Captures the relationships between television stations, programs, sponsors, ads, producers, and presenters.

- Logical Tables: Includes strong entities (Person, Sponsors, Television_Station, Program, Advertisements, Schedule), specialization/generalization tables (Producer, Movie, News, Presenter, Documentary), and associative tables (Program_Ad, Telephone).

🛠 Key Technology

- Entity-Relationship (EER) modeling

- Logical table design (normalization)

- SQL-ready schema for implementation
