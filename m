Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A8C32CF2E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 10:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbhCDI7m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 03:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbhCDI7a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Mar 2021 03:59:30 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667EC061760
        for <linux-rdma@vger.kernel.org>; Thu,  4 Mar 2021 00:58:49 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q203so6283008oih.5
        for <linux-rdma@vger.kernel.org>; Thu, 04 Mar 2021 00:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJrkrKqv0jMTbTRvONzT26FMLNQ1UuSz2+PWtOaELY4=;
        b=Cj3BfMlyqAYreGklqfAOnQBT3+LmEmgUMwRxSuyy/8GFPzoTDkIOoxSdPKKLJnd+pq
         d4dhZOWjgLCO/XO1U9ShasKaCj3u2cP0f/nxoMfkQ/KdoqmCRauoSj/PbiccU6gJuAau
         s4n9xE9et7exydP3mcaYvHpd4KpNX6P0SAf5aVZzGDnqLnZdcUtf1eRr39MJtYDm0cjT
         JlREfALSygcuKwv8rwdVc/hs7ox2i3jJxpPB26QSFQmYLK1aSJo6czA/ADtuQWCU8sMm
         8+t938vV/ApHu6JvRWC7Rit1EAxx1aflDYN/ZDC/iMmb/scsBYYu3N1KhaPM2UiD5Ar5
         LjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJrkrKqv0jMTbTRvONzT26FMLNQ1UuSz2+PWtOaELY4=;
        b=T/9s1KBAG8a+T29EQB0GcHBZg8Sl04kiQ7/DA/AF3qYAB4M+nqPy4iPIKYT785/gBJ
         Hila7kxH6fIBPR3e56MyU6qTSdkGJMniYajIGKZBWzYmR5WmJj+AaCTF0dwDyaMqpelF
         P/05exXxqXxR9HO5Ho3GqU/dEZ3Dij9I59A5WHSYNuAPyPNGcRZtVGQ+lMe/D5lWxSTG
         f1icD3FhqzEefDMVnM1oHoIYYhmmoPa8x6I+3tk3uB+SsjGovTIZ6grLP+TOPl50xrkI
         6A6ocLy9p61uVp1YUzrbFw+yYBE7JoYUD4DZqIKllA48au4eT4TnVCtP3W/1alvMlpeK
         92Zg==
X-Gm-Message-State: AOAM5322ElIfpThXNzy4dg5+kYbw0QxaUF3cSd5EapDmyh+aH6hlxJ4E
        P3z7wPikmuIIHO5cHrDvcwym2Sth4etFb+hyHK0=
X-Google-Smtp-Source: ABdhPJwitCBfjJnGUx7gLKx+NBLoZxiFb2nN7M1DBDmKkDnvJDSwvuH1xlaeHdaLuC2sXTc0mE3wmYF1r79Q64Bh8Mc=
X-Received: by 2002:aca:3a41:: with SMTP id h62mr2238545oia.89.1614848329159;
 Thu, 04 Mar 2021 00:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20210303225628.2836-1-rpearson@hpe.com>
