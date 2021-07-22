Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA22F3D1AB2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 02:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhGUXo5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 19:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGUXo5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 19:44:57 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAD1C061575
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 17:25:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qa36so5831065ejc.10
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 17:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HmRm0qNBEZ28U/+eGzZ3hMzOKuU1OJBSWYLp0l2YRT0=;
        b=BPfiMpj4si5oU2a9lFyAnuIxV2JE1eWYgLIKzk2JEBvq1itas8GY6tA9PvJD4O6gWJ
         iaP70wNPylqwjQ10F2yeJnJpvdk/ExA+G+6GhGuWRxKLd3SeKgQVdq4HAXfmyth9M3Kt
         JAE211wZ8ZZ7VsUahdNigM6xeg0wyvUZlmuFByIbNOBnRe8sJpFH3t8fTUFBxTj+j7rN
         6A7x/41Hb5ws8T15sJ1RDqkAeC/Rm2ajgYreFNgGIVg3qMHRGOK7vFnQVmt9BmermpKS
         kGJt0hbusY01HfdEIwdIG2CqbN0ydpCSEvD5cGJxCjvTrU1569Sq+iEv4lV/VmHP5XWI
         KyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HmRm0qNBEZ28U/+eGzZ3hMzOKuU1OJBSWYLp0l2YRT0=;
        b=BBafcKB1uOC+Tu7uP6Av02waEYtaCh7lKq4Z95dUa+zDVO8LRigAiM7kRWluZcSrG/
         i29p44VecI1sQdAOAqi6+9z+7a2oliJa7axFd8JluV+8Q6yOK+ba2X18RKEeE4MeBPKV
         q4kDIYl2sAYrNol1jexhto2j7ZwJaVWYtr1GjjB+sJUpB91sfwvVRriXOuICst4SWvnc
         MkLynjq8NRaUFfA26883krI2RoLxM6XVKSOYYdCrCqYUA+CUI/q+3Dy97A8et7bwtWdk
         Ue+XMHDUsqP4X1tVgPJhYMUTNKzuP3f6U0aQa4M62QCy45r1WI4zy33V618+mI4ElkAF
         r4fA==
X-Gm-Message-State: AOAM5316x4asjf0QSIdcdOP8VXy3V19yva8fX0Ut15ynn5C8wDbXi+ir
        IPyw4iWPdqP8APKJOfLEvqDfErryPQKMJVT22Ms=
X-Google-Smtp-Source: ABdhPJykPy2v5t7ZR1CV3dLmfjunfUHXptWi5Gm7rPfFFij9H5xef9dQm4ij/aDOOanGmTmR/cHJQBlmITceyzLon60=
X-Received: by 2002:a17:906:f0d8:: with SMTP id dk24mr41587396ejb.432.1626913531342;
 Wed, 21 Jul 2021 17:25:31 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 21 Jul 2021 20:25:20 -0400
