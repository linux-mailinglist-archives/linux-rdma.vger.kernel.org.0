Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083174B3A91
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Feb 2022 10:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiBMJWG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Feb 2022 04:22:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiBMJWG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Feb 2022 04:22:06 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7DF5C35B
        for <linux-rdma@vger.kernel.org>; Sun, 13 Feb 2022 01:22:00 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id l125so4511319ybl.4
        for <linux-rdma@vger.kernel.org>; Sun, 13 Feb 2022 01:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1Iejp/RID3IRiHx1HMZ02Imq8HRPRPdd8nZE1NpNJSw=;
        b=YJU/ALppbItwpzSFPm8zl9Rii4lt8w+EtJJ5nNaOv0f2jc3+dPauzlgxmaBSJCyAZs
         LiRHDDCZTTfbQukBQxepVX5ncBwIqAcWQ2xF1aLQGzjB+8M6PjQ7HBFYVg5L/+xQPLpn
         py7G2Y1RlgqwRhajWWn0mQ7OFJBwDSjWBnol1y1Iw6hN+1rl1lOaHKz5hooG5farop6P
         Yy7x8NhNRYpXPBhAK69+2ov9N+saLfw2Mog2mnXwQShNkOrDS7OCHWoddBnaptK3gv+4
         P/rDRQrNlsZR9dH4wrUl2JLMEbxAD+eJIILzUqYuj1hj1SItiucLxJNO7SFiVWDajOWi
         m1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1Iejp/RID3IRiHx1HMZ02Imq8HRPRPdd8nZE1NpNJSw=;
        b=TDtR+oLLyzVaMjdKYj7Gjs6ugyEKAJF6fyhExy0oC/n/56MJD9meCyCfWILMWh4PRf
         0zOyxa+ygHrSmdGp+Me9qFcHthqr+1XUM7+3rREX385sIgqUJ/xLVJY1fpAQYb9AhUeO
         6eZjEwhidTOSR1ihrn28HJOOYv3usPOAktT9LF4VMbU+thJ3veIp3ZF7DtJY8brq1Rx9
         gpfyWMuLtnfwum/GxZ5Yvkhbo2BziykhEL9JrR49N+0H8qsQJOD4/8z/qGEnDIL9YDPB
         JkBWbb555OcB1e9BXSW2QlNwx0f2qjB5FiPgvfAvco+mtDay+CsMhAxYfcMPgCDEYr30
         jD9g==
X-Gm-Message-State: AOAM532GtA9TquXHM4+PUOpV57uymk3n0r816LkwVRQggJXoLrAMiA+A
        i0O32Jz4b8SH5PYmedchb9kA/+P8ekxY2sjSnbljjYEcl04=
X-Google-Smtp-Source: ABdhPJzLXpeNlMDb/S3ohUWeTScE8TtzPPGfnS+K7BPK/3hIcX2CVPS4kmRchLUtrARzKN9vh91HyJQkhqQMUyLyk/I=
X-Received: by 2002:a81:4741:: with SMTP id u62mr9807153ywa.512.1644744120190;
 Sun, 13 Feb 2022 01:22:00 -0800 (PST)
MIME-Version: 1.0
From:   Robin Peiremans <rpeiremans@gmail.com>
Date:   Sun, 13 Feb 2022 10:21:49 +0100
Message-ID: <CAJt3DjCM1uKkutB0srAiofuLUunX8hJZ+h+xkkTKmN3p_r+OLg@mail.gmail.com>
Subject: sysfs: cannot create duplicate filename
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi

I ran into this error when upgrading to kernel 5.14 (it works
pre-5.14). The driver gets loaded (verified via lsmod), but the ib
utils don't show any ports.

