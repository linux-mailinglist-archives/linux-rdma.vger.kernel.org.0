Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08318582426
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 12:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiG0KYA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiG0KX7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 06:23:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3127242AF8
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 03:23:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w15so18413083lft.11
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeXcipryxPDNDL8Pukqi+uVcCL9AO8IS5xS7/yKP8oE=;
        b=G7z/EsRfRNZPVBNBlb6FG+gmTjezgwJuT7jGMT+NcvUZFWuB3fHXC8g8IqwL+Sl84d
         /Ya6+EQ7vlpakWZHyoO4Hd/n99OYx2xkLIK/Fya092Bv2EXiBYF5/4rLaYos6h9/qtNY
         iNRLnpdW+2YQWKm8LAYcn70GIDPO1ANg6L7MOsAhqG90/2wSMBbzU9LULY5GofqmMvo7
         h4nEDhdcx0FtyNojQ/veGox8oxgL+Du8yrCTqJG1XxCvrHGnJB5NI8vQthNrVUJuXwsn
         D5puHUuf7lhGQDy2llRnHL105h4YCnQugIRyCUJ+LcckIT05gw6ljRtZn+8zOVENRIA+
         Yj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeXcipryxPDNDL8Pukqi+uVcCL9AO8IS5xS7/yKP8oE=;
        b=r4MrfFBGWhD0Gd59DjvjjCJKmYrKirfUDgqRA+QDemwVjAPULb5XdFjj6FI/306Y7L
         clBGNPrin5jROzamy9kMnG/mp1mOtsSKt6oqSGuZ40PEe8stvGn5rr1tcHhE6LUGTp4S
         MhpJZU22qUcdc4loOInMc3sqW4VQBYPcx9iREL/IUvS0+ZHHEK7qNgXEbeUGYEKtlrxS
         bYdQzmjtzbXWXZSMCjSQNcGaPnwI350R6cP46P0D4XPQ61dpuZboKphE/vfD1jHrRSCV
         CCgJkBDiygQMlLICFX/8r6R47g3AIaTO8CC2fKByCI3E+m2vWllTWC4h12SuNCVDYk6r
         0Lug==
X-Gm-Message-State: AJIora+Ensc0C1QsSW7C/mmrs8Wq8uj406fUcppZeSoJ7yxbUjezdo/e
        LZcrHLUQHpZ7kOssXaYGwUihzTRkLK0D7KS8zliqjA==
X-Google-Smtp-Source: AGRyM1tvwVK2CiinaqjCp8g7FMaS3rn15/VQzhZvlaNEwR3WfN7gzw8t2dgmvoMjqNYNtLCPoNk1Ebv3KJu/olSad+I=
X-Received: by 2002:a05:6512:2f3:b0:48a:812c:14 with SMTP id
 m19-20020a05651202f300b0048a812c0014mr6873523lfq.589.1658917436478; Wed, 27
 Jul 2022 03:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220726195602.12368-1-rpearsonhpe@gmail.com>
