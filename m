Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7335069F
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhCaSo2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 14:44:28 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:6703
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235440AbhCaSoB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 14:44:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1CpY4gqHMcsn6YRyeAlfGCjUcjzS1VvvQOso+523/UrmzXrcP5FPRAPTL4evHVxx5BT8y9sp25emW/Kr7RKK5WqW5K2h6wK83kI+dUX5C5PpwxkPD7FNZzY054d4PPZUf2l/c/lCmsaFDQqnI9Q7xV2eGaI9dy19UH0B1JFoVsb7JA4sPYpb95yrFGEf6Z7fL4XgwARP79XulBjV4ljIZZc6UX6wCsuhWJ+wx9rwYRgct0VrsxkWKqtghQasErAWkx6xmCIJiEpGig17SQh4AWkNJzRuin6Z20LwI02Y6h83dATnviOxysQ42BmvRAEH24FU/w8fTonMddhHgVlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHt5DtY3fDH4bq0uQQhIM3vrOXBlpRu+jYkcCYdM4RI=;
 b=UqRnqEYgYUzWq9DtbmCZJ4hVWhVEtSX3EfUkKKJ5PfPM73hyTCimOnVq0RSxZg/3fGPWqn0IQ/hu+1ImFjF9ebFJnRpUxYgAx25i32tmfbw5eQkMctro0yKDLNp/vRnyoHpCuhkS0yp/dKX6eJoIOAL+yElmsTNKL7I7VDuINVzpxJozCDK7SKzMXJYR3zLa9++4LZFB1WagB8g7pWaFPiSBFs/duJXdAjEhGA4Cfc3eqIoZHrr8VslZU4pcy8n8TZbTPn3lrsiTADpp5uJ9Rwb+DC7cyeqsE95F5lGr4zqFHsEQ1UrR0bK07QjbAv3RIQYiaCtdKm9z4MYOaH33BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHt5DtY3fDH4bq0uQQhIM3vrOXBlpRu+jYkcCYdM4RI=;
 b=iy5+zJlhT3Sj/A726r5RwFIXQU3Z/MAGWx+9ATzSOkpIdoGG12+aKr+2U3Dr7l4Cqo30GDxxF2+jJzlgSQR/+iz7Z1Ng6BIM6rUlhGdEPynKAizNIrzDSvqUPNLEXFCtzlyXFUiodbD2Sn/KJKXtyBeN04nc8ZEEUwh+oqehgLPSTr1m1OFziGPpRtX7Pzmzrkf6uY+sj3PaZ4mNW4jjtBjcApG06Xj6Yyu0pvBeFSL8XNnvsFowYUSE7jvzVH8kP3TGXp22lJCj7X3sBtvQm0bt8aVlOr2F8jdGS+NYqD5Ooh8v8jOn+TqweEJQ/TWilg4WByqR6045uHNYuvt2Aw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2629.namprd12.prod.outlook.com (2603:10b6:a03:69::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 31 Mar
 2021 18:44:00 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 18:44:00 +0000
Date:   Wed, 31 Mar 2021 15:43:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Remove rxe_dma_device declaration
Message-ID: <20210331184358.GB1534472@nvidia.com>
References: <20210331102043.691950-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331102043.691950-1-kamalheib1@gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0265.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::30) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Wed, 31 Mar 2021 18:43:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRfos-006RMg-2W; Wed, 31 Mar 2021 15:43:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb91cff4-d66a-4658-6753-08d8f474f2b3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2629:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2629692F8403D6F27B5F5152C27C9@BYAPR12MB2629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwYYldsdL2DGr8itZiZD/HIm1rrNs3SsLhD79CSfldTpDF4ggf23CGD6FgBjQxqwNMnjZYT0/CAsF0DcU9JIDAGzHUhi1JSki1AqZ8W6fsiQuke56eIGkNoP+PwJbFxCvufnWv1qDZWpsxHdtIpoxL54km9qqtn7P9Lwzf50oZM9WBywLYH2lCnMoCzgVtaEbhEAUitS27FdNnA8l619QUkfMoH5TPtxji7LTf9x+DbBWvJ5uYCdQPSGbg+CkvJAQguAAnXiZ14ziac7hNrkcxLR6GeNXT8TvTZitWnxGGFBRcI8BJdp+qZH9zNecuv7tGtxZRakyXV3V/N77CPr3X86MUubsd+WcoAVMgP5WDl4XXbUimnQV7qVGuS4rMkgFj2BrT+smgnq0BV3LXwJlZt7w/Jax3AdUj0JJe+2hTIzwYfjJyBnatogUgiMnGtF9948w8xRTjKsqSAZGwbVCaE1rVBv2O9Xls29hDrOzKEvQSXf4yAb+UgJW4yNIap68JJBnwxZ8nhkfAbAZTGRxa1yEiM4k+pfp2Ijw7aNyhbPxZMALKoJbCj6f6gopebcueD8bsZSwHwPgXCPluzrNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(2906002)(83380400001)(26005)(38100700001)(5660300002)(1076003)(478600001)(86362001)(9746002)(9786002)(66946007)(316002)(33656002)(66556008)(4744005)(2616005)(66476007)(36756003)(426003)(8936002)(4326008)(6916009)(186003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uY8KFk16ArWeSJnj1sAWv58Qu8hypmsb2xKF4oIfPnbIe9Z7xny23H6E2vDM?=
 =?us-ascii?Q?1sBb4pipbJC/FRflnow3xe/vJGnTwM+hMcq0esgCikWS83veMi4jwdKOqsFV?=
 =?us-ascii?Q?WTVJuwdmjNC5JU6POiwZuCehM74RRZv1g4OCZpekV2JwBDVRUgItpYnirJo1?=
 =?us-ascii?Q?KMYP/YGr/cfCDgu8M5CH3D6YcJ68I57jRlXIjPJXZekYlhLnzSImIg6mByc7?=
 =?us-ascii?Q?7YIvdK81pFnVccqvEVN2L17RY/AKTrx31NzYoRoDBgQiCf/n7rpSqq60Bysz?=
 =?us-ascii?Q?+I/fSr7H6b0c5zN7mdm0qY+C//oi7zjomnHxTH/mofOab4sYa3PLCF7CLLkq?=
 =?us-ascii?Q?Oo0j4HVXc6sEv8R+4pALGjYVG+SEKvVv6/RxNfYcihwJPBXAWwLd/hmxtIxv?=
 =?us-ascii?Q?SCLfsEoO7kAwZRT60CXqhJS2U0KVtvDzBZBzR1RPx6Aw0jwDAdc6/VLr5LWP?=
 =?us-ascii?Q?IFjoUaGV/tEtB0r7NzsUNg5lHjua9FHloMU5HmPr8A7WCWBkIkTevcH1WddH?=
 =?us-ascii?Q?VD1pklzY024VxJvOt1fAyaViZ8wOR7sE1DQdxkglng2Xo4Of3v3wUL7j5TZz?=
 =?us-ascii?Q?TJayIUBu+Vnm1pNYv4dvpCvOPMdZBTRet6vmCKREaMPjp4fSqr1sirHAbML/?=
 =?us-ascii?Q?Qi1D9FuyV9WM9VYmb1nc51kDtM5VYlk9sfLgaTrvCAn71iVa89CQ84JEVkJD?=
 =?us-ascii?Q?GCnstJOEQFTbVp514XruSbVOB9HMLK3jmAFAdri9CA3k6U9kNQXaWCb8PgAa?=
 =?us-ascii?Q?a9OyPeY9hJANA+qo1HXNjQZCAdIkcKNPxzgv8suBFvSWxio4jk65vUKDISVV?=
 =?us-ascii?Q?DjfiJh0AKwaTEZPFOOP6uWHhQCC5crY1+XgShcBrMWik5CC84cGx5nVSLuQt?=
 =?us-ascii?Q?ikSGF1mccqwsSYV8MM6LWmkHs4dKjv6OmEQhR8t+BROS5DrkZxTDxtqzcTnx?=
 =?us-ascii?Q?jojbGNB2kgbY4xDe8qHfJCKxxe/kMxeqh1+O0ynURfElP3wBulv2uP8Dad9W?=
 =?us-ascii?Q?cNPq4omsTqsUfKzsaOwneqcTY1VjVejnqGjN+k7OQb1Jf76P8kW7EF6bHnLs?=
 =?us-ascii?Q?+BXz096t0V0QozVcw1D6zKy7FOfVsNKtSd/z5GQ1GwFEOdnbUEH59/jiG1V6?=
 =?us-ascii?Q?+yayyyxfms7teoVq2seRmVDZ3SR9i5AUHmSVmBlT1G64+vGAB9+HoCZ0LlIR?=
 =?us-ascii?Q?LlKWhAzLVs3Uas/NtktdZIxlXvCRFGKu1C916o/h0bJwjdnSRejJzFhSXxb5?=
 =?us-ascii?Q?B3CRXbMAibfLhWLUBPM5yeG1y1/snYCzcDHS5BGwnVUdWA5UHL8/vr8NTVhr?=
 =?us-ascii?Q?HFQLIU/pT/W53oB4c1AR9I8etdpGtiZZFafwv+SckcM8zA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb91cff4-d66a-4658-6753-08d8f474f2b3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 18:43:59.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sU38LbEiGSpNZ3HuohnzX6kZNVp09QjGaIRl/U3VxbalYeinf3I6fXq2rHqLJY2V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2629
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 01:20:43PM +0300, Kamal Heib wrote:
> The function isn't implemented - delete the declaration.
> 
> Fixes: a9d2e9ae953f ("RDMA/siw,rxe: Make emulated devices virtual in the device tree")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
