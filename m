Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96900338706
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 09:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhCLIFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 03:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhCLIEr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 03:04:47 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E010C061574
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 00:04:47 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id m1so3015116ote.10
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 00:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61RBLYpuLkTbNmCdUQspwMiAyejBUwtVN6AGI3SysTs=;
        b=eec+Y3PhEc3paTyzaxUZpF8hpM21kHyddMozyccYHUxwSRxRpOtQWEcxoLgsyaKixq
         qYGEmlYEKDsCC1Mik4zdhyc23lBfNwrbPbKUJDie/U8c+bx+noN2RvqFH61QQsi/1zsv
         50IXkpULexLYk+oxHinHbCF5FgQ7B+oUv84PWAyAB4+G8USfjGnA50D01WzDWR22vKTm
         w/JxY5vYJawctjAUDUrkF+Zjs+l64jp2GT79F83qxw1LrUR4yRPIMn+d/8mC8DJRwyzS
         P9j+a3WrrJOs/bInxMTuW1yTpoL3Bt+lYOcydKhFqshfL2y2WhIY0BQvDKZQFJVKqEFq
         E6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61RBLYpuLkTbNmCdUQspwMiAyejBUwtVN6AGI3SysTs=;
        b=L54RyFkBWDgA4OW4z7ATx6ToIAwTBP4g0WFCxD7rEezXvVa8SOlk0iwFoh3EbC+Q3Z
         PDs7Sb5c8ix+nQhYDvWbEVm9sb3laTB6iGbd+9v9/Qcct5BR9GnTov98/32qAxMuTxVW
         lrHBreSJeJkylXm5Gt+MLKI7mw4FcaK5WEPAzw9HiD9UHwMZJa9JX62OltJi0uun1I4d
         PQOHpTO3eo5jGN4drapYXXH1c6thqkjZcRJ0oqZ4XyIkowG11Wpd/4UW0/2D+VN0LoPV
         rvyR6Wmu/hCkaxe0zGEaaNp7aA/AWVMB+R02zJlnkVW4pItTFwSSg7iKEVjPCILpwao3
         QRkQ==
X-Gm-Message-State: AOAM533nva4l0i/IsJ8WqqzIEerpce3LHRrYh83YLTVVL1A1MKWbPj9Y
        9ZgxDS5ofzF2uN+DFOOGSHszy0pLZXAOhdsgERDv5CLl5NkYFA==
X-Google-Smtp-Source: ABdhPJx5+GND0asutSAX3Edgt7lRuOI060Vu/MQsMZUd1ksPIx0xPRIjnj0TNe9w54P5DU5FQnibwJ4rIwJBM+3W8+Q=
X-Received: by 2002:a05:6830:1c26:: with SMTP id f6mr2438727ote.53.1615536286897;
 Fri, 12 Mar 2021 00:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20210307221034.568606-1-yanjun.zhu@intel.com> <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal> <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com> <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com>
In-Reply-To: <20210312002533.GS2356281@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 12 Mar 2021 16:04:35 +0800
Message-ID: <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
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

On Fri, Mar 12, 2021 at 8:25 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Mar 11, 2021 at 06:41:43PM +0800, Zhu Yanjun wrote:
> > On Mon, Mar 8, 2021 at 8:16 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Mon, Mar 08, 2021 at 06:13:52PM +0800, Zhu Yanjun wrote:
> > >
> > > > And I delved into the source code of __sg_alloc_table_from_pages. I
> > > > found that this function is related with ib_dma_max_seg_size. So
> > > > when ib_dma_max_seg_size is set to UINT_MAX, the sg dma address is
> > > > 4K (one page). When ib_dma_max_seg_size is set to SZ_2M, the sg dma
> > > > address is 2M now.
> > >
> > > That seems like a bug, you should fix it
> >
> > Hi, Jason && Leon
> >
> > I compared the function __sg_alloc_table_from_pages with ib_umem_add_sg_table.
> > In __sg_alloc_table_from_pages:
> >
> > "
> >  449         if (prv) {
> >  450                 unsigned long paddr = (page_to_pfn(sg_page(prv))
> > * PAGE_SIZE +
> >  451                                        prv->offset + prv->length) /
> >  452                                       PAGE_SIZE;
> >  453
> >  454                 if (WARN_ON(offset))
> >  455                         return ERR_PTR(-EINVAL);
> >  456
> >  457                 /* Merge contiguous pages into the last SG */
> >  458                 prv_len = prv->length;
> >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> >  460                         if (prv->length + PAGE_SIZE > max_segment)
> >  461                                 break;
> >  462                         prv->length += PAGE_SIZE;
> >  463                         paddr++;
> >  464                         pages++;
> >  465                         n_pages--;
> >  466                 }
> >  467                 if (!n_pages)
> >  468                         goto out;
> >  469         }
> >
> > "
> > if prv->length + PAGE_SIZE > max_segment, then set another sg.
> > In the commit "RDMA/umem: Move to allocate SG table from pages",
> > max_segment is dma_get_max_seg_size.
> > Normally it is UINT_MAX. So in my host, prv->length + PAGE_SIZE is
> > usually less than max_segment
> > since length is unsigned int.
>
> I don't understand what you are trying to say
>
>   460                         if (prv->length + PAGE_SIZE > max_segment)
>
> max_segment should be a very big number and "prv->length + PAGE_SIZE" should
> always be < max_segment so it should always be increasing the size of
> prv->length and 'rpv' here is the sgl.

Sure.

When max_segment is UINT_MAX, prv->length is UINT_MAX - PAGE_SIZE.
It is big. That is, segment size is UINT_MAX - PAGE_SIZE.

But from the function ib_umem_add_sg_table, the prv->length is SZ_2M.
That is, segment size if SZ_2M.

It is the difference between the 2 functions.

Zhu Yanjun


>
> The other loops are the same.
>
> Jason
