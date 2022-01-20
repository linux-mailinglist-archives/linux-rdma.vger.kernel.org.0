Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F505494FD0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbiATOHI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 09:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344201AbiATOHH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jan 2022 09:07:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F04FC06161C
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 06:07:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a18so29159426edj.7
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KRtOHbY+iEJq9HfSDY0hl4UcUFuJy+kf9sLEgb7rvM=;
        b=i3Y73nifEBrIutvODwIjryyqWMK2H7NX0bRs8MPMVYVgK0gIPQ7wQ29lGTmxUheND5
         yw2IrD8FlsD9d7onvZQ9Y8WTSxKQd2M6IFU571t4CemhNuNWTPaFcvdhxOtwmibnpTIb
         E7PAV39X7nCQhVe3HRe+isYdleonuwvjYVR+Df3h6gLoCLOTI1a8Yy8VY/GO79wb9cV3
         DeNORziXKIWAXEdYYdwflnq9eVqPusqhLf9+hZSVkV+8iRMVvfEP8xC6+TP+5q3jTlZl
         ioxf1t7ri3IPwXMeSpvXfyMVVj+xDpeZPhpAJKv3GI8PKmMy24wQrnbtFdqCm2wUoSqL
         J62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KRtOHbY+iEJq9HfSDY0hl4UcUFuJy+kf9sLEgb7rvM=;
        b=lKA5cEpQyyE+oArbJ5YdITFjECNxFkMyu4XF+HvWPBbx2a824LzXlYIbe+lHUQBF7M
         ucmESkuMwneUY0Lwc9t71oS0xmXNpkGBAH9FSjy+/17utj8AFC93FDa2FZvdxg3p21uf
         +rUjmjkQqghkd79VCk0JrNDFrZJ5YiwqCffJfcncSfAKKODjWuzGjdlvKIk0gWLIq6xa
         zF5Nj3BnArBZyBM1kECTOnWbfgo3Mum6De2iptgBq4D2p2gOXe5nG9MQPYm4TyWGQYXY
         ZYqx4cOesYBFmL2k/fobma1uFbyFmspFyEMxjNM3y7TfbUwwOw5qvTv8Uyr9OTLCWI/R
         mv1Q==
X-Gm-Message-State: AOAM533CEAaOmFCDfF7da4VZ28ofvyqJID3G6rgnvvajtFh8rrMmTF2a
        c5iF9b8c1TuQu0NKd5vq+m1HsE3reQLpwYtr2SuFCQ==
X-Google-Smtp-Source: ABdhPJwwqmt0ufVXcEDCKYdH6FzL7WEQ5EpxKzwKJ1VvV8HD4ReqC1fuYcEEhM0iwphF2I1C3VePd+PAQeRpr7Na0ZI=
X-Received: by 2002:a05:6402:195:: with SMTP id r21mr35564718edv.174.1642687625993;
 Thu, 20 Jan 2022 06:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20220120103714.32108-1-linmq006@gmail.com>
In-Reply-To: <20220120103714.32108-1-linmq006@gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 20 Jan 2022 15:06:55 +0100
Message-ID: <CAMGffE=mzZVCg9hoiMRmjnnKqMb9cfC9YTcCkhHMo9BjHOr+Tg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: Fix double free in alloc_clt
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 20, 2022 at 11:37 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> Callback function rtrs_clt_dev_release() in put_device()
> calls kfree(clt); to free memory. We shouldn't call kfree(clt) again.
>
right, there is a bug, but the fix is not right.
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 7c3f98e57889..61723f48fbd4 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2741,7 +2741,7 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>         err = device_register(&clt->dev);
>         if (err) {
>                 put_device(&clt->dev);
> -               goto err;
> +               goto err_free_cpu;
>         }
>
>         clt->kobj_paths = kobject_create_and_add("paths", &clt->dev.kobj);
> @@ -2764,6 +2764,9 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>  err:
>         free_percpu(clt->pcpu_path);
>         kfree(clt);
> +       clt->pcpu_path = NULL;
> +err_free_cpu:
> +       free_percpu(clt->pcpu_path);
this still lead to use after free, because clt could be free already.
the right fix should move the free_percpu() to the release call back
before kfree(clt);
>         return ERR_PTR(err);
>  }
>
> --
> 2.17.1
>
