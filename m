Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132692A36DF
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 00:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgKBXAQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 18:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgKBXAP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 18:00:15 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843B7C0617A6
        for <linux-rdma@vger.kernel.org>; Mon,  2 Nov 2020 15:00:15 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id l16so16094228eds.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Nov 2020 15:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=boLbJ5VBBP+sfpvynYdjEisEY6Zkr9/+MmC2CfC3AbY=;
        b=LWVLY+16iWlfvLK3hDqoIqLRpYTi/ae0Q9zH19fPKn9p5llDWooy8pi/t1NXaB+fIo
         YtkBQPqUwBFLeCC4dlyuK7vlJfOXJZHovRbx3YjI6fgXI7IKBKzfawpgJHwj7+tTu15U
         tNiYDEqBk0fAt7iL7WSkUernmtxoT7xJDdlsq16xICxHjW66wmVkGbzrGeVhXWNgW6m2
         07F8QsZTiLBMsqstxDk7EtyU07ldHaHG/lgEH8Dx3xJmuYnzh68YG67mjB02ORO2HJbH
         bv+t4gaBCau0W1hS1epKj2ad/AusKCmTD5hI/y5M6wGn31pfzzN3bAeXQBC61jLr8Dim
         K8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=boLbJ5VBBP+sfpvynYdjEisEY6Zkr9/+MmC2CfC3AbY=;
        b=lDJPizR/fplWm0NSE9W5PvTmTtqdaSwUJc/HgkKBmxvNtm2dHFrO0KY8DN3HVLrX+5
         a24DUiX7SBzpkMug5CY+JfTbhrFBhDoL3t/oNBuQaBv/nsyWlfdTGRFP6HIjqlIW0e4Y
         8CbIy2CsaYuWth/YS8WiAI89NO9DXNQcKRl2Cx+PpGBhu9CnmEUqXptOc5fXeV6PmPp6
         A+ZfbJ6XNfLh6WmX++OfLoWtZJRXW8P8yAs9gBDnfykYNFareg+HnZJFbO2HyLCfiKQU
         0CaGgQtGcQlhJUo9nj1pT7A74c09YPyFg2wRtIni++8PaVAqa1mp/WRZ+rtHKg+rXehn
         nMRw==
X-Gm-Message-State: AOAM531/87JhVGEh+j1fZiIjiscDLkDGNRr3dQeFcvo/lqSsUAd2uJBs
        /2KSWChsHKF4bf9sEv1NAUe+5B5cLs9kXPbsSkoj+8Fr9/o=
X-Google-Smtp-Source: ABdhPJzSkFB+Ob5hObrLAk9fm+xemquMfSm46UzHIZKRe+4vb3wnb8Q0bvb/32QF90c3giRPPul21YQHwLM/dVJ3+xY=
X-Received: by 2002:a50:d84a:: with SMTP id v10mr6290238edj.84.1604358013182;
 Mon, 02 Nov 2020 15:00:13 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 2 Nov 2020 18:00:02 -0500
Message-ID: <CAN-5tyHaVyoLMOc0Qtte=Gz+UUE+HX1b3E1d9xh-RD3Uve22JA@mail.gmail.com>
Subject: Oops problem with rxe from 5.10-rc kernel
To:     linux-rdma <linux-rdma@vger.kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi folks,

Is this a known problem? I'm unable to do simple rping over Soft RoCE
starting from 5.10-rc1 kernel (5.9 works).This is an oops from running
the following. I'm also unable to do NFS-over-RDMA.

sudo rping -c -a 192.168.1.105 -v -C 3
recv_buf reg_mr failed
rping_setup_buffers failed: 22

