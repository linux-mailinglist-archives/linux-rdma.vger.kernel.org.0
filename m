Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31582342A46
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Mar 2021 04:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCTDuR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 23:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhCTDuH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Mar 2021 23:50:07 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93A0C061761
        for <linux-rdma@vger.kernel.org>; Fri, 19 Mar 2021 20:50:06 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id k25so6928016oic.4
        for <linux-rdma@vger.kernel.org>; Fri, 19 Mar 2021 20:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcqJsfwlxGKqYglAxBMtgcLJpIBVOLXBFQ5fj3zFR98=;
        b=b91S/NRaNws+PS4bYJvswfGieS+xbj8PJf5KnkERfaNs019fiXiPep6/4KSeaNJpmN
         tRWr+6CS5TJliepdAjKb4r2lg7FQrfyRxtzwSo1hAn0woUYG8p7oexsm/MFNFAtxcsKJ
         3x5cxCLE9+h5FwsNnuVQJemyc00/6Pp3PAXuCx5jwu1S9H17yyFnRYcZuUH4nUV71VVe
         +0g0PM8kQ2wt5pDiJ/8sLocjLMRDUOADeW4mrz+4RbxafY0zQPDbDk/jXfJJUSK15yk4
         PXDjSusspdBS8Ta22r8lhVgsIWkPoS1iPltmhnGhDPJC63PmTatVhUNLcVF/oem7qJTN
         /pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcqJsfwlxGKqYglAxBMtgcLJpIBVOLXBFQ5fj3zFR98=;
        b=sxp0llrFW3VtlQFhwZ7AtrqMk1nOjJvBujdQNgwHVAv6LTiQz+ACdpVbySNMlnOnIa
         4UAp4ww0AcDcmKsTuZfQrZUxuN/bHq8lfunbLt+eMQKXui6FDB4g7csCiU0s/ITTkCyy
         RBCPE0YTPfdWI6Mm3tsGCvMn3GSyaOFvzoomF6Z9AiecShUz0m4FhfHM4VP50sLsiwlV
         k53pflPZNlfzUQmhf+nFUA27zh0acBMRC75H8UCuDGghOHEJQj1793m+Xv6bDcbtNVMn
         QCpiFkiVU1EjiaLMIvcna9aYJr+e6T4/uSR6YOxtMZczSXQGGHk3xalhuQoS0oQmFvoo
         365A==
X-Gm-Message-State: AOAM533IsbQx6oxr47fOy7wSIuq1CNfUUXlaCklYiYLKXJyXzPx/0lb8
        pPIsp9V89wYJ6HrZca1sFlMqWeTxsu6fXb5lQKwK5pbFDxU=
X-Google-Smtp-Source: ABdhPJwWKA8djU73UIR1whTvpFVY0QgOQYpa7eWFuSyV9gdEzOPyXU35fTBH5XvuDa9ZPv/5vYDLw6U3jVKri0ZUhgw=
X-Received: by 2002:aca:4785:: with SMTP id u127mr3048689oia.163.1616212203587;
 Fri, 19 Mar 2021 20:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com> <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com> <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
 <20210312140104.GX2356281@nvidia.com> <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com> <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com> <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
In-Reply-To: <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 20 Mar 2021 11:49:52 +0800
Message-ID: <CAD=hENcaiZeFo4G4vyyEJnmHTci-vmcb4qvq_uZ0g_oKowqTkw@mail.gmail.com>
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

On Sat, Mar 20, 2021 at 11:38 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Fri, Mar 19, 2021 at 9:48 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Mar 19, 2021 at 09:33:13PM +0800, Zhu Yanjun wrote:
> > > On Fri, Mar 19, 2021 at 9:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Sat, Mar 13, 2021 at 11:02:41AM +0800, Zhu Yanjun wrote:
> > > > > On Fri, Mar 12, 2021 at 10:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 12, 2021 at 09:49:52PM +0800, Zhu Yanjun wrote:
> > > > > > > In short, the sg list from __sg_alloc_table_from_pages is different
> > > > > > > from the sg list from ib_umem_add_sg_table.
> > > > > >
> > > > > > I don't care about different. Tell me what is wrong with what we have
> > > > > > today.
> > > > > >
> > > > > > I thought your first message said the sgl's were too small, but now
> > > > > > you seem to say they are too big?
> > > > >
> > > > > Sure.
> > > > >
> > > > > The sg list from __sg_alloc_table_from_pages, length of sg is too big.
> > > > > And the dma address is like the followings:
> > > > >
> > > > > "
> > > > > sg_dma_address(sg):0x4b3c1ce000
> > > > > sg_dma_address(sg):0x4c3c1cd000
> > > > > sg_dma_address(sg):0x4d3c1cc000
> > > > > sg_dma_address(sg):0x4e3c1cb000
> > > > > "
> > > >
> > > > Ok, so how does too big a dma segment side cause
> > > > __sg_alloc_table_from_pages() to return sg elements that are too
> > > > small?
> > > >
> > > > I assume there is some kind of maths overflow here?
> > > Please check this function __sg_alloc_table_from_pages
> > > "
> > > ...
> > >  457                 /* Merge contiguous pages into the last SG */
> > >  458                 prv_len = prv->length;
> > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > >  460                         if (prv->length + PAGE_SIZE >
> > > max_segment)    <--max_segment is too big. So n_pages will be 0. Then
> > > the function will goto out to exit.
> >
> > You already said this.
> >
> > You are reporting 4k pages, if max_segment is larger than 4k there is
> > no such thing as "too big"
> >
> > I assume it is "too small" because of some maths overflow.
>
>  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
>  460                         if (prv->length + PAGE_SIZE >
> max_segment)  <--it max_segment is big, n_pages is zero.
>  461                                 break;
>  462                         prv->length += PAGE_SIZE;
>  463                         paddr++;
>  464                         pages++;
>  465                         n_pages--;
>  466                 }
>  467                 if (!n_pages)   <---here, this function will goto out.
>  468                         goto out;
> ...
>  509                 chunk_size = ((j - cur_page) << PAGE_SHIFT) - offset;
>  510                 sg_set_page(s, pages[cur_page],
>  511                             min_t(unsigned long, size,
> chunk_size), offset); <----this function will not have many chance to
> be called if max_segment is big.
>  512                 added_nents++;
>  513                 size -= chunk_size;
>
> If the max_segment is not big enough, for example it is SZ-2M,
> sg_set_page will be called every SZ_2M.
> To now, I do not find any math overflow.

147 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
148                             size_t size, int access)
149 {
...
244         umem->nmap =
245                 ib_dma_map_sg_attrs(device, umem->sg_head.sgl,
umem->sg_nents,
246                                     DMA_BIDIRECTIONAL, dma_attr);
...

And after the function ib_dma_map_sg_attrs, dma address is set.
To now, I can not find maths overflow.

Zhu Yanjun


>
> Zhu Yanjun
> >
> > You should add some prints and find out what is going on.
> >
> > Jason