In-Reply-To: <20210303225628.2836-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 4 Mar 2021 16:58:38 +0800
Message-ID: <CAD=hENcj91eT0VBQVExPBbg9K8+NNPr6BT_B47Q9cWqUP2KEcw@mail.gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix ib_device reference counting (again)
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 4, 2021 at 7:02 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Three errors occurred in the fix referenced below.
>
> 1) rxe_rcv_mcast_pkt() dropped a reference to ib_device when
> no error occured causing an underflow on the reference counter.
> This code is cleaned up to be clearer and easier to read.
>
> 2) Extending the reference taken by rxe_get_dev_from_net() in
> rxe_udp_encap_recv() until each skb is freed was not matched by
> a reference in the loopback path resulting in underflows.
>
> 3) In rxe_comp.c the function free_pkt() did not clear skb which
> triggered a warning at done: and could possibly at exit: in
> rxe_completer(). The WARN_ONCE() calls are not actually needed.
>
> This patch fixes these errors.
>
> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
> Version 2:
> v1 of this patch incorrectly added a WARN_ON_ONCE in rxe_completer
> where it could be triggered for normal traffic. This version
> replaced that with a pr_warn located correctly.
>
> v1 of this patch placed a call to kfree_skb in an if statement
> that could trigger style warnings. This version cleans that up.
>
>  drivers/infiniband/sw/rxe/rxe_comp.c |  6 +--
>  drivers/infiniband/sw/rxe/rxe_net.c  | 10 ++++-
>  drivers/infiniband/sw/rxe/rxe_recv.c | 60 +++++++++++++++++-----------
>  3 files changed, 48 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index a8ac791a1bb9..96e5a73579f8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -672,8 +672,10 @@ int rxe_completer(void *arg)
>                          */
>
>                         /* there is nothing to retry in this case */
> -                       if (!wqe || (wqe->state == wqe_state_posted))
> +                       if (!wqe || (wqe->state == wqe_state_posted)) {
> +                               pr_warn("Retry attempted without a valid wqe\n");
>                                 goto exit;
> +                       }
>
>                         /* if we've started a retry, don't start another
>                          * retry sequence, unless this is a timeout.
> @@ -750,7 +752,6 @@ int rxe_completer(void *arg)
>         /* we come here if we are done with processing and want the task to
>          * exit from the loop calling us
>          */
> -       WARN_ON_ONCE(skb);
>         rxe_drop_ref(qp);
>         return -EAGAIN;
>
> @@ -758,7 +759,6 @@ int rxe_completer(void *arg)
>         /* we come here if we have processed a packet we want the task to call
>          * us again to see if there is anything else to do
>          */
> -       WARN_ON_ONCE(skb);

With the above line is kept, I made tests with this commit.
1. git clone  https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
2. cd rdma && git pull
3. apply this commit and with "WARN_ON_ONCE(skb);" kept
make tests with "rping ...."
The similar problem still occurs.

