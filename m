Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785333D5481
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jul 2021 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhGZHCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 03:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhGZHCS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 03:02:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8647C061757
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jul 2021 00:42:47 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 48-20020a9d0bb30000b02904cd671b911bso9247157oth.1
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jul 2021 00:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6QKJ8Q+H7JA+HnvO/PDtERgn//o8rO/ZrrLaHwBk8E4=;
        b=IyCirBsuJ5NFZa0OpNpd0zWILQcGKE6FQr2FqMDg4DspxWL+M6xScSwUovxV8ZWe1d
         DDpPChwTec90F3yZmpr3yN7zVSd8jTDZGcZKpYrLqJvQj6l+7sDBroynfDHHIbkVce71
         UogpQqKzDzsPOHX+xEcMbv73VaSKIelJq9Vj1vZBMHMUIR0r5MEdkjB8alGLwGqpgU8i
         SSV9DDxoz0gxWsA1flg/C+TZuIB9bbjuxIU4dHsGr7r6GUz6a4eI3KzICNhaOli/8Z0p
         uo+7FjBHmOtoEa0XwQkLqrUkIxSkXRenVcy0Zc7DpK91K4sem93DidcKesSYMKyAUnCs
         kUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6QKJ8Q+H7JA+HnvO/PDtERgn//o8rO/ZrrLaHwBk8E4=;
        b=tmDIZY8ZACxP8KGd4ODMTJiXFv7klPQrKsM5ogZ2mEJwTib8wWw3qIf9zfoZjWvqor
         puFI2YDuxuVB4q4fhlxSPs15qlTgyAWlYTBiedI5lXQ48Gp/C19fEma8x/UWAEjDuTLV
         IKeSbkbD30sf0xdZBhHtchuZ934EvzdmDcxxkj5A5HRHLVuy0MQ0ahPvKVqroT7voVsi
         0WohmKr8WYEWZMqmNcc/QXtOrZD2AvjILyYnHbhqzb2TYGduCrWYGWpgMjHNZ5inHEs2
         COwyjpJZNbWXNFTkerZX9etifNsozsYl4+LqM3JZPVnB6+CkgJpDbNh6hqAYed4rVdzK
         0WCQ==
X-Gm-Message-State: AOAM533mia8Zn4r2mrzkihvVPccGIbSqTLxbLiw49Bv6l7cQcG0TzOkS
        cmgX34q3fyP+6PVloiL9dSW8C2MD25NSofAFQaQ=
X-Google-Smtp-Source: ABdhPJxyPaEYgLCAcaUFa94/zqh46gBMhUMTmhFPx7msE3EM+al/0sOZXoGPDgPIlArwO8k920X1KDUYTf/rH+1J5Z4=
X-Received: by 2002:a05:6830:4104:: with SMTP id w4mr11006698ott.59.1627285367139;
 Mon, 26 Jul 2021 00:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210721214105.8099-1-rpearsonhpe@gmail.com> <CAN-5tyEkkBN49HCghKSCfPb8e_+0C2PCt8o51TOaMBS=3L7AuA@mail.gmail.com>
 <CS1PR8401MB10968C0943041FEDCBEBF8BDBCE49@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAN-5tyEVZRUyFf4bGRvL-DkoMmAXB10zQhZFB7K_UzNJ2uNWVQ@mail.gmail.com>
In-Reply-To: <CAN-5tyEVZRUyFf4bGRvL-DkoMmAXB10zQhZFB7K_UzNJ2uNWVQ@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 26 Jul 2021 15:42:35 +0800
Message-ID: <CAD=hENdqHx7FANVNFG4u-_WFmgsMBa=Mv67V3emqcO+wgwZaCQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix bug in rxe_net.c
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 11:37 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> I'm RHEL based in terms of my userland software. I work on upstream
> kernels using that.

Simply, one host with the kernel 5.14-rc1, the other host with the
kernel 5.14-rc2.
Then the following errors will appear
"
...
 [13873.255148] rdma_rxe: bad ICRC from 192.168.1.92
 [13877.567475] rdma_rxe: bad ICRC from 192.168.1.92
 [13882.175544] rdma_rxe: bad ICRC from 192.168.1.92
...
"

Correct?

Zhu Yanjun

