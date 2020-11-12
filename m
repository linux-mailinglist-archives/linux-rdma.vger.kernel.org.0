Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2270F2B0D0E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 19:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKLS7y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 13:59:54 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4364 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKLS7y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 13:59:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad86240000>; Thu, 12 Nov 2020 10:59:48 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 18:59:54 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 18:59:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce06tMGKHkSpeUIdksr/TB8Oo5FlLblP7u4/RKvColHvzV2F6juw11QrfPypBiE7YX7JvLtOSGsBfy+Cm5mA9W9sRLRgo4pcxTUNdYisfw83sZJg4yRwmjNhKUJZfzp3I0gA+IrAxY+bM5zKmx7GYx1LSAehHJ2MvTacHWBJc+KGvuwZ5y24wu0HCnq7Fziwc6++JRVylu++pRbGJTgYfUbwjVE7AX1l5YGcTLL53JgSWm6CLCscQa9cXf9LaUOwMbxP1Ro/Gv22PIdJwmQr+rEFt1sjNVJY7pgBUeW1enGnlBtRKU6ZJJZv5mcVgYlsU8ET/Fvro3azSclCVrFCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QR+iZnN2Wi+gM2bJqTnWY4OL9vR0NKERU08Sb3O/1U=;
 b=KhxzFGNEi96Lm392Q0Zml6jBp4OkoLAojx+O/9uhuBO5wQ7Y0hE8a2c/0s7DN1Q+AJM7d3oemnhcFeIufXwVGhvRi/cQVEyBj1vBg2jUCiScD1wTHIk4PowebkMJzdBZh+eBHeZ/DywFYglbgRgy/tx4pjrs2Nt+xmMN7vh/v64QAWuDuEr9mgU14ASRk14+SLyu5/WJxc7+yH/AKCwaHL2iAoRQ7CNVBEBGrFH7JGVqssYykDkvdIx92cf/mfFhI3t96W7lYAEZ72hCIRttIuAtYzZ8lTn8rx/JsA7aSjezCCCxde2mHJgpBq7NGDzrPn8/FL6dlNf6rLIA2fC51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Thu, 12 Nov
 2020 18:59:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 18:59:52 +0000
Date:   Thu, 12 Nov 2020 14:59:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v4 0/5] Track memory allocation with restrack
 DB help (Part I)
Message-ID: <20201112185951.GA981682@nvidia.com>
References: <20201104144008.3808124-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201104144008.3808124-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:208:23c::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:208:23c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 18:59:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdHp1-0047P4-Cy; Thu, 12 Nov 2020 14:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605207588; bh=5QR+iZnN2Wi+gM2bJqTnWY4OL9vR0NKERU08Sb3O/1U=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ZQOfwlAmOcz/ygRM49hNeAKdoekpRR/UZ3GUcr4neoBrrChlRCja0AcS7ITSHB8u7
         1duI5BdUVj4ZFzsX1HxEBJLH57kEJbqEisAE87ex8iu5ky7H8r/dXAILXaA3XNVnVS
         kPLghm5OHVjsDm3R4D3pssFp53kfIlcFGYTsPgfyYkCs4JzblTDD+yE/CPxb3bLGEg
         1zgm4xDEpWi7IM7RwZVC5L+8UZxY+X47mhOhoSPtRwds68RB6ntIAcCfalJ8Y75LQq
         US8XpTgSdmUUuAbu5Wa6G3R8OOzCV4qYFYsuTxafij9X7TzGNGr6g+5VNuqaqOsZJL
         QbMgmbrq6YQFQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 04:40:03PM +0200, Leon Romanovsky wrote:

> Leon Romanovsky (5):
>   RDMA/core: Allow drivers to disable restrack DB

This stuff is never used

>   RDMA/cma: Be strict with attaching to CMA device

This adds a return 0 which is pointless..

>   RDMA/counter: Combine allocation and bind logic
>   RDMA/restrack: Store all special QPs in restrack DB
>   RDMA/cma: Add missing error handling of listen_id

Took these three to for-next

Thanks,
Jason
