Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCA290A4F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 19:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410799AbgJPRJz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 13:09:55 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7502 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409104AbgJPRJz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 13:09:55 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f89d3b60000>; Fri, 16 Oct 2020 10:09:10 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 17:09:54 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 17:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnjdnrShF7pJj+BDWbUmDLVCol5cXpdXbQDxp2XIFXGffvIFx3vl4bdeEpLyJcKmO7KV7AUKPp9+HPaCkRz2Xu0lAj64CEiutmKjy/wE1+EMldZPqXTQPD+6LGLRow9V6RdA9W3g3U7BVok6lB5dM61ij/5r48+4gsKFrYLC58o1Vww7ZYpqLcmRWq/+MAp/re6yMgg9SwZ1pM3vHZ8GtLjSeQEuqsmsGGLOEo7+abf/fofsIqI/FYbLYQ/MpFjeEA8d87tHydNw7Lr6ZqAk6bZ6glrwQimB7uG6EtDUhaQR02a+9y/6z7KIaGoHc4ZGPQbHYBr3rbbI8FwZWTM/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9lNEws0x/LkBo6G6AfoSC8Q2z1xFjqaxFOEO1S2Juc=;
 b=Y+/2ym2ML7zINcA7AD5BAFDQMIhKz9fIzIOw8cIHHBNT0KHS7tiIqzx3mNECYyByZO5L3AFDfhwqjJs18APqh77kiyEevIdt7W6o6I4hYLwV5AhoRVnHll9/zbM/dRe1nbN1N9hrx+WmEy253Ja3WjKiQ9Xt1KwHRzugvUh/HpRpdJjUmnh6ZPpOY4ZnFGgsTMw7gwy0LRM8zY/KFCGGja/vmObIoSo+/iBjKiZM1j36C0VqZv4UfH4FaXpvs58+6J0jLdsCt1+uxlMFUAeIho3BZ4J1CopLm4dBeKuY9Daak2SKwkr10gOxJ0NGH4Ye9ejPzKtzwaUX0O5lkW50Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 17:09:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 17:09:53 +0000
Date:   Fri, 16 Oct 2020 14:09:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc 3/3] RDMA/ucma: Fix use after free in destroy id
 flow
Message-ID: <20201016170951.GA162163@nvidia.com>
References: <20201012045600.418271-1-leon@kernel.org>
 <20201012045600.418271-4-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201012045600.418271-4-leon@kernel.org>
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Fri, 16 Oct 2020 17:09:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTTEl-000gDF-Uo; Fri, 16 Oct 2020 14:09:51 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602868150; bh=P9lNEws0x/LkBo6G6AfoSC8Q2z1xFjqaxFOEO1S2Juc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ebXRGn6bx+Jx5z/Tb9xrE0hKrpQUhJBEiHUiJQIm3taTNqP3u+srCPZ5pOShdu1wR
         fcPzJZZ4P6Kf5eEI7Wa9F0+VaaInJyo1F9ShPEcz8cbXQsUaSqfKGs/sOeF6xozSwS
         pRqQify2N5yItuUZhiZqnixsAsY/yT6JulKHbr8SlcDcbvxnvAxd5MI9BkGAUopa66
         ggU0SuEclImMr2E5DvB79PAGjBmNCw9tWB8ELQ0GQPD6mRkiYJqrO7MfgW+YpJqm6f
         cGsPAtFOxiUi5CZrTYXZ1qxDBOtYCqP33k+z/NKcI7L63g3TEJDdhTDfDH3RVZ4hNu
         IT/6nKQULs0kw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 07:56:00AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> ucma_free_ctx should call to __destroy_id on all the connection
> requests that have not been delivered to user space. Currently
> it calls on the context itself and cause to use after free.
> 
> Fixes the below trace:
> BUG: Unable to handle kernel data access on write at
> 0x5deadbeef0000108
> Faulting instruction address: 0xc0080000002428f4
> Oops: Kernel access of bad area, sig: 11 [#1]
> Call Trace:
> [c000000207f2b680] [c00800000024280c] .__destroy_id+0x28c/0x610 [rdma_ucm] (unreliable)
> [c000000207f2b750] [c0080000002429c4] .__destroy_id+0x444/0x610 [rdma_ucm]
> [c000000207f2b820] [c008000000242c24] .ucma_close+0x94/0xf0 [rdma_ucm]
> [c000000207f2b8c0] [c00000000046fbdc] .__fput+0xac/0x330
> [c000000207f2b960] [c00000000015d48c] .task_work_run+0xbc/0x110
> [c000000207f2b9f0] [c00000000012fb00] .do_exit+0x430/0xc50
> [c000000207f2bae0] [c0000000001303ec] .do_group_exit+0x5c/0xd0
> [c000000207f2bb70] [c000000000144a34] .get_signal+0x194/0xe30
> [c000000207f2bc60] [c00000000001f6b4] .do_notify_resume+0x124/0x470
> [c000000207f2bd60] [c000000000032484]
> .interrupt_exit_user_prepare+0x1b4/0x240
> [c000000207f2be20] [c000000000010034] interrupt_return+0x14/0x1c0
> Instruction dump:
> 7d094378 3906ffe8 4082ffa8 3f205dea 3f405dea e95d0120 e91d0118
> 6339dbee
> 635adbee e93f0888 7b3907c6 7b5a07c6 <f9480008> 6739f000 f90a0000
> 675af000
> ---[ end trace 9796e2b012b61b83 ]---
> 
> Fixes: a1d33b70dbbc ("RDMA/ucma: Rework how new connections are passed through event delivery")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/ucma.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Don't word wrap oops messages

Applied to for-next 

Thanks,
Jason
