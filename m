Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F16423D5A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 13:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhJFL6B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 07:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbhJFL6B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Oct 2021 07:58:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25060C061749
        for <linux-rdma@vger.kernel.org>; Wed,  6 Oct 2021 04:56:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t9so9384495lfd.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 Oct 2021 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VN65crui0c/YziNjx9Uxptfdba9yCoXnD/cwOyJ+8UM=;
        b=eF3+P+T1PDIhaV918isPZW4EZRYciwGHyWr1l/mZrb9h+S+zc+m64C3vCkO/uCh/0c
         OjVVmIhlkB9+4qsTIzInzG2VbygcpZ+ncNIbt3hmAkA3sqnIhQp2ro+JZKfXDwW/nSxJ
         MFn4LMSocrOnCGV8GVE4YhVARO/xikVkM9MwflJuPcDFxygQ6IxaTHR3Gi5cuaHg3aJZ
         vaWx3ykPhH5V6o06l5ize2ZGZxh0M6A6RfuADT/sWJ7Qyg+Dg9n42OQQoRheECC9+/qy
         pIn8FhFPMxbLnlxciilX6HZ+oMTvutnkct3DtudYFGx4uba6bmk0m0dNXOyxhK+eiB1a
         e1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VN65crui0c/YziNjx9Uxptfdba9yCoXnD/cwOyJ+8UM=;
        b=MT+x+gklc8BsrIi45tiLczjApLRp1jRLuPaWPfUm4T1syCj61pJNkivWofbAfDYKkQ
         +yysHsuVGasT1dzY7wg/1yfjhtdsKqlNXJN91J7ph8jz97LCzotxTNll0JnY215DB2+4
         5gzfGSmyCif5KilRA5/rka1MpvYP1WID20l+l0jctX0qprXiDgTwMztNMGJCUK2u2gpu
         D41Kvuxd2dRP1c7koiAczUUVja+IINE5WaaP/Lw12tlq5P6uuIULbEdUMwgGK+yr4Izm
         Gaeu76dpxrA3RnspT9EYTLWRpru0c7K+GvzfeH9p3MVxlc31gE31qFzqUx47hmqmZUs+
         sKEA==
X-Gm-Message-State: AOAM533Pb6wSdLb7RAbUukg5bs48moW2bArJYb0meS/5xz5CBNq/joQ5
        0sn1BtNLCcxXSrvbxyJNRaumBE4BnQzFg1/ELRLnt71rtcg=
X-Google-Smtp-Source: ABdhPJzHtGU/+/qObybpRVIkKBjWGHh588Lt901M9WqUkCPpGHRrPGOxOn/RArfJrq214UbJamlyjF/vmER9I9VlEoI=
X-Received: by 2002:a2e:1645:: with SMTP id 5mr26905620ljw.123.1633521366524;
 Wed, 06 Oct 2021 04:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211006015815.28350-1-rpearsonhpe@gmail.com> <20211006015815.28350-6-rpearsonhpe@gmail.com>
In-Reply-To: <20211006015815.28350-6-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 6 Oct 2021 19:55:55 +0800
Message-ID: <CAD=hENda99c3wDoub39EedNrU7cmeMORnW=q6K9EVdFXZaTUsg@mail.gmail.com>
Subject: Re: [PATCH for-next v5 5/6] RDMA/rxe: Lookup kernel AH from ah index
 in UD WQEs
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 6, 2021 at 9:58 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Add code to rxe_get_av in rxe_av.c to use the AH index in UD send WQEs
> to lookup the kernel AH. For old user providers continue to use the AV
> passed in WQEs. Move setting pkt->rxe to before the call to rxe_get_av()
> to get access to the AH pool.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_av.c  | 20 +++++++++++++++++++-
>  drivers/infiniband/sw/rxe/rxe_req.c |  8 +++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
> index 85580ea5eed0..38c7b6fb39d7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_av.c
> +++ b/drivers/infiniband/sw/rxe/rxe_av.c
> @@ -101,11 +101,29 @@ void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr)
>
>  struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
>  {
> +       struct rxe_ah *ah;
> +       u32 ah_num;
> +
>         if (!pkt || !pkt->qp)
>                 return NULL;
>
>         if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
>                 return &pkt->qp->pri_av;
>
> -       return (pkt->wqe) ? &pkt->wqe->wr.wr.ud.av : NULL;
> +       if (!pkt->wqe)
> +               return NULL;
> +
> +       ah_num = pkt->wqe->wr.wr.ud.ah_num;
> +       if (ah_num) {
> +               /* only new user provider or kernel client */

struct rxe_ah *ah;
ah is only used in this snippet. Is it better to move to here?
It is only a trivial problem.

Zhu Yanjun
> +               ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
> +               if (!ah || ah->ah_num != ah_num || rxe_ah_pd(ah) != pkt->qp->pd) {
> +                       pr_warn("Unable to find AH matching ah_num\n");
> +                       return NULL;
> +               }
> +               return &ah->av;
> +       }
> +
> +       /* only old user provider for UD sends*/
> +       return &pkt->wqe->wr.wr.ud.av;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index fe275fcaffbd..0c9d2af15f3d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -379,9 +379,8 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
>         /* length from start of bth to end of icrc */
>         paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
>
> -       /* pkt->hdr, rxe, port_num and mask are initialized in ifc
> -        * layer
> -        */
> +       /* pkt->hdr, port_num and mask are initialized in ifc layer */
> +       pkt->rxe        = rxe;
>         pkt->opcode     = opcode;
>         pkt->qp         = qp;
>         pkt->psn        = qp->req.psn;
> @@ -391,6 +390,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
>
>         /* init skb */
>         av = rxe_get_av(pkt);
> +       if (!av)
> +               return NULL;
> +
>         skb = rxe_init_packet(rxe, av, paylen, pkt);
>         if (unlikely(!skb))
>                 return NULL;
> --
> 2.30.2
>
