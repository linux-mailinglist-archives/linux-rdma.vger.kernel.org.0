Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF54A0045
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbiA1SmF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 13:42:05 -0500
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:7392
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350580AbiA1SmD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 13:42:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I950wTIXyAHy3FDHbXwi9OJPggqNne+M5WLYjpzvdA0qnyBziXzmi94IS20ORnSFbh0JP+ygyOEk80Ev8ca2yVYmBVdjLx8wAstE3MeQrbQwFpjRkp9rl9+3Nd3hLkfGlOj4wwK7sPrnVPQItgj9j/5yfWS8XiUN2gWHTvbR6yuC4iKGjKuUkSjRFhglU9srMJmhyjss5aYrSrEsM5YPcPfRWdi2HDRFxBm9CS4+dux6xgZxn1ZFyAa8G0i9yo8lhZR/8f/STBag/oJTHFmWvjfIz9dbauAo4+6plWPRlHXe/AkubKdAPZxFYNZR76g+eKdoL9uetfUMZQuujCvu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3pt5xEPjZlnwSRcXBpWVxsA1/D3jn/hmBrJxst/R/Q=;
 b=ktY7ji6g3g7J0j9+CrFfMbvRX4kzmzI93nE0POdWIgn7/5ujC7JjtrD8L0xnjscqZ8ypVV2qYomKIPFI4a3GmCdkH62ulTXQjX52gehMDRYER1tqa94QG2JIplrdpJGNaw15QLDjU4LLCAkjITgDXwOsE/nAIlgs8sfjqqYmzdZ1DrhsGPvE4wBvmtx9fNBnRn3DAO4VO7UZlCinXAYNmYFDExtNAbDloGa5VGjH9+uOoGf2xYdn9uSDciDjCb0LgYZDS+P9ot5d+tj+gcj4e/WmyAmSmXoz7oXtUNfVo/WBueS1Q2m3/Zf2c6DC67euXsfyA4hq9cVxLGUMKjZjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3pt5xEPjZlnwSRcXBpWVxsA1/D3jn/hmBrJxst/R/Q=;
 b=i4rVpRy8n3Evdugs9UMPDp/N7OmC96yjmSzgs/YjtVkXoHjpX7gZ5bqfYUCH8EX4u2VAZwC4YY27F/OfeC8kyWafe1T8hnMfJnjGmYJGXy+1uSqZ8+0AzSQaRKrHuw96vsso351yLDOLdMuamc/ZJYsgthiWqXuHfccgqM31uGimfSVAaED1Oazdd6TDYYsQIhS0OpmKA/O+JWHe/k9rCJNVIoaU47qENwF2buxiyyYfZ7M8wAdJyFwBRjNTRpiHA2o9JzBYr5wC+9dJkymlrN5N5IMWjsXDPY7KdsTn3UVg0PneDfAqIfEDaXt+s4fPcJlubjYegnUq8T58hU0EDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 18:42:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 18:42:02 +0000
