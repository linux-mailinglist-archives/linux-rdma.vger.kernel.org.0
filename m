Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E825843A309
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 21:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhJYTzp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 15:55:45 -0400
Received: from mail-dm3nam07on2052.outbound.protection.outlook.com ([40.107.95.52]:38624
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237774AbhJYTvX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 15:51:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXLCOs8etrmGH43+OrA8Aeo0zpUJq4yM/r5+z5qFueCosLM5dVpZJVuA/IXdxEzDdvP2sN7UuRqheHJd6Y+Q2SOG6iTu8lSxc/3+iYS5t4UVL4WbfyEf8YRmRz4XUUAUmD1xh2En2zDztTpnTKFYDvv/7yWm1OZdkdZu4LXg6V7FMbzfmARt2rAwEYg9v/6ab4BtVRHXQsHYne9PsUZVPgUxII8OMla3M/si5RKGsgvVg5cUn2VCs1Dj5NOEbcdBr7seUyCdOuKQYrt6KEyCNNwtcW41HTm/e4dxMzO0ek/8ihiQBZfTdujojDsM13VpFpZAgJnOHn4yB2XEzsRNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5d368Fw+juyPleHkiiQMF9MPSetgfPCAekjJSjm+eI=;
 b=CGa8JrzcLdfdxD5phtBwrBWD6qKcim9i0fTaGA1pEhqouxvCEc5b799XNqBGn1rptJPuAbLWqmMFbLp9D9GCZyL97VRN//aRRD24iLvhgAWxB4w9Ue+OPyjj/+zy95nfY9vs2TEF4O23rRlxGnxbuw2h9iRmmGDrF7FFqeLeATczT4G42depFPB/EEYMMyQiWDPPRxwGYYdSJCUYUlSFleB8NGr6Cj17Wjemw94L4Cii2fj2Wnek7mjAOuyFdWQguud8xXhxH5BZtCRk8m/vKaomhvy4LKTsP9VMxTU8yQO4DQ/esIHdkh2myo9rxUvIpYQyqH6hvkXZoci7IqBG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5d368Fw+juyPleHkiiQMF9MPSetgfPCAekjJSjm+eI=;
 b=ImG/uJncfTBFCSVM27G70Qt2kHua9iMC5uYai9rlWudJS8Lj7HMeuovHTCzZf9AoZf6X4AWzIuHLOAv/TpfXlrkzMM3LxrHOF/BRopoVRs37Rn66nP8NPeLmnvoHD3NFcnwFR1ddH5gw1Kf+HmXZZVJX9Kusfn3OMbjiItk6EvSB9K2Sr91jFPbpPCfnxun926XcSfsdsX5SI3D4xuS5qPSDvLqSjOSnDZ7AH351raQbwnOqRK1/uMXDGeVuIIglTLvPTk4FYgO+DPxlz78Bl4pfGgaqcstRk1SgENQQlFgGpZDeb1C9LNQLM7NiHQ+ke1Suqvf27w1LedUUytiIvA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 19:48:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 19:48:54 +0000
Date:   Mon, 25 Oct 2021 16:48:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/qedr: Remove unsupported qedr_resize_cq
 callback
Message-ID: <20211025194851.GA447503@nvidia.com>
References: <20211025062632.3960-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025062632.3960-1-kamalheib1@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Mon, 25 Oct 2021 19:48:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf5xj-001sQV-OH; Mon, 25 Oct 2021 16:48:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beb60a71-f7fb-4713-7893-08d997f07993
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5301CBB30CF8F563AE54125EC2839@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsHKLg2nvi49l/bbxbAM+tHgikd4seZ+sUbIvcIHw/5pXGrJ5NAD8Gi9goB4BiHcg+ji6jTCoYAoQkLtXHOec2T+w7zsjCSLg5204xY/q1ZbTKPd7soMal+PCiLIg43gpJbJoa6Bg0tqyFtNGS39aeFo5kBfZxjqDfZ981E0YquXC+IRocSWWvvglXlbiOXSiZqwwx8Kz0E7CbVuF+NasAnQbDZK1+kWMQ2loGwpknUhwmi2yHRxSBsNiEeGw0804Y652I9qFxDaAaR2KZZg/MJY5PhFaWLvEFDVVz4rpTC68Q0g43xetXhrfHmpUec1t/yHl2r17syUOckETLpVlXkuK0S870aHmJoumqHjGK+jrJ5EcZFjaXs4qFsNkUwhFMNANFjhHMZ6924vtJupC1Ei0/qsxOpot/nC4R5sGDlAZ0SKjn7wrkSL+38NEAvwRGc73yhEMDrZ7kWtTFq3JKn3mZEw0yHc/2IU7nJTVSPL2505JB4JwHLT1YbJzrFKLWzqFVaFK0KUPxubtssyc4ZJ2nnEGi2SFfVK2+6GP1wvTZHCLcmUtE98BXXves3FnE+kyuJBtbQevFj2jirH4KtepLsAYT6izSeXs78kXdUs7pPAYGNe4Xp6Z4kEuB7JCaXDo6ZQGb5rh8ApRXlHcoTRK0kagEL2SJdJ+4cINr8scLIvmz29J/9zDr7qH9CVuYWEE37n25NTAjuXcK3CMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(9746002)(83380400001)(2906002)(426003)(6916009)(9786002)(186003)(4744005)(508600001)(1076003)(33656002)(66946007)(86362001)(66556008)(2616005)(66476007)(8936002)(8676002)(36756003)(54906003)(5660300002)(316002)(4326008)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uu8fiHEhjmF2l3yX/vCw0wvVr5S6bYc2+MCP2gpgqgcj8fPrNAnIFeL+IklI?=
 =?us-ascii?Q?exL9ZcH9ka5VHOUFvU+1Si5xLqwhPuM0c0Fo57S6O0UosT7uDqe+C+4FynxS?=
 =?us-ascii?Q?1OHtJm8Rs8M+1HhZ8MRR6nHJJCzUotATRsesaORZvbocW4cnasyRLTOrGKhT?=
 =?us-ascii?Q?HbCgeGhL7tv9Rq7QYc5eL21ExNDOlsSMG21M1VqdaL6x2Pfu51BTBO+6abV2?=
 =?us-ascii?Q?tKx/gr5ju81T6bqA1CfZ2Nc704ArihgRxjeLClN13G+sHOZjOc8zM4li9Srh?=
 =?us-ascii?Q?/M/il0m0L5BPtNsPwboW5NQx4+1HvtMOm8MwPPhZEaAl+TfPgLAlpFsDgsF4?=
 =?us-ascii?Q?0QtN/t9R5meFcmhgYL95Oyx8N+HhD9Z9aYtSOEypHbVLzoM0djTRn7ACeJjE?=
 =?us-ascii?Q?pDxJQFBDAFbQyZq4ypAo4BPDK+Qe166W60kYRYU4ln+r5lpoFCNwqOBgG5Pn?=
 =?us-ascii?Q?s8earBXW/ow9d5su9oVZw/0yB4FYlpTFtgyypaOPTvDfMORUoVXGYf9X+agY?=
 =?us-ascii?Q?U+PjNCGe/LOYKMYDOPVpvaWIqXBDa7CwLK6fveBUU9kBt0TefRaf3EvN2ynC?=
 =?us-ascii?Q?E7g4tteM+0iEvBHWxYytdtSZ4AaeMDSwNgi6EiT8CiGE867PYtrSodPpNd4A?=
 =?us-ascii?Q?k+ooPxllfkxKB5DjyCUy9GeNjp9zGiGUe+H0Hy9UldsdJ5KGGc1y0jt8nj9p?=
 =?us-ascii?Q?cSRcr9aebG7tOs4sDmwB5lGo2MF7EPuwuAdDd7hzGmw5yf8qYIjC8TWbm/DW?=
 =?us-ascii?Q?6Q2dbjMrkOnmdauNfoK435e4AK4Nhrr2OPiHUcFFlLCTrZF1H+rlRLFexPHM?=
 =?us-ascii?Q?O/2FsAfBpnTQ5LSqmyFRqyM1ItfhRJX/IzZ9lhl9v+hjZ2bRnGET5prxyOLa?=
 =?us-ascii?Q?6y5eGIe47grHLqgKeY8x4NF2xHljyrgaZbaGqvHR9maX9w4voJvKThFA5Gj4?=
 =?us-ascii?Q?9saBgbVUWfNw92qHyWb+HRHXw1EMKrP2A8JjH1inzf8dCPvSW7Q9NXteXuVS?=
 =?us-ascii?Q?dUFlsRXp1Ss+HEUc2MXFjQwUFD2wu3vE+/fBhWPDjGdbjAcv90s1IV9AS+SM?=
 =?us-ascii?Q?bWsukcsxbKlCVn9/UtWGyoXzSeIR2YF8uI/YyLYdnpmtEGTSUxRtIUnXZFNx?=
 =?us-ascii?Q?dZ/6+4wH0dCJPYcNjeqBL1qAmdfqAMyOSyMWvFzrraBEooTcBnxbPe+VHSJ3?=
 =?us-ascii?Q?vTcAlsYXrCy7CMI0BwrpjkBt8QxY+zq4F/eRwCifCLNu+8my5Q3Lv/M+2LO1?=
 =?us-ascii?Q?MouNnluA1kKeDkNYBKcVxwRVocrGh3jBrz+PBUt4aMY1agUaNcW0yNhg2Q4c?=
 =?us-ascii?Q?baRzb5EvNNfqMFaiqJCcwkB1rO0te+BE6e3ll5R7rKsBf2pGkuTh7jnIrkRx?=
 =?us-ascii?Q?IF6/NxJlePIKdpRfnqzDeGJSb9WqKZ4z4f4+zs7D+R/gJcnkLpMpo3+Sek5s?=
 =?us-ascii?Q?aItfyXCVTeqaTRKicQsljhWaiuO5VzloiaMdt/996MzD45K2aH3gbC2NqYfP?=
 =?us-ascii?Q?p4ugmbHXrzjfvB7a7Vsk06plYOFO7T5yGl6T5ABtyIEGX1R80R/dLrPvD4Zs?=
 =?us-ascii?Q?ClQe3HXMKCNzQChGJDQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb60a71-f7fb-4713-7893-08d997f07993
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 19:48:54.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2cY4vc2Q+OCufDeqTau0CoFRUTjvObmn/wBIwmkv7CVUoSvNkFwOquW4is5AZXR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 09:26:32AM +0300, Kamal Heib wrote:
> There is no need to return always zero for function which is not
> supported.
> 
> Fixes: a7efd7773e31 ("qedr: Add support for PD,PKEY and CQ verbs")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/main.c  |  1 -
>  drivers/infiniband/hw/qedr/verbs.c | 10 ----------
>  drivers/infiniband/hw/qedr/verbs.h |  1 -
>  3 files changed, 12 deletions(-)

Applied to for-next, thanks

Jason
