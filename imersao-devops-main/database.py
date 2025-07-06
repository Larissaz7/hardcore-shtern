from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

# Para produção com Docker Compose, usar a variável de ambiente DATABASE_URL.
# Para desenvolvimento local, manter o fallback para um arquivo SQLite local.
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./escola.db")

# Se estiver usando PostgreSQL, não precisamos do argumento 'check_same_thread'.
engine_args = {"connect_args": {"check_same_thread": False}} if "sqlite" in DATABASE_URL else {}

engine = create_engine(
    DATABASE_URL, **engine_args
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