Date:   Fri, 28 Jan 2022 14:42:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v9 00/26]
Message-ID: <20220128184200.GH1786498@nvidia.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:208:23d::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b644e264-d751-42d4-1ab8-08d9e28ddf93
X-MS-TrafficTypeDiagnostic: MW3PR12MB4492:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4492828EDE44EDD1CB21C3BBC2229@MW3PR12MB4492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+5EXDzU/C7fw7mlrkEgRstM+pW4pythiM6B0/tWd01AGDzXde7rBsW7GeUpwFKGtKyX8pp0uIi4TeHqSUIMNqQ/ntUchegMPPrNsufewk/zGP7YM3pKhEHLdM3W7bXWud9Ti/Zt+otjJBfDMXPC/4hoWo2mamnyy/SCaTqHI/Arq5dEykxeZBUDx+8ZH72U5KRi7YdvZ7n26YKb2p0+AEcJU/srJ2zP8457zWnoAswWzscXpHYs+Nl+T+2uqvEBbYSvmSBsIAIxTGV00Doq+vFkzumV5eJFPjxs3H/aX+k12+MPgAcb1zllzP7edkXhoQH/9/VTwGTbhCkip+cQrZ7f9TgXkD7KfPMKyqS+QoOXFNAbwWg4EXBMbDHqvfQFwgK1E5boHRqhNfXKsWwBif/6KTMLMa/p2Nl6CqUUWL3SWhBBY/OsUpP9xln711aRXWG4PUxIL8dl9F3cThX7CSsrGPbyiaRaEM5R0YlQdVl84Bg+WjKln4Q0JeOb7Zrclsvze1ff8Y3aFgkr3whXQaAHvm6SBvK4b6mbV3xURtXHIdcLrKiewxveFUQo8/xOzedFao2Jzkdl+E6RVwUu4+RWeiI/mp2gli6CF7D+aSV7ye1nSkFj7+AmDB0NAe5nG4GuW84sK6c1y1z8fZXz8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(6486002)(508600001)(8676002)(6512007)(4326008)(66556008)(26005)(186003)(316002)(1076003)(66946007)(2616005)(66476007)(33656002)(83380400001)(86362001)(2906002)(36756003)(5660300002)(38100700002)(6916009)(6506007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Ss5KrT1S3lKD5+fOXzrnv3+MWowrklBSK9ozBw+5NooMwY6svgbU0+iV/R0?=
 =?us-ascii?Q?FGSZvVITuZq8k36ALsD6/WXZuqkQEoPVUm/kJga1f8MYHKO3oHVaslCHfSgB?=
 =?us-ascii?Q?7Obodf12Sa1ASmTKS5zDOR3BNsrNZ+yGslsuIu/E5c7nLtk/4/rY07C1tgLa?=
 =?us-ascii?Q?msnVxTvpARUzuhEULWhCPpi3PNHD4WAuaxY4V6AwF9/CkeIb2QbZtfv10jfI?=
 =?us-ascii?Q?WUGnofm9u/unCzHm5U/geP/IxIEaSrozaLfpd/r0JtZG9w0IJT48u8sA/Qcb?=
 =?us-ascii?Q?skVnXN9ilWH7XXhzYcNtPd3Ak/BxBqTbk4XvU40rzbAfgNcMGlbtAHwQn24X?=
 =?us-ascii?Q?EZn9Q2fo1ycd2+IH9DHeuF+JUst8pCxd5sKC+yBOVY1kZLC7NSJjPoNDnTkC?=
 =?us-ascii?Q?gnwL8DC/2KcoYsJ4R72+oWcaeg1rbsx30v2Pscz4t4dYcEJf8zSEahmWW+x0?=
 =?us-ascii?Q?GOBF3LrReqG924socsPjMDu0pSkFtw95eorPNFF7u0FUvq+RkSgERjgo/AdA?=
 =?us-ascii?Q?y8b7PJdquHKXHfsgA0SRbe0FIDi+UH0SX0WiqHP9ChqHldvnJBr5b3d9f9Kw?=
 =?us-ascii?Q?tyxWFKJo0Ii2U0wOWQxoG9zIfyQarZ9aclVdy6BoUAB2ywE4u8zrSBEbeVan?=
 =?us-ascii?Q?2oGdx29XOgXr+sN27sTmkJM9i0+XFxuKb/n5nfdhKaRVBUYI8pDmYMv4yOGn?=
 =?us-ascii?Q?j+J4yucYmFIlxslG26/5mv1oBJIDC+5hF5uS0DKg+oa5G085vl28mDTBkvTt?=
 =?us-ascii?Q?NUuRxck6CqpLInvG5nyMe+jA7JxEsFcW8Ezirb/SIZZ5bVTRAkoks7sIM4gp?=
 =?us-ascii?Q?gkNeLjGZFe6gjxvmxBwVirteQIySd8YZhsqTISbyxob/s9V5DG6uB36xelU6?=
 =?us-ascii?Q?udf2bH0nztADDkjEuDkw7+tISf+1VA0ONV6Mbifbnc7pITe0cHfE3XHlKZYX?=
 =?us-ascii?Q?6GseH9SEWGp7JbpNMMNhaBZvsHPi5JjmidX04bxCO49JdSBQX/vxiOu4AiXS?=
 =?us-ascii?Q?3FLIaqpHyT1bqDNr25NOHa2zPN2m0a1lqZJevVhSvUCsd2XwHF+fatYJnJsd?=
 =?us-ascii?Q?76cqnH4hsjFn8EqStHWyYPkkO38NfnsVZwk3FQdBsTycVApQF2MB2sdOJZ/Z?=
 =?us-ascii?Q?tkr2m3ndMwWxmm2D7IPzBGQf+5XQIv/xjZGCrZpZYzDnO0zRAxmOT/0vajEZ?=
 =?us-ascii?Q?ezpLybpAbj43qI+bkUk31wSCz3Afki5Fbr2q3a/4EobmEHphkQqlJSECMu5u?=
 =?us-ascii?Q?CNLEwJd9mLi3a3dRfHi1ZaN4mI/UgHJuy5Fm2+bkzLVabjCd4a4uVsKwoWhN?=
 =?us-ascii?Q?LQ6R54tIeLvdRSKrSNJCTiXwZCFMBQ4HY0Eh3clLlO2e6lSMRwHW5BqFSvd4?=
 =?us-ascii?Q?mBZm/MYs6c8z+vKGABVXZWqoQ4kN32+5uHKg7z2lNacLzEDk5MvMvjS6GDRf?=
 =?us-ascii?Q?bWSGyRwbDl92rZKw1xrj9xlC/gFc96YryQQcW+FCKYbFBMR8H/Vbsjb60r6l?=
 =?us-ascii?Q?7FBgM6SLbd1v6t7iFleInXhjU3sD52sRsylsl//s55dYN3JLIGNbDPiqpaUt?=
 =?us-ascii?Q?AN8vG7xm0VXefmgWaOc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b644e264-d751-42d4-1ab8-08d9e28ddf93
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 18:42:02.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMgCVXkbJEPamCfZZpSsOH+uf2FlYDrw5fer1k2SPdIlsB00xbbow/k6niH9riHl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 27, 2022 at 03:37:29PM -0600, Bob Pearson wrote:
> There are several race conditions discovered in the current rdma_rxe
> 
> Bob Pearson (26):
>   RDMA/rxe: Move rxe_mcast_add/delete to rxe_mcast.c
>   RDMA/rxe: Move rxe_mcast_attach/detach to rxe_mcast.c
>   RDMA/rxe: Rename rxe_mc_grp and rxe_mc_elem
>   RDMA/rxe: Enforce IBA o10-2.2.3
>   RDMA/rxe: Remove rxe_drop_all_macst_groups
>   RDMA/rxe: Remove qp->grp_lock and qp->grp_list

I took these patches to for-next

>   RDMA/rxe: Use kzmalloc/kfree for mca
>   RDMA/rxe: Rename grp to mcg and mce to mca
>   RDMA/rxe: Introduce RXECB(skb)
>   RDMA/rxe: Split rxe_rcv_mcast_pkt into two phases
>   RDMA/rxe: Replace locks by rxe->mcg_lock
>   RDMA/rxe: Replace pool key by rxe->mcg_tree
>   RDMA/rxe: Remove key'ed object support
>   RDMA/rxe: Remove mcg from rxe pools
>   RDMA/rxe: Add code to cleanup mcast memory
>   RDMA/rxe: Add comments to rxe_mcast.c
>   RDMA/rxe: Separate code into subroutines

I think you should try to get up to here done in one series and
merged, it looked OK

>   RDMA/rxe: Convert mca read locking to RCU

Not sure this can ever work..

>   RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
>   RDMA/rxe: Delete _locked() APIs for pool objects
>   RDMA/rxe: Replace obj by elem in declaration
>   RDMA/rxe: Replace red-black trees by xarrays
>   RDMA/rxe: Change pool locking to RCU
>   RDMA/rxe: Add wait_for_completion to pool objects
>   RDMA/rxe: Fix ref error in rxe_av.c
>   RDMA/rxe: Replace mr by rkey in responder resources

These also seem reasonable, didn't follow why we needed the RCU patch?

Jason
