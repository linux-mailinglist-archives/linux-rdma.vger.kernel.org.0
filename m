Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB76B2C198D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 00:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgKWXpz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 18:45:55 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:21978 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgKWXpz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 18:45:55 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc49ae0000>; Tue, 24 Nov 2020 07:45:50 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 23:45:47 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 23 Nov 2020 23:45:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/6/wHjqLAa1Fvq0z19HpHWiYP7iB8QAdSKNj/JCUTD457s8iog4FjdFD6DwtuMOPEyevjYY4F+ShtkYYBMM0LB3Yap5JpG9LTPB7mZRJ69Jp3vWNs9WByoNQq2Uo8uLkxmVvu1hwfO1OHH66EmDrPpSR6lSqep5m/hlmwlSVdnJn0mKKmrWJwe/nfx8IO67QKCsce7oEGpTfRewpTQVsJGlXaz3ZHYyKluCwQp+Q2ZIp6ng2q4p0C1xeA/UktdcgwuddK86PXDDO3ZC85cJGRmYUJpgJC/vd14L2rZqii7OYskxzLu6i5BIjltIcOg1VbkU99Bx0q1la1n7RAK/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E01IzcN4XoZ6n+sfxHTo73e1HBdmVfQ3RmtpDQ4t1h4=;
 b=LPwZOIDoILW/l9wm63ii5Jk8OSxNEna9lVWsBF5uoqcM6K+tZ9r1nk82Lrdh895XMjaQx7bj2tyQDJqfRCeCT1zJaXBjiktFKuTC7u8kO4axbQRFh2VIIuGAWornXDqAtG8Gj2X3WM9WEJojAOCmkReDjsFBfWn7x39virhxaf/APBS8iDHGHHkFKFokyPVUoR5gmwoefT7D49SKYA2/oRqQiXPQ5ZxpWPdfol3CIZHUFX2YrBLh5wYUL5Q7MseSSstTTDidjGlN5+DP8jmxl1/6W2kpP6x8Bz68VY7VQJqRe4mwic8yvj+R5adueYO8YstsXYHvRMQwp17Guj4vUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Mon, 23 Nov
 2020 23:45:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 23:45:43 +0000
Date:   Mon, 23 Nov 2020 19:45:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Danit Goldberg <danitg@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Divya Indi <divya.indi@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Moni Shoua <monis@mellanox.com>,
        "Or Gerlitz" <ogerlitz@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Xi Wang <wangxi11@huawei.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <target-devel@vger.kernel.org>
Subject: Re: [PATCH v4 07/27] IB: fix kernel-doc markups
Message-ID: <20201123234542.GA142861@nvidia.com>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
 <4983a0c6fe5dbc2c779d2b5950a6f90f81a16d56.1605521731.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4983a0c6fe5dbc2c779d2b5950a6f90f81a16d56.1605521731.git.mchehab+huawei@kernel.org>
X-ClientProxiedBy: BL0PR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:207:3d::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0071.namprd02.prod.outlook.com (2603:10b6:207:3d::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Mon, 23 Nov 2020 23:45:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khLWg-000bAy-7V; Mon, 23 Nov 2020 19:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606175150; bh=E01IzcN4XoZ6n+sfxHTo73e1HBdmVfQ3RmtpDQ4t1h4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=BEoa4QiccrY265iqHUpgSzIo2RLsJuTbTSVfaQ05KIRZlCsIAoBAbXwqw4nvzz6Og
         wcRlLjRne2NISETCbo12ASmp5TjAgp2DoJbdxS8kSBdspyIGTkmW0s8TEYWHJLDNnQ
         4uM44NCmtE0Qa/cPB+lpyc7ElBW6TJ/+WuB7TTiZoh387hw3sVPhakeREtv0oyT2jD
         GXAXUeUX6Z76tnjbPfHFj+Pe0XOPev/CLuDkkkBY1/Wii7yHpx/k65bkOaaR4pLwTT
         LD30Ivpe3wE2uG9wGFRofSRbKyNq7yFQ461pA1tOCd/0O0GhKQ2g9Dtk6fabOP+u59
         FC2n4rHrvDy1w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 16, 2020 at 11:18:03AM +0100, Mauro Carvalho Chehab wrote:

> +/**
> + * ib_alloc_pd - Allocates an unused protection domain.
> + * @device: The device on which to allocate the protection domain.
> + * @flags: protection domain flags
> + *
> + * A protection domain object provides an association between QPs, shared
> + * receive queues, address handles, memory regions, and memory windows.
> + *
> + * Every PD has a local_dma_lkey which can be used as the lkey value for local
> + * memory operations.
> + */
>  #define ib_alloc_pd(device, flags) \
>  	__ib_alloc_pd((device), (flags), KBUILD_MODNAME)

Why this hunk adding a completely new description in this patch?

Jason
