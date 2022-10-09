Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D047F5F8923
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Oct 2022 05:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJIDa1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Oct 2022 23:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJIDa0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Oct 2022 23:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AE02FFF5
        for <linux-rdma@vger.kernel.org>; Sat,  8 Oct 2022 20:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EADD360A39
        for <linux-rdma@vger.kernel.org>; Sun,  9 Oct 2022 03:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A78FC433D7
        for <linux-rdma@vger.kernel.org>; Sun,  9 Oct 2022 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665286222;
        bh=5vJKwMajY2h3JKY38T2JBFDgaDqJop5zq8Q3yiqcNkg=;
        h=From:To:Subject:Date:From;
        b=TNNHPsH0vxX5JWuBdu0BCj4gl0iWWlh8gM/EM6wJyrg5a96ejIXddYsIxa1QYMvPH
         z32z/j+qZazM4iA8vXdCssCX39T+/gm8tL7gFXbpzBS4dF6pIwrUh7dWhEcNaf+l6y
         BpYXNXBZ/mggc8IExWPXHHf3Q8JbYEpy5l985lPoOFemAx8dNH1U+4iuSYuDGG66n4
         MvaSiqH7/MRL2iHQWoaoym7ht7ZWSdAs4Y4PCECcsp3DeXdQ/IYqESrKAgKZrbunno
         Q1gUtf8mVZEpk5UhlRZ9U7cZpGQKEtAH4C38p9Qk+tKgdXUOCTy8/CsFSEUql1XtmR
         Pt23ugOJbIlew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2801AC433E4; Sun,  9 Oct 2022 03:30:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-rdma@vger.kernel.org
Subject: [Bug 216561] New: memcpy: detected field-spanning write (size 80) of
 single field "&wqe->wr" at drivers/infiniband/sw/rdmavt/qp.c:2043 (size 40)
Date:   Sun, 09 Oct 2022 03:30:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yizhan@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216561-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216561

            Bug ID: 216561
           Summary: memcpy: detected field-spanning write (size 80) of
                    single field "&wqe->wr" at
                    drivers/infiniband/sw/rdmavt/qp.c:2043 (size 40)
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.0.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: yizhan@redhat.com
        Regression: No

Found this warning just during system boots up, and the kernel I used is v6=
.0.0



