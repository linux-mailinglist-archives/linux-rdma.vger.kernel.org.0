Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE6575E65
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jul 2022 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiGOJWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jul 2022 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiGOJWN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jul 2022 05:22:13 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344161D57
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jul 2022 02:22:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 19so5071344ljz.4
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jul 2022 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJ/N9z6a8uhmAmv1ud5XvRkYGwSmxPYUtsnZAb3GhNE=;
        b=j3zIGlNMM6I+h28o2pTdDVEXkAlLvXbnD7ikWoYZAzoM+R9Uj95Yw+oLo+s5pWAH3Z
         3XfA3oBCMHCDoz4YfaeZSHaDmwFqFeIOyP2BjNpDeJqef2B+yAay9th28JIQnYI7OHGG
         c+lfTX2XOHOG15ie/HiUpd5bvPakX4p95glmRB5cgZJtSp3VbJXabCpseVshsoYRvH5j
         MH+vMdA1wSYex5wLe1YnhBkiqmqMeRcAVe70l/nl1QO+8OhhBhooMC9Gjkl6EfZHO90n
         fYZ34FFwMzwWGkRHv2kjOUSHoKkYnuNE913aPs4nmGmGnaG18SbyHVJSiHXBGXk0yPvg
         meqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJ/N9z6a8uhmAmv1ud5XvRkYGwSmxPYUtsnZAb3GhNE=;
        b=fPjZm9CyvWCF9F5S9sWkdSnElXBbgOmiNbJyusvFDiUAkuHbWA10omQHJH4pSNuDVN
         Nl2HCSA2zD7O8KdfGlj4DKP7/IqN4G2xGtC2sub2agU5EH2omR1YsggebKGy3ULriPJ9
         D8hTUX9aHuvbi5AqxPPAOvA3H4ezMUrabbPkDgZf1afv7AuSMDmWqkcsfzNUxNO1Akkq
         wGwdpuKvyUbg8RvJpnKXixeJiU+f4s9WH3vsCTjEGHY+lWw0IsrNwoy8XRG7SaBqGv8a
         a7FSMrtXHgXaKRdD8nYmjJyIMUXg0dNch5o0dCmrlHP8IlxuAqAmUjGGEgCHW6M+VUVJ
         YztA==
X-Gm-Message-State: AJIora9V1cobshwrbrqxqv2c4ItC3R1YANoqNGE9ByfHzcG2R5B+cqut
        xL3WD8G0r0hKLKLj8IQu3Y34R6ww2Sg/epGXFjQFeG367kIxe7h1
X-Google-Smtp-Source: AGRyM1tEld7rKMD29u0MpgfRTacQKlxnQdJjIV4ns1vM1us8C03UmIEO2Bg4/uuTWLzug+1PKF5ixLP8o8UVkRbFOT4=
X-Received: by 2002:a05:651c:a12:b0:25d:9ab3:4b38 with SMTP id
 k18-20020a05651c0a1200b0025d9ab34b38mr3866949ljq.409.1657876930079; Fri, 15
 Jul 2022 02:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220707073006.328737-1-haris.phnx@gmail.com>
In-Reply-To: <20220707073006.328737-1-haris.phnx@gmail.com>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Fri, 15 Jul 2022 11:21:44 +0200
Message-ID: <CAE_WKMzj3i6bKrHN_GuBpjoEzuQBXLoEZrXpsqKjtkxvM+ZbfA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare according to set keys in mr
To:     linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, haris.iqbal@ionos.com,
        Jinpu Wang <jinpu.wang@ionos.com>, aleksei.marov@ionos.com,
        Bob Pearson <rpearsonhpe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 7, 2022 at 9:30 AM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
>
> The 'rkey' input can be an lkey or rkey, and in rxe the lkey or rkey have
> the same value, including the variant bits.
>
> So, if mr->rkey is set, compare the invalidate key with it, otherwise
> compare with the mr->lkey.
>
> Since we already did a lookup on the non-varient bits to get this far,
> the check's only purpose is to confirm that the wqe has the correct
> variant bits.
>
> Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
> Cc: rpearsonhpe@gmail.com
> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0e022ae1b8a5..37484a559d20 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>                          enum rxe_mr_lookup_type type);
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
>  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
>  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index fc3942e04a1f..3add52129006 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -576,22 +576,22 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>         return mr;
>  }
>
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
>  {
>         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>         struct rxe_mr *mr;
>         int ret;
>
> -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> +       mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
>         if (!mr) {
> -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> +               pr_err("%s: No MR for key %#x\n", __func__, key);
>                 ret = -EINVAL;
>                 goto err;
>         }
>
> -       if (rkey != mr->rkey) {
> -               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> -                       __func__, rkey, mr->rkey);
> +       if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
> +               pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
> +                       __func__, key, (mr->rkey ? mr->rkey : mr->lkey));
>                 ret = -EINVAL;
>                 goto err_drop_ref;
>         }
> --
> 2.25.1

Ping.

>