This is the oops
Nov  2 17:49:39 localhost kernel: ------------[ cut here ]------------
Nov  2 17:49:39 localhost kernel: WARNING: CPU: 0 PID: 2613 at
kernel/dma/mapping.c:188 dma_map_sg_attrs+0x37/0x50
Nov  2 17:49:39 localhost kernel: Modules linked in: rpcsec_gss_krb5
nfsv4 dns_resolver nfs lockd grace nfs_ssc rpcrdma rdma_rxe
ip6_udp_tunnel udp_tunnel rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs
ib_core nls_utf8 isofs fuse rfcomm nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 tun
bridge stp llc ip6_tables nft_compat ip_set nf_tables nfnetlink bnep
vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event
intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul
vmw_balloon ghash_clmulni_intel joydev uvcvideo pcspkr
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 btusb btrtl btbcm
btintel videobuf2_common snd_ens1371 videodev snd_ac97_codec ac97_bus
snd_seq mc snd_pcm bluetooth rfkill ecdh_generic ecc snd_timer
snd_rawmidi snd_seq_device snd soundcore vmw_vmci i2c_piix4
auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg
crc32c_intel ata_generic serio_raw vmwgfx nvme nvme_core t10_pi
Nov  2 17:49:39 localhost kernel: drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops cec vmxnet3 ata_piix ahci libahci
ttm drm libata
Nov  2 17:49:39 localhost kernel: CPU: 0 PID: 2613 Comm: rping
Tainted: G        W         5.10.0-rc2+ #21
Nov  2 17:49:39 localhost kernel: Hardware name: VMware, Inc. VMware
Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00
02/27/2020
Nov  2 17:49:39 localhost kernel: RIP: 0010:dma_map_sg_attrs+0x37/0x50
Nov  2 17:49:39 localhost kernel: Code: 85 c0 48 0f 44 05 a9 22 e5 01
83 f9 02 77 19 48 83 bf 48 02 00 00 00 74 11 48 85 c0 75 11 e8 20 19
00 00 85 c0 78 13 c3 0f 0b <0f> 0b 31 c0 c3 48 8b 40 50 e8 7b 50 ab 00
eb e9 0f 0b 0f 1f 80 00
Nov  2 17:49:39 localhost kernel: RSP: 0018:ffffa8958297ba30 EFLAGS: 00010246
Nov  2 17:49:39 localhost kernel: RAX: ffffffff8fc23260 RBX:
000055af0b7aa000 RCX: 0000000000000000
Nov  2 17:49:39 localhost kernel: RDX: 0000000000000001 RSI:
ffff90719c4290c0 RDI: ffff9071a5b3c4e8
Nov  2 17:49:39 localhost kernel: RBP: 0000000000000000 R08:
0000000000000000 R09: 0000000000000000
Nov  2 17:49:39 localhost kernel: R10: ffffe64f807e35c0 R11:
0000000000000000 R12: ffff9071a5b3c000
Nov  2 17:49:39 localhost kernel: R13: 0000000000000000 R14:
ffff9071f14c1000 R15: ffff907199f82d00
Nov  2 17:49:39 localhost kernel: FS:  00007f869a842740(0000)
GS:ffff9071fbe00000(0000) knlGS:0000000000000000
Nov  2 17:49:39 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Nov  2 17:49:39 localhost kernel: CR2: 00007f8697eddfb8 CR3:
00000000716b6005 CR4: 00000000001706f0
Nov  2 17:49:39 localhost kernel: Call Trace:
Nov  2 17:49:39 localhost kernel: ib_umem_get+0x343/0x3b0 [ib_uverbs]
Nov  2 17:49:39 localhost kernel: rxe_mem_init_user+0x4a/0x1e0 [rdma_rxe]
Nov  2 17:49:39 localhost kernel: rxe_reg_user_mr+0x8e/0x150 [rdma_rxe]
Nov  2 17:49:39 localhost kernel: ib_uverbs_reg_mr+0x156/0x280 [ib_uverbs]
Nov  2 17:49:39 localhost kernel:
ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xcc/0x130 [ib_uverbs]
Nov  2 17:49:39 localhost kernel: ? __check_object_size+0x46/0x180
Nov  2 17:49:39 localhost kernel: ib_uverbs_run_method+0x6f6/0x7a0 [ib_uverbs]
Nov  2 17:49:39 localhost kernel: ?
ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0xd0/0xd0 [ib_uverbs]
Nov  2 17:49:39 localhost kernel: ? alloc_commit_idr_uobject+0x21/0x30
[ib_uverbs]
Nov  2 17:49:39 localhost kernel: ib_uverbs_cmd_verbs+0x195/0x360 [ib_uverbs]
Nov  2 17:49:39 localhost kernel: ib_uverbs_ioctl+0xa7/0x110 [ib_uverbs]
Nov  2 17:49:39 localhost kernel: __x64_sys_ioctl+0x84/0xc0
Nov  2 17:49:39 localhost kernel: do_syscall_64+0x33/0x40
Nov  2 17:49:39 localhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Nov  2 17:49:39 localhost kernel: RIP: 0033:0x7f8699d1087b
Nov  2 17:49:39 localhost kernel: Code: 0f 1e fa 48 8b 05 0d 96 2c 00
64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f
1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 95
2c 00 f7 d8 64 89 01 48
Nov  2 17:49:39 localhost kernel: RSP: 002b:00007ffd271e0578 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
Nov  2 17:49:39 localhost kernel: RAX: ffffffffffffffda RBX:
00007ffd271e05d0 RCX: 00007f8699d1087b
Nov  2 17:49:39 localhost kernel: RDX: 00007ffd271e05f0 RSI:
00000000c0181b01 RDI: 0000000000000004
Nov  2 17:49:39 localhost kernel: RBP: 00007ffd271e0608 R08:
0000000000000028 R09: 00007ffd271e0784
Nov  2 17:49:40 localhost kernel: R10: 00000000ffffffff R11:
0000000000000246 R12: 00007f8690005110
Nov  2 17:49:40 localhost kernel: R13: 00007ffd271e05d0 R14:
00007ffd271e0798 R15: 0000000000000001
Nov  2 17:49:40 localhost kernel: CPU: 0 PID: 2613 Comm: rping
Tainted: G        W         5.10.0-rc2+ #21
Nov  2 17:49:40 localhost kernel: Hardware name: VMware, Inc. VMware
Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00
02/27/2020
Nov  2 17:49:40 localhost kernel: Call Trace:
Nov  2 17:49:40 localhost kernel: dump_stack+0x57/0x6a
Nov  2 17:49:40 localhost kernel: __warn.cold.14+0xe/0x3d
Nov  2 17:49:40 localhost kernel: ? dma_map_sg_attrs+0x37/0x50
Nov  2 17:49:40 localhost kernel: report_bug+0xbd/0xf0
Nov  2 17:49:40 localhost kernel: handle_bug+0x44/0x80
Nov  2 17:49:40 localhost kernel: exc_invalid_op+0x13/0x60
Nov  2 17:49:40 localhost kernel: asm_exc_invalid_op+0x12/0x20
Nov  2 17:49:40 localhost kernel: RIP: 0010:dma_map_sg_attrs+0x37/0x50
Nov  2 17:49:40 localhost kernel: Code: 85 c0 48 0f 44 05 a9 22 e5 01
83 f9 02 77 19 48 83 bf 48 02 00 00 00 74 11 48 85 c0 75 11 e8 20 19
00 00 85 c0 78 13 c3 0f 0b <0f> 0b 31 c0 c3 48 8b 40 50 e8 7b 50 ab 00
eb e9 0f 0b 0f 1f 80 00
Nov  2 17:49:40 localhost kernel: RSP: 0018:ffffa8958297ba30 EFLAGS: 00010246
Nov  2 17:49:40 localhost kernel: RAX: ffffffff8fc23260 RBX:
000055af0b7aa000 RCX: 0000000000000000
Nov  2 17:49:40 localhost kernel: RDX: 0000000000000001 RSI:
ffff90719c4290c0 RDI: ffff9071a5b3c4e8
Nov  2 17:49:40 localhost kernel: RBP: 0000000000000000 R08:
0000000000000000 R09: 0000000000000000
Nov  2 17:49:40 localhost kernel: R10: ffffe64f807e35c0 R11:
0000000000000000 R12: ffff9071a5b3c000
Nov  2 17:49:40 localhost kernel: R13: 0000000000000000 R14:
ffff9071f14c1000 R15: ffff907199f82d00
Nov  2 17:49:40 localhost kernel: ib_umem_get+0x343/0x3b0 [ib_uverbs]
Nov  2 17:49:40 localhost kernel: rxe_mem_init_user+0x4a/0x1e0 [rdma_rxe]
Nov  2 17:49:40 localhost kernel: rxe_reg_user_mr+0x8e/0x150 [rdma_rxe]
Nov  2 17:49:40 localhost kernel: ib_uverbs_reg_mr+0x156/0x280 [ib_uverbs]
Nov  2 17:49:40 localhost kernel:
ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xcc/0x130 [ib_uverbs]
Nov  2 17:49:40 localhost kernel: ? __check_object_size+0x46/0x180
Nov  2 17:49:40 localhost kernel: ib_uverbs_run_method+0x6f6/0x7a0 [ib_uverbs]
Nov  2 17:49:40 localhost kernel: ?
ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0xd0/0xd0 [ib_uverbs]
Nov  2 17:49:40 localhost kernel: ? alloc_commit_idr_uobject+0x21/0x30
[ib_uverbs]
Nov  2 17:49:40 localhost kernel: ib_uverbs_cmd_verbs+0x195/0x360 [ib_uverbs]
Nov  2 17:49:40 localhost kernel: ib_uverbs_ioctl+0xa7/0x110 [ib_uverbs]
Nov  2 17:49:40 localhost kernel: __x64_sys_ioctl+0x84/0xc0
Nov  2 17:49:40 localhost kernel: do_syscall_64+0x33/0x40
Nov  2 17:49:40 localhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Nov  2 17:49:40 localhost kernel: RIP: 0033:0x7f8699d1087b
Nov  2 17:49:40 localhost kernel: Code: 0f 1e fa 48 8b 05 0d 96 2c 00
64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f
1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 95
2c 00 f7 d8 64 89 01 48
Nov  2 17:49:40 localhost kernel: RSP: 002b:00007ffd271e0578 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
Nov  2 17:49:40 localhost kernel: RAX: ffffffffffffffda RBX:
00007ffd271e05d0 RCX: 00007f8699d1087b
Nov  2 17:49:40 localhost kernel: RDX: 00007ffd271e05f0 RSI:
00000000c0181b01 RDI: 0000000000000004
Nov  2 17:49:40 localhost kernel: RBP: 00007ffd271e0608 R08:
0000000000000028 R09: 00007ffd271e0784
Nov  2 17:49:40 localhost kernel: R10: 00000000ffffffff R11:
0000000000000246 R12: 00007f8690005110
Nov  2 17:49:40 localhost kernel: R13: 00007ffd271e05d0 R14:
00007ffd271e0798 R15: 0000000000000001
Nov  2 17:49:40 localhost kernel: ---[ end trace 62d4cee803ba06f3 ]---
Nov  2 17:49:40 localhost kernel: rdma_rxe: err -12 from rxe_umem_get