[   15.248081] bnxt_re: Broadcom NetXtreme-C/E RoCE Driver
[   15.337110] ipmi_si IPI0001:00: IPMI kcs interface initialized
[   15.378737] ipmi_ssif: IPMI SSIF Interface driver
[   15.429469] infiniband bnxt_re0: Device registered successfully
[   15.434356] infiniband bnxt_re1: Device registered successfully
[   15.434360] eno2np1 speed is unknown, defaulting to 1000
[   15.651973] Console: switching to colour frame buffer device 128x48
[   15.659505] hfi1 0000:d8:00.0: hfi1_0: Eager buffer size 8388608
[   15.660026] hfi1 0000:d8:00.0: hfi1_0: UC base1: 00000000d94985cd for
1200000
[   15.660032] hfi1 0000:d8:00.0: hfi1_0: RcvArray count: 65536
[   15.660059] hfi1 0000:d8:00.0: hfi1_0: UC base2: 00000000b522b0ad for d8=
0000
[   15.660492] hfi1 0000:d8:00.0: hfi1_0: WC piobase: 00000000efa1c9a8 for
2000000
[   15.660507] hfi1 0000:d8:00.0: hfi1_0: WC RcvArray: 000000002ac1b130 for
80000
[   15.660520] hfi1 0000:d8:00.0: hfi1_0: Implementation: RTL silicon, revi=
sion
0x0
[   15.660523] hfi1 0000:d8:00.0: hfi1_0: GUID 11750101096c60
[   15.660806] hfi1 0000:d8:00.0: hfi1_0: Resetting CSRs with FLR
[   15.673507] mgag200 0000:03:00.0: [drm] fb0: mgag200drmfb frame buffer
device
[   15.681320] iw_cxgb4: Chelsio T4/T5 RDMA Driver - version 0.1
[   15.753729] XFS (dm-2): Mounting V5 Filesystem
[   15.768336] hfi1 0000:d8:00.0: hfi1_0: PCIe,8000MHz,x16
[   15.809227] hfi1 0000:d8:00.0: hfi1_0: do_pcie_gen3_transition: PCIe alr=
eady
at gen3, skipping
[   15.812518] Loading iSCSI transport class v2.0-870.
[   15.818518] XFS (dm-2): Ending clean mount
[   15.825694] mlx5_core 0000:af:00.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(2=
56)
RxCqeCmprss(0)
[   15.825702] mlx5_core 0000:af:00.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(2=
56)
RxCqeCmprss(0)
[   15.840800] hfi1 0000:d8:00.0: hfi1_0: Setting partition keys
[   15.842172] hfi1 0000:d8:00.0: hfi1_0: allocating rx size 2496
[   15.842178] hfi1 0000:d8:00.0: hfi1_0: rcv contexts: chip 160, used 35
(kernel 3, netdev 8, user 24)
[   15.842181] hfi1 0000:d8:00.0: hfi1_0: RcvArray groups 234, ctxts extra 2
[   15.842184] hfi1 0000:d8:00.0: hfi1_0: unused send context blocks: 25
[   15.842186] hfi1 0000:d8:00.0: hfi1_0: send contexts: chip 160, used 52
(kernel 16, ack 3, user 32, vl15 1)
[   15.842432] hfi1 0000:d8:00.0: hfi1_0: Using send context 16(143) for VL=
15
[   15.842501] hfi1 0000:d8:00.0: hfi1_0: SDMA mod_num_sdma: 0
[   15.842502] hfi1 0000:d8:00.0: hfi1_0: SDMA chip_sdma_engines: 16
[   15.842504] hfi1 0000:d8:00.0: hfi1_0: SDMA chip_sdma_mem_size: 401408
[   15.842505] hfi1 0000:d8:00.0: hfi1_0: SDMA engines 16 descq_cnt 2048
[   15.842670] hfi1 0000:d8:00.0: hfi1_0: SDMA num_sdma: 16
[   15.843185] hfi1 0000:d8:00.0: hfi1_0: 28 MSI-X interrupts allocated
[   15.843202] hfi1 0000:d8:00.0: hfi1_0: IRQ: 557, type GENERAL  -> cpu: 1
[   15.843217] hfi1 0000:d8:00.0: hfi1_0: IRQ: 558, type SDMA engine 0 -> c=
pu:
7
[   15.843231] hfi1 0000:d8:00.0: hfi1_0: IRQ: 559, type SDMA engine 1 -> c=
pu:
9
[   15.843250] hfi1 0000:d8:00.0: hfi1_0: IRQ: 560, type SDMA engine 2 -> c=
pu:
11
[   15.843264] hfi1 0000:d8:00.0: hfi1_0: IRQ: 561, type SDMA engine 3 -> c=
pu:
13
[   15.843278] hfi1 0000:d8:00.0: hfi1_0: IRQ: 562, type SDMA engine 4 -> c=
pu:
15
[   15.843291] hfi1 0000:d8:00.0: hfi1_0: IRQ: 563, type SDMA engine 5 -> c=
pu:
17
[   15.843309] hfi1 0000:d8:00.0: hfi1_0: IRQ: 564, type SDMA engine 6 -> c=
pu:
19
[   15.843325] hfi1 0000:d8:00.0: hfi1_0: IRQ: 565, type SDMA engine 7 -> c=
pu:
21
[   15.843338] hfi1 0000:d8:00.0: hfi1_0: IRQ: 566, type SDMA engine 8 -> c=
pu:
23
[   15.843351] hfi1 0000:d8:00.0: hfi1_0: IRQ: 567, type SDMA engine 9 -> c=
pu:
7
[   15.843366] hfi1 0000:d8:00.0: hfi1_0: IRQ: 568, type SDMA engine 10 -> =
cpu:
9
[   15.843380] hfi1 0000:d8:00.0: hfi1_0: IRQ: 569, type SDMA engine 11 -> =
cpu:
11
[   15.843396] hfi1 0000:d8:00.0: hfi1_0: IRQ: 570, type SDMA engine 12 -> =
cpu:
13
[   15.843410] hfi1 0000:d8:00.0: hfi1_0: IRQ: 571, type SDMA engine 13 -> =
cpu:
15
[   15.843424] hfi1 0000:d8:00.0: hfi1_0: IRQ: 572, type SDMA engine 14 -> =
cpu:
17
[   15.843437] hfi1 0000:d8:00.0: hfi1_0: IRQ: 573, type SDMA engine 15 -> =
cpu:
19
[   15.843526] hfi1 0000:d8:00.0: hfi1_0: IRQ: 574, type RCVCTXT ctxt 0 -> =
cpu:
1
[   15.843591] hfi1 0000:d8:00.0: hfi1_0: IRQ: 575, type RCVCTXT ctxt 1 -> =
cpu:
3
[   15.843650] hfi1 0000:d8:00.0: hfi1_0: IRQ: 576, type RCVCTXT ctxt 2 -> =
cpu:
5
[   15.843660] hfi1 0000:d8:00.0: hfi1_0: Downloading fabric firmware
[   15.847004] EDAC MC0: Giving out device to module skx_edac controller
Skylake Socket#0 IMC#0: DEV 0000:3a:0a.0 (INTERRUPT)
[   15.847066] EDAC MC1: Giving out device to module skx_edac controller
Skylake Socket#0 IMC#1: DEV 0000:3a:0c.0 (INTERRUPT)
[   15.847129] EDAC MC2: Giving out device to module skx_edac controller
Skylake Socket#1 IMC#0: DEV 0000:ae:0a.0 (INTERRUPT)
[   15.847188] EDAC MC3: Giving out device to module skx_edac controller
Skylake Socket#1 IMC#1: DEV 0000:ae:0c.0 (INTERRUPT)
[   15.876384] iscsi: registered transport (iser)
[   15.892271] mlx5_core 0000:af:00.1: MLX5E: StrdRq(0) RqSz(1024) StrdSz(2=
56)
RxCqeCmprss(0)
[   15.892286] mlx5_core 0000:af:00.1: MLX5E: StrdRq(0) RqSz(1024) StrdSz(2=
56)
RxCqeCmprss(0)
[   15.893881] mlx5_core 0000:af:00.0 ibs4f0: renamed from ib0
[   15.932220] Rounding down aligned max_sectors from 4294967295 to 4294967=
288
[   15.932307] db_root: cannot open: /etc/target
[   15.972283] mlx5_core 0000:af:00.1 ibs4f1: renamed from ib0
[   16.001488] hfi1 0000:d8:00.0: hfi1_0: 8051 firmware version 1.27.0
[   16.013527] hfi1 0000:d8:00.0: hfi1_0: SBus Master firmware version
0x10130001
[   16.033368] ib_srpt ib_cm_listen() failed: -22 (cm_id state =3D 0)
[   16.041974] ib_srpt srpt_add_one(mlx5_0) failed.
[   16.042219] ib_srpt ib_cm_listen() failed: -22 (cm_id state =3D 0)
[   16.049562] ib_srpt srpt_add_one(mlx5_1) failed.
[   16.152676] intel_rapl_common: Found RAPL domain package
[   16.152688] intel_rapl_common: Found RAPL domain dram
[   16.152693] intel_rapl_common: DRAM domain energy unit 15300pj
[   16.152906] intel_rapl_common: Found RAPL domain package
[   16.152929] intel_rapl_common: Found RAPL domain dram
[   16.152935] intel_rapl_common: DRAM domain energy unit 15300pj
[   16.152942] RPC: Registered named UNIX socket transport module.
[   16.152945] RPC: Registered udp transport module.
[   16.152946] RPC: Registered tcp transport module.
[   16.152947] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   16.206368] hfi1 0000:d8:00.0: hfi1_0: PCIe SerDes firmware version 0x47=
55
[   16.232757] RPC: Registered rdma transport module.
[   16.232759] RPC: Registered rdma backchannel transport module.
[   16.254996] hfi1 0000:d8:00.0: hfi1_0: Fabric SerDes firmware version 0x=
1055
[   16.255012] hfi1 0000:d8:00.0: hfi1_0: Initializing thermal sensor
[   17.196285] bnxt_en 0000:19:00.0 eno1np0: NIC Link is Up, 10000 Mbps full
duplex, Flow control: ON - receive & transmit
[   17.196297] bnxt_en 0000:19:00.0 eno1np0: FEC autoneg off encoding: None
[   17.457959] hfi1 0000:d8:00.0: hfi1_0: apply_rx_amplitude_settings:
Requested RX AMP 1
[   17.457963] hfi1 0000:d8:00.0: hfi1_0: apply_rx_amplitude_settings: Appl=
ying
RX AMP 1
[   17.498036] hfi1 0000:d8:00.0: hfi1_0: handle_qsfp_int: Interrupt receiv=
ed
from QSFP module
[   17.651488] hfi1 0000:d8:00.0: hfi1_0: set_link_state: current OFFLINE, =
new
POLL=20
[   17.651498] hfi1 0000:d8:00.0: hfi1_0: Downloading fabric firmware
[   17.855391] hfi1 0000:d8:00.0: hfi1_0: physical state changed to PHYS_PO=
LL
(0x2), phy 0x20
[   17.855439] hfi1 0000:d8:00.0: hfi1_0: Reserving QPNs from 0x800000 to
0x81ffff for non-verbs use
[   17.859574] hfi1 0000:d8:00.0: hfi1_0: created netdev context 3
[   17.860804] hfi1 0000:d8:00.0: hfi1_0: Setting rcv queue 0 napi to conte=
xt 3
[   17.860829] hfi1 0000:d8:00.0: hfi1_0: IRQ: 577, type NETDEVCTXT ctxt 3 =
->
cpu: 21
[   17.860840] hfi1 0000:d8:00.0: hfi1_0: created netdev context 4
[   17.862065] hfi1 0000:d8:00.0: hfi1_0: Setting rcv queue 1 napi to conte=
xt 4
[   17.862076] hfi1 0000:d8:00.0: hfi1_0: IRQ: 578, type NETDEVCTXT ctxt 4 =
->
cpu: 23
[   17.862086] hfi1 0000:d8:00.0: hfi1_0: created netdev context 5
[   17.863312] hfi1 0000:d8:00.0: hfi1_0: Setting rcv queue 2 napi to conte=
xt 5
[   17.863326] hfi1 0000:d8:00.0: hfi1_0: IRQ: 579, type NETDEVCTXT ctxt 5 =
->
cpu: 7
[   17.863336] hfi1 0000:d8:00.0: hfi1_0: created netdev context 6
[   17.864566] hfi1 0000:d8:00.0: hfi1_0: Setting rcv queue 3 napi to conte=
xt 6
[   17.864577] hfi1 0000:d8:00.0: hfi1_0: IRQ: 580, type NETDEVCTXT ctxt 6 =
->
cpu: 9
[   17.864587] hfi1 0000:d8:00.0: hfi1_0: created netdev context 7
[   17.865820] hfi1 0000:d8:00.0: hfi1_0: Setting rcv queue 4 napi to conte=
xt 7
[   17.865832] hfi1 0000:d8:00.0: hfi1_0: IRQ: 581, type NETDEVCTXT ctxt 7 =
->
cpu: 11
[   17.865842] hfi1 0000:d8:00.0: hfi1_0: created netdev context 8
[   17.867080] hfi1 0000:d8:00.0: hfi1_0: Setting rcv queue 5 napi to conte=
xt 8
[   17.867093] hfi1 0000:d8:00.0: hfi1_0: IRQ: 582, type NETDEVCTXT ctxt 8 =
->
cpu: 13
[   17.867103] hfi1 0000:d8:00.0: hfi1_0: created netdev context 9
[   17.868348] hfi1 0000:d8:00.0: hfi1_0: Setting rcv queue 6 napi to conte=
xt 9
[   17.868363] hfi1 0000:d8:00.0: hfi1_0: IRQ: 583, type NETDEVCTXT ctxt 9 =
->
cpu: 15
[   17.868374] hfi1 0000:d8:00.0: hfi1_0: created netdev context 10
[   17.869608] hfi1 0000:d8:00.0: hfi1_0: Setting rcv queue 7 napi to conte=
xt
10
[   17.869623] hfi1 0000:d8:00.0: hfi1_0: IRQ: 584, type NETDEVCTXT ctxt 10=
 ->
