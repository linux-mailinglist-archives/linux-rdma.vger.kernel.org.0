Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4D37F090
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 02:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhEMAnL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 20:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhEMAkb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 20:40:31 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D1C061358
        for <linux-rdma@vger.kernel.org>; Wed, 12 May 2021 17:38:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so18334155oto.0
        for <linux-rdma@vger.kernel.org>; Wed, 12 May 2021 17:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKftSlMNafgARsnzVos89awFujmC8+k0QBYKQb3YXWU=;
        b=qOodrRu4JgkQoUHusT8+rqSf+AUdAwrNFQY/Md6wRcCcKj5E6kV5RVI+B3wM7D3NOX
         HUetGnrrEEHZT4hsB3Ks5TfCDu80BWISpijcGUXBuY1Lx3B+i2kjkf4W24F6A2Kx0+jx
         WInB3RgR9YgckVcgNnBMAeHCEj95P1E+4R7AvbUhRj/9t3U+9tQr17DifuoGTr9FDbAq
         +0lDElYmVLDCcmk3RldE/fzeZaqYa8+sXkwhUyUSOnmoxP+p9I+cTb+65w2t8y42O0vb
         FmnoDn5SFiYkSp5k9hR/jNay2pBg76d5QjuQIkv3crSsDS821FmShum14TVTfJmG0bfS
         DqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKftSlMNafgARsnzVos89awFujmC8+k0QBYKQb3YXWU=;
        b=L07z7BvFFywrgop42KFJfite8l8UwHl1QYPvTv73G2QPPyKrSR69lQp0xq/EMSbeDs
         JI0ec/BtgYbhOPOMY7MXnsSEzJ4DVUg4+6Mz1s/GnFf7Z6PBGVXZKlBKmyyMC1B2Xw18
         cKwwXRRCMwOLaib1J941N9UGUJ2AXeMtZsDAlUAtjTSMc8h2ShZnH5tpBE8XH8Zt9zem
         /GDIFYx8bYfguThy6vMDsReYKUMWnzTIR2AcBsTKAegSB8jUAQHHrfrIRJnAiPO1a+RY
         UFW29oFIOQ6Xj8RfI0tBplcIxqW4XurvzlKPsY0To636ULBbB+iKTbTgvpQ9It3ioZfL
         3QAQ==
X-Gm-Message-State: AOAM533aNVu6YK8KPIOz1ZnkIBgLcEgqZArXVXa2CMsAOLZxrRYmZu3W
        TQi2XL9OyIUxH9FsF44e+7J0+e1O+AJ5ttPm11q6TcWp
X-Google-Smtp-Source: ABdhPJyK8WLc1oOHAG6N1aJ+uJk4XCkmBpVDWZ7xGxzVQjrQ4ltQUkl+v3r6ourYnzsWIerDN+HisWXxcr4QnbdCsUk=
X-Received: by 2002:a05:6830:10c7:: with SMTP id z7mr3438661oto.278.1620866302686;
 Wed, 12 May 2021 17:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <1620807142-39157-1-git-send-email-liweihang@huawei.com> <1620807142-39157-5-git-send-email-liweihang@huawei.com>
In-Reply-To: <1620807142-39157-5-git-send-email-liweihang@huawei.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 13 May 2021 08:38:11 +0800
Message-ID: <CAD=hENf8RH5RNa5u+Hn8b6n1jWyj2=3ZdPMjbcv5ZoiZk1h4pQ@mail.gmail.com>
Subject: Re: [PATCH for-next 4/4] RDMA/rxe: Remove unused parameter udata
To:     Weihang Li <liweihang@huawei.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 4:14 PM Weihang Li <liweihang@huawei.com> wrote:
>
> From: Lang Cheng <chenglang@huawei.com>
>
> The old version of ib_umem_get() need these udata as a parameter but now
> they are unnecessary.
>
> Fixes: c320e527e154 ("IB: Allow calls to ib_umem_get from kernel ULPs")
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>

Thanks. I am fine with this.
Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   | 2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index ef8061d..b21038c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -79,7 +79,7 @@ enum copy_direction {
>  void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
>
>  int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
> -                    int access, struct ib_udata *udata, struct rxe_mr *mr);
> +                    int access, struct rxe_mr *mr);
>
>  int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 9f63947..373b46aa 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -121,7 +121,7 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
>  }
>
>  int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
> -                    int access, struct ib_udata *udata, struct rxe_mr *mr)
> +                    int access, struct rxe_mr *mr)
>  {
>         struct rxe_map          **map;
>         struct rxe_phys_buf     *buf = NULL;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index aeb5e23..86a0965 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -899,7 +899,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>
>         rxe_add_ref(pd);
>
> -       err = rxe_mr_init_user(pd, start, length, iova, access, udata, mr);
> +       err = rxe_mr_init_user(pd, start, length, iova, access, mr);
>         if (err)
>                 goto err3;
>
> --
> 2.7.4
>
