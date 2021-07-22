Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88B73D1E9F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGVGYt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 02:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhGVGYq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Jul 2021 02:24:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 692C261241;
        Thu, 22 Jul 2021 07:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626937522;
        bh=llpwcSwIoRkFywjB2bAOzYOX4SzJ7LKdKo1OJ6ezcx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ek5e4/aBdnHqvQgymXDltbwMQX6FzSHQqI18vzIzfjRu80xuVCOcq6ROfIqRCSqO8
         0zF73H5w2undmeY5Kgf2QkmU7dNt0ob/YiGcRx6fPhyqjHvkLs697Tvhw3XuE6gui3
         /gSYaeQsBgmi9YFHrv2NVI0g4awvLnKfSm85sbwSxVlBtBWrsrcwPfadQNExlBU0qg
         qqbfmglGN8WtLeEMOzplhXanAf+pMo2d1Bv3spEfXK/iBxaEfqFfEPpBl5WassAgF6
         d1NTIRxOTPdYjMHcRBb/HTf+5Sl7CtnXXld5pUJlpvR0FQqQQClzMvP0x2oKiOKXw/
         kD3wAvk9ndJbg==
Date:   Thu, 22 Jul 2021 10:05:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 8/9] RDMA: Globally allocate and release QP
 memory
Message-ID: <YPkYrluozzr4dJUb@unreal>
References: <cover.1626609283.git.leonro@nvidia.com>
 <5b3bff16da4b6f925c872594262cd8ed72b301cd.1626609283.git.leonro@nvidia.com>
 <abfc0d32-eab8-97d4-5734-508b6c46fe98@amazon.com>
 <YPaKu4ppS0Bz6fW1@unreal>
 <5539c203-0d3b-6296-7554-143e7afb6e34@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5539c203-0d3b-6296-7554-143e7afb6e34@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 02:05:34PM -0400, Dennis Dalessandro wrote:
> On 7/20/21 4:35 AM, Leon Romanovsky wrote:
> > On Mon, Jul 19, 2021 at 04:42:11PM +0300, Gal Pressman wrote:
> >> On 18/07/2021 15:00, Leon Romanovsky wrote:
> >>> From: Leon Romanovsky <leonro@nvidia.com>
> >>>
> >>> Convert QP object to follow IB/core general allocation scheme.
> >>> That change allows us to make sure that restrack properly kref
> >>> the memory.
> >>>
> >>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >>
> >> EFA and core parts look good to me.
> >> Reviewed-by: Gal Pressman <galpress@amazon.com>
> >> Tested-by: Gal Pressman <galpress@amazon.com>
> 
> Leon, I pulled your tree and tested, things look good so far.
> 
> For rdmavt and core:
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Tested-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

Thanks

> 
> 
> > Thanks a lot.
> > 
> >>
> >>> +static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,
> >>> +				    gfp_t gfp, bool is_numa_aware)
> >>> +{
> >>> +	if (is_numa_aware && dev->ops.get_numa_node)
> >>
> >> Honestly I think it's better to return an error if a numa aware allocation is
> >> requested and get_numa_node is not provided.
> > 
> > We don't want any driver to use and implement ".get_numa_node()" callback.
> > 
> > Initially, I thought about adding WARN_ON(driver_id != HFI && .get_numa_node)
> > to the device.c, but decided to stay with comment in ib_verbs.h only.
> 
> Maybe you could update that comment and add that it's for performance? This way
> its clear we are different for a reason. I'd be fine adding a WARN_ON_ONCE like
> you mention here. I don't think we need to fail the call but drawing attention
> to it would not necessarily be a bad thing. Either way, RB/TB for me stands.

The thing is that performance gain is achieved in very specific artificial
use case, while we can think about other scenario where such allocation will
give different results.

For the performance test, Mike forced to have QP and device to be in different
NUMA nodes, while in reality such situation is possible only if memory on the
local node is depleted and it is better to have working system instead of current
situation where node request will fail.

I don't want to give wrong impression that numa node allocations are
better for performance.

Thanks

> 
> -Denny
> 
> 
