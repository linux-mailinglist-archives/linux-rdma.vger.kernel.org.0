Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC44246BA
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 21:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhJFTjJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 15:39:09 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:4577
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229992AbhJFTjJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 15:39:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCQERzJdfejyDdv/0I4gKYuKk/dC8vs7R5ihl6Amlj6VDkxi+lFBsXeCCEyDUuzEzI0wYQm0IJAANXcAnZNwf0fEuFWu0WCHOiAIt2+XPHdNf5fv4uqxXQCt1Y62rCKjHCuxujL6Z0z1Z/SM3pvyGUw1y2ese60gmeUThLgKaJqdwIGdnqOkMaEE2YGpU2/JWt/vv5FVmJtjakbsQ+9Ej2PtgMXXr1pm+JjnxOOq25aakFIH7ckwc/lNLuolJ+VK2a9Sj41lh7SmJjJenosBeWEXuAhH29XThhm+YJI6XCJOYt93Id2bdW5Tq+VZKY3PNixB5FNxJIVw24z47BuD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsnXBT7KkysvBEoeTtAOuYOTWwZw2crUTeV7Yp1fHMU=;
 b=UnuVyNEbilaVGKK5j443PiaFs4N4a38p9OCECiWi9fA5/l/A2ZwKTR9R0Wfj4ulGD/jPcSkstPVySXLMuRHFJeVi/WLBNXRpTz+T/iwA1t+22RPZwPe7jd2t36AYAfKGFqcx/hUbEmWqauj+rVVzLnxjlxTC9Y1uTdcyULJTo9V1SJYx5dXQOa9Q4YIA0OZmMOJy9Oj+1UdpsqGTo3zIDuR++CBam6zymGU/OvZfcQDRh80ChODCUbO7DTwe70TmIEmlKtOjpFvPHH/hpeAU3J6cx9ZzTEDjijZyshdfNYS19nbskj75UtA5WeqxAJ3vu86IjDhPbu6LBbxbyJTzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsnXBT7KkysvBEoeTtAOuYOTWwZw2crUTeV7Yp1fHMU=;
 b=EMToMn2A4bwTtweaDwfNjdDDvNBmezk3F9+YigFUfzioI+IJdvvDhYBw5e5Pa3Q/cKeIPIv6HmtPHRF/9L9xq+58bS4FxjLmCa855CRvepr5Pf2M8sG7yuBY4B5kVnyD7o8WIL/JdI5HxKoCN3gC0e29FiwYRnrp0fYFzIeT1iOHfxQCdNrGorTiJwsSvPxI//Vndgqmqfl7b5aXdcu0D5GPNHxyXJ5p4HkeR9Ea8oso/ZrF0W0daQeV+t9XGFlcI1Z1qPXeiEktyHTugK7Un8Nky5wArmcnBwiW+nyJpxahWWlWYWfDXOx4ciAd60UydWELiTatlyqXXGTmY3sW0w==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Wed, 6 Oct
 2021 19:37:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 19:37:15 +0000
