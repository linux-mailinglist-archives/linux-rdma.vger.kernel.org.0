Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BBB342A34
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Mar 2021 04:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCTDi6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 23:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCTDit (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Mar 2021 23:38:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D0C061761
        for <linux-rdma@vger.kernel.org>; Fri, 19 Mar 2021 20:38:37 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so10434468ota.9
        for <linux-rdma@vger.kernel.org>; Fri, 19 Mar 2021 20:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXAQQhhZ6Z4FADLIixGVBdclYoUEwajh1CnmCPEodP0=;
        b=Hc99kp+E8JsAMUN3fixEI5FEze05laOViKvueAqTPFwQQdUpaZpiWVFgEgKaVZ3xPS
         xPpSaf33SGK1lM4UOYrrWfrhkADVBcWZMVlws/MvTIpCnEbdBHSTRGHZr1z/lhiIbMsi
         BvKymcyb6b6T1P/WxxWCDoIFFPlrg+gKyfEI/Ltqgtztcy85V0Ew85ulp83Ls4SRukMx
         q3/71lnBaUwl9YUkZ5/m4DO21a2ChtlHTyA2ES24CEnf5ca6KhgGslgZdYWDJIhHFB97
         shIZGlWrikMoYsHc+ZrZRuuFy6rjS6nsliIah/g/sCdDhZnVEqbXhtVBR8n+ZfgVYTPw
         +ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXAQQhhZ6Z4FADLIixGVBdclYoUEwajh1CnmCPEodP0=;
        b=TwMnSOBMfhLS3ckhwrcpillfHKPfoLRvwmG0xiKPVOyIIzduOmXJZkr9J7tvoB91Zz
         2nkcej9N0FAuOKPEZopAzlelPbPn7sj0ey+YyrPm7A2qcTWvN1CQz/+wPefCWtGu9Ijm
         gAEJt9Dh33MOZlypbBAIPAgOCTXJ49FyyGAO/RhRhLcxFfnhanxmncS0w6FcCY3pmHYn
         CBYjqNkXBbmvRqJnsc8k96wRslB4pLCyZaIa+2F1mr7nZYdwWvRGq2gDifDKKZ4mBGD1
         pbuU4y7lcDj71Ztk5vG/sKoaG+iVhL1bIegH3BdzcXHW4mlce/+clYtyIHtmQzsWeOZu
         H+yA==
X-Gm-Message-State: AOAM530ettMjLxpcDH5H9kLUYw8uk4KLGIqPJlGHP7ZMymx/RNkDCZDL
        OkUtc9FZxBDSpDx81kwzajq0UqxJsF+WjTMukfM=
X-Google-Smtp-Source: ABdhPJxdRzdprkWZrUjRrM8H2GQ294MFUSPLPOoLpxTacnON5W6FM95jw5TVsnO0RBkGZEBOG3/gTaDW8TnuU/B2vdc=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr3505931otr.59.1616211517212;
 Fri, 19 Mar 2021 20:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com> <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com> <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
 <20210312140104.GX2356281@nvidia.com> <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com> <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com>
In-Reply-To: <20210319134845.GR2356281@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 20 Mar 2021 11:38:26 +0800
Message-ID: <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
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

On Fri, Mar 19, 2021 at 9:48 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Mar 19, 2021 at 09:33:13PM +0800, Zhu Yanjun wrote:
> > On Fri, Mar 19, 2021 at 9:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Sat, Mar 13, 2021 at 11:02:41AM +0800, Zhu Yanjun wrote:
> > > > On Fri, Mar 12, 2021 at 10:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > >
> > > > > On Fri, Mar 12, 2021 at 09:49:52PM +0800, Zhu Yanjun wrote:
> > > > > > In short, the sg list from __sg_alloc_table_from_pages is different
> > > > > > from the sg list from ib_umem_add_sg_table.
> > > > >
> > > > > I don't care about different. Tell me what is wrong with what we have
> > > > > today.
> > > > >
> > > > > I thought your first message said the sgl's were too small, but now
> > > > > you seem to say they are too big?
> > > >
> > > > Sure.
> > > >
> > > > The sg list from __sg_alloc_table_from_pages, length of sg is too big.
> > > > And the dma address is like the followings:
> > > >
> > > > "
> > > > sg_dma_address(sg):0x4b3c1ce000
> > > > sg_dma_address(sg):0x4c3c1cd000
> > > > sg_dma_address(sg):0x4d3c1cc000
> > > > sg_dma_address(sg):0x4e3c1cb000
> > > > "
> > >
> > > Ok, so how does too big a dma segment side cause
> > > __sg_alloc_table_from_pages() to return sg elements that are too
> > > small?
> > >
> > > I assume there is some kind of maths overflow here?
> > Please check this function __sg_alloc_table_from_pages
> > "
> > ...
> >  457                 /* Merge contiguous pages into the last SG */
> >  458                 prv_len = prv->length;
> >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> >  460                         if (prv->length + PAGE_SIZE >
> > max_segment)    <--max_segment is too big. So n_pages will be 0. Then
> > the function will goto out to exit.
>
> You already said this.
>
> You are reporting 4k pages, if max_segment is larger than 4k there is
> no such thing as "too big"
>
> I assume it is "too small" because of some maths overflow.

 459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
 460                         if (prv->length + PAGE_SIZE >
max_segment)  <--it max_segment is big, n_pages is zero.
 461                                 break;
 462                         prv->length += PAGE_SIZE;
 463                         paddr++;
 464                         pages++;
 465                         n_pages--;
 466                 }
 467                 if (!n_pages)   <---here, this function will goto out.
 468                         goto out;
...
 509                 chunk_size = ((j - cur_page) << PAGE_SHIFT) - offset;
 510                 sg_set_page(s, pages[cur_page],
 511                             min_t(unsigned long, size,
chunk_size), offset); <----this function will not have many chance to
be called if max_segment is big.
 512                 added_nents++;
 513                 size -= chunk_size;

If the max_segment is not big enough, for example it is SZ-2M,
sg_set_page will be called every SZ_2M.
To now, I do not find any math overflow.

Zhu Yanjun
>
> You should add some prints and find out what is going on.
>
> Jason
