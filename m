Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF4078DD54
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Aug 2023 20:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbjH3Ss7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Aug 2023 14:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbjH3KuV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Aug 2023 06:50:21 -0400
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 03:50:16 PDT
Received: from mail.bsc.es (mao.bsc.es [84.88.52.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C8B1BB
        for <linux-rdma@vger.kernel.org>; Wed, 30 Aug 2023 03:50:16 -0700 (PDT)
Received: from hop.home (unknown [10.100.4.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.bsc.es (Postfix) with ESMTPSA id AE84C4061888;
        Wed, 30 Aug 2023 12:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsc.es; s=20191012;
        t=1693392219; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=r3xZeTc9u3gWsp25nsUIMugTiHBMlDf5D2sxvPh5TTU=;
        b=pt/NJGKa6aoPpGu7rLahdVFj4FL/JRa6QBuP0puQc3CzhzWBJVoEFdav1+oR1Akqc3wYcG
        XGPsjJo4OGGDyS87HTjcsIRU5fDT4UWZqmdtqPRWoC7bS97jTJ5l+xHBopPHHM/rES08fr
        q1b1uCxLBAau2KV9OEPTia9kJe5FOFagfJ7PWnj6CGuE5pj0T0wrfsnKIRaSNWih9kBdc3
        lwBgatKX7oAlQejUWJ6ok8un1kvTEArptmTS35tH2CaRcwDggWVeE6IiunYD80Mqov8/xa
        UZ+domSlDPDn6tFxvLnu1Qd3Rqbl/R9bM6/8MQf1goKQalkKFo0OoqSAkSkBvQ==
Date:   Wed, 30 Aug 2023 12:43:37 +0200
From:   Rodrigo Arias <rodrigo.arias@bsc.es>
To:     linux-rdma@vger.kernel.org
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [bug-report] Oops at hfi1_ipoib_send + hfi1_ipoib_sdma_complete IRQ
Message-ID: <ZO8dWSh5Y9D8FZG9@hop.home>
Reply-To: Rodrigo Arias <rodrigo.arias@bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Copyrighted-Material: Please visit http://www.bsc.es/disclaimer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

(Please CC me)

I'm testing the Ceph filesystem in an OmniPath network using ipoib and=20
I'm able to cause an oops every time I run a fio benchmark with more=20
than one writer for some seconds. Here is the oops of the 6.4.11 kernel=20
=66rom netconsole:

[ 2116.528509] BUG: kernel NULL pointer dereference, address: 0000000000000=
010
[ 2116.536343] #PF: supervisor read access in kernel mode
[ 2116.542106] #PF: error_code(0x0000) - not-present page
[ 2116.547853] PGD 0 P4D 0
[ 2116.550699] Oops: 0000 [#1] PREEMPT SMP PTI
[ 2116.555380] CPU: 4 PID: 42 Comm: ksoftirqd/4 Not tainted 6.4.11 #1-NixOS
[ 2116.562889] Hardware name: Intel Corporation S2600WT2R/S2600WT2R, BIOS S=
E5C610.86B.01.01.0016.033120161139 03/31/2016
[ 2116.574768] RIP: 0010:napi_schedule_prep+0x9/0x50
[ 2116.580050] Code: 68 54 0c 94 e8 58 3e cf ff 0f 1f 84 00 00 00 00 00 90 =
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <48=
> 8b 4f 10 f6 c1 04 75 29 48 89 ca 48 89 c8 83 e2 01 48 01 d2 48
[ 2116.601069] RSP: 0018:ffffabe5c65f0eb8 EFLAGS: 00010046
[ 2116.606923] RAX: ffffffffc14f1ab0 RBX: 0000000000000000 RCX: 00000000000=
00001
[ 2116.614916] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[ 2116.622905] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[ 2116.630897] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00617
[ 2116.638887] R13: ffff9164955396b0 R14: 0000000000000016 R15: ffff916498d=
09a00
[ 2116.646878] FS:  0000000000000000(0000) GS:ffff9173bfb00000(0000) knlGS:=
0000000000000000
[ 2116.655940] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2116.662375] CR2: 0000000000000010 CR3: 0000000a8ee20002 CR4: 00000000003=
706e0
[ 2116.670366] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2116.678356] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2116.686346] Call Trace:
[ 2116.689089]  <IRQ>
[ 2116.691350]  ? __die+0x23/0x70
[ 2116.694782]  ? page_fault_oops+0x17d/0x4b0
[ 2116.700050]  ? ip_protocol_deliver_rcu+0x32/0x170
[ 2116.705968]  ? exc_page_fault+0x6d/0x150
[ 2116.711007]  ? asm_exc_page_fault+0x26/0x30
[ 2116.716336]  ? __pfx_hfi1_ipoib_sdma_complete+0x10/0x10 [hfi1]
[ 2116.723646]  ? napi_schedule_prep+0x9/0x50
[ 2116.728875]  hfi1_ipoib_sdma_complete+0x38/0x90 [hfi1]
[ 2116.735353]  sdma_make_progress+0x178/0x460 [hfi1]
[ 2116.741459]  ? __pfx_hfi1_ipoib_sdma_complete+0x10/0x10 [hfi1]
[ 2116.748712]  sdma_engine_interrupt+0x72/0x100 [hfi1]
[ 2116.755030]  sdma_interrupt+0x36/0x110 [hfi1]
[ 2116.760632]  __handle_irq_event_percpu+0x4d/0x1a0
[ 2116.766538]  handle_irq_event+0x3e/0x80
[ 2116.771462]  handle_edge_irq+0x9d/0x280
[ 2116.776380]  __common_interrupt+0x46/0xc0
[ 2116.781495]  common_interrupt+0x81/0xa0
[ 2116.786418]  </IRQ>
[ 2116.789403]  <TASK>
[ 2116.792382]  asm_common_interrupt+0x26/0x40
[ 2116.797708] RIP: 0010:skb_segment+0x86b/0xf00
[ 2116.803222] Code: 24 44 8b 74 24 60 49 89 cc 48 8b 4c 24 28 e9 8b 00 00 =
00 48 8b 11 48 8b 79 08 49 89 14 24 48 89 d0 49 89 7c 24 08 48 8b 50 08 <f6=
> c2 01 0f 85 c9 03 00 00 0f 1f 44 00 00 f0 ff 40 34 41 8b 44 24
[ 2116.825561] RSP: 0018:ffffabe5c65dbb90 EFLAGS: 00000213
[ 2116.832097] RAX: ffffd6a144ae8c00 RBX: ffff9164af715c00 RCX: ffff9164db5=
25400
[ 2116.840773] RDX: 0000000000000000 RSI: ffff91648734f0e8 RDI: 00000000000=
08000
[ 2116.849444] RBP: ffffabe5c65dbc60 R08: 0000000000005dac R09: 00000000000=
06574
[ 2116.858127] R10: 25dd4e99d6e1ffe7 R11: 0000000000000003 R12: ffff916487c=
b7980
[ 2116.866801] R13: 0000000000005df8 R14: 0000000000000001 R15: 00000000000=
00000
[ 2116.875493]  ? __pfx_csum_partial_ext+0x10/0x10
[ 2116.881263]  ? __pfx_csum_block_add_ext+0x10/0x10
[ 2116.887289]  tcp_gso_segment+0xec/0x4e0
[ 2116.892247]  ? __pfx_tcp_wfree+0x10/0x10
[ 2116.897283]  inet_gso_segment+0x159/0x3d0
[ 2116.902393]  ? hfi1_ipoib_send+0x246/0x560 [hfi1]
[ 2116.908364]  skb_mac_gso_segment+0xa4/0x110
[ 2116.914180]  __skb_gso_segment+0xb7/0x170
[ 2116.919271]  ? netif_skb_features+0x151/0x2e0
[ 2116.924746]  validate_xmit_skb+0x16c/0x340
[ 2116.929930]  validate_xmit_skb_list+0x4e/0x70
[ 2116.935392]  sch_direct_xmit+0x18a/0x380
[ 2116.940372]  __qdisc_run+0x149/0x5a0
[ 2116.944952]  net_tx_action+0x1df/0x2a0
[ 2116.949714]  __do_softirq+0xca/0x2ae
[ 2116.954278]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 2116.960005]  run_ksoftirqd+0x2c/0x40
[ 2116.964575]  smpboot_thread_fn+0xdc/0x1d0
[ 2116.969622]  kthread+0xe8/0x120
[ 2116.973702]  ? __pfx_kthread+0x10/0x10
[ 2116.978465]  ret_from_fork+0x2c/0x50
[ 2116.983033]  </TASK>
[ 2116.986029] Modules linked in: netconsole ipmi_si nfsv3 nfs_acl nfs lock=
d grace netfs fscache msr sb_edac edac_core intel_rapl_msr intel_rapl_commo=
n intel_uncore_frequency intel_uncore_frequency_common hfi1 x86_pkg_temp_th=
ermal intel_powerclamp coretemp crc32_pclmul polyval_clmulni polyval_generi=
c gf128mul ghash_clmulni_intel sha512_ssse3 sha512_generic aesni_intel mgag=
200 libaes drm_shmem_helper crypto_simd cryptd igb drm_kms_helper rdmavt ra=
pl iTCO_wdt mei_me intel_cstate intel_pmc_bxt ptp syscopyarea ib_uverbs pps=
_core watchdog sysfillrect mxm_wmi sunrpc intel_uncore sysimgblt mei i2c_i8=
01 i2c_algo_bit ioatdma i2c_smbus lpc_ich evdev dca input_leds joydev led_c=
lass mousedev mac_hid wmi tiny_power_button acpi_power_meter acpi_pad butto=
n xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_rpfilter xt_p=
kttype xt_LOG nf_log_syslog xt_tcpudp nft_compat sch_fq_codel nf_tables lib=
crc32c nfnetlink atkbd libps2 serio vivaldi_fmap loop cpufreq_powersave tun=
 tap macvlan bridge stp llc kvm irqbypass ib_ipoib ib_cm
[ 2116.986177]  ib_umad ib_core ipmi_watchdog ipmi_devintf ipmi_msghandler =
fuse drm efi_pstore backlight configfs dmi_sysfs ip_tables x_tables autofs4=
 ext4 crc32c_generic crc16 mbcache jbd2 hid_generic usbhid hid sd_mod ahci =
xhci_pci xhci_pci_renesas libahci firmware_class ehci_pci xhci_hcd libata e=
hci_hcd nvme nvme_core usbcore scsi_mod t10_pi crc32c_intel crc64_rocksoft =
crc64 crc_t10dif crct10dif_generic crct10dif_pclmul crct10dif_common usb_co=
mmon scsi_common rtc_cmos dm_mod dax [last unloaded: ipmi_si]
[ 2117.145385] CR2: 0000000000000010
[ 2117.149915] ---[ end trace 0000000000000000 ]---
[ 2117.215956] RIP: 0010:napi_schedule_prep+0x9/0x50
[ 2117.222128] Code: 68 54 0c 94 e8 58 3e cf ff 0f 1f 84 00 00 00 00 00 90 =
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <48=
> 8b 4f 10 f6 c1 04 75 29 48 89 ca 48 89 c8 83 e2 01 48 01 d2 48
[ 2117.244851] RSP: 0018:ffffabe5c65f0eb8 EFLAGS: 00010046
[ 2117.251528] RAX: ffffffffc14f1ab0 RBX: 0000000000000000 RCX: 00000000000=
00001
[ 2117.260351] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[ 2117.269151] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[ 2117.277962] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00617
[ 2117.286754] R13: ffff9164955396b0 R14: 0000000000000016 R15: ffff916498d=
09a00
[ 2117.295538] FS:  0000000000000000(0000) GS:ffff9173bfb00000(0000) knlGS:=
0000000000000000
[ 2117.305396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2117.312654] CR2: 0000000000000010 CR3: 0000000a8ee20002 CR4: 00000000003=
706e0
[ 2117.321457] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2117.330257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2117.339079] Kernel panic - not syncing: Fatal exception in interrupt
[ 2117.347081] Kernel Offset: 0x12200000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
[ 2117.420699] ---[ end Kernel panic - not syncing: Fatal exception in inte=
rrupt ]---

