Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C499F8BB
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 05:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfH1D1d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 23:27:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34751 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfH1D1d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 23:27:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so537744plr.1;
        Tue, 27 Aug 2019 20:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0jQlknGri5FzlyHM22Y/ns5jWqAjGWKeGzOct8tXCc=;
        b=jj5n+JC6LAAdDs3Zl2qRTh5cU8pkkLxOvmHHSDVZUO5ITrbHFvCKRUrCdWIY8BwkE5
         gowF5eUAMaDFNt3fKyDbEJHd4Oi4ZCIfLxkswUDX3G7dCVwYrVQCwXrhqHftWjEqj/Nj
         ClVSy5G309FAJY/c3olaD8FLjEwjgkHhHOYXbic1v9OLiVkTSNhtWyuOET8Bo0xATMiB
         Wy5vuKKe72G7wEjeWO29CTjCUGXlAm+dhWbNVgMLhvG827Qp00LsGP0ZCg3XKJphjcmy
         rg3JSMtGu6UylEJjS5mMP1ZZo8EuNlI2myTFTTrcPz5gbSmQEkOVBTRDaOt5KpuLhHn1
         9iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0jQlknGri5FzlyHM22Y/ns5jWqAjGWKeGzOct8tXCc=;
        b=CSLcD/4HOFRI+d0V5+bcjxirSqaRpRq5QTJmkPUi8O+lkBfaE1/XmTMN0XJqB3sUbU
         +HGMqzsPBrYdmhXeiV48l+4XrZmQ5uYK5Kkxl+sRAJ3YRBv3GxQj0lvhVHaqAQWPINpc
         lEbWroacrsdvTrVThjFH07Tkj/2sC31s7st7tW+flTbYSBwDvlvF6cr60P9Ohf3lri7Y
         NsOHRyIulCqvkxtIInQEQx3JOzXq+3oyhnjVzzfM2CzHcrPZsfvDO4N7tZf0sOcX74Dd
         gp4G9Gf2FtIWz7WpsGW/biysxzZ6GwyFYQGgtl4ET1Hk76E+yO3/6qoxnGq5lEQNPFrI
         Hfnw==
X-Gm-Message-State: APjAAAXb+FoiqOj5FaNOFP7hq+b61kEym7V5aSq9L84y4UXbr2PvmAUg
        K4z/giaxAh1tjEXB2QVtCPK4SmOpQvObteepfqQ=
X-Google-Smtp-Source: APXvYqzCciNsNOqyFtY1wmd5btq/ic/CSOFZyg8D4Jg+Frij+ttkgEHjGvu3M830BikaMZiWtg7rEgiANMLVx+Ao7lA=
X-Received: by 2002:a17:902:d690:: with SMTP id v16mr2096309ply.318.1566962852492;
 Tue, 27 Aug 2019 20:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
 <20190825194354.GC21239@ziepe.ca> <CAFqt6za5uUSKLMn0E25M1tYG853tpdE-kcoUYHdmby5s4d0JKg@mail.gmail.com>
 <20190826122055.GA27349@ziepe.ca> <CAFqt6zbTm7jA692-Ta9c5rxKoJyMUz2UPBpYGGs69wRtU=itpw@mail.gmail.com>
 <20190827154935.GD7149@ziepe.ca>
In-Reply-To: <20190827154935.GD7149@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 28 Aug 2019 08:57:19 +0530
Message-ID: <CAFqt6zb3VzXXnooowpQpTqhvmkB6qxhFHT1C87=3XcwaoP6V5w@mail.gmail.com>
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

On Tue, Aug 27, 2019 at 9:19 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Aug 27, 2019 at 01:48:57AM +0530, Souptick Joarder wrote:
> > On Mon, Aug 26, 2019 at 5:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Aug 26, 2019 at 01:32:09AM +0530, Souptick Joarder wrote:
> > > > On Mon, Aug 26, 2019 at 1:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Sun, Aug 25, 2019 at 11:37:27AM +0530, Souptick Joarder wrote:
> > > > > > First, length passed to mmap is checked explicitly against
> > > > > > PAGE_SIZE.
> > > > > >
> > > > > > Second, if vma->vm_pgoff is passed as non zero, it would return
> > > > > > error. It appears like driver is expecting vma->vm_pgoff to
> > > > > > be passed as 0 always.
> > > > >
> > > > > ? pg_off is not zero
> > > >
> > > > Sorry, I mean, driver has a check against non zero to return error -EOPNOTSUPP
> > > > which means in true scenario driver is expecting vma->vm_pgoff should be passed
> > > > as 0.
> > >
> > > get_index is masking vm_pgoff, it is not 0
> >
> > Sorry, I missed this part. Further looking into code,
> > in mlx5_ib_mmap(), vma_vm_pgoff is used to get command and
> > inside mlx5_ib_mmap_clock_info_page() entire *dev->mdev->clock_info*
> > is mapped.
> >
> > Consider that, the below modification will only take care of vma length
> > error check inside vm_map_pages_zero() and an extra check for vma
> > length is not needed.
>
> What is the point of vm_map_pages_zero() Is there some reason we should
> prefer it for mapping a single page?

vm_map_pages_zero() can be used to map single/ multiple pages both.
There were drivers previously which either check length and pg_off explicitly
or didn't check for incorrect value of length /pg_off passed to it at
all. Calling
vm_map_pages_zero() in those places were more appropriate as it has
internal check for both.

Now considering this patch, avoiding an extra check for length
explicitly is the only
part which can be avoided if converted to use vm_map_pages_zero()
because pg_off
is used in different context ( to identify command). So yes,
improvement wise convert
to use vm_map_pages_zero() is not making much difference here.
