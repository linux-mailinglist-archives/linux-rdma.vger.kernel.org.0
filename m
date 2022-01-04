Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAED0483960
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 01:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiADAIO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 19:08:14 -0500
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:5985
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbiADAIN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Jan 2022 19:08:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYXZ6xEZLj3IPCIcLv9BWJ1Vx0SvYEHMdtbFYPKqRUjpnbgqtj2uJs2AON4jECheeXv2sBdCRW4gNu8IeGW44NuFTiK3qtEp3vYYQer9c09aTdSsPVbto5VgdDN0EiihC6WMJVHetvN/rzRgZqyPyNgn6YzTj+DsnW2jjNgf5DDGQtUA6Fz9UOzGZ1pr0RuGbbs4Sd+D8nBwO/tyZignqOkV3agoQNnMb32yAhJJYo9aITrihkXKu02P4vdo3JCchfSDdzkk8iIvkWMiwUMud9oHdqacetQuFqzU9DY/ldPVpl67AxbCHYGKN7mvs3A4bPgWumAyvGm0oFIeYBAgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yz/2Sc/yGiQa8a5M23t4zcH5+HGzZMi+pjTckMGJZGQ=;
 b=dljQRqLXSmOK5sYh2oBDU6j/i6MWb3hXpVaSRD2neIQOQSzWIRAktUdsQyVPr/v3haNMTl7CbKHTUG8akOZAqWFc7XGX+D3gFH3lrTk4lJYv2y18JQIvBT52Ed6ZYSMbfIATiC4yIFhVDmoQX1JhUiDfbCXbdH2g6usvFR+zI5N/yzhXCXCMIiTRhqfBd3/zsfMCjQJ/xpqI56nEYTcQ7nI6SNOAwxfShfS7vLz5TcQJyOiAtx08zXAH0V1VDVdIWyN8AdqbYSvnRkPJPKFBjivigPA3/J8A6s+RbN2WzahzQJCF5mgSuHtdrcw0Zun4Q4lMsbEB0TAa/4G7D4F3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz/2Sc/yGiQa8a5M23t4zcH5+HGzZMi+pjTckMGJZGQ=;
 b=Vw4o2BhvXOyJ8aQT1O64bR6ZN/HEDe+ctBM6xKspHsGRBYXxEOyXx5FKeh+lA7jn5cXmhYlGSH71CpCtsrZ1HG0o47GeKjC6TAnVdx+Ku1ZDcD3w0G+cG/XQ/vEMTGRKCamKEC4MBN/21OvCwba1sLHt/bRsTQjcVxnqszRATfgQUbiam1V1InIW1ADHwS0TxpCWoLaL9LYnIq0Il4H1qPRC1bOJe9x87m/hiOv9BAGPpMCyyOY3j1n8gw7IPe90GUwQFrZ32iYaJ/2yjYGQ3fumqqP5EESOsVkjsiLplkWF832aFZ3MF6WKhO+U9SzHs/rLglpsgPrfGCMyisRKWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 00:08:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 00:08:12 +0000
Date:   Mon, 3 Jan 2022 20:08:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Alaa Hleihel <alaa@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix dereg mr flow for kernel MRs
Message-ID: <20220104000811.GA2596382@nvidia.com>
References: <f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com>
 <YcKSzszT/zw2ECjh@TonyMac-Alibaba>
 <YdLHDzmNXlqSMj/A@unreal>
 <0d897f0a-6671-bb78-21d5-e475d1db29b9@leemhuis.info>
 <YdM/0EUd3S4obWWa@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdM/0EUd3S4obWWa@unreal>
