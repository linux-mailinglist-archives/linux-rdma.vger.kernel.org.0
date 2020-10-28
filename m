Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7F29DC23
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 01:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbgJ2AV7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 20:21:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1420 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388936AbgJ1WiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 18:38:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99a01c0000>; Wed, 28 Oct 2020 09:45:16 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 16:45:04 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 16:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKPnlpaXjVIG/6JGZ9pvR9Ooj40FuVJnazB2LqNngLPkhQpUGVHPZcA1Ks0S0NzTfatVG0iUz3lqcRSBtAT+UZtQZn/20hm9xGqPrSaod0o+6Vp3wLTvPC0jiwCYfLNUH/oSGGrbeY0mqfZBJO6jAk5iGnbSEv1rlcRdEDdfOyVa+jti3qSFxwFcGUozEseqTTCChUA15CD3acRLHUL2iXEj1558rT0Z3BI2yjQ6qfQGCmeYNTffliDdmlRBJjhIjTbObSVc4XoQfQuSEqSJWal/ByUPmPrUbHBXVzENiEweWf5iPZYga1AOYQ/UifQqxE4D/e7xZ9PT2uZl4uE68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr9WilqchcRu/FnWfgIeDnVRSRbqKIySD09iVpOeuNU=;
 b=OAj+gPbr4o8D10V+VMflws+CEGCUa9PwV/1VZJmKYVzF6Qn+lVch7AuL8AVS+GMXLJxUoBXuLeLsrwr9RWi0ij3CJHVIqroLNsDDw+6+xUzegBOw0JD4X+pQx9pdQ7fK/kHZvywbZLF2tsva8BMvG2ai+oV1e4/qwURGYmwxLTCAlo6KjKKuE5VNxhXPOAUqthLU8pM5oe9evW2BZtBaT53qaiviCByzv09f1Zvel9NvaQwzEZ6Sa4txhvhVLLU6zjP1c9FGEiUrdQ6fa3kZjqgoz/dNj9N+arujaA3kTlbkm94/NtniFIWGQOs4OVpQ5bFBVzcl/1eBhz2pYrIHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 28 Oct
 2020 16:45:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 16:45:03 +0000
Date:   Wed, 28 Oct 2020 13:45:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 0/2] RDMA/hns: Support GMV table
Message-ID: <20201028164500.GA2453249@nvidia.com>
References: <1603508836-33054-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1603508836-33054-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0264.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0264.namprd13.prod.outlook.com (2603:10b6:208:2ba::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.4 via Frontend Transport; Wed, 28 Oct 2020 16:45:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXoZI-00AIDR-M0; Wed, 28 Oct 2020 13:45:00 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603903516; bh=Wr9WilqchcRu/FnWfgIeDnVRSRbqKIySD09iVpOeuNU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=GBShnSlDzgW0sYU+O3ijoNLIvnRpX1u0oZcYSWVKxQpX5wXbeIvPnuai63WFxDsKW
         hkm66DKa9KBssJEv7/iagX0SWML3ZT/DsPkw2GC07NXkgZY6StOdRQhyOU6yc2qcd2
         KihpyBMDYUrC0K07EoyPw04oUk2aY/aZBKUHau99k6k6RFOdSWsWKfobr39hHn07Xk
         K0jxnhGF7AKJ5pN44FGpOdwBFIVYE9NtGAC0cnQhBf32V1XcwiOwVMghHNP8LWJDWm
         Tby6Lh/BRQDYs1nsiAa+BW7TWR9N0g+Ww42bazoWZyq/+WGCMfHYFk+7EVr60JScph
         xF3At19yGao4w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 24, 2020 at 11:07:14AM +0800, Weihang Li wrote:
> GMV(GID/MAC/VLAN) table is used for HIP09 to store above information
> together instead of filling them in different table respectively, so that
> the users can just provide the index to the hardware when post send.
> 
> Weihang Li (2):
>   RDMA/hns: Add support for configuring GMV table
>   RDMA/hns: Add support for filling GMV table

Applied to for-next

Thanks
Jason
