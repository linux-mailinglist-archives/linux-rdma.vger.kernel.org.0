Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9A49FE9E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 18:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiA1RFU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 12:05:20 -0500
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:23520
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350271AbiA1RFT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 12:05:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEsInna54KZJIKWz0ffmHG0QQKABONUC30fk3T52t03jGI2kBykkWqxcxvNo/UKCMKATq+M9V8qnp1kBgGqTiS6q9twdBwqxOHbD+eOooKl+VtcN18KPbt5RGSuBNUSLa1yRYyLlIz7WTEvfiZ63OK/0JYWXzUpGATS3XRqT6qQyA5EpqiYxDP482QUJkA/25/K6Flx3ANHVK32v/Mb48JiPYfq78p5ultgs/KsxZBcAZGJHwZXLR+8KfBOlUmTIlQrTbIuxU/qbzrGPh9pxXMwKYeD1vfobWZaz12FInKc8YdCZW/HbLCd7ktRo7Fq3KhYofJaoZQhQ9IWHV8RINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcYwWB26iTQe4wGP3OniAVDwzyc6yVgAZuVGyPrlZ0o=;
 b=hHhKXM+gzcdBg+Ls4vA1Ro0UIrCjcHFjQKI0OXM2e4ORNk0arFYO8kyOu6JmZh86VembinhYjpMoOPBxm/ajn2flDapeXetjLoPJDTHC1mOCKbFnBfcv7gpUaShvz2ylGvnrNKIFz5KeMbrLgpjx8O1W6UVH6p64xGJGck6u23PepDGYmRld1eTSGcu4H/98r6BrkBNHppKJZi0U/e2/WjJRJLlNUU+SthREoMVZXY2ZAjK9UTFDrHLOggasH21vZ5DaTyMvXQaNMn2XicCgWw6hcjmFn+9NB1FxsWUqJggbv00BZsyyprUZRxmG4B+09aTD5+YWOHS4ibfDfFtSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcYwWB26iTQe4wGP3OniAVDwzyc6yVgAZuVGyPrlZ0o=;
 b=LhIv8zNRz6TNy7POwVleoUwkC1ZVkmhZAC0lwSMCkGbtq2zk1IOnSKTFR/szIVfmRIcc5EOAL9ocorXRWiEZs/NCfKpOUkeoDxtYDVjAz2I3+aa/zJOTBntbxoeZbWneijcoApvzzIAvl1rbRuNsL3s0EEDtRpfi1g7lXJoaTPHbIzNKDfyScDZ1v4sAroHPbprg2UXHppxh9fKBYEOQO0hW4H9VbJLFbibbew90vURULqcJaJH81DQWYlUG0q8aZ5GKJQm2Fv9+Msg4Y6a4EZsvqzFdeoxKyiEBsh2ZNfQhUVUyKEW+F3BLY6lbApqTa6hNabp3Ze13Wcrp6BXycw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2776.namprd12.prod.outlook.com (2603:10b6:a03:67::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Fri, 28 Jan
 2022 17:05:18 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 17:05:18 +0000
Date:   Fri, 28 Jan 2022 13:05:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Delete get_num_static_uars function
Message-ID: <20220128170516.GA1884437@nvidia.com>
References: <11d78568c3c6ba588ee8465e0d10d96145fc825c.1642960830.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d78568c3c6ba588ee8465e0d10d96145fc825c.1642960830.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0396.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36b1a5a8-f551-441d-9fa8-08d9e2805c32
X-MS-TrafficTypeDiagnostic: BYAPR12MB2776:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB277696DE57A41FB32636E6DAC2229@BYAPR12MB2776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yL9Nwh1orRMcPOgqJ/BnwJPjw1vx+v5jxhZhsnb8DvUGpAVKWCW3ZQTH6nKaLVRPVuTiOsNn/FuPri936I/BsKXLCzi85c0Oi/ZMFbhpeKqkNKkWZaQ4cq828HAZbWv2n+rgONEZE3WpQArzQ/QIG1VcS+beBTt9aJsCtbzAkA3zIiT4rGVNERiWvf6AZBfV8FOe5b2w8bmwXfXVeDYmBnPiQb42l43U2hiQaiT2DTmJXrSGp2rEAJ8nFJRi/qiKH16+FOxgv5z/nuqVFeWOeYiDONvvDk/172lo0qghwjdoNWOE18RaEkdUxAp+PYFY8If+xRGofetY68LoKeXzPg5vrLYGXUB/coz4FPTDWXWjVqEaLALmb/i4Pitsbha9Q4Fj1RSX0kmOD/j1vfCRrfViJMnJFR1ojT5vMw2jCW/Jb0wVVvkIZ5J/oHH1apjGe0ey4wPsLVsZVey1Svl4Yhogdamf9pujO+iVY3h2ccbLPu+SMlzaekPOW8Phs6WKt8C1Ak5k2w9jHpsQcql2Q0sIeEiLDrG80TgS7PDsjnSPQbHf6Ti4zCs4/WbQkT46ETZz/DiKMAdy6rEBo11f35yJw/bTmXzxjirU91LIECmRGHl+pK6QNXT9MOSeEtEfse1M4p4IlD3/hqEqU4jYQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6506007)(5660300002)(4326008)(6512007)(8676002)(2616005)(38100700002)(83380400001)(4744005)(66476007)(508600001)(6486002)(33656002)(26005)(86362001)(66946007)(1076003)(2906002)(186003)(8936002)(66556008)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yD/NrFe+23Uufieu9sIA4O3KhiMP1fX6LJ58LVzkePT901dXQbuIIz/jrjIk?=
 =?us-ascii?Q?HvtrsQXNdvEfMwEbCoOsjFxrvet7q2NTQwGv5VSWX4QHSJIOW1s5OZUe6pl6?=
 =?us-ascii?Q?VqCLdGRDMS8FzAm3nreOEZUf7JkuLUdF8JvvnoqNKlma01oHRDr+Bj3zmjPd?=
 =?us-ascii?Q?v873rDSaOO1PqT5YYt6zPFD4zUOmhvesQB478X/nTdQ71BYE6yRFmgzwSfo8?=
 =?us-ascii?Q?nItFFfRKgSzHDDpmj9LQB15fm5rI7KYhU6EWCaQgt70LNHlfc2BFeUrjMLPK?=
 =?us-ascii?Q?mwJ7CXHTgSd+YCQjTLECH77Scsj41VlC64m3Nw6+US7z+iYjxztFbcURED6y?=
 =?us-ascii?Q?DoLDtQiJNwcActJGJ4MiUHQx/tTKOB6OlRoakvfg8r6FcCQlEx5k8SMLy+8k?=
 =?us-ascii?Q?VWSylovFiFMTCHRGVEMPrFIx/wsLlMhrYKN+lCmng8Bx5+cwVRwUFSg1RjLE?=
 =?us-ascii?Q?lhgcXXUlkMCQCrKZUPmZ6c8L8A6j961a336MhgKd4JCPQ5NB/pYgwzBTaWLa?=
 =?us-ascii?Q?ZqUnMRm2MMhrSvtKfA1SpXUwzdflgaFwsNJLdENvzFLmQ0K2oov4ntvj7BXt?=
 =?us-ascii?Q?RRjzw+QU+juCn79hpLkXyoSpNev1rfxmEYNKXy1fohBeTJqjTL8bsRgymbfa?=
 =?us-ascii?Q?KZrYBQ73UEyzxalQfIDvGWs9zkZVQJ0c1USkTUBtOwW4Bskf1+EBJ2IafL47?=
 =?us-ascii?Q?cG6OjyCDq1763KdAWAlQL6wJ86inKXohgu3vy4mEZzgQE4vJoGSII2XGmSHU?=
 =?us-ascii?Q?f6cYyhSxP5wNdRN9pmY3VeSBu3W5EdZR02d/nVOzUnPbu4ZRHEQn4AztgYVh?=
 =?us-ascii?Q?509FL1iWzzrdZ7uTGOQZuxXgTyqhszMlSz2Dq4JWR2pCH1XRGWQJ4OwmZ5xC?=
 =?us-ascii?Q?x5P1Nkrs0lKbRnP/14gcjPSLIQfYi5TKTIhsULGN9wH6ucvQoIhOz9p8LuCw?=
 =?us-ascii?Q?S9tLq86khFKEwPaalEw/cZgst+kOPs5crkp2w/Fhdh3gZzGHd+jx0IDGnHIb?=
 =?us-ascii?Q?8wnqho88GVwb3TygvmSiKkPluql5yDXFYnv4NP8rZhOBd2JPeOGeYtcOsriK?=
 =?us-ascii?Q?D4edFFgFz4qVlmdKOy/DyYC2eN7KYGCtCyfDD5d3PxarImoKTT8xXNlgYA3F?=
 =?us-ascii?Q?ma9Au79gMQYMJJ0iABmj3Gm9lha+Wowv6WVoqHBh3baDI+IrWPypVYwDqsZG?=
 =?us-ascii?Q?UBN6a1l00vQKeSvyT3elW+JIhN/doqQAfczmM7/zNiDswHMk/OIB3XC1rho5?=
 =?us-ascii?Q?oOiE1ZN4ZXrsdOao5EZFB3AiSuhzpBWY8BZNjc4VPyNP8enVr+Pm2PM5mCLi?=
 =?us-ascii?Q?hFNteejFwVqXS+Xspx8FxL1Z3iKvTKMjuV2rcJqMrwqMkc5WaJPxRkdwWR+p?=
 =?us-ascii?Q?yMdztBVgtRfDr68qF8I6Z2WNlEaSc4OJgu26T11/aHEgTd4ygyHl+eUCkjys?=
 =?us-ascii?Q?aGvsoVvVrjPd7tssbV3do7Cis7Ki4rCu5haffe946QHJXmYIaqCFeV7se1l8?=
 =?us-ascii?Q?XAqFV758i7BoTSem1BrB3xS6VXYNVrV6UjOV4dHQ05L+Sythpbxfq9eAolHr?=
 =?us-ascii?Q?9lhq2UfL+aUv6Q9w/2w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b1a5a8-f551-441d-9fa8-08d9e2805c32
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:05:18.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phPkoFdVHZJLPO1c6ILk2wf9nhFGX6jmI9lGeiv7mu5lBkRRIT6TR2islFukTQ4l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 23, 2022 at 08:00:48PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> There is no need to keep get_num_static_uars in the headers file
> as it is not shared and used only once.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 6 ------
>  drivers/infiniband/hw/mlx5/qp.c      | 3 ++-
>  2 files changed, 2 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason
