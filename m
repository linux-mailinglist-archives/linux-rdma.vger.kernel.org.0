Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF90E2C57C6
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391306AbgKZPCZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 10:02:25 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15002 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390811AbgKZPCZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 10:02:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbfc3840000>; Thu, 26 Nov 2020 07:02:28 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 15:02:20 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 15:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmM78gFW9Z5cy7LlQc7UPt84mUOXBLZ2yzQErA5PJEYn6gO3gLfrykBny/7Z+bTcXFoDP9Yks+AnCvvd+wDqtnwqP6vpzlQE2xmigxRFhd9SWLXAH6V/lVpiUmF3N2rskvYRpXZxadKaoC3LP6jGoY5Ezg6RBC0jWpvacvCSnECaQvN4x5fqAeDX/LXQwLzZ0GooRb2YcpRT0V1vwGZvU9gJVhsessm121QH41Z3FtwJytphnaPaAM5hSH2CG9u/Pf90/FmLsaEDfu5dFqEwX5W3ejnkGgS1jUX8FRNstK/KUJ0g6cc9fONFMHgCucRPA2QxlyVimf4OZKsaSuGaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfy+WhN3kp1rALCOPH1zrbYYifZwfVTBbg8Y4Z8ASXo=;
 b=Ml/jRdGwSP10E8Vlj6AATp+Bh0Cr9H/t0pZUtTkoOlTPR4dBkL933vLucRTiaQl582i6Lc/7L6Wl+J7+R5aVA9Z5qQ6nB7ISc5mz0jnqc2Og0/ydRZ0o7SehAPmtDPU2Qnz7+bnerjrggabxqUBaw+FclKnvUav4oFI5QQaOZUrjqxr4hcoRGDwnNuu6BAFLJVI1USmAk9m8qEjiuqkSVNWm5AWmSdpnLtI2OBHrXGMXxu8uGWuAtmSf23K3KspflisSVZBHqwPNFKctU4NmYlolficTOhYQbpxQOOdtVL04ftlEk4QVoZ+aGq3Pn5fChxRiR56MyGW7tkk0w3aW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 26 Nov
 2020 15:02:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 15:02:19 +0000
Date:   Thu, 26 Nov 2020 11:02:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Bugfix for memory window mtpt
 configuration
Message-ID: <20201126150217.GC520564@nvidia.com>
References: <1606386372-21094-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1606386372-21094-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:208:257::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0039.namprd13.prod.outlook.com (2603:10b6:208:257::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.8 via Frontend Transport; Thu, 26 Nov 2020 15:02:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiImn-002BTy-R4; Thu, 26 Nov 2020 11:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606402948; bh=Yfy+WhN3kp1rALCOPH1zrbYYifZwfVTBbg8Y4Z8ASXo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Ybq70brhfspnhiv4RBOJzkzF+6AQ3TOdO5Ge5wRL+pFuA1E4dXrNVir7vPWqUHBdp
         YH7pw26/sv7Aa8x+ZMdWHn+rFWWK4HEKG3zTDbfRbIBXToAIA6dCpTS1CSCPSFq+ci
         Qai+t01bqLFfOLp5LkWWoq1ws8gBf11PAifSIMSfT5G4eveUXEJnlwIEGDVb1nazEt
         JlJ5Pmv+sdc/pmn4OUwKsOWsEBBzPT526uQcdpJF4CXLDNqjoa0PzG9kRt2LGq+RMt
         YJa50Tn4TUaBvnEXIKXBvogIOLlvmO4JtLaEP+DKrzTAQ90yf7gSkezRYgwwQ63ufu
         nTBASUlB1tkuA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 26, 2020 at 06:26:12PM +0800, Weihang Li wrote:
> From: Yixian Liu <liuyixian@huawei.com>
> 
> When a memory window is bound to a memory region, the local write access
> should be set for its mtpt table.
> 
> Fixes: c7c28191408b ("RDMA/hns: Add MW support for hip08")
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

Jason

