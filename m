Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB93D1ABC
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 02:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhGUXvC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 19:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhGUXvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 19:51:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB7CC061575
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 17:31:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x17so4628966edd.12
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXkGvui0Af4mRGlbbdwnfnaqueAl315nK8XXNKVzW6E=;
        b=nodwrm33muIDGr7Hbhnd3FnBvMxJOOFyxU5beKQ4N1DlSbAORnmr0qxl85+m+lruX4
         d79I6dINn1vL6xOGUQL/8cVr4iXI+REgZOFT4qmJUQcllzEcs5nrN/PMCVDW+Gh5+Omz
         Qg6cObPkNUHbCUPwnX0/Gu1U36lQ7dtrlox5N6u3Tlr/lrh3N5Fl8bFewsRPMMHYob1P
         Eb0ed4jVYWQ/TbaP5HREJAp3J/94YUF3ZzDj89p082hHyozJFOCWxgo9INSB3cfnwsrt
         uKmKz1wKCxiPWQn1CMXXrbve4nVM3rCJBEJsMmWvB8GeBjBoSbLx4A1/g3vMovvy+TUN
         6GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXkGvui0Af4mRGlbbdwnfnaqueAl315nK8XXNKVzW6E=;
        b=lqrTacoe5u6l9zMQdhb97zU4FnFir7qrIAZUjBmFxNIM8rBOb1JJ25MwQ5hj7/jxp1
         FjWeu1vG0EfzyHXSgUesZHj5fGc4LsL3qKGkphOyA+uhBxH/3HobusZJdmzS4f7allUN
         /YiK3T5Rt78Br3N32i4kx4DnV5GjnT0U3QlK8KZXO0BYChqsS9RPhxLWj3iqTWXB7twx
         ro2rIZMa9P4ND+8U7bJrc1f4WCB14rxoeQ55wz3Ee8sYvNvzbQ2nHPns82R083ich7zF
         dhfoZJqX1vkAWBIGq39KeQRWCGgdIeG9WFobgl/NVb8zCzZnIHoVJpcSRSBUxMFCWKtJ
         XAtg==
X-Gm-Message-State: AOAM532Qu+k1oJRar5/+bdFKWKn6efPzr7mdT5bm1msCUxNb/krFH0aV
        W9M3moDTrzE4hAZwK9CVtik9QPn9YzdlXCPUl8Q=
X-Google-Smtp-Source: ABdhPJw56oq3mMQ4U5IM7aldxuwEg63cyngEQR7nBbDqV4/5RqkhqtShxfpM0khg7uI6UXo5Mx1U+4ZONuKglNbPEYw=
X-Received: by 2002:a05:6402:1c19:: with SMTP id ck25mr51585201edb.128.1626913896957;
 Wed, 21 Jul 2021 17:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210721214105.8099-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210721214105.8099-1-rpearsonhpe@gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 21 Jul 2021 20:31:25 -0400
