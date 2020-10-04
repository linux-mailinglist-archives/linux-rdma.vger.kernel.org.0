Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B31282ACF
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJDNDT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 09:03:19 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:12890 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgJDNDT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 09:03:19 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f79c8140001>; Sun, 04 Oct 2020 21:03:16 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 4 Oct
 2020 13:03:16 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sun, 4 Oct 2020 13:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqy8v9aj/CTSSC2DKQotPrfZmRheitMY9NS/2QtXsRQhp4IUYhtLujfXMLkTT6SpzQpECsVCF5TqK0uE0bxfFPOtrAfDs9a2VJ2B8w+aAp6BeGYt19AsIHUUpvEmOid0qH7MZ72uVeI8PCYQHKGBmZY2KnPTRLLX3ksV3z8ZIyyjP7N0RUICDPCnq0ocbAc0UA8yqyvFZ/H/ogB3q2NSrhlqaPyLdIj84W+rcMb2TZENt6XjD8UxUzzd4Eb7tajW6rALKOWWF6z00tVhnurkrp+MlPsO2cjg5YtNFm80wcLv6UMTQnyHeRFiG+MvcwvWwnVk3VmFsrYmHnQBXCDDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtdEwaJAiRNeTH4Kclax+pvvLUOYAzXOrzJDU3NPuJ8=;
 b=TfKjBct8JOWHUgqMX8bVPARLaEgFmdit4GgAOrkqHjEKHoND5AvfBS1zFCYasHLb+5j68Ptm/8JIOYwNnxJMKK9Jz3ZrgImieHb6twjS5ZLlmj51OkbO0CF3rAnVKUbrt1rR67NueaNwrS/O4UZvi+2B3+M8LWxPPfz9I/mk7m3CHdQop3NGERe+qrPQFXxP722ZUkQ1XlAWdN3cJEnjrOBfSUdQec8RKqmvaN12QB9POYTXQaKF1raE7zWCGH4g44bpHknpoMqN5pPDzwFrF8ceLTsfeFLgkQi44yKdm++w0ldOrG32NIjcKWnUJ51MT+O10JMKlQXu7rbcL/TJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 13:03:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sun, 4 Oct 2020
 13:03:13 +0000
Date:   Sun, 4 Oct 2020 10:03:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v3 6/9] RDMA/restrack: Add error handling while
 adding restrack object
Message-ID: <20201004130311.GR816047@nvidia.com>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-7-leon@kernel.org>
 <20201002124217.GA1342563@nvidia.com> <20201002125720.GD3094@unreal>
 <20201002131628.GI816047@nvidia.com> <20201004064818.GB9764@unreal>
 <20201004123226.GN816047@nvidia.com> <20201004124920.GD9764@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201004124920.GD9764@unreal>
