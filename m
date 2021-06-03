Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B633739AA8D
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFCS55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 14:57:57 -0400
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:46048
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229620AbhFCS54 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 14:57:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV4ZI34wR+6j9HIs1CH7Ug1HGf2cOs2XNrrbV5QL6qdQ67rkZYlQApwDgeHmhsdF5kMsdlK1/FpM+mqdXOK9eKxELww9xlx8E5WJPc6sx1956G+JbhzE7UwNJaCGlaYKM7CBH1zL9qTgL1VzyJqWJWy5eQCDUhE8FYYVesMEmK0CRd06iGZQXyOuVsmNlzb8q0oJIIv8ceQQVbuwXzzH1trZz8/UYosWrOjQbENNMY2bhR6NZ3K/oXSchB3avxGGRY8tA1MM0T7p5XvPRwldF7K49F9fN9M0U3GeqwXBlSA6AKpb/rH+apHeC41K4ynuL0TCZyJgVGZduX0BT0J0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XehWdLFM55Eo70je9fmsrbiMpIrUphxOBvgVyLXmNuc=;
 b=lYOryFNQIXD/q+N4Z63dIucy+pf/sbbq01cliA/zgTTxZseAOYnH2Z2RQn1bvA4TbxjuRAZZPEk79ehLSfU8WkSCC/2fjaZJsQ1ob06lfmrSKR4obs+W8uhTGMFNG01MODfOdhgOgoPOM4hZdKaCA0/GFfk/NqbBsOKaCkH4oXYu/vqpUg9jdm40SVtbJ8BPg53RZZPIH5hbfVe7ouqg90SNgGy2lPdHCmfcd3v/EVD1OCP6ItldbhWlz26aLeDlPa5ak3zb15Txo5r5Hj8UMaiWjLdChh4qB1unnOcAhD1X1HtmuyqpLe5i8TcYpmEtEKUrLEG90RiiIHfpnuSsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XehWdLFM55Eo70je9fmsrbiMpIrUphxOBvgVyLXmNuc=;
 b=VKsS4sOHS17lTVJ3KPzjq1C8mHTUFCr7AnNhGEGyOAAYMC8JAIUqdSFbQdb1hxeyehj2Q6NIvlW7c3M2vdw7l/Rw3uaBNWfL1GiC3ZsPmChFlgctNJ2lMOimy1bTNlQNeoFp4Oy8grF6LlM7FBK2dTZjjoNc16SWGv5f+3CN63dmaijVIYwK3tlyOTrO4ww4OIIOPB0TWsFJA2Bv1F5r8XrT1x1fYI0Z5PJnkrcLsjK5+MhVGud1hzH+dKqAXTLQrdHZKyue6NAu8lPDXlY1hOkuk5VdW+d3P406ImNDeupMKB3NkCIG9N7W3yLNfKuqWLXs8JcZ1SRSWl/ua+VcBA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 18:56:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 18:56:10 +0000
