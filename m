Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B32C2201
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 10:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgKXJqe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 04:46:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730272AbgKXJqd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 04:46:33 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51B0B2075A;
        Tue, 24 Nov 2020 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606211193;
        bh=uIhAd9QzKa21wsF9mjq14Klx+f+GayjVUkoddWfApiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdolciZI2QszA3qdPu+SeoRq1qVgkQrWQIZO3U8tvPY0TO0DqAWEmleOwEFItcArE
         ElDTGCeHKVpMeMlAgjmdlfZm9mbrKK/qOoGF1o6U34S+w+wr8kKlEeZVy565RPQ26N
         M/iycefV+zHntqzqn/STYY8BpNOvH684zDmD/j04=
Date:   Tue, 24 Nov 2020 11:46:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/mlx5: Use ib_dma APIs instead of open
 access to parent device
Message-ID: <20201124094628.GI3159@unreal>
References: <20201123082400.351371-1-leon@kernel.org>
 <20201124093154.GA29715@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124093154.GA29715@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 09:31:54AM +0000, Christoph Hellwig wrote:
> On Mon, Nov 23, 2020 at 10:24:00AM +0200, Leon Romanovsky wrote:
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > index 090e204ef1e1..d24ac339c053 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -42,7 +42,7 @@
> >  #include "mlx5_ib.h"
> >
> >  /*
> > - * We can't use an array for xlt_emergency_page because dma_map_single doesn't
> > + * We can't use an array for xlt_emergency_page because ib_dma_map_single doesn't
>
> Please avoid the pointlessly overly long line.
>
> > +		ib_dma_sync_single_for_cpu(&dev->ib_dev, sg.addr, sg.length, DMA_TO_DEVICE);
>
> And here and much more.

No problem, I will reduce checkpatch limit from its default.

Thanks
