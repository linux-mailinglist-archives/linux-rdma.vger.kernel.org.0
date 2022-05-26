Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB57F535039
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbiEZNxR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiEZNxR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 09:53:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0A6B676
        for <linux-rdma@vger.kernel.org>; Thu, 26 May 2022 06:53:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s20so1816070ljd.10
        for <linux-rdma@vger.kernel.org>; Thu, 26 May 2022 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9A5g55cyBsOgeoVTQ2s8GjFHkfwy7j0n7q/GUnZ++k=;
        b=Ong9tOOh4BJ607E6nYKcRWhrJXw1Tg6YpDVA/rSgtkYz4cIANIKVgUhMvfDbTSfpX5
         jKzhu1sIVuhC+RQbnN7Nf2NFNM4fAwcHA6DsAAqwZypnRXTVmtaESLS9ReVH999A1I+X
         GrDrUIh7a0GgOQPwkK7tIfwX5VRzOTPcoDjOaDsQmj5r6uskqKrEWtnMYbnlb0gvYm6y
         p+Ghgj8CsMZ3YtnKbPEVRTK8tdr5qclqoymbFwOdYpMyiCiW8CL1nIOOQe2dtRy5CF9i
         qQpwLeRXYo15vzLehqWObd+lpOOpg9m7hqqV5OkDifk+h3hl8LM+xxfS2AoJwz3kZLfK
         MntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9A5g55cyBsOgeoVTQ2s8GjFHkfwy7j0n7q/GUnZ++k=;
        b=gahZvYSLXCcD2s1Gkim3JfJqXdqP19KknxwWgK7CqeXGqlEo0R1VmssynDJqqqp8ef
         6iIbMOVH7pAIw0Rx5eh5AUJnIOrXBnn7IArryeiFuHkWfyGzhoLCjUT9GbazJ3xtxWUj
         2V2wyAMFvWI83KD2gqjyvG9r/bgmrTOvtnh2BfIUl5BtfjFQqdYSnnIst9uguaJVDI4N
         SpHRD8+8PFaEKd4adv+Ox7zEhtQHcCifBbd5FlWt4+ut/j1K1U+ftyc0NQBhtVP4Ntgo
         rB0wWzLDDQCQ3QuQTT5BHwFniuCzbpa/LVSv+YwpVy6KU+WDd/ym0sPSjERxpLHAXqO2
         8hEg==
X-Gm-Message-State: AOAM532u5qX1em8Ob54Pw13fPxUjOuHivet9ycfKhNJe7xlp+/FRAkrJ
        aQp7O4d72aJC8SIoDHjYLaZS5BOjQykUeEszXV25bg==
X-Google-Smtp-Source: ABdhPJxi0bItpZ0zTE+ZSYieJTEYcAfu4LVgNNVjvw9v7XF+c/O/vS1m8tyH+DoIHimNWAALRWb35+ezlfCZl98lZHU=
X-Received: by 2002:a2e:9ccb:0:b0:253:df97:ebd with SMTP id
 g11-20020a2e9ccb000000b00253df970ebdmr16773333ljj.280.1653573193228; Thu, 26
 May 2022 06:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220526130945.98601-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220526130945.98601-1-yang.lee@linux.alibaba.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 26 May 2022 15:53:01 +0200
Message-ID: <CAJpMwyhG152M9iLWRwLk5ewijj7gzE9rTmv2KFCZODbxLRCcFQ@mail.gmail.com>
Subject: Re: [PATCH -next] RDMA/rtrs-clt: Fix one kernel-doc comment
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
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

On Thu, May 26, 2022 at 3:09 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Add the description of @pathname and remove @sessname in rtrs_clt_open()
> kernel-doc comment to remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
>
> drivers/infiniband/ulp/rtrs/rtrs-clt.c:2809: warning: Function parameter
> or member 'pathname' not described in 'rtrs_clt_open'
> drivers/infiniband/ulp/rtrs/rtrs-clt.c:2809: warning: Excess function
> parameter 'sessname' description in 'rtrs_clt_open'
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>

Thanks

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index c2c860d0c56e..9809c3883979 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2785,7 +2785,7 @@ static void free_clt(struct rtrs_clt_sess *clt)
>  /**
>   * rtrs_clt_open() - Open a path to an RTRS server
>   * @ops: holds the link event callback and the private pointer.
> - * @sessname: name of the session
> + * @pathname: name of the path to an RTRS server
>   * @paths: Paths to be established defined by their src and dst addresses
>   * @paths_num: Number of elements in the @paths array
>   * @port: port to be used by the RTRS session
> --
> 2.20.1.7.g153144c
>
