#!/bin/bash
some_text="Function to conversion of excel sheet into Data frame"
echo $some_text

cat <<EOF | python3 -
# import pandas lib as pd 
import pandas as pd
import xml.etree.cElementTree as ET
import requests
 
# read by default 1st sheet of an excel file
df1 = pd.read_excel (r'./jenkins/Individual_parameter_coverage.xlsx')
print(df1)
xml_data = open(r'./jenkins/config.xml').read()  # Read file
def xml2df(xml_data):
    tree = ET.parse(xml_data)
    root = list(list(tree.getroot())[0])[1]
    all_records = []
    headers = []
    for i, child in enumerate(root):
        if i < 2:
            headers.append(list(child)[0].text)
            continue
        record = []
        for subchild in child:
            record.append(subchild.text)
        all_records.append(record)
    return pd.DataFrame(all_records, columns=headers)

tt = xml2df(xml_data)
EOF