cpu: 17
[   17.904565] ib_srpt ib_cm_listen() failed: -22 (cm_id state =3D 0)
[   17.918310] ib_srpt srpt_add_one(hfi1_0) failed.
[   17.919125] hfi1 0000:d8:00.0: hfi1_0: Registration with rdmavt done.
[   17.985271] infiniband hfi1_0: VNIC client initialized
[   18.227188] iw_cxgb4: 0000:5e:00.4: Up
[   18.227195] iw_cxgb4: 0000:5e:00.4: On-Chip Queues not supported on this
device
[   18.230313] cxgb4 0000:5e:00.4 ens3f4: passive DA module inserted
[   18.240426] csiostor 0000:5e:00.6: Port:0 - LINK DOWN
[   18.329686] eno2np1 speed is unknown, defaulting to 1000
[   18.329740] ens3f4 speed is unknown, defaulting to 1000
[   18.334239] cxgb4 0000:5e:00.4 ens3f4d1: port module unplugged
[   18.387823] csiostor 0000:5e:00.6: Port:1 - LINK DOWN
[   18.412123] ens3f4d1 speed is unknown, defaulting to 1000
[   18.413321] hfi1 0000:d8:00.0 ibp216s0: renamed from ib0
[   18.428723] ens3f4 speed is unknown, defaulting to 1000
[   18.706503] ens3f4d1 speed is unknown, defaulting to 1000
[   18.992055] ens3f4 speed is unknown, defaulting to 1000
[   18.997357] ens3f4d1 speed is unknown, defaulting to 1000
[   19.001338] hfi1 0000:d8:00.0: hfi1_0: enabling queue 0 on context 3
[   19.002862] hfi1 0000:d8:00.0: hfi1_0: enabling queue 1 on context 4
[   19.002938] hfi1 0000:d8:00.0: hfi1_0: enabling queue 2 on context 5
[   19.003011] hfi1 0000:d8:00.0: hfi1_0: enabling queue 3 on context 6
[   19.003086] hfi1 0000:d8:00.0: hfi1_0: enabling queue 4 on context 7
[   19.003162] hfi1 0000:d8:00.0: hfi1_0: enabling queue 5 on context 8
[   19.003246] hfi1 0000:d8:00.0: hfi1_0: enabling queue 6 on context 9
[   19.003319] hfi1 0000:d8:00.0: hfi1_0: enabling queue 7 on context 10
[   19.003969] ens3f4 speed is unknown, defaulting to 1000
[   19.009262] ens3f4d1 speed is unknown, defaulting to 1000
[   19.441797] ens3f4 speed is unknown, defaulting to 1000
[   19.447695] IPv6: ADDRCONF(NETDEV_CHANGE): ibs4f1: link becomes ready
[   19.447858] ens3f4d1 speed is unknown, defaulting to 1000
[   19.898835] IPv6: ADDRCONF(NETDEV_CHANGE): ibs4f0: link becomes ready
[   21.440463] tg3 0000:01:00.1 eno4: Link is up at 1000 Mbps, full duplex
[   21.440481] tg3 0000:01:00.1 eno4: Flow control is on for TX and on for =
RX
[   21.440489] tg3 0000:01:00.1 eno4: EEE is disabled
[   21.440521] IPv6: ADDRCONF(NETDEV_CHANGE): eno4: link becomes ready
[   21.924332] cxgb4 0000:5e:00.4 ens3f4: link up, 100Gbps, full-duplex, no
PAUSE
[   21.924344] csiostor 0000:5e:00.6: Port:0 - LINK UP
[   21.925830] IPv6: ADDRCONF(NETDEV_CHANGE): ens3f4: link becomes ready
[   23.044726] hfi1 0000:d8:00.0: hfi1_0: set_link_state: current POLL, new
VERIFY_CAP=20
[   23.044739] hfi1 0000:d8:00.0: hfi1_0: physical state changed to
PHYS_TRAINING (0x4), phy 0x46
[   23.044760] hfi1 0000:d8:00.0: hfi1_0: Fabric active lanes (width): tx 0=
xf
(4), rx 0xf (4)
[   23.044767] hfi1 0000:d8:00.0: hfi1_0: Peer PHY: power management 0x0,
continuous updates 0x1
[   23.044772] hfi1 0000:d8:00.0: hfi1_0: Peer Fabric: vAU 3, Z 1, vCU 0, v=
l15
credits 0x44, CRC sizes 0x3
[   23.044778] hfi1 0000:d8:00.0: hfi1_0: Peer Link Width: tx rate 0x2, wid=
ths
0x8
[   23.044782] hfi1 0000:d8:00.0: hfi1_0: Peer Device ID: 0xabc0, Revision =
0x10
[   23.044788] hfi1 0000:d8:00.0: hfi1_0: Final LCB CRC mode: 1
[   23.044794] hfi1 0000:d8:00.0: hfi1_0: set_link_state: current VERIFY_CA=
P,
new GOING_UP=20
[   24.660932] hfi1 0000:d8:00.0: hfi1_0: 8051: Link up
[   24.661008] hfi1 0000:d8:00.0: hfi1_0: set_link_state: current GOING_UP,=
 new
