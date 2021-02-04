Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28B330FD91
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbhBDUBu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 15:01:50 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18224 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbhBDUBS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 15:01:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601c52620000>; Thu, 04 Feb 2021 12:00:34 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 20:00:34 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 4 Feb 2021 20:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lajgb74IV/h6u+h6hVuXAi7d7n4S2sQf4DGig8OtQ/8P5a46SJZL2HoHrGscK04AeyQ2CYYQb/gQAO2VR69Bp0FjRRHR3O8wkHRerY56dw2YTnEVclkfy/o6oSRdRMnQ+dqS7QuZsVOGxkMJ9nWZtEgLeJlAsFMJL1rbX1Sh/AmZOCQmNvrXoD2S7Zhm2Pw77OBr+i0tJrHCcRylrIt/NZ5HS+dUE2OOQ/HaaE/TXZnGW3c5Z6pDqwpNZEWsOQCTDSYff+6Fg/GaHlF0vmy32BqDIZsVVr/yHrJU1J/FMGnJKo+C7r+JPucKsK6Yy2/8On9kFqT4v8ouvFktgSCZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Blxpv9wdIhTHV/SuxJJuCyToGqkciL5tkr9faNzzCsc=;
 b=UZoNTTaUry0hBJJI6kUFZhMG1TAhKWMXPCEia3zDXarBVWbiEN7BHAu6qu7EgqtRHP9eyJdej/TsE/3PRYLBE0Xa/X0Nv5uDumAbK4FoMbIsKcXFLUWwwD5242oBFnC6zc6W/0V+UbdXbpUgrEvqgQQ1tj8IFF4tHsbgCUmxQlbpJbgCLj/AjdfihJ+lpKTzWFli8Cs01aeae6p4ZNdUUndSziLVgKypDQ/j9QkgwLU/dy0WIBW2vzFd6Jg4az46HdXnfErCiVnfrA5w12CB1ERH4lgx8CP5KLEZBBC7+rmHEyS7HyRMDqs7VBsoMu8HRP73LrBdV2bJMDM+9LWBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Thu, 4 Feb
 2021 20:00:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3805.033; Thu, 4 Feb 2021
 20:00:28 +0000
Date:   Thu, 4 Feb 2021 16:00:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 4/4] RDMA/umem: batch page unpin in __ib_mem_release()
Message-ID: <20210204200026.GP4247@nvidia.com>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-5-joao.m.martins@oracle.com>
 <4ed92932-8cf2-97ab-7296-6efee51fc555@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4ed92932-8cf2-97ab-7296-6efee51fc555@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0432.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0432.namprd13.prod.outlook.com (2603:10b6:208:2c3::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.16 via Frontend Transport; Thu, 4 Feb 2021 20:00:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l7kni-003anf-TF; Thu, 04 Feb 2021 16:00:26 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612468835; bh=Blxpv9wdIhTHV/SuxJJuCyToGqkciL5tkr9faNzzCsc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=N8qveSKf/BXX6yJw26xBnwqkjkeGd5hqs2FZGtWoZI2ozFgkHBoRMcgm66l/Gt3rj
         6UdtBcul/9b4dI1k2pMwb8tb+e/mGKkMO3rgwMIsIICxdpyBKj5Ubfa5Q1f1pweLET
         C+RL66SZo8Xxg6B49fdSqfJ4xwwDx2rfXvhK6/pz9FScCdRJHIpFr4ewoMaCMocs0q
         tc6LbLTCw4o9Tif5KOq7+NyhnFNKjbEiCaobaHidwkisSx/q3rA2WJLYq0E9YLC3oJ
         IQBSbHZXQ97Xv8BXsxtZSgY/5o602o1ALd5Xl4qMzmfILqfYXClwFBv5hzKLA9tyIV
         ZY7WOWR6ninKA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 03, 2021 at 04:15:53PM -0800, John Hubbard wrote:
> > diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> > index 2dde99a9ba07..ea4ebb3261d9 100644
> > +++ b/drivers/infiniband/core/umem.c
> > @@ -47,17 +47,17 @@
> >   static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
> >   {
> > -	struct sg_page_iter sg_iter;
> > -	struct page *page;
> > +	bool make_dirty = umem->writable && dirty;
> > +	struct scatterlist *sg;
> > +	int i;
> 
> Maybe unsigned int is better, so as to perfectly match the scatterlist.length.

Yes please

> >   	if (umem->nmap > 0)
> >   		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
> >   				DMA_BIDIRECTIONAL);
> > -	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
> > -		page = sg_page_iter_page(&sg_iter);
> > -		unpin_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
> > -	}
> > +	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
> 
> The change from umem->sg_nents to umem->nmap looks OK, although we should get
> IB people to verify that there is not some odd bug or reason to leave it as is.

No, nmap wouldn't be right here. nmap is the number of dma mapped SGLs
in the list and should only be used by things doing sg_dma* stuff.

umem->sg_nents is the number of CPU SGL entries and is the correct
thing here.

> > +		unpin_user_page_range_dirty_lock(sg_page(sg),
> > +			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
> 
> Is it really OK to refer directly to sg->length? The scatterlist library goes
> to some effort to avoid having callers directly access the struct member variables.

Yes, only the dma length has acessors

Jason
