Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C893F1BB2
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhHSOhq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 10:37:46 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:25312
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238547AbhHSOhp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 10:37:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl1yr59nRRb/hmVbTt73ztfuuTeBfMZOb8GzbkzW6U9G9lfEb7EXPRPXQdNrI90/IPc4WPJrMkCgKirb5BvYgDm2MJGtlrRtk2jCPXGS3TDDcqbyw4WaE+I/yzOiKK19zoIQecqN5tkl6ESI433D/E5G2wXsSsMCrrJxp3sZxvGJIDrxLr924h3D66lbzG7srBKIGga9bprosevya8GkdfChzKea1oW9rtwMO+XynUClxXqHK4eDU1hOAXoW46puEEMdTQIORM2lhet1f63VM6fP9/LBlTTPv8ZBHdo7OjtMhljpYZ485LXxdl3qtZ4EaPyePcH1kcK894cdXJOaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M220LSwCyviKfrSgEXHgLaLZfpJNIqqCsfjZNgedj4=;
 b=ObjITrgoIUrSDoFg6arTP1UeSSo3rk46FVY79z6QR7PGwv2cNPnk8illEbLR6IUPiZJYgF/HfBYZ/wPqc9cFKE975/Snh6nzRfZWeixrjpg29gDe0Qx8QrLwPPhh2rlPBYPqbWbWFI2WMmFYQnAnB1wMe2KlFgNCwcJbXoFNWxJE84TZXHMpQYUcjeq04JAHIs/Tt/CW4eoK0DIQ05xPt+mVRc5Nz6c8LhLZvgKAlrMcGyO3162LszUM8fcHbc90iD1DGwmpOojYM1LWhA7eX/uqgnJ6wz8vrDxJmH6IujIpfSAbqAma94qC4T0L09545AX6k0nNshxLi4T1fz7NwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M220LSwCyviKfrSgEXHgLaLZfpJNIqqCsfjZNgedj4=;
 b=ZozThho1c6GADNEyVLXEVrJnEarwM7rwhMym+bw5O7p0bYTSs5EgS5C8Q2Cztez1tOdUJ01Q8cRmz/D2TnfDh3aOTcGx5H9ZR0bjXbT0qBqfmF2kksXnzycBwyL6AUGIwiCeIzGEOtBii7bkcY3/yzvfNvql2uBbf/ODyzmovc3yVvVe6SlEMnhgZYVCFm6s+4bSk2uapH1dlD5j6tVVadw8uOTj+JzBgO29Q1c83+yX3QgHeD96R1zEOo4D1u4P3fbQJ1SExDHO+/bF9LsLYASLzNIY64vUyQCgfrdpm3yb2Ed3/9HqjHAGX+SB0iCbQ2nn2zMsWSpm2/Ky8gP5zg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 14:37:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 14:37:08 +0000
Date:   Thu, 19 Aug 2021 11:37:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tuo Li <islituo@gmail.com>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH v3] IB/hfi1: Fix possible null-pointer dereference in
 _extend_sdma_tx_descs()
