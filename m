Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38C846AEB7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 00:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351375AbhLGAB3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 19:01:29 -0500
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:2624
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238201AbhLGAB3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 19:01:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcO/HeY+A759CP3PU8IN6ag8mGkKTOxDmzeGgnqJ1kVOX26oLEj5bmSTcrgt1wnjKH8JcK6JPJy1BsTZvDhdhc9VVuo4r7ALaLp0C/gQpv1FEe5hf+Mnclec57NqhxjA4tQvJPgIe4YiG+ffgmN9og32h+/ouM4Uxi+jMosXEGH2YCqMBVsfgVE2m3ZG5aCQd7ZqT4kGCO/oo1QbkDBrva4kxQnwSx8+6JQpGFvYk4wm3BqqMLVRlLiAxL59ZeniG89EB9dbI7WDiBk8VIL4Pm04DPsmd3MOCh4BXZxXKJC/UkkRob9dxG0Aplub1mbhAxTRoncTqaHO8YtooS6vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caYrs2TSXQ/4GZkEHdTk+p+v9ZpOgmRgQL1BxuHFbMQ=;
 b=Rz7zTH17yIFKdXSR/KqaIIcUB60nFGjacUrXXoEGOqfrjP1t1wYxAqknED37Ln3X64zo11qqzCJ3iKE5tNJhj+bk0UM7dttzjEZbrAwapddVc5tEyXLC+9wwjEB3WGX+KxAr5t1AIYJFk4vg1mHo/hB1DJ6oAh16tD+yF/hDGZOJm7ilrtex2p6paW5LRECW0LUH0dyq5sruXDHRXWgpBAPeB2pysjv1MLN+GbR4HauwkgC4EbZ2g32UTFVHqIMb/ideto2LnwcQLlhCsCMk4VGuP2F3s8nVai4910ge2yWDf5+udcfJCkQvae9ZdKDb/fjfZrwtOUlcD9qr1y8/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caYrs2TSXQ/4GZkEHdTk+p+v9ZpOgmRgQL1BxuHFbMQ=;
 b=YacHSbXq45WOH10Rb2OsyT5PxIUd0YO0wELD1g05nM/TZUGXknWjdR3ibpDe7EHEhaSrdqukJTWvwQfmDJb4Z6PM83tiAKIgEwjnDATQfMHh9xqEh8xkwHU/hj4/ptRTUevUiieAWonV6Z8Coq2lCLZnQ325WK5Ly9FhsDXUuyQPKD0f40aXrB7r5+vSTfaQwrh2jcoYjrAQCxuCnC/n17oKreP7QGxOKaicibRzyfQc9noIXFgtqiIOBvZNC6rxAWAUivHEGXWE7zYNWnkxShUOGSA6LLn1UCOZB7MieOeLpBTNYvepDO8cFOh9nJHQ4lZsx4gDxPrSQEIY6r8kHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Mon, 6 Dec
 2021 23:57:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:57:58 +0000
