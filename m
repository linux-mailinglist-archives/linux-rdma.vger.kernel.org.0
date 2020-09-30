Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2D27E5B3
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 11:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgI3Jx0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 05:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3Jx0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 05:53:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 155502075F;
        Wed, 30 Sep 2020 09:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601459605;
        bh=n7b9ZN9lWXqAAXqpvYhEZTZkNVvQeHxENX4KKFd7s9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zlp5hRjXAbo8Cb3tqMZFlDt2iXHugyplO5KpoQHA35xj21Luw9UV2SE1NMbzEn1Th
         NWaA9Dh177egigRZUNdHfS116GxaJNzvsoz+pogGkCK+t++5wVfb/Ldv+IEQ+Etwrw
         kiqvESwSIgjPGPTiDha1J90UvqA0M/RzaxWRdgvQ=
Date:   Wed, 30 Sep 2020 12:53:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Subject: Re: [PATCH rdma-next v4 4/4] RDMA/umem: Move to allocate SG table
 from pages
Message-ID: <20200930095321.GL3094@unreal>
References: <20200927064647.3106737-1-leon@kernel.org>
 <20200927064647.3106737-5-leon@kernel.org>
 <20200929195929.GA803555@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929195929.GA803555@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 04:59:29PM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 27, 2020 at 09:46:47AM +0300, Leon Romanovsky wrote:
> > @@ -296,11 +223,17 @@ static struct ib_umem *__ib_umem_get(struct ib_device *device,
> >  			goto umem_release;
> >
> >  		cur_base += ret * PAGE_SIZE;
> > -		npages   -= ret;
> > -
> > -		sg = ib_umem_add_sg_table(sg, page_list, ret,
> > -			dma_get_max_seg_size(device->dma_device),
> > -			&umem->sg_nents);
> > +		npages -= ret;
> > +		sg = __sg_alloc_table_from_pages(
> > +			&umem->sg_head, page_list, ret, 0, ret << PAGE_SHIFT,
> > +			dma_get_max_seg_size(device->dma_device), sg, npages,
> > +			GFP_KERNEL);
> > +		umem->sg_nents = umem->sg_head.nents;
> > +		if (IS_ERR(sg)) {
> > +			unpin_user_pages_dirty_lock(page_list, ret, 0);
> > +			ret = PTR_ERR(sg);
> > +			goto umem_release;
> > +		}
> >  	}
> >
> >  	sg_mark_end(sg);
>
> Does it still need the sg_mark_end?

It is preserved here for correctness, the release logic doesn't rely on
this marker, but it is better to leave it.

Thanks

>
> Jason
