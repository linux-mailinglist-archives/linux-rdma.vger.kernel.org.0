Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19846284F7
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 17:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiKNQVl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 11:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbiKNQVl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 11:21:41 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD45F56
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:21:40 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id be13so20125098lfb.4
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hce3gOKejiZjozkssxuC5iCMepRv3tk5WzvMPLIa9lA=;
        b=L/3eHRtnSEbc3bvDG10+Ha27rquxNV6YKKhbw7LhnUv99Ha9qtCzYpPReBXC2lVVES
         AH1nvgom9PrGS8nhOfRQLHDaLqNJN7q5307ajXKGD/2iY9h388NquFY6uwQJsXwFB0Q+
         fnef/YM4DQ1+o/wJVBwkDOResTxhD2xQFXFxIvcxuVI8yBKGO52t2s29FaelcPOK5WGO
         NTv6Bp74v4LChcaFfxdt3KSpEK1NZTZxkXkADu5iH0hEWuWf3uN39za60s0rfRm+P/Sz
         YQ7ztjVLLw+P4D/nYTK+c6Eoc7Y5j/W6aSLq+k+BLM9hpjcNKBKaQ5ez/yBtuekRT76m
         0MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hce3gOKejiZjozkssxuC5iCMepRv3tk5WzvMPLIa9lA=;
        b=svM+3gf0W/cWLitEfvwkfZQy631eiHb1ZU4CLlRiYIg6zoS88lIrgD6Sv2aVOYxA50
         nfWnY1XEPZodDdMUPRiaIWhcwbM4dlZR6R+qiiNxF6xzU/q7/ryBUOYQ2MnlRQ5mO1r8
         srzrAAltsLXdT2iMwTfCBgU4LRCx3GCwlK2kobLWDZDrDYp3hGRs9d+xa5mf2YoI5omt
         E4cAIHV0Z0u4e1Sqs/fYfj2HAELexI77ry5p4fFRSuBpEz6VKGvGDfeeWeCpyydR/GF1
         MZsHtuvatFt6zFdwdadD969JcK13M92dbPLy7agjrG0PtTLkPY3UpXCauMWxFJvht00v
         7VXw==
X-Gm-Message-State: ANoB5plsg5sPYsdkC8KeVEBpBU421KgUBLY+7NbvmVCggNr2KQuPAD5z
        di29Nh7rOT9vbeyNbNvN4WBc/IcK3GlWpo+4HbqxtA==
X-Google-Smtp-Source: AA0mqf75IKBUdGMxmerZBYnCYYTmDnG1ZoFwN2o7HuvSddj2mvLc8LyC48ajCqqNbQRBkWeKjrToTQv/eF5l8AqJo40=
X-Received: by 2002:a05:6512:308:b0:4aa:8cd:5495 with SMTP id
 t8-20020a056512030800b004aa08cd5495mr4038618lfp.254.1668442898397; Mon, 14
 Nov 2022 08:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-5-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-5-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 14 Nov 2022 17:21:27 +0100
Message-ID: <CAJpMwyj659G3QbT2wntQ1FtivscewtjB-jh2ZODQR-BawoD=jQ@mail.gmail.com>
Subject: Re: [PATCH RFC 04/12] RDMA/rtrs-srv: refactor the handling of failure
 case in map_cont_bufs
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Let's call unmap_cont_bufs when failure happens, and also only update
> mrs_num after everything is settled which means we can remove 'mri'.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

Thanks for this. It looks much better now without the weird while loop
and the gotos

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 47 +++++++++++---------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 063082d29fc6..88eae0dcf87f 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -561,9 +561,11 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
>  {
>         struct rtrs_srv_sess *srv = srv_path->srv;
>         struct rtrs_path *ss = &srv_path->s;
> -       int i, mri, err, mrs_num;
> +       int i, err, mrs_num;
>         unsigned int chunk_bits;
>         int chunks_per_mr = 1;
> +       struct ib_mr *mr;
> +       struct sg_table *sgt;
>
>         /*
>          * Here we map queue_depth chunks to MR.  Firstly we have to
> @@ -586,16 +588,14 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
>         if (!srv_path->mrs)
>                 return -ENOMEM;
>
> -       srv_path->mrs_num = mrs_num;
> -
> -       for (mri = 0; mri < mrs_num; mri++) {
> -               struct rtrs_srv_mr *srv_mr = &srv_path->mrs[mri];
> -               struct sg_table *sgt = &srv_mr->sgt;
> +       for (srv_path->mrs_num = 0; srv_path->mrs_num < mrs_num;
> +            srv_path->mrs_num++) {
> +               struct rtrs_srv_mr *srv_mr = &srv_path->mrs[srv_path->mrs_num];
>                 struct scatterlist *s;
> -               struct ib_mr *mr;
>                 int nr, nr_sgt, chunks;
>
> -               chunks = chunks_per_mr * mri;
> +               sgt = &srv_mr->sgt;
> +               chunks = chunks_per_mr * srv_path->mrs_num;
>                 if (!always_invalidate)
>                         chunks_per_mr = min_t(int, chunks_per_mr,
>                                               srv->queue_depth - chunks);
> @@ -644,31 +644,24 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
>
>                 ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
>                 srv_mr->mr = mr;
> -
> -               continue;
> -err:
> -               while (mri--) {
> -                       srv_mr = &srv_path->mrs[mri];
> -                       sgt = &srv_mr->sgt;
> -                       mr = srv_mr->mr;
> -                       rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
> -dereg_mr:
> -                       ib_dereg_mr(mr);
> -unmap_sg:
> -                       ib_dma_unmap_sg(srv_path->s.dev->ib_dev, sgt->sgl,
> -                                       sgt->nents, DMA_BIDIRECTIONAL);
> -free_sg:
> -                       sg_free_table(sgt);
> -               }
> -               kfree(srv_path->mrs);
> -
> -               return err;
>         }
>
>         chunk_bits = ilog2(srv->queue_depth - 1) + 1;
>         srv_path->mem_bits = (MAX_IMM_PAYL_BITS - chunk_bits);
>
>         return 0;
> +
> +dereg_mr:
> +       ib_dereg_mr(mr);
> +unmap_sg:
> +       ib_dma_unmap_sg(srv_path->s.dev->ib_dev, sgt->sgl,
> +                       sgt->nents, DMA_BIDIRECTIONAL);
> +free_sg:
> +       sg_free_table(sgt);
> +err:
> +       unmap_cont_bufs(srv_path);
> +
> +       return err;
>  }
>
>  static void rtrs_srv_hb_err_handler(struct rtrs_con *c)
> --
> 2.31.1
>
