Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB65629429
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 10:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiKOJTx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 04:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiKOJTh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 04:19:37 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F06C62E5
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 01:18:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so23475266lfv.2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 01:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kADTpbkq0En76Um53SmxIAybOP8rnRuo/Zr6fLnKXYc=;
        b=OYshvhJd3i/jTaEq824ZDH3zyZT6tzSInPbaVuiJEbVOr/TY6Ccsmj4LqnRhke2v9z
         k/Wtb4DrY+sodgWyc4/siKdHEnMCrhFhU54ugtT+QSnFgDnNj0Mro4sviSzA0DygG5HY
         uatqOL8mGl/DQrGZqQKQSGsnPImDdPyZeYRxnzQAwqUZuiLlymNrpBqVdhj5PsTTaIBj
         0kdbTOHTMd7re7rLdLFQlKIkFyjCeqGdAtar8CUtyKjKGOKG+5O7AePMEOtopScfhwkS
         t466d0yVmz1S7/hwkrTrR+OsbvVx4SpA8Xmp+7CJPfwen0jH0QAD62uu+2EYxK5hW/3u
         sgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kADTpbkq0En76Um53SmxIAybOP8rnRuo/Zr6fLnKXYc=;
        b=m4gbQhvsC8gFtG/UXe6+Z4l0Jtbfp4/I1z7KpjP62JsN7V9Caj1Crkhp2de1tOzLWD
         9urh2RRcyLrlAkqz8MDUSafTaFA3nXMFVQ2uxY0NxZ0xmNOysUHrrgfcAl4VAff7eWZj
         9iihMRFclxi/PEee0ofzdjHVn+aRgGLWt8M6QF97VpVys1lTxAE+V3UDiAsQmFjfz7MO
         snV+y4JgUisdM+/BXO1Vy4xSXimg4us8shfxrP+8iEX3fjbn69JS+hT4POdIDjbOyJEK
         vd7sWntltsHLYpIwD7baHe/7U01hEZJDf8KiYqVEUFjT341X1j9nX94OJo31+FQLWKue
         Zhng==
X-Gm-Message-State: ANoB5plZPNMGHgWDRaWlyTtzCx/4R6eTgb+EQ4eTC/nyYc7nTpOtzQJs
        iwqeG8+ZeKFpDsqX5LzOV2ikSvSvKr02KO9zuOb/HQ==
X-Google-Smtp-Source: AA0mqf4s3gS/1vk4+mlhZzNPrQmdlk1XZSkBbyIYVNc0KiIdw8B73qv4lmVgseBWl2EMA9mZS1mVHBNDa+jfnRXLt7o=
X-Received: by 2002:a05:6512:308:b0:4aa:8cd:5495 with SMTP id
 t8-20020a056512030800b004aa08cd5495mr4872585lfp.254.1668503930944; Tue, 15
 Nov 2022 01:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-10-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-10-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 15 Nov 2022 10:18:39 +0100
Message-ID: <CAJpMwyg_7qJJ6RNgF_fQygu6enVuuWu2_7B_NaAWABo_OZPQ=Q@mail.gmail.com>
Subject: Re: [PATCH RFC 09/12] RDMA/rtrs: Clean up rtrs_rdma_dev_pd_ops
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
> Let's remove them since the three members are not used.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

Thanks

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  3 ---
>  drivers/infiniband/ulp/rtrs/rtrs.c     | 22 ++++------------------
>  2 files changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> index c4ddaeba1c59..4d15a6fd96b6 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> @@ -68,10 +68,7 @@ enum {
>  struct rtrs_ib_dev;
>
>  struct rtrs_rdma_dev_pd_ops {
> -       struct rtrs_ib_dev *(*alloc)(void);
> -       void (*free)(struct rtrs_ib_dev *dev);
>         int (*init)(struct rtrs_ib_dev *dev);
> -       void (*deinit)(struct rtrs_ib_dev *dev);
>  };
>
>  struct rtrs_rdma_dev_pd {
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index ed324b47d93a..4bf9d868cc52 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -557,7 +557,6 @@ EXPORT_SYMBOL(rtrs_addr_to_sockaddr);
>  void rtrs_rdma_dev_pd_init(enum ib_pd_flags pd_flags,
>                             struct rtrs_rdma_dev_pd *pool)
>  {
> -       WARN_ON(pool->ops && (!pool->ops->alloc ^ !pool->ops->free));
>         INIT_LIST_HEAD(&pool->list);
>         mutex_init(&pool->mutex);
>         pool->pd_flags = pd_flags;
> @@ -583,15 +582,8 @@ static void dev_free(struct kref *ref)
>         list_del(&dev->entry);
>         mutex_unlock(&pool->mutex);
>
> -       if (pool->ops && pool->ops->deinit)
> -               pool->ops->deinit(dev);
> -
>         ib_dealloc_pd(dev->ib_pd);
> -
> -       if (pool->ops && pool->ops->free)
> -               pool->ops->free(dev);
> -       else
> -               kfree(dev);
> +       kfree(dev);
>  }
>
>  int rtrs_ib_dev_put(struct rtrs_ib_dev *dev)
> @@ -618,11 +610,8 @@ rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
>                         goto out_unlock;
>         }
>         mutex_unlock(&pool->mutex);
> -       if (pool->ops && pool->ops->alloc)
> -               dev = pool->ops->alloc();
> -       else
> -               dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> -       if (IS_ERR_OR_NULL(dev))
> +       dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +       if (!dev)
>                 goto out_err;
>
>         kref_init(&dev->ref);
> @@ -644,10 +633,7 @@ rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
>  out_free_pd:
>         ib_dealloc_pd(dev->ib_pd);
>  out_free_dev:
> -       if (pool->ops && pool->ops->free)
> -               pool->ops->free(dev);
> -       else
> -               kfree(dev);
> +       kfree(dev);
>  out_err:
>         return NULL;
>  }
> --
> 2.31.1
>
