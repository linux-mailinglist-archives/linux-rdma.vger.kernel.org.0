Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846766297B3
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiKOLqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 06:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKOLqh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 06:46:37 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0603A25EAD
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 03:46:36 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j16so23963210lfe.12
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 03:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhCH9HU1ycTLcCwENk+XuYSwF5VkTaELgEabTuqDu1o=;
        b=NJiZ5NY5+keVanHjpccUzPVob52Rr9PJRFlxwIjgFWuAl5MgNtAMD1CnxJz7AObu07
         fwsRYkZmKs7rzVJQOBYh4E3ocgLSFP8EkeIgBSdj68R0PCOuk2YrumB4hop64DEZUz0U
         cCEs296lpxNanpW+G8MSWHmZvwlEhNnE1ovTHYgMUGP8Gz+4LkKDjCDAdQa9ikQy28X0
         BpxuS6nIFcRerpcsS0rNTVm/RFNkhVuVNMr6dIKLklYib6JEdJ0U8R1zOnG7oKJmrJEC
         ti9Y9/k6EsQWZW2DfRqX8H80vtygJNu7zn315o/e/wgwd73SEXudcBkWigOfuVUVt98r
         Q1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhCH9HU1ycTLcCwENk+XuYSwF5VkTaELgEabTuqDu1o=;
        b=sANUSbKRc6MxhTHWxuipj1KssHD4JmVqPDcYI69nt/x5Vfwa9Pc7sWItQD4kJ+Pyq+
         wmEaO5AvkFiBeM7vcwL4q2ZmgMKcpayldJBq6SBEiI75TBm+XP9ckaiwvDLtG5QXE3pJ
         bCEmAO1t3QoqyHt/7+VFS/mAoSy6v1f6H2bIf7dmtgYW/RmdjuO0lWlG3RyBuJzhp6U5
         QD//cFVt6AMm6+Gty+IQLlg8sZAe10KeQE42wA+jK/X6QfmoN0jEWBPRLF2ZmXpBPcND
         f8dklac7iRGbsROzp/sQaohsDb2wQJopLacke7U5YXSQSKd5qj6Hw3oif7RiTnLcTjEa
         J7KA==
X-Gm-Message-State: ANoB5pnGLWLOHsASUL3yOAastrkVcykK8weAGJlT5Iyt2xwoMNcssnEy
        T84YBTjrhKq5Znex7zfBOL4nG0W9DlBqnTBiubCSVuKzT1Q=
X-Google-Smtp-Source: AA0mqf5d5Ni/XZ2kFTinA7OnOolZN1YC7cv0DYyC4UgHs0zgwtFpaDl7eTsavlkc/WiuF8uLzd/bLZg4KpwzF/yKXW4=
X-Received: by 2002:ac2:46c2:0:b0:4a2:47a4:319d with SMTP id
 p2-20020ac246c2000000b004a247a4319dmr5163046lfo.657.1668512794145; Tue, 15
 Nov 2022 03:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-6-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-6-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 15 Nov 2022 12:46:22 +0100
Message-ID: <CAMGffEn3sYLbF1_05mjHvtOM4DPGKR3AYYTBip0BD=4V9g9-+A@mail.gmail.com>
Subject: Re: [PATCH RFC 05/12] RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
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
> We should check with nr_sgt, also the only successful case is that
> all sg elements are mapped, so make it explict.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 88eae0dcf87f..f3bf5bbb4377 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -622,8 +622,8 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
>                 }
>                 nr = ib_map_mr_sg(mr, sgt->sgl, nr_sgt,
>                                   NULL, max_chunk_size);
> -               if (nr < 0 || nr < sgt->nents) {
> -                       err = nr < 0 ? nr : -EINVAL;
> +               if (nr != nr_sgt) {
> +                       err = -EINVAL;
but with this, the initial errno are lost, we only return EINVAL
>                         goto dereg_mr;
>                 }
>
> --
> 2.31.1
>
