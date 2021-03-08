Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87EB330AEC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Mar 2021 11:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhCHKOT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Mar 2021 05:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhCHKOE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Mar 2021 05:14:04 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174E8C06174A
        for <linux-rdma@vger.kernel.org>; Mon,  8 Mar 2021 02:14:04 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 75so5392016otn.4
        for <linux-rdma@vger.kernel.org>; Mon, 08 Mar 2021 02:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgn85oB2pm1ikwqMSjngNApSWjIy6EOl8lih9+v/apc=;
        b=bwBPuWg8L8WaleGzDTv34YlAhiUDf3bqZGnXqoJKn0raJPaHNewE2hZKDLEP95MaqN
         GMM707ZHWAo6BvHiANATrOB3nqIBDsgmpiygcjDjVyNXfnG6pWuFpNMnZEzmBIEJA3aA
         d7LZOx1HombIUs7jMUyZrjMEmliPzVVmbT5L97x9ldbqB72810SbFH9b7axpXHhNNgsY
         M46YqpMqYoUV1bs0JzC0HiS8fAI4sp64qd9ja0hk36Qre6Thnet2QN2BoxvBpwFPohYz
         80GQrFwgMd8rx3IHwxaKyCwGPVfrVjLDpxGdvtR9VBzSpfqYbLmmvwdEMaRz9H58WPE6
         vyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgn85oB2pm1ikwqMSjngNApSWjIy6EOl8lih9+v/apc=;
        b=BXMMyGNk2cfVkpIStHl+hNGD07WgwOei+pUWYvPc5O0xnm2nU6yWq2gEzD+yUkvfT/
         nwCU3zfctTaPzt8QOBgu4ETeJW7QhwmV0bvwrgIf9NiO1cLfC/kcvO+imUcise1fa9iu
         q7CkPsPznjLhb9w7rfzj0Flgh0U8Eskkmum5AI8YolLYRXlefs7sSk/+C5TmqhrGfNdp
         GhNT5Hjcc0nyJ3BaBNULfgAH5l+R9cGpHFkfE7zJ00a6+1KgcDb79yRlZoVso1O/8SUC
         lW5HAQTgOUwnD9D3sycDEt2hqeD0MOiMOHpN3KmZE7oHvUHGW25N5U0X4SK/dLh/nvhC
         VOew==
X-Gm-Message-State: AOAM532JjrF01665MMemYalcMVGSMn2qrygi8fie4zwWYh2FkUP9FOe5
        qFpuDg0G2vjGs802/1Xb3BCh6bp6Eu0uSzKBkWM=
X-Google-Smtp-Source: ABdhPJzIK/Bhj1lQ/ou6AoKH4lMCa2498/1lQSRGekmOvffZpWDOnPecpmR4nU0Enkb/VHfsB2Frndul17e9c0A4VwM=
X-Received: by 2002:a9d:7650:: with SMTP id o16mr10212021otl.278.1615198443390;
 Mon, 08 Mar 2021 02:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20210307221034.568606-1-yanjun.zhu@intel.com> <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal>
In-Reply-To: <YEUL2vdlWFEbZqLb@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 8 Mar 2021 18:13:52 +0800
Message-ID: <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 8, 2021 at 1:22 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Mar 07, 2021 at 10:28:33PM +0800, Zhu Yanjun wrote:
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> >
> > After the commit ("RDMA/umem: Move to allocate SG table from pages"),
> > the sg list from ib_ume_get is like the following:
> > "
> > sg_dma_address(sg):0x4b3c1ce000
> > sg_dma_address(sg):0x4c3c1cd000
> > sg_dma_address(sg):0x4d3c1cc000
> > sg_dma_address(sg):0x4e3c1cb000
> > "
> >
> > But sometimes, we need sg list like the following:
> > "
> > sg_dma_address(sg):0x203b400000
> > sg_dma_address(sg):0x213b200000
> > sg_dma_address(sg):0x223b000000
> > sg_dma_address(sg):0x233ae00000
> > sg_dma_address(sg):0x243ac00000
> > "
> > The function ib_umem_add_sg_table can provide the sg list like the
> > second. And this function is removed in the commit ("RDMA/umem: Move
> > to allocate SG table from pages"). Now I add it back.
> >
> > The new function is ib_umem_get to ib_umem_hugepage_get that calls
> > ib_umem_add_sg_table.
> >
> > This function ib_umem_huagepage_get can get 4K, 2M sg list dma address.
> >
> > Fixes: 0c16d9635e3a ("RDMA/umem: Move to allocate SG table from pages")
> > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > ---
> >  drivers/infiniband/core/umem.c | 197 +++++++++++++++++++++++++++++++++
> >  include/rdma/ib_umem.h         |   3 +
> >  2 files changed, 200 insertions(+)
>
> You didn't use newly introduced function and didn't really explain why

Thanks Leon and Jason.
Now I set ib_dma_max_seg_size to SZ_2M. Then this problem is fixed.
This problem is caused by the capacity parameter of our device.

Originally the ib_dma_max_seg_size is set to UINT_MAX. Then the sg dma
address is different from
the ones before the commit ("RDMA/umem: Move to allocate SG table from pages").

And I delved into the source code of __sg_alloc_table_from_pages. I
found that this function is
related with ib_dma_max_seg_size. So when ib_dma_max_seg_size is set
to UINT_MAX, the sg dma
address is 4K (one page). When ib_dma_max_seg_size is set to SZ_2M,
the sg dma address is 2M now.

The function ib_umem_add_sg_table is not related with
ib_dma_max_seg_size. So the value of  ib_dma_max_seg_size
does not affect sg dma address.

Anyway, this problem is not caused by the function __sg_alloc_table_from_pages.

Please ignore this commit.

Zhu Yanjun

> it is needed.
>
> Thanks