The OmniPath info from lspci -v:

05:00.0 Fabric controller: Intel Corporation Omni-Path HFI Silicon 100=20
Series [discrete] (rev 11)
	Subsystem: Intel Corporation Omni-Path HFI Silicon 100 Series [discrete]
	Flags: bus master, fast devsel, latency 0, IRQ 205, NUMA node 0
	Memory at 90000000 (64-bit, non-prefetchable) [size=3D64M]
	Expansion ROM at <ignored> [disabled]
	Capabilities: [40] Power Management version 3
	Capabilities: [70] Express Endpoint, MSI 00
	Capabilities: [b0] MSI-X: Enable+ Count=3D256 Masked-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [148] Secondary PCI Express
	Capabilities: [178] Transaction Processing Hints
	Kernel driver in use: hfi1
	Kernel modules: hfi1

And here is dmesg | grep hfi :

[   11.299758] hfi1 0000:05:00.0: hfi1_0: Eager buffer size 8388608
[   11.299841] hfi1 0000:05:00.0: hfi1_0: UC base1: 00000000526a78a9 for 12=
00000
[   11.299845] hfi1 0000:05:00.0: hfi1_0: RcvArray count: 65536
[   11.299862] hfi1 0000:05:00.0: hfi1_0: UC base2: 00000000088b79df for d8=
0000
[   11.299868] hfi1 0000:05:00.0: hfi1_0: WC piobase: 000000001c60bc9b for =
2000000
[   11.299874] hfi1 0000:05:00.0: hfi1_0: WC RcvArray: 00000000064844ea for=
 80000
