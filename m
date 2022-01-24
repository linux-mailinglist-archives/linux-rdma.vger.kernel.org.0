Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB93C4976E2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 02:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbiAXBTk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 20:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiAXBTj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 20:19:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC6EC06173B;
        Sun, 23 Jan 2022 17:19:39 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a28so15831669lfl.7;
        Sun, 23 Jan 2022 17:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7TE4em7JB/tZ41yHK/CgF2TCS9fy9M15DMSLo68rwY=;
        b=B6W25/ZJ4XdX2y1N6dkBAqcHFixu3Pou7AOICcmcNX+sQha4x7Af+ZiDbbYmtal19C
         usRIxTgBjuhTN8eIEALApeWeW7gx5S6IEtZd+AGdg3L6cTqwDMWehrMu6AH5Vjb8Pq5N
         Uk3nlyfxD8QZW3GIlKIgOwzehvwaON2uZJfeuSybDC8wg+ukbDJ/FsTzbH6JoS1X3kGp
         xwjVrovFpuEDiMS5HCJeWhgijhZ8JLiIOHvyIcFOoIkpBSv+YInXbgmsJn0UXByhhnEq
         77gqBHamQ3i/gjPmzRKrFeqZQUPU5UYMC5bbGvz+NABr3zeA3DtlqXaGPf9XtP1ep+ls
         t9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7TE4em7JB/tZ41yHK/CgF2TCS9fy9M15DMSLo68rwY=;
        b=5vkMN6sKz2u2BFFBG5gnXtWOtB0SZww1+J0U0HpGDqf1duugfWTEN3+gowuI+CVWvB
         ktIojFK5WtPhV9PrC51GjyOSRyA44x0M44OGJ8CkuMBu+nMMtpd/DntNfpLNIV/IAzp7
         fOL52it1tqGzjyiL90MlOzS19q4UIl3H1NqHluSFKFkFNM+YwQpO0vumqYjzcuh9orAF
         1Bu+nqywzxgkZ/7FN93FdOmxz7kAoGBX4FN+vt009FUYgn00hqJ7YsJMHx96s4asndJa
         +3smaXInpDc2pduAKWt/uTqyw1g1xvs4rxd+CwizokF6pxygWwsQyDebNuVVgVNk1hQG
         MOyA==
X-Gm-Message-State: AOAM533opQ8eIEY7U8yfXHJ0MYI2nFSNhB5rn1gI7Hzt9c2ypedLHvE8
        uJjDjcLgPN8ah46+CjsS/uc5wWlnrAuqn8LugCQ=
X-Google-Smtp-Source: ABdhPJyhzegui+Ot229oGKSPqX96/DbvHusqhmuwaipzrltw7hPxgnnZMYu/YO4HRCo9AseWCtP6S4UKqByAyAcFt/o=
X-Received: by 2002:a05:6512:398b:: with SMTP id j11mr10943260lfu.94.1642987177803;
 Sun, 23 Jan 2022 17:19:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642960861.git.leonro@nvidia.com> <8bdb652b01f2316bc57b456fb8c60bfbffe6cc64.1642960861.git.leonro@nvidia.com>
In-Reply-To: <8bdb652b01f2316bc57b456fb8c60bfbffe6cc64.1642960861.git.leonro@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 24 Jan 2022 09:19:26 +0800
Message-ID: <CAD=hENc7UV4er4b3MwFJPRuJCBpFv46aEbG8zbnEPdE3ORQLjA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 08/11] RDMA/rxe: Delete useless module.h include
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 24, 2022 at 2:03 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> There is no need in include of module.h in the following files.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thanks a lot.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe.h      | 1 -
>  drivers/infiniband/sw/rxe/rxe_mmap.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
> index fb9066e6f5f0..30fbdf3bc76a 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -12,7 +12,6 @@
>  #endif
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> -#include <linux/module.h>
>  #include <linux/skbuff.h>
>
>  #include <rdma/ib_verbs.h>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
> index 035f226af133..9149b6095429 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mmap.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
> @@ -4,7 +4,6 @@
>   * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>   */
>
> -#include <linux/module.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
>  #include <linux/errno.h>
> --
> 2.34.1
>
