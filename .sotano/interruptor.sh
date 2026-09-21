#!/bin/bash
DIR_SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIVING="$DIR_SCRIPT/../living"

mkdir -p "$LIVING"
rm -rf "$LIVING"/*

DIALOGOS_B64=(
    "IEdycnIh"
    "IEVsIMOhcmVhIGRlbCBsaXZpbmcgZXMgbnVlc3RyYSE="
    "IEN1aWRhZG8gY29uIGVsIHNjcmlwdCBkZWwgaGFkYSE="
    "U3Nzcy4uLiBObyBtZSBib3JyZXMsIG5vIHRlIGhpY2UgbmFkYS4uLg=="
    "IFNvbW9zIGRlbWFzaWFkb3MsIHLDrW5kZXRlIQ=="
)

for i in $(seq -w 1 50); do
    ENEMIGO_FILE="$LIVING/$i-enemigo.sh"
    NUM=$((10#$i))
    B64_TEXT="${DIALOGOS_B64[$((NUM % 5))]}"
    MENSAJE_REVELADO=$(echo "$B64_TEXT" | base64 -d)
    cat << EOF > "$ENEMIGO_FILE"
        #!/bin/bash
        echo "$MENSAJE_REVELADO"
EOF
done

rm -f "$LIVING/03-enemigo.sh" "$LIVING/04-enemigo.sh"

cat << 'EOF' > "$LIVING/04-hada.sh"
    #!/bin/bash
    DIR_ACTUAL="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    x="U29sbyBoYXkgdW4gZXhwZXJpbWVudG8gbm8gRkFMTElETywgc3Ugbm9tYnJlIGVzIEFVR1VTVE8="

    CANTIDAD=$(ls -1 "$DIR_ACTUAL"/*enemigo* 2>/dev/null | wc -l)

    if [ "$CANTIDAD" -gt 0 ]; then
        echo "El hada vuela aterrada de miedo!"
    else
        echo "¡Gracias!"
        echo "¡Sé algo importante!"
        echo "$x" | base64 -d
        echo ""
        echo "Deberias BUSCAR en el CONTENIDO de los experimentos en el laboratorio!"
    fi
EOF

cat << 'EOF' > "$LIVING/03-hada.sh"
    #!/bin/bash
    DIR_ACTUAL="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    CANTIDAD=$(ls -1 "$DIR_ACTUAL"/*enemigo* 2>/dev/null | wc -l)

    if [ "$CANTIDAD" -gt 0 ]; then
        echo "Quedan $CANTIDAD enemigos. ¡Debes ELIMINAR los enemigos!"
    else
        echo "¡Lo lograste! ^^"
    fi
EOF

echo "Se escuchan muchos ruidos que provienen del living."

chmod +x "$LIVING"/*
