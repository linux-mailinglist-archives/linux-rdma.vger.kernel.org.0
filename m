Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31E32A80D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377903AbhCBRAw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381301AbhCBFUT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Mar 2021 00:20:19 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEA5C061788
        for <linux-rdma@vger.kernel.org>; Mon,  1 Mar 2021 21:19:38 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id f3so20744634oiw.13
        for <linux-rdma@vger.kernel.org>; Mon, 01 Mar 2021 21:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VRqzq1HeA9tJxkN7JNuFKMvbyUOOhR/3TlkU8WZUOs=;
        b=nVuMpnVlGw8w581AgoJu6dP9RBbCzs54Hp2kuKZ7CuMYjfRsE4JVpH7440EcPWAoXs
         aYXDvCaYfFoVO1gvDkTzDIov+gaaz4T9ptdXa5y69SBwp5jUsKeOPSjSeLtX8WszzFk1
         /Mt6Dbky2YfffaBbkIhfXNl4KmyMSGwagj1DXkSUdCuZnEtkC7QF7eTwmozc7lEzVtAD
         9WmxAhAgG71+/uPJZ7U94PZ4NXFfZxoLSzCgtsykG06BJPmjc7SJQfhYWKgW6A7OMROa
         7bjgtiz/7l6WsWueDwjzxLddU+7nhxhbF7nGcvSvBorF4s5qHsBK+2SsP059aeVwKL0l
         0m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VRqzq1HeA9tJxkN7JNuFKMvbyUOOhR/3TlkU8WZUOs=;
        b=RsqAolqchINxoKKVicXqj7L2kjn1tLaLgY3V5itSlPdj9i76pP8e2MQKOriqSh3zAz
         qPS5TvM9CLqy02Q9NVy4P/t7i5fSL0ieXJIY7AUjUDhzwsOw+ouVB++7Rdptj2u0/hRd
         HdftxIvZ88u0btn4rSeH+mUlpCqfNZJ7r59MhnNTf3gPSnC1LCc5De4uQC3dvlSAT1v5
         b2bNvbjc2jkyJBCwcZ5TLCod4fXsSb5ZPd00tZjYVbSdjHa4g178O6GOaTn8swqW1oDR
         UqM36BwRRLITKHfCn/QwtLjaXzhixoPags1PR8UPHMp083ESbwgkHhGaVEcFGXF5O4em
         tuEQ==
X-Gm-Message-State: AOAM5314fXAq5/dCMOm3/lL7zFd/E9n+yIwkeZMxrn0c1ycBwSATDPtD
        rSAqLR+mpGbdEC9t4xIcGU8/e/jYZa3e8xiScTQ=
X-Google-Smtp-Source: ABdhPJxgl4HzPVz6z3scNAzLTUDme7NqDKCzixqzrrblOhrmOzGICl7wtUH8/6LNXIqrm8MW6BYs5Ih4DLNtWHw/Byo=
X-Received: by 2002:aca:3a41:: with SMTP id h62mr1992082oia.89.1614662378075;
 Mon, 01 Mar 2021 21:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20210214222630.3901-1-rpearson@hpe.com>
