Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF83431B6
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 09:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCUIGU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 04:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCUIGU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Mar 2021 04:06:20 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277BAC061574
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 01:06:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id x2so9739712oiv.2
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kss3S1Cb/DVH5EFUbd0F+zefWWsF2yGaX15s3OrFgzo=;
        b=MaLWjfK3gCwUaf/rPJat22+tVzs0wkReABkCspPJhc57tDSCD9tg7yNiHkQFnCEZDV
         KtXytk6ZfY+3kWJMMTeA4C5ltPBrSAzIVgTWim3kI+KqAFl/JuyR0zSGy5eg1Fgc1fk0
         f0AspI48EzYspEj3F3NR9cnaLzxK6vG1Fg0dWYiTWLHvPoeoDITrUeEUVcda5Y4xTmOw
         Zb4YLbHSGgJdDmIBOaZyKhyto5wBaZzm3UOAAzYW6/JdX11ep/sL2WsFZ3S7CNrlm469
         IdiltQAg1dCoSUHtkFCZSxHLpuuTU36Wassnh93r/4/qXKXF1g/dNsIZIPzIUlIX6pQf
         0Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kss3S1Cb/DVH5EFUbd0F+zefWWsF2yGaX15s3OrFgzo=;
        b=Zi2rIK9wziCbitRqH8PJtxynwGLoJgSMoACLfR0MJTA6ZB05GpjZox8qJyrAdVpJuc
         OAKKbVoKIu7djFLWfBEut/X6LS7GjXx1k6KYuXQKIh2hkEkZSVQiXT5UXXTVscw6aFuB
         yd4XYQZrktc4ChMMqil3f8TxezhWYlEQeBqCpqid74Ztop3+dAtlWqKeR3/ERaAN0pe5
         qw5f//qOA33sDhv87nOMe+MCdp6SY6AQyhBZkUAr+n88gMwSFB7EeMhZAST1ilcTUQEa
         mS0geUr6qMqNmhKIBw87teo3EF8tvcAx7fd5BDHM8CmtT9GNmnwvqtGsoMvw0BQdb8HZ
         CVoA==
X-Gm-Message-State: AOAM531rEOvTu/JHrPvuyfkLJhCVW5IFXKEnqG4PtOUiglbZjlSnbsnf
        Ky5MF/+XqmQ5nepvBRc0rIti77hJq2vXONanC7FlKDMISzI=
X-Google-Smtp-Source: ABdhPJynIFjWPBc3QYW8NJzi3G9QDGodGWeOJAMrDzPFMvuh7OCPDan1w2frPRduQny/v7xNhCwhRFi5icVM4/DhW/M=
X-Received: by 2002:aca:4785:: with SMTP id u127mr6068243oia.163.1616313978473;
 Sun, 21 Mar 2021 01:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com> <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
 <20210312140104.GX2356281@nvidia.com> <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com> <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com> <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
 <20210320203832.GJ2356281@nvidia.com>
In-Reply-To: <20210320203832.GJ2356281@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 21 Mar 2021 16:06:07 +0800
Message-ID: <CAD=hENf2mcmCk+22dt8H_O1FRFUQzcLqiknEzoOma=_VR0fz+g@mail.gmail.com>
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 4:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Sat, Mar 20, 2021 at 11:38:26AM +0800, Zhu Yanjun wrote:
> > On Fri, Mar 19, 2021 at 9:48 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Fri, Mar 19, 2021 at 09:33:13PM +0800, Zhu Yanjun wrote:
> > > > On Fri, Mar 19, 2021 at 9:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > >
> > > > > On Sat, Mar 13, 2021 at 11:02:41AM +0800, Zhu Yanjun wrote:
> > > > > > On Fri, Mar 12, 2021 at 10:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > > > >
> > > > > > > On Fri, Mar 12, 2021 at 09:49:52PM +0800, Zhu Yanjun wrote:
> > > > > > > > In short, the sg list from __sg_alloc_table_from_pages is different
> > > > > > > > from the sg list from ib_umem_add_sg_table.
> > > > > > >
> > > > > > > I don't care about different. Tell me what is wrong with what we have
> > > > > > > today.
> > > > > > >
> > > > > > > I thought your first message said the sgl's were too small, but now
> > > > > > > you seem to say they are too big?
> > > > > >
> > > > > > Sure.
> > > > > >
> > > > > > The sg list from __sg_alloc_table_from_pages, length of sg is too big.
> > > > > > And the dma address is like the followings:
> > > > > >
> > > > > > "
> > > > > > sg_dma_address(sg):0x4b3c1ce000
> > > > > > sg_dma_address(sg):0x4c3c1cd000
> > > > > > sg_dma_address(sg):0x4d3c1cc000
> > > > > > sg_dma_address(sg):0x4e3c1cb000
> > > > > > "
> > > > >
> > > > > Ok, so how does too big a dma segment side cause
> > > > > __sg_alloc_table_from_pages() to return sg elements that are too
> > > > > small?
> > > > >
> > > > > I assume there is some kind of maths overflow here?
> > > > Please check this function __sg_alloc_table_from_pages
> > > > "
> > > > ...
> > > >  457                 /* Merge contiguous pages into the last SG */
> > > >  458                 prv_len = prv->length;
> > > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > > >  460                         if (prv->length + PAGE_SIZE >
> > > > max_segment)    <--max_segment is too big. So n_pages will be 0. Then
> > > > the function will goto out to exit.
> > >
> > > You already said this.
> > >
> > > You are reporting 4k pages, if max_segment is larger than 4k there is
> > > no such thing as "too big"
> > >
> > > I assume it is "too small" because of some maths overflow.
> >
> >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> >  460                         if (prv->length + PAGE_SIZE >
> > max_segment)  <--it max_segment is big, n_pages is zero.
>
> What does n_pages have to do with max_segment?

With the following snippet
"
        struct ib_umem *region;
        region = ib_umem_get(pd->device, start, len, access);

        page_size = ib_umem_find_best_pgsz(region,
                                           SZ_4K | SZ_2M | SZ_1G,
                                           virt);
"
Before the commit 0c16d9635e3a ("RDMA/umem: Move to allocate SG table
from pages"),
the variable page_size is SZ_2M.
After the commit 0c16d9635e3a ("RDMA/umem: Move to allocate SG table
from pages"),
the variable page_size is SZ_4K.

IMHO, you can reproduce this problem in your local host.

Zhu Yanjun
>
> Please try to explain clearly.
>
> Jason
