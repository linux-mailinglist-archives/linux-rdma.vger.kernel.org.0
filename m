Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B02B0A38
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 17:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgKLQiq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 11:38:46 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:7207 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgKLQip (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 11:38:45 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad65130002>; Fri, 13 Nov 2020 00:38:43 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 16:38:39 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 16:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr8dW4eis32u6WyUiqRsWXP472mU2GBxeA/WYggJDrQeLe1C5zWIHGICNtK7qVlxeTKnL9l1d8W/QUPe1Ebk5s6aTYyZZnFuB8vQT/qlclF3vV59qMb/A9lklVVBlucFqGliJeqUHR6kfxzwn8gQAGrJU9DHtEutv4CowApD0638/vwdJs3pC1dbdZolp6BgfJBjFfSzWpm90lNXfxwMXZpOpVKn4wiKd1aRxvH+mRz0F0cM0VooilG/4MKoHsOEIhXH57NNfktApq4nxKRMvuVxKRZbbbIoUREAx+hxmP4VmNwZ6k0JsL3fvQYJrbyrCWhwDXsVQUSyEaoUvgYdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcTG2IcE1Hb9XQM+imSj69ZypnT/1I6k6eML/+1ITjg=;
 b=KnCWxCBLVx16z4QVV/TTX8QYj+WH9q2WS9CveIT+92CEvukh2introSF6Lp7OCk5YUIWKH2y+efNsxKhOgyNVANgERKxvDao13zPZOBckZleM+SFk9I4WSVG3bmZtpQpSGj4ShYdxLPq2ME4SvYRblC2GJAe6VPMiaUT/S2JHHKW1FqzZuTbUJGk0ZWkI4IA7ftqmhYiDyZ3LrB9yGq6QxUA7/dvKordKURcDNzf3dY0EhCk3ErRf3dyUUCOTWcBH5SGbNjbVQfgapjea4KqMfyvpI0IBzy+BPbfFLNOKTU3TqPPMydo/3Q238urhWZhQvr7b/HktWQS3okCoRGhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 16:38:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 16:38:36 +0000
Date:   Thu, 12 Nov 2020 12:38:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zou Wei <zou_wei@huawei.com>
CC:     <sagi@grimberg.me>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] IB/isert: Fix warning Comparison to bool
Message-ID: <20201112163834.GA917430@nvidia.com>
References: <1604404674-32998-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1604404674-32998-1-git-send-email-zou_wei@huawei.com>
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0065.namprd13.prod.outlook.com (2603:10b6:208:2b8::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Thu, 12 Nov 2020 16:38:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdFcI-003qgV-FJ; Thu, 12 Nov 2020 12:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605199123; bh=GcTG2IcE1Hb9XQM+imSj69ZypnT/1I6k6eML/+1ITjg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Ep2SaKfHIYMJRpjMoXvvW583Z1GiEsgWiG+WcjXxVb1dA1TNBT6Y0/F9sQ/JghhY0
         PoPi4D95MllY2KexDQUtRdXZejiHRIoW4xed5nFQJ2y7I0kPlyAiWSK4LRsaS3R4pu
         t5WIpxKv8kRa4nCh+GuCnxy6N5Kb+PaPNfsNYtedm/i2qwOG003EKRQDrL1ejrP7ig
         XyKqTxFdA+s2d0aOd5bHTYDBZREccS3fEKrotod1zUlDBn75unvMVmFGI0REpoHBHA
         fuKMWmeZR67rcXO/YLLjsmXiyQaszxN07mXMfz0e/3v6SDdpv7zEp2eKzr4XWp8yj8
         9YzeFUK/rukaw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 03, 2020 at 07:57:54PM +0800, Zou Wei wrote:
> Fix below warning reported by coccicheck:
> 
> ./ib_isert.c:1104:12-24: WARNING: Comparison to bool
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
