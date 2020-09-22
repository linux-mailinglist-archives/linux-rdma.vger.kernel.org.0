Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB882741DC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIVMOZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 08:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgIVMOZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 08:14:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A709C061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 05:14:25 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n2so20781603oij.1
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 05:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/8bmP6FchAvN0yq+1cTD38v5/7nTLM0su9L9VKliIg=;
        b=BqRAzkvdUNf6YMxSJwS11kJQY6N4QfcIioh1OYAopEPonyBZ/L8lvZSwWjIHCB6qPc
         FxYlDQFAEvVVJDc47byKzKkC+FBfbKN1XT2aVua3+9mD2hytOx4X20yF/LDktel8U/C3
         nGgbg4XHc9Hj3bTmi1eqPIq2hvpPla1St7A8YR0CP7Jq04Db/JVxQWK3zRObRiTb3ffm
         yKrYa/iw/bReARoI6qXBJea8khyXtqjFoqdIBGlLCNBP8fTmZ0OQjMomkUcjlrUcTW6D
         DocmNqOXwkDU52lZ7gR9loQ5zDOsv6i7u2LZoT+5jflkMDVU7re1FqNk7P25vcj2yExi
         esrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/8bmP6FchAvN0yq+1cTD38v5/7nTLM0su9L9VKliIg=;
        b=OVWDoUwCLd5JJsHbni4CZGOOKpa/uoUrRoBh8AqmvZbAXg3JNPEXbQIF/M0XDyPigD
         +Qo0eYlybVs1hNqR+9PFfiVhaMQD26OlA5Qgbk1y0GT15F3SqGnHLmnKfKZ6GPyDX4xU
         9amRS7LpNy85KPMGP4tRoyTTeUiUPBZnF2phIkFaoiGzjw0PmemQkb61eijGqP+n0/Pc
         MRKrkas5r6CvszOw3js0U9uEYfhQDHbFTjG0o0YEtebUTnHsWlLHcnBIIoEhtTWLoeth
         AMM4ZNpbKcq1V4aneg5dRY5tlvbRAs46FP4D4VOuQMsl+Gys1mRgnz699p09lbSLMJLj
         gCqQ==
X-Gm-Message-State: AOAM531gCqTTzfoQBSuxfy5EaWMYmamtFADlxeiaX5+drm0/NIA47gtB
        UuO1u3jf3ej0jvPzrdzymufJOFdkCT5BX79itoM=
X-Google-Smtp-Source: ABdhPJz80tc1V3ByFh31KjRSwtV2L1yrvu7zZIkgwwbKtPgyOl1OFVCo7H9gPCiqV7KrbKDGfe4CImo6sCK8O0hQd3Y=
X-Received: by 2002:aca:4e03:: with SMTP id c3mr2244363oib.169.1600776864379;
 Tue, 22 Sep 2020 05:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200921200356.8627-1-rpearson@hpe.com> <20200921200356.8627-13-rpearson@hpe.com>
In-Reply-To: <20200921200356.8627-13-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 22 Sep 2020 20:14:13 +0800
Message-ID: <CAD=hENeBKW2JJJaiXD0n_vqgLz2dvw_HQ3P4K8R4pTnyXG4vZw@mail.gmail.com>
Subject: Re: [PATCH for-next v6 12/12] rdma_rxe: Fix bugs in the multicast
 receive path
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 4:04 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> This patch does the following
>   - Fix a bug in rxe_rcv.
>     The current code calls rxe_match_dgid which checks to see if the
>     destination ip address (dgid) matches one of the addresses in
>     the gid table. This is ok for unicast adfdresses but not mcast
>     addresses. Because of this all mcast packets were previously
>     dropped.