Message-ID: <20210819143704.GA330763@nvidia.com>
References: <20210806133029.194964-1-islituo@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806133029.194964-1-islituo@gmail.com>
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18 via Frontend Transport; Thu, 19 Aug 2021 14:37:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGjAG-001O3h-FQ; Thu, 19 Aug 2021 11:37:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4efd9780-2bca-4c72-c4e1-08d9631ed271
X-MS-TrafficTypeDiagnostic: BL0PR12MB5506:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55060DBC74C59585E76AEFCBC2C09@BL0PR12MB5506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cupM4AHjXdGnR9ckfVpf8LnpVUUdu+y9+5r2e1+9TyPGdXelHbp4LvI+EqUyCj/qGSA88Yngkqr93ay3zomRGyZi7OiwbcO2s9nTxZ8S4pup5A5RgZ6LtCPcBMTmneZyhbGwVjgD2aqoOYoQDZpVootgx3mVDZU8jM9ONv/+jSHmeA2SbtL2o+Qr+7eqd1p/yaGFozoVVRq4Uw1/JT9LcVB9uuqR6Lkohe4kK/HUg+Uf/3ujTXJ0uRGNrWSmiDEgWHjlumk7rl8puDi7gc0hXeboa9UWCcmd+JhauE+Vsdjrto65yPnRg5ncM4r4iD14dnYwtRQ5ofkJAygnthOk7NHTYOaNOthtJdfRAAVrMxMbHyuHaYRc7y2vk82cqkVRjGQ+C/kBddMXvmADP6cBXJykr/O0Yr4DWaelSeaCsQEWvYlbV+bVIB/kKTdN4q1v3xRwcsaC6EHZumCwNiYaHUjf2b+OTcco5xcXQFhLPQJuJnK/3+WyQdty7JmW1A2K2Flg1T8P2imDB3pWacON1nF1QHvRTga4u+sFrTzb2geOqyhcSBCtfs7+z3rrzyK6Xc6SIvZnKfVyGIlsXNpbZvHTgAPm51iAxGDdt/W0Y/hp286x5ZO9eOQ6eRagZfaZ8YebiCfjYU9W1+krOgsbOe7tZDehxffLnJNAHilWepk2/6CuFrIFWGgnWlvZL+BE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(508600001)(8936002)(426003)(26005)(2616005)(8676002)(186003)(66476007)(66556008)(2906002)(33656002)(83380400001)(36756003)(66946007)(9746002)(9786002)(5660300002)(316002)(86362001)(38100700002)(1076003)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHCCMKursmOESKqMEmWF34u7I6thdyzTPEW9XSzADS55/5WxNUBH6dFJ/NOi?=
 =?us-ascii?Q?bcA7yPy1/1bUx+FNzEn8tVXXcHJthJL7T2plh9zmOOz8qV4L+n57o76Hu76Y?=
 =?us-ascii?Q?839QczD8wPnbVQW1QTaDIIpxPDQ56ZeTPYVZuzBehC/Bo5V8Qx3QuShBfXG4?=
 =?us-ascii?Q?CdPbdPYLo5fcaAIsd2JHz4Aj2Yl4eIfqYpZIAbprVOSpGjbrbkXSZqliaL8L?=
 =?us-ascii?Q?JokWlIltAvrq6RXKiGmC8CUPeh5mws8ONZnZwR5tabGevzFN7+Zst5ch7mTR?=
 =?us-ascii?Q?b/Rl+y5HmgPuF2UNp5LrtPPbv/wczz8kT6fEEJDiy9LcYxQleMs6/i1r2Z72?=
 =?us-ascii?Q?QTk30v/SRLjhuTG0aUu7Tq25ghPez+pmlqgEbb7g42F+BTIWauCzDrOGo18w?=
 =?us-ascii?Q?IHsQ43kh+OlcMpQV95Pqw3Ch7YWAgGbLxi9YTRtnhfcxPcBGTSpZJKtZKqTW?=
 =?us-ascii?Q?Zvr3mISsELujSpaW6ANHEVpgb2r/ck2gyPOvpUgZ643wnh2gy0LdO38E/XI1?=
 =?us-ascii?Q?7ymRWjx7ySgdX7Z9DtGglTNsrsN3VOxsh+6TE+qwiGNEm3fyoKaGqfy+qCvY?=
 =?us-ascii?Q?G3mzmGDrvdnEGd5pZTWhfZc32u9JEynKuh/WPBi2+uGDFkwIW7rXH0lWz4j/?=
 =?us-ascii?Q?LyN9UpFp69CUcILYPOj+NpQLzekic+XN2OgKseSm1DZe6B9mGGVy26bEdd0k?=
 =?us-ascii?Q?llg4xHWvH7T6ibnrMaE4O2+dfdRliqLzYJt/PbhexwYRraU8V1jzoiVLnCgi?=
 =?us-ascii?Q?maBTzUCgJmS3KJYo3+hoYQ6YRQNBZ3DoRvuKm5IPZYtf2cZpQ7vs0WCp3noo?=
 =?us-ascii?Q?8K7fN60VlzstB87dXj9eT/yJnCOEHdPDzwJRwNeBI1DuEmo2AwCW+aqra2Tb?=
 =?us-ascii?Q?RVixYL9AA/BeiqOTgZ4ItAvDvzUP4mCtClt2h5+4NxLzWjEqpr7kffp9fX7Q?=
 =?us-ascii?Q?cJDeuUIgrjK6JQsEVsJSK5fqT4rg4srR+/ZYjU+dK3fmoKz2CZhoQQIxyuFg?=
 =?us-ascii?Q?FYHAojr0n2/oWDeiwu7jA5et5ZExpYAkF10RzVVfaP0UPi9oOyGR6JuI3+6I?=
 =?us-ascii?Q?0oMmBiK8U6YgAWU4nlTsDr0FbgsHT1gfje3adDUEoe/uQSZ9/SaIvgZt6Yk2?=
 =?us-ascii?Q?V0/xm/4JALKa5R0qoi9Q/dEFT15qUPqE+Ovb8UUzoPYVTVKXkHNY/W9p/SBp?=
 =?us-ascii?Q?a3x/bZVLnfiC431bdhif9vbyVv+PM018+VjX5/s6Y9rHghxArRb1+lZtuoL3?=
 =?us-ascii?Q?pSqZHUUs3INLFubuVcuDApomeU6GH3906lcTZ4qskhFkHSYoAesM32iJaTl4?=
 =?us-ascii?Q?5QmHCczHI2Tvct+Jk8U5zYD9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efd9780-2bca-4c72-c4e1-08d9631ed271
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 14:37:08.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsVzQCfxCGyW3ge+zd1/i5vMN0m8Ma4tO05ODH6/7zjaQ8+5SzdXNIR1oq1vHv2D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 06, 2021 at 06:30:29AM -0700, Tuo Li wrote:
> kmalloc_array() is called to allocate memory for tx->descp. If it fails,
> the function __sdma_txclean() is called:
>   __sdma_txclean(dd, tx);
> 
> However, in the function __sdma_txclean(), tx-descp is dereferenced if
> tx->num_desc is not zero:
>   sdma_unmap_desc(dd, &tx->descp[0]);
> 
> To fix this possible null-pointer dereference, assign the return value of
> kmalloc_array() to a local variable descp, and then assign it to tx->descp
> if it is not NULL. Otherwise, go to enomem.
> 
> Fixes: 7724105686e7 ("IB/hfi1: add driver files")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
> v3:
> * Add fixes line.
>   Thank Jason Gunthorpe for helpful advice.
> v2:
> * Assign the return value of kmalloc_array() to a local variable and then
> check it instead of assigning 0 to tx->num_desc when memory allocation
> fails.
>   Thank Mike Marciniszyn for helpful advice.
> ---
>  drivers/infiniband/hw/hfi1/sdma.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

I fixed the wonky code formatting and applied to for-rc, thanks

Jason
