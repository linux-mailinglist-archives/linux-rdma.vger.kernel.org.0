Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D8027DD67
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 02:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgI3Afl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 20:35:41 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:20018 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgI3Afk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 20:35:40 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73d2da0000>; Wed, 30 Sep 2020 08:35:38 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 00:35:38 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 00:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpDaJQy+zJI7UbNoM1P2MbPb3bzdv5vzABNUcfGmyRnXjO/l+okqZ0jR4lkcDjOf+fPGCMzbOqT2s/5lmSpgZB701O4oMFb9pcxSvBd6H5GhbFgaV0Pc3r4wIKC1LJ28VZuuzy+hVtpjjNX4fYbbMBemo6NYRORGjPjdUImqhb78gHN2H4Xej/+I3UKIY6rXG9qF6sUL3sMT3rBjV6qsXci4PJLuhXCO/ZKWusWSeVLLmzeau8G80GliRlcZ4zZfHcyAtf9G8kjH5axmSTE/mmNNIriq61gL3OQmYXsR6u/oZHKLSTmEZgsXWKVPkNuPoodFlM+lNnHQ9Aoao2C+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKBhUrqo+rfkCLr7U89iG35APhS8Zl4/m75HF31p5SE=;
 b=ZtFtTiltv+n7nqH1J8Jkp8TSNkX4/2imat9lbBVD3c6C4F2MJUx8n2gOiDldI06WIjoTJYCkq0YrCbExZcH7dM3N5d/3nHS/uCmmRcGYZlvcKmriiFmrvvluZSvLjDwLaVYRh6xHO6utQD+cuxau63+AqKsRoStW4o988QVFdvw/9EsgUaP271inFrTe5nwqlBzfEMpOFxPi7EWuCHcx+6Nl4vICJg0SYXzxXuJyyc+6SQrn41mG+mO54TfLG+ifgrvQ5hREic2nrJLdVMzGi9U/Wt/Gr6ScAoG+c32LjyC3nCMznW/mmacaOfTzaErKBhIZrEnbqMZ6qJNyUb9FBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 00:35:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 00:35:33 +0000
Date:   Tue, 29 Sep 2020 21:35:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200930003531.GA816047@nvidia.com>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
 <20200929192730.GB767138@nvidia.com>
 <089ce58a-a439-79b5-72ac-128d56002878@nvidia.com>
 <20200929201303.GG9475@nvidia.com>
 <c3b37733-f48b-bc97-9077-60dab5954702@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c3b37733-f48b-bc97-9077-60dab5954702@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:91::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:91::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.13 via Frontend Transport; Wed, 30 Sep 2020 00:35:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNQ5k-003lSm-0A; Tue, 29 Sep 2020 21:35:32 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601426138; bh=YKBhUrqo+rfkCLr7U89iG35APhS8Zl4/m75HF31p5SE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=I43+B4Q9S/6LrQYUcSm99KeFvbwlshPNT7pTgUXBecnCI2JoYyPafTX9N75IKb1Wk
         KONODFlxnl9pZN2i9CNXdaRPu6qJ2giixzxx2tMMOGTtd17Y7wnD2d+xXC2vpgUiby
         Ft47wnQIWYpMPae/0B+bJgpcNNgnuwA+RoZjrWnkY1A7spSJneJ6yUCisIQsYumpO6
         4X9PTezrmtb00jcDK+ZHNBLcvXV2YBQl4Rz5xqSyKoROMG0PSYtdau2pyNBQ4K2LRv
         iM/AiG/u8jOEOaR8UEJb6KJBkxy1OFDi0QimRxf6FS/uC1uDdq4Szh33xB+FTVPlR1
         w36OwYpGpZasQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 12:34:55AM +0300, Yishai Hadas wrote:
> On 9/29/2020 11:13 PM, Jason Gunthorpe wrote:
> > > > > +		WARN_ON(!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID));
> > > > > +		hmm_order = hmm_pfn_to_map_order(range.hmm_pfns[pfn_index]);
> > > > > +		/* If a hugepage was detected and ODP wasn't set for, the umem
> > > > > +		 * page_shift will be used, the opposite case is an error.
> > > > > +		 */
> > > > > +		if (hmm_order + PAGE_SHIFT < page_shift) {
> > > > > +			ret = -EINVAL;
> > > > > +			pr_debug("%s: un-expected hmm_order %d, page_shift %d\n",
> > > > > +				 __func__, hmm_order, page_shift);
> > > > >    			break;
> > > > >    		}
> > > > I think this break should be a continue here. There is no reason not
> > > > to go to the next aligned PFN and try to sync as much as possible.
> > > This might happen if the application didn't honor the contract to use
> > > hugepages for the full range despite that it sets IB_ACCESS_HUGETLB, right ?
> > Yes
> > 
> > > Do we still need to sync as much as possible in that case ? I
> > > believe that we may consider return an error in this case to let
> > > application be aware of as was before this series.
> > We might be prefetching or something weird where it could make sense.
> > 
> 
> In addition to my previous note here as of below [1], ignoring the clear
> error case might break some testing that expects to get an error in this
> case when the contract was not honored.

The error code should be preserved, but not all callers care, like
prefetch for instance

> Also not sure how the HW will behave, won't that cause an extra / infinite
> call to the driver to page fault for the missing data as the result will be
> success but no dma will be provided ?
> As of that I believe that better leave the code as is, what do you think ?

The HW must trigger fail if it reaches a pfn that isn't valid. The
return code is an indirect indication this happened.

Please send an update tomorre with these small changes since it is
late for me now

Jason