338 /* rxe_rcv is called from the interface driver */
339 void rxe_rcv(struct sk_buff *skb)
340 {
...
365         err = hdr_check(pkt);  <---In this function multicast
packets are checked and taken as error.
366         if (unlikely(err))
367                 goto drop;
...

Zhu Yanjun

>   - Fix a bug in rxe_rcv_mcast_pkt.
>     The current code is just wrong. It assumed that it could pass
>     the same skb to rxe_rcv_pkt changing the qp pointer as it went
>     when multiple QPs were attached to the same mcast address. In
>     fact each QP needs a separate clone of the skb which it will
>     delete later.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 60 +++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 50411b0069ba..bc86ebbd2c8c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -233,6 +233,8 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>         struct rxe_mc_elem *mce;
>         struct rxe_qp *qp;
>         union ib_gid dgid;
> +       struct sk_buff *per_qp_skb;
> +       struct rxe_pkt_info *per_qp_pkt;
>         int err;
>
>         if (skb->protocol == htons(ETH_P_IP))
> @@ -261,42 +263,37 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>                 if (err)
>                         continue;
>
> -               /* if *not* the last qp in the list
> -                * increase the users of the skb then post to the next qp
> +               /* for all but the last qp create a new clone of the
> +                * skb and pass to the qp.
> +                * This effectively reverts an earlier change
> +                * which did not work. The pkt struct is contained
> +                * in the skb so each time you changed pkt you also
> +                * changed all the earlier pkts as well. Caused a mess.
>                  */
>                 if (mce->qp_list.next != &mcg->qp_list)
> -                       skb_get(skb);
> +                       per_qp_skb = skb_clone(skb, GFP_ATOMIC);
> +               else
> +                       per_qp_skb = skb;
>
> -               pkt->qp = qp;
> +               per_qp_pkt = SKB_TO_PKT(per_qp_skb);
> +               per_qp_pkt->qp = qp;
>                 rxe_add_ref(qp);
> -               rxe_rcv_pkt(pkt, skb);
> +               rxe_rcv_pkt(per_qp_pkt, per_qp_skb);
>         }
>
>         spin_unlock_bh(&mcg->mcg_lock);
> -
>         rxe_drop_ref(mcg);      /* drop ref from rxe_pool_get_key. */
> +       return;
>
>  err1:
>         kfree_skb(skb);
> +       return;
>  }
>
> -static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
> +static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb,
> +                         union ib_gid *pdgid)
>  {
> -       struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>         const struct ib_gid_attr *gid_attr;
> -       union ib_gid dgid;
> -       union ib_gid *pdgid;
> -
> -       if (pkt->mask & RXE_LOOPBACK_MASK)
> -               return 0;
> -
> -       if (skb->protocol == htons(ETH_P_IP)) {
> -               ipv6_addr_set_v4mapped(ip_hdr(skb)->daddr,
> -                                      (struct in6_addr *)&dgid);
> -               pdgid = &dgid;
> -       } else {
> -               pdgid = (union ib_gid *)&ipv6_hdr(skb)->daddr;
> -       }
>
>         gid_attr = rdma_find_gid_by_port(&rxe->ib_dev, pdgid,
>                                          IB_GID_TYPE_ROCE_UDP_ENCAP,
> @@ -314,17 +311,32 @@ void rxe_rcv(struct sk_buff *skb)
>         int err;
>         struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>         struct rxe_dev *rxe = pkt->rxe;
> +       union ib_gid dgid;
> +       union ib_gid *pdgid;
>         __be32 *icrcp;
>         u32 calc_icrc, pack_icrc;
> +       int is_mc;
>
>         pkt->offset = 0;
>
>         if (unlikely(skb->len < pkt->offset + RXE_BTH_BYTES))
>                 goto drop;
>
> -       if (rxe_match_dgid(rxe, skb) < 0) {
> -               pr_warn_ratelimited("failed matching dgid\n");
> -               goto drop;
> +       if (skb->protocol == htons(ETH_P_IP)) {
> +               ipv6_addr_set_v4mapped(ip_hdr(skb)->daddr,
> +                                      (struct in6_addr *)&dgid);
> +               pdgid = &dgid;
> +       } else {
> +               pdgid = (union ib_gid *)&ipv6_hdr(skb)->daddr;
> +       }
> +
> +       is_mc = rdma_is_multicast_addr((struct in6_addr *)pdgid);
> +
> +       if (!(pkt->mask & RXE_LOOPBACK_MASK) && !is_mc) {
> +               if (rxe_match_dgid(rxe, skb, pdgid) < 0) {
> +                       pr_warn_ratelimited("failed matching dgid\n");
> +                       goto drop;
> +               }
>         }
>
>         pkt->opcode = bth_opcode(pkt);
> --
> 2.25.1
>