There's a bugreport on elrepo
(https://elrepo.org/bugs/view.php?id=1176) that looks pretty much
identical, but it looks stalled.
I've bisected the kernel and commit
4a7aaf88c89f12f8048137e274ce0d40fe1056b2 seems to be the culprit.
Since I'm absolutely no dev, I'm hoping someone here can figure out
what exactly is going wrong. Latest mainline kernel still has the same
behavior.

Relevant output and logs below.

$ sudo lspci -s 04:00.0 -vv
04:00.0 InfiniBand: QLogic Corp. IBA7322 QDR InfiniBand HCA (rev 02)
Subsystem: QLogic Corp. IBA7322 QDR InfiniBand HCA
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 39
IOMMU group: 22
Region 0: Memory at fbc00000 (64-bit, non-prefetchable) [size=4M]
Expansion ROM at fc000000 [disabled] [size=128K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [70] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 5GT/s, Width x8, ASPM L0s, Exit Latency L0s <4us
ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s (ok), Width x4 (downgraded)
TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP- LTR-
10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
FRS- TPHComp- ExtTPHComp-
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
AtomicOpsCtl: ReqEn-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
Retimer- 2Retimers- CrosslinkRes: unsupported
Capabilities: [b0] MSI-X: Enable- Count=32 Masked-
Vector table: BAR=0 offset=00008000
PBA: BAR=0 offset=00009000
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Kernel modules: ib_qib

Relevant /var/log/messages section:
Feb 13 09:43:29 localhost kernel: ib_qib 0000:04:00.0: qib0: Reserving
QPNs from 0x656b78 to 0x656b78 for non-verbs use
Feb 13 09:43:29 localhost kernel: sysfs: cannot create duplicate
filename '/devices/pci0000:00/0000:00:01.2/0000:01:00.0/0000:02:02.0/0000:04:00.0/infiniband/qib0/ports/1/linkcontrol'
Feb 13 09:43:29 localhost kernel: CPU: 15 PID: 1118 Comm: modprobe
Tainted: G           OE     5.17.0-rc3-robin+ #20
Feb 13 09:43:29 localhost kernel: Hardware name: ASUS System Product
Name/TUF GAMING X570-PRO (WI-FI), BIOS 3001 12/04/2020
Feb 13 09:43:29 localhost kernel: Call Trace:
Feb 13 09:43:29 localhost kernel: <TASK>
Feb 13 09:43:29 localhost kernel: dump_stack_lvl+0x48/0x5e
Feb 13 09:43:29 localhost kernel: sysfs_warn_dup.cold+0x17/0x24
Feb 13 09:43:29 localhost kernel: internal_create_group+0x348/0x350
Feb 13 09:43:29 localhost kernel: internal_create_groups.part.0+0x3d/0xa0
Feb 13 09:43:29 localhost kernel: setup_port+0x370/0x680 [ib_core]
Feb 13 09:43:29 localhost kernel: ? kobject_add+0x6e/0x90
Feb 13 09:43:29 localhost kernel: ib_setup_port_attrs+0x88/0x220 [ib_core]
Feb 13 09:43:29 localhost kernel: ib_register_device+0x576/0x650 [ib_core]
Feb 13 09:43:29 localhost kernel: ? __vmalloc_node+0x4a/0x70
Feb 13 09:43:29 localhost kernel: rvt_register_device+0x10c/0x270 [rdmavt]
Feb 13 09:43:29 localhost kernel: qib_register_ib_device+0x5f8/0x7a0 [ib_qib]
Feb 13 09:43:29 localhost kernel: qib_init_one+0x17f/0x470 [ib_qib]
Feb 13 09:43:29 localhost kernel: local_pci_probe+0x45/0x80
Feb 13 09:43:29 localhost kernel: ? pci_match_device+0xd7/0x130
Feb 13 09:43:29 localhost kernel: pci_device_probe+0xaa/0x1a0
Feb 13 09:43:29 localhost kernel: really_probe+0x1f5/0x3d0
Feb 13 09:43:29 localhost kernel: __driver_probe_device+0xfe/0x180
Feb 13 09:43:29 localhost kernel: driver_probe_device+0x1e/0x90
Feb 13 09:43:29 localhost kernel: __driver_attach+0xc0/0x1c0
Feb 13 09:43:29 localhost kernel: ? __device_attach_driver+0xe0/0xe0
Feb 13 09:43:29 localhost kernel: ? __device_attach_driver+0xe0/0xe0
Feb 13 09:43:29 localhost kernel: bus_for_each_dev+0x64/0x90
Feb 13 09:43:29 localhost kernel: bus_add_driver+0x149/0x1e0
Feb 13 09:43:29 localhost kernel: driver_register+0x8f/0xe0
Feb 13 09:43:29 localhost kernel: ? qib_init_qibfs+0x11/0x11 [ib_qib]
Feb 13 09:43:29 localhost kernel: qib_ib_init+0x3e/0xf62 [ib_qib]
Feb 13 09:43:29 localhost kernel: do_one_initcall+0x44/0x200
Feb 13 09:43:29 localhost kernel: ? kmem_cache_alloc_trace+0x163/0x2c0
Feb 13 09:43:29 localhost kernel: do_init_module+0x4c/0x260
Feb 13 09:43:29 localhost kernel: __do_sys_finit_module+0x9b/0xf0
Feb 13 09:43:29 localhost kernel: do_syscall_64+0x3b/0x90
Feb 13 09:43:29 localhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
Feb 13 09:43:29 localhost kernel: RIP: 0033:0x7fae66bf5ecd
Feb 13 09:43:29 localhost kernel: Code: 5b 41 5c c3 66 0f 1f 84 00 00
00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d
89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b ef
0e 00 f7 d8 64 89 01 48
Feb 13 09:43:29 localhost kernel: RSP: 002b:00007ffdb7beb198 EFLAGS:
00000246 ORIG_RAX: 0000000000000139
Feb 13 09:43:29 localhost kernel: RAX: ffffffffffffffda RBX:
00007fae677c8c80 RCX: 00007fae66bf5ecd
Feb 13 09:43:29 localhost kernel: RDX: 0000000000000000 RSI:
00007fae67173a2a RDI: 0000000000000003
Feb 13 09:43:29 localhost kernel: RBP: 0000000000040004 R08:
0000000000000000 R09: 0000000000000000
Feb 13 09:43:29 localhost kernel: R10: 0000000000000003 R11:
0000000000000246 R12: 00007fae67173a2a
Feb 13 09:43:29 localhost kernel: R13: 00007fae677c8ed0 R14:
00007fae677c8c80 R15: 00007fae677c9980
Feb 13 09:43:29 localhost kernel: </TASK>
Feb 13 09:43:29 localhost kernel: infiniband qib0: Couldn't register
device with driver model
Feb 13 09:43:33 localhost kernel: ib_qib 0000:04:00.0: qib0: Failed to
register driver with ib core.
Feb 13 09:43:33 localhost kernel: ib_qib 0000:04:00.0: qib0: cannot
register verbs: 17!
Feb 13 09:43:33 localhost kernel: ib_qib 0000:04:00.0: Disabling
notifier on HCA 0 irq 140
Feb 13 09:43:33 localhost kernel: ib_qib 0000:04:00.0: Disabling
notifier on HCA 0 irq 141
Feb 13 09:43:33 localhost kernel: ib_qib 0000:04:00.0: Disabling
notifier on HCA 0 irq 142
Feb 13 09:43:33 localhost kernel: ib_qib 0000:04:00.0: Disabling
notifier on HCA 0 irq 144
Feb 13 09:43:33 localhost kernel: ib_qib: probe of 0000:04:00.0 failed
with error -17

$ ibstatus
Fatal error:  device '*': sys files not found (/sys/class/infiniband/*/ports)

$ git bisect bad
4a7aaf88c89f12f8048137e274ce0d40fe1056b2 is the first bad commit
commit 4a7aaf88c89f12f8048137e274ce0d40fe1056b2
Author: Jason Gunthorpe <jgg@nvidia.com>
Date:   Fri Jun 11 19:00:30 2021 +0300

    RDMA/qib: Use attributes for the port sysfs

    qib should not be creating a mess of kobjects to attach to the port
    kobject - this is all attributes. The proper API is to create an
    attribute_group list and create it against the port's kobject.

    Link: https://lore.kernel.org/r/911e0031e1ed495b0006e8a6efec7b67a702cd5e.1623427137.git.leonro@nvidia.com
    Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
    Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

 drivers/infiniband/hw/qib/qib.h       |   4 -
 drivers/infiniband/hw/qib/qib_sysfs.c | 606 ++++++++++++++--------------------
 2 files changed, 254 insertions(+), 356 deletions(-)


Cheers
Robin
