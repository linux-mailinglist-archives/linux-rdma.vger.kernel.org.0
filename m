Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79C3F1AE7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbhHSNuK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 09:50:10 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:36577
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240351AbhHSNuJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 09:50:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFjiAaHAfiM77+nPcQoG7X0+DeTm4YgMq00Y7G9Yp3XHeJZWa8SgYC+ueWZpJmgGbTGRUtvrEzFb0FsF27rH+cILMPiKIPCCFHC8V/IHxXlpjpFvfuy1jvG0ozl+wsMkZzYgnLLmJyrzVX9K28JwmTXorWJoJz6WCHHcnfRELUZWyRLpGLRhIDRdQokDpSK7fys3wzMtSmYmGSt2ttM5klCTw98iwqSvpaJxFehfQa7RGdOtSDBk2JllPDEELZkLKHWT7o0phg6DhfZhdIf2umg17C8rh6mBbzmGUllwhO3i3Z6/uyD3SEYWusfyDHe4XBwDRFtLZRKTMDluVTIMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4SdZIyAqNo3kI2sVeumodhpr7ae6MvBIHZidW3cLLU=;
 b=PeN/voR3NhNWpTiMbNDRC3BcOC1Ot3tQJX7V2p70pLnocCJRiAq2nlA4BTBe65oJlPJzbsyLWHZhAGrfI7RPAQivtUAVYrq3fwIeUokl5W0TUqkXTWVcs3bRv7hYARB6+rFyfcPPBHPyz1SbInn5idLyiYfcOQMCxkWLDlBUqMRPyF16SiUDFmdTmgLrlzc5EZrG9kKHDLpiBrRN9mQCdGDtxBdFc+Zb/qQ1Ulo9PRcR/ZjnkM4GZp/j73ngE3HoyYXDJcmy7aZlqd2jyI0tFB7MF28EKhnmm2DTiU9CVkxXA8mmBvLdqpsLoQObDMpgdN+DBtAmcyuLfd9a4bDf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4SdZIyAqNo3kI2sVeumodhpr7ae6MvBIHZidW3cLLU=;
 b=Zl1hGePNKGgYEjaTjaLe/R6TZuUcPSs6qGYwGjJeJSvCOoCED5EkZh6ozPQYOCElS6jSDvtNd2O4t2AOa/cPUdU2B2cKsYtzjIieehqeNHnPRac8UW8irFGqjwGQka1vB+sM/pIOwAcVWKCEDlJ7N727PxXYKklFRVPjF0p2wvGZH5eJ3T6jxd3GF3yEUFwnFC7w+ZPgB5glI72NQijaS1sD+KpkqmmYb2Pamn5AvQhQHnb8sKEkHCMO804b6GMhcl1n4d5Stj1yFAzwHVoFEg3dfRTi3RJYwK6+Q5H+6PjUoeo28z/AGxXdE0MZuQ2TzruJJxLPSKRo4dI8fdcX/g==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 13:49:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 13:49:31 +0000
