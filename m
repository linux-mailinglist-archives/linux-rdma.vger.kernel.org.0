Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E503B8120
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 13:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhF3LT2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 07:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhF3LT2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 07:19:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71FDC61416;
        Wed, 30 Jun 2021 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625051819;
        bh=gUK7CVS8e2cXpIkn5P9a80Ni/fjjiEdxLr686zwbYwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrE5xBZGvBzxMMDr7xPpC0LgFueWQu9wnpPgxKFozVNI8/77In5i8c/hdO5MtVNMC
         RVEOP5F5mHswSXrFPMxFi7/iAel9d4oGLGucGIc7r9FEpoKRJZcQ2HVWGjvG5VU69Q
         c6cjOrpWuI+1VjsBTf1qKdsQQ3D4afJAQrbf/4rqnfptmLydhn4PAhaWaB9I/Tsbdp
         ldRiKGTkwLmboPAvmvH0tfaKael5yebU5xrM108RV5xDelyF1SYVwz4c8V7MQGY2LB
         okwz61hRCid9ECCu5DhsCWAgdpyNIkdX0wBxVdoeQjrUMcUxYe1uL0oLn267Ja83oM
         bDJsfPF7DHZvg==
Date:   Wed, 30 Jun 2021 14:16:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YNxSqOeECXGG2fX8@unreal>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <CGME20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4@eucas1p2.samsung.com>
 <a9462d67-2279-93f1-e042-d46033c208df@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9462d67-2279-93f1-e042-d46033c208df@samsung.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 30, 2021 at 01:12:26PM +0200, Marek Szyprowski wrote:
> Hi Leon,
> 
> On 29.06.2021 10:40, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@nvidia.com>
> >
> > orig_nents should represent the number of entries with pages,
> > but __sg_alloc_table_from_pages sets orig_nents as the number of
> > total entries in the table. This is wrong when the API is used for
> > dynamic allocation where not all the table entries are mapped with
> > pages. It wasn't observed until now, since RDMA umem who uses this
> > API in the dynamic form doesn't use orig_nents implicit or explicit
> > by the scatterlist APIs.
> >
> > Fix it by:
> > 1. Set orig_nents as number of entries with pages also in
> >     __sg_alloc_table_from_pages.
> > 2. Add a new field total_nents to reflect the total number of entries
> >     in the table. This is required for the release flow (sg_free_table).
> >     This filed should be used internally only by scatterlist.
> >
> > Fixes: 07da1223ec93 ("lib/scatterlist: Add support in dynamic allocation of SG table from pages")
> > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

<...>

> For now I would suggest to revert this change.

Thanks for the report, we will drop this patch.