INIT (LINKUP)
[   24.661023] hfi1 0000:d8:00.0: hfi1_0: physical state changed to PHYS_LI=
NKUP
(0x5), phy 0x50
[   24.661035] hfi1 0000:d8:00.0: hfi1_0: Neighbor Guid 117501026480e3, Typ=
e 1,
Port Num 43
[   24.661547] hfi1 0000:d8:00.0: hfi1_0: Setting partition keys
[   24.661564] hfi1 0000:d8:00.0: hfi1_0: Fabric active lanes (width): tx 0=
xf
(4), rx 0xf (4)
[   24.661581] hfi1 0000:d8:00.0: hfi1_0: logical state changed to PORT_INIT
(0x2)
[   25.091609] ------------[ cut here ]------------
[   25.096234] memcpy: detected field-spanning write (size 80) of single fi=
eld
"&wqe->wr" at drivers/infiniband/sw/rdmavt/qp.c:2043 (size 40)
[   25.108705] WARNING: CPU: 1 PID: 1618 at
drivers/infiniband/sw/rdmavt/qp.c:2043 rvt_post_one_wr+0x4e3/0x6d0 [rdmavt]
[   25.119232] Modules linked in: opa_vnic rfkill rpcrdma intel_rapl_msr
intel_rapl_common sunrpc intel_uncore_frequency rdma_ucm
intel_uncore_frequency_common ib_srpt ib_isert iscsi_target_mod ib_umad
isst_if_common target_core_mod ib_iser skx_edac libiscsi nfit ib_ipoib
scsi_transport_iscsi libnvdimm x86_pkg_temp_thermal intel_powerclamp corete=
mp
hfi1 kvm_intel mlx5_ib ipmi_ssif iw_cxgb4 kvm rdmavt libcxgb bnxt_re mgag200
rdma_cm ib_uverbs iw_cm drm_shmem_helper drm_kms_helper dcdbas ib_cm mei_me
syscopyarea irqbypass i2c_algo_bit sysfillrect rapl ib_core dell_smbios
intel_cstate acpi_ipmi intel_uncore wmi_bmof sysimgblt dell_wmi_descriptor
ipmi_si pcspkr mei i2c_i801 fb_sys_fops ipmi_devintf i2c_smbus lpc_ich
intel_pch_thermal ipmi_msghandler acpi_power_meter vfat fat drm fuse xfs
libcrc32c sd_mod csiostor sg mlx5_core cxgb4 ahci crct10dif_pclmul nvme mlx=
fw
crc32_pclmul libahci psample crc32c_intel nvme_core nvme_common
ghash_clmulni_intel bnxt_en tls pci_hyperv_intf megaraid_sas
[   25.119294]  scsi_transport_fc t10_pi libata tg3 wmi dm_mirror
dm_region_hash dm_log dm_mod
[   25.214243] CPU: 1 PID: 1618 Comm: kworker/u101:1 Tainted: G          I=
=20=20=20=20=20
  6.0.0+ #1