>
> Client is running kernel version 5.14-rc1 (when I started, now rc2) on
> a  RHEL8.4 (beta, when I started) VM (RHEL8.2 VM with 5.14-rc1 kernel
> for server). RHEL8.4 beta that came with userland versions
> [aglo@localhost linux-nfs]$ rpm -qa | grep rdma
> rdma-core-devel-32.0-1.el8.x86_64
> librdmacm-utils-32.0-1.el8.x86_64
> rdma-core-32.0-1.el8.x86_64
> librdmacm-32.0-1.el8.x86_64
>
> I upgraded to RHEL8.4GA to make sure it's on an official release of
> the userspace. The results are the same (at the end of the mail).
> [root@localhost yum.repos.d]# rpm -qa | grep rdma
> rdma-core-32.0-4.el8.x86_64
> rdma-core-devel-32.0-4.el8.x86_64
> librdmacm-utils-32.0-4.el8.x86_64
> librdmacm-32.0-4.el8.x86_64
>
> Now, let's go back to NFSoRDMA so that we remove the variable of what
> version are the userland libraries (and if there are any
> interoperability issues with kernel changes and userland). Doing an
> NFS mount, leads to client logging continuously logging "bad ICRC"
> until mount fails with connection refused.
>
> Network trace has "ConnectRequest" which gets back ConnectReject
> (reason 0x001c) which I'm assuming is bad ICRC?
>
> nfs oops (that doesn't actually crash the machine which is nice) (this
> is a snippet and doesn't reflect the #of bad ICRC message in total):
> [  342.290895] rdma_rxe: bad ICRC from 192.168.1.92
> [  348.947562] rdma_rxe: bad ICRC from 192.168.1.92
> [  355.602913] rdma_rxe: invalid mask or state for qp
> [  355.606411] rdma_rxe: invalid mask or state for qp
> [  355.608928] ------------[ cut here ]------------
> [  355.610831] failed to drain recv queue: -22
> [  355.612549] WARNING: CPU: 1 PID: 516 at
> drivers/infiniband/core/verbs.c:2738 __ib_drain_rq+0x258/0x290
> [ib_core]
> [  355.616200] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
> nfs lockd grace rpcrdma rdma_ucm rdma_cm iw_cm ib_cm rdma_rxe
> ip6_udp_tunnel udp_tunnel ib_uverbs ib_core uinput nls_utf8 isofs
> rfcomm xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_counter
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> nf_tables nfnetlink tun bridge stp llc bnep vsock_loopback
> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock
> intel_rapl_msr snd_seq_midi snd_seq_midi_event intel_rapl_common
> crct10dif_pclmul crc32_pclmul vmw_balloon ghash_clmulni_intel rapl
> snd_ens1371 joydev pcspkr snd_ac97_codec ac97_bus snd_seq uvcvideo
> btusb snd_pcm videobuf2_vmalloc btrtl videobuf2_memops btbcm
> videobuf2_v4l2 btintel videobuf2_common bluetooth videodev snd_timer
> rfkill snd_rawmidi snd_seq_device mc ecdh_generic snd ecc soundcore
> vmw_vmci i2c_piix4 auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod
> cdrom sg ata_generic crc32c_intel vmwgfx ttm drm_kms_helper nvme ahci
> syscopyarea
> [  355.616399]  sysfillrect libahci sysimgblt ata_piix serio_raw
> fb_sys_fops drm nvme_core libata vmxnet3 t10_pi dm_mirror
> dm_region_hash dm_log dm_mod fuse
> [  355.648889] CPU: 1 PID: 516 Comm: kworker/u256:28 Tainted: G
> W         5.14.0-rc2+ #199
> [  355.651852] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 07/22/2020
> [  355.655245] Workqueue: xprtiod xprt_autoclose [sunrpc]
> [  355.657033] RIP: 0010:__ib_drain_rq+0x258/0x290 [ib_core]
> [  355.658808] Code: 00 00 00 48 89 ef e8 f7 a9 cc de 48 85 c0 74 e1
> e9 f6 fe ff ff 89 c6 48 c7 c7 40 09 4d c1 c6 05 0a 60 08 00 01 e8 da
> 29 c6 de <0f> 0b e9 da fe ff ff 80 3d f6 5f 08 00 00 0f 85 cd fe ff ff
> 89 c6
> [  355.665601] RSP: 0018:ffff888008cc7b48 EFLAGS: 00010286
> [  355.667435] RAX: 0000000000000000 RBX: 1ffff11001198f69 RCX: ffffffff9=
f427a3e
> [  355.669758] RDX: 1ffff1100b98cd35 RSI: 0000000000000008 RDI: ffff88805=
cc669ac
> [  355.672397] RBP: ffff88801c83c058 R08: ffffed100b98df31 R09: ffffed100=
b98df31
> [  355.675018] R10: ffff88805cc6f987 R11: ffffed100b98df30 R12: ffff88801=
312f000
> [  355.677844] R13: ffff8880183ef810 R14: ffffffffc18173c0 R15: ffff88800=
1119000
> [  355.680599] FS:  0000000000000000(0000) GS:ffff88805cc40000(0000)
> knlGS:0000000000000000
> [  355.683904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  355.686447] CR2: 00003bafb8832fd0 CR3: 00000000142e6002 CR4: 000000000=
01706e0
> [  355.689154] Call Trace:
> [  355.690157]  ? __ib_drain_sq+0x280/0x280 [ib_core]
> [  355.692013]  ? autoremove_wake_function+0x82/0xa0
> [  355.694000]  ? mutex_lock+0x8e/0xe0
> [  355.695683]  ? mutex_unlock+0x1d/0x40
> [  355.697821]  ? cma_modify_qp_err+0xa5/0xf0 [rdma_cm]
> [  355.700409]  ? rdma_unlock_handler+0x20/0x20 [rdma_cm]
> [  355.702602]  ? __update_load_avg_cfs_rq+0x5a/0x550
> [  355.704558]  ib_drain_rq+0x9f/0xb0 [ib_core]
> [  355.706253]  rpcrdma_xprt_disconnect+0xbe/0x4b0 [rpcrdma]
> [  355.708215]  xprt_rdma_close+0xe/0x50 [rpcrdma]
> [  355.709785]  xprt_autoclose+0x8b/0x160 [sunrpc]
> [  355.711810]  process_one_work+0x3ab/0x6b0
> [  355.713303]  worker_thread+0x57/0x5c0
> [  355.714477]  ? process_one_work+0x6b0/0x6b0
> [  355.715806]  kthread+0x1bf/0x1f0
> [  355.716901]  ? set_kthread_struct+0x80/0x80
> [  355.718333]  ret_from_fork+0x22/0x30
> [  355.719577] ---[ end trace dc0181bd9d91f55b ]---
> [  355.721135] rdma_rxe: invalid mask or state for qp
> [  355.723117] ------------[ cut here ]------------
>
> rping oops.
>
> [13873.255148] rdma_rxe: bad ICRC from 192.168.1.92
> [13877.567475] rdma_rxe: bad ICRC from 192.168.1.92
> [13882.175544] rdma_rxe: bad ICRC from 192.168.1.92
> [13886.784329] rdma_rxe: bad ICRC from 192.168.1.92
> [13891.391534] rdma_rxe: bad ICRC from 192.168.1.92
> [13896.000084] rdma_rxe: bad ICRC from 192.168.1.92
> [13900.608291] rdma_rxe: bad ICRC from 192.168.1.92
> [13905.219925] rdma_rxe: bad ICRC from 192.168.1.92
> [13905.222298] rdma_rxe: bad ICRC from 192.168.1.92
> [13907.392305] rdma_rxe: bad ICRC from 192.168.1.92
> [13909.569156] rdma_rxe: bad ICRC from 192.168.1.92
> [13911.744391] rdma_rxe: bad ICRC from 192.168.1.92
> [13913.921244] rdma_rxe: bad ICRC from 192.168.1.92
> [13916.097423] rdma_rxe: bad ICRC from 192.168.1.92
> [13918.272800] rdma_rxe: bad ICRC from 192.168.1.92
> [13920.449837] BUG: unable to handle page fault for address: ffffc9010378=
2194
> [13920.453440] #PF: supervisor read access in kernel mode
> [13920.455627] #PF: error_code(0x0000) - not-present page
> [13920.457585] PGD 1000067 P4D 1000067 PUD 0
> [13920.459103] Oops: 0000 [#1] SMP KASAN PTI
> [13920.460659] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
>   5.14.0-rc2+ #199
> [13920.463284] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 07/22/2020
> [13920.466820] RIP: 0010:copy_data+0x45/0x3a0 [rdma_rxe]
> [13920.468732] Code: 20 48 89 0c 24 44 89 4c 24 10 45 85 c0 0f 84 6c
> 01 00 00 48 8d 42 04 49 89 d4 45 89 c5 48 89 c7 48 89 44 24 30 e8 fb
> c0 6e ec <45> 8b 7c 24 04 44 89 7c 24 14 45 39 ef 0f 8c 08 03 00 00 49
> 8d 44
> [13920.474397] RSP: 0018:ffff88805cc092e0 EFLAGS: 00010246
> [13920.476010] RAX: 0000000000000000 RBX: ffff88800ed36520 RCX: ffffffffc=
15b4555
> [13920.478234] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffffc9010=
3782194
> [13920.480721] RBP: ffff888042fc9a48 R08: 0000000000000010 R09: 000000000=
0000000
> [13920.483235] R10: ffff888042fc9a55 R11: ffffed1001da6c01 R12: ffffc9010=
3782190
> [13920.485626] R13: 0000000000000010 R14: ffff8880172a536a R15: ffff88800=
ed36000
> [13920.488373] FS:  0000000000000000(0000) GS:ffff88805cc00000(0000)
> knlGS:0000000000000000
> [13920.491327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13920.493344] CR2: ffffc90103782194 CR3: 0000000044dac005 CR4: 000000000=
01706f0
> [13920.495705] Call Trace:
> [13920.496608]  <IRQ>
> [13920.497554]  send_data_in.isra.30+0x21/0x40 [rdma_rxe]
> [13920.499371]  rxe_responder+0x1a06/0x3e50 [rdma_rxe]
> [13920.500970]  ? fib_info_nh_uses_dev+0x6d/0x320
> [13920.502530]  ? rxe_resp_queue_pkt+0x60/0x60 [rdma_rxe]
> [13920.504183]  ? crc32_pclmul_update+0x36/0x42 [crc32_pclmul]
> [13920.505895]  ? rxe_crc32.isra.14+0x7d/0x100 [rdma_rxe]
> [13920.507485]  ? check_type_state.isra.8+0x150/0x150 [rdma_rxe]
> [13920.509248]  ? find_gid+0x166/0x210 [ib_core]
> [13920.510978]  ? _raw_spin_lock_irqsave+0x80/0xe0
> [13920.512449]  ? _raw_write_lock_irqsave+0xe0/0xe0
> [13920.513877]  ? rxe_resp_queue_pkt+0x60/0x60 [rdma_rxe]
> [13920.515506]  rxe_do_task+0xd2/0x160 [rdma_rxe]
> [13920.516881]  rxe_rcv+0x5a5/0xe30 [rdma_rxe]
> [13920.518510]  ? rxe_crc32.isra.14+0x100/0x100 [rdma_rxe]
> [13920.520297]  ? __udp4_lib_lookup+0x3fa/0x5b0
> [13920.521617]  ? ib_device_get_by_netdev+0x165/0x1b0 [ib_core]
> [13920.523403]  ? ib_unregister_driver+0x170/0x170 [ib_core]
> [13920.525327]  ? stack_access_ok+0x35/0x80
> [13920.526808]  rxe_udp_encap_recv+0xd0/0x120 [rdma_rxe]
> [13920.528541]  ? rxe_enable_task+0x20/0x20 [rdma_rxe]
> [13920.530252]  udp_queue_rcv_one_skb+0x36d/0x8a0
> [13920.531985]  udp_unicast_rcv_skb.isra.65+0x126/0x140
> [13920.533800]  __udp4_lib_rcv+0x924/0x1310
> [13920.535186]  ? udp_err+0x20/0x20
> [13920.536190]  ? is_bpf_text_address+0x13/0x20
> [13920.537554]  ? kernel_text_address+0x100/0x110
> [13920.538944]  ? __unwind_start+0x2e8/0x370
> [13920.540193]  ? raw_rcv+0x1a0/0x1a0
> [13920.541253]  ? nft_do_chain_arp+0xa0/0xa0 [nf_tables]
> [13920.542913]  ? nft_do_chain_ipv4+0xe4/0x110 [nf_tables]
> [13920.544569]  ? nf_nat_ipv4_fn+0x21/0xc0 [nf_nat]
> [13920.546109]  ip_protocol_deliver_rcu+0x170/0x2c0
> [13920.547907]  ip_local_deliver_finish+0xae/0xc0
> [13920.549598]  ip_local_deliver+0x1ae/0x1c0
> [13920.551031]  ? ip_local_deliver_finish+0xc0/0xc0
> [13920.552586]  ? ip_route_input_rcu+0x421/0x4b0
> [13920.554071]  ? ip_protocol_deliver_rcu+0x2c0/0x2c0
> [13920.555662]  ? ip_sublist_rcv+0x3c0/0x3c0
> [13920.556962]  ? ip_sublist_rcv+0x3c0/0x3c0
> [13920.558439]  ip_rcv+0x159/0x160
> [13920.559549]  ? ip_sublist_rcv+0x3c0/0x3c0
> [13920.560782]  ? secondary_startup_64_no_verify+0xc2/0xcb
> [13920.562683]  ? remove_all_stable_nodes+0x40/0x190
> [13920.564674]  ? ip_local_deliver+0x1c0/0x1c0
> [13920.566054]  ? __napi_poll+0x5d/0x1f0
> [13920.567310]  ? net_rx_action+0x21c/0x4a0
> [13920.568616]  ? __do_softirq+0xf9/0x376
> [13920.569809]  __netif_receive_skb_one_core+0x133/0x150
> [13920.571350]  ? __netif_receive_skb_core+0x1760/0x1760
> [13920.572889]  ? ip_finish_output+0xc0/0xc0
> [13920.574123]  ? _raw_spin_lock_irqsave+0x80/0xe0
> [13920.575505]  ? _raw_write_lock_irqsave+0xe0/0xe0
> [13920.576910]  ? kasan_set_track+0x1c/0x30
> [13920.578205]  netif_receive_skb+0x94/0x240
> [13920.579667]  ? __netif_receive_skb+0xa0/0xa0
> [13920.581132]  ? eth_type_trans+0x134/0x270
> [13920.582422]  ? eth_gro_receive+0x310/0x310
> [13920.583679]  ? __build_skb_around+0x10e/0x130
> [13920.585023]  ? dma_unmap_page_attrs+0x1c6/0x2d0
> [13920.586439]  vmxnet3_rq_rx_complete+0xa76/0x17b0 [vmxnet3]
> [13920.588146]  vmxnet3_poll_rx_only+0x47/0xd0 [vmxnet3]
> [13920.589693]  __napi_poll+0x5d/0x1f0
> [13920.590766]  net_rx_action+0x21c/0x4a0
> [13920.591918]  ? napi_threaded_poll+0x1c0/0x1c0
> [13920.593253]  ? vmxnet3_msix_tx+0x100/0x100 [vmxnet3]
> [13920.594792]  ? note_interrupt+0xf0/0x3a0
> [13920.596042]  ? add_interrupt_randomness+0x15f/0x2a0
> [13920.597677]  ? _raw_spin_lock+0x7a/0xd0
> [13920.598853]  ? _raw_write_lock_bh+0xe0/0xe0
> [13920.600144]  __do_softirq+0xf9/0x376
> [13920.601247]  irq_exit_rcu+0x118/0x130
> [13920.602435]  common_interrupt+0x77/0x90
> [13920.603712]  </IRQ>
> [13920.604411]  asm_common_interrupt+0x1e/0x40
> [13920.606075] RIP: 0010:acpi_idle_do_entry+0x61/0x70
> [13920.607750] Code: ef 01 00 be 08 00 00 00 48 89 df e8 89 10 54 ff
> 48 89 df e8 41 06 54 ff 48 8b 03 a8 08 75 0c eb 07 0f 00 2d 01 b1 73
> 00 fb f4 <fa> 5b c3 48 89 df 5b e9 93 f9 ff ff cc cc cc 0f 1f 44 00 00
> 41 57
> [13920.613840] RSP: 0018:ffffffffaf407d98 EFLAGS: 00000246
> [13920.615463] RAX: 0000000000004000 RBX: ffffffffaf41a400 RCX: ffffffffa=
e76014f
> [13920.617651] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffffffa=
f41a400
> [13920.619820] RBP: 0000000000000001 R08: fffffbfff5e83481 R09: fffffbfff=
5e83481
> [13920.622005] R10: ffffffffaf41a407 R11: fffffbfff5e83480 R12: ffff88800=
953a000
> [13920.624162] R13: 0000000000000001 R14: ffff88800953a004 R15: ffff88800=
46c1800
> [13920.626335]  ? acpi_idle_do_entry+0x4f/0x70
> [13920.627740]  ? acpi_idle_do_entry+0x4f/0x70
> [13920.629020]  acpi_idle_enter+0x14d/0x1c0
> [13920.630295]  cpuidle_enter_state+0xb2/0x590
> [13920.631603]  ? tick_nohz_stop_tick+0x1f0/0x2d0
> [13920.632987]  cpuidle_enter+0x3c/0x60
> [13920.634136]  do_idle+0x399/0x400
> [13920.635192]  ? arch_cpu_idle_exit+0x40/0x40
> [13920.636471]  ? do_idle+0x26d/0x400
> [13920.637517]  cpu_startup_entry+0x19/0x20
> [13920.638716]  start_kernel+0x378/0x396
> [13920.639925]  secondary_startup_64_no_verify+0xc2/0xcb
> [13920.641564] Modules linked in: rpcrdma rdma_ucm rdma_cm iw_cm ib_cm
> rdma_rxe ip6_udp_tunnel udp_tunnel ib_uverbs ib_core uinput nls_utf8
> isofs rfcomm xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat
> nft_counter nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc bnep
> vsock_loopback vmw_vsock_virtio_transport_common
> vmw_vsock_vmci_transport vsock intel_rapl_msr snd_seq_midi
> snd_seq_midi_event intel_rapl_common crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel vmw_balloon rapl pcspkr joydev snd_ens1371
> snd_ac97_codec ac97_bus btusb snd_seq uvcvideo btrtl btbcm btintel
> videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common
> bluetooth snd_pcm videodev mc snd_timer rfkill snd_rawmidi
> snd_seq_device ecdh_generic snd ecc soundcore vmw_vmci i2c_piix4
> auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg ata_generic
> crc32c_intel nvme vmwgfx ata_piix serio_raw nvme_core ttm ahci libahci
> drm_kms_helper libata syscopyarea
> [13920.641737]  sysfillrect sysimgblt fb_sys_fops vmxnet3 t10_pi drm
> dm_mirror dm_region_hash dm_log dm_mod fuse
> [13920.671747] CR2: ffffc90103782194
> [13920.674506] ---[ end trace 6ae70b2fba32e277 ]---
>
>
> On Wed, Jul 21, 2021 at 9:56 PM Pearson, Robert B
> <robert.pearson2@hpe.com> wrote:
> >
> > OK. For tomorrow. I need to know more about your setup. Which versions =
of kernel, rdma-core and what application SW you are running so I can try t=
o reproduce your results.
> >
> > Regards,
> >
> > Bob Pearson
> >
> > -----Original Message-----
> > From: Olga Kornievskaia <aglo@umich.edu>
> > Sent: Wednesday, July 21, 2021 7:31 PM
> > To: Bob Pearson <rpearsonhpe@gmail.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>; Zhu Yanjun <zyjzyj2000@gmail.com>=
; linux-rdma <linux-rdma@vger.kernel.org>
> > Subject: Re: [PATCH for-next] RDMA/rxe: Fix bug in rxe_net.c
> >
> > On Wed, Jul 21, 2021 at 5:42 PM Bob Pearson <rpearsonhpe@gmail.com> wro=
te:
> > >
> > > An earlier patch removed setting of tot_len in IPV4 headers because i=
t
> > > was also set in ip_local_out. However, this change resulted in an
> > > incorrect ICRC being computed because the tot_len field is not masked
> > > out. This patch restores that line. This fixes the bug reported by Zh=
u Yanjun.
> > > This bug would have also affected anyone using rxe.
> > >
> > > Fixes: 230bb836ee88 ("RDMA/rxe: Fix redundant call to ip_send_check")
> > > Reported_by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > > ---
> > >  drivers/infiniband/sw/rxe/rxe_net.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> > > b/drivers/infiniband/sw/rxe/rxe_net.c
> > > index dec92928a1cd..5ac27f28ace1 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > > @@ -259,6 +259,7 @@ static void prepare_ipv4_hdr(struct dst_entry
> > > *dst, struct sk_buff *skb,
> > >
> > >         iph->version    =3D       IPVERSION;
> > >         iph->ihl        =3D       sizeof(struct iphdr) >> 2;
> > > +       iph->tot_len    =3D       htons(skb->len);
> > >         iph->frag_off   =3D       df;
> > >         iph->protocol   =3D       proto;
> > >         iph->tos        =3D       tos;
> > > --
> >
> > This patch made the server crash (just like one of the other crashes I'=
ve seen and posted to the list).
> >
> > The client logs:
> >
> > [  206.437839] rdma_rxe: bad ICRC from 192.168.1.92 [  211.043978] rdma=
_rxe: bad ICRC from 192.168.1.92 [  215.652973] rdma_rxe: bad ICRC from 192=
.168.1.92
> >
> >
> > Server crash:
> >
> > [11568.440098] BUG: unable to handle page fault for address: ffffaddb21=
f61180 [11568.442923] #PF: supervisor write access in kernel mode [11568.44=
4452] #PF: error_code(0x0002) - not-present page [11568.445996] PGD 1000067=
 P4D 1000067 PUD 11b9067 PMD 0 [11568.447527] Oops: 0002 [#1] SMP PTI
> > [11568.448606] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> >   5.14.0-rc1+ #42
> > [11568.450911] Hardware name: VMware, Inc. VMware Virtual Platform/440B=
X Desktop Reference Platform, BIOS 6.00 07/22/2020 [11568.454072] RIP: 0010=
:rxe_cq_post+0x98/0x210 [rdma_rxe] [11568.455613] Code: 8b b3 48 01 00 00 4=
d 8b 48 08 41 8b 48 28 49 8d
> > b9 80 01 00 00 85 f6 0f 84 78 01 00 00 41 8b 50 34 d3 e2 48 01 fa 48 8b=
 4d 00 <48> 89 0a 48 8b 4d 08 48 89 4a 08 48 8b 4d 10 48 89 4a 10 48 8b 4d =
[11568.461093] RSP: 0018:ffffaddb004c0988 EFLAGS: 00010082 [11568.462621] R=
AX: 0000000000000246 RBX: ffff9c9137df1a00 RCX: 0000000000000000 [11568.464=
695] RDX: ffffaddb21f61180 RSI: 0000000000000001 RDI: ffffaddb05f5f180 [115=
68.466779] RBP: ffffaddb004c0a30 R08: ffff9c9123186c00 R09: ffffaddb05f5f00=
0 [11568.468902] R10: 80139a1c70550000 R11: 400000005d050000 R12: 000000000=
0000000 [11568.470977] R13: ffff9c9137df1b40 R14: ffff9c9137d50008 R15: 000=
000000000000a [11568.473050] FS:  0000000000000000(0000) GS:ffff9c917be4000=
0(0000)
> > knlGS:0000000000000000
> > [11568.475395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [11568=
.477090] CR2: ffffaddb21f61180 CR3: 0000000043476005 CR4: 00000000001706e0 =
[11568.479170] Call Trace:
> > [11568.479966]  <IRQ>
> > [11568.480683]  rxe_responder+0x612/0x2470 [rdma_rxe] [11568.482122]  r=
xe_do_task+0x89/0x100 [rdma_rxe] [11568.483427]  rxe_rcv+0x2eb/0x900 [rdma_=
rxe] [11568.484655]  ? __udp4_lib_lookup+0x2c8/0x440 [11568.486159]  rxe_ud=
p_encap_recv+0x68/0xa0 [rdma_rxe] [11568.487721]  ? rxe_enable_task+0x10/0x=
10 [rdma_rxe] [11568.489223]  udp_queue_rcv_one_skb+0x1df/0x4e0 [11568.4905=
28]  udp_unicast_rcv_skb.isra.67+0x74/0x90
> > [11568.491926]  __udp4_lib_rcv+0x555/0xb90 [11568.493053]  ip_protocol_=
deliver_rcu+0xe8/0x1b0
> > [11568.494479]  ip_local_deliver_finish+0x44/0x50 [11568.496204]  ip_lo=
cal_deliver+0xf1/0x100 [11568.497621]  ? ip_protocol_deliver_rcu+0x1b0/0x1b=
0
> > [11568.499147]  ip_rcv+0xcb/0xe0
> > [11568.500032]  __netif_receive_skb_core+0x3a2/0x1010
> > [11568.501491]  ? packet_rcv+0x40/0x4b0
> > [11568.502661]  ? select_idle_sibling+0x29/0x970 [11568.504019]  __neti=
f_receive_skb_one_core+0x3c/0xa0
> > [11568.505455]  netif_receive_skb+0x3d/0x130 [11568.506650]  vmxnet3_rq=
_rx_complete+0x5f0/0xdc0 [vmxnet3] [11568.508808]  vmxnet3_poll_rx_only+0x3=
1/0xa0 [vmxnet3] [11568.510526]  __napi_poll+0x2b/0x120 [11568.511596]  net=
_rx_action+0xe2/0x240 [11568.512678]  ? vmxnet3_msix_rx+0x4a/0x60 [vmxnet3]=
 [11568.514084]  __do_softirq+0xd9/0x2a1 [11568.515218]  irq_exit_rcu+0xba/=
0xd0 [11568.516272]  common_interrupt+0x77/0x90 [11568.517438]  </IRQ> [115=
68.518059]  asm_common_interrupt+0x1e/0x40 [11568.519291] RIP: 0010:acpi_id=
le_do_entry+0x4c/0x50 [11568.520680] Code: 08 48 8b 15 3a e3 94 01 ed c3 e9=
 5f fc ff ff 65
> > 48 8b 04 25 00 6f 01 00 48 8b 00 a8 08 75 ea eb 07 0f 00 2d 40 41 50
> > 00 fb f4 <fa> c3 cc cc 0f 1f 44 00 00 41 55 41 89 d5 41 54 49 89 f4 55
> > 53 48
> > [11568.526026] RSP: 0018:ffffaddb0009be68 EFLAGS: 00000246 [11568.52756=
9] RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffff9c917be40000 [11568=
.529627] RDX: 0000000000000001 RSI: ffffffff9dcc99c0 RDI: ffff9c917c03b464 =
[11568.531723] RBP: ffff9c9105f63400 R08: ffff9c917c03b400 R09: 00000000000=
0b0e0 [11568.533772] R10: 0000000000001e99 R11: ffff9c917be6a984 R12: fffff=
fff9dcc9a40 [11568.535918] R13: ffffffff9dcc99c0 R14: 0000000000000001 R15:=
 0000000000000000 [11568.538558]  ? sched_clock_cpu+0x9/0xa0 [11568.539706]=
  acpi_idle_enter+0x4d/0xb0 [11568.540912]  cpuidle_enter_state+0x8c/0x350 =
[11568.542164]  cpuidle_enter+0x29/0x40 [11568.543211]  do_idle+0x257/0x2a0=
 [11568.544303]  cpu_startup_entry+0x19/0x20 [11568.545455]  start_secondar=
y+0x116/0x150 [11568.546928]  secondary_startup_64_no_verify+0xc2/0xcb
> > [11568.548479] Modules linked in: rpcrdma rdma_ucm rdma_cm iw_cm ib_cm =
rdma_rxe ip6_udp_tunnel udp_tunnel ib_uverbs ib_core fuse rfcomm xt_conntra=
ck nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
> > nf_reject_ipv4 nft_counter nft_compat nf_tables nfnetlink tun bridge st=
p llc vmw_vsock_vmci_transport vsock bnep snd_seq_midi snd_seq_midi_event i=
ntel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul vmw_balloon g=
hash_clmulni_intel joydev pcspkr btusb btrtl btbcm btintel bluetooth uvcvid=
eo rfkill videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 snd_ens1371 snd=
_ac97_codec ac97_bus snd_seq videobuf2_common snd_pcm videodev mc ecdh_gene=
ric ecc snd_timer snd_rawmidi snd_seq_device snd soundcore vmw_vmci i2c_pii=
x4 auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg crc32c_intel =
ata_generic vmwgfx ttm serio_raw nvme drm_kms_helper syscopyarea sysfillrec=
t sysimgblt fb_sys_fops nvme_core t10_pi cec ata_piix ahci vmxnet3 libahci =
drm libata [11568.575542] CR2: ffffaddb21f61180 [11568.577210] ---[ end tra=
ce 8afcc89bb91d9b85 ]--- [11568.578573] RIP: 0010:rxe_cq_post+0x98/0x210 [r=
dma_rxe]
> >
> >
> >
> > > 2.30.2
> > >
