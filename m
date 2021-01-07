Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C132EE712
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 21:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbhAGUlt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 15:41:49 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2070 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGUlt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jan 2021 15:41:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff771e50000>; Thu, 07 Jan 2021 12:41:09 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 20:41:06 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 20:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKqWUbRq88faB6OrPbXCmna1EORlvV/Ubu7tQ+qlHNZKeuEY2jZYppVk35T2Fel2fcAV4cD4zuv8z6EOpFgEISclchRWywKP2RTsWQxhgI01m/p6OpizIGtPuxsiDEsPhS4LBZqJC0cfWPutw/9hgDI+jlW2jU3ARmwQEG5JnuQE2veXYvvuHL/hY+o/8k8K1xCbCDNmarchcFRly+ts+u4qqAGXI8GOOOOmVv4a+2/8S85/xteCeN2c6SZXXeNCsf+8GukEK99d2nlrPiJux27QRtlZcXKRRrXpJUOcNT1QJsKgmyR+5ysFtPQO7q1HGaBo1sJYE9ayY/+LkwFi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdNJaIz6r9cJhxdBrqGu2vw9xSxQsf7n/apnzxQj1wo=;
 b=DzIvUGtqMMYkfADDGI3Ar0CWUSapohYaOZMW00ETfxll2uB1JuhEmUEfZvZ9lS+EzRO6ZO9Z4Jht1JU6Pwhv6L8xQ6/dzPiWk3bXtzbZD+xaOfG3GoKGnbmS9Pgr/7Ozov/ODSqKJ+2aRy2ArLwSBI7LZpbgNT4HSNKa8jrEb2Phhbwpn4yumA+u9DWRxnlfKpR0K6Cc2jRikxIMaEx6mLOmfpsRN8GRkDytlNBE+Oag/+y5Qa3DPOo1tiieLu6Po7pYZHBZzPXIrN6K1LRHyphHhewSGOtgKPhUPvqk/lrnss9euP7VbSmVERRiVEJS1kkd73OkGLZJDEFeBj19YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4633.namprd12.prod.outlook.com (2603:10b6:5:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 20:41:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 20:41:04 +0000
Date:   Thu, 7 Jan 2021 16:41:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <trix@redhat.com>
CC:     <selvin.xavier@broadcom.com>, <devesh.sharma@broadcom.com>,
        <dledford@redhat.com>, <leon@kernel.org>, <maxg@mellanox.com>,
        <galpress@amazon.com>, <michaelgur@nvidia.com>,
        <monis@mellanox.com>, <gustavoars@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ocrdma: fix use after free in
 ocrdma_dealloc_ucontext_pd()
Message-ID: <20210107204102.GA933840@nvidia.com>
References: <20201230024653.1516495-1-trix@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201230024653.1516495-1-trix@redhat.com>
X-ClientProxiedBy: BL1PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:208:2be::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.17 via Frontend Transport; Thu, 7 Jan 2021 20:41:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxc5e-003uyb-PA; Thu, 07 Jan 2021 16:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610052069; bh=xdNJaIz6r9cJhxdBrqGu2vw9xSxQsf7n/apnzxQj1wo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ARwBCflLM1IWE+m/cjVxN8GaXv6vqxdiz1wye+UQuKyHBs9cLm17/8XzS48eMZpTM
         OUZnQ8BHW2dEmMOMnnBe4hqr56rUmDJktdYSJUJxdRo2nxAb+Igd//aZ9sSN7hSfv7
         aA7sGTHtPUimzWvBwlylMzqyvIE7GDSqNMyMZ6vWWMu4zLWQUg6lsEsNC/C6XA4umM
         OCNXWhKPEwPQHgrciwvRwrvSgQsS5PdEyVK4xENwCk2FyGr0Zc/PQf+lxklcJVU9bB
         R8D4MH3y2NaenBVfKXj8X/OMo3J6GoV3IcYfLehDkX5mPYCHt8dVuhqJ9jL+9UEj/c
         VZ0fGvEfnFnOQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 29, 2020 at 06:46:53PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> In ocrdma_dealloc_ucontext_pd() uctx->cntxt_pd is assigned to
> the variable pd and then after uctx->cntxt_pd is freed, the
> variable pd is passed to function _ocrdma_dealloc_pd() which
> dereferences pd directly or through its call to
> ocrdma_mbx_dealloc_pd().
> 
> Reorder the free using the variable pd.
> 
> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
> Signed-off-by: Tom Rix <trix@redhat.com>
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc

Is anyone testing ocrdma? Just doing the pyverbs rdma tests with kasn
turned on would have instantly caught this, and the change is nearly a
year old.

Is ocrdma obsolete enough we can delete the driver?

Thanks,
Jason