[   11.299884] hfi1 0000:05:00.0: hfi1_0: Implementation: RTL silicon, revi=
sion 0x0
[   11.299887] hfi1 0000:05:00.0: hfi1_0: GUID 117501017982d2
[   11.300105] hfi1 0000:05:00.0: hfi1_0: Resetting CSRs with FLR
[   11.402144] hfi1 0000:05:00.0: hfi1_0: PCIe,5000MHz,x16
[   11.414874] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: download=
ing firmware
[   11.414877] hfi1 0000:05:00.0: hfi1_0: Downloading SBus firmware
[   11.438112] hfi1 0000:05:00.0: hfi1_0: Setting PCIe SerDes broadcast
[   11.438120] hfi1 0000:05:00.0: hfi1_0: Downloading PCIe firmware
[   11.475144] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: setting =
PCIe registers
[   11.475161] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: using EQ=
 Pset 2
[   11.475162] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: doing pc=
ie post steps
[   11.475202] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: clearing=
 ASPM
[   11.475205] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: setting =
parent target link speed
[   11.475207] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: ..old li=
nk control2: 0x3
[   11.475209] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: ..target=
 speed is OK
[   11.475210] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: setting =
target link speed
[   11.475212] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: ..old li=
nk control2: 0x2
[   11.475213] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: ..new li=
nk control2: 0x3
[   11.475215] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: arming g=
asket logic
[   11.475217] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: calling =
trigger_sbr
[   11.619094] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: calling =
restore_pci_variables
[   11.619112] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: gasket b=
lock status: 0x1
[   11.619117] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: per-lane=
 errors: 0x0
