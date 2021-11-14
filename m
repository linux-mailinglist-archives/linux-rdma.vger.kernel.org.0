Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD744F735
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Nov 2021 09:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhKNIOS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Nov 2021 03:14:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhKNIOS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Nov 2021 03:14:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9B7161104;
        Sun, 14 Nov 2021 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636877484;
        bh=WYSyYpvm0tMh/jDBQWt8yCUaua298xnr+KmfsRgOpNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SG1h9XEDwQ28aaXpsx5nWaljek7mRabSBP3odK+z8ri2uY0HMVFi10nnAjgpmyFVT
         6GIQ1usdQxLYq+3HRq5fbUY+dKfMtaXg4gc2FfuSNHy+IKENrzBanfPvjsAeEh2qwW
         Xws32GaOpt3TEfEjN2KPgFTMUTj23L4KRVoDi+4H5EYVfhurr5CG/nATsQtG9JKU5X
         p+8kCPECio4Fh3/Tqd/gsuSqpdLvV0wL6BTz3UrqneYHMK9mIrlcvmPOb9WgX6bg1e
         yF7ELuj2xwUB/iExIUzJ/8jEfYUERFKGa5mmCFLVSk/ulrdV10VFi8w9qtj3wSw9uG
         KiT7PsnVsvVoQ==
Date:   Sun, 14 Nov 2021 10:11:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Drew Fitch <dacomusai@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Fwd: Infiniband mthca driver crash on linux kernel 5.11 and
 higher
Message-ID: <YZDEqEX4EaUE7JHR@unreal>
References: <CAOTVd1UNAJxmdSWdkmrEaW_CzuZrd5T1cmZHZDOk7fbnOopHQg@mail.gmail.com>
 <CAOTVd1VaW3Q2nyfu=9W9sUHD=y=hBvXA=J6-_AMH6XvuzuDHdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOTVd1VaW3Q2nyfu=9W9sUHD=y=hBvXA=J6-_AMH6XvuzuDHdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 12, 2021 at 11:34:12AM -0800, Drew Fitch wrote:
> To whom it may concern,
>=20
> I hope this is the right place to submit Infiniband driver bug reports.
> As I understand it, cards that rely on the mthca driver are relatively
> old and I would understand if they are no longer supported.
> I've attached files detailing my tests and conditions and relevant
> dmesg snippets. If there is any other information I can provide, or
> somewhere else I should send this, please let me know.
>=20
> Thanks in advance!
> Andrew

> Infiniband MTHCA module crash
>=20
> Working on Ubuntu 20.04 kernel 5.4
> Crashing on Alpine kernel 5.15.1, Xanmod kernel 5.14.17, Ubuntu 21.04 ker=
nel 5.11
> Rootfs is Alpine Linux Edge (nfs shared rootfs)
> all nodes run the same rootfs regardless of kernel
> all cards have the latest firmware. Switch is an IS5022.

I don't know if anyone from the active developers in this ML have such card.
Can you try to find which field in mthca_poll_cq() causes to this crash?

Thanks

>=20
> OpenSM versions tested:
> Distribution version(Alpine Testing); OFED 3.3.20 (with alpine musl fixes=
 patch); linux-rdma (also with alpine musl fixes patch); Ubuntu 20.04 distr=
ibution (run from chroot).=20
>=20
> Crash conditions as tested:
> Run opensm(any version listed above)
> Opensm sits at "Entering DISCOVERY state"
> dmesg entries as attached
> module ib_mthca can no longer be unloaded
>=20
> Working conditions (with Ubuntu 20.04 kernel 5.4)
> Run up opensm same as above
>=20
> ipoib interfaces can be brought up and ping other nodes that share the sa=
me kernel (5.4)
>=20
> Note:
> Nodes that are not running kernel 5.4 on the same switch will have their =
kernel modules crash when opensm is run on a node running kernel 5.4

