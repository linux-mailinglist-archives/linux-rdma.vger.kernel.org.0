Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED346C21F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbhLGRyb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 12:54:31 -0500
Received: from mail-mw2nam08on2053.outbound.protection.outlook.com ([40.107.101.53]:36960
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229703AbhLGRya (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 12:54:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCsziXHdxg+LAaCExcuF0p9SJ0HsppaqVIr0KTkrr3zjsPMoWuwhAeY3fVrnzZs7kbrbAnOhYj9Tmh7KlZmVMdFMGwehaeIGatzFMslLc4Sg0hsxuWH3E9KXnqQ85qML7d/VGwW7yjwfgTAx5KhrIVZtWIgSAknX+YDfywGut7vNsQNDflHtbOMSFlEjsmhcNJwPrz195b19cJ0okE11lHiqIeLGrSwFnUTnrSlcG98Rs1GCaboaX5uFRDyBlwszDwTXplJgKbytHX0yH/+AT7KqEcf7rOwJ4dylYNJCOkzc9bxuH+0yYEciWkKO6k0lPGPQ5pcoR3ZJyAUsl292Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yio9TdQo+eKepj01p7atD5CdYwllQ36oufRIrxb6V8s=;
 b=FKBRRlG+fyXdHjhaCXawIVlcxgj+pY+PP6WbYpcSpGz+r3q5kuLI+L8ZydGfvyosKSe8d6bGszMkQgxMhSEoKyYWvYJF5rYj7iYGEqaPcrP7A3w47WSL/6ShXvO/fyl2wXxr3ILF12ZF2QJ2dSuGGno0nv7Rqz85dMOKz9UPNyghuKAVzZSz/89uEdeSsMxCVI4iat6mgrl52kXTdM61cqkgxOZecoOOfcmALIlPX/KR8X7jCJWakC3PZKlGiThYI1vxjNXdY5/6qIFv/v7FGsGTl9rKQ+Cyg3NIYcI4nEAeFy42TM09vapr2C3hd3ImFkIhZGczO9/7dVuHX4t0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yio9TdQo+eKepj01p7atD5CdYwllQ36oufRIrxb6V8s=;
 b=DXP5naWZzoyobJE3yDVC38NX2rGQd1kDYblIAXvyTo3hXpJe0nx8R5WIL1LIh5D7fokidK3rAVbRdSLMC7LMWS3J/QiZ3A+X0WsByrcKVLDv74mVc6eT9rh0UrFmH+TVIzMg8SrW/eAHMbqXBcodB6wbzg8xWkV6dsCibqyKuPxjwggHeFTXgQwbpueJiA6g2uFT32ZJnXH0quUvmH56JtYzAWE8y3+Sw9i0fwUhCJ7NXrlJIMOb/yrZ0fwaosj8YacrJE7ZQj+kJfahsNu2p6EmvvXfUIig/st7J8Zwo52ewb07rmrLIb0FVy/UOcxLO+k0j8MWobClt66OiOJOqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 17:50:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 17:50:57 +0000
Date:   Tue, 7 Dec 2021 13:50:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com,
        christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH for-rc] RDMA/irdma: Fix a user-after-free in add_pble_prm
Message-ID: <20211207175056.GA70682@nvidia.com>
References: <20211207152135.2192-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207152135.2192-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: MN2PR01CA0021.prod.exchangelabs.com (2603:10b6:208:10c::34)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR01CA0021.prod.exchangelabs.com (2603:10b6:208:10c::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 17:50:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muecC-000IOo-3Y; Tue, 07 Dec 2021 13:50:56 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30e7b22c-db7b-4843-8956-08d9b9aa1f7e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128F58DECF0E34331AE4091C26E9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pi6MLsn7oErEDbzldoLxiGKv6VXqwrGixe1fN08yCC9cySBtr+qDknEYDspuZvQdRrazUHVbj5Ip+hEm/CrIuz8aqtM0WTHb6yUg+moBQSyP5eVrCjqxXgY/yZSvcFv+s+9MhOGR4aKC6KUmdhBULWd94Rx4GvmkHp/azFWC9oCJ9u7lNroaUWZNPmSuxGr62/F7vhw43wjoIfykaDmjVS6uhVR60bnbXRl7adqIb+eOCeSMRRKwq8BanwrZj8TvNfJ0vH7s8DWMXqgodmNgSjTlHBLdJj/kNhT0+Opd6zvQTw1aM+M+ZZVgnbpAhLrGZCZCiw2ZgtIIcU/B9L4uf0jTHDaGnVsNvRQ3mch8CvHSIC7P8fjemFRNdx+tD3kUGgdM+6awfUBGPNzhxLmC+/p+4rcFFOtPa/fWU56Oqnn23KLl7wN9O38zpf6Ol9k7w+yr9vFNDif5urB0k+sAYaV4x2gW12bpr5q7b+lUQ1FMFuITIEJhZaIUQ15e5gRQqUyl3pr4CVU8rBFOa3KOUPS9i0lK4BpM1MPdAbb/D2Sfju/YlemQGQBBQIkst30rryPe/voRFMHu5kfgSO6EplMoN0OC05Tgt1SUmB3TFzzINPwMZy+EXeH+Nwve0ZjP/H0SdHmo4UiHRL4H8AhReg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(186003)(26005)(6916009)(8676002)(9746002)(36756003)(66946007)(66476007)(4326008)(9786002)(83380400001)(426003)(2906002)(2616005)(508600001)(33656002)(316002)(4744005)(5660300002)(8936002)(1076003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HS2BgPJZMTZNgmwuRZPCMNlvx9dxqXjVmk2bS8VXsZ2VPbsAuXEimb4jqbby?=
 =?us-ascii?Q?QSRa3IfwRUArSY+5p2g4JgHZAIjZor00r5TUdNyqvVRHBDvIk1qI9H/Lzojb?=
 =?us-ascii?Q?gZ7kXfkLcDdwRZByjZm/OFJB7T3U2KAplQ2NbBQ1791emSEdC7DDhZNjkPi2?=
 =?us-ascii?Q?RpxWNhZxROkXZIVM9oHSDylarZzqtw0DNstV649yR9AOjmT11tBM2VLwOZVq?=
 =?us-ascii?Q?KDiDiZPahkv54TBrAYFSjjzqrGNdv0gJyvmVEfXLj92vK+uw0EiWULj56NtW?=
 =?us-ascii?Q?zXxF3/timJ3iImljfOFsIBruNsa2HUGZS5VI+39/cBg9JjlJmlP6GR8Oppuh?=
 =?us-ascii?Q?aId+lg81sef00SlQs13+/jx/UJN409Tdx5kCmNJ/+nNl61KESt4INxl9duhZ?=
 =?us-ascii?Q?5vnRYVqIGD6Ps22kryHvd1wawWXL0xOBWhEtQrm9TzCUA6MpYVqdPd1ceg/r?=
 =?us-ascii?Q?HO+AHSIJMJ+g1v9C2wtPGUa+SQ6mhU1F7hzRWUuuHMplVMB1na+RkVxXCNw8?=
 =?us-ascii?Q?R/FUtezG8KGsrH83pS8T4Gj2bLQ9TtxCJkfAp5dKKfUURQOBMxJJhWGEM43Q?=
 =?us-ascii?Q?Kahbqdj7RID47ousksYXl1nnU7lqDqctLM/xxjz4JwN4lFUcmOlyLI9AIjUp?=
 =?us-ascii?Q?46odrnufUa/A+7C0H3N+mD7CfJq1V0DLYLBUR2exyGHtKaFTGbl3JX7YZXQK?=
 =?us-ascii?Q?nECIYC3MjjVyoduhonb0AG+q3kmCbAFplmv3BzgIfTcwGRMzBAX+g2wy9d5V?=
 =?us-ascii?Q?hQC0RzF1T7TY7ieiDop+2DWXjPvItGLIH9oZDeGoPDwSty3xeYXZ3Io2s4CC?=
 =?us-ascii?Q?V4RICccgKi5zi8oW07Kf05TuLmO/wOJ9WcbwtZfBnJQDY07pw1BLDVuwRj75?=
 =?us-ascii?Q?Wwyibw3YoWdlS5c3/Dib0D6q3lEszAWSehcND64V+6l+kTcD92XooXiPfsyY?=
 =?us-ascii?Q?0ekMlEHFnCeXzL0+OuR+NZxRTsW8hZHKWu7uNxV3oyoDLpFCr7EZHq3cA7s9?=
 =?us-ascii?Q?tax0lv1fTGxFthNMKa75VhEYeB8bRkSzq1f80YFxV6bHPLAYjz+M1uz56ibp?=
 =?us-ascii?Q?8JW9cCQLcaGPs9kjqjJVcNS+vbi5gpTC7hqAJLpU+o/dflySb+AMBmV4FdBw?=
 =?us-ascii?Q?uoVVsNg8izl2PXAOCReYk3R3lPi+O/Fdcm3gKyGlzzO1gbcakJfbsar+QFyH?=
 =?us-ascii?Q?2ciBpHPM0iaPBC/qxxJG6AyhhOnRh4Uiu92nuPZ7AmXAp6c7IHab+kRCYQNc?=
 =?us-ascii?Q?MuV1kUFMpBIV1ut5l3c4dHADcaz6WtcYzSjZNp4yAOUbH5dzQfP6qocBKtLo?=
 =?us-ascii?Q?qOrpA5tTJt953/qHoZzZtkJExM3CNFWXHblblQk+vqTXN7RorapE9l7TRSzM?=
 =?us-ascii?Q?59JArJ1tST5trGlpvziLXoFJmGv9pG7k/kEtkkaixSSxEB41uDbQXVYIqFDi?=
 =?us-ascii?Q?3w+8d7aHhzg+LFKGeg0YgHtBHKgbEeCFDPVNxzksq8mMXuLkcWJMN+6ePWvx?=
 =?us-ascii?Q?7v1mQBfBCwZjcwgS5mcpYKIqi2R+RoSneLDoTprCtLYdwXmn+CiF1dGczD4X?=
 =?us-ascii?Q?dWBNofdzmZV0jquV1GI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e7b22c-db7b-4843-8956-08d9b9aa1f7e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 17:50:57.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdNfT3wzAaXzUTuW5tpe7ZdD+5JJQ1tgFpzMLqkN7fUxzcIwysZkyb3JgHXPr97l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 09:21:36AM -0600, Shiraz Saleem wrote:
> When irdma_hmc_sd_one fails, 'chunk' is freed while its still on the PBLE
> info list.
> 
> Add the chunk entry to the PBLE info list only after successful setting of
> the SD in irdma_hmc_sd_one.
> 
> Fixes: e8c4dbc2fcac ("RDMA/irdma: Add PBLE resource manager")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/pble.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
