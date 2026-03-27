echo -e '#!/bin/bash\n\nnum1=$1\nnum2=$2\nsum=$((num1 + num2))\necho "Add $num1 to $num2 = $sum"' > add.sh && chmod +x add.sh
git add add.sh
git commit -m "Ajout du script d'addition pour le TP" 
git push origin feature/sara-travail
