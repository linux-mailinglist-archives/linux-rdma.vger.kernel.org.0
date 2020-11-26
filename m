Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAC2C5CBE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 20:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgKZT5U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 14:57:20 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:52916 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgKZT5U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Nov 2020 14:57:20 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc0089f0000>; Fri, 27 Nov 2020 03:57:19 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 19:57:19 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 19:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVbtna4D1U5BYYQfgteYrZTgp5t4lY45plqs5BNaaKnzZsZ+CPZj3jdwV4oZ686WopSzDgFR+RnRQl00PR5HjEjB48Kjm0x3Wnw8puxikRFheN87CJItwuG5qNTsSbqW6RZgq9v4oRpYxUh7K5oy6geNDd2LLC4FuFxWedZXa1u9vpvnuDKLM8KXO8vv9xAdQbEiW/3a4ljh6A52mQSGP4qOTyiwLOaTKBHP79/tPgDbd6fqCoQAehEeK2pfJ+WwuZNSJvIwoRQcHx3DpWV0kxwXTTiQXpYiqufPpjWHdP+o5C4Wub2CzIMVIZ4by4dv3DeNKv7Y4YPcePMvtqtiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdeRlPJ6upzBM8iFLGlHFFyI5fhZUFOc4tpvXwX0Lrc=;
 b=ka/b4RsEpU49Pe1ExrApZV/1hUPBjFR5BIWl9pq1y2qPL81j+YKVQ0wVqo9fE2bucMhXEaUbYMJ4SEuZP+RhyUbE/5Dcq6GwmqgAvLoy/6ncdRBSxJqC4eMNWH5xdoH3bKAch+JC/t2h1ch9sJSAfvWV2KjIbYMOpXrinvJDuHOhhy5BZ5AMxsfVYNRgELwm9YQgRU3X/7bHcGmMYKXxGp4UFX49tfgaoWHTJyuqDpfpLgsbZlz9u0rrNm1q0PmC+dSTNAx3eB96T3Ax5Fga5RYdkcdg07PRmfprHfxupkFKlzC+TlTgLcKibh7yGmiXtYx4yUzr7Ss5fSTxdATRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 19:57:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 19:57:17 +0000
Date:   Thu, 26 Nov 2020 15:57:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH] RDMA/mlx5: Check for ERR_PTR from uverbs_zalloc()
Message-ID: <20201126195715.GA557094@nvidia.com>
References: <0-v1-4d05ccc1c223+173-devx_err_ptr_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-4d05ccc1c223+173-devx_err_ptr_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:2d::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:2d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 19:57:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiNOF-002KwB-5V; Thu, 26 Nov 2020 15:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606420639; bh=PdeRlPJ6upzBM8iFLGlHFFyI5fhZUFOc4tpvXwX0Lrc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rzI4R6XoUghkMZN7nwp3t2CAxToh0XfH30LOhRiEDnLnO5hdck2ye33xZItRNHoSE
         /9exYBSYF7kjHzjMGacNU8tOKNUTzJ0d85RBV1yofgIFetRo7bT7DK2gl5NqaqUMPD
         NgnWh9uQUjlaO23tKQUZHu7wgYH4Lsd7VW3xiA6i4oyK+9vUK/nSbQIx0EVCfkP/+i
         96JIiU5WFkB8bcni2AMyXG6XmDJFA4tVL4D795FyP+V4CDtNabAV/vDu/KYYSYPLyl
         /5U5K2Vbxt2HJNMEhELnU9VhLYTZzI6Qq0iWkEMc/8ET4CT99k3OB+lb8KhhCpVAoM
         NFeKGNPYNnitQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 07:34:33PM -0400, Jason Gunthorpe wrote:
> The return code from uverbs_zalloc() was wrongly checked, it is ERR_PTR
> not NULL like other allocators:
> 
> drivers/infiniband/hw/mlx5/devx.c:2110 devx_umem_reg_cmd_alloc() warn: passing zero to 'PTR_ERR'
> 
> Fixes: 878f7b31c3a7 ("RDMA/mlx5: Use ib_umem_find_best_pgsz() for devx")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Jason
