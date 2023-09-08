#!/bin/bash

# Script Parameters
ARCHIVE="$1"
XML_FILE="$2"
TEMP_DIR="temp_dir"

# Step 1: Extract entire .tar.xz archive to a temporary directory
echo "Extracting entire archive to ${TEMP_DIR}..."
mkdir -p $TEMP_DIR
tar --xz -xf $ARCHIVE -C $TEMP_DIR

# Step 2: Format XML and Open in VSCode
echo "Formatting ${XML_FILE}..."
cp "${TEMP_DIR}/${XML_FILE}" "${TEMP_DIR}/formatted.xml"
xmllint --format "${TEMP_DIR}/formatted.xml" > "${TEMP_DIR}/${XML_FILE}"

# Step 3: Open in VSCode
echo "Opening ${XML_FILE} in VSCode..."
code "${TEMP_DIR}/${XML_FILE}"

# Waiting for user to finish editing
read -p "Press any key to continue after editing..."

# Step 4: Compress the edited XML back into a new .tar.xz archive
echo "Re-creating ${ARCHIVE}..."
rm $ARCHIVE
(cd $TEMP_DIR && tar --xz -cf ../$(basename $ARCHIVE) *)

# Clean-up
rm -r $TEMP_DIR

mv $(basename $ARCHIVE) $ARCHIVE

echo "Done."