Message-ID: <CAN-5tyEkkBN49HCghKSCfPb8e_+0C2PCt8o51TOaMBS=3L7AuA@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix bug in rxe_net.c
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 5:42 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> An earlier patch removed setting of tot_len in IPV4 headers because it
> was also set in ip_local_out. However, this change resulted in an incorrect
> ICRC being computed because the tot_len field is not masked out. This
> patch restores that line. This fixes the bug reported by Zhu Yanjun.
> This bug would have also affected anyone using rxe.
>
> Fixes: 230bb836ee88 ("RDMA/rxe: Fix redundant call to ip_send_check")
> Reported_by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index dec92928a1cd..5ac27f28ace1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -259,6 +259,7 @@ static void prepare_ipv4_hdr(struct dst_entry *dst, struct sk_buff *skb,
>
>         iph->version    =       IPVERSION;
>         iph->ihl        =       sizeof(struct iphdr) >> 2;
> +       iph->tot_len    =       htons(skb->len);
>         iph->frag_off   =       df;
>         iph->protocol   =       proto;
>         iph->tos        =       tos;
> --

This patch made the server crash (just like one of the other crashes
I've seen and posted to the list).

The client logs:

[  206.437839] rdma_rxe: bad ICRC from 192.168.1.92
[  211.043978] rdma_rxe: bad ICRC from 192.168.1.92
[  215.652973] rdma_rxe: bad ICRC from 192.168.1.92


Server crash:

[11568.440098] BUG: unable to handle page fault for address: ffffaddb21f61180
[11568.442923] #PF: supervisor write access in kernel mode
[11568.444452] #PF: error_code(0x0002) - not-present page
[11568.445996] PGD 1000067 P4D 1000067 PUD 11b9067 PMD 0
[11568.447527] Oops: 0002 [#1] SMP PTI
[11568.448606] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
  5.14.0-rc1+ #42
[11568.450911] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 07/22/2020
[11568.454072] RIP: 0010:rxe_cq_post+0x98/0x210 [rdma_rxe]
[11568.455613] Code: 8b b3 48 01 00 00 4d 8b 48 08 41 8b 48 28 49 8d
b9 80 01 00 00 85 f6 0f 84 78 01 00 00 41 8b 50 34 d3 e2 48 01 fa 48
8b 4d 00 <48> 89 0a 48 8b 4d 08 48 89 4a 08 48 8b 4d 10 48 89 4a 10 48
8b 4d
[11568.461093] RSP: 0018:ffffaddb004c0988 EFLAGS: 00010082
[11568.462621] RAX: 0000000000000246 RBX: ffff9c9137df1a00 RCX: 0000000000000000
[11568.464695] RDX: ffffaddb21f61180 RSI: 0000000000000001 RDI: ffffaddb05f5f180
[11568.466779] RBP: ffffaddb004c0a30 R08: ffff9c9123186c00 R09: ffffaddb05f5f000
[11568.468902] R10: 80139a1c70550000 R11: 400000005d050000 R12: 0000000000000000
[11568.470977] R13: ffff9c9137df1b40 R14: ffff9c9137d50008 R15: 000000000000000a
[11568.473050] FS:  0000000000000000(0000) GS:ffff9c917be40000(0000)
knlGS:0000000000000000
[11568.475395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11568.477090] CR2: ffffaddb21f61180 CR3: 0000000043476005 CR4: 00000000001706e0
[11568.479170] Call Trace:
[11568.479966]  <IRQ>
[11568.480683]  rxe_responder+0x612/0x2470 [rdma_rxe]
[11568.482122]  rxe_do_task+0x89/0x100 [rdma_rxe]
[11568.483427]  rxe_rcv+0x2eb/0x900 [rdma_rxe]
[11568.484655]  ? __udp4_lib_lookup+0x2c8/0x440
[11568.486159]  rxe_udp_encap_recv+0x68/0xa0 [rdma_rxe]
[11568.487721]  ? rxe_enable_task+0x10/0x10 [rdma_rxe]
[11568.489223]  udp_queue_rcv_one_skb+0x1df/0x4e0
[11568.490528]  udp_unicast_rcv_skb.isra.67+0x74/0x90
[11568.491926]  __udp4_lib_rcv+0x555/0xb90
[11568.493053]  ip_protocol_deliver_rcu+0xe8/0x1b0
[11568.494479]  ip_local_deliver_finish+0x44/0x50
[11568.496204]  ip_local_deliver+0xf1/0x100
[11568.497621]  ? ip_protocol_deliver_rcu+0x1b0/0x1b0
[11568.499147]  ip_rcv+0xcb/0xe0
[11568.500032]  __netif_receive_skb_core+0x3a2/0x1010
[11568.501491]  ? packet_rcv+0x40/0x4b0
[11568.502661]  ? select_idle_sibling+0x29/0x970
[11568.504019]  __netif_receive_skb_one_core+0x3c/0xa0
[11568.505455]  netif_receive_skb+0x3d/0x130
[11568.506650]  vmxnet3_rq_rx_complete+0x5f0/0xdc0 [vmxnet3]
[11568.508808]  vmxnet3_poll_rx_only+0x31/0xa0 [vmxnet3]
[11568.510526]  __napi_poll+0x2b/0x120
[11568.511596]  net_rx_action+0xe2/0x240
[11568.512678]  ? vmxnet3_msix_rx+0x4a/0x60 [vmxnet3]
[11568.514084]  __do_softirq+0xd9/0x2a1
[11568.515218]  irq_exit_rcu+0xba/0xd0
[11568.516272]  common_interrupt+0x77/0x90
[11568.517438]  </IRQ>
[11568.518059]  asm_common_interrupt+0x1e/0x40
[11568.519291] RIP: 0010:acpi_idle_do_entry+0x4c/0x50
[11568.520680] Code: 08 48 8b 15 3a e3 94 01 ed c3 e9 5f fc ff ff 65
48 8b 04 25 00 6f 01 00 48 8b 00 a8 08 75 ea eb 07 0f 00 2d 40 41 50
00 fb f4 <fa> c3 cc cc 0f 1f 44 00 00 41 55 41 89 d5 41 54 49 89 f4 55
53 48
[11568.526026] RSP: 0018:ffffaddb0009be68 EFLAGS: 00000246
[11568.527569] RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffff9c917be40000
[11568.529627] RDX: 0000000000000001 RSI: ffffffff9dcc99c0 RDI: ffff9c917c03b464
[11568.531723] RBP: ffff9c9105f63400 R08: ffff9c917c03b400 R09: 000000000000b0e0
[11568.533772] R10: 0000000000001e99 R11: ffff9c917be6a984 R12: ffffffff9dcc9a40
[11568.535918] R13: ffffffff9dcc99c0 R14: 0000000000000001 R15: 0000000000000000
[11568.538558]  ? sched_clock_cpu+0x9/0xa0
[11568.539706]  acpi_idle_enter+0x4d/0xb0
[11568.540912]  cpuidle_enter_state+0x8c/0x350
[11568.542164]  cpuidle_enter+0x29/0x40
[11568.543211]  do_idle+0x257/0x2a0
[11568.544303]  cpu_startup_entry+0x19/0x20
[11568.545455]  start_secondary+0x116/0x150
[11568.546928]  secondary_startup_64_no_verify+0xc2/0xcb
[11568.548479] Modules linked in: rpcrdma rdma_ucm rdma_cm iw_cm ib_cm
rdma_rxe ip6_udp_tunnel udp_tunnel ib_uverbs ib_core fuse rfcomm
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
nf_reject_ipv4 nft_counter nft_compat nf_tables nfnetlink tun bridge
stp llc vmw_vsock_vmci_transport vsock bnep snd_seq_midi
snd_seq_midi_event intel_rapl_msr intel_rapl_common crct10dif_pclmul
crc32_pclmul vmw_balloon ghash_clmulni_intel joydev pcspkr btusb btrtl
btbcm btintel bluetooth uvcvideo rfkill videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 snd_ens1371 snd_ac97_codec ac97_bus
snd_seq videobuf2_common snd_pcm videodev mc ecdh_generic ecc
snd_timer snd_rawmidi snd_seq_device snd soundcore vmw_vmci i2c_piix4
auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg
crc32c_intel ata_generic vmwgfx ttm serio_raw nvme drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops nvme_core t10_pi cec
ata_piix ahci vmxnet3 libahci drm libata
[11568.575542] CR2: ffffaddb21f61180
[11568.577210] ---[ end trace 8afcc89bb91d9b85 ]---
[11568.578573] RIP: 0010:rxe_cq_post+0x98/0x210 [rdma_rxe]



> 2.30.2
>