Date:   Thu, 3 Jun 2021 15:56:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 0/3] Fix memory ordering errors in queues
Message-ID: <20210603185609.GA317370@nvidia.com>
References: <20210527194748.662636-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527194748.662636-1-rpearsonhpe@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0032.namprd03.prod.outlook.com (2603:10b6:208:32d::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Thu, 3 Jun 2021 18:56:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1losVl-001KZP-Iy; Thu, 03 Jun 2021 15:56:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8283fcf-dc81-482d-a181-08d926c14090
X-MS-TrafficTypeDiagnostic: BL1PR12MB5335:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5335D44C24F098D7AF68E41FC23C9@BL1PR12MB5335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TlVp1xzhq6cnTwS86vsVv5EOJEtv41Lcb9Fn3WkVb96dEx13Wg63f5iSBFHee0FGTEfmdm16SEHggxSsyeHTiuqeNxW6hJ+U4WUJ0Sa/rsG3Zg1hKlujeIwkU9Oot725bAu35ZnF3K/PZO/SK4lu0053DQ4aeVs+oECy9wfjVci1XkIdJdx6YOGn5liQ64UbX06LKYXXrmQYcrxgZEg/c+GO2MakhIpuRLVEA94YBu3cn56B4sCHXqdbA9aU84m6Qr1VIy/pf+nLCwp4S4Ai+liZQ1+FvNeF/jhz4CbQ0SjzyQr95O+kjggpsFDiL6UCROqGEraHFduQgnHC/UEJaO+YiEFfEHYlIHzCif0h8UY8vXC6zeTuz8GG7hFgtQbGs9LPweSBNjgwWwZ/bt0V8bQRDGYx09s8M+wPb7aBGK8ukzXZcieeIvwQp385MPBq6j4SL96ihGBV+ie5D8gVwFH7tW3ykFahfK5iUwr9WNLTgZwh8bhlCk0xWb8tmZwWIPf7WqO1FPGFe7enXck+QDS72DWZFZpGs5bifCLggqN53IVk5PBGsDF3ir8x+EXfVeO1FPj14TzUWUpQdxGp8M91+rBnJbNHzk3VYHrzHkt7TKax5E7+w8NBz0G3CbqGuAcXvovHBZcfNA7wrqpB0QvGqIsQeQbC90M0I46l6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(66946007)(4326008)(316002)(38100700002)(9786002)(9746002)(6916009)(36756003)(86362001)(83380400001)(33656002)(66556008)(5660300002)(26005)(426003)(8676002)(186003)(1076003)(478600001)(2906002)(2616005)(66476007)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JFajmkfmh40x6drkW36O0/aFItbBSHwTJhucUJ9TtOgTbJavN1O6juQbR5LU?=
 =?us-ascii?Q?TGEpYLdcCFtfmuHIGG5h5JHB7o/Cx9uskqm56G1zYrSKqqOAyf5jG05TP5tt?=
 =?us-ascii?Q?S1eXTuf+QYt4M/DTOrctRWP4QG7nau7TaqgTtz73QNAGjGAX92XIrNpa0IEm?=
 =?us-ascii?Q?C3UC2RC1qVUHJWvyMrGh/3H8LTfu4abAcvJgeej9c8WzpB1Yh+wQfD5vG7si?=
 =?us-ascii?Q?kTEsHaxiCF5oq6VKIavFkZaZMk7PLMYO1qRbyNRKgnfcW8WFuwc9dmIksHy8?=
 =?us-ascii?Q?Pax6gYTT7oeXeycRg2Fw9wzoaiurZzLOTtLTsRAioHym1n9oXXHG11fJDyub?=
 =?us-ascii?Q?FlpT2f6euCBnUnn76GFf6YqVSDcrwUyZZkLa12VQLrVCmhV98F6GbSx55Jf8?=
 =?us-ascii?Q?kTQ4tkATtrv31DkjI0KVvagCI5mlzONV1bMjOClvjp4H0eLGgGXgexVEYwRF?=
 =?us-ascii?Q?++P5WZ0H9OdOgs5Nkg5cUl8ffKMBXUu/bASgBYWQXLIGSbFfHJuniN+SnZGm?=
 =?us-ascii?Q?YqF1pC1R8BbdQY+C7Y+J5dCGmESY8dgze9Qj9Ugz/bo5yuU1EOLweM6PdDcN?=
 =?us-ascii?Q?V758w9zqT+SmzW7/EjtTQ+UxBkT+C8pzdnQ28kTQNPagrwt4TLCoy0p6IXDS?=
 =?us-ascii?Q?iHBHUWqemjAoj0xPPnbJJvNkaY0dPHvi6IZl7T1tyHkmuFYtpGhJlh39EI/W?=
 =?us-ascii?Q?mr8aph1i9CpqDCkG/WOqTHzQnz17c2dzPS6SwNx9ndoneIov0ynivTGPEvbP?=
 =?us-ascii?Q?+sh5Dlb6mpVNhPjyJWVLQkQnTdmS6mRyqVtVZApane2JODlS/VIcFyZN/o2a?=
 =?us-ascii?Q?TG/OSWeWhyIsgZj6lGaJwHTqjBU0rl+PhImZSl8b1C+/5TkMmPSyqBRYNVuk?=
 =?us-ascii?Q?LQEn94m9u1fuFR/UXVQhxG1ebFVL0ZidOSENF2lqvaLZCBiLRKvYSJ6Oew18?=
 =?us-ascii?Q?MrJ7Wcxkps+pE88rFmvSyYVAuNsNkY4YFjlYA4q/q6gC0tZPOBOmtK6qI3Yf?=
 =?us-ascii?Q?8j1/EZam+t57Aun9cm3PHRZGGf4/huMYLzvpt4VgVnw6dU6IM6i81L7htpPN?=
 =?us-ascii?Q?GAULKtR+DIL+t0znCXj1GPJ/wO46alD/o5qGcGCavtE2xVkXDP1tQBBcrNAo?=
 =?us-ascii?Q?06VmbHAIJE1UeFIPc+n37GPGVGjEs2lDKrz4xd2rFVb1lvC5RbI3ECZrVrP8?=
 =?us-ascii?Q?GBRmmk1yDJw+1ze2CvRo/bOGgsm1kf7as8Tz1Mecrs30O02ABrUXPUF745kB?=
 =?us-ascii?Q?Ln4ZQnlwY1EYSGI2xS+qSQEZmFRowIGvrjAlCiy3n265rktU1WZ+GL5Z/hpv?=
 =?us-ascii?Q?coiA8791ftf2iu1GpHWcw/GD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8283fcf-dc81-482d-a181-08d926c14090
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 18:56:10.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XVZc6lglBeJWAKLiwW++lx6ZtBkVLBPNsykLyAPbuGRY+tRo6ktaug9DP3WAHfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 27, 2021 at 02:47:45PM -0500, Bob Pearson wrote:
> These patches optimize the memory ordering in rxe_queue.h so
> that user space and not kernel space indices are protected for loads
> with smp_load_acquire() and stores with smp_store_release(). The
> original implementation of this did not apply to all index references
> which has recently caused test case errors traced to stale memory loads.
> These patches fix those errors and also protect kernel indices from
> malicious modification by user space.
> 
> Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Fixes: d21a1240f516 ("RDMA/rxe: Use acquire/release for memory ordering")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v3:
>   Protected kernel index in shared queues from modification by user space.
>   Pass queue type to allow compiler to optimize queue methods.
> v2:
>   Add a way to distinguish between user and kernel indices.
> v1:
>   Add missing smp_load_acquire() calls.
> ---
> Bob Pearson (3):
>   RDMA/rxe: Add a type flag to rxe_queue structs
>   RDMA/rxe: Protect user space index loads/stores
>   RDMA/rxe: Protext kernel index from user space

Applied to for-next, thanks

Jason