> Infiniband MTHCA module crash - 5.15.1
>=20
> [   42.545456] BUG: unable to handle page fault for address: 000000000004=
0028
> [   42.545464] #PF: supervisor read access in kernel mode
> [   42.545467] #PF: error_code(0x0000) - not-present page
> [   42.545469] PGD 0 P4D 0=20
> [   42.545471] Oops: 0000 [#1] SMP NOPTI
> [   42.545474] CPU: 16 PID: 509 Comm: kworker/u65:0 Tainted: P           =
O      5.15.1-3-lts #4-Alpine
> [   42.545478] Hardware name: Micro-Star International Co., Ltd. MS-7A34/=
B350 PC MATE (MS-7A34), BIOS A.LR 07/02/2020
> [   42.545480] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
> [   42.545499] RIP: 0010:mthca_poll_cq+0x1e1/0x860 [ib_mthca]
> [   42.545505] Code: 8d 84 24 28 02 00 00 0f c9 41 2b 8c 24 64 02 00 00 8=
9 ce 41 8b 8c 24 4c 02 00 00 d3 ee 89 f1 41 03 b4 24 f4 01 00 00 48 63 f6 <=
48> 8b 34 f7 49 89 37 48 85 c0 74 1b 44 8b 48 0c 8b 78 14 41 39 c9
> [   42.545509] RSP: 0018:ffffaef8814a7ce0 EFLAGS: 00010006
> [   42.545511] RAX: ffff9336081da728 RBX: ffff933637134000 RCX: 000000000=
0008005
> [   42.545513] RDX: 0000000000000080 RSI: 0000000000008005 RDI: 000000000=
0000000
> [   42.545515] RBP: ffff9336061c8400 R08: 000000000000000a R09: ffff93360=
5af28b4
> [   42.545517] R10: 0000000000000246 R11: 0000000000000000 R12: ffff93360=
81da500
> [   42.545519] R13: ffff9336061c84e0 R14: 0000000000000000 R15: ffff93361=
08d4800
> [   42.545521] FS:  0000000000000000(0000) GS:ffff9344cec00000(0000) knlG=
S:0000000000000000
> [   42.545523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.545525] CR2: 0000000000040028 CR3: 0000000105cac000 CR4: 000000000=
0350ee0
> [   42.545527] Call Trace:
> [   42.545530]  ? update_load_avg+0x78/0x5a0
> [   42.545535]  ? newidle_balance+0x123/0x3f0
> [   42.545538]  ? __switch_to_asm+0x42/0x70
> [   42.545541]  ? finish_task_switch.isra.0+0xa7/0x280
> [   42.545545]  __ib_process_cq+0x57/0x150 [ib_core]
> [   42.545558]  ib_cq_poll_work+0x26/0x80 [ib_core]
> [   42.545570]  process_one_work+0x1ec/0x390
> [   42.545573]  worker_thread+0x53/0x3c0
> [   42.545575]  ? process_one_work+0x390/0x390
> [   42.545577]  kthread+0x127/0x150
> [   42.545580]  ? set_kthread_struct+0x40/0x40
> [   42.545583]  ret_from_fork+0x22/0x30
> [   42.545586] Modules linked in: bonding xt_CHECKSUM xt_MASQUERADE xt_co=
nntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat ip=
6table_filter ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_=
defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter ip_tables x_tables brid=
ge stp llc nfsd auth_rpcgss lockd grace sunrpc nls_utf8 nls_cp437 vfat fat =
ftdi_sio usbserial ib_ipoib ib_umad ib_cm af_packet r8153_ecm cdc_ether usb=
net r8152 mii pcspkr efi_pstore ib_mthca ib_uverbs ib_core ipv6 sp5100_tco =
i2c_piix4 k10temp input_leds mousedev intel_rapl_msr joydev intel_rapl_comm=
on kvm_amd ccp rng_core kvm irqbypass crct10dif_pclmul ghash_clmulni_intel =
aesni_intel crypto_simd cryptd wmi_bmof rapl wmi parport_pc parport evdev b=
utton acpi_cpufreq efivarfs hid_generic usbhid hid crc32_pclmul r8169 realt=
ek mdio_devres libphy nvme nvme_core hwmon ahci libahci libata xhci_pci xhc=
i_pci_renesas xhci_hcd simpledrm drm_kms_helper cfbfillrect syscopyarea cfb=
imgblt sysfillrect sysimgblt
> [   42.545632]  fb_sys_fops cfbcopyarea cec drm i2c_core drm_panel_orient=
ation_quirks agpgart loop zfs(PO) zunicode(PO) zzstd(O) zlua(O) zavl(PO) ic=
p(PO) zcommon(PO) znvpair(PO) spl(O) ext4 crc32c_generic crc32c_intel crc16=
 mbcache jbd2 usb_storage usbcore usb_common sd_mod t10_pi scsi_mod
> [   42.545662] CR2: 0000000000040028
> [   42.545664] ---[ end trace 4634d65b0351fcb8 ]---
> [   42.545665] RIP: 0010:mthca_poll_cq+0x1e1/0x860 [ib_mthca]
> [   42.545670] Code: 8d 84 24 28 02 00 00 0f c9 41 2b 8c 24 64 02 00 00 8=
9 ce 41 8b 8c 24 4c 02 00 00 d3 ee 89 f1 41 03 b4 24 f4 01 00 00 48 63 f6 <=
48> 8b 34 f7 49 89 37 48 85 c0 74 1b 44 8b 48 0c 8b 78 14 41 39 c9
> [   42.545674] RSP: 0018:ffffaef8814a7ce0 EFLAGS: 00010006
> [   42.545676] RAX: ffff9336081da728 RBX: ffff933637134000 RCX: 000000000=
0008005
> [   42.545677] RDX: 0000000000000080 RSI: 0000000000008005 RDI: 000000000=
0000000
> [   42.545679] RBP: ffff9336061c8400 R08: 000000000000000a R09: ffff93360=
5af28b4
> [   42.545681] R10: 0000000000000246 R11: 0000000000000000 R12: ffff93360=
81da500
> [   42.545682] R13: ffff9336061c84e0 R14: 0000000000000000 R15: ffff93361=
08d4800
> [   42.545684] FS:  0000000000000000(0000) GS:ffff9344cec00000(0000) knlG=
S:0000000000000000
> [   42.545686] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.545688] CR2: 0000000000040028 CR3: 0000000105cac000 CR4: 000000000=
0350ee0