In-Reply-To: <20210214222630.3901-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 2 Mar 2021 13:19:26 +0800
Message-ID: <CAD=hENcDYgbN9N2Wh=+83BqkXw3WwQ_UtSw2i1Ki0h1d+AsBFA@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting (again)
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 15, 2021 at 6:27 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Three errors occurred in the fix referenced below.
>
> 1) The on and off again 'if (skb)' got dropped but was really
> needed in rxe_rcv_mcast_pkt() to prevent calling ib_device_put()
> on the non-error path.
>
> 2) Extending the reference taken by rxe_get_dev_from_net() in
> rxe_udp_encap_recv() until each skb is freed was not matched by
> a reference in the loopback path resulting in underflows.
>
> 3) In rxe_comp.c the function free_pkt() did not clear skb which
> triggered a warning at done: and could possibly at exit: in
> rxe_completer(). The WARN_ONCE() calls are not required at done:
> and only in one place before going to exit.
>
> This patch fixes these errors.
>
> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c | 5 +++--
>  drivers/infiniband/sw/rxe/rxe_net.c  | 7 ++++++-
>  drivers/infiniband/sw/rxe/rxe_recv.c | 6 ++++--
>  3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index a8ac791a1bb9..13fc5a1cced1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -671,6 +671,9 @@ int rxe_completer(void *arg)
>                          * it down the road or let it expire
>                          */
>
> +                       /* warn if we did receive a packet */
> +                       WARN_ON_ONCE(skb);
> +
>                         /* there is nothing to retry in this case */
>                         if (!wqe || (wqe->state == wqe_state_posted))
>                                 goto exit;
> @@ -750,7 +753,6 @@ int rxe_completer(void *arg)
>         /* we come here if we are done with processing and want the task to
>          * exit from the loop calling us
>          */
> -       WARN_ON_ONCE(skb);
>         rxe_drop_ref(qp);
>         return -EAGAIN;
>
> @@ -758,7 +760,6 @@ int rxe_completer(void *arg)
>         /* we come here if we have processed a packet we want the task to call
>          * us again to see if there is anything else to do
>          */
> -       WARN_ON_ONCE(skb);

When I keep "WARN_ON_ONCE(skb);", others are applied into -net, then I
run "rping " command. I got the followings.
It seems that SKBs are not freed.

"
[ 4068.003830] ------------[ cut here ]------------
[ 4068.003833] WARNING: CPU: 10 PID: 4241 at
drivers/infiniband/sw/rxe//rxe_comp.c:762 rxe_completer+0x982/0xd60
[rdma_rxe]
[ 4068.003845] Modules linked in: rdma_rxe(OE) rdma_ucm rdma_cm iw_cm
ib_cm ib_uverbs ib_core dm_multipath scsi_dh_rdac scsi_dh_emc
scsi_dh_alua intel_rapl_msr intel_rapl_common isst_if_common nfit rapl
snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm snd_timer snd soundcore
joydev input_leds serio_raw mac_hid sch_fq_codel ip_tables x_tables
autofs4 btrfs blake2b_generic zstd_compress raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid hid
vmwgfx ttm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
drm_kms_helper syscopyarea sysfillrect aesni_intel sysimgblt
fb_sys_fops crypto_simd psmouse cec cryptd ahci drm e1000 i2c_piix4
libahci pata_acpi video [last unloaded: rdma_rxe]
[ 4068.003898] CPU: 10 PID: 4241 Comm: rping Kdump: loaded Tainted: G
      W  OE     5.11.0+ #1
