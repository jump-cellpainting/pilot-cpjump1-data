"""
Perform the feature selection profiling pipeline (defined in feature_select.py).
"""

import pathlib
from profile_utils import load_pipeline
from profile_utils import process_pipeline
import argparse

parser = argparse.ArgumentParser(description='Run feature selection')
parser.add_argument('--config', help='Config file')
parser.add_argument('--input', help='input file')
parser.add_argument('--output', help='output file')

args = parser.parse_args()

pipeline, profile_config = load_pipeline(args.config)

input_file = args.input
output_file = args.output

print(f'Now processing... input: {input_file}, output: {output_file}')

#---

from profile_utils import process_pipeline
from pycytominer import feature_select

compression = process_pipeline(pipeline["options"], option="compression")
float_format = process_pipeline(pipeline["options"], option="float_format")
samples = process_pipeline(pipeline["options"], option="samples")

feature_select_steps = pipeline['feature_select']
feature_select_operations = feature_select_steps['operations']
feature_select_features = feature_select_steps['features']

print(f'Feature selection operations:')
print(feature_select_operations)

feature_select(
    profiles=input_file,
    features=feature_select_features,
    operation=feature_select_operations,
    output_file=output_file,
    float_format=float_format,
    compression=compression,
)
