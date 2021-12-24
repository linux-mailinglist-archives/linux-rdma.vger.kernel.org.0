Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B147EAA7
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 03:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351008AbhLXCvv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 21:51:51 -0500
Received: from mail-bn1nam07on2076.outbound.protection.outlook.com ([40.107.212.76]:7947
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350885AbhLXCvu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Dec 2021 21:51:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXIsK3v9Rq7h1/wRtVpPVVaVmcbCp8NWz/ONFTkPUa6UgoHmkGVCwgOmh8LYWsgKx2IO8E+M30+02gY+t2/09tQx/T7dCeOoUblxcgTq2F/L/PKyuz63bAFVtAXu5BzPx5WbOIetVdw3RStct5Z1bL/BFvA9hqbX9puCH1jTVDPMahXxxryNY9XvRqbK9BwtqdlZ/cHJO/Qa6cTO0Tcba5wOwRYXggJAN+72pJvGn+jeJILMgsfjTq9QY5aDTydAsvSPMGuxN4AuwmkUvFENN1owFUGsLjNPZdVz+2hLnuIAvW9e0JNWd3Ad68Pxzbhm8nTBvSgG7zgZl4jmIipPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QG1eb7ap5WDqH+IQptW0qq4if4biI5j8f6VWs1HaPI=;
 b=O/5LM19NUi9+a/nPgpiCp21oyjGJDD/OSpIxVqQoVWolXB8w6AEiWFZKFCl3jANV9GHgm81KvJvZWm3YwElpqkRs37P0NSWo0gclLRhBzCNbXIzRpICsk/FzJyTANpOBUG07H0t2pVOHhi40dA2ICAtXsknna2ChOyaEuLsK+9V/PqivOjNlb3I3K5zoiW6ebzU+tR6e4dZJaYsStGGVwLd4VJDnG0iRxRUBHnPOmCmXZWNf2D4bGK+NMjNNO2chwBCGm3qTJDjgc5VVOwUup0jo52mqNa8byEMmTm+pjBSoLU1EdlMpZvtCxeLlLL0S+Wnn4kMJmpBzEZ97/kG8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QG1eb7ap5WDqH+IQptW0qq4if4biI5j8f6VWs1HaPI=;
 b=ph/DwWu7WOwvFt4aKK/k/l7A0/6XxrKCOtqBYNxxarKtY9mwD+v6ooU3CFY32QK9wXD7T3G4NuesoLc8Slh6OeGBtInm/SszV9SEZcM27pOzYQssFbHnb7Dp+Ouiwl28yUSiAdr/Ubw1lGwtdltn/dmxhzhETSiN2qeHpEgrIWQQn9oL9Kr6nNtkIExHxdtMvwhdPt34rfHdCMGkoSAzGFWTSpDWK6+KH+X6WEFdSw35fvEZbMbiWU5golwB6/1T8LwGruBv4B1TGht9BHbmiIrDg6LnotWYv851YpNyAhBNMqPPY9dagVPFtWe4jMH/vBbwIr0fqGXDJiKeYUeRKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 02:51:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4823.019; Fri, 24 Dec 2021
 02:51:47 +0000
Date:   Thu, 23 Dec 2021 22:51:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Maor Gottlieb <maorg@nvidia.com>
Cc:     alaa@nvidia.com, chuck.lever@oracle.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, leon@kernel.org
Subject: Re: [PATCH rdma-rc] Revert "RDMA/mlx5: Fix releasing unallocated
 memory in dereg MR flow"
Message-ID: <20211224025145.GE1779224@nvidia.com>
References: <20211222101312.1358616-1-maorg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222101312.1358616-1-maorg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0342.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f90e164-1895-4e89-93dc-08d9c6885394
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB533610214A80B151F091A659C27F9@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Z9iidoBFBtDI1Gtm9r6htTdP8ZWBHniQnc+ZCmd3zvJ+4UF3tOmuhALP0+cNyFTTIUCpVuHDv0ujxrmSN67zn2I1/+TYm6OyPXyo7v72060fykQCKY1O2J+icaLant9FhJkLWgrAGS8a8g9leMBAC0Uky3JmQitmYxmDYOYlndmp9n/TEsbcnL334PGrVnDeb7KHacS9LR6NRcxkDj8qO5/LDXHze7OxsY8wSL/+mF+hdpofBe/jARw2erOVoNag1DiJ5RLT7X2ttuLkstR8wBhh8ezhQZz0SXReAybHOWNmTAq4nSolHUezfjUYFX3Req7bgRi6vp2k/Ocr2yy/H3Wml0nYAezFAjZENY5t58jVCiOV6nFfCPihVMIDNRnMqFAcaRo3KOdSYrJZYmNJlrg6wxkRGW4fUe1kbqAIR6R4YyrjvP+gpOAlriW4fwUhzq94yZdaaKSIr5oRIRACa5GzB88zVuIvXOof+2H2Vi3CvuO/bOWAmIuW3ElOpdSKmMKyJPp7W9cKefr3k8On9852PgqSGGe0My2sQ7TKBKqcrOiIU844RxGaeRjegE3W+MDqVPYBGIznc63rW36tOqtF6v5Rt24hVm36lvjsbuNSVoIH9/on7LwJQl0Y70Z+1pLghkvASZ1wcjheYtyZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(8676002)(186003)(2616005)(6636002)(26005)(508600001)(5660300002)(6512007)(6486002)(33656002)(8936002)(66476007)(6862004)(38100700002)(66946007)(2906002)(37006003)(6506007)(316002)(83380400001)(4326008)(66556008)(1076003)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSXcOtiKR8SxP66ZOdoAr62P47RyYCm9xy5BSYMBNBkv0Tfpz819xWjiNvpC?=
 =?us-ascii?Q?aXrVxrSrpeyV8AEYbKfGmWQbhI5yW6P8k6pygkzg3hyOJaJelMga/p6gQSrL?=
 =?us-ascii?Q?rg+26YHDiq4s6q4lD0k+TqpmoP78ESihnIeA3uteg9F/a00RZc1OzoL/jl9y?=
 =?us-ascii?Q?NSg2j20dv86tleoDR/E80nLk8Ea4DcZPOPErxVli85nTmqaQacy7v2XLAV5f?=
 =?us-ascii?Q?vofCnXmI23VOc9zcycv6dj7Z/1+m4q38tbDbuI3Te4soouBXUdCrPNsRVONW?=
 =?us-ascii?Q?c8NySoPisW3F70MXdbMBh6O+YzDE3V8O9MPvL5u/wsi885DgocMaIfMGDVCw?=
 =?us-ascii?Q?U84aPNO9toxWES25tm8SXH5FIqHqu/fX5D4KsMmVblsjh07qZ0ouYJ1jNWHH?=
 =?us-ascii?Q?rAEtcKeV/QGGIFVEeiXkfeXE6Dr6LcMlnK/OX6PP0jPmiNkU16geTTobGSgi?=
 =?us-ascii?Q?1e0vvNO9M9HKXqFKxj6P6YOSgd3/JQlxr47vHC6TXb1nSkZmE2B2hMRjWG2+?=
 =?us-ascii?Q?oRWTOxJ6i5HnbNAviaSATHz57E4IIVBj/fJCAznP7MU5PumrqE6Bs63+fdiY?=
 =?us-ascii?Q?vzYxlUQUjlqHpHNxevt+1CiKjZfnYj/eQqhjFoLDu6h+oThTXIp2rg6fOfnB?=
 =?us-ascii?Q?hAzNx5u20LoWUdJ+0JIR8gXafpW3KLEKBVQ7tgNIphwBVJuTXoJytHXwCtCl?=
 =?us-ascii?Q?JRP8XFr7xbDQW29O7OoNcMbtKMo+XmwouzTBWpBxKqVxLq7Qtqjcqm/zceBG?=
 =?us-ascii?Q?UE1GdzrlJVl9MDs/VJgnoX9276JRVIMO3hfaMA2uIlVrRz7zzV8XhkOTBwE6?=
 =?us-ascii?Q?BwTKzCr+Sj+8DrKZeuWqSyoOJCLiCSy2JC1rcV1rDBZ+FcjWsM9zA603aQKO?=
 =?us-ascii?Q?XsvjDWAQnKUUH4cfvbPp4d7FYTahhYJZF92ag9yGthhFxDHBFpVe8+M2nJlC?=
 =?us-ascii?Q?fi4nWyQ0QwpWFBvxhLNUtMfMPRx1FNotC1bUZu+0+qbZDbOiJzErrGtyCYBv?=
 =?us-ascii?Q?yye6F387Z8Ttrx1DnqRvodEXGatSrcMolOwTtLszc3/IpxiQedS72EFTfOvg?=
 =?us-ascii?Q?qt+Mr4C93ZRHev6QlYCRVyTON5rHGHUmHMtz6A5SVSc5hsLLgPlWNibrROB9?=
 =?us-ascii?Q?ZGdMjCJeDtmIq/vapRLaqBTcKVA2HLjUin9arzu0L+h5sUZCPxyXdtE10Q01?=
 =?us-ascii?Q?p8Csk6JImKSMLdBQp4j2y4oZDALx4b9EVsdzY2BBIGAcf/wBWvjGPZ8dIork?=
 =?us-ascii?Q?SkYXxXDwDAMmo21agPZrt+Hcc+1+ux89GV1eKKQylfMhzzns2+KzzKMfHnC5?=
 =?us-ascii?Q?FJbN+mpYFja9GSx/hlxK0E3nXOmIarQkicXDqpzqPDHjwYy8PiMVEHMP+aRh?=
 =?us-ascii?Q?yy7hVroGWTI/kZM0QGJQLASLZgTxYWJ/Ur0HGnf29n8MXRABK30kQrsNbYgR?=
 =?us-ascii?Q?cGXa5ci8nqtXrm3+DkN6ENxqzTya1E2ovwk5Q3N3BxUveSii4d0JDE8P8b7g?=
 =?us-ascii?Q?7UdVTXA9+VU80ibwEURCwcvc4hXIdubGmHBCEQZ+M3PAPTvkN7fQThAHPsZU?=
 =?us-ascii?Q?de9hbCJoguLNNF950QU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f90e164-1895-4e89-93dc-08d9c6885394
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 02:51:47.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdKlcxBj/jHszIxNzNTl3WSct66RgWpcswYyAZP8uvfOQLgAg6NWeVx6SPBA8kGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 22, 2021 at 12:13:12PM +0200, Maor Gottlieb wrote:
> This patch is not the full fix and still causes to call traces
> during mlx5_ib_dereg_mr().
> 
> This reverts commit f0ae4afe3d35e67db042c58a52909e06262b740f.
> 
> Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++---
>  drivers/infiniband/hw/mlx5/mr.c      | 26 ++++++++++++++------------
>  2 files changed, 17 insertions(+), 15 deletions(-)

Huh? Why is this such a problem to fix the missing udatas?

Jason
