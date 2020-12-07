Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C302D1A33
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 21:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgLGUDx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 15:03:53 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:52736 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgLGUDw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Dec 2020 15:03:52 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce8a7e0000>; Tue, 08 Dec 2020 04:03:10 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 20:03:10 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 20:03:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZlhowEbM0GK+kARaKkuEKCzFnacgHuYo4yf5DR07RhY5bNthkcpCmeWLEOL+BSHyUEyj6zKwhpcqYqtI6Yn5oZ6XAu4mpE4G/Wx6CsX8A8Flf7MEmWu371j1hCfF6y5ecdrLOOEtK9Otrvme/kcI8mUzphs+2oh8gSQbGQlJGdqBlrS6fb5o6YY6C2ZVRU90loXlp4YT32OEoEUDkw6RVFAKS8C+IhjBz3GfBVseGdNADXo/qPZ1ffSrF7GbRcvWn3KUkuQtxY9QYhvqJdMe2cpitxWw0vf2Maaf6aAtn9Q8SP9AMP1artjXQSYP4r5CzbrDqDNUqrqJHvKHw0CTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XenRe9u0Ue7srIsXuEReI0BqXzZ12IX0Lc3skitEOC8=;
 b=KshxMLtf2JWP3o2mHc3ZJbiyVe9MDf01qcarNXLu7E02t3cqyMYu1yEJmIJFJKLAfUYN+semOv+36xBIdMbZn81bYe9JAmdJXGH5u0eh7J/dju05TAqDZ3aA+vOLFx4AuEB0MZiSI/NwsT3NXgqC42FQVFbUml8VMgfM27g6lwbBGZ0qj5KsXuUAt9eZgQw0ruxQEQ5cKy6OZrNTCyoGjEw42yQgADg1fztfpAp2vuAWuocF9o9KsJQlNDOSsnqUCqF5g/NYOAL9QL1A6tD9ixhU2tyPhNvehvUD4HEXAasT8pIy3JtB5/rSWT/gGOx+UwGvXvp/ISUHTlBS/5xTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Mon, 7 Dec
 2020 20:03:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 20:03:07 +0000
Date:   Mon, 7 Dec 2020 16:03:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Assign dev to DM MR
Message-ID: <20201207200306.GA1790347@nvidia.com>
References: <20201203190807.127189-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201203190807.127189-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:208:236::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:208:236::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Mon, 7 Dec 2020 20:03:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmMiw-007Vu2-3w; Mon, 07 Dec 2020 16:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607371390; bh=XenRe9u0Ue7srIsXuEReI0BqXzZ12IX0Lc3skitEOC8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=PFkMJc0L57qqZHwnlHVkmufSGaCia5+gVw4RPmH7E7hbUVtTEyYYIHgJpsZvAeeNa
         a6fbRwMF5kvO14KWrMMmXtrC2OXx/ear5vG32E++4uj+mubV5LxdQrFrmpFaXvxEVk
         ySiBPZbkJbqvzKITQQKqEX+EDN6U66reXrLfmaV/ULWxchk0Cfwb1uIZd3Exqbp8qa
         O6xMXAKpw90Ekmp7zxARF1sbLX/pcrLnAJwzua43gzQvkMokW5AjJcjrpooLksDSLW
         z5575uojMFStJvXBwOzlgF7vp8aiOEf1eHiGwyaygIMPS5JyZ5XoMqpyGoteI97bz5
         5xVZdR9wv4FqA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 03, 2020 at 09:08:07PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Currently, DM MR registration flow doesn't set the mlx5_ib_dev
> pointer and can cause NULL pointer dereference.
> Fix it by assign the IB device together with the other fields and
> remove unessecary reference of mlx5_ib_dev from mlx5_ib_mr.
> 
> Fixes: 6c29f57ea475 ("IB/mlx5: Device memory mr registration support")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h  |  6 +++-
>  drivers/infiniband/hw/mlx5/mr.c       | 17 ++++++------
>  drivers/infiniband/hw/mlx5/odp.c      | 40 ++++++++++++++-------------
>  drivers/infiniband/hw/mlx5/restrack.c |  2 +-
>  4 files changed, 35 insertions(+), 30 deletions(-)

This really should be backported, an unconditional user triggerable
null pointer deref is clearly cc: stable stuff. I've added that.

This has all kinds of conflicts with the current rc branch so I'm
putting it in for-next, someone will have to make the backport

Jason
