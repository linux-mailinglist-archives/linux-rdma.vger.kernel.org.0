Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D317E2C5C99
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 20:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgKZTYi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 14:24:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8939 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgKZTYh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 14:24:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc000f80000>; Thu, 26 Nov 2020 11:24:40 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 19:24:32 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 19:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqMceHPlVXsWbaeTXkglQn78ZDxtNLYsOCwON0jLIS0mKF4syMzrxTv6B2QHrHsJSXHqbhVHGF1SkS4Gq9zvHzH+S5KckmIUmavCZYxWzEB52jXrGrzM7z6BtAT8iamtsKbSn9YqZ+pTaNmd9bNO22qnHSP7mHwttyhR+q7xNcrQiz/hnZ5s34W5uYSibZqxirOMFoOvNAbN+3nLDBhAZrs933SFs30VhOajSTgJuostId0SixPC4VLvf71St30f1Xn3lUDFjcE5gEnY43BsjY2PGAlfg4yHipLv0N3HtkfEyg8jInud383dYQhhQKijUaCDRhSB7ZcczlDbPEPWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNoezosP5UjPV9wkMIRx2NAhSu5zfJRVFbd0StP8coc=;
 b=XvvKghBPgEiILrQcMRlQ9g3q3RMdIvRQsrMt/zUs1lvS6YkvrelvP9zZ0jW8I1RWQT3YRoMmw67KA0jputDUoofRE2L9mFJjymwXKeS3cipi33kBRg6SbmDz0e/856mmVq1N2W2uepDA2EUfOzcKH+X3JKUUfK8f1NKnzO2o2tAKclUt42kVlk++pXWOqHsKACZRD1pg4jGkenKoXsq0GeVJ8s+YjFsS95MJlUU4lhQf8M4im3QPgcdF+iv4CTUWBX05MuaYzbJ6EXbS12ZYMFuNFIWlvoDJkjdxQjGRUsVuYw2i/2r1KbRLMpIC4aMZHX8LB0IzXhBAzLch2osKlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 26 Nov
 2020 19:24:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 19:24:30 +0000
Date:   Thu, 26 Nov 2020 15:24:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Add support for UD inline
Message-ID: <20201126192428.GA547165@nvidia.com>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
 <1605526408-6936-8-git-send-email-liweihang@huawei.com>
 <20201118191051.GL244516@ziepe.ca>
 <7a7ee7427b68488f98ebc18d5b7c4d75@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7a7ee7427b68488f98ebc18d5b7c4d75@huawei.com>
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0117.namprd13.prod.outlook.com (2603:10b6:208:2b9::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.18 via Frontend Transport; Thu, 26 Nov 2020 19:24:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiMsW-002INb-GR; Thu, 26 Nov 2020 15:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606418680; bh=GNoezosP5UjPV9wkMIRx2NAhSu5zfJRVFbd0StP8coc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ICHEu1vG4ijJY2+Hjs3BQR+urOx3IV9R/gSS5niL0xPUskzHPoXsnQOy3qXYFx/BF
         OLGSYAEnM+YdtGdlS11M9U5XSR1JNseL4EpAlPocjusxfTCQjdaunAIgE3f5/Qtm76
         EgVfz5n4PyYs+UsjZ5L2jEnJcK+WjQL0BpXC7YRhc0WfmihpTK6OoeRKsLTj1j9Va4
         bB/5BUmF6rU3x2RtpVkbE+vRNgTRKAsp+qZGfpe6SUsX9c1hSSmzLbH6VZx/wIWXWE
         MaHykZ+Qeq+Y5AYlSapR0axoYPTRs/xUORqo7f7r6lL1rYNKv7qhTYzNosnvb5LGq/
         Zw334x2W6KKWg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 19, 2020 at 06:15:42AM +0000, liweihang wrote:
> On 2020/11/19 3:11, Jason Gunthorpe wrote:
> > On Mon, Nov 16, 2020 at 07:33:28PM +0800, Weihang Li wrote:
> >> @@ -503,7 +581,23 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
> >> +	if (wr->send_flags & IB_SEND_INLINE) {
> >> +		ret = set_ud_inl(qp, wr, ud_sq_wqe, &curr_idx);
> >> +		if (ret)
> >> +			return ret;
> > 
> > Why are you implementing this in the kernel? No kernel ULP sets this
> > flag?
> 
> Sorry, I don't understand. Some kernel users may set IB_SEND_INLINE
> when using UD, some may not, we just check this flag to decide how
> to fill the data into UD SQ WQE here.

I mean if you 'git grep IB_SEND_INLINE' nothing uses it. 

This is all dead code.

How did you test it?

Jason
