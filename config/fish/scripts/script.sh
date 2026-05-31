#!/usr/bin/env bash
clear; echo -e "\n   ...   SCRIPT GENERATION UTILITY ...\n"

read -p "   > Enter script name: " sas
sas="${sas%.sh}"

printf '#!/usr/bin/env bash\n\n\n' > "$sas.sh"

chmod +x "$sas.sh"

nvim +3 "$sas.sh"
