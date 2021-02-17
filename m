Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F142831DACD
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Feb 2021 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhBQNjH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Feb 2021 08:39:07 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19968 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhBQNiw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Feb 2021 08:38:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602d1c410004>; Wed, 17 Feb 2021 05:38:09 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Feb
 2021 13:38:04 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 17 Feb 2021 13:38:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv6T6CTYZ4u9swHHhgA8GC2TQKhvEMCUA58/gtcLirBYRY2R0rHvqj8mnrYC78eRew7RgNuas8dwhpF2BWjezN4AiNjuIPC69eA/nMjL37hr2Ge3aiQr4kkdxpTIMfAi3dSAMH9fNT2dKmTOQgvCRSs/dTY0g4LCdInGiTgD5ZyFeuJE4aMpixfS+yLB1vIuDl3BcNYg6ZAFQyVx6oQ/t/hBSb5dzZTkbQrO/D/hv8yPjjl3KFwLhLEWYoHsT0HKhEZQK+ubT+17HHjI3taaTkqa9Me4UkV7Y3FAH3Wdg5F7oAYrbcdkjDwAG2FaVbjUWW0SUBarEAvmurUOWu6RtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvo6osK4XJlcrRRmO9CrUpM0u0cXqWGyqhpVNJYHQYg=;
 b=DLqFXN3sA44jEy4E/0UUrO7pdm0aYCMKt5N5krJOipBEQ/xLP93iLsmKJ70NkrkLFt1FLeAuLdjhg/1XcyB/YgfObAtBt7yO0YkmpR1zZ8NlB1IHjf6ofQIYeHEOm9lil813cUA8vw3fl6DOJvM7IFyuDtckH3axsx/tLPhw/Yi0cjtiX5QxfsrJeP7bgppdoety0+B1pa9EcwDzJdO5BeAHjGcskDSOvxNjTAvxUhbLDf1pImjEncLtTfpeyupNDVYblmPXcAZUpjFfF8xjIEPTmKr0B3kVXsBQj6bU2TSkpJNeTBw3X0q4t3ZGnzCMACZGh7eHVxHzv2FpjxphIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Wed, 17 Feb
 2021 13:38:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.041; Wed, 17 Feb 2021
 13:38:03 +0000
Date:   Wed, 17 Feb 2021 09:38:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>, <bvanassche@acm.org>,
        <leon@kernel.org>, <dledford@redhat.com>,
        <danil.kipnis@cloud.ionos.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: Suppress warnings passing zero to
 'PTR_ERR'
Message-ID: <20210217133802.GA2296927@nvidia.com>
References: <20210216143807.65923-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210216143807.65923-1-jinpu.wang@cloud.ionos.com>
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:208:239::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 13:38:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lCN1m-009dY2-9W; Wed, 17 Feb 2021 09:38:02 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613569089; bh=Jvo6osK4XJlcrRRmO9CrUpM0u0cXqWGyqhpVNJYHQYg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=SBBgEMkPiA6Oc1pYgWdWolavLCGK0SZduohS0drn41Ohk83Va/WtTkIIluu1XZ4HT
         4upHxhc/MgrS0WseFwkn2AVnyopgkvP9g0tf4gCkHkagTJZ9hvXHVkPPuJJ8NXb8N0
         o6/ws//epQoBoGCevzeyUqX6L2rrE+oHcuVA+QHIWCtfIr3S6k8dpO6TDozwv8cuhR
         +Czf0iZQXa+sGgoSN8apNwZxB0NkxAuSoHOYOdulwYu3r4IzTdDJNDCck9vpBhRQNt
         prAMEj4uiDojuSJNX5SOBqZ6h3io6hcsKjPN3R6HjFRyQQ7A/mmPpeDIWpDGi94Rtx
         eghE7smntt4ZQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 16, 2021 at 03:38:07PM +0100, Jack Wang wrote:
> smatch warnings:
> drivers/infiniband/ulp/rtrs/rtrs-srv.c:1805 rtrs_rdma_connect() warn: passing zero to 'PTR_ERR'
> 
> Smatch seems confused by the refcount_read condition, the solution is
> protect move the list_add down after full initilization of rtrs_srv.
> To avoid holding the srv_mutex too long, only hold it during
> the list operation as suggested by Leon.
> 
> Fixes: f0751419d3a1 ("RDMA/rtrs: Only allow addition of path to an already established session")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

Applied to for-next, thanks

Jason
