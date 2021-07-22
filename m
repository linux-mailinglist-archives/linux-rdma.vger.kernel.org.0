Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750C33D1AB3
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 02:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhGUXpB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 19:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGUXpB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 19:45:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC10C061575
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 17:25:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k27so4628650edk.9
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5IOf5ntPZ6qzRjlprWjLw63Hbijv8HHyppjzxpKbPDY=;
        b=X5TF3JwHpLA39xJthttmAmvvFNBo3aGbA6t658Rco/t+//h6QqZJroWvhYTbqVAvhR
         UKa4nNC9uZDq4ygUporo6VeXaR0CUA7TgWZZvOSTxl8ZGY1FcWJfTUsiEGf+4q1ob6+3
         onCRG6FjBzTA9o59827pleqAAgC/SHR+GsZZWn9e41UbW6MiPbJxes5dI4RiXiIlbZVS
         Z1K9hrJJID9sGj+p1wQyeZlSYE1OKe3yZmGYvs6Xu3Rg7QVrZwi7uoej/UF+eLRqhSDj
         tcpX6SxlZ+52y5TXwgMHtdtZ2v9XQdwaKWh9RALfckuo0Z8CbFuiWHZln/kabMxgU8nH
         fx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5IOf5ntPZ6qzRjlprWjLw63Hbijv8HHyppjzxpKbPDY=;
        b=sb0HTa86pGe+CGA86Yi4lpLeR2EdmoBa/2hyop31R8k1ElPKdNGvCjNeMbP8VUmGMp
         Zwm6ThvRFZ8p5Gc4cXVJTKH5DI7ol4Dxo6o3u6Jccj+aTWZbNt3whU0UNcxNKu+YzLxp
         w24PyxV2S7a3i2yicYh4uZRP7kdelYaw4qCxrhGi+McLVR+rEcRWR9RdHCQl45WckWvE
         +kFCu/XbNOpZZKvlb7ewq6zB7Jgu8f+MELSecEQvNUYmHJOuYBqrjogbfRbsqLfVefTN
         xXAHCjDS+ht34XWXbzXNGq0i+ZZTMEG6clX/w2M/U/viSOPYP+xerI1lwGXNucpkdBDN
         n7IA==
X-Gm-Message-State: AOAM533wd+yGx9vnH0nWw4FWUl+L0hyAIbR3/juLDXqM8tonDsJbN5pc
        ZyiqxDzNEXAnl9r8jJ63ns0dcbK5rTyeAtkjYgY=
X-Google-Smtp-Source: ABdhPJw/C+HVjOxgccocFU6y5uz7RyZ1Zyx4IVbwS/JNgmNI8CAdanySYAsyB3vdbr15rZSQtmwNdinFEICAimeac5Y=
X-Received: by 2002:a05:6402:1bc6:: with SMTP id ch6mr52116024edb.267.1626913534586;
 Wed, 21 Jul 2021 17:25:34 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 21 Jul 2021 20:25:23 -0400
Message-ID: <CAN-5tyGxJvYpjyMUUQc_QrxnroUvmyumWyWcLsJfRZTY6naqjw@mail.gmail.com>
Subject: crash at commit ec9bf373f2458f4b5f1ece8b93a07e6204081667 running
 rping using rxe driver
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

