Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D142D39D6F1
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhFGITs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:19:48 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43800 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGITr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 04:19:47 -0400
Received: by mail-ot1-f51.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso15892424otu.10
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRRphp1pMXetIPqWzfUb4kEsWYYyxyULXVCeARJ2rBs=;
        b=WsRjxIKoOaxQ+MpqjqRAFekuzhP6wYW9RrmfRAvGtAzVDnrZ8c94rkSW88eV5ttalj
         d6jXplqBBPPARjsXYKVql12lEsvc+lUUWyTbg/6OKJYvgm142Ek4oVWAKL26g2hsrE9R
         sel1drjLkb3XrkR7+tAHzsOX7Oc0ed1xTe+kSWBM1DPtwO6QJd0i0eT3/nbmZJZdulLZ
         WjEi4W8s8jgPOX9bOnS7kAHeOERzBQIcpHpA1VvZeLHleczg5LwEoYRYAX7h12LryjXA
         kR5WeSDKg5DWHlc5o0pMKhOT/AznG3mwm3hwVN4my7c9Ygqz6d4wWiTG9Yb+8lyNLX5m
         HwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRRphp1pMXetIPqWzfUb4kEsWYYyxyULXVCeARJ2rBs=;
        b=Oz2lXtpBh00rOhgyQOCEqejm4YLAYSmuH68mXwC8RJNEZEx7HmU6Wnwyuiq61DXKQe
         OOoBCPO7fIMwHXt8lOcqD7YRReg/j0AUYNku1Y07HRgBpghQuCHRCaEITbn4xL2GfZZO
         SEQ/H1lQVUW4VrRa3S3U+zxOweuX/wqWYHlFDb3+ogyA6DWzZPA7oe0hNo5Yn5ilWJvC
         M9MYCXuVLVPYVRTC/mlR14d9EkE8R8gsq1lnhBLdpiWyABq5mxapP+ohgWUg7vqBPXYA
         PcvAx9zRgw2z2szxfk7BSgaZKtL/nWLJw3FyXAqZNU0iaDuDdUmhLJ6VmFQEPqQf5/jp
         iO9Q==
X-Gm-Message-State: AOAM53048UzlwB80s8HVqgjkMnxvFD8v64AGe8PzETG3okDp4bGduIeq
        +njpM3Tngi7fksKsoysAOK9lz6HBZPlQ2u43/zU=
X-Google-Smtp-Source: ABdhPJyUEKOTOgk5fhadNQ042a6pfhh6fmAvEvY1Tzg1K2tIXap5iQu2n9yTy/Ejev6pXjbJ1n6D788PwojgdNLXGO8=
X-Received: by 2002:a05:6830:c5:: with SMTP id x5mr2263478oto.59.1623053808508;
 Mon, 07 Jun 2021 01:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210604230558.4812-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210604230558.4812-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 7 Jun 2021 16:16:37 +0800
Message-ID: <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic ops
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 5, 2021 at 7:07 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Currently the rdma_rxe driver attempts to protect atomic responder
> resources by taking a reference to the qp which is only freed when the
> resource is recycled for a new read or atomic operation. This means that
> in normal circumstances there is almost always an extra qp reference
> once an atomic operation has been executed which prevents cleaning up
> the qp and associated pd and cqs when the qp is destroyed.
>
> This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
> call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is

Not sure if it is a good way to fix this problem by removing the call
to rxe_add_ref.
Because taking a reference to the qp is to protect atomic responder resources.

Removing rxe_add_ref is to decrease the protection of the atomic
responder resources.

Zhu Yanjun

> destroyed while a peer is retrying an atomic op it will cause the
> operation to fail which is acceptable.
>
> Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Fixes: 86af61764151 ("IB/rxe: remove unnecessary skb_clone")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c   | 1 -
>  drivers/infiniband/sw/rxe/rxe_resp.c | 2 --
>  2 files changed, 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 34ae957a315c..b6d83d82e4f9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -136,7 +136,6 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
>  void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
>  {
>         if (res->type == RXE_ATOMIC_MASK) {
> -               rxe_drop_ref(qp);
>                 kfree_skb(res->atomic.skb);
>         } else if (res->type == RXE_READ_MASK) {
>                 if (res->read.mr)
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 2b220659bddb..39dc39be586e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -966,8 +966,6 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>                 goto out;
>         }
>
> -       rxe_add_ref(qp);
> -
>         res = &qp->resp.resources[qp->resp.res_head];
>         free_rd_atomic_resource(qp, res);
>         rxe_advance_resp_resource(qp);
> --
> 2.30.2
>