[   11.619123] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: new spee=
d and width: PCIe,8000MHz,x16
[   11.619129] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: done
[   11.653960] hfi1 0000:05:00.0: hfi1_0: Setting partition keys
[   11.653970] hfi1 0000:05:00.0: hfi1_0: parse_platform_config:File length=
 out of bounds, using alternative format
[   11.653974] hfi1 0000:05:00.0: hfi1_0: parse_platform_config:File claims=
 to be smaller than read size, continuing
[   11.653984] hfi1 0000:05:00.0: hfi1_0: Board description not found
[   11.653990] hfi1 0000:05:00.0: hfi1_0: allocating rx size 2560
[   11.653999] hfi1 0000:05:00.0: hfi1_0: rcv contexts: chip 160, used 27 (=
kernel 3, netdev 8, user 16)
[   11.654005] hfi1 0000:05:00.0: hfi1_0: RcvArray groups 303, ctxts extra =
11
[   11.654011] hfi1 0000:05:00.0: hfi1_0: unused send context blocks: 9
[   11.654014] hfi1 0000:05:00.0: hfi1_0: send contexts: chip 160, used 44 =
(kernel 16, ack 3, user 24, vl15 1)
[   11.654337] hfi1 0000:05:00.0: hfi1_0: Using send context 16(143) for VL=
15
[   11.654425] hfi1 0000:05:00.0: hfi1_0: SDMA mod_num_sdma: 0
[   11.654429] hfi1 0000:05:00.0: hfi1_0: SDMA chip_sdma_engines: 16
[   11.654432] hfi1 0000:05:00.0: hfi1_0: SDMA chip_sdma_mem_size: 401408
[   11.654436] hfi1 0000:05:00.0: hfi1_0: SDMA engines 16 descq_cnt 2048
[   11.654709] hfi1 0000:05:00.0: hfi1_0: SDMA num_sdma: 16
[   11.655634] hfi1 0000:05:00.0: hfi1_0: 28 MSI-X interrupts allocated
[   11.655679] hfi1 0000:05:00.0: hfi1_0: IRQ: 216, type GENERAL  -> cpu: 0
[   11.655718] hfi1 0000:05:00.0: hfi1_0: IRQ: 217, type SDMA engine 0 -> c=
pu: 3
[   11.655748] hfi1 0000:05:00.0: hfi1_0: IRQ: 218, type SDMA engine 1 -> c=
pu: 4
[   11.655775] hfi1 0000:05:00.0: hfi1_0: IRQ: 219, type SDMA engine 2 -> c=
pu: 5
[   11.655802] hfi1 0000:05:00.0: hfi1_0: IRQ: 220, type SDMA engine 3 -> c=
pu: 6
[   11.655837] hfi1 0000:05:00.0: hfi1_0: IRQ: 221, type SDMA engine 4 -> c=
pu: 7
[   11.655865] hfi1 0000:05:00.0: hfi1_0: IRQ: 222, type SDMA engine 5 -> c=
pu: 3
[   11.655893] hfi1 0000:05:00.0: hfi1_0: IRQ: 223, type SDMA engine 6 -> c=
pu: 4
[   11.655918] hfi1 0000:05:00.0: hfi1_0: IRQ: 224, type SDMA engine 7 -> c=
pu: 5
[   11.655941] hfi1 0000:05:00.0: hfi1_0: IRQ: 225, type SDMA engine 8 -> c=
pu: 6
[   11.655975] hfi1 0000:05:00.0: hfi1_0: IRQ: 226, type SDMA engine 9 -> c=
pu: 7
[   11.656001] hfi1 0000:05:00.0: hfi1_0: IRQ: 227, type SDMA engine 10 -> =
cpu: 3
[   11.656027] hfi1 0000:05:00.0: hfi1_0: IRQ: 228, type SDMA engine 11 -> =
cpu: 4
[   11.656059] hfi1 0000:05:00.0: hfi1_0: IRQ: 229, type SDMA engine 12 -> =
cpu: 5
[   11.656095] hfi1 0000:05:00.0: hfi1_0: IRQ: 230, type SDMA engine 13 -> =
cpu: 6
[   11.656132] hfi1 0000:05:00.0: hfi1_0: IRQ: 231, type SDMA engine 14 -> =
cpu: 7
[   11.656158] hfi1 0000:05:00.0: hfi1_0: IRQ: 232, type SDMA engine 15 -> =
cpu: 3
[   11.656281] hfi1 0000:05:00.0: hfi1_0: IRQ: 233, type RCVCTXT ctxt 0 -> =
cpu: 0
[   11.656379] hfi1 0000:05:00.0: hfi1_0: IRQ: 234, type RCVCTXT ctxt 1 -> =
cpu: 1
[   11.656483] hfi1 0000:05:00.0: hfi1_0: IRQ: 235, type RCVCTXT ctxt 2 -> =
cpu: 2
[   11.656498] hfi1 0000:05:00.0: hfi1_0: Downloading fabric firmware
[   11.815124] hfi1 0000:05:00.0: hfi1_0: 8051 firmware version 1.27.0
[   11.827334] hfi1 0000:05:00.0: hfi1_0: SBus Master firmware version 0x10=
130001
[   12.019816] hfi1 0000:05:00.0: hfi1_0: PCIe SerDes firmware version 0x47=
55
[   12.067297] hfi1 0000:05:00.0: hfi1_0: Fabric SerDes firmware version 0x=
1055
[   12.067310] hfi1 0000:05:00.0: hfi1_0: Initializing thermal sensor
[   14.707102] hfi1 0000:05:00.0: hfi1_0: wait_for_qsfp_init: No IntN detec=
ted, reset complete
[   14.840952] hfi1 0000:05:00.0: hfi1_0: set_link_state: current OFFLINE, =
new POLL=20
[   14.840964] hfi1 0000:05:00.0: hfi1_0: Downloading fabric firmware
[   15.045304] hfi1 0000:05:00.0: hfi1_0: physical state changed to PHYS_PO=
LL (0x2), phy 0x20
[   15.045427] hfi1 0000:05:00.0: hfi1_0: Reserving QPNs from 0x800000 to 0=
x81ffff for non-verbs use
[   15.056181] hfi1 0000:05:00.0: hfi1_0: created netdev context 3
[   15.058702] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 0 napi to conte=
xt 3
[   15.058766] hfi1 0000:05:00.0: hfi1_0: IRQ: 236, type NETDEVCTXT ctxt 3 =
-> cpu: 4
[   15.058791] hfi1 0000:05:00.0: hfi1_0: created netdev context 4
[   15.061776] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 1 napi to conte=
xt 4
[   15.061808] hfi1 0000:05:00.0: hfi1_0: IRQ: 237, type NETDEVCTXT ctxt 4 =
-> cpu: 5
[   15.061826] hfi1 0000:05:00.0: hfi1_0: created netdev context 5
[   15.064140] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 2 napi to conte=
xt 5
[   15.064163] hfi1 0000:05:00.0: hfi1_0: IRQ: 238, type NETDEVCTXT ctxt 5 =
-> cpu: 6
[   15.064179] hfi1 0000:05:00.0: hfi1_0: created netdev context 6
[   15.066314] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 3 napi to conte=
xt 6
[   15.066333] hfi1 0000:05:00.0: hfi1_0: IRQ: 239, type NETDEVCTXT ctxt 6 =
-> cpu: 7
[   15.066352] hfi1 0000:05:00.0: hfi1_0: created netdev context 7
[   15.068990] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 4 napi to conte=
xt 7
[   15.069018] hfi1 0000:05:00.0: hfi1_0: IRQ: 240, type NETDEVCTXT ctxt 7 =
-> cpu: 3
[   15.069035] hfi1 0000:05:00.0: hfi1_0: created netdev context 8
[   15.071180] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 5 napi to conte=
xt 8
[   15.071198] hfi1 0000:05:00.0: hfi1_0: IRQ: 241, type NETDEVCTXT ctxt 8 =
-> cpu: 4
[   15.071214] hfi1 0000:05:00.0: hfi1_0: created netdev context 9
[   15.073353] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 6 napi to conte=
xt 9
[   15.073371] hfi1 0000:05:00.0: hfi1_0: IRQ: 242, type NETDEVCTXT ctxt 9 =
-> cpu: 5
[   15.073387] hfi1 0000:05:00.0: hfi1_0: created netdev context 10
[   15.075538] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 7 napi to conte=
xt 10
[   15.075566] hfi1 0000:05:00.0: hfi1_0: IRQ: 243, type NETDEVCTXT ctxt 10=
 -> cpu: 6
