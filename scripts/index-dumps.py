import os
import json

dumps=json.loads('[]')

for root, dirs, files in os.walk('/var/www/html'):
    for filename in files:
        if '_' in filename:
            height=filename.split('_')[0]
            timestamp=filename.split('_')[1]

            dumps.append({
                'file': filename,
                'size': os.path.getsize('/var/www/html/' + filename),
                'height': height,
                'timestamp': timestamp,
            })

with open('/var/www/html/manifest', 'w') as outfile:
    json.dump(dumps, outfile)
