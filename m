Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B6E31B472
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Feb 2021 04:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBODrq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Feb 2021 22:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhBODrp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Feb 2021 22:47:45 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEDDC061756
        for <linux-rdma@vger.kernel.org>; Sun, 14 Feb 2021 19:47:05 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id i3so6503172oif.1
        for <linux-rdma@vger.kernel.org>; Sun, 14 Feb 2021 19:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyqWbTqa6RPmmicUNXCsXIT8lyN+mZX4oU1sw6bj9LU=;
        b=Vad/da0KIYz952KCnjE0VCNL/lCMh47/QPw8RnF9HWJ/2XvUc7q8tJQN10AAxhoKa3
         yOffwGkj3KKNCX9Mu7fNBjB1WusIvflnZo+VFaE3wYiw6jlzeoOqzvh4+TiTNVtKwyjo
         hPgIGFuumhzHIXOzAHef6dxFVbDB9SmdXNGe5vBmHSIkAmGwA9hYOlGXMo6Xu+vtmSqp
         XhH2CwzyRedVPQ4NS2m8a9sa1RxsiGYVARBmASDal28rBWRE5KQ7wLSmH6/QHK8j8Rc3
         OcX9tOiltgbSOvrwTvp1xhfjM7PC+3I0GQHkjGGtqLmpSGUJdf19mpUM4pyYNEMMIZkY
         TgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyqWbTqa6RPmmicUNXCsXIT8lyN+mZX4oU1sw6bj9LU=;
        b=rmr65/yMFESG5R0fY8lcGfTqEM0j6FjgEdTsFC+gguJrSMqHEypRbuzxPiO++tA3zK
         LJE+MZoC6JtkBhGIGwaxwXtrA0rBBHxXs2+BFb0pE0K8RiyU2IrE34Ysh1lfUeQWIMSz
         JkW3KlokMhEsb3S1imjRENLVoWdupexPnY4uG+iC7dHFDDPTYQHvl2PJqyixzMJvkj09
         84hso2REQkoey4O6YF5TU+a/0x0/1v90VwYicaLTij6UqQVtekffcHcXIVQGGe2M4csY
         h37lT2GltiZcrq9TRrUrphSFggI9I6MJP1jCswpjmZDjp/HPnE2l/0reBZ7nK/RfweSM
         l9rA==
X-Gm-Message-State: AOAM532e9OyRifaBsL+cJSxFrALq5jbjJD9TD3DLWVbfy+Vs7TNg3nou
        X5Iv49UByoZ5mfSDq7krb7IKfiVGcuGojMTkNIo=
X-Google-Smtp-Source: ABdhPJxWzm2A0xaZxf6QTL+JNK36fGoPQuma0CSI4CJGyxuZS8aHlGctenXLnPIUyqxI1azIkZfNzcxpZ+oIezxPbPc=
X-Received: by 2002:aca:3906:: with SMTP id g6mr7171176oia.169.1613360824730;
 Sun, 14 Feb 2021 19:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20210214222630.3901-1-rpearson@hpe.com>
In-Reply-To: <20210214222630.3901-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 15 Feb 2021 11:46:54 +0800
Message-ID: <CAD=hENcVD=Ev1UzNbZ_KU-Cj7ebRMRhKrJotmUHPdcod9iG3SQ@mail.gmail.com>
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

From Leon Romanovsky
"
Please don't put "if (a) kfree(a);" constructions unless you want to
deal with daily flux of patches with attempt to remove "if".
"

Zhu Yanjun

> +               kfree_skb(skb);
> +               ib_device_put(&rxe->ib_dev);
> +       }
>  }
>
>  /**
> --
> 2.27.0
>