Zhu Yanjun
"
[  129.220472] ------------[ cut here ]------------
[  129.220475] WARNING: CPU: 11 PID: 1669 at
drivers/infiniband/sw/rxe/rxe_comp.c:763 rxe_completer+0x97f/0xd60
[rdma_rxe]
[  129.220485] Modules linked in: rdma_ucm rdma_cm iw_cm ib_cm
rdma_rxe ib_uverbs ip6_udp_tunnel udp_tunnel ib_core dm_multipath
scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common
isst_if_common nfit rapl snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm
snd_timer snd soundcore joydev input_leds mac_hid serio_raw
sch_fq_codel ip_tables x_tables autofs4 btrfs blake2b_generic
zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
hid_generic usbhid hid crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel vmwgfx ttm drm_kms_helper syscopyarea aesni_intel
sysfillrect sysimgblt fb_sys_fops crypto_simd cec cryptd psmouse drm
video ahci i2c_piix4 e1000 libahci pata_acpi
[  129.220537] CPU: 11 PID: 1669 Comm: rping Kdump: loaded Not tainted
5.12.0-rc1+ #2
[  129.220539] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[  129.220541] RIP: 0010:rxe_completer+0x97f/0xd60 [rdma_rxe]
[  129.220545] Code: 8d 7f 08 e8 e3 e8 7d cd e9 f7 f6 ff ff 39 ca b8
0e 00 00 00 ba 03 00 00 00 0f 44 c2 89 c3 e9 47 f7 ff ff 0f 0b e9 b2
f9 ff ff <0f> 0b e9 26 f9 ff ff 49 8d 9f 30 08 00 00 48 89 df e8 5b a1
e0 cd
[  129.220547] RSP: 0018:ffffb4e3c0def7f0 EFLAGS: 00010286
[  129.220549] RAX: 0000000000000008 RBX: 000000000000000e RCX: ffffffff8f07feb8
[  129.220551] RDX: 0000000000000c40 RSI: ffffffff8e56db0e RDI: ffff99b1c2834000
[  129.220552] RBP: ffffb4e3c0def850 R08: 0000000000000000 R09: 0000000000000001
[  129.220553] R10: ffffb4e3c0def888 R11: 0000000000000000 R12: ffffb4e3c0bb1180
[  129.220554] R13: ffff99b1d15f4228 R14: 0000000000000000 R15: ffff99b1c8b66000
[  129.220555] FS:  00007f306d63b740(0000) GS:ffff99b4cfcc0000(0000)
knlGS:0000000000000000
[  129.220557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  129.220558] CR2: 00007f306cd5bfb8 CR3: 000000011169a002 CR4: 00000000000706e0
[  129.220561] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  129.220562] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  129.220563] Call Trace:
[  129.220568]  rxe_do_task+0xa7/0xf0 [rdma_rxe]
[  129.220574]  rxe_run_task+0x2a/0x40 [rdma_rxe]
[  129.220578]  rxe_comp_queue_pkt+0x48/0x50 [rdma_rxe]
[  129.220582]  rxe_rcv+0x339/0x8e0 [rdma_rxe]
[  129.220586]  ? prepare_ack_packet+0x1b6/0x250 [rdma_rxe]
[  129.220590]  rxe_loopback+0x53/0x80 [rdma_rxe]
[  129.220595]  send_ack+0xac/0x170 [rdma_rxe]
[  129.220599]  rxe_responder+0x15bf/0x2220 [rdma_rxe]
[  129.220678]  rxe_do_task+0xa7/0xf0 [rdma_rxe]
[  129.220685]  rxe_run_task+0x2a/0x40 [rdma_rxe]
[  129.220689]  rxe_resp_queue_pkt+0x44/0x50 [rdma_rxe]
[  129.220693]  rxe_rcv+0x286/0x8e0 [rdma_rxe]
[  129.220697]  ? copy_data+0xc4/0x2a0 [rdma_rxe]
[  129.220701]  rxe_loopback+0x53/0x80 [rdma_rxe]
[  129.220705]  rxe_requester+0x6ec/0x10a0 [rdma_rxe]
[  129.220709]  ? _raw_spin_unlock_irqrestore+0xe/0x30
[  129.220739]  rxe_do_task+0xa7/0xf0 [rdma_rxe]
[  129.220744]  rxe_run_task+0x2a/0x40 [rdma_rxe]
[  129.220747]  rxe_post_send+0x320/0x530 [rdma_rxe]
[  129.220752]  ? lookup_get_idr_uobject+0x19/0x30 [ib_uverbs]
[  129.220761]  ? rdma_lookup_get_uobject+0x47/0x180 [ib_uverbs]
[  129.220767]  ib_uverbs_post_send+0x64d/0x6e0 [ib_uverbs]
[  129.220773]  ? __wake_up+0x13/0x20
[  129.220779]  ib_uverbs_write+0x44f/0x580 [ib_uverbs]
[  129.220785]  vfs_write+0xb9/0x250
[  129.220790]  ksys_write+0xb1/0xe0
[  129.220792]  __x64_sys_write+0x1a/0x20
[  129.220794]  do_syscall_64+0x38/0x90
[  129.220799]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  129.220801] RIP: 0033:0x7f306d9062cf
[  129.220803] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 fd
ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 48 89 44 24 08 e8 5c fd ff
ff 48
[  129.220805] RSP: 002b:00007fff81960ae0 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[  129.220807] RAX: ffffffffffffffda RBX: 00007f306cd5d180 RCX: 00007f306d9062cf
[  129.220808] RDX: 0000000000000020 RSI: 00007fff81960b40 RDI: 0000000000000004
[  129.220809] RBP: 0000000000000010 R08: 0000000000000000 R09: 0000000000000027
[  129.220810] R10: 00000000ffffffff R11: 0000000000000293 R12: 0000000000000001
[  129.220811] R13: 000055cfe2fb64a0 R14: 0000000000000000 R15: 0000000000000000
[  129.220813] ---[ end trace e6143931678defa3 ]---
"
>         rxe_drop_ref(qp);
>         return 0;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0701bd1ffd1a..01662727dca0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -407,14 +407,22 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
>         return 0;
>  }
>
> +/* fix up a send packet to match the packets
> + * received from UDP before looping them back
> + */
>  void rxe_loopback(struct sk_buff *skb)
>  {
> +       struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
> +
>         if (skb->protocol == htons(ETH_P_IP))
>                 skb_pull(skb, sizeof(struct iphdr));
>         else
>                 skb_pull(skb, sizeof(struct ipv6hdr));
>
> -       rxe_rcv(skb);
> +       if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev)))
> +               kfree_skb(skb);
> +       else
> +               rxe_rcv(skb);
>  }
>
>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 45d2f711bce2..2b2465744896 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -237,8 +237,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>         struct rxe_mc_elem *mce;
>         struct rxe_qp *qp;
>         union ib_gid dgid;
> -       struct sk_buff *per_qp_skb;
> -       struct rxe_pkt_info *per_qp_pkt;
>         int err;
>
>         if (skb->protocol == htons(ETH_P_IP))
> @@ -250,10 +248,15 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>         /* lookup mcast group corresponding to mgid, takes a ref */
>         mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
>         if (!mcg)
> -               goto err1;      /* mcast group not registered */
> +               goto drop;      /* mcast group not registered */
>
>         spin_lock_bh(&mcg->mcg_lock);
>
> +       /* this is unreliable datagram service so we let
> +        * failures to deliver a multicast packet to a
> +        * single QP happen and just move on and try
> +        * the rest of them on the list
> +        */
>         list_for_each_entry(mce, &mcg->qp_list, qp_list) {
>                 qp = mce->qp;
>
> @@ -266,39 +269,48 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>                 if (err)
>                         continue;
>
> -               /* for all but the last qp create a new clone of the
> -                * skb and pass to the qp. If an error occurs in the
> -                * checks for the last qp in the list we need to
> -                * free the skb since it hasn't been passed on to
> -                * rxe_rcv_pkt() which would free it later.
> +               /* for all but the last QP create a new clone of the
> +                * skb and pass to the QP. Pass the original skb to
> +                * the last QP in the list.
>                  */
>                 if (mce->qp_list.next != &mcg->qp_list) {
> -                       per_qp_skb = skb_clone(skb, GFP_ATOMIC);
> -                       if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
> -                               kfree_skb(per_qp_skb);
> +                       struct sk_buff *cskb;
> +                       struct rxe_pkt_info *cpkt;
> +
> +                       cskb = skb_clone(skb, GFP_ATOMIC);
> +                       if (unlikely(!cskb))
>                                 continue;
> +
> +                       if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
> +                               kfree_skb(cskb);
> +                               break;
>                         }
> +
> +                       cpkt = SKB_TO_PKT(cskb);
> +                       cpkt->qp = qp;
> +                       rxe_add_ref(qp);
> +                       rxe_rcv_pkt(cpkt, cskb);
>                 } else {
> -                       per_qp_skb = skb;
> -                       /* show we have consumed the skb */
> -                       skb = NULL;
> +                       pkt->qp = qp;
> +                       rxe_add_ref(qp);
> +                       rxe_rcv_pkt(pkt, skb);
> +                       skb = NULL;     /* mark consumed */
>                 }
> -
> -               if (unlikely(!per_qp_skb))
> -                       continue;
> -
> -               per_qp_pkt = SKB_TO_PKT(per_qp_skb);
> -               per_qp_pkt->qp = qp;
> -               rxe_add_ref(qp);
> -               rxe_rcv_pkt(per_qp_pkt, per_qp_skb);
>         }
>
>         spin_unlock_bh(&mcg->mcg_lock);
>
>         rxe_drop_ref(mcg);      /* drop ref from rxe_pool_get_key. */
>
> -err1:
> -       /* free skb if not consumed */
> +       if (likely(!skb))
> +               return;
> +
> +       /* Fall through to drop packet
> +        * This only occurs if one of the checks fails on the last
> +        * QP in the list above
> +        */
> +
> +drop:
>         kfree_skb(skb);
>         ib_device_put(&rxe->ib_dev);
>  }
> --
> 2.27.0
>
