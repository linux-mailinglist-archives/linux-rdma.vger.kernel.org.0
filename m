Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD2C338F02
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 14:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhCLNnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 08:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhCLNmj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 08:42:39 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00A0C061574
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 05:42:39 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so1401024otn.1
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsOMIv74UijrRNT/WGp+ug4NAuV9jEk9bWtUfdSTJeE=;
        b=aJ5EdCOnT0pULYJ2WCZwgeOQD+uY9gPqq+V+6lhva5eQgiryFvCeejQ4Balybc+n73
         nRxrnCyXFxA8vKL8+D4xhezm2jtXRINjb+P7/E1KjMyoKa3ZNzCWeRuJLpNegDcCdqeB
         HDXxDcyU65bHWClXPPKe0zqoIITpSHOCi8VmvFkquUI+Wxl1FNNPkh+vp4+sIjtZVc1L
         Qve3BbTwg+B/XCly1EMaOZMxqlN+GgfOhKSzr6yVvspzMpzRyq25DSAKyxwgUgLGmpVM
         snURKICJQoKZrQP+uGSE+iDue9q56cAEU9Pyqd8r/CFNGRyV+W3x+uJKbrkyXKvCHKiv
         hj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsOMIv74UijrRNT/WGp+ug4NAuV9jEk9bWtUfdSTJeE=;
        b=b+b2y/2BTczFvWI0CSmggx32YLcMtxcp4Snf5uC+X1sqf20FbAmxO9UbIcbAy0aG2B
         vx5XtwFpKc/kBsUiSY3N3e7RzTaWIup/n2CStAKjrQI13vyLw5VVP8oodH9NVyi7c0J5
         9BKUCkABJapm3dRWWmlSutSJqUngsh7kUEd3V7MONz3dV3EM89KicYmvTy3s6t/jdS4o
         bArjvPmPhY/9ZTMJpJykQwSLdmgJBN3BvgzzFxKzVb+lT7BdRo1pYx6vtBYFdWPMnuDH
         iPsU0llQ6EJDZPXFV3HblBdDAKQg0m9FDAZWxUATGBkD50W2rLuEuBpuhNuIGTBs+nWn
         QCvA==
X-Gm-Message-State: AOAM5323o6DpI0uhC6eHKvNLVdr6cRFNE3uTgIgjbWV0dkWynVLhilsq
        uWrjw/HMsnvvqzaSUJm4pQ24tceBP3kRc+x696jKA1ulhglnkg==
X-Google-Smtp-Source: ABdhPJxFy/1ZQDBF74HfAPDRgQ9rJ7JhTAw0ApM5dpCVeSCf73vV+P4f8D9WbCLGmpB/dxoru0DBnRVh8DAzgsui1TE=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr3390120otr.59.1615556559039;
 Fri, 12 Mar 2021 05:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20210307221034.568606-1-yanjun.zhu@intel.com> <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal> <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com> <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com> <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com>
In-Reply-To: <20210312130243.GU2356281@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 12 Mar 2021 21:42:28 +0800
Message-ID: <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
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

On Fri, Mar 12, 2021 at 9:02 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Mar 12, 2021 at 04:04:35PM +0800, Zhu Yanjun wrote:
> > On Fri, Mar 12, 2021 at 8:25 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Thu, Mar 11, 2021 at 06:41:43PM +0800, Zhu Yanjun wrote:
> > > > On Mon, Mar 8, 2021 at 8:16 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > >
> > > > > On Mon, Mar 08, 2021 at 06:13:52PM +0800, Zhu Yanjun wrote:
> > > > >
> > > > > > And I delved into the source code of __sg_alloc_table_from_pages. I
> > > > > > found that this function is related with ib_dma_max_seg_size. So
> > > > > > when ib_dma_max_seg_size is set to UINT_MAX, the sg dma address is
> > > > > > 4K (one page). When ib_dma_max_seg_size is set to SZ_2M, the sg dma
> > > > > > address is 2M now.
> > > > >
> > > > > That seems like a bug, you should fix it
> > > >
> > > > Hi, Jason && Leon
> > > >
> > > > I compared the function __sg_alloc_table_from_pages with ib_umem_add_sg_table.
> > > > In __sg_alloc_table_from_pages:
> > > >
> > > > "
> > > >  449         if (prv) {
> > > >  450                 unsigned long paddr = (page_to_pfn(sg_page(prv))
> > > > * PAGE_SIZE +
> > > >  451                                        prv->offset + prv->length) /
> > > >  452                                       PAGE_SIZE;
> > > >  453
> > > >  454                 if (WARN_ON(offset))
> > > >  455                         return ERR_PTR(-EINVAL);
> > > >  456
> > > >  457                 /* Merge contiguous pages into the last SG */
> > > >  458                 prv_len = prv->length;
> > > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > > >  460                         if (prv->length + PAGE_SIZE > max_segment)
> > > >  461                                 break;
> > > >  462                         prv->length += PAGE_SIZE;
> > > >  463                         paddr++;
> > > >  464                         pages++;
> > > >  465                         n_pages--;
> > > >  466                 }
> > > >  467                 if (!n_pages)
> > > >  468                         goto out;
> > > >  469         }
> > > >
> > > > "
> > > > if prv->length + PAGE_SIZE > max_segment, then set another sg.
> > > > In the commit "RDMA/umem: Move to allocate SG table from pages",
> > > > max_segment is dma_get_max_seg_size.
> > > > Normally it is UINT_MAX. So in my host, prv->length + PAGE_SIZE is
> > > > usually less than max_segment
> > > > since length is unsigned int.
> > >
> > > I don't understand what you are trying to say
> > >
> > >   460                         if (prv->length + PAGE_SIZE > max_segment)
> > >
> > > max_segment should be a very big number and "prv->length + PAGE_SIZE" should
> > > always be < max_segment so it should always be increasing the size of
> > > prv->length and 'rpv' here is the sgl.
> >
> > Sure.
> >
> > When max_segment is UINT_MAX, prv->length is UINT_MAX - PAGE_SIZE.
> > It is big. That is, segment size is UINT_MAX - PAGE_SIZE.
> >
> > But from the function ib_umem_add_sg_table, the prv->length is SZ_2M.
> > That is, segment size if SZ_2M.
> >
> > It is the difference between the 2 functions.
>
> I still have no idea what you are trying to say. Why would prv->length
> be 'UINT - PAGE_SIZE'? That sounds like max_segment

Sure. whatever, this prv->length from __sg_alloc_table_from_pages
is greater than sg->length from the function ib_umem_add_sg_table.

__sg_alloc_table_from_pages:
"
 457                 /* Merge contiguous pages into the last SG */
 458                 prv_len = prv->length;
 459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
 460                         if (prv->length + PAGE_SIZE >
max_segment)  <-------------- prv->length > max_segment - PAGE_SIZE
 461                                 break;
 462                         prv->length += PAGE_SIZE;
 463                         paddr++;
 464                         pages++;
 465                         n_pages--;
 466                 }
 467                 if (!n_pages)
 468                         goto out;
"

Zhu Yanjun
>
> Jason
