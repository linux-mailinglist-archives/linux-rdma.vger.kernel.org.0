Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB80327F14B
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgI3S26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 14:28:58 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:57055 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgI3S26 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 14:28:58 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f74ce670001>; Thu, 01 Oct 2020 02:28:55 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 18:28:55 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 18:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRD3nfNTcCN6GaIXu0w5fhThAtSP1OTXLAgcApnMBBTXHFQSvMPFAnJ+FZ6Zwu6pdTHEu3R4MkSFqwkvYLuniU7bfsuubo1O/cnDVU3HY0Ol+OnBfpqjWIEuCatDxgesj7qHzZf6gquhS/SKAH5VcDEh7fG+8XIZftXD9JW/PxhUEAdFd94MdI884OM8Nb9TQjduIlGIKMJnV6b6FzxZcFeMlx6POFNYRZL6PqHLOQBDXJn0AeCsAK6OroKjUlwTAo/fSyP0DEtcWN44u0/csa2hjSH8TR3rlWxfg8QXB4Myo7uWdcbrT8fga9WykvUSGNGcPt0fB3JVuXypS6d93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opGtLUSmqMWhO7EmmGN6QYQbEaDO6Nlxpgf4x2zCoq0=;
 b=kap+8kR60pkX2Tzkzf+U/rapXu/k92TTMCRblByeH0nXiKRnPKyZvgwJ1ahe2YlomYR3Q4lwy1Oy6w7Wob2JurawN6/SeItNZzfeH+hSbY8u52LB0/v2mCAfV4DuanKKZSNckNgks+j+9hReYWEmxN4+luj10o166rV5gEABSdeN13gRYnGQWHycBoG9kDCLWqwQNWpTyG6KDlAXAnEaou1V9BXFeV338XZdeL7/5Dset+9Sc5P1OjoN6woU6Cp4eia2bWAGOyBQUa4UNu+hWqQQ8gzyv8alK7Bv73IPT6qSj7jncgpZ/cw3vCDEWylCoJKGrU6VmwbXESMta2k9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Wed, 30 Sep
 2020 18:28:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 18:28:52 +0000
Date:   Wed, 30 Sep 2020 15:28:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: Remove ucontext->closing
Message-ID: <20200930182851.GA1028301@nvidia.com>
References: <0-v1-df64ff042436+42-uctx_closing_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-df64ff042436+42-uctx_closing_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:208:120::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:208:120::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend Transport; Wed, 30 Sep 2020 18:28:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNgqR-004JWF-GO     for linux-rdma@vger.kernel.org; Wed, 30 Sep 2020 15:28:51 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601490535; bh=opGtLUSmqMWhO7EmmGN6QYQbEaDO6Nlxpgf4x2zCoq0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=quOA4XeP72JjrIujPnim9Uj4jMWzb5RvNz48GQNN+CtU1Zo8xTvoSsdGAx2wxwGu9
         +p6ZbQT5z7dfPPBLqfWq3NEkujlbvJGPXA3nt36tzFQJkwPp7VdXa1k7ck0gjM/hoA
         g/Gl+T0b+biWDCYCj8U+vwmjbNn4+nZccNkAuPdyiSlXWG9olMbOzvN+QO8a5Q8zFe
         Rv6WoRele8J0i2v4EtnGfqKPcwelrDWjTKg75kxRG2OTnfC3h/I5cL8rz4otMopEn9
         I09H6ivNNy1fb6qTAm4M94OyAzz5ROkub4fGgipMonblVcMQvITta0m2rbwELA3ik+
         oafHHi4pvng2Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 01:09:07PM -0300, Jason Gunthorpe wrote:
> Nothing reads this any more, and the reason for its existance has passed
> due to the deferred fput() scheme.
> 
> Fixes: 8ea1f989aa07 ("drivers/IB,usnic: reduce scope of mmap_sem")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 1 -
>  include/rdma/ib_verbs.h             | 6 ------
>  2 files changed, 7 deletions(-)

Applied to for-next

Jason
