Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB42D68A2
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbgLJU0o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 15:26:44 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13224 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390094AbgLJU0o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 15:26:44 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd2845b0001>; Thu, 10 Dec 2020 12:26:03 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Dec
 2020 20:26:03 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Dec 2020 20:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l28X6CLQeb8U8QZ2YQuQO0adSg1HM1eKvZv80/3rTHCwTX7/npaVox27y5W3IOmoHj6XESyWvHJV3VHR+t11v4T+aek1mswaF3ycQz2WyxnpeEJOGguAwhUBqDXAIglGLtKI7EiT/6WwVHcP2TbLCpLp4C8sECeS/mbrPHBhgSyeuaFpNGJkS8vd1zesTWDDLkdw8nFHN9306QO7u7JTJeS5fgPzSBV9YKtp0/crnjDzJUtGMmhwSDyMf5axqRNovYODfBXg+9MH++1iRR/+OfGLAYtq/1RXHxP3cdc9sFqqMFoTSDkOlHR27Zbc0I8P3T9CN4rxCnvopgetbYeQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i2yP9qeGjcGRaIqa6mtckBZ5DgX4jfGJr+IWmZ5HYk=;
 b=MV0Ojs+DzEJn/TDtalnf93adg+ZJ5RV3rDfnyikPVeJi16Tbp76w3Icq7YR1fQZLARlB4um6isT1I+V/Ud3ukaT6qiz2Cu6txb7m0hwAvfuKu/1pGKpWp6sMtMCN2DENxaQEUMxrxJJxyAyzUPDeohI3dH3/RkFFcqVMbVXbj95BEQWGvDJsAs9M4/yWQLJSqjW7S8R1jtIS3kgbiQgsIRq78fw+T6YpZ7oFGRWVMtN8YV8ooR2gphGGgz0mVR41oYazbQoEwo0Y08VOjI8vP27ZTsPVjXYytOvq/7YQBXdVHkW9AhOunjEq4unosEekS3gYI1JBsNyqIVPBxPYZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 20:26:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 20:26:01 +0000
Date:   Thu, 10 Dec 2020 16:26:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/3] Various fixes collected over time
Message-ID: <20201210202600.GA2136131@nvidia.com>
References: <20201208073545.9723-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201208073545.9723-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:208:134::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:208:134::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 20:26:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knSVk-008xiL-47; Thu, 10 Dec 2020 16:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607631963; bh=+i2yP9qeGjcGRaIqa6mtckBZ5DgX4jfGJr+IWmZ5HYk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=kPpXD93BV/D0ZwTewPFswUoC4yd1xablWclR6aAPgfE7g0C1G6VTdgJfufFv/h0Qz
         z1hrWP3ZZ9kRwZp+9IuGrmMd1Idxd8TtZvHoZziR6RHzba/hv3oVfmoyoeE6YSfBAW
         2+xQEaACB/vzZqbv0awWO7YqUhlIOCiLK7RwjaVuWnmxAdFtCBxxX7UBGqUwv/aCBR
         LBYLRjYxjcTwlYr+cGTGC0JQu1x2VaiVS8ZayffNgnW2gmL5oNpV8Kj9lKGWjVCfoO
         uKieqKbxqmZUbcsZUvDf1wTUEGT7gjh1ievAz9/ZLzXVYbCCndIaeWESHbsW5+cSw0
         6RRjyKCPu2s+w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 08, 2020 at 09:35:42AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This is set of various and unrelated fixes that we collected over time.
> 
> Thanks
> 
> Avihai Horon (1):
>   RDMA/uverbs: Fix incorrect variable type
> 
> Jack Morgenstein (2):
>   RDMA/core: Clean up cq pool mechanism
>   RDMA/core: Do not indicate device ready when device enablement fails
> 
>  drivers/infiniband/core/core_priv.h              |  3 +--
>  drivers/infiniband/core/cq.c                     | 12 ++----------
>  drivers/infiniband/core/device.c                 | 16 ++++++++++------
>  .../infiniband/core/uverbs_std_types_device.c    | 14 +++++---------
>  include/rdma/uverbs_ioctl.h                      | 10 ++++++++++
>  5 files changed, 28 insertions(+), 27 deletions(-)

Applied to for-next, thanks

Jason
