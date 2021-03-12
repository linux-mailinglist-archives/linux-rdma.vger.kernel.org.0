Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE333870A
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 09:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhCLIG0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 03:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhCLIFv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 03:05:51 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78219C061574
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 00:05:51 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so1333121ooe.9
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pn8G7hGWgySJtOdWaGuzdbaG4pbf4WRVn5n9MEL3OZk=;
        b=SYG/0oYc9OMomYJv23GpANKjp7ldk7sng2mlLonI6x4KhS35Jxd670olk2Uf1vHffX
         ey09LTQ+ih+6BC7GQoJs4GUcXxCSzuHyVhd/sSIkN19l0kb3oqKpSwUp0tcLdWRReHxI
         q7aTozvGxPU/jl/vtOm+UUmzQTQsOSYy+Tt54fmh0kblOR9JpHf1sS60bhmUkRA73yuT
         WsMJdNWZ4A1ovdbGLFddaIn2EX3tI0hIKVNEy167fB/WOi2SrqVcyV8JERH7HWv2W3qi
         oq5l3aAMAI7E+0EuI19eh4Hk7KbB78casVXTDGDdaVRek4AQbOX3ibc/P9powzFAiGbI
         PG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pn8G7hGWgySJtOdWaGuzdbaG4pbf4WRVn5n9MEL3OZk=;
        b=qBSSO4KIFtdx4aPjsBzrDU3TIbLhojbiHhbIrSRW3/UWuKtIc4xwG8m/F84lYYvDot
         PZP4xQukHRJ1AeYZv09N1yOj36P3GS9+tSgUwWdfzgZheYTFfNA9UjnANsFPOGeiXj5n
         BK8s8dN6A6ih3EISQSKSXRbRlqHDLzmzg0wQjzKNM5PPCKrbiFvYg0zIczOt4fFV2MmK
         NVOUARLg2l7dzlzsqi1GGi8j3da8Ft7hKb81E5zN3CGKl+qcvRhQOGL4N5qyGUvVb/tb
         A+WzAt3Bsj9mEnUKX2WnE0SkdwijqtOTmWeifOpFgv9PPdVjPSaSABDaja6xoE1k2qii
         Gh0A==
X-Gm-Message-State: AOAM5303Ig7BzpaIhEUxioM4Dx3qO6LWDGBaqbe5hCjsBhEiot79D2ix
        Jwk44FVO3XfQzRH7DrEqluOLp5+U0UEYGvnDcmxLhBmtQfE=
X-Google-Smtp-Source: ABdhPJyjX5/7hKR9ekLl0HyVh/psy05zmrgS7bcy+cqQAicMPkn+RcBWHWtpLVW2QscFiCKuJ2NkDduHg2bBdfN2zSI=
X-Received: by 2002:a05:6820:3c8:: with SMTP id s8mr2362606ooj.49.1615536350962;
 Fri, 12 Mar 2021 00:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20210307221034.568606-1-yanjun.zhu@intel.com> <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal> <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com> <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com> <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
In-Reply-To: <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 12 Mar 2021 16:05:39 +0800
Message-ID: <CAD=hENd1x5S4TLxWqOs4Vo-utxiqHWh2r2NZ-J9q9=HY6AO_kA@mail.gmail.com>
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

On Fri, Mar 12, 2021 at 4:04 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Fri, Mar 12, 2021 at 8:25 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Thu, Mar 11, 2021 at 06:41:43PM +0800, Zhu Yanjun wrote:
> > > On Mon, Mar 8, 2021 at 8:16 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Mon, Mar 08, 2021 at 06:13:52PM +0800, Zhu Yanjun wrote:
> > > >
> > > > > And I delved into the source code of __sg_alloc_table_from_pages. I
> > > > > found that this function is related with ib_dma_max_seg_size. So
> > > > > when ib_dma_max_seg_size is set to UINT_MAX, the sg dma address is
> > > > > 4K (one page). When ib_dma_max_seg_size is set to SZ_2M, the sg dma
> > > > > address is 2M now.
> > > >
> > > > That seems like a bug, you should fix it
> > >
> > > Hi, Jason && Leon
> > >
> > > I compared the function __sg_alloc_table_from_pages with ib_umem_add_sg_table.
> > > In __sg_alloc_table_from_pages:
> > >
> > > "
> > >  449         if (prv) {
> > >  450                 unsigned long paddr = (page_to_pfn(sg_page(prv))
> > > * PAGE_SIZE +
> > >  451                                        prv->offset + prv->length) /
> > >  452                                       PAGE_SIZE;
> > >  453
> > >  454                 if (WARN_ON(offset))
> > >  455                         return ERR_PTR(-EINVAL);
> > >  456
> > >  457                 /* Merge contiguous pages into the last SG */
> > >  458                 prv_len = prv->length;
> > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > >  460                         if (prv->length + PAGE_SIZE > max_segment)
> > >  461                                 break;
> > >  462                         prv->length += PAGE_SIZE;
> > >  463                         paddr++;
> > >  464                         pages++;
> > >  465                         n_pages--;
> > >  466                 }
> > >  467                 if (!n_pages)
> > >  468                         goto out;
> > >  469         }
> > >
> > > "
> > > if prv->length + PAGE_SIZE > max_segment, then set another sg.
> > > In the commit "RDMA/umem: Move to allocate SG table from pages",
> > > max_segment is dma_get_max_seg_size.
> > > Normally it is UINT_MAX. So in my host, prv->length + PAGE_SIZE is
> > > usually less than max_segment
> > > since length is unsigned int.
> >
> > I don't understand what you are trying to say
> >
> >   460                         if (prv->length + PAGE_SIZE > max_segment)
> >
> > max_segment should be a very big number and "prv->length + PAGE_SIZE" should
> > always be < max_segment so it should always be increasing the size of
> > prv->length and 'rpv' here is the sgl.
>
> Sure.
>
> When max_segment is UINT_MAX, prv->length is UINT_MAX - PAGE_SIZE.
> It is big. That is, segment size is UINT_MAX - PAGE_SIZE.
>
> But from the function ib_umem_add_sg_table, the prv->length is SZ_2M.
> That is, segment size if SZ_2M.
>
> It is the difference between the 2 functions.

BTW, my commit is to fix this difference.

Zhu Yanjun

>
> Zhu Yanjun
>
>
> >
> > The other loops are the same.
> >
> > Jason
