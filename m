Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C896282AA9
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 14:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgJDMcd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 08:32:33 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16189 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgJDMcd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 08:32:33 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f79c0de0000>; Sun, 04 Oct 2020 20:32:30 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 4 Oct
 2020 12:32:29 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sun, 4 Oct 2020 12:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0IEy0Mmhdgvf3ywkbpDrdDEvsoooKUZzN8/GuZtVitXPwTnFrMqB903I2OwdFewUeMN0mCXBQ+V8fOsyFwwII0aIjNlzswuHbkFFYOpiYt9kIw+14kxyocOenIsOGooseRmfGDpumpVuaXBZ6NUxpFW+OL7HPvLx5e7hLH3VCxZczVW+f3zJSpS77MyOwoVweuqWQ+g2rL+/ocIf8vDahEM/LYyXeUSXmZfniJ7aL8XHj0P+Yj9cochASw7SiaFiiDmVtCFQnWTNhTQzlv0Ue2vpVTZqtTz1RimWRoeKs7LDx5/slPekn/7cuYvOnvlj42aE2SNfqTIE3EDZOJujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GvqIE0X8KA8heeXIy+CXP/dylDWrUbXNzcDdMeIehs=;
 b=BTt7zw4LiJulfy4GmGTDsjk/WGf6nMPx4IPmRRzpqI+lQVmus67xOpDZejxBARrIdAi2HlnTFC9QUbK9MPh7LoMa0E4we74wWceqQrY7Ti4AyTjX5YULjzZgUX+1uuw9OsoPk6LX8vFlUeH/O8MITvLFXooMsiXvhRRUw+aHex82vidUf6/pDrmakMc3J4qeml74RbfFrfjp8WwbBriCtekxF9XvSId/+Pw9hYpjUn0jYyFQ1wUiQ4qGVIvfRbvAsejWVUbJQEGjLrrYkGRi8g97hHm/ESmfrExJtRU8l6vyOdBrTeqTAPfE9gRtGD3K0n8n1pXmA3iABMK3uTlynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.42; Sun, 4 Oct
 2020 12:32:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sun, 4 Oct 2020
 12:32:28 +0000
Date:   Sun, 4 Oct 2020 09:32:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v3 6/9] RDMA/restrack: Add error handling while
 adding restrack object
Message-ID: <20201004123226.GN816047@nvidia.com>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-7-leon@kernel.org>
 <20201002124217.GA1342563@nvidia.com> <20201002125720.GD3094@unreal>
 <20201002131628.GI816047@nvidia.com> <20201004064818.GB9764@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201004064818.GB9764@unreal>
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:256::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend Transport; Sun, 4 Oct 2020 12:32:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kP3Bi-007GnJ-HP; Sun, 04 Oct 2020 09:32:26 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601814750; bh=4GvqIE0X8KA8heeXIy+CXP/dylDWrUbXNzcDdMeIehs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=d5RAWcU+dx+3HPlA2L1iKHhiXT4oZlwJlwfLy0wAqT6/ILzK0e9S9T8v+5EOb1Jfe
         BlgwpbvBm2r88WOdZv9c+DIjXHqYrTIUiLDegCnmatVh2+MO5QdS/WyHOnzg7qt/Dk
         CIWXkk4yZ0D0lVAFaulYG/w5X45NUL/BC1/5Sfi7vuoWvpYItbvo1XnBvGxln1t/E7
         x4ESaKvldxaBWV0EiQm/mvxKeU7+rveHJPPGfFHgpPoNtxd2AqCxMK5imwS1okyU53
         REbuMOULmWNgbbPwPM7Y1z2M14IlUQn13ssSjtRFYNvJ4uqKDcrqR2d5L4+byMutYp
         eeb/puhVUgCKg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 04, 2020 at 09:48:18AM +0300, Leon Romanovsky wrote:
> On Fri, Oct 02, 2020 at 10:16:28AM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 02, 2020 at 03:57:20PM +0300, Leon Romanovsky wrote:
> > > On Fri, Oct 02, 2020 at 09:42:17AM -0300, Jason Gunthorpe wrote:
> > > > On Sat, Sep 26, 2020 at 01:19:35PM +0300, Leon Romanovsky wrote:
> > > > > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > > > > index 12ebacf52958..1abcb01d362f 100644
> > > > > +++ b/drivers/infiniband/core/cq.c
> > > > > @@ -267,10 +267,25 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
> > > > >  		goto out_destroy_cq;
> > > > >  	}
> > > > >
> > > > > -	rdma_restrack_add(&cq->res);
> > > > > +	ret = rdma_restrack_add(&cq->res);
> > > > > +	if (ret)
> > > > > +		goto out_poll_cq;
> > > > > +
> > > > >  	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
> > > > >  	return cq;
> > > > >
> > > > > +out_poll_cq:
> > > > > +	switch (cq->poll_ctx) {
> > > > > +	case IB_POLL_SOFTIRQ:
> > > > > +		irq_poll_disable(&cq->iop);
> > > > > +		break;
> > > > > +	case IB_POLL_WORKQUEUE:
> > > > > +	case IB_POLL_UNBOUND_WORKQUEUE:
> > > > > +		cancel_work_sync(&cq->work);
> > > >
> > > > This error unwind is *technically* in the wrong order, it is wrong in
> > > > ib_free_cq too which is an actual bug.
> > > >
> > > > The cq->comp_handler should be set before calling create_cq and undone
> > > > after calling destroy_wq. We can do this right now that the
> > > > allocations have been reworked.
> > > >
> > > > Otherwise there is no assurance the ib_cq_completion_workqueue() won't
> > > > be called after this cancel == use after free
> > > >
> > > > Also, you need to check all the rdma_restrack_del()'s, they should
> > > > always be *before* destroying the HW object, eg ib_free_cq() has it
> > > > too late. Similarly the add should always be after the HW object is
> > > > allocated.
> > >
> > > It is true to not converted object (QP and MR), everything that was
> > > converted has two steps: rdma_restrack_put() before creation,
> > > rdma_restrack_add() right after creation and rdma_restrack_del() after
> > > successful destroy.
> >
> > It must be before destroy not after.
> 
> We need rdma_restrack_put() after destroy to release memory.

The netlink ops must be blocked before ops->destory and the memory
freed after ops->destroy success.

It must work like that since the fill stuff was added as ops - no
choice.

Jason