Message-ID: <CAN-5tyErGH=2fCa4R6R+fncoB1y+BP6HY9JEaPzvL7Wy3Di8vQ@mail.gmail.com>
Subject: crash at commit 205be5dc9984b67a3b388cbdaa27a2f2644a4bd6 running
 rping using rxe
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
205be5dc9984b67a3b388cbdaa27a2f2644a4bd6 against an rping server
(5.14-rc1 but it doesn't matter). I see the following kernel crash on
the client machine:

[  121.164440] BUG: unable to handle page fault for address: ffffc90102178180
[  121.166944] #PF: supervisor read access in kernel mode
[  121.168573] #PF: error_code(0x0000) - not-present page
[  121.170233] PGD 1000067 P4D 1000067 PUD 0
[  121.171578] Oops: 0000 [#1] SMP KASAN PTI
[  121.172751] CPU: 0 PID: 2747 Comm: rping Not tainted 5.13.0-rc1+ #198
[  121.174580] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 07/22/2020
[  121.177486] RIP: 0010:rxe_responder+0x1cd6/0x3cb0 [rdma_rxe]
[  121.179162] Code: 49 8d be 08 01 00 00 44 89 ac 24 e0 01 00 00 e8
a0 0b b4 c6 41 8b 86 08 01 00 00 48 89 ef 89 84 24 f4 01 00 00 e8 ca
0c b4 c6 <48> 8b 45 00 48 89 84 24 d8 01 00 00 45 85 ed 0f 85 ba e9 ff
ff 49
[  121.184367] RSP: 0018:ffff888059609c68 EFLAGS: 00010246
[  121.185891] RAX: 0000000000000000 RBX: ffff8880213fa520 RCX: ffffffffc1957456
[  121.188019] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffffc90102178180
[  121.190186] RBP: ffffc90102178180 R08: ffffed100b2c13d1 R09: 0000000000000000
[  121.192337] R10: ffff888059609e40 R11: ffffed100b2c13d0 R12: 0000000000000000
[  121.194276] R13: 0000000000000005 R14: ffff8880213fa000 R15: ffff888018a30000
[  121.196361] FS:  00007f507c79e700(0000) GS:ffff888059600000(0000)
knlGS:0000000000000000
[  121.198597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  121.200192] CR2: ffffc90102178180 CR3: 000000000ce3a004 CR4: 00000000001706f0
[  121.202167] Call Trace:
[  121.202901]  <IRQ>
[  121.203500]  ? update_curr+0x74/0x2c0
[  121.204722]  ? wakeup_preempt_entity.isra.60+0x18/0x70
[  121.206150]  ? rxe_resp_queue_pkt+0x60/0x60 [rdma_rxe]
[  121.207593]  ? check_preempt_curr+0xae/0x110
[  121.208833]  ? ttwu_do_wakeup+0xae/0x220
[  121.209942]  ? try_to_wake_up+0x341/0x840
[  121.211039]  ? rb_insert_color+0x2e/0x360
[  121.212389]  ? _raw_spin_lock_irq+0x7b/0xd0
[  121.213608]  ? _raw_read_unlock_irqrestore+0x30/0x30
[  121.214983]  ? _raw_write_lock_irqsave+0xe0/0xe0
[  121.216235]  ? __wake_up_bit+0x81/0xe0
[  121.217321]  ? wake_bit_function+0xb0/0xb0
[  121.218437]  ? rxe_resp_queue_pkt+0x60/0x60 [rdma_rxe]
[  121.220011]  rxe_do_task+0xd2/0x160 [rdma_rxe]
[  121.221290]  tasklet_action_common.isra.16+0x142/0x1f0
[  121.222804]  __do_softirq+0xf9/0x38b
[  121.223797]  irq_exit_rcu+0x13d/0x150
[  121.224798]  sysvec_apic_timer_interrupt+0x66/0x80
[  121.226136]  </IRQ>
[  121.226754]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  121.228240] RIP: 0010:n_tty_write+0x14a/0x770
[  121.229450] Code: 48 e8 0a f5 5f 00 4c 89 f7 e8 d2 df ff ff 49 8d
86 00 02 00 00 48 89 c7 48 8d b4 24 90 00 00 00 48 89 44 24 68 e8 b6
2d 86 ff <49> 8d 86 f0 01 00 00 4c 8b 7c 24 58 48 89 44 24 50 49 8d 86
10 01
[  121.234361] RSP: 0018:ffff888025c6fb68 EFLAGS: 00000206
[  121.235920] RAX: 0000000000000000 RBX: ffff88801a829800 RCX: ffffffff881a716e
[  121.237892] RDX: dffffc0000000000 RSI: 0000000000000246 RDI: ffff88801a829a00
[  121.239807] RBP: 000000000000002a R08: 0000000000000004 R09: ffffed1004b8df59
[  121.192337] R10: ffff888059609e40 R11: ffffed100b2c13d0 R12: 0000000000000000
[  121.194276] R13: 0000000000000005 R14: ffff8880213fa000 R15: ffff888018a30000
[  121.196361] FS:  00007f507c79e700(0000) GS:ffff888059600000(0000)
knlGS:0000000000000000
[  121.198597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  121.200192] CR2: ffffc90102178180 CR3: 000000000ce3a004 CR4: 00000000001706f0
[  121.202167] Call Trace:
[  121.202901]  <IRQ>
[  121.203500]  ? update_curr+0x74/0x2c0
[  121.204722]  ? wakeup_preempt_entity.isra.60+0x18/0x70
[  121.206150]  ? rxe_resp_queue_pkt+0x60/0x60 [rdma_rxe]
[  121.207593]  ? check_preempt_curr+0xae/0x110
[  121.208833]  ? ttwu_do_wakeup+0xae/0x220
[  121.209942]  ? try_to_wake_up+0x341/0x840
[  121.211039]  ? rb_insert_color+0x2e/0x360
[  121.212389]  ? _raw_spin_lock_irq+0x7b/0xd0
[  121.213608]  ? _raw_read_unlock_irqrestore+0x30/0x30
[  121.214983]  ? _raw_write_lock_irqsave+0xe0/0xe0
[  121.216235]  ? __wake_up_bit+0x81/0xe0
[  121.217321]  ? wake_bit_function+0xb0/0xb0
[  121.218437]  ? rxe_resp_queue_pkt+0x60/0x60 [rdma_rxe]
[  121.220011]  rxe_do_task+0xd2/0x160 [rdma_rxe]
[  121.221290]  tasklet_action_common.isra.16+0x142/0x1f0
[  121.222804]  __do_softirq+0xf9/0x38b
[  121.223797]  irq_exit_rcu+0x13d/0x150
[  121.224798]  sysvec_apic_timer_interrupt+0x66/0x80
[  121.226136]  </IRQ>
[  121.226754]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  121.228240] RIP: 0010:n_tty_write+0x14a/0x770
[  121.229450] Code: 48 e8 0a f5 5f 00 4c 89 f7 e8 d2 df ff ff 49 8d
86 00 02 00 00 48 89 c7 48 8d b4 24 90 00 00 00 48 89 44 24 68 e8 b6
2d 86 ff <49> 8d 86 f0 01 00 00 4c 8b 7c 24 58 48 89 44 24 50 49 8d 86
10 01
[  121.234361] RSP: 0018:ffff888025c6fb68 EFLAGS: 00000206
[  121.235920] RAX: 0000000000000000 RBX: ffff88801a829800 RCX: ffffffff881a716e
[  121.237892] RDX: dffffc0000000000 RSI: 0000000000000246 RDI: ffff88801a829a00
[  121.239807] RBP: 000000000000002a R08: 0000000000000004 R09: ffffed1004b8df59
[  121.241772] R10: 0000000000000003 R11: ffffed1004b8df59 R12: ffff888008ab3280
[  121.243744] R13: 000000000000002a R14: ffff88801a829800 R15: ffff888025c6fd68
[  121.245822]  ? add_wait_queue+0xde/0x110
[  121.246919]  ? n_tty_write+0x14a/0x770
[  121.248003]  ? _copy_from_iter+0x1e8/0x8e0
[  121.249220]  ? mem_cgroup_oom_trylock+0x100/0x100
[  121.250691]  ? n_tty_read+0x920/0x920
[  121.251828]  ? prepare_to_wait_exclusive+0x170/0x170
[  121.253439]  ? __virt_addr_valid+0xc1/0x140
[  121.254731]  ? __check_object_size+0x178/0x220
[  121.256100]  file_tty_write.isra.27+0x2d1/0x4d0
[  121.258183]  ? n_tty_read+0x920/0x920
[  121.259655]  new_sync_write+0x256/0x380
[  121.260940]  ? new_sync_read+0x370/0x370
[  121.262247]  ? __handle_mm_fault+0x149c/0x1b90
[  121.264258]  ? __cond_resched+0x15/0x30
[  121.265910]  ? __inode_security_revalidate+0x49/0x80
[  121.267544]  vfs_write+0x237/0x340
[  121.268691]  ksys_write+0xb4/0x150
[  121.269866]  ? __ia32_sys_read+0x50/0x50
[  121.271159]  ? ktime_get_coarse_real_ts64+0x51/0x70
[  121.272849]  do_syscall_64+0x3c/0x80
[  121.274388]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  121.276795] RIP: 0033:0x7f507e7df11f
[  121.278043] Code: 00 00 00 41 54 49 89 d4 55 48 89 f5 53 89 fb 48
83 ec 10 e8 03 3d f9 ff 4c 89 e2 48 89 ee 89 df 41 89 c0 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 3c 3d f9
ff 48
[  121.288548] RSP: 002b:00007f507c79b5f0 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[  121.291366] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f507e7df11f
[  121.293507] RDX: 000000000000002a RSI: 00007f507c79b7f0 RDI: 0000000000000002
[  121.295783] RBP: 00007f507c79b7f0 R08: 0000000000000000 R09: 00007f507c79b687
[  121.297919] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000002a
[  121.299904] R13: 000000000000002a R14: 00007f507eaaa880 R15: 000000000000002a
[  121.304015] Modules linked in: rpcrdma rdma_ucm rdma_cm iw_cm ib_cm
rdma_rxe ip6_udp_tunnel udp_tunnel ib_uverbs ib_core uinput nls_utf8
isofs rfcomm xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat
nft_counter nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc bnep
vsock_loopback vmw_vsock_virtio_transport_common
vmw_vsock_vmci_transport vsock intel_rapl_msr snd_seq_midi
snd_seq_midi_event intel_rapl_common crct10dif_pclmul crc32_pclmul
vmw_balloon ghash_clmulni_intel rapl joydev pcspkr snd_ens1371
snd_ac97_codec ac97_bus btusb snd_seq btrtl btbcm uvcvideo snd_pcm
btintel videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
videobuf2_common bluetooth videodev snd_timer mc snd_rawmidi rfkill
snd_seq_device ecdh_generic snd ecc vmw_vmci soundcore i2c_piix4
auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg vmwgfx
ata_generic drm_kms_helper crc32c_intel syscopyarea sysfillrect
sysimgblt fb_sys_fops ttm drm serio_raw ata_piix nvme
[  121.304178]  ahci libahci nvme_core vmxnet3 t10_pi libata dm_mirror
dm_region_hash dm_log dm_mod fuse
[  121.335160] CR2: ffffc90102178180
[  121.336361] ---[ end trace 1598260a1e066047 ]---
[  121.337643] RIP: 0010:rxe_responder+0x1cd6/0x3cb0 [rdma_rxe]
