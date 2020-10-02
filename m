Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6692813DD
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgJBNQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 09:16:35 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:44682 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733260AbgJBNQf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 09:16:35 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7728300001>; Fri, 02 Oct 2020 21:16:32 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 13:16:32 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 13:16:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLi7B0pmHrM11UW/Nti06wroLh5VJrFV+NuUUBmDv36dvWovZ56s7GoWNzSt9Lrb2iXnQ3GHzxhpQ+QDoAXNHp2EJcTVS0/lWJwdUio4TWZmEw8bCX1d/sH0nfQ9lGUMRpu/MN/974BOzqSFILCzyTxqpRKCpDXq07rW0Qfq8Go2hCBC95qdT7PnVhXl0XFNPveeh+ngQyBRjN0Y4nKUcxAFTQapUmsjmukvP11YFRA7BobeJQ86dlYuwZOsWys1mmxwtmR68xdOWPkHAE2QAonmNaPQ3YrMYIwQLbzFIPm7GYALmyX47mzonodFpBnrnzFRMMQtWTsg/VifLGh/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNHxYccHHDQNKm1BlTzvvcpsBY+WwT3D9XRgeecr+Nk=;
 b=PetmBILTjQID8NT5GIZaXbsbyVrg8IFlXqN+phwlKoP77BH1ubKmzsS4m85l2n+7BHzh2cv+Q0xSLSMZ5Zfuhxd9CB/RvVJ7p9a5In6ClUlKrFuSVRJHIg72ye3ve+3JrKItP5+aoGkcHWhaFSGmBR1TCCRwuE97SzU/2CGHj/HseckBZZGhHZwbrj3L/5oVV5UQ94jsjxNgm8lBHKudPLvRSIc0EN3ZX4vUoZkrAbGQEfxTKawWk3VIY7XWvAhXfBAZRs3ZcwbB6x9QrXUrNz0O4r00JZqLeAWoxLcnqlJ/75pNtsoZBvXD9WGyRDHof8z/sEzkCVdoWXhffSJBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Fri, 2 Oct
 2020 13:16:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 13:16:29 +0000
Date:   Fri, 2 Oct 2020 10:16:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v3 6/9] RDMA/restrack: Add error handling while
 adding restrack object
Message-ID: <20201002131628.GI816047@nvidia.com>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-7-leon@kernel.org>
 <20201002124217.GA1342563@nvidia.com> <20201002125720.GD3094@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201002125720.GD3094@unreal>
X-ClientProxiedBy: MN2PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:208:a8::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:208:a8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Fri, 2 Oct 2020 13:16:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOKvE-005eLE-OI; Fri, 02 Oct 2020 10:16:28 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601644592; bh=NNHxYccHHDQNKm1BlTzvvcpsBY+WwT3D9XRgeecr+Nk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=b9PzCMbpIKKG+X5r6TRuWoFY8NDxZzePjBgmdtAUZdueKIQAvdzXua9e0nLFSHald
         4wBwN9eHCF8YYTHgb0AS4qY8h6MksDzcW+b5BvRlwSc1s0BdvqY29gHzRghVYarHo0
         6dBNgPW1lRHjBnQWQG+ozR/k0dSztGffI1dR43Wo+nc50WdnHh6TMVIlJx2ZNU/4mY
         F5Uilcq6SCgqmAxfacWuMaRAAcVG96tDD+1lA4hOorxD6n/zXNB1VM1Ypt5f0DNvFA
         R/SgjzOMiuCU/qBPhatQ3T6B4GZmc3KbodpIJjynJxHxSFw3Ip4WAJQgyGCKZCZLFu
         HkDXsvjh0d3Iw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 03:57:20PM +0300, Leon Romanovsky wrote:
> On Fri, Oct 02, 2020 at 09:42:17AM -0300, Jason Gunthorpe wrote:
> > On Sat, Sep 26, 2020 at 01:19:35PM +0300, Leon Romanovsky wrote:
> > > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > > index 12ebacf52958..1abcb01d362f 100644
> > > +++ b/drivers/infiniband/core/cq.c
> > > @@ -267,10 +267,25 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
> > >  		goto out_destroy_cq;
> > >  	}
> > >
> > > -	rdma_restrack_add(&cq->res);
> > > +	ret = rdma_restrack_add(&cq->res);
> > > +	if (ret)
> > > +		goto out_poll_cq;
> > > +
> > >  	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
> > >  	return cq;
> > >
> > > +out_poll_cq:
> > > +	switch (cq->poll_ctx) {
> > > +	case IB_POLL_SOFTIRQ:
> > > +		irq_poll_disable(&cq->iop);
> > > +		break;
> > > +	case IB_POLL_WORKQUEUE:
> > > +	case IB_POLL_UNBOUND_WORKQUEUE:
> > > +		cancel_work_sync(&cq->work);
> >
> > This error unwind is *technically* in the wrong order, it is wrong in
> > ib_free_cq too which is an actual bug.
> >
> > The cq->comp_handler should be set before calling create_cq and undone
> > after calling destroy_wq. We can do this right now that the
> > allocations have been reworked.
> >
> > Otherwise there is no assurance the ib_cq_completion_workqueue() won't
> > be called after this cancel == use after free
> >
> > Also, you need to check all the rdma_restrack_del()'s, they should
> > always be *before* destroying the HW object, eg ib_free_cq() has it
> > too late. Similarly the add should always be after the HW object is
> > allocated.
> 
> It is true to not converted object (QP and MR), everything that was
> converted has two steps: rdma_restrack_put() before creation,
> rdma_restrack_add() right after creation and rdma_restrack_del() after
> successful destroy.

It must be before destroy not after.

Jason