Date:   Wed, 6 Oct 2021 16:37:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v5 0/6] Replace AV by AH in UD sends
Message-ID: <20211006193714.GA2760599@nvidia.com>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006015815.28350-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Wed, 6 Oct 2021 19:37:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mYCj4-00BaAe-Gb; Wed, 06 Oct 2021 16:37:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21b87d95-264f-43d7-aa3a-08d98900b367
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5269846AB52F6B5FF0F23540C2B09@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVxYKGgY7Ptd3ge00JWhjdXwPsk3X5GK3Bqz7N5U4YcRI8WtAr+8jbwlicffR2+d5aUfWKM4GqqvkeAkDeqeN66geTuNlOp4pGEIuSMAlgHeNNFJVymTDUBJJ9GhxL6/HLRJW67Vgo+u/qB9oLvJPFLyFrUAEg7R6JnSRQLAyhFTPm/aLHc2jQJ2fcy6NLRRBX4CW1kN/wiZtYki3bNyM9QVjEQV5GD83JL1eWpFpRGocQU71AcyGXDvyfuX0tyH6ms0/KjlX1coZ532WmcDa+FkVpUypJ6yYNv1+7yrfJKuyWyeAmkSO05PgYrWg8Z5uedJ0MHPzlHJ3qFJ56wpU2+zA/PuiPl9HjC03NnpzVYBiL+vkbQKXm12cuzcZKXX7+Lfzq1u8zAHRwmK2lSr+awk2o+cQ6iY0J1HXiDSdOJoXQskqurF/vNe1yeaMjQyKgUhloc3nny6JPPi3+3lDcviTig3Dv5Q1VUtgL1epGwfqrf4RoqqReAmJFxVf9GGRcjeJ7pxTehEd/QjS9iWRPoITLFt9jHrCgqXVXebK8tnlUAMP3xHsQj462C+H8tZiEcKM1Q0HSull6QmaP9OdmmK5TZNCuBDlxGfaiBdQJzE2y3IA+fn3yLet/W6/V44b8m1HCyOLRDlUPyAXqBKKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6916009)(508600001)(426003)(8676002)(26005)(2616005)(9746002)(9786002)(4326008)(316002)(36756003)(1076003)(5660300002)(186003)(8936002)(33656002)(66556008)(66476007)(38100700002)(2906002)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNrEhF+MQ8MxFDdzLXUFUDGaoVhzbJiyUhJcftfMKAWmw7MkzYNlYk4Q8nMm?=
 =?us-ascii?Q?AusjXzuJVTQCErkJeeAJd/20rM9caxEZcM+ExTID5V9opmIGsXU2uHvlwKlu?=
 =?us-ascii?Q?MApdrPBtkBQWsQb9PXD9Y5VKQ8J2shcUU8jfWSJjwk0sC0fDSJ3OES57IlbG?=
 =?us-ascii?Q?RAGWeyowvjEe92D9vKLdICbdVlpeYMOa735bliD/2Mz2nuAHDcFoM59iF8W2?=
 =?us-ascii?Q?60sYcFUDkBHS4CQJIN5fdQlCmCCpoRNrcGhXJAWKXMsw1smBO+xztIygKLSU?=
 =?us-ascii?Q?pGHunvuiAUxn9zYQ4+s+/zxN8oNkxVaUdX25XssnKSJfRPUy8S1APGq3ocfn?=
 =?us-ascii?Q?PDNwTOWcz3rxsRnpOIvz/AzwoOf9pJCYd2llg7a9geKzn2FaQ+8VwhDfzkvq?=
 =?us-ascii?Q?slRn1f8AF3tSFbitOmdykuOHAiyu2m5TlTzh3LojHy365Xwd4g138HKbHmQP?=
 =?us-ascii?Q?C9cDODfGrjj1qNIvlcUzu9AtDIiObFR7YXqupDc/UWH/+ELPckQD3ANZt78T?=
 =?us-ascii?Q?B1WZ6Mr7Qah1YEiagCGxJoybE4Kj/FYahZ9GUF0uX3DWoMYnMtWfxHNibwfh?=
 =?us-ascii?Q?YUO/VEotaiBmcf7baybF1Pid2O3Kz2ahDJ1eh9EfwkU5E+a8hOijJ+EJhG1B?=
 =?us-ascii?Q?DvWHleF5JPfaw+8Ci7qIdiHYpYgCl9/QsghfgHpnfmJ/xC+/aAnP92RP6ZAE?=
 =?us-ascii?Q?ztYcX3YlqkeXEOClnpR0ytsa4GQ7EhRqhWE/LQavtnxg4gSGro7oMQZT+5aB?=
 =?us-ascii?Q?RK476pqqJo30cdLvl+yJd3Bb0Q4dXKEd+5v6se8vMW3j6OUfE6wVX/mX/0bx?=
 =?us-ascii?Q?lRdNTkPhyhlOglSD1xq6DQJV5Tz73w/rxH133kkToBWI7Vp5toUpYaARCmXc?=
 =?us-ascii?Q?Wbvff45/uoyumVFOiKcJLeOxTNVZ8/KldiAG9/ljizrdqt2WHFAeK8uGbKwC?=
 =?us-ascii?Q?d6LYigp6By6UjfjHW+aYM+lDquecbjAKJKC9Ii+KWxshgJWWH8bELb34YnK9?=
 =?us-ascii?Q?lW+LgWxyC+9N+AH22oxaFQFkxVXUmbKhMcWG1K0iQ/OO/lqbn4Ni/jim13oL?=
 =?us-ascii?Q?mEZgwrovxUkDC81Grg+054V2HIzCNydJsUeHy1V8kCm3H02cHcDzhNlwaswp?=
 =?us-ascii?Q?A7Y5sH5geS1wvvVuz/vW7cfuNAT92sw+BCAe/DF7LfSQEMb/0YE3WBAqeKKK?=
 =?us-ascii?Q?mW9jkHTNWK++AKDQn8SbPAs4XAby7vVGpJacpJZtH8XBVorICvFmDXnVtBzz?=
 =?us-ascii?Q?/p6d14Gz9QNUt82xYQDCA5pXmG/C4Vx4/dLoS2D1ecnh0gbMsX72W3HBWDiB?=
 =?us-ascii?Q?7cVBInAhaRiR9fzSF23LIxCvMfMpd2ZBmC08Q7NnNmYBlw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b87d95-264f-43d7-aa3a-08d98900b367
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 19:37:15.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+ZPHMaodlDAdo/2ZooEUYomaEDjuqZkCjRbMPE9DilAfWSFkvRQCVzCKzTOYLMY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 05, 2021 at 08:58:09PM -0500, Bob Pearson wrote:
> Currently the rdma_rxe driver and its user space provider exchange
> addressing information for UD sends by having the provider compute an
> address vector (AV) and send it with each WQE. This is not the way
> that the RDMA verbs API was intended to operate.
> 
> This series of patches modifies the way UD send WQEs work by exchanging
> an index identifying the AH replacing the 88 byte AV by a 4 byte AH
> index. In order to not break compatibility with the existing API the
> rdma_rxe driver will recognise when an older version of the provider
> is not sending an index (i.e. it is 0) and will use the AV instead.
> 
> This series of patches is identical to the previous version
> but rebased to 5.15.0-rc2+. It applies cleanly to
> 
>     commit: d30ef6d5c013c19e907f2a3a3d6eee04fcd3de0d (for-next)
> 
> v5:
>   Rebase to 5.15.0-rc2+

This is not the right base, I said you needed something path Rao's
patch like current rdma for-next since it gets conflicts:

Applying: RDMA/rxe: Move AV from rxe_send_wqe to rxe_send_wr
Applying: RDMA/rxe: Change AH objects to indexed
Using index info to reconstruct a base tree...
M	drivers/infiniband/sw/rxe/rxe_param.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/infiniband/sw/rxe/rxe_param.h
CONFLICT (content): Merge conflict in drivers/infiniband/sw/rxe/rxe_param.h
error: Failed to merge in the changes.
Patch failed at 0002 RDMA/rxe: Change AH objects to indexed
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Try again

Jason