X-ClientProxiedBy: BL1PR13CA0264.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e63d70b3-6501-45fd-fa8c-08d9cf164bfb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5272C813CA05652BF9DA75EBC24A9@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYhdK+WOOHD7ozNo4MteFgx00AXvFfZvwP9o0w6desb+iQi9XpHADzKDGccbb4K6oZJRO7lfzezdlfQ0Q795SJaUbkqq0whq1lFLNJ1arn85r0GebY26QjGjx2WeLP3KP4F2EZ33y+sQDY1Bml4r5/1THP3eoVqVrOD4SfDu6EGttZ5RdeCHMaaOpt3ANVuqG7KyavZFAI5GFPaRhN7v6OYwuzXGcD6966/dDCVEeSdYMsJ2XGcfikZWKcSYSyNuAdlU4G8fo9PV2T2TwjxSjtSuB+iWQw6t22H29xBJSbbae7ZWR9V+Mgo0BLVBpB3f6YZfir53qvoOETdkwTUdKVvbSyfZcEpXG1NZc9MPBXUBbD79fIlOGkbzJIe3HB7y5NFK7k1lrWguch+SUa0DsVxSCRr3cxPczq8Vsoplno+/d0icCsGFJmfMiTWSA07nLtY5TOj1ohRGW6WGVuKpVC+CtX6be4gu5mqXH+rrcr+TKFxcTySOKoXWqNIBmYk1Tdhnxt7QCFKEoq9STETME+k1z9M7yS69T0hPAZ10TC7aX+tl7xRD2RBpaOzWBLGPP2uEZ1MouhJoy8ViHiK/9QUdbm/i2VwOeEvAZJfUi+dZHrwg4qwU9i0sWrgxYDEQv4SRXwVVwrOp76OC9JKJLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(83380400001)(8676002)(6486002)(316002)(26005)(2616005)(5660300002)(38100700002)(66946007)(4326008)(33656002)(186003)(6916009)(54906003)(6512007)(36756003)(8936002)(1076003)(66556008)(86362001)(66476007)(2906002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3k68E1v1oIrENaZB3iYer3j23zbYUYdPjmO/rXrbe3VUdXWvXw/2UIx04GvE?=
 =?us-ascii?Q?eHOqUOHUlpcmSTL4jPA/meui3Q5bdseSFVRNITtYUwLlbbuWQDV2aKwBt8Yn?=
 =?us-ascii?Q?01s0rB1TPnGhZu2tEyN91F7nvu/Txhe7toa+vbP2IRWGflqLvzY9nFgE5ZAk?=
 =?us-ascii?Q?aHEBcifGZJEvfPqTSPDS1M7UzOF8MQ5f/5HVT99c5nFAaPSwG6ttXBGA+YiG?=
 =?us-ascii?Q?03ETGbd3CSMIoEKL2UFbiTpP30172rw960YUxU2Ver6fvoEFXXgZagk2ThZO?=
 =?us-ascii?Q?1PkjYL5tEYRzJO5LwSVL0N7HrMt+b+WbW0gQdwwiC02ypx9WECXgtB/DNAqn?=
 =?us-ascii?Q?ymU2f3UaF3VKCQQmtBzu6v7UL0ETEActX8GQH+HDBXhPQshoW/Ooo0oYmh5+?=
 =?us-ascii?Q?5h/bx05CZJ7qhnzuR081VGJ3cgvqYH8PQv3Rkd6UYo0g0/HPb0gM6nVyC8kQ?=
 =?us-ascii?Q?eYvqJ2WJdn5J9XQEfFglZ3fwUd1sNyA/VY85LbY+GNzgLMgDl39GRJ467cah?=
 =?us-ascii?Q?g+igww0MzRZu1iE7y91vZhkhO9svXmkCXoT5XReE2dh34no8h6iEfSGJwI+u?=
 =?us-ascii?Q?4MQ4Cb0P+R2ZzxBqp1hkV5p5uZKShdyTjq1HlPWVn+FiPN3f5veSlB9IC7Sp?=
 =?us-ascii?Q?GKAvLM2z6FHGvG4O+hPSlsi/TzN1ra4JBBH8CEKN+3WtKffQ5kqSaD00C4LQ?=
 =?us-ascii?Q?GlzbxPZ5BY71f3E6mXYXGOTCTLFI2smNzwtOKO9/ogpXq5bQz+zoGt0SHyEi?=
 =?us-ascii?Q?uXTaxu8fTEocoPQLwTFvA+F5zbGYBcWukLKeozS+Kw673tSmEAUN+IPxq6ci?=
 =?us-ascii?Q?Knz9rzT9UbKWbXGHLyxNx4ixFOJjMR7B5d7szfWV18nX6WNp6PPtqZqJYBu8?=
 =?us-ascii?Q?NsbB6xsw+gSGnezZYn7UiXKqPO3CCrqeQ7r1vGs2mp+A2WauQJG+ekrpKTT2?=
 =?us-ascii?Q?vmsiWqpg3S58tJjKiuzSJ7FRItBr/H3eX9kPnuGAA2yCLaNedeh5EpQdjRzw?=
 =?us-ascii?Q?yQ4BNQwj+CGUYkkUyEfFO+9PNS66PLovVQNVwsTQwX2VWq7QtdVLQdG7ZL+m?=
 =?us-ascii?Q?5ldOT31KZNI9Nv23NSfwoZlKsnvmJD9eNLdwK1qByewbUyGGaD0tLllTPZ7y?=
 =?us-ascii?Q?TLddWutNuqNFFx4f8Vt3j6uuOikYti47fFGsQNoxNQRGjO0dAYTlC5qUKbHA?=
 =?us-ascii?Q?R0PmqVxnxj7028fcXfeVvCO2iBhgTDpU36miCoU/9duWvdprTrF3TgH7B41J?=
 =?us-ascii?Q?7Ly/6BzyR465EM9+ZXRd/B3pSq7niJrJMGhrpc1CHKTPVfp3fiBLO59nbVC/?=
 =?us-ascii?Q?ILz7803urFpqovkUbV9rOrEyBASvutslDFJTwqQMlWxpE1h15GlxfaOHq9ix?=
 =?us-ascii?Q?3moXLu/G9xSkgmEAyT9fBunHkWwBDIeZikymo5CUuWqiR8rPG1xadezczusM?=
 =?us-ascii?Q?gob4AR89UCDI3EDcvhbinP3P5Nyd105VJ1cWUFxh7AHT5+lRBShAflEuH9w6?=
 =?us-ascii?Q?hJ3x43MlDrI+dTwuljrCDh09ttw6mmbLxy4H7hCW7o898bfF6NoV7lRFE5h6?=
 =?us-ascii?Q?J/41H/Ajq2vzUkMYJdQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63d70b3-6501-45fd-fa8c-08d9cf164bfb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 00:08:12.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AxvudbtHAGQmxNXVxPVNIpUXfU6TsugjBS0bhoctg0YnTbx6pfQvJM3RWMmnC1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 03, 2022 at 08:26:24PM +0200, Leon Romanovsky wrote:

> The proposals are:
> 1. Return back to v1, which had dummy umem, so so DM memory regions will
> behave as regular user created verbs object.
> 2. Add extra flag to is_user/is_kernel for mlx5 mr struct and update all
> paths to rely on that flag.
> 3. Create separate dereg MR function that will treat DM differently.

It is not DM that is the problem, ti is that user and kernel has been
mixed together in this mess despite being completely different.

I've been slowly disentangling them and the series you just sent 'MR
cache enhancment' removes the last blocker from completely giving
kernel MRs their own struct.

So, the solution here is to move in the direction of making the kernel
MRs different. There is only one place that destroys a kernel MR, just
have it call a special 'destroy kernel MR' function that doesn't touch
any umem stuff at all. Remove the kernel-only parts entirely from the
current function.

After Aharon's series we can give them different types. Notice the
union is already completely disjoint except for the little bit
tracking the cache which evaporates once the cache only stores the
mkey # and not the struct memory.

Jason
