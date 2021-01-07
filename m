Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F82F2EE684
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 21:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbhAGUDh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 15:03:37 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:63623 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbhAGUDh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Jan 2021 15:03:37 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff768ee0002>; Fri, 08 Jan 2021 04:02:54 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 20:02:52 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 20:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUobc4ZNi5Qynop78MkoemXzKDrpC0t+asGNzsEAefxIeAVYkPoQX1L4aHrlSPBhDQtC3Lr7AisACOWQPDdp7KV3Kv+OMAGMXqpjf3yqBPLo2sD7+h3XFshgtloPdEfVxeLXKNbx9bX2qu8kkdZH2XW3C+nURUSI/tRnvfFeW58m8Aafrq5TCOR9WpWXchMb3E+R5PVkn4jMiHU7dMaN7BShicM3cxdGzOcTy7ujCdZnOvoaTzugC6uu1BIwfp0W7+h/X42H+sWfKZ6CL610AyRXn+yMMxJErq4Gj2YBJDX2mt2mBLaCuqswrfl0IU6w+Nh2JlDPnfj/ubFFIazMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cddHvAGoUNp4+Mb5v4KfCvEZA4FofDsIXOFSeUsEz7g=;
 b=nTvSgk54+/bRqzDUyE/BYj1Gt5fOU38wCfpmBP6vNmxPlhengkzOxQBV2+AR0v2AQFupv6M9C8c/3KiOWgNdkLDevmAsx+G7TqZBXjVKBXzJsw5EQuZfMGac7m8LfUE9A788Ht9HhW8PVCb5w+UUGMoMLn0vbzrmA2iDD8zhgeBFC4GR9aSH3l8ixRlSB+KIDVXAUhRfuPoETMFMZZzRobEHQW2NliwB5SpyRzJKyZ1tlIcmdJl2BAfi2jvp53IRxSPIOE+6hwF7n59PC+9EK2xnIue+1Plc8tIrisiDn4vBhMJfUR19a63fAN1UdRa904iew8zrloGQ7pWoayCScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 20:02:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 20:02:49 +0000
Date:   Thu, 7 Jan 2021 16:02:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <trix@redhat.com>
CC:     <oulijun@huawei.com>, <huwei87@hisilicon.com>,
        <liweihang@huawei.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hns: remove h from printk format specifier
Message-ID: <20210107200247.GA930381@nvidia.com>
References: <20201223193041.122850-1-trix@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201223193041.122850-1-trix@redhat.com>
X-ClientProxiedBy: BL1PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:208:257::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0058.namprd13.prod.outlook.com (2603:10b6:208:257::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Thu, 7 Jan 2021 20:02:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxbUd-003u2t-9e; Thu, 07 Jan 2021 16:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610049774; bh=cddHvAGoUNp4+Mb5v4KfCvEZA4FofDsIXOFSeUsEz7g=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=m63cFHnaqfcge5oFoTMQi4Tb9x34ZFn6STj0R/sj8qps0bCnvXUXT1hV00f4GaNTh
         MpovPPv5klqqR4+tvSBg9CHsA7xByzYWbXgIEPIGi+jegtEkspoJfGGCk1ZvJLXNrc
         SHPs+RvjZQwwWpdh7tJEr2Tp0oKkPhmG5YLHuOCzYkroKIrEmDErdA8T9tACHGDfnM
         6ac8cmIR5M3K7vJmk8w29zqlezh9Am5hdA9InwI0lW31BCYA8WChLxVNDP2rFfRyLG
         7eJ1AYMaQFUKegZ/VbVbgWmsPdGSinwcoInxgarhFenO8CUsTLZdkag0gFnkAPL4CI
         NV/i9IJsVDvfg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 23, 2020 at 11:30:41AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> This change fixes the checkpatch warning described in this commit
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")
> 
> Standard integer promotion is already done and %hx and %hhx is useless
> so do not encourage the use of %hh[xudi] or %h[xudi].
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