Date:   Thu, 19 Aug 2021 10:49:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma: irdma: Rectify selection in config INFINIBAND_IRDMA
Message-ID: <20210819134928.GA288314@nvidia.com>
References: <20210817084158.10095-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817084158.10095-1-lukas.bulwahn@gmail.com>
X-ClientProxiedBy: YT3PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:49:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGiQD-001D0s-0B; Thu, 19 Aug 2021 10:49:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ce930c5-0794-4f03-c319-08d963182bd2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5173206048A91A75AAD798BBC2C09@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HC2XU5axXCQLNhOKrMyqkOOnIS5AepbimMr7lQnNbCZxJiMg5fk0H2iZGRsNKt5uIt6JqPxlyh1NaY985VsIN8+g9dZ5z1L9x15V6Yn1Eur+0MTBGQeGJ5PKxVNU/5uvroeOuSddHE1P4BIRpg8A3ixQ3E2ZhtJ3d8d/0IegCHFd7YoTnAdkjMzADmbP3S2hqF4ArvE7doCGwszYZoPlCM7X14uPfP9BKjxw24UxIIUNDjEcQquV+akpxshX/F+/Lryis8RpreShXki1SipcV8djy/WEmQCF2/agdXy0yCAWJtQ/6fHt8M17O39OpHuorjFYiYT4mbnwtg5b1tWaRUs+P5VlP8WOIH/pSBnU2hi0y4h9PB5pTo7PmvYYtOqPJM5F5Xa96ipiZNg6ZJD0b5zzOpwqdvp2fl5qTQHg9Milc/Gl91Io8puGclr6bR/JYen4Iv75USyiBRfScRTxY9UdJMHeq2Ua5iMNJKNuYcVXkV2CKWgxQCUcfP/akMqaP7DVV1tHpmgYMJy9kP+QDAQnZd7EL+nPivxvFTGo/R1xUokoEIj3Mr62Ei4BN+2il0MFesMhcPyS5KKc7Tkt08YydFZza8QYzmqqBcluFTmhPAInvlb3UR79UnqXrqYc4/akGd/0CJCNcgvO7AspAVjleMSPjpWO5g8he0DCJgAgXvZy/yUsorAO9SP5aif0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(54906003)(5660300002)(1076003)(83380400001)(316002)(9746002)(4326008)(33656002)(4744005)(9786002)(26005)(478600001)(8676002)(2616005)(6916009)(36756003)(86362001)(8936002)(2906002)(66946007)(186003)(38100700002)(66476007)(426003)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GDtS3KQgq3awYUrda71IV3YttCzOR6S/PvJu8+TwOppg5E7THn5Vv8WHZrA/?=
 =?us-ascii?Q?3H/LjnkVK3GVDNHLEe6zw9Yb5s7TRkslPm6XNcQphkkiUp/RHXgDK0dVdFKQ?=
 =?us-ascii?Q?BJWlKQkQZOhgGwEyGCX0ZFQATm1l1UCIAHX1qCeN//VuQGUuMX0bLlQLCBRh?=
 =?us-ascii?Q?PCHj3N9uZb7THQ3D1LiUd0A4lIdk7RFyyIXhqyLoftmfzub7bSx/sBgwOwhv?=
 =?us-ascii?Q?fto95hE4ot7sRA0WoBxPbyw562NbK9fGb0Weyx2D178cbwVePcreli3KY4Jd?=
 =?us-ascii?Q?n8ZZz91JV7PB+5ds+/zRxLuDCjl7OaxlabAVhyPiCEkVbRHJFdBjCDLjRFC+?=
 =?us-ascii?Q?7QAnNx8VRmaV3sMcps4cKZQ2+HQx94CAFDeT4zAqMUEFCiOcOniur7VinbMO?=
 =?us-ascii?Q?GV4LEm0Ld9tZJe3mQK5pIBGFIIcsdGt/FIFq7uFBBztfvlp4L8UVUG3qegui?=
 =?us-ascii?Q?gIk1ExAgTmVyDDxcB67tW3IWAL9YLbyNXSzpdBvZVneJjTaUc/1bZHzJuZAG?=
 =?us-ascii?Q?nKT7+jhs6WZ/ilj91XLvD29+HHKMC/OQciowJCUMeJXVdqC5iJE4uq4cjwdr?=
 =?us-ascii?Q?psNX6uZvCltUm3A9vprXE/6yp8EOtXulElo1ChdJKG05z+F1R9huwKKw2/4X?=
 =?us-ascii?Q?GG75V4bZZYK3AvlwE1rcMAC2Cc+Wdxoq9Zi6iPPr510t3gbu70d9iKvz8hRg?=
 =?us-ascii?Q?j+htn668l5kd4gsrAeLRKCXtnIjFrN0vnzrDnd79NxQ9miyPFhRBAayRMqGF?=
 =?us-ascii?Q?qtg5B/dEbb8AwPW8liFNZzZugqHZyRqrMmaAoaSPKKbxQAfKj4iWsiFSnRKL?=
 =?us-ascii?Q?hVTokJTng4Jkcn/iK2CVEaPXHKiD+P5tKuGP1ZiKZjlmL8jDtra8lpGAVhfo?=
 =?us-ascii?Q?EAEjuJivB7orj7xQYetQ+FlZnlS1sf5bVX0Uz6qXPYpPr1zLZn7P6aagSSRM?=
 =?us-ascii?Q?pVpbPu66ep/+zE6Mg3zIx0aDB0tLWZ6HTEWu2iLhvCJMu6KwuVpPiQNGp6Ve?=
 =?us-ascii?Q?o/F9VpnAuovhFa+AOr1yyhDYgBrXPZ27IjoGNMcAdY6BO9maNySzHUvhJ2nL?=
 =?us-ascii?Q?AuY0k33NFdVv9msrr4+38yFvp+nqaYwE0xlAGrqeE6j0FtMT6MxsbeDO5a0U?=
 =?us-ascii?Q?aGcdsGljm7fRFOT3C9u3zg+4NtB4eI4Fh8QwhZElXzjSpkvKbQhkcYR40rCG?=
 =?us-ascii?Q?3h/ZAeGdxGXbp2TWq0dojwBLsrzHQtgSlfLpDVMR9rYdtSpi2Eqxq3nhE+1A?=
 =?us-ascii?Q?4YAMtO9ZYspolz8rphUmPPQgoyIpyAa6fbBn0Df4XlxGW+rguTItWc34bRJy?=
 =?us-ascii?Q?U4csLnd2NmkbCeX9jvPP7qMb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce930c5-0794-4f03-c319-08d963182bd2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:49:31.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7movPgFkt+4RbQ3gn4+hmaTyPgnlMO+Rhhvv9NjsLsNloVZUKWo24hjV09X2Z1jj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 17, 2021 at 10:41:58AM +0200, Lukas Bulwahn wrote:
> In Kconfig, references to other config do not use the prefix "CONFIG_".
> 
> Commit fa0cf568fd76 ("RDMA/irdma: Add irdma Kconfig/Makefile and remove
> i40iw") selects config CONFIG_AUXILIARY_BUS in config INFINIBAND_IRDMA,
> but intended to select config AUXILIARY_BUS.
> 
> Rectify this selection in config INFINIBAND_IRDMA.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/infiniband/hw/irdma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I added the missing fixes line and applied to for-rc, thanks

Jason