Date:   Mon, 6 Dec 2021 19:57:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Fix endianness warning
Message-ID: <20211206235757.GA2179112@nvidia.com>
References: <20211205204537.14184-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205204537.14184-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 23:57:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muNrp-0098to-1g; Mon, 06 Dec 2021 19:57:57 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99a58873-1195-4f09-bc4e-08d9b9143a70
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160FDBE080B33D38F9A2EC7C26D9@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cVb/n2rtlEMiIjMwJQhvNpq+TnTHryYWV4Cqvzfb7Wd32fleYuMpltRiHGLrzk3W//VrgTl30THBu2I4h1JRlP6o+SZZIL8kEy977XlbyH1KPykIKghCdZ/0oLFBJidT2WnclB/jEm+NQoNErpdk32gVSpjkoYjG6wbzayKq7PsDNarD+HoYRvk2g1qPz9T21GKzPZkL06PMZxiM7KLCLrxuvHiWzpaAN0FMyLFhdhu69NYO7caX+BZaGqMuo7A8g3aJszU0IOUm8HUxwkgj1sv+0bv+0+nUvmUd8CdPWUnuR05zv54zEjbpdTHP9sA0gVFReCMyu27EYp4GnOHnzwYtGc1fCBl8oG0UmKwc8vPMuj3NzMea6P5k18nhV4bX/yVkHcwTfkKDHrtcnAXS4oWqQZbRSudCKfZ1Wzdj7E8vY2WglixjgKoY5MY7sbPsaRhAqD4DLzEv0YJ4d4ymgcEeXnU+bJ8s153zWIF2073mPfd+SA6J22VoV/DACprz56UEOkFse4u0M/XmEI2Z0QeKcVAL0uOYkwOqqKQYK0MhNY0mSAZBti4aXCsuU8dAxkO/xAJze41Vkq1UCeArU52IhM98ThIQbdLogXYqmAdH364KogvotDFsybOq8Gm8tlrxASzsJZCmCpy0iuilQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(83380400001)(5660300002)(8676002)(9786002)(4326008)(8936002)(38100700002)(186003)(26005)(508600001)(9746002)(2616005)(86362001)(2906002)(33656002)(4744005)(54906003)(36756003)(66946007)(6916009)(66476007)(1076003)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYzBR3opjNdqyNHOidpAXk/aNLOExg1QoGpPtWgglB1XFnqiGygEkIjWNUc7?=
 =?us-ascii?Q?lpuc752UwRMrwc5jkA3wy724TLK2ZfwqNVGqTfvf971x/f0TuQFWmVjTKXyC?=
 =?us-ascii?Q?QIPo2zVRVi1qhFkfgNRJrgkyk6UaaBUD0NWrgBGBjrTQyjnvOyeHJVaj8UpK?=
 =?us-ascii?Q?kWwcqZH0YeiboBG5L7X7tUT7co9x7JcrGVcpzANZu7IYG0RkuXQNZMzQ9XAx?=
 =?us-ascii?Q?Qb67LKaALIrGeVj1iU09l8Ko2H8PV0AYGP3o5FOU2J0fWQnEkjUJmtU8JxJ/?=
 =?us-ascii?Q?V3/WnWLSp84al8x+LiZpdci0zw8NY5VWBdeBOk6/QAoixr8AYjBXwYNKbmfo?=
 =?us-ascii?Q?YydeYOTSD5guPD4dw6OllM85P2kfhg/0qF+gJr5iO06u5inuQIbGcsj0ToHy?=
 =?us-ascii?Q?iS/91SUA95CkUKWg42hfmHLHkGRe8PKAtZBIA2/ke50Rw31LTwpGt0+jn379?=
 =?us-ascii?Q?Ec7S6icsZwrpEO3p407VSXjOqID1gFT8c1yHc8e9eHfcr2A4oFKCuwS3/OTq?=
 =?us-ascii?Q?reGfzXs9BK/KwD5LJrabNM7fRzouB1yeRfjQvnEC3UuxCgKKP12M8zNXA63j?=
 =?us-ascii?Q?QZeVvg4nAQqsVoPJt7ezsEJ+Zudvx4WQSc8D4FPwSscZhswxLNb+qXKkVgNr?=
 =?us-ascii?Q?TiEkuFatbYb9nMYMUWkmIj0FOY2EClECetgEuW3KH00hA8gumVuHJjS8aGdn?=
 =?us-ascii?Q?BEKgArO4i/ECVNNXTHvHS2HDytj6wxbHBpIbD4Wwkq10xMhiCB/aJZbBG2mo?=
 =?us-ascii?Q?sf0zlJSvK8J1hS7wc5LMZSHhzOhP4Z8Rh4Hu8d2rJogu28SAWnfyiB3CCuXI?=
 =?us-ascii?Q?EhGs1wO26NgFQ7qiSJc0aNIc7HuFW7ZkbSEoBS1ZHJ33NVlNWfR4mwhimLAM?=
 =?us-ascii?Q?AX4vEPvLBtBIbMNGNs+uBxsks1J4qO9HpJCvXRDwb4ht0bSYtlp/uBweOJW9?=
 =?us-ascii?Q?mDmswrrgLvMfvQiK8YF7WGL4yBwpU23kuDnDzQFXuucIm/1aivsxvxTYqi2m?=
 =?us-ascii?Q?OjkGTMppN+WRUsf5rPMSze2bKZ4V9zskNdEl7Mbk59cGufsFwXoejHPLNysr?=
 =?us-ascii?Q?QhDq1JF/Ek68qLk6lJapGZSBhZj5Lhfl2DP7LrPEm0RZ5kW+316RyVdGaElk?=
 =?us-ascii?Q?0H/Uao9dq4eFOTgc5FHYwLaZNOYIli1Sh9K69r+62JYyUvq7TOVCbosizUWD?=
 =?us-ascii?Q?j8bipdU9t2E+tMx8TAfuoqmQvJMfSDfGODoJGhIi1oovOBpyz7Fo2iD3wXWg?=
 =?us-ascii?Q?w9AWNRqXk9RDGfvY1Rpqbp7vEHMR79kV+SHkD8BXdj6PiasqBKyPjsAHmkP6?=
 =?us-ascii?Q?SUdzgqlMmNsQd/E0QfMwR6PC1iEfiqtp4JH1VIxparhDDtjckJbj9oiIoFrM?=
 =?us-ascii?Q?Mm9P1j/813cwYphSosFcmizHZevloA2VQM7VUuIXV9sXkBd0lGeMAsIy12xw?=
 =?us-ascii?Q?KASFAqLt+bC4SE9ww+C5RJhGdwLhMXL2AiwZfzHxXV/2U144h5LI8XSvekur?=
 =?us-ascii?Q?+Pn/Llc7cwCApNinZDznCzODDnqjciD7Onb9WO7+RwgtjttK6/A5fZCFMKaI?=
 =?us-ascii?Q?hcnvtdVb4hVjHbZtCsE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a58873-1195-4f09-bc4e-08d9b9143a70
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:57:58.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2/8k+X462ruBH+UP4t2K5xPcjqzaxlWcqNqr0uAlMkXo8JeiyB4Y5ydXhs3mQg8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 05, 2021 at 10:45:37PM +0200, Kamal Heib wrote:
> Fix the following sparce warning:
> CHECK   ../drivers/infiniband/hw/bnxt_re/qplib_fp.c
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:1260:26: sparse: warning:
>  incorrect type in assignment (different base types)
> 
> Fixes: 0e938533d96d ("RDMA/bnxt_re: Remove dynamic pkey table")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
