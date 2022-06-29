Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2E756074B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jun 2022 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiF2RVM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 13:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiF2RVM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 13:21:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B983D498
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 10:21:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z21so29180682lfb.12
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 10:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOkVsZnlbvTZGVDVeTOlQ5jm4ZirLCtp7cz1ft4VTwg=;
        b=UyKNxd4D71Mra3F6lwL+df7qWYMmG2yKa7s7G7FZ8AXrwMR4igoSm07nC4EfXrojZe
         LMroh27ahNCNLovPr3jdCZt72svQC296fewnOvHHPrC954Agzn8EkWD6lriTbSzGrtwz
         ClkwNpZPqEVNPG03SwJmZWdWd9CVzP4QKzTbTcVfzHRK7SL8FhIYGwockOzJovP7rve+
         vLL2Zfpd4mtZKSLmNdHEOnsjjMQtR4By4WjQUTa8xKc2bV59GLvTZ2mTdK1e8keMjcbz
         tS3AlQMHH8lbIPiPdY4EML3VC3LvTs3WZGDGk8khtuhU0rcEVAJzsjl3k7m7y1dkxGfO
         /OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOkVsZnlbvTZGVDVeTOlQ5jm4ZirLCtp7cz1ft4VTwg=;
        b=p7JsKa7ToMtkg/qRTHvwIgyF+YXMOQBn7dfx2amSEE/VwipaK818+H6uVEtaVOMwl4
         yTmD4c2NhA9RCRpWe3MeWyyRVwhlfhPfiCNAYvwqLSBZE2+Q9XVO0+h0FmggZkQPhRJT
         Y27SNsAiGRp1MbYKxaaUS4wyfES7HdbICUMblt9dR3lIZMxohE4VY5+3e111bqpzfkDN
         VeiBP1+cCP3fa8hndF5HGC6EMdk0osN5xMr38zjl1TlPVdAwEMLmcGcQTG9VXZBnCdOj
         tVowFdFXDors1Uxm/n+aIrB1N9bivBuor6UyaeFs4iLWpsh9ltMWKrdnpPx/Fhr6fD/n
         cjxw==
X-Gm-Message-State: AJIora9ltg845Cy/wsuefVPQBMlWFbDokzOqGGkHUVcQGV38TvfF4Bcf
        Q9kjw28peNN0UHCNOuNRe3TdO3q/nNoKX4l9IWlrTTwVRb87jDQ/1iBswA==
X-Google-Smtp-Source: AGRyM1vRMZv60JWfZC2RKG2o4KBQReQzkZILZUOCKNLkQk/FY58OlyfOeocr+auZJgn0fx/jzLhsx18etOyUj1nJP6M=
X-Received: by 2002:a05:6512:6d1:b0:47f:6471:cfb7 with SMTP id
 u17-20020a05651206d100b0047f6471cfb7mr2684323lff.337.1656523269001; Wed, 29
 Jun 2022 10:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220629164946.521293-1-haris.phnx@gmail.com>
In-Reply-To: <20220629164946.521293-1-haris.phnx@gmail.com>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Wed, 29 Jun 2022 19:20:42 +0200
Message-ID: <CAE_WKMxY-G5nR1nJ85YaeBXiL_Q4ZMztmDCbFba51=5s8VaLhg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare keys according to the MR access
To:     linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, aleksei.marov@ionos.com,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, haris.iqbal@ionos.com,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 29, 2022 at 6:49 PM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
>
> In rxe, the access permissions decide which of the lkey/rkey would be set
> during an MR registration. For an MR with only LOCAL access, only lkey is
> set and rkey stays 0. For an MR with REMOTE access, both lkey and rkey are
> set, such that rkey=lkey.
>
> Hence, for MR invalidate, do the comparison for keys according to the MR
> access. Since the invalidate wr can contain only a single key
> (ex.invalidate_rkey), it should match MR->rkey if the MR being invalidated
> has REMOTE access. If the MR has only LOCAL access, then that key should
> match MR->lkey.
>
> Fixes: 3902b429ca14 ("RDMA/rxe: Implement invalidate MW operations")

I think I messed up the Fixes line. It should be,

Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")

> Cc: rpearsonhpe@gmail.com
> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 17 +++++++++++------
>  2 files changed, 12 insertions(+), 7 deletions(-)
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
> index fc3942e04a1f..790cff7077fd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -576,22 +576,27 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
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
> +       if ((mr->access & IB_ACCESS_REMOTE) && key != mr->rkey) {
> +               pr_err("%s: key (%#x) doesn't match mr->rkey (%#x)\n",
> +                       __func__, key, mr->rkey);
> +               ret = -EINVAL;
> +               goto err_drop_ref;
> +       } else if ((mr->access & IB_ACCESS_LOCAL_WRITE) && key != mr->lkey) {
> +               pr_err("%s: key (%#x) doesn't match mr->lkey (%#x)\n",
> +                       __func__, key, mr->lkey);
>                 ret = -EINVAL;
>                 goto err_drop_ref;
>         }
> --
> 2.25.1
>