> Infiniband MTHCA module crash - 5.14.17
>=20
> [  169.267974] BUG: unable to handle page fault for address: 000000000004=
0028
> [  169.267980] #PF: supervisor read access in kernel mode
> [  169.267982] #PF: error_code(0x0000) - not-present page
> [  169.267984] PGD 0 P4D 0=20
> [  169.267986] Oops: 0000 [#1] SMP NOPTI
> [  169.267989] CPU: 11 PID: 891 Comm: kworker/u65:2 Not tainted 5.14.17-x=
anmod1 #0~git20211106.2bf32bb
> [  169.267992] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.=
M./A520M-HDV, BIOS P1.60 03/18/2021
> [  169.267994] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
> [  169.268005] RIP: 0010:mthca_poll_cq+0x1db/0x830 [ib_mthca]
> [  169.268010] Code: 02 00 00 49 8d 85 28 02 00 00 0f c9 41 2b 8d 64 02 0=
0 00 89 ce 41 8b 8d 4c 02 00 00 d3 ee 89 f1 41 03 b5 f4 01 00 00 48 63 f6 <=
48> 8b 34 f7 49 89 37 48 85 c0 74 1c 44 8b 48 0c 8b 78 14 41 39 c9
> [  169.268013] RSP: 0018:ffffb70b810cfcd0 EFLAGS: 00010006
> [  169.268014] RAX: ffff9a7e87878f28 RBX: ffff9a7e878d5000 RCX: 000000000=
0008005
> [  169.268016] RDX: 0000000000000080 RSI: 0000000000008005 RDI: 000000000=
0000000
> [  169.268017] RBP: ffffb70b810cfe18 R08: 000000000000000a R09: ffff9a7e8=
a13aa2c
> [  169.268019] R10: 0000000000000282 R11: 0000000000000000 R12: ffff9a7e8=
db08c00
> [  169.268020] R13: ffff9a7e87878d00 R14: 0000000000000000 R15: ffff9a7e8=
ded9000
> [  169.268022] FS:  0000000000000000(0000) GS:ffff9a81becc0000(0000) knlG=
S:0000000000000000
> [  169.268024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  169.268025] CR2: 0000000000040028 CR3: 0000000106efc000 CR4: 000000000=
0750ee0
> [  169.268027] PKRU: 55555554
> [  169.268028] Call Trace:
> [  169.268031]  ? release_sock+0xa/0x90
> [  169.268035]  ? __cond_resched+0x11/0x40
> [  169.268038]  ? update_load_avg+0x7a/0x530
> [  169.268041]  ? newidle_balance+0x11b/0x3f0
> [  169.268043]  ? dequeue_entity+0xc1/0x3f0
> [  169.268045]  ? __switch_to_asm+0x42/0x70
> [  169.268048]  ? finish_task_switch.isra.0+0xa2/0x280
> [  169.268050]  __ib_process_cq+0x49/0xd0 [ib_core]
> [  169.268058]  ib_cq_poll_work+0x21/0x80 [ib_core]
> [  169.268065]  process_one_work+0x1f5/0x350
> [  169.268068]  worker_thread+0x4b/0x400
> [  169.268069]  ? process_one_work+0x350/0x350
> [  169.268071]  kthread+0x122/0x140
> [  169.268073]  ? set_kthread_struct+0x30/0x30
> [  169.268076]  ret_from_fork+0x22/0x30
> [  169.268079] Modules linked in: overlay xt_CHECKSUM xt_MASQUERADE xt_co=
nntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat ip=
6table_filter ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_=
defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter ip_tables x_tables rpcs=
ec_gss_krb5 bridge stp llc auth_rpcgss nfsv4 ib_qib rdmavt dca ib_ipoib ib_=
umad ib_cm wmi_bmof pcspkr efi_pstore nvme nvme_core ib_mthca ib_uverbs ib_=
core sp5100_tco ahci libahci k10temp intel_rapl_msr mac_hid intel_rapl_comm=
on edac_mce_amd kvm_amd ccp kvm crct10dif_pclmul ghash_clmulni_intel aesni_=
intel crypto_simd cryptd rapl nfsv3 nfs_acl nfs lockd grace sunrpc fscache =
netfs ftdi_sio usbserial r8169 crc32_pclmul realtek mdio_devres i2c_piix4 l=
ibphy xhci_pci xhci_pci_renesas wmi gpio_amdpt gpio_generic
> [  169.268114] CR2: 0000000000040028
> [  169.268115] ---[ end trace 0b7e3d6ee2a7b04a ]---
> [  169.307003] RIP: 0010:mthca_poll_cq+0x1db/0x830 [ib_mthca]
> [  169.307009] Code: 02 00 00 49 8d 85 28 02 00 00 0f c9 41 2b 8d 64 02 0=
0 00 89 ce 41 8b 8d 4c 02 00 00 d3 ee 89 f1 41 03 b5 f4 01 00 00 48 63 f6 <=
48> 8b 34 f7 49 89 37 48 85 c0 74 1c 44 8b 48 0c 8b 78 14 41 39 c9
> [  169.307011] RSP: 0018:ffffb70b810cfcd0 EFLAGS: 00010006
> [  169.307013] RAX: ffff9a7e87878f28 RBX: ffff9a7e878d5000 RCX: 000000000=
0008005
> [  169.307014] RDX: 0000000000000080 RSI: 0000000000008005 RDI: 000000000=
0000000
> [  169.307015] RBP: ffffb70b810cfe18 R08: 000000000000000a R09: ffff9a7e8=
a13aa2c
> [  169.307017] R10: 0000000000000282 R11: 0000000000000000 R12: ffff9a7e8=
db08c00
> [  169.307018] R13: ffff9a7e87878d00 R14: 0000000000000000 R15: ffff9a7e8=
ded9000
> [  169.307019] FS:  0000000000000000(0000) GS:ffff9a81becc0000(0000) knlG=
S:0000000000000000
> [  169.307020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  169.307021] CR2: 0000000000040028 CR3: 0000000106efc000 CR4: 000000000=
0750ee0
> [  169.307023] PKRU: 55555554