[   15.078195] hfi1 0000:05:00.0: hfi1_0: Registration with rdmavt done.
[   15.093030] hfi1 0000:05:00.0 ibp5s0: renamed from ib0
[   19.722924] hfi1 0000:05:00.0: hfi1_0: set_link_state: current POLL, new=
 VERIFY_CAP=20
[   19.722934] hfi1 0000:05:00.0: hfi1_0: physical state changed to PHYS_TR=
AINING (0x4), phy 0x46
[   19.722951] hfi1 0000:05:00.0: hfi1_0: Fabric active lanes (width): tx 0=
xf (4), rx 0xf (4)
[   19.722956] hfi1 0000:05:00.0: hfi1_0: Peer PHY: power management 0x0, c=
ontinuous updates 0x1
[   19.722960] hfi1 0000:05:00.0: hfi1_0: Peer Fabric: vAU 3, Z 1, vCU 0, v=
l15 credits 0x44, CRC sizes 0x3
[   19.722965] hfi1 0000:05:00.0: hfi1_0: Peer Link Width: tx rate 0x2, wid=
ths 0x8
[   19.722969] hfi1 0000:05:00.0: hfi1_0: Peer Device ID: 0xabc0, Revision =
0x10
[   19.722974] hfi1 0000:05:00.0: hfi1_0: Final LCB CRC mode: 1
[   19.722979] hfi1 0000:05:00.0: hfi1_0: set_link_state: current VERIFY_CA=
P, new GOING_UP=20
[   21.960278] hfi1 0000:05:00.0: hfi1_0: 8051: Link up
[   21.960340] hfi1 0000:05:00.0: hfi1_0: set_link_state: current GOING_UP,=
 new INIT (LINKUP)
