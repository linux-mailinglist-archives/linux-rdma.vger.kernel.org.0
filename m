Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EBF9F9A8
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 07:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfH1FAk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 01:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfH1FAk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 01:00:40 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C7122CF4;
        Wed, 28 Aug 2019 05:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566968439;
        bh=Twq2yQQW1kb+CdWAXLUhBkn41nTMmiL4dInftsa3ZCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZljqAGWZT4g8A0yMdejOLzv1u7W2uhfFa5rqORxiArnhe3swrP+m7icxDTO0aneI
         RZd1YgueeJJ/2oUlEJMf2CtPEW+yE08MKFWkXyGlXgAe6Ox6vOQf+5ARKOiSByUK1h
         jOMxty5Y4iECjQjc+E+TbCaIOBanmLGjjeliin+M=
Date:   Wed, 28 Aug 2019 08:00:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] IB/mlx5: Convert to use vm_map_pages_zero()
Message-ID: <20190828050009.GB4725@mtr-leonro.mtl.com>
References: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
 <20190825194354.GC21239@ziepe.ca>
 <CAFqt6za5uUSKLMn0E25M1tYG853tpdE-kcoUYHdmby5s4d0JKg@mail.gmail.com>
 <20190826122055.GA27349@ziepe.ca>
 <CAFqt6zbTm7jA692-Ta9c5rxKoJyMUz2UPBpYGGs69wRtU=itpw@mail.gmail.com>
 <20190827154935.GD7149@ziepe.ca>
 <CAFqt6zb3VzXXnooowpQpTqhvmkB6qxhFHT1C87=3XcwaoP6V5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zb3VzXXnooowpQpTqhvmkB6qxhFHT1C87=3XcwaoP6V5w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 08:57:19AM +0530, Souptick Joarder wrote:
> On Tue, Aug 27, 2019 at 9:19 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Aug 27, 2019 at 01:48:57AM +0530, Souptick Joarder wrote:
> > > On Mon, Aug 26, 2019 at 5:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Mon, Aug 26, 2019 at 01:32:09AM +0530, Souptick Joarder wrote:
> > > > > On Mon, Aug 26, 2019 at 1:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > >
> > > > > > On Sun, Aug 25, 2019 at 11:37:27AM +0530, Souptick Joarder wrote:
> > > > > > > First, length passed to mmap is checked explicitly against
> > > > > > > PAGE_SIZE.
> > > > > > >
> > > > > > > Second, if vma->vm_pgoff is passed as non zero, it would return
> > > > > > > error. It appears like driver is expecting vma->vm_pgoff to
> > > > > > > be passed as 0 always.
> > > > > >
> > > > > > ? pg_off is not zero
> > > > >
> > > > > Sorry, I mean, driver has a check against non zero to return error -EOPNOTSUPP
> > > > > which means in true scenario driver is expecting vma->vm_pgoff should be passed
> > > > > as 0.
> > > >
> > > > get_index is masking vm_pgoff, it is not 0
> > >
> > > Sorry, I missed this part. Further looking into code,
> > > in mlx5_ib_mmap(), vma_vm_pgoff is used to get command and
> > > inside mlx5_ib_mmap_clock_info_page() entire *dev->mdev->clock_info*
> > > is mapped.
> > >
> > > Consider that, the below modification will only take care of vma length
> > > error check inside vm_map_pages_zero() and an extra check for vma
> > > length is not needed.
> >
> > What is the point of vm_map_pages_zero() Is there some reason we should
> > prefer it for mapping a single page?
>
> vm_map_pages_zero() can be used to map single/ multiple pages both.
> There were drivers previously which either check length and pg_off explicitly
> or didn't check for incorrect value of length /pg_off passed to it at
> all. Calling
> vm_map_pages_zero() in those places were more appropriate as it has
> internal check for both.
>
> Now considering this patch, avoiding an extra check for length
> explicitly is the only
> part which can be avoided if converted to use vm_map_pages_zero()
> because pg_off
> is used in different context ( to identify command). So yes,
> improvement wise convert
> to use vm_map_pages_zero() is not making much difference here.

So let's drop it, please.

Thanks