In-Reply-To: <20220726195602.12368-1-rpearsonhpe@gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 27 Jul 2022 12:23:45 +0200
Message-ID: <CAJpMwygY-iTUO9mookqJUBZjxp0MjSYQMiu52xBQP74YLsUkJQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Cleanup rxe_init_packet()
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 26, 2022 at 9:56 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Currently rxe_init_packet() recomputes ndev from the address
> vector but struct rxe_dev already holds a reference to ndev.
>
> Cleanup rxe_init_packet to use the value of ndev in rxe and drop
> an unneeded parameter paylen since it is already carried in the
> packet info struct.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  2 +-
>  drivers/infiniband/sw/rxe/rxe_net.c  | 49 +++++++++++-----------------
>  drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c |  3 +-
>  4 files changed, 23 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index f9af30f582c6..7f98d296bc0d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -93,7 +93,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
>
>  /* rxe_net.c */
>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> -                               int paylen, struct rxe_pkt_info *pkt);
> +                               struct rxe_pkt_info *pkt);
>  int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
>                 struct sk_buff *skb);
>  int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index c53f4529f098..4a091f236dde 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -443,18 +443,22 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>         return err;
>  }
>
> +/**
> + * rxe_init_packet - allocate and initialize a new skb
> + * @rxe: rxe device
> + * @av: remote address vector
> + * @pkt: packet info
> + *
> + * Returns: an skb on success else NULL
> + */
>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> -                               int paylen, struct rxe_pkt_info *pkt)
> +                               struct rxe_pkt_info *pkt)
>  {
>         unsigned int hdr_len;
>         struct sk_buff *skb = NULL;
> -       struct net_device *ndev;
> -       const struct ib_gid_attr *attr;
> +       struct net_device *ndev = rxe->ndev;
>         const int port_num = 1;
> -
> -       attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
> -       if (IS_ERR(attr))
> -               return NULL;
> +       int skb_size;
>
>         if (av->network_type == RXE_NETWORK_TYPE_IPV4)
>                 hdr_len = ETH_HLEN + sizeof(struct udphdr) +
> @@ -463,26 +467,13 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>                 hdr_len = ETH_HLEN + sizeof(struct udphdr) +
>                         sizeof(struct ipv6hdr);
>
> -       rcu_read_lock();

Was removing this rcu lock intentional? If so, do we need a mention of
this in the commit message why its not needed anymore?

> -       ndev = rdma_read_gid_attr_ndev_rcu(attr);
> -       if (IS_ERR(ndev)) {
> -               rcu_read_unlock();
> -               goto out;
> -       }
> -       skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev),
> -                       GFP_ATOMIC);
> -
> -       if (unlikely(!skb)) {
> -               rcu_read_unlock();
> -               goto out;
> -       }
> -
> -       skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
> -
> -       /* FIXME: hold reference to this netdev until life of this skb. */
> -       skb->dev        = ndev;
> -       rcu_read_unlock();
> +       skb_size = LL_RESERVED_SPACE(ndev) + hdr_len + pkt->paylen;
> +       skb = alloc_skb(skb_size, GFP_ATOMIC);
> +       if (unlikely(!skb))
> +               return NULL;
>
> +       skb_reserve(skb, LL_RESERVED_SPACE(ndev) + hdr_len);
> +       skb->dev = ndev;
>         if (av->network_type == RXE_NETWORK_TYPE_IPV4)
>                 skb->protocol = htons(ETH_P_IP);
>         else
> @@ -490,11 +481,9 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>
>         pkt->rxe        = rxe;
>         pkt->port_num   = port_num;
> -       pkt->hdr        = skb_put(skb, paylen);
> -       pkt->mask       |= RXE_GRH_MASK;
> +       pkt->hdr        = skb_put(skb, pkt->paylen);
> +       pkt->mask      |= RXE_GRH_MASK;
>
> -out:
> -       rdma_put_gid_attr(attr);
>         return skb;
>  }
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 49e8f54db6f5..e72db960d7ea 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -397,7 +397,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
>         pkt->paylen = paylen;
>
>         /* init skb */
> -       skb = rxe_init_packet(rxe, av, paylen, pkt);
> +       skb = rxe_init_packet(rxe, av, pkt);
>         if (unlikely(!skb))
>                 return NULL;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index b36ec5c4d5e0..02a5d4ebb45e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -670,8 +670,9 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
>          */
>         pad = (-payload) & 0x3;
>         paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
> +       ack->paylen = paylen;

Maybe remove the old ack->paylen assignment which is done later in
this function?

>
> -       skb = rxe_init_packet(rxe, &qp->pri_av, paylen, ack);
> +       skb = rxe_init_packet(rxe, &qp->pri_av, ack);
>         if (!skb)
>                 return NULL;
>
> --
> 2.34.1
>
