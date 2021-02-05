Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF7310EFF
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 18:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhBEQBg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 11:01:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10085 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhBEP7C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 10:59:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d83190000>; Fri, 05 Feb 2021 09:40:41 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 17:40:41 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 17:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTcY7pgQcXfkxqyFqzuj3LbbNuGZedoQ/gMqfmEtoW3e5vlcUw5qVplrFDRI1jKMXjJ3dKD1cuJK72j8hyGkCLHA4MBDxX6rzdm1WiSICtM0RVaftYB6AJSm8EQU+0y/oeESqlZYqz4p5hVEqcWjTjp8A+cfypDONbbPLXEg3eUvIpoS4fkLXwV2f2GWoDBZpx3wxPysy6D1/0RMGUsjlKGwBTSLb1AHvb8CtllJOOHSVYPSh+Oo56yaBgjYMwvCmpzctEuHURjl9jwz7rt5D8Tms8pF4uN4scUNa1bSGz399Mkr6AvO6j7Hp+1ExhzJmBU/KotG//i24ONFzd1JHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQXzqVh431bhN62qwR3emcJcOWADRIcgbzzoPu8gfd4=;
 b=dVsPDbw+rzOuLn5sRuLC7B9vGMwi9wAgclYN+gm2W3MH2XOfAmbXFO8NdTDg+Tgbp6GF9ApZC+aM58BFGQDH6s6wH2nu6preBu7rW6NslrB7k5BxN0V7n7ORWJ6yuAoatetY8dfAYbFsTsX85IgsJKa3NTb+rOqqbaFgRwKckfDxxpEC20ZHDPjYhLXR4bWKBesu/XimEsokuopgelmA6EnsIKaFSx1YOd1kXulo4H/Elm+0kCBSEEkwdwMG62Dji7/NquR7bwkcjroc8Ns9Lw01wWmAxASqxG/H0d8EreR7rDqOka/a5WHLeappOoSGMLBKPklaOxm+mpi6jrTyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 5 Feb
 2021 17:40:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 17:40:39 +0000
Date:   Fri, 5 Feb 2021 13:40:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH rdma-next v1 0/5] Various cleanups
Message-ID: <20210205174038.GA954997@nvidia.com>
References: <20210203130133.4057329-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210203130133.4057329-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:91::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:91::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Fri, 5 Feb 2021 17:40:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l855y-0040Ry-6m; Fri, 05 Feb 2021 13:40:38 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612546841; bh=EQXzqVh431bhN62qwR3emcJcOWADRIcgbzzoPu8gfd4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=B0xbi6dBVzsqw+xi/JoCp749SCtPJaZC+yWJhGDmkCMbp9sEpQxTqShCZtAv9lQ3+
         U34PsbnyTDR+doLzvw5mIeI+lIp5SYNRv2UP6aNADoJNzx2tpIGsnkXkGWD+QJHM2K
         ekiHgVqicnVv9UHbYcwLh5AtxdKM+wMRyns8YStQta+9YP/jWzRW5ri/1pm/l5ycuD
         NfahKyMxfr5Rr96Lkd8ZgsvE8devXOxHMlhrVMLSf6uUKGGXTxfd4lcPen5d/9N/e+
         zGVlcXXCKLMkDHSdrqWiAizDl/syWH/WJfUG4WtXvQMxg+0c0IVD0LeEitgj0SYCbq
         4wGZtGoa9pK5g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 03, 2021 at 03:01:28PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Rebase
> v0: https://lore.kernel.org/linux-rdma/20210127150010.1876121-1-leon@kernel.org
> 
> Parav Pandit (5):
>   IB/mlx5: Move mlx5_port_caps from mlx5_core_dev to mlx5_ib_dev
>   IB/mlx5: Avoid calling query device for reading pkey table length
>   IB/mlx5: Improve query port for representor port
>   RDMA/core: Introduce and use API to read port immutable data
>   IB/mlx5: Use rdma_for_each_port for port iteration

Applied to for-next, thanks

Jason