[   25.222329] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 2.13.3
12/13/2021
[   25.229893] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
[   25.235839] RIP: 0010:rvt_post_one_wr+0x4e3/0x6d0 [rdmavt]
[   25.241324] Code: 26 fd ff ff b9 28 00 00 00 4c 89 ee 4c 89 1c 24 48 c7 =
c2
58 67 2d c1 48 c7 c7 98 67 2d c1 c6 05 d3 27 01 00 01 e8 78 14 a3 cf <0f> 0=
b 4c
8b 1c 24 e9 f5 fc ff ff 49 8b 74 24 28 49 8b 7c 24 50 4c
[   25.260072] RSP: 0018:ffffbfad086a7bc0 EFLAGS: 00010082
[   25.260074] RAX: 0000000000000000 RBX: ffffa0ba21e0f800 RCX:
0000000000000027
[   25.260075] RDX: ffffa0c5b721f848 RSI: 0000000000000001 RDI:
ffffa0c5b721f840
[   25.260076] RBP: ffffa0b9d3330898 R08: 0000000000000000 R09:
00000000ffff7fff
[   25.260077] R10: ffffbfad086a7a60 R11: ffffffff91be73e8 R12:
ffffbfad08779000
[   25.260078] R13: 0000000000000050 R14: 0000000000000000 R15:
ffffa0ba21e0f800
[   25.260079] FS:  0000000000000000(0000) GS:ffffa0c5b7200000(0000)
knlGS:0000000000000000
[   25.260080] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.260081] CR2: 000055bd3c11e098 CR3: 0000000c0a210002 CR4:
00000000007706e0
[   25.260082] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   25.260083] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   25.260084] PKRU: 55555554
[   25.260085] Call Trace:
[   25.260086]  <TASK>
[   25.260089]  rvt_post_send+0xa9/0x150 [rdmavt]
[   25.260098]  ib_send_mad+0x251/0x430 [ib_core]
[   25.260125]  ? __kmalloc+0x19b/0x360
[   25.260130]  ib_post_send_mad+0x154/0x310 [ib_core]
[   25.365022]  agent_send_response+0x183/0x1f0 [ib_core]
[   25.370178]  ib_mad_recv_done+0x5ea/0x640 [ib_core]
[   25.375066]  __ib_process_cq+0x86/0x190 [ib_core]
[   25.379780]  ib_cq_poll_work+0x26/0x80 [ib_core]
[   25.384407]  process_one_work+0x1e2/0x3b0
[   25.388420]  ? rescuer_thread+0x390/0x390
[   25.392432]  worker_thread+0x50/0x3a0
[   25.396099]  ? rescuer_thread+0x390/0x390
[   25.400110]  kthread+0xd6/0x100
[   25.403257]  ? kthread_complete_and_exit+0x20/0x20
[   25.408049]  ret_from_fork+0x1f/0x30
[   25.411631]  </TASK>
[   25.413820] ---[ end trace 0000000000000000 ]---
[   25.455714] hfi1 0000:d8:00.0: hfi1_0: Setting partition keys
[   25.456183] hfi1 0000:d8:00.0: hfi1_0: port 1: got a lid: 0x4
[   25.456195] SubnSet(OPA_PortInfo) smlid 0x5
[   25.456247] hfi1 0000:d8:00.0: hfi1_0: disabling queue 0 on context 3
[   25.460401] hfi1 0000:d8:00.0: hfi1_0: disabling queue 1 on context 4
[   25.460404] hfi1 0000:d8:00.0: hfi1_0: MTU change on vl 1 from 10240 to 0
[   25.460409] hfi1 0000:d8:00.0: hfi1_0: disabling queue 2 on context 5
[   25.460411] hfi1 0000:d8:00.0: hfi1_0: MTU change on vl 2 from 10240 to 0
[   25.460418] hfi1 0000:d8:00.0: hfi1_0: disabling queue 3 on context 6
[   25.460418] hfi1 0000:d8:00.0: hfi1_0: MTU change on vl 3 from 10240 to 0
[   25.460424] hfi1 0000:d8:00.0: hfi1_0: MTU change on vl 4 from 10240 to 0
[   25.460427] hfi1 0000:d8:00.0: hfi1_0: disabling queue 4 on context 7
[   25.460431] hfi1 0000:d8:00.0: hfi1_0: MTU change on vl 5 from 10240 to 0
[   25.460436] hfi1 0000:d8:00.0: hfi1_0: disabling queue 5 on context 8
[   25.460436] hfi1 0000:d8:00.0: hfi1_0: MTU change on vl 6 from 10240 to 0
[   25.460443] hfi1 0000:d8:00.0: hfi1_0: MTU change on vl 7 from 10240 to 0
[   25.460444] hfi1 0000:d8:00.0: hfi1_0: disabling queue 6 on context 9
[   25.460451] hfi1 0000:d8:00.0: hfi1_0: disabling queue 7 on context 10
[   25.466338] hfi1 0000:d8:00.0: hfi1_0: set_link_state: current INIT, new
ARMED=20
[   25.466353] hfi1 0000:d8:00.0: hfi1_0: logical state changed to PORT_ARM=
ED
(0x3)
[   25.466360] hfi1 0000:d8:00.0: hfi1_0: send_idle_message: sending idle
message 0x103
[   25.466689] hfi1 0000:d8:00.0: hfi1_0: read_idle_message: read idle mess=
age
0x103
[   25.466698] hfi1 0000:d8:00.0: hfi1_0: handle_sma_message: SMA message 0=
x1
[   25.470293] hfi1 0000:d8:00.0: hfi1_0: enabling queue 0 on context 3
[   25.470387] hfi1 0000:d8:00.0: hfi1_0: enabling queue 1 on context 4
[   25.470476] hfi1 0000:d8:00.0: hfi1_0: enabling queue 2 on context 5
[   25.470564] hfi1 0000:d8:00.0: hfi1_0: enabling queue 3 on context 6
[   25.470652] hfi1 0000:d8:00.0: hfi1_0: enabling queue 4 on context 7
[   25.470740] hfi1 0000:d8:00.0: hfi1_0: enabling queue 5 on context 8
[   25.470828] hfi1 0000:d8:00.0: hfi1_0: enabling queue 6 on context 9
[   25.470915] hfi1 0000:d8:00.0: hfi1_0: enabling queue 7 on context 10
[   25.516851] hfi1 0000:d8:00.0: hfi1_0: set_link_state: current ARMED, new
ACTIVE=20
[   25.516873] hfi1 0000:d8:00.0: hfi1_0: logical state changed to PORT_ACT=
IVE
(0x4)
[   25.516883] hfi1 0000:d8:00.0: hfi1_0: send_idle_message: sending idle
message 0x203
[   25.517163] hfi1 0000:d8:00.0: hfi1_0: read_idle_message: read idle mess=
age
0x203
[   25.517172] hfi1 0000:d8:00.0: hfi1_0: handle_sma_message: SMA message 0=
x2
[   25.823696] IPv6: ADDRCONF(NETDEV_CHANGE): ibp216s0: link becomes ready
[   26.143999] FS-Cache: Loaded
[   26.326945] Key type dns_resolver registered
[   26.542899] NFS: Registering the id_resolver key type
[   26.542907] Key type id_resolver registered
[   26.542913] Key type id_legacy registered
[  151.949694] ens3f4d1 speed is unknown, defaulting to 1000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
