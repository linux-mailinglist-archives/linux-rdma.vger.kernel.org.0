Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848AF27D58E
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 20:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgI2SN2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 14:13:28 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2703 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI2SN2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 14:13:28 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73793b0000>; Tue, 29 Sep 2020 11:13:15 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 18:13:28 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 18:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSpnTJNWZWp+4cm+QIR1NQvPExMLfNRimzDQ3QIjRvp3AKdO8HpbaUq5UlFLy2nzn5EpyVBrwLJMDK5TuSipK1pZSHsdQL2JURsPKIert9WJA0/GPQAZOpib7CuP6P1uxyzMCxLhLXUm47xuONvaxiU4vIFr4RQDHRavqVXCKqMseG+KRinPA4Nsz5HmiR7OA+tKiSYbNVg6XRkC3xvB4lkN54bTzokkU8qQbIRhajkTxSxL3EIJk+RgAhE3maWnLmPxpHTE+gqP3kpL7ULyWmOsM5Qpr0mY4rHQeEAWYowi5h4tQ01JxkBHr4zkdreDRkXgzQh7dpVALHw1/CAo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1ZIeeHRMTt44FSSvtNqgQQm75eAeUQZyq/xGv5Fgb8=;
 b=J14y5UCqoPYmYgCXpDfCmtxUuN4IP6w0JwSud8vp66tMPN3bVjnmLoNK89pgRnSYLuk7Yt1QCn2z4X6yKSAOypkk4ztI0IlgCt8WzNzPT76HkQqS8w771lCqZYfRu0+URNziIeUCaCmfgFdovyOSk6ISCXGwM+MIHVn4FuEYGnaJX+l7VKUWz/fVFNlP92FVvD6mZbts4CVm9hMVsSSkJcPZkezmwZrVSafqTBdFQsLN5csMlBYZWoLQtu7ttjspnMhA1VMNx2dIBroEUi47QTa2CTwg11941J77vZJRKBrIFVCgsVsYYoDt7SEkbFrhLfWKmUoDkysn8rTm/HwdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Tue, 29 Sep
 2020 18:13:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 18:13:27 +0000
Date:   Tue, 29 Sep 2020 15:13:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200929181325.GA9475@nvidia.com>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
 <20200929175946.GA767138@nvidia.com> <20200929180210.GA5012@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200929180210.GA5012@infradead.org>
X-ClientProxiedBy: BL0PR01CA0026.prod.exchangelabs.com (2603:10b6:208:71::39)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR01CA0026.prod.exchangelabs.com (2603:10b6:208:71::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 18:13:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNK7x-003DtA-PE; Tue, 29 Sep 2020 15:13:25 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601403195; bh=L1ZIeeHRMTt44FSSvtNqgQQm75eAeUQZyq/xGv5Fgb8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rMBFPb+TWy9IL3BwimaJQk+N62r7EhbtZymASk5dNx+CRFapbhUPx6PPR+RWLu7Ht
         E0NvUxHORj/AWdNWo/LEw0DqgJ/yenl7HkB3D07Qz/sAu23Fl3BcMlpphdEHMFyA1D
         2TbMkBvmH2az/tSZ6H3oMWHth3Qs3nfL8ALNMjYTjtxvXITpStTqpgFLSDJ2eDn6ml
         EnSPYGsOA9YnGXAKzMmDRmbGIVFZ45uds/xHfglElOq+U/cPf5XQlyAeyiWS2E+PA8
         2PyAUHFUWyW28vSuEnSv5rBASqwJGRu1DFvqcjtPAxAy9udSFzyqAe7+Wsq9LSNWIA
         PDPTGCJYiMSMA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 07:02:10PM +0100, Christoph Hellwig wrote:
> On Tue, Sep 29, 2020 at 02:59:46PM -0300, Jason Gunthorpe wrote:
> > This leaves *dma_addr set to ib_dma_mapping_error, which means the
> > next try to map it will fail the if (!dma_addr) and produce a
> > corrupted dma address.
> > 
> > *dma_addr should be set to 0 here
> 
> Maybe the code should use DMA_MAPPING_ERROR as the sentinel for a
> not mapped entry?

My eventual hope is to be able to send this DMA page list to the HW
without having to parse and copy it like is done today. We already
have it in a linear array that can be DMA'd from.

However, the HW knows 0 means need-fault (the flag bits are zero), it
doesn't know what to do with DMA_MAPPING_ERROR..

Jason