[ 4068.003901] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[ 4068.003902] RIP: 0010:rxe_completer+0x982/0xd60 [rdma_rxe]
[ 4068.003907] Code: 8d 7f 08 e8 70 94 39 de e9 f4 f6 ff ff 39 ca b8
0e 00 00 00 ba 03 00 00 00 0f 44 c2 89 c3 e9 44 f7 ff ff 0f 0b e9 af
f9 ff ff <0f> 0b e9 23 f9 ff ff 0f 0b e9 ef f9 ff ff 49 8d 9f 30 08 00
00 48
[ 4068.003909] RSP: 0018:ffffb3d7c0bf37f0 EFLAGS: 00010286
[ 4068.003911] RAX: 0000000000000008 RBX: 000000000000000e RCX: ffffffff9fa7fee8
[ 4068.003912] RDX: 0000000000000507 RSI: ffffffff9ef6e47e RDI: ffff939ace4b0000
[ 4068.003913] RBP: ffffb3d7c0bf3850 R08: ffff939ac30f1c00 R09: 0000000000000001
[ 4068.003915] R10: ffffb3d7c0bf3888 R11: 0000000000000000 R12: ffffb3d7c0127180
[ 4068.003916] R13: ffff939ad166a728 R14: 0000000000000000 R15: ffff939ad0fd8000
[ 4068.003917] FS:  00007f1f105b4740(0000) GS:ffff939dcfc80000(0000)
knlGS:0000000000000000
[ 4068.003919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4068.003920] CR2: 00007f9bc63f7fb8 CR3: 000000010e12a002 CR4: 00000000000706e0
[ 4068.003923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4068.003924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4068.003926] Call Trace:
[ 4068.003929]  rxe_do_task+0xa7/0xf0 [rdma_rxe]
[ 4068.003934]  rxe_run_task+0x2a/0x40 [rdma_rxe]
[ 4068.003938]  rxe_comp_queue_pkt+0x48/0x50 [rdma_rxe]
[ 4068.003942]  rxe_rcv+0x339/0x860 [rdma_rxe]
[ 4068.003946]  ? prepare_ack_packet+0x1b6/0x250 [rdma_rxe]
[ 4068.003951]  rxe_loopback+0x53/0x90 [rdma_rxe]
[ 4068.003955]  send_ack+0xac/0x170 [rdma_rxe]
[ 4068.003959]  rxe_responder+0x15bf/0x2220 [rdma_rxe]
[ 4068.003964]  rxe_do_task+0xa7/0xf0 [rdma_rxe]
[ 4068.003968]  rxe_run_task+0x2a/0x40 [rdma_rxe]
[ 4068.003972]  rxe_resp_queue_pkt+0x44/0x50 [rdma_rxe]
[ 4068.003976]  rxe_rcv+0x286/0x860 [rdma_rxe]
[ 4068.003979]  ? copy_data+0xc4/0x2a0 [rdma_rxe]
[ 4068.003984]  rxe_loopback+0x53/0x90 [rdma_rxe]
[ 4068.003987]  rxe_requester+0x6ec/0x10a0 [rdma_rxe]
[ 4068.003991]  ? _raw_spin_unlock_irqrestore+0xe/0x30
[ 4068.003996]  rxe_do_task+0xa7/0xf0 [rdma_rxe]
[ 4068.004000]  rxe_run_task+0x2a/0x40 [rdma_rxe]
[ 4068.004004]  rxe_post_send+0x320/0x530 [rdma_rxe]
[ 4068.004008]  ? lookup_get_idr_uobject+0x19/0x30 [ib_uverbs]
[ 4068.004016]  ? rdma_lookup_get_uobject+0x47/0x180 [ib_uverbs]
[ 4068.004022]  ib_uverbs_post_send+0x64d/0x6e0 [ib_uverbs]
[ 4068.004028]  ? __wake_up+0x13/0x20
[ 4068.004033]  ib_uverbs_write+0x44f/0x580 [ib_uverbs]
[ 4068.004039]  vfs_write+0xb9/0x250
[ 4068.004043]  ksys_write+0xb1/0xe0
[ 4068.004045]  __x64_sys_write+0x1a/0x20
[ 4068.004048]  do_syscall_64+0x38/0x90
[ 4068.004052]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 4068.004054] RIP: 0033:0x7f1f1087f2cf
[ 4068.004056] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 fd
ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 48 89 44 24 08 e8 5c fd ff
ff 48
[ 4068.004058] RSP: 002b:00007ffd14eb1d00 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[ 4068.004060] RAX: ffffffffffffffda RBX: 00007f1f0fcd6180 RCX: 00007f1f1087f2cf
[ 4068.004061] RDX: 0000000000000020 RSI: 00007ffd14eb1d60 RDI: 0000000000000004
[ 4068.004062] RBP: 0000000000000010 R08: 0000000000000000 R09: 0000000000000027
[ 4068.004063] R10: 00000000ffffffff R11: 0000000000000293 R12: 0000000000000001
[ 4068.004064] R13: 000055ad34999e80 R14: 0000000000000000 R15: 0000000000000000
[ 4068.004066] ---[ end trace 719f4d5687d4ac94 ]---
"

>         rxe_drop_ref(qp);
>         return 0;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 36d56163afac..8e81df578552 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -406,12 +406,17 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
>
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
> index 8a48a33d587b..a5e330e3bbce 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -299,8 +299,10 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>
>  err1:
>         /* free skb if not consumed */
> -       kfree_skb(skb);
> -       ib_device_put(&rxe->ib_dev);
> +       if (unlikely(skb)) {
> +               kfree_skb(skb);
> +               ib_device_put(&rxe->ib_dev);
> +       }
>  }
>
>  /**
> --
> 2.27.0
>
