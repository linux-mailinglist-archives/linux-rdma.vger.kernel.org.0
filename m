Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C564F2812FC
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 14:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBMmW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 08:42:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12249 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMmV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 08:42:21 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7720200000>; Fri, 02 Oct 2020 05:42:08 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 12:42:21 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 12:42:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSyTaIfwAoYInB4q6C6gm9ZzRa8H0u1niHBYH8j+/JuwbM+AJmwils5v786gSRd/TF590wD/0maTbFGKcMKPklCpJcgQqMvUfpRwT7U/6oOFoEWz774sW/5yaZmAXOkwNgDpop5I24c/5RzP+4WE2iki6MhPY1381zRmk3KJcD3fuuOIzcn8nkLFduAOoVW1IG3CBU4debfuCyJtvZP7SFN64WWPdRtoABgI1LvJjYBLZhL08dxex3dKJSbT6hLX9Bjwxv/GYPaEpVbkS9xJpYJC+hvTl9+/dcIBWLTpXLeitvn/tyxVLh2rMGBKXTpyinR6oHcHO66r3P9ikvqLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ILIRMx0qDK043G7D2fsf0ew3JP1dppK7YB9W2srx8s=;
 b=kb9Ap3V5/J7DdqWjcjEgAwj/a00qd0qq3ym6ncR/jsOw2BY0iM5HKgej1DFdkD0e2T1rzXrKaZbSUuIbtTV8mc0GcnWrjIPN516qPmy+NAZYaSS6ACNGbbo9dqyoQS+Hx3IyKzOGjD58jmqXdmxV4OS9uBsS5RMhcyFbfuoMx15aS+GWeEVnJUJG8RD61ZDs6BjprEyQgTRC3QgFAn2tO2oZ8ZUbGw1lkpH5+6SnFOngrFMZXF0Bk10NW5TvjaQtNc65ccYuzA+4bBher65NWO228u5UJwZyrYRpkDPMJYz6EX9nW1ya5wT+mkOmHQlLAFSEX1UGO45fPS9UMRR1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 12:42:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 12:42:19 +0000
Date:   Fri, 2 Oct 2020 09:42:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v3 6/9] RDMA/restrack: Add error handling while
 adding restrack object
Message-ID: <20201002124217.GA1342563@nvidia.com>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-7-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200926101938.2964394-7-leon@kernel.org>
X-ClientProxiedBy: MN2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Fri, 2 Oct 2020 12:42:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOKO9-005dR7-Cj; Fri, 02 Oct 2020 09:42:17 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601642529; bh=/ILIRMx0qDK043G7D2fsf0ew3JP1dppK7YB9W2srx8s=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=h6qgTacLyCpu/cVCWNW6RUN07hPJXtvXAVlUhiapK8pPwmoOgT4HmRJO6/a5zN7Pc
         7aRXLYi/jNPfPb3OtOecdh7CjSy74J3nxFYBqcVuiucKY0DFy7pGKYXn3Xb4aQeqsV
         u53WC/zLEE0CWFgqlJfB18FpIFkyWpJLD9217IilejIF/+H+btzL6CvadPBkIqULXw
         mooba9s+zPXGP2Vs5j0pmzhugCeopcymYXznl5cK2QcVkGJfltHMQjka+o7LXQZiY2
         T3j1lw1F4rvS+9RjNc89qCS5/2gvIFaGBAjWSsYHIHkcdWb2etTy0Xn9ibve7xB0Ym
         uDjqLdJOl86Rw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 26, 2020 at 01:19:35PM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 12ebacf52958..1abcb01d362f 100644
> +++ b/drivers/infiniband/core/cq.c
> @@ -267,10 +267,25 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
>  		goto out_destroy_cq;
>  	}
>  
> -	rdma_restrack_add(&cq->res);
> +	ret = rdma_restrack_add(&cq->res);
> +	if (ret)
> +		goto out_poll_cq;
> +
>  	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
>  	return cq;
>  
> +out_poll_cq:
> +	switch (cq->poll_ctx) {
> +	case IB_POLL_SOFTIRQ:
> +		irq_poll_disable(&cq->iop);
> +		break;
> +	case IB_POLL_WORKQUEUE:
> +	case IB_POLL_UNBOUND_WORKQUEUE:
> +		cancel_work_sync(&cq->work);

This error unwind is *technically* in the wrong order, it is wrong in
ib_free_cq too which is an actual bug.

The cq->comp_handler should be set before calling create_cq and undone
after calling destroy_wq. We can do this right now that the
allocations have been reworked.

Otherwise there is no assurance the ib_cq_completion_workqueue() won't
be called after this cancel == use after free

Also, you need to check all the rdma_restrack_del()'s, they should
always be *before* destroying the HW object, eg ib_free_cq() has it
too late. Similarly the add should always be after the HW object is
allocated.

For instance fill_res_cq_entry() calls 

  dev->ops.fill_res_cq_entry(msg, cq) 

on an already free'd HW object with this arrangment.

These are pre-existing things so lets fix them seperately please

Jason
