Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9667C341E68
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 14:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhCSNdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCSNdZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Mar 2021 09:33:25 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6007FC06174A
        for <linux-rdma@vger.kernel.org>; Fri, 19 Mar 2021 06:33:25 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n8so4759422oie.10
        for <linux-rdma@vger.kernel.org>; Fri, 19 Mar 2021 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3KqGG2b0FbptmKMEEFQYnzFMmqIWUd0wdQzR94hG8Y=;
        b=A3m6FGSyjwXg3XXfs0fPtYtI7L1F2kOCYNkjFzDmih1G1t4JYs6LGj+7/eVNEO4R66
         Cf34hkZhU+W2m76HQNK/JrU+x5zPJ+fFl421JW1nnaSILuCcOtaLSU/WBwQLVyh8Hpzq
         YFwN5W8bnagPx7KVTshuJIaWpB2QnvpvJADKpNx4/IbpwceV2oaIiFqMtYIL5zSBKQOD
         ujxPnZFN5Vo/vveJYF9NqZQtvO1ITb3rX+vPvg7k+MhPslsPmO+oCyhekaO8hD8w5reJ
         bF/ahnUy9QufPQ7vi4pknU6HNDIPZI5+n6H1QYOhyaYKzPVj+vs+XHgCBCv2fOQHhbbs
         VPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3KqGG2b0FbptmKMEEFQYnzFMmqIWUd0wdQzR94hG8Y=;
        b=nlvgL1rUV0YMTbV6ig7Yk/H2XjjVmF074AY3Fmvm0jN75hlTGoDQfLtTMhQzeuTLvp
         Qb/WHC+ytOvyaBh975G7jzvIiEVQRbSTPFm9blwNp9sivw2n6NojbV4EmlIZhL5mwQCl
         wuvbMszAj1+bo6MU1LRrqVjSMC9aQpFbZ4cH6vz//g77mvjaLf2TpIkBChbqWaTmhAPB
         1mK3m3KTBs9q4cWMWhpRf1XWVFoqYFJ7cQxLZKyhpTPqM4o/vSc5hdty7p9oOi00HyVb
         NkWHp43YAcjTGqsVop7PY1wypmUBE52HKH0QZa3BPeOvukfiWSUk8qb4KZq1/W04Z6BH
         5bTg==
X-Gm-Message-State: AOAM530XorhYmIOF8U5MZriAErvs3ssKrbVDtKM5/loB/FtYqtjrz8QM
        ABFHquwYMNfI/xDwcAyUERhGcNpE/MElZvybixZB9VyAk0o=
X-Google-Smtp-Source: ABdhPJwdlmmJWE+lnfPYTTVOY0pUqiOwEIPcg/iZGkCChEczAkDDOhpjakNBfkf6imbzgbVBA2uSmuV2rbW6hFjSkII=
X-Received: by 2002:a05:6808:5cb:: with SMTP id d11mr1014363oij.169.1616160804674;
 Fri, 19 Mar 2021 06:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com> <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com> <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com> <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
 <20210312140104.GX2356281@nvidia.com> <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com>
In-Reply-To: <20210319130059.GQ2356281@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 19 Mar 2021 21:33:13 +0800
Message-ID: <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
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

On Fri, Mar 19, 2021 at 9:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Sat, Mar 13, 2021 at 11:02:41AM +0800, Zhu Yanjun wrote:
> > On Fri, Mar 12, 2021 at 10:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Fri, Mar 12, 2021 at 09:49:52PM +0800, Zhu Yanjun wrote:
> > > > In short, the sg list from __sg_alloc_table_from_pages is different
> > > > from the sg list from ib_umem_add_sg_table.
> > >
> > > I don't care about different. Tell me what is wrong with what we have
> > > today.
> > >
> > > I thought your first message said the sgl's were too small, but now
> > > you seem to say they are too big?
> >
> > Sure.
> >
> > The sg list from __sg_alloc_table_from_pages, length of sg is too big.
> > And the dma address is like the followings:
> >
> > "
> > sg_dma_address(sg):0x4b3c1ce000
> > sg_dma_address(sg):0x4c3c1cd000
> > sg_dma_address(sg):0x4d3c1cc000
> > sg_dma_address(sg):0x4e3c1cb000
> > "
>
> Ok, so how does too big a dma segment side cause
> __sg_alloc_table_from_pages() to return sg elements that are too
> small?
>
> I assume there is some kind of maths overflow here?
Please check this function __sg_alloc_table_from_pages
"
...
 457                 /* Merge contiguous pages into the last SG */
 458                 prv_len = prv->length;
 459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
 460                         if (prv->length + PAGE_SIZE >
max_segment)    <--max_segment is too big. So n_pages will be 0. Then
the function will goto out to exit.
 461                                 break;
 462                         prv->length += PAGE_SIZE;
 463                         paddr++;
 464                         pages++;
 465                         n_pages--;
 466                 }
 467                 if (!n_pages)
 468                         goto out;
...
"

>
> Jason
