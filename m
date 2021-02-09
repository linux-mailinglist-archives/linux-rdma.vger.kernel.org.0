Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976AF3155D1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 19:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhBISXb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 13:23:31 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9930 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbhBISUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 13:20:35 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6022d0aa0001>; Tue, 09 Feb 2021 10:12:58 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 18:12:58 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 18:12:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EExrIqzZG935TVXSLuGdadMSXlRmL7jekgmzOuRblcsNQ8mzJXUDqBhSN9+wwCfjAgV5AsnHXgltLmT8AmSZ5ByJWce1qNUKPAqMeUh5SkrpXy1XnSHHqFow5pQITdiqgXGtyQqQlqcEoLgC4nzlIRB4oUBXXZ77Z/hYnAYI53Qqh3fstbv202cwzYcMKQlVZ2PJIEQR6vfpneNN4ofPHCHAi1l1hsgPWwxAk2lAq+W9Ft75vt9F9gR0Y5u/LK1mkd6354RMXeq7gJLaOZs5Vl4fSiyJNgFb8quU9GFhbvUN6qfEDGm3cah23/Y2k9n+2wkzu7U1qnAgynlVuuc1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SamNGl1wpDsmPaTVVx3VJh4qXcL04EtbzcUhrvhiow=;
 b=UVpBZlbMwDSec7HnayCYktrBy3juMW3ndwjfBJqK3njMzQarpuq/dlTN95YOVYE+X7pD2aKNA/JhM/WIROqX5LHv4REp1V8mYvFWixCKx9JZ560QipE268ibLq2Xq7W4hHcUQug3WwwUlXxVgySVrcYX+iaBo5iNm5RlgPmHT8gIp8DsdnDUJQNJORWXIwDw23jGw68rFSh7lD7cEvSz/J0ZrL+EloMdOtmUduYCpaov+j4vDYiDJ78t/loyGJqCcTD7HkUQ07z7ZxD8kELZldhJEQYZDcLB/Hy5phm9haiMOV1nX1x5qKEdk7+DUuo8tzkRYgPQpk2XmIgrPCLzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 9 Feb
 2021 18:12:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 18:12:56 +0000
Date:   Tue, 9 Feb 2021 14:12:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Support 400Gbps IB rate in mlx5
 driver
Message-ID: <20210209181254.GA1325568@nvidia.com>
References: <20210209130429.698237-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210209130429.698237-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 18:12:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9XVO-005Yqs-PT; Tue, 09 Feb 2021 14:12:54 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612894378; bh=4SamNGl1wpDsmPaTVVx3VJh4qXcL04EtbzcUhrvhiow=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=AiW+r+bZdbsD5FMXfVvqgElRVSYZeONPP1yx0O+ivOmbQhBHgMgMKKkqj718fITqq
         24vPcS0dde6SPfP4l3mDk14MCkis9austMQjII/I5QhcSWhu4VTA76s/R/4D6bxchp
         FBFcrZimC6KXl1sCKVy9Z+YAi7IxH6e3itZt6AiV4XeXcGxWMk8hejA++pOJ9A41mk
         Oc6GPKJCs7NsCWJYDIcd/UNLA8K3haXAaQdLEsXJVR4/Jv+PFeL0POUvQCC6EWLp/8
         vaxjfE6k4keuzva49N8lyUb49Fd18uj4w5GvA82oUR7vdD6pkT9bkhYPU1jQfA7rmV
         wa3nNmQ1rPk1w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 09, 2021 at 03:04:29PM +0200, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Support 400Gbps IB rate in mlx5 driver.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next, thanks

Jason