X-ClientProxiedBy: BL1PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:208:257::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0043.namprd13.prod.outlook.com (2603:10b6:208:257::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.16 via Frontend Transport; Sun, 4 Oct 2020 13:03:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kP3fT-007HQ9-Pq; Sun, 04 Oct 2020 10:03:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601816596; bh=qtdEwaJAiRNeTH4Kclax+pvvLUOYAzXOrzJDU3NPuJ8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=F7N/TDAWEfUEXScNRxaeOP6ZiEg9zE+LXXjRvb+L2w8Wixo6n2dVDTurx0y3Ro4Y3
         wpVRD906JLTXrdaJVnnkUHUnqvY1d0YvkFyRHQ7NdSeEy7i7PTvpwGweil+RXKv9VZ
         jrRjMPU/7yMel45RuNtynNi3JBhVYoPui+Zj1KBmFUCaFiU2r1Ckk7lzQUnr1sFEns
         B7Yt1/SIfnaE2sbcD2R1bseHz6+oo0QgeaWZjq8dRgb0bIC1nWpWH1ZGQWOElx0Fdo
         DijEaD5+0U2AWeRKcoVFglk2L94m134YeUXRwq06sZj6lQYv7/kQjUgJvKYdn7L07M
         65oxuzuolGAoA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 04, 2020 at 03:49:20PM +0300, Leon Romanovsky wrote:
> On Sun, Oct 04, 2020 at 09:32:26AM -0300, Jason Gunthorpe wrote:
> > On Sun, Oct 04, 2020 at 09:48:18AM +0300, Leon Romanovsky wrote:
> > > On Fri, Oct 02, 2020 at 10:16:28AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Oct 02, 2020 at 03:57:20PM +0300, Leon Romanovsky wrote:
> > > > > On Fri, Oct 02, 2020 at 09:42:17AM -0300, Jason Gunthorpe wrote:
> > > > > > On Sat, Sep 26, 2020 at 01:19:35PM +0300, Leon Romanovsky wrote:
> > > > > > > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > > > > > > index 12ebacf52958..1abcb01d362f 100644
> > > > > > > +++ b/drivers/infiniband/core/cq.c
> > > > > > > @@ -267,10 +267,25 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
> > > > > > >  		goto out_destroy_cq;
> > > > > > >  	}
> > > > > > >
> > > > > > > -	rdma_restrack_add(&cq->res);
> > > > > > > +	ret = rdma_restrack_add(&cq->res);
> > > > > > > +	if (ret)
> > > > > > > +		goto out_poll_cq;
> > > > > > > +
> > > > > > >  	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
> > > > > > >  	return cq;
> > > > > > >
> > > > > > > +out_poll_cq:
> > > > > > > +	switch (cq->poll_ctx) {
> > > > > > > +	case IB_POLL_SOFTIRQ:
> > > > > > > +		irq_poll_disable(&cq->iop);
> > > > > > > +		break;
> > > > > > > +	case IB_POLL_WORKQUEUE:
> > > > > > > +	case IB_POLL_UNBOUND_WORKQUEUE:
> > > > > > > +		cancel_work_sync(&cq->work);
> > > > > >
> > > > > > This error unwind is *technically* in the wrong order, it is wrong in
> > > > > > ib_free_cq too which is an actual bug.
> > > > > >
> > > > > > The cq->comp_handler should be set before calling create_cq and undone
> > > > > > after calling destroy_wq. We can do this right now that the
> > > > > > allocations have been reworked.
> > > > > >
> > > > > > Otherwise there is no assurance the ib_cq_completion_workqueue() won't
> > > > > > be called after this cancel == use after free
> > > > > >
> > > > > > Also, you need to check all the rdma_restrack_del()'s, they should
> > > > > > always be *before* destroying the HW object, eg ib_free_cq() has it
> > > > > > too late. Similarly the add should always be after the HW object is
> > > > > > allocated.
> > > > >
> > > > > It is true to not converted object (QP and MR), everything that was
> > > > > converted has two steps: rdma_restrack_put() before creation,
> > > > > rdma_restrack_add() right after creation and rdma_restrack_del() after
> > > > > successful destroy.
> > > >
> > > > It must be before destroy not after.
> > >
> > > We need rdma_restrack_put() after destroy to release memory.
> >
> > The netlink ops must be blocked before ops->destory and the memory
> > freed after ops->destroy success.
> >
> > It must work like that since the fill stuff was added as ops - no
> > choice.
> 
> So I will need to separate _del() to two calls, one is real _del() and
> another _put().

I think you end up with destroy being like

restrack_remove_from_xarray_and_stop_nl()
rc = ops->destroy()
if (rc)
   restrack_return_to_xarray()
   return rc

restrack_put_for_freeing_memory()

It ends up with *two* refcounts, an kref for the memory lifetime and a
refcount_t for the HW object lifetime (basically HW object destroy
rwlock)

To solve the immediate problems I'd suggest something like

static inline int __rdma_destroy_hw_obj(struct restrack *res, int destroy_rc);

#define rdma_destroy_hw_obj(restrack, op, args ..) \
  ({ __rdma_destroy_hw_ob_pre(restrack); __rdma_destroy_hw_obj(restrack, op(args, ## __VA_ARGS__));})

Which does the sequencing above

Jason
