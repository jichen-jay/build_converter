from pycallgraph import PyCallGraph
from pycallgraph.output import GraphvizOutput
from docling.document_converter import DocumentConverter
import os
from pathlib import Path
import sys

def conv():
    source = "https://arxiv.org/pdf/2408.09869"  # Default URL source
    converter = DocumentConverter()
    result = converter.convert(source)
    print(result.document.export_to_markdown())
    
    
    
with PyCallGraph(output=GraphvizOutput()):
    conv()


