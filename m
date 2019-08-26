Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2809D743
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfHZUNN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 16:13:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47066 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbfHZUNM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 16:13:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id f9so16229170ljc.13;
        Mon, 26 Aug 2019 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Sl2EkWDyyOYJsCb7VCgLmTNEmzRDjZTOMKErAqj8Vo=;
        b=PvArNWxvHbhGyyPb2ska22IMhpzGSoP+Ot7IzEROgwUTlkFGkZlBH5jB/CITvIjig4
         6ydLZtH6siJWnFKoMqqsJ1f/bIbhMcM0sZUN8Mvh+9x1tc9Jk/cgRdEPUT3HKJu1C5hm
         b6FNu/bGAEG3pwQQf/zG+LGq42BjHGe2we5TyThk85eJ22jbBeTvp9PGSRQbV2zx/c8W
         PU/LVuwNJW2uWr9oCX4yvq68bFbA1KZ3LR0Zc1lOyZA4h5PNLG9cafA6U4vMscfZdA4a
         Rf+tEIeQ6J19zC5P6peMaFt5otTlOGRx+vLNnZGUzILs4yiG8ath7AIZdslUxvTmABl5
         IIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Sl2EkWDyyOYJsCb7VCgLmTNEmzRDjZTOMKErAqj8Vo=;
        b=Tw3s+BoHTWXAokyFTHe7N1eCExWTMwp679nK+EPGexlqbehDdUmu/qOWyLdLEFMDoo
         2kDED/yQrz3fT1ztrXeekIHpEQ/XbWVVCZE2INDf4B/9KK0V9Oh+3DwitaF5LRQbn3iL
         zOL6Q8h4gUlbpJgkZROWEhaGCmmtdPDvfbldRNssNwu4zUcu6BW4HcmCLzGdDEzpgXXs
         BSj0D15s4J1Q94Rk8m0srWV8tz9dDKEbKKcDV9TtclU/z/zqcccYI7rjxlYuMsHfVJMw
         IT1IsykADQIkbLvVTUroneraGKODhLoc9bRYMBVtyYuAfYF6pbGZ2JiIDJ6lvV6BiF54
         U/dQ==
X-Gm-Message-State: APjAAAWgxFRJs408KZO+qpdDOctUqPGAeK3zGI5tknhTbZAT20ZvbiAj
        ZpDBNHZwqRFjMqCBZPbD6KFbfDEtM+Oj13VevzY=
X-Google-Smtp-Source: APXvYqzK7yvu4wIiKj3NQDKKOBqQ4S3XuXUAlg6nbVH3P055CKv5RAB6nl2IYVUejzH9l7IgwEVQIb6sturVnm4n44g=
X-Received: by 2002:a2e:9a10:: with SMTP id o16mr1730431lji.104.1566850390614;
 Mon, 26 Aug 2019 13:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
 <20190825194354.GC21239@ziepe.ca> <CAFqt6za5uUSKLMn0E25M1tYG853tpdE-kcoUYHdmby5s4d0JKg@mail.gmail.com>
 <20190826122055.GA27349@ziepe.ca>
In-Reply-To: <20190826122055.GA27349@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 27 Aug 2019 01:48:57 +0530
Message-ID: <CAFqt6zbTm7jA692-Ta9c5rxKoJyMUz2UPBpYGGs69wRtU=itpw@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx5: Convert to use vm_map_pages_zero()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 5:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Aug 26, 2019 at 01:32:09AM +0530, Souptick Joarder wrote:
> > On Mon, Aug 26, 2019 at 1:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Sun, Aug 25, 2019 at 11:37:27AM +0530, Souptick Joarder wrote:
> > > > First, length passed to mmap is checked explicitly against
> > > > PAGE_SIZE.
> > > >
> > > > Second, if vma->vm_pgoff is passed as non zero, it would return
> > > > error. It appears like driver is expecting vma->vm_pgoff to
> > > > be passed as 0 always.
> > >
> > > ? pg_off is not zero
> >
> > Sorry, I mean, driver has a check against non zero to return error -EOPNOTSUPP
> > which means in true scenario driver is expecting vma->vm_pgoff should be passed
> > as 0.
>
> get_index is masking vm_pgoff, it is not 0

Sorry, I missed this part. Further looking into code,
in mlx5_ib_mmap(), vma_vm_pgoff is used to get command and
inside mlx5_ib_mmap_clock_info_page() entire *dev->mdev->clock_info*
is mapped.

Consider that, the below modification will only take care of vma length
error check inside vm_map_pages_zero() and an extra check for vma
length is not needed.

diff --git a/drivers/infiniband/hw/mlx5/main.c
b/drivers/infiniband/hw/mlx5/main.c
index 0569bca..c3e3bfe 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2071,8 +2071,9 @@ static int mlx5_ib_mmap_clock_info_page(struct
mlx5_ib_dev *dev,
                                        struct vm_area_struct *vma,
                                        struct mlx5_ib_ucontext *context)
 {
-       if ((vma->vm_end - vma->vm_start != PAGE_SIZE) ||
-           !(vma->vm_flags & VM_SHARED))
+       struct page *pages;
+
+       if (!(vma->vm_flags & VM_SHARED))
                return -EINVAL;

        if (get_index(vma->vm_pgoff) != MLX5_IB_CLOCK_INFO_V1)
@@ -2084,9 +2085,9 @@ static int mlx5_ib_mmap_clock_info_page(struct
mlx5_ib_dev *dev,

        if (!dev->mdev->clock_info)
                return -EOPNOTSUPP;
+       pages = virt_to_page(dev->mdev->clock_info);

-       return vm_insert_page(vma, vma->vm_start,
-                             virt_to_page(dev->mdev->clock_info));
+       return vm_map_pages_zero(vma, &pages, 1);
 }

If this is fine, I can post it as v2. Otherwise I will drop this patch ?