[   21.960350] hfi1 0000:05:00.0: hfi1_0: physical state changed to PHYS_LI=
NKUP (0x5), phy 0x50
[   21.960359] hfi1 0000:05:00.0: hfi1_0: Neighbor Guid 117501020d8fd4, Typ=
e 1, Port Num 33
[   21.960866] hfi1 0000:05:00.0: hfi1_0: Setting partition keys
[   21.960879] hfi1 0000:05:00.0: hfi1_0: Fabric active lanes (width): tx 0=
xf (4), rx 0xf (4)
[   21.960892] hfi1 0000:05:00.0: hfi1_0: logical state changed to PORT_INI=
T (0x2)
[   22.971450] hfi1 0000:05:00.0: hfi1_0: port 1: got a lid: 0x4
[   22.971467] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 1 from 10240 to 0
[   22.971472] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 2 from 10240 to 0
[   22.971476] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 3 from 10240 to 0
[   22.971479] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 4 from 10240 to 0
[   22.971482] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 5 from 10240 to 0
[   22.971486] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 6 from 10240 to 0
[   22.971489] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 7 from 10240 to 0
[   22.993233] hfi1 0000:05:00.0: hfi1_0: set_link_state: current INIT, new=
 ARMED=20
[   22.993246] hfi1 0000:05:00.0: hfi1_0: logical state changed to PORT_ARM=
ED (0x3)
[   22.993251] hfi1 0000:05:00.0: hfi1_0: send_idle_message: sending idle m=
essage 0x103
[   22.993273] hfi1 0000:05:00.0: hfi1_0: read_idle_message: read idle mess=
age 0x103
[   22.993281] hfi1 0000:05:00.0: hfi1_0: handle_sma_message: SMA message 0=
x1
[   22.993292] hfi1 0000:05:00.0: hfi1_0: read_idle_message: read idle mess=
age 0x103
[   22.993295] hfi1 0000:05:00.0: hfi1_0: handle_sma_message: SMA message 0=
x1
[   22.993604] hfi1 0000:05:00.0: hfi1_0: set_link_state: current ARMED, ne=
w ACTIVE=20
[   22.993625] hfi1 0000:05:00.0: hfi1_0: logical state changed to PORT_ACT=
IVE (0x4)
[   22.993633] hfi1 0000:05:00.0: hfi1_0: send_idle_message: sending idle m=
essage 0x203
[   23.014640] hfi1 0000:05:00.0: hfi1_0: read_idle_message: read idle mess=
age 0x203
[   23.014651] hfi1 0000:05:00.0: hfi1_0: handle_sma_message: SMA message 0=
x2

Best,
Rodrigo.
