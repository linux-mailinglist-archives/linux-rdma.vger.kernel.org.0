Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067A63C6B39
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 09:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhGMHaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 03:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbhGMHaj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jul 2021 03:30:39 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951EC0613DD
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jul 2021 00:27:49 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so21585741otl.3
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jul 2021 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20LCdYOl+GKJla0djNh7RAFWjzWldP5vmSJ6xIDRDmY=;
        b=MRA38t81Q1Ez752lMD8HHbg28Zr8WI26Pe84sxMpGnRqCyyzo8unEwomne9/BV+1Zj
         t58qZO0LxWzQTnyMCyn+S/30szXHsNXAxHPfKnijHKhWkn0CxVHUfcSAtG5okiQJwt3t
         1K7J0Nz6ADEfuZCGmYiXXn5prMlhmjutoBXqe83AhuwFNM1FMPRZzV89ZgiNOdz/fBL1
         rOdHksa0SBKo4vC1/AwFxDk0CLzXdOgQKTU4MEy4BssBs7BA6gAwydmN3tG9CQ9undk6
         FE5pXaDRfg6XLAx1jiQnZZoti354tFoMplSBZWrX2aIzTEhxsrGuJ472WI3deNQyUdnW
         IGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20LCdYOl+GKJla0djNh7RAFWjzWldP5vmSJ6xIDRDmY=;
        b=GrBMnoB2EvRXF7kUD/OCAXUDDe8UccdR3e67jEhKZ2JBOKmv/OCzYGsWZcZV7ylciw
         W5cD+pETtdlEzLtzPv1AoXyEgfmwnmFIeRKuIQUolSrHYGVnaiIsWH8h53VmqhDt8oym
         /8VYYDnb0SuB1gyUpKtX9U7IvJ4+T+qOyez/nnJJ1dg5siakJFMbVfmemUYpnvcfSUsf
         8qXn2jSpE8y4wZjLZJcw2hj0vhAhgfLmOR2Rslp7dFRX9zaIHpAMbrG9Ci8eyIMXFnpG
         gQZJaUNuwoX7NBBwbpPAMsj4W7BlkZK7OWQHH+syakzT8xWdw4iYNlaNoo97bt+/fbow
         leaw==
X-Gm-Message-State: AOAM530mWj8Teb8F3bRQDRYFjh1QpqiOp737lJqz/vVgmoRU7I4J5EXX
        XYovHDebAE89D9zGVG2XdwNYSOS4RthMzK12xEY=
X-Google-Smtp-Source: ABdhPJyCaopyqE0cyGM9WQi5yB7qLrBl19Vbo6UG8oIz4VKMw8Sp6QF4fmCdEzaPVfqaPhFnmAQ0vT7OpZOykTb1fTQ=
X-Received: by 2002:a9d:a83:: with SMTP id 3mr2458833otq.278.1626161268599;
 Tue, 13 Jul 2021 00:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210707040040.15434-1-rpearsonhpe@gmail.com> <20210707040040.15434-2-rpearsonhpe@gmail.com>
In-Reply-To: <20210707040040.15434-2-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 13 Jul 2021 15:27:37 +0800
Message-ID: <CAD=hENfY2PwNF71QFkR981CA8z7WFR65a2qxkeP61r0Zbaq+GQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] RDMA/rxe: Move ICRC checking to a subroutine
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 7, 2021 at 12:01 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Move the code in rxe_recv() that checks the ICRC on incoming packets to a
> subroutine rxe_check_icrc() and move that to rxe_icrc.c.

In this commit, a new function rxe_icrc_check is created with the
original source code.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_icrc.c | 38 ++++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  2 ++
>  drivers/infiniband/sw/rxe/rxe_recv.c | 23 ++---------------
>  3 files changed, 42 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
> index 66b2aad54bb7..d067841214be 100644
> --- a/drivers/infiniband/sw/rxe/rxe_icrc.c
> +++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
> @@ -67,3 +67,41 @@ u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
>                         rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES);
>         return crc;
>  }
> +
> +/**
> + * rxe_icrc_check() - Compute ICRC for a packet and compare to the ICRC
> + *                   delivered in the packet.
> + * @skb: packet buffer
> + * @pkt: packet info
> + *
> + * Return: 0 if the values match else an error
> + */
> +int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> +{
> +       __be32 *icrcp;
> +       u32 pkt_icrc;
> +       u32 icrc;
> +
> +       icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> +       pkt_icrc = be32_to_cpu(*icrcp);
> +
> +       icrc = rxe_icrc_hdr(pkt, skb);
> +       icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
> +                               payload_size(pkt) + bth_pad(pkt));
> +       icrc = (__force u32)cpu_to_be32(~icrc);
> +
> +       if (unlikely(icrc != pkt_icrc)) {
> +               if (skb->protocol == htons(ETH_P_IPV6))
> +                       pr_warn_ratelimited("bad ICRC from %pI6c\n",
> +                                           &ipv6_hdr(skb)->saddr);
> +               else if (skb->protocol == htons(ETH_P_IP))
> +                       pr_warn_ratelimited("bad ICRC from %pI4\n",
> +                                           &ip_hdr(skb)->saddr);
> +               else
> +                       pr_warn_ratelimited("bad ICRC from unknown\n");
> +
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 1ddb20855dee..015777e31ec9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -193,7 +193,9 @@ int rxe_completer(void *arg);
>  int rxe_requester(void *arg);
>  int rxe_responder(void *arg);
>
> +/* rxe_icrc.c */
>  u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb);
> +int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt);
>
>  void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 7a49e27da23a..6a6cc1fa90e4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -361,8 +361,6 @@ void rxe_rcv(struct sk_buff *skb)
>         int err;
>         struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>         struct rxe_dev *rxe = pkt->rxe;
> -       __be32 *icrcp;
> -       u32 calc_icrc, pack_icrc;
>
>         if (unlikely(skb->len < RXE_BTH_BYTES))
>                 goto drop;
> @@ -384,26 +382,9 @@ void rxe_rcv(struct sk_buff *skb)
>         if (unlikely(err))
>                 goto drop;
>
> -       /* Verify ICRC */
> -       icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> -       pack_icrc = be32_to_cpu(*icrcp);
> -
> -       calc_icrc = rxe_icrc_hdr(pkt, skb);
> -       calc_icrc = rxe_crc32(rxe, calc_icrc, (u8 *)payload_addr(pkt),
> -                             payload_size(pkt) + bth_pad(pkt));
> -       calc_icrc = (__force u32)cpu_to_be32(~calc_icrc);
> -       if (unlikely(calc_icrc != pack_icrc)) {
> -               if (skb->protocol == htons(ETH_P_IPV6))
> -                       pr_warn_ratelimited("bad ICRC from %pI6c\n",
> -                                           &ipv6_hdr(skb)->saddr);
> -               else if (skb->protocol == htons(ETH_P_IP))
> -                       pr_warn_ratelimited("bad ICRC from %pI4\n",
> -                                           &ip_hdr(skb)->saddr);
> -               else
> -                       pr_warn_ratelimited("bad ICRC from unknown\n");
> -
> +       err = rxe_icrc_check(skb, pkt);
> +       if (unlikely(err))
>                 goto drop;
> -       }
>
>         rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
>
> --
> 2.30.2
>
