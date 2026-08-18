# Acknowledgments & Attribution

This file documents the open-source tools, process design kit, and prior
art that AbadMCU depends on or was inspired by. It's split into two
categories that are easy to conflate but legally distinct:

1. **Tools and IP actually incorporated into this design** - their
   licenses (all Apache-2.0) place real obligations on redistribution.
2. **Architectural inspiration from prior projects** - no code was
   copied from these; crediting them is good academic/community
   practice, not a license requirement, since taking inspiration from
   a *design pattern* (as opposed to copying source text) isn't a
   copyright event.

---

## 1. Tools & IP incorporated into this design (Apache-2.0)

The physical chip (GDS) produced from this repository directly embeds
standard-cell layouts from, and was built using, the following
Apache-2.0-licensed projects. Their copyright notices are reproduced
below per Apache-2.0 \u00a74; none of them ship a separate `NOTICE` file as
of this writing (checked: skywater-pdk's repository root contains only
`LICENSE` and `AUTHORS`, no `NOTICE` - worth re-checking the others
listed here yourself before a formal release, since this wasn't
exhaustively verified for every entry).

### SkyWater SKY130 PDK
The standard-cell library your design was synthesized and hardened
against.

```
Copyright 2020 SkyWater PDK Authors
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0
```
Source: https://github.com/google/skywater-pdk

### open_pdks
PDK build/installer tooling used to assemble the sky130 PDK for the
hardening flow.

Source: https://github.com/fossi-foundation/open-pdks (Apache-2.0)

### OpenLane / OpenROAD
The RTL-to-GDS tool flow (synthesis, place & route, STA, DRC/LVS) that
produced this design's GDS.

```
OpenLane is \u00a92020-2024 Efabless Corporation and is available under
the Apache License, version 2.0.
```
Source: https://github.com/The-OpenROAD-Project/OpenLane

If citing academically:
> M. Shalan and T. Edwards, "Building OpenLANE: A 130nm OpenROAD-based
> Tapeout-Proven Flow," 2020 IEEE/ACM International Conference on
> Computer-Aided Design (ICCAD), San Diego, CA, USA, 2020, pp. 1-6.

### Tiny Tapeout project templates / tt-support-tools
The `tt_um_*` port convention, `info.yaml` schema, and CI/build
scaffolding this repo's structure follows.

Source: https://github.com/TinyTapeout (templates are Apache-2.0 by
default per Tiny Tapeout's own FAQ)

---

## 2. Architectural inspiration (no code reused)

AbadMCU's central design decision - CPU with no on-chip memory,
program fetched from external QSPI flash, working data in external
QSPI PSRAM, sharing physical SPI wires between them via separate chip
selects - follows the same strategic pattern pioneered on Tiny Tapeout
by the following projects. **No RTL, ISA encoding, or source code from
either project was copied** - AbadMCU's CPU core, instruction set, and
peripheral RTL were independently designed and implemented. What's
credited here is the *architectural pattern*, not any specific
implementation of it.

### TinyQV (Michael Bell)
First (and to date, most complete) demonstration of this
flash+PSRAM-over-shared-QSPI-Pmod pattern on Tiny Tapeout, including
the specific convention of a single active chip-select and
code-execution-restricted-to-flash.

Source: https://github.com/MichaelBell/tinyQV (Apache-2.0)

### KianV (Hirosh Dabui / splinedrive)
Independent, earlier demonstration of the same external-memory-over-QSPI
pattern (both the uLinux and bare-metal editions), predating this
project.

Source: https://github.com/splinedrive/kianRiscV,
https://github.com/TinyTapeout/KianV-RV32IMA-RISC-V-uLinux-SoC
(check the repository's own LICENSE file directly before citing a
specific license - it wasn't confirmed via an explicit license badge
at the time this was written)

### RISC-V (conceptual influence only)
TT8's `r0`-hardwired-to-zero convention and load/store architectural
style are modeled on RISC-V's design philosophy. RISC-V is an open,
freely usable ISA specification; no code is reused here, so this
carries no license obligation. **TT8 is not RISC-V-compliant** - it's
a custom 16-bit-instruction, 8-bit-datapath ISA in the RISC-V style,
and should not be described as a RISC-V implementation or use the
RISC-V trademark/logo.

---

## 3. What's original to this project

- The TT8 instruction encoding (16-bit fixed-width, R-type/I-type
  split, the specific opcode table) is a custom design, not derived
  from any existing ISA's bit layout.
- All RTL in this repository (`tt8_core.v`, `tt8_alu.v`,
  `tt8_regfile.v`, `tt8_peripherals.v`, `qspi_flash_reader.v`,
  `qspi_psram_ctrl.v`, `tt_um_abadmcu.v`) was independently written for
  this project.
- The verification suite, bug fixes, and STA signoff analysis
  documented in this repository's history are this project's own work.

---

## Unverified claims to double-check before formal publication

- A code comment in `qspi_flash_reader.v` attributes a ~20ns round-trip
  timing margin figure to "TinyQV's own QSPI controller comments." This
  has not been independently confirmed against TinyQV's actual source -
  verify the exact figure and its origin before citing it as a
  TinyQV-derived fact.
- The Apache-2.0 NOTICE-file check above was only performed for
  skywater-pdk; confirm the other three Apache-2.0 entries (open_pdks,
  OpenLane, Tiny Tapeout templates) don't ship their own NOTICE files
  before finalizing this document, since if any of them do, its
  contents would need to be reproduced here per \u00a74(d).
