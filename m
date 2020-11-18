Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3932B72CF
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 01:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKRAEO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 19:04:14 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:42556 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgKRAEN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Nov 2020 19:04:13 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb464fb0001>; Wed, 18 Nov 2020 08:04:11 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 00:04:11 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 18 Nov 2020 00:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyzMdwsTynwiFt9aB2X7qDtc0k5d5CWBbQU89Egua/UWdoDGvU1e0+qDr8GhP8dZ9bgZRkklgPCJ1tfRaDhMI7c64nA2iL7xA/y8afm/tNn6N/hspFZnlDEr/AsvZkL1/fiJRU0JJ1MgLW3ZrkB8TwvnPDZq3zjfjtCCYcpwzTFUIx7O+N4J99y06b9sK0sJ+Psa4TaUQ7BkMJjDVfD1GXYa67Me7HayYecz1Imv1ncunIZmSXJL9lSMD4YxnqddUNGlirJcEwMLqZqDyRM9KjRYvNdxmD0IfqmRFD6WImEJdf0Ku1aglKHIU2QWqTm1+SAWz4/kpK+XJlhxtx9G+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcL02MO308VaMQDEOZ9/+zv+V5KmIQV9n/S058mT90k=;
 b=Pk5/H956WVEp0W7zEKYHOnbMwxjIB5JGvDtT7Zt8GgKpqfw9/HZ+vbdr8jZ+UfetcjbEKCpaF4UppZJGYXCkrjcDU8jQ+3M744HeOfnWlCkIye+kOd9+PKe42lrUAaI6GKw/9Ck7h+BHKRXi7EbThdKhSnKIZzc5MfuxknNDNRzVE2r09HiVq8MHuNFmkI/81FI0IMchQJWOUwhkijZY/3+CoaH5YBuz8ncodt6tKCwXkOsxWx6ryLgmf8v30o5FVJ1aH7wtvIb7i7a5o+Etl818r9dJnqlQvad3OoYhxNFzUTxFiHkviXs34vRqayKI6mmO20QQrWDRMGErLNC+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 00:04:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 00:04:08 +0000
Date:   Tue, 17 Nov 2020 20:04:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] tools/testing/scatterlist: Fix test to compile
 and run
Message-ID: <20201118000405.GA1778133@nvidia.com>
References: <20201115120623.139113-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201115120623.139113-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0002.namprd15.prod.outlook.com (2603:10b6:208:1b4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 00:04:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kfAxB-007SaW-MW; Tue, 17 Nov 2020 20:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605657851; bh=EcL02MO308VaMQDEOZ9/+zv+V5KmIQV9n/S058mT90k=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=lZHn4sWyj09u0CNYm6zuM+ia0hfYfsaablRftaDil7ykgNKwqtQG2tn2oAj2KNYiz
         fpxctAK1Oi74c2wufRTNd1BTdXEOkMkwwPmBmk3+arcQ4FM972bN0PJIxfV4fDu0FL
         0s5BIIswkHBtqsjPgnBGpJ4SWTl21G7HxkqXMcUcpboof8qjxW9UyqmL6It0AA1VaN
         8PU2E2QvZjiekoYJcFallRyEEV9ykzyR3oRU1tdNIaI1ZpdPhD0gGUlXEU89KqO0ZF
         GrbtqSK5iScjoir3JzBTfc+AeoMxbetO8JVrmYClMUInc46iWSl+LdVZZ59Y7Tu/Ha
         WSU/9zPOZbahw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 15, 2020 at 02:06:23PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Add missing define of ALIGN_DOWN to make the test build and run.
> In addition, __sg_alloc_table_from_pages now support unaligned maximum
> segment, so adapt the test result accordingly.
> 
> Fixes: 07da1223ec93 ("lib/scatterlist: Add support in dynamic allocation of SG table from pages")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  tools/testing/scatterlist/linux/mm.h | 1 +
>  tools/testing/scatterlist/main.c     | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
