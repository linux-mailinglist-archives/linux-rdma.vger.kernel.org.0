Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B6B391D51
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhEZQyP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 12:54:15 -0400
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:56732
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233324AbhEZQyP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 May 2021 12:54:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fx1Ir86p1HNP/zRTr4pH7U4TyKV/hZYpwY5BpRvBHdc6z/oHsM7SoWpbvKRR9KOW8D3PUPJF117idbpZ4/6mgFVY0jIZtMdtyQOQMKFSbSHnDUwcfpb+PMpv/wy1YwyEml8WxhbBIw4zhJ+1O22c8a3BzkZY4eSEAjTbnLOQA87IFS9M0OAoazCLiWaj148tozrLm4+TauVjiCNCUJ9PlVpVFl0reoRwsZuBNyLhTY7obqq6fodRUllsvO/9s2CFFpvheu1Kx94yiSAWvHlL67KsnBB19Ebqw0z9Xbm0jVkF8G4QMReXlwaj8yFoJZOUgmrzJP4P6UG7PkMvjMsI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lK5GvEN5lTREEbLKLHSetuuOPCNFwAHi/G1PEnli58=;
 b=D/5RQlflfy1pD8jC1/T2KH9c52gS+7xHKs9l0NvTomRHsicDJpd4v8JVRSrqek4P9NFFI6/m5DXGlbHIYE1GTlD71bo96fEcU5Ei008OxX0Z59duggl71BntixuhGaLj+Q0oJqk7qsPXVh+EDmPx2Dy7jWOalb2v4s4OALkErzMgwzOTZwtyhGmySD/Xhcc18OTgC9ef0qZ2Xmr3CnBlLWZaE1SEQSR2azzl5dgDfF3LS15mBWja7B9HymbiwzU4h9xzHUcj5N4n2ZhIVtbxc/pksz5bwPL/aOZvX9T88b9HQGlF8f+/zuXVnLeB7XfYNq90p9oMpb5+L0SmQFzX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lK5GvEN5lTREEbLKLHSetuuOPCNFwAHi/G1PEnli58=;
 b=CtANmABk1PY8/OogJSr/KJBRTaABPCCIeTI3Kuk8NZLBwJP7o8kfsrTt3NneLwXeDTnV1OVGL0EoUGhb2Po0i+5uUsZU96IwcBohcAhHg4euiXK2GmiWudPqWIj5QcBFnla3adV8SekqCCd4FwRtsheEhRRvH1EqutX5B1tO3EifwNBwZX4z9xKqSv+4P/gsWoknbXtMHMmu98m2fcki0aUmFQyPDDUW5t+3sEl/Zc66uxFDCz+3sm82xUkOfuXqTGocB+mP2IQWX6jcbOX5V7ijm88pXBYBxcAp/NuoClRNzL3Bkk7K+zycCjDAy6O95AOrd9ZPEtua9ZAZJYIn+Q==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 16:52:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 16:52:41 +0000
Date:   Wed, 26 May 2021 13:52:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 2/2] RDMA/rxe: Protect user space index
 loads/stores
