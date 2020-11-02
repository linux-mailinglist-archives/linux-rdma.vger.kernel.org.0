Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7352A348B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 20:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKBTuo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 14:50:44 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:9554 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgKBTug (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 14:50:36 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa0630a0000>; Tue, 03 Nov 2020 03:50:34 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 19:50:34 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 19:50:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6xI3mYJCN9kM/2euzuic3WIVyyEBjY1xF2n6wHzhH0fAJtGqc7aRoUvgDI+SqmJlPZvh8p59wq1Cl9f2Ab9q4A1PGqlWqIi74HhDEeXXJHUoP1DeltP2UWIXg9TGq6ZDID2Zzkwr/sisGhIK0Ueii/CTmIZ12X7zo2ddhLLN6nqUGDx53jYU0oT+0b1ngnsC2zZ/aprZLMG8se53oWDAKWI/a7sL+y6YrzqTbSwBw5+DOkaNDjE666a6uIQBED3cWUHlDz5i4LlKYLdV7ura+g5eX0pZOelml2KDPsF88NFHE3y6DrxJjkEP1IRg1dSUrVBv530b+dY8/Szw6uKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0zoCH2jyv9LJzZOk6v8R/YohHGv9pKart4RjeCaTwE=;
 b=MFMPXOrHXmwbwv6Wo98Zbc5W1+dCJ8YkOLX0p+0VaLxi2NQXWUzaTlkGM76xFPkDzZIEtpaGumn9QnjOQO25i7n+16a79ShnobyzJ7LfmDuSf3fA/cfJ028LDWpYIE2ZEyQqJqSO2A66ukP594Lbh9vnqPvMWmnokQbGuih+SIYeSeeaAMZOijZv6xEeP/IjjVt/4VJq0Zo24X8w+OOlKsavWJRQx7zaSzx5HBFBqWnCttRW02Dg6ED2YroR7ZdfXoBXLUoZjylQepYB+jiIJmLyhKKCL8/fW5Qh+XkPrvizBcOdWKzOWDmzzjxAeIQeFv7krhScW1jpptodsU4uTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 19:50:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:50:31 +0000
Date:   Mon, 2 Nov 2020 15:50:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Meir Lichtinger <meirl@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/ipoib: Add 50Gb and 100Gb link speeds to
 ethtool
Message-ID: <20201102195029.GA3726340@nvidia.com>
References: <20201026132904.1338526-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201026132904.1338526-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:23a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 19:50:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZfqX-00FdOv-Ae; Mon, 02 Nov 2020 15:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604346634; bh=o0zoCH2jyv9LJzZOk6v8R/YohHGv9pKart4RjeCaTwE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=oeGJxhg+2Y0wbYx9y+mwStvXx2Si7Q5etgoixItrKnz1/hXiWTy/sATzxv/9B2HCB
         eQtfphs8N9TqC0zqFeuyecfyw7npTwealyRWgrZDWzFVPwds26yuez28DpEcxtzPtT
         JD/MlOUaK8+PZt8Dcag0cROeJbleqcxuhPZnVl20ZCJmqIy5hhPzyMTtqxBIS3QTbF
         NneFkaSyu0jTxMtcupTjKiofBsDFqgHci+edi6xWes9FeUFdwtTdD5D9S8uG9A+ISl
         HhpY4Oa7fxc/d6HvZGBXacD8FTxlwBK2ju07dKQVY/PNGqsWMmL9TT9EWGW/D/4sLt
         kGHvqWt9vb6dg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 03:29:04PM +0200, Leon Romanovsky wrote:
> From: Meir Lichtinger <meirl@mellanox.com>
> 
> The IBTA specification has new speeds - HDR and NDR, supporting signaling
> rate of 50Gb and 100Gb respectively. ethtool support of ipoib driver
> translates IB speed to signaling rate. Added translation of HDR and NDR
> IB types to rates of 50Gb and 100Gb ethernet speed.
> 
> Signed-off-by: Meir Lichtinger <meirl@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to for-next

Thanks,
Jason
