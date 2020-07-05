Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E89214C7E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGEM7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 08:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGEM7d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 08:59:33 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14F0C061794
        for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2020 05:59:33 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w17so29349414oie.6
        for <linux-rdma@vger.kernel.org>; Sun, 05 Jul 2020 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XO5rEcYqXEpor7aOhyKa3C4GbT/s92i2SeLaRr7oZ0w=;
        b=tGeHds6t4T5wavSFDxt1FEkLzMK8UJLh2FLLvre1VuYPTEHwM6i9DcwnHOt72lA2mi
         IbdVss8W2C2weqPbk51gYhSpDgPJqIOamolOXnJxgv7Pagb6fOX+r/x8cTTNj2J//jEU
         g30TMtG60sse8bVzXmf5wJkBx+nZQkjJVQoybgRCohlTSAghY/d91UxMDRI4QXRIShMR
         StleMFn745vkWMS3VA9iFBOpVyxG8nayNnNUiGk5chrIf7sBxQ8RuzNmwhmXpz2wCPbx
         XatzAbBsYU3uaYWK5ZnoQpoFQPTUFFT+C1XQXHDSJ4Y3xG62SIwLib7KdEvjvZovYWFT
         9vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XO5rEcYqXEpor7aOhyKa3C4GbT/s92i2SeLaRr7oZ0w=;
        b=RJ78m7968waAaSfwSfmKbEq7MDFpLC2cgTVJF0nvekBhJQQ4v68bjU7S2BnC/0rxjS
         mqP9GPUQSqIsQuSX/bLrNWnfTwXHECbGZKN+7FOthQrhmzvjh/bSmlNcumIOKMtuQIq0
         Zg+GIczSf+6e+tenOibpfeIAuSHsZE0/d5/BBphoKOiDeZnM4C/4zBmGshZ17RWdsjiy
         aztqae9duEF6kRRktxj1tZoLa9peiE+/J9R+rOZ+MtOUWAIm09nOQmzxyvpGl1rMvoh0
         r84LVVzVKxxDnpTfeqKGhs/HfaDk1LaCbzpIQmXPT9jLFy/xERkwLJCwXkxXgSc8G20u
         01Uw==
X-Gm-Message-State: AOAM530NB6GFNmaU2XfHzcQqal4M+VQei1rsKKrrtjJzXFiJGxEr7loQ
        FpTFrpvj+b3RE6FPmjLTcDqmUk9OXGkDDJKF1xk=
X-Google-Smtp-Source: ABdhPJyeqhpq5ggwEbx75UYdLV9hSjnXc8OE0NP/OsgFFEzFhzwFBOvsHQWnRvDwO+0U7z97u98buR7HsO+DVcKMC2Y=
X-Received: by 2002:aca:5e06:: with SMTP id s6mr34733137oib.89.1593953972960;
 Sun, 05 Jul 2020 05:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200705104313.283034-1-kamalheib1@gmail.com> <20200705104313.283034-5-kamalheib1@gmail.com>
In-Reply-To: <20200705104313.283034-5-kamalheib1@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 5 Jul 2020 20:59:22 +0800
Message-ID: <CAD=hENcqA1b6wimN0G6oA0smv+Kyvu0ksx5Wm9_-Fh4_3W=Ciw@mail.gmail.com>
Subject: Re: [PATCH for-next v1 4/4] RDMA/rxe: Remove rxe_link_layer()
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 5, 2020 at 6:45 PM Kamal Heib <kamalheib1@gmail.com> wrote:
>
> Instead of returning IB_LINK_LAYER_ETHERNET from rxe_link_layer, return it
> directly from get_link_layer callback and remove rxe_link_layer().
>

I am fine.

Thanks a lot.
Zhu Yanjun

> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   | 1 -
>  drivers/infiniband/sw/rxe/rxe_net.c   | 5 -----
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 4 +---
>  3 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0688928cf2b1..39dc3bfa5d5d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -142,7 +142,6 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>                                 int paylen, struct rxe_pkt_info *pkt);
>  int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
> -enum rdma_link_layer rxe_link_layer(struct rxe_dev *rxe, unsigned int port_num);
>  const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
>  struct device *rxe_dma_device(struct rxe_dev *rxe);
>  int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 312c2fc961c0..0c3808611f95 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -520,11 +520,6 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num)
>         return rxe->ndev->name;
>  }
>
> -enum rdma_link_layer rxe_link_layer(struct rxe_dev *rxe, unsigned int port_num)
> -{
> -       return IB_LINK_LAYER_ETHERNET;
> -}
> -
>  int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>  {
>         int err;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index ee80b8862db8..a3cf9bbe818d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -141,9 +141,7 @@ static int rxe_modify_port(struct ib_device *dev,
>  static enum rdma_link_layer rxe_get_link_layer(struct ib_device *dev,
>                                                u8 port_num)
>  {
> -       struct rxe_dev *rxe = to_rdev(dev);
> -
> -       return rxe_link_layer(rxe, port_num);
> +       return IB_LINK_LAYER_ETHERNET;
>  }
>
>  static int rxe_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
> --
> 2.25.4
>
