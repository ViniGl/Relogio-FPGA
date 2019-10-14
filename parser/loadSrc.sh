#!/bin/bash

python3 parser.py relogio.asm
cp relogio/initROM.mif ../src/initROM.mif