While running rping between a client running a kernel at commit
ec9bf373f2458f4b5f1ece8b93a07e6204081667 against an rping server
(5.14-rc1 but it doesn't matter). I see the following kernel crash on
the client machine:

[  119.521742] BUG: unable to handle page fault for address: ffffc9003b8d7214
[  119.523886] #PF: supervisor read access in kernel mode
[  119.525338] #PF: error_code(0x0000) - not-present page
[  119.526777] PGD 1000067 P4D 1000067 PUD 11f6067 PMD 0
[  119.528265] Oops: 0000 [#1] SMP KASAN PTI
[  119.529372] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.13.0-rc1+ #197
[  119.531294] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 07/22/2020
[  119.534213] RIP: 0010:rxe_completer+0x761/0x1840 [rdma_rxe]
[  119.535807] Code: 8d a8 80 01 00 00 e8 2e 68 30 f6 41 8b 4c 24 28
d3 e5 4c 01 ed 48 85 ed 0f 84 20 06 00 00 48 8d bd 94 00 00 00 e8 0f
68 30 f6 <8b> 85 94 00 00 00 85 c0 0f 84 08 06 00 00 83 f8 03 0f 84 f8
08 00
[  119.540937] RSP: 0018:ffff88805cc49dc8 EFLAGS: 00010246
[  119.542406] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffc19917d1
[  119.544448] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffffc9003b8d7214
[  119.546427] RBP: ffffc9003b8d7180 R08: 0000000000000004 R09: ffffed100b9893a6
[  119.548404] R10: 0000000000000003 R11: ffffed100b9893a6 R12: ffff888011c42380
[  119.550381] R13: ffffc900038d3180 R14: 00000000ffc7ffc1 R15: ffff88800cf76000
[  119.552424] FS:  0000000000000000(0000) GS:ffff88805cc40000(0000)
knlGS:0000000000000000
[  119.554646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  119.556378] CR2: ffffc9003b8d7214 CR3: 0000000007586005 CR4: 00000000001706e0
[  119.558310] Call Trace:
[  119.558982]  <IRQ>
[  119.559536]  ? rxe_comp_queue_pkt+0x80/0x80 [rdma_rxe]
[  119.561008]  ? __update_load_avg_cfs_rq+0x5a/0x550
[  119.562290]  ? _raw_spin_lock_irqsave+0x80/0xe0
[  119.563745]  ? _raw_write_lock_irqsave+0xe0/0xe0
[  119.565281]  ? __wake_up_bit+0x81/0xe0
[  119.566415]  ? wake_bit_function+0xb0/0xb0
[  119.567669]  ? rxe_comp_queue_pkt+0x80/0x80 [rdma_rxe]
[  119.569212]  rxe_do_task+0xd2/0x160 [rdma_rxe]
[  119.570663]  tasklet_action_common.isra.16+0x142/0x1f0
[  119.572196]  __do_softirq+0xf9/0x38b
[  119.573298]  irq_exit_rcu+0x13d/0x150
[  119.574424]  sysvec_apic_timer_interrupt+0x66/0x80
[  119.575742]  </IRQ>
[  119.576332]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  119.577827] RIP: 0010:acpi_idle_do_entry+0x64/0x70
[  119.579119] Code: be 08 00 00 00 48 89 df e8 b9 09 55 ff 48 89 df
e8 71 ff 54 ff 48 8b 03 a8 08 75 0f e9 07 00 00 00 0f 00 2d 3e d1 74
00 fb f4 <fa> 5b c3 48 89 df 5b e9 70 f9 ff ff 0f 1f 44 00 00 41 57 41
89 d7
[  119.584104] RSP: 0018:ffff88800130fd40 EFLAGS: 00000246
[  119.585639] RAX: 0000000000004000 RBX: ffff8880012c8000 RCX: ffffffffb87481af
[  119.587986] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff8880012c8000
[  119.589995] RBP: 0000000000000001 R08: ffffed1000259001 R09: ffffed1000259001
[  119.591923] R10: ffff8880012c8007 R11: ffffed1000259000 R12: ffff888007ac8800
[  119.594036] R13: 0000000000000001 R14: ffff888007ac8804 R15: ffff888002b8e000
[  119.596178]  ? acpi_idle_do_entry+0x4f/0x70
[  119.597335]  acpi_idle_enter+0x14d/0x1c0
[  119.598474]  cpuidle_enter_state+0xb2/0x590
[  119.599625]  ? tick_nohz_stop_tick+0xb0/0x2c0
[  119.600847]  cpuidle_enter+0x3c/0x60
[  119.601883]  do_idle+0x399/0x400
[  119.602799]  ? arch_cpu_idle_exit+0x40/0x40
[  119.604003]  ? do_idle+0x26d/0x400
[  119.604965]  cpu_startup_entry+0x19/0x20
[  119.606048]  start_secondary+0x1c4/0x220
[  119.607130]  ? set_cpu_sibling_map+0xc30/0xc30
[  119.608347]  ? set_bringup_idt_handler.constprop.0+0x88/0x90
[  119.609896]  ? start_cpu0+0xc/0xc
[  119.610845]  secondary_startup_64_no_verify+0xc2/0xcb
[  119.612227] Modules linked in: rpcrdma rdma_ucm rdma_cm iw_cm ib_cm
rdma_rxe ip6_udp_tunnel udp_tunnel ib_uverbs ib_core uinput nls_utf8
isofs rfcomm xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat
nft_counter nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc bnep
vsock_loopback vmw_vsock_virtio_transport_common
vmw_vsock_vmci_transport vsock intel_rapl_msr snd_seq_midi
snd_seq_midi_event intel_rapl_common crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel vmw_balloon rapl joydev pcspkr snd_ens1371
uvcvideo snd_ac97_codec ac97_bus btusb snd_seq btrtl videobuf2_vmalloc
btbcm videobuf2_memops btintel videobuf2_v4l2 videobuf2_common
bluetooth snd_pcm videodev snd_timer snd_rawmidi rfkill mc
snd_seq_device ecdh_generic snd ecc soundcore vmw_vmci i2c_piix4
auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg
crc32c_intel nvme vmwgfx ata_generic drm_kms_helper serio_raw
nvme_core syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ahci
[  119.612378]  drm libahci t10_pi vmxnet3 ata_piix libata dm_mirror
dm_region_hash dm_log dm_mod fuse
[  119.638500] CR2: ffffc9003b8d7214
[  119.639514] ---[ end trace 8177ac0f5fd1b1c0 ]---
