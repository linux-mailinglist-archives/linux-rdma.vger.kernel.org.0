Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AED293A3E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Oct 2020 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393479AbgJTLrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Oct 2020 07:47:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13461 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392938AbgJTLrS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Oct 2020 07:47:18 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8ece170000>; Tue, 20 Oct 2020 04:46:31 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 11:47:14 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 11:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGmxP5lmIvBHBymGY3Q0VeNFnKG7gowKlIOcYkINFTFzbh1B+YM1XQNxRrEWl+9fUZIYEpp56V9cy8QtyuNZcWY3H8hbAOF+oOkOkwvMuAFuEKHYv1ALgLC+lbmMwqMqRit+JfwAJ5g0v67Rxcn8VKTgBd7+0Q8Bj5M0AF1+C+j6rjxsBLs7eQe1Qv0SYVtePMJOx5aSrrGPLbT3+5AblypIqU71LQrPpsvNq87yaNrfNgbd1mNQDCmgwStMBUEW1CCoHLerzbsJMm5Jqfo9pzOtBdP0UslLxc1KTOyWKlwlm552/BJvELHX3kptusfkU6hWon/lc3MsbpRU0AMtjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yic1RmSKXSgCSXrw3W0Yb+O0cwrtJQjdVpDi9cMVvJ4=;
 b=UknTitQJ62W29CFcfMHBfE81cz0BaRVDCCiBYErdRFI31OKb843DcIGp2dorXvayxfComLeh61W41dMJydH3LBBdgrNygtF6pick8zCXLUktOx2hXUf1R629kiyxbTuApIRBl2+8pinkhxnrIFyxPgnNWbZ5tq9jWpv1epwc6s7pvLbgFShhiM7nNLBUbM5XsA1KVfKGfCDt79rzmhvHn7ayrs6gZmziKTZiMcheegwYaCQFFVMhW0YEcNoZzptHTDlPjgTYQrE9p5pQzlegG9N9hSMHNtEB1o4gPYpbaM4qBFsW9MgH32Lqq30zff5NiMEEHVp4PDngCcCawomxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Tue, 20 Oct
 2020 11:47:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 11:47:12 +0000
Date:   Tue, 20 Oct 2020 08:47:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     Maor Gottlieb <maorg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        "Gal Pressman" <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "Leon Romanovsky" <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: dynamic-sg patch has broken rdma_rxe
Message-ID: <20201020114710.GC6219@nvidia.com>
References: <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
 <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
 <20201016003127.GD6219@nvidia.com>
 <796ca31aed8f469c957cb850385b9d09@intel.com>
 <20201016115831.GI6219@nvidia.com>
 <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
 <20201019121211.GC6219@nvidia.com>
 <29ab34c2-0ca3-b3c0-6196-829e31d507c8@linux.intel.com>
 <20201019124822.GD6219@nvidia.com>
 <03541c89-92d0-2dc8-5e40-03f3fe527fef@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <03541c89-92d0-2dc8-5e40-03f3fe527fef@linux.intel.com>
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:208:23e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Tue, 20 Oct 2020 11:47:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUq6g-002thW-5G; Tue, 20 Oct 2020 08:47:10 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603194391; bh=Yic1RmSKXSgCSXrw3W0Yb+O0cwrtJQjdVpDi9cMVvJ4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=DvzCoAVIvKnpOvhzFh6J1AFA3FaqLFPrXikWCBC0f9sniamcS6rry3FM2R0veX3zP
         5HdUKbayiPbOyjWyJwI8i6/UCUZ0o7a44Sac+UA6qf5gdoekO/1ylw+bztnMhcsMZF
         ktPKiQ+/elSN5ujUC3TviN9bGVRf9afQGJ6pSGigpV5vQ/BTRiVleaOmSuQusMm/Rs
         ZwIDx5/EuFQlo/csKYt9oHPxG7J9Jv2gxOSU+F6qYvuUnpkpZmrkDPdmHb1Z2o34Di
         73l51WWMfRXgLElNHD/Q3lrct+5o/up7rEYd07pQm7TsGEbq6JJMmnxir2boipabVd
         Q1a+bkdB13klA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 20, 2020 at 12:37:05PM +0100, Tvrtko Ursulin wrote:

> > Why put this confusing code in every caller? Especially for something
> > a driver is supposed to call. Will just make bugs
> 
> For max_segment to be aligned is a requirement today so callers are
> ready.

No, it turns out all the RDMA drivers were became broken when they
converted to use the proper U32_MAX for their DMA max_segment size,
then they couldn't form SGLs anymore.

I don't want to see nonsense code like this:

        dma_set_max_seg_size(dev->dev, min_t(unsigned int, U32_MAX & PAGE_MASK,
                                             SCATTERLIST_MAX_SEGMENT));

In drivers.

dma_set_max_seg_size is the *hardware* capability, and mixing in
things like PAG_MASK here is just nonsense.

Jason
