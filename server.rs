use actix_web::{get, post, web, App, HttpResponse, HttpServer, Responder};
use serde::{Deserialize, Serialize};
use sqlx::{sqlite::SqlitePoolOptions, SqlitePool};
use dotenv::dotenv;

#[get("/")]
async fn index() -> impl Responder {
    HttpResponse::Ok()
        .content_type("text/plain; charset=utf-8")
        .body("дарова, вот аутпут сервера: [ LOG ] я родился!")
}
 #[actix_web::main]
fn main() -> std::io::Result<()> {
    dotenv().ok();
    let db_url = std::env::var("DATABASE_URL").unwrap_or("sqlite:users.db".into());
    let pool = SqlitePoolOptions::new().connect(&db_url).await.unwrap();
     println!("Server started at http://localhost:$port");
     HttpServer::new(move || {
        App::new()
            .app_data(web::Data::new(pool.clone()))
            .service(index)  
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await;
}