Message-ID: <20210526165239.GP1002214@nvidia.com>
References: <20210526045139.634978-1-rpearsonhpe@gmail.com>
 <20210526045139.634978-3-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526045139.634978-3-rpearsonhpe@gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:33::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:33::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 16:52:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llwlr-00FExw-PL; Wed, 26 May 2021 13:52:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbea8475-da9e-4499-6367-08d92066ad5e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349D3719E341A7045DCB9C7C2249@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2Vmd2dMhnvYfgpQvujMkmC9i4SxMyT8HUIk5dmXzYUKy6nQ3ehNbGt+8K8qiAvTraaAV2tq20pStWDwXh0FeVf2iyDsiWOmf/tVYWQGmVimyru3rYEnzgcqDYCbFWm9cPM1cXPruLqLNrd7IdqoAKsfpyflS3YIGuJ/WK3SR4dSP0v+2GbauYQ8Sh11dtemy0nNLYzVeR6EqX+TW17AOeHw/z+DVwZE4TDyRH80gzDEek9Hbd37NgugVsLC8p8bglQuPih/SFg4MgxvBHyq5Xb91byqOJAv7fwlT75fNN+8vp54p6tgC/ST3c3JLzwxxjbul5uLLY8v3V8Cy4AgIB7MsfcpHDoL7eMsgjuhJc66gmJrFgvsJ89zaeDPhUnGK0Df8N3pT61STNmBXIqazgba4iGf3KkijUwj/dJgqYtVbM2BNK4VwQCwc23CW6x1DNj8Y9v+dMUTuZt9lyjLjbJuWtGb30rhAoRqEaQTL1Y8ED6evzBg44OcgaITIj/FpLEKvGPGDpnd9/mxg5dna44/c/7UszW91aoVbZSeknSIRLHcsLkbZ0qMGq+8vE1VNaqLTBUy42r8L7obR4zfKn7kXvBiEernUh+ZkDLvMl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(86362001)(2906002)(83380400001)(1076003)(6916009)(5660300002)(38100700002)(316002)(33656002)(4326008)(36756003)(426003)(8676002)(66946007)(9786002)(9746002)(478600001)(2616005)(66476007)(26005)(8936002)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WeZPhfGM+nC7QnJm6h/bQuY0IabJhLKDduvdIvW9TSIELg8nKGbTwteAEai+?=
 =?us-ascii?Q?4yTtfZcxA4PAD5LOn71fvR+T972ZpA149fifKkmt2kL+sYyZ+MzFxQT8lDXL?=
 =?us-ascii?Q?mbc6Kf1iBPPWMB/tZYqQ8GdvbYptlESrPphTTYlbw32xVg+QCdsHRRZrShFj?=
 =?us-ascii?Q?fjrbpRpA3+YIxyR0x982yuetJ9MFmL0N7u0bB26qVI/ovdU7mMF76i1Mojr9?=
 =?us-ascii?Q?Df37r30Jw0wioeVZ6Yo/C37U8l0yA1L+IWPoSIZVEdfDB3jMkF0leOnV3yER?=
 =?us-ascii?Q?UY6pcBQyabk1oUAmIVEJp45r/16/xgeylIvxapf4v2w2XksejEVLf5Hgu7BT?=
 =?us-ascii?Q?MKWZjwXMWPSww0RBDnO9CrEBYdPzZL6jzdzHHnLnl1bMHX/zn2nVs6urcxGa?=
 =?us-ascii?Q?rIoaswuQ+49UT/gBVrlQU5Gv3rMoVx1kFZ0IMEzoMxuhoApctiaFzGPEjmBY?=
 =?us-ascii?Q?ND0EA5GuM4eu0CqwZCScvtleX7xxPltWt9AXDSqWPuAGzpyqVLKoVj5Q1N7D?=
 =?us-ascii?Q?29k7c9A8lfKxww85H+i556rDcgvQO3PmapbxHe7u6yfJ1a6Aih5qbjH0QfGQ?=
 =?us-ascii?Q?9RG1qoD4tkBWmqtFjVANYnIzhE1L9YifI6eMAtS32f6alN7owPANqZaaTvlt?=
 =?us-ascii?Q?jAJkqncod25VwWEcCai+Kh2WDQov/ju+8N8vFmNoi95BM4xQ2VWX3k+O3948?=
 =?us-ascii?Q?qOOddNBlUhAYieoxmnZjQAnVoyvsZolL6AbVoZxsVKWGQmFjIWgJttUSrXyQ?=
 =?us-ascii?Q?Rib/xCNQ/a8olJZ+xbBKbb5RcxpMfYGX4AM8E/HT8hXhbYrVjVIlP5/M6NiH?=
 =?us-ascii?Q?OHgdcEufD2ROst/R+6JxW1SKRMiCj4Z+hyk1IokkvDIBhVVZSQ0oWSHm31wT?=
 =?us-ascii?Q?cgOMwPxpg/653ZtLe7ZNRGbqR5RgPrRZa662CKiw8T7tdPgu/fzy/6jVCHtI?=
 =?us-ascii?Q?pnq3VFOTjrQ3YXWlPnAUzJuzZMgtdBubRkiz5wWbZwQYdO10/vYc+PbxXW5r?=
 =?us-ascii?Q?bKULPS3IUXGylgWie0VugUYcQq/wzfybeGmg+3AyA3K9EP7NkcMbpOSkHK32?=
 =?us-ascii?Q?Keo4YTTDb0AI/Wu7txucyfMZdJ73O30dKVEXJZeFF2lYNo/gQzK0gMBXlnz4?=
 =?us-ascii?Q?aCnd51hpcvKzTFSXB/HXuHHkHhoztMCigdnkV+gOc/httZ7ltpBnZ/E16TDO?=
 =?us-ascii?Q?Jj/ABfexqqyJ+JLrdW08LQNIvhckIskby8ev1a5tCgPSOwO0uVoH6mKtbJoh?=
 =?us-ascii?Q?t6aNrAGCF7bFbIfXoI0Vg/2y5geWSttlfAcTFrMialaOkyAdoYU+bAjMuQXW?=
 =?us-ascii?Q?1famMnOJV027IqIbMQj5pPmv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbea8475-da9e-4499-6367-08d92066ad5e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 16:52:41.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzZWZ2lu+v8Ih7wqandVxgvtS92w8x5UabWxMTUdDzREQgp1jQtKryWSIjoWF4as
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 11:51:40PM -0500, Bob Pearson wrote:
> Modify the queue APIs to protect all user space index loads
> with smp_load_acquire() and all user space index stores with
> smp_store_release(). Base this on the types of the queues which
> can be one of ..KERNEL, ..FROM_USER, ..TO_USER. Kernel space
> indices are protected by locks which also provide memory barriers.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> v2:
>   In v2 use queue type to selectively protect user space indices.
>  drivers/infiniband/sw/rxe/rxe_queue.h | 168 ++++++++++++++++++--------
>  1 file changed, 117 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
> index 4512745419f8..6e705e09d357 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
> @@ -66,12 +66,22 @@ static inline int queue_empty(struct rxe_queue *q)
>  	u32 prod;
>  	u32 cons;
>  
> -	/* make sure all changes to queue complete before
> -	 * testing queue empty
> -	 */
> -	prod = smp_load_acquire(&q->buf->producer_index);
> -	/* same */
> -	cons = smp_load_acquire(&q->buf->consumer_index);
> +	switch (q->type) {
> +	case QUEUE_TYPE_FROM_USER:
> +		/* protect user space index */
> +		prod = smp_load_acquire(&q->buf->producer_index);
> +		cons = q->buf->consumer_index;

The other issue is you can't store the kernel owned consumer_index in
the 'buf'

It should be stored in 'q' and only on write copied to be buf

Kernel never reads the user memory it writes to

This is why splitting it makes sense because it really needs to be
reading different memory, not just using the correct load primitive

Jason
