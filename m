Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC685B196A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIHJ4X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 05:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiIHJ4S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 05:56:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79DD9874A
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 02:56:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r18so9573690eja.11
        for <linux-rdma@vger.kernel.org>; Thu, 08 Sep 2022 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iYfKbv18GQ2Lm3V68GaSwIdwTDNYIl4a20Ic7i8+Krs=;
        b=VuYaXuKRcFjHM19t8NhyMlGQpn7BTtDf0JrRoh+0mH/oKvctYkuvx5osWCHzfP6qj2
         IBU/o1blGeoDoDGMM23L1XgsAHJwIuGhY7EwlcNiCmjIVyDtl4SVz+tX4laBbsIv51Yv
         JiCsEYJV+9EO51s7PR2atzS+zvDn3MxeALb36pat2DxRXLDq9BFbICt1c2keFAf2HuqS
         lYQ2pxPBpwAjXg80ugA9eMtXK/Zi/0Bj8NArMRxGEXtknIdCnPS2NF4sLYUy9irPVkxw
         GB2rs3mJb5K7J0YtoX4vFE9qUrXkXL/Q7SV4tcYPmFQdNKy9QCHYCvevzRrLwQR/79A2
         pKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iYfKbv18GQ2Lm3V68GaSwIdwTDNYIl4a20Ic7i8+Krs=;
        b=53XzwMKxwHpwmlhk/EnZkQKwcO70hI3ba3YkbB9HaH3kxHVKcDqERIYAnM0BwzB3Fs
         qyqAtZqirMvYPnRArhLYNYUPchB9id2+B7ipC0lLt1igqu1kkeSRc8QOq3dCQxQguVDN
         ILSHT723l6if/TupXPlHCsXUQf+KMBwfnX9wABi9DF4ZJXO1J4cPD2D7ylLRIAGEfubF
         97tj3pNN+nJGqJU5doGsv/sKxltJPj+bPsN8x9DkqMeNY01wdAvfRXO6YJCAMPeAVUQm
         tq8o144FKIJ0cYlpzZhh/G0RNjKak1TO5jHFAXe7FJCXZUlmAOqnv+EMrGjA1D9lsBO5
         TzTg==
X-Gm-Message-State: ACgBeo2uPYeQLR7OA5P/1K+S/Jf2Q70v2BsiKLYlX8Yck87ExVebKwoK
        d6Hrj1Q1WpEu7nrEGkQNiWGh8Puvk9ZcRdboeS9E2A==
X-Google-Smtp-Source: AA6agR6KlNxTd4nZ3aPXKdL4RhgQ37LHo42rVvMN6Gr5iqiJYlYFbhugFB21Glek6NFXJQioIHtE3Pwy66258Pm/lvE=
X-Received: by 2002:a17:907:2672:b0:734:a952:439a with SMTP id
 ci18-20020a170907267200b00734a952439amr5128418ejc.539.1662630969661; Thu, 08
 Sep 2022 02:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220908094548.4115-1-guoqing.jiang@linux.dev> <20220908094548.4115-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220908094548.4115-4-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 8 Sep 2022 11:55:58 +0200
Message-ID: <CAJpMwyjzEc0hLbq7x5nQDPGp5Bwaqp4nTwcNBFryW28jKm8+aw@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] RDMA/rtrs-clt: Kill xchg_paths
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 8, 2022 at 11:46 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Let's call try_cmpxchg directly for the same purpose.
>
> Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Reported-by: kernel test robot <lkp@intel.com>

I am not sure whats the correct way of using this. But technically,
this change was NOT done due to a report from the "kernel test robot".
It only pointed out the problem in the original patch. To the branch
maintainers, if its okay to keep this in this scenario, then ignore
this comment.

Thanks.

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index c29eccdb4fd2..2428bf5d07e3 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2220,17 +2220,6 @@ static void rtrs_clt_stop_and_destroy_conns(struct rtrs_clt_path *clt_path)
>         }
>  }
>
> -static inline bool xchg_paths(struct rtrs_clt_path __rcu **rcu_ppcpu_path,
> -                             struct rtrs_clt_path *clt_path,
> -                             struct rtrs_clt_path *next)
> -{
> -       struct rtrs_clt_path **ppcpu_path;
> -
> -       /* Call cmpxchg() without sparse warnings */
> -       ppcpu_path = (typeof(ppcpu_path))rcu_ppcpu_path;
> -       return clt_path == cmpxchg(ppcpu_path, clt_path, next);
> -}
> -
>  static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_path *clt_path)
>  {
>         struct rtrs_clt_sess *clt = clt_path->clt;
> @@ -2305,7 +2294,8 @@ static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_path *clt_path)
>                  * We race with IO code path, which also changes pointer,
>                  * thus we have to be careful not to overwrite it.
>                  */
> -               if (xchg_paths(ppcpu_path, clt_path, next))
> +               if (try_cmpxchg((struct rtrs_clt_path **)ppcpu_path,
> +                               &clt_path, next))
>                         /*
>                          * @ppcpu_path was successfully replaced with @next,
>                          * that means that someone could also pick up the
> --
> 2.31.1
>
