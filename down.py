from docling.document_converter import DocumentConverter
from docling.document_converter import StandardPdfPipeline
import os

os.environ["HF_HOME"] = "/cache"
os.environ["TRANSFORMERS_CACHE"] = "/cache/models"
os.environ["HF_DATASETS_CACHE"] = "/cache/datasets"

converter = DocumentConverter()
artifacts_path = StandardPdfPipeline.download_models_hf(force=True)
result = converter.convert("https://arxiv.org/pdf/2408.09869")
