Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C21435659
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 01:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhJTXTM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 19:19:12 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:8288
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230103AbhJTXTL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Oct 2021 19:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZjy482WMzWtSQJUh+ESfEf78kl3sdiNY3HCpLYgHYqKLHcivi5dDE4f+BOPsTdWLXe7bCpnrYs9ACPtyMLVFBFhnb/Qjimo0qCLTearro9OaRn3cW86IENUd7pvq1h2q0mosJRYxFy7Lj+o+YskIkAMf+kA+agvi7PwHptu1Hs+nQ68EbzoCdCoRzMVuiO4LcGrnR8TgQ5rbplPJ/m1lRhXq6L6hQ5vYuG47ynxs5JvTnozuXpN28hJ/217l5k+UzwHzULZbu+8fod3b89rdE2esuGnatsKXIB8dNUV9e0HU0DSnJBGw++d/HdFmcLbwyBSgR5bg7qzkzW/h9qnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVa/etPH//7iDQ2mpcMWSezu6rhXbxnhKi9e1TleVV4=;
 b=fEcVDtv0SHhK8CpwEAPr5MDOfvolAhM5djpJSs+flEDq6yMkFh7DqdmFDYadEw/oSf5vlJilsbcpzrbAscPbZ+Id4UL0mNtTPsmKncyR+jdudF97nvMv0MZOHr6AuLWSOx28u5j0nVMAPV7UO9kbyFUeDNCBsbUDHxNsd7PoLQFpiFPnyxTRLBfEcSbOuOnHKZ07iS/dC8VBGx2VtgpkwpPQQb3qznOxrqfh6J6pJLzjUbLirCyqhmnQ/xobC53pwFbrA5hdR+Ju34feV4JGLrdk+V4hlkYxZ8JiUhdlFW9kHG45EW/EoEig0CxWqE8AtTLAInGc+zQdC8r+wr1OCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVa/etPH//7iDQ2mpcMWSezu6rhXbxnhKi9e1TleVV4=;
 b=g7is3Nk1Zf/YwT0HRgvpEQDfr9a6cYJ4BV55gM8thcVayxrfC4UKOBNigq3dBjvYZMxhG4QRWGpdIoJ6gfWXiXmgB/Xm1+l96fu8Iht6UvhKC+n44E2Iad9txAgbhzoTonOrJP7WrVZYrYnPnpHJSfZtZpT4UNlebLXKHpNCygdIwsg9OMqy9gPBpl3WIunYRe2ngYDd1SBCe09jJnFYlz6pZ2CVH8isR1DAX+MVGxzWrEVBRxa8+RykDwa2d8JH+ULnpKcjMRG2eBQGtBq+0CK/soffjZSy+UtTibco9ZSXxJyw6qsld5WUBb/9dcXIqsD0ZC0MRAwVZuxFZENn9w==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 23:16:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 23:16:54 +0000
Date:   Wed, 20 Oct 2021 20:16:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/6] RDMA/rxe: Make rxe_alloc() take pool lock
Message-ID: <20211020231653.GA28428@nvidia.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <20211010235931.24042-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010235931.24042-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0215.namprd13.prod.outlook.com (2603:10b6:208:2bf::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 23:16:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mdKpJ-0007PR-8w; Wed, 20 Oct 2021 20:16:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49261c9e-e64b-4827-66f8-08d9941fb4a7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192CE146063D59D871BB803C2BE9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SHa1UQycJqmSnYtx9UkPaSuEXhbvsROreFlelqRBzMrJOkA8rqD9AaRJb2ZlDR49tSva0S6uVqdFaJ3cpSqDTSQCvY7S0OOmq/N0GMUf1NYzMpjJeMERlxO6YAqB4qaQITgI1hxif1EMXhr8uX5xBj//a2pe3LwOLAm/n7JrSx+hhsJFl8HsZaoQZNT3Bj98J+QJRZ6YQbzUTWZS1kjwlEOqj82V7e2/WfpcvF1rlQqMooGPYJwLfR31SOh6/vc4gvDEUi+ni3Ezn6T2SGLVGdSMuZt5TEAgU/em1aHvpp3K7F+TlH1KzoyYNkuOxHt5lRX5EudEWrWy0/Q3B6e0RHxrN371pQoE3ZdpsRltw35OuvYdNch6MY4FYRLlTqaiggKK9AJYcsU8iT1zSXWiXr7xvvw5I3bW/JS1EzyrF/Kf1FMGLPxMKMKZiDn0jsAIBUNzQJ31l5m7qD1hVdX5qVYHmjNPEueoegIcnDKH2GKtMzZcgJEDvz7b2P1yu/aKkmiUalmk+DHDKLBvgh7lx1jW6O88KzAOfbKJ2uWOxYcQk3DKrH/urT/BIeIsSa5tKijSSCHpPyC9IP7xMPw7kSg4m97jRgzdgzp/kVQkwpGyyF7n5A17J1jZioFoqOgLpCWe9RRcuYP7ndVM8g5Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9786002)(9746002)(186003)(5660300002)(4326008)(2906002)(508600001)(316002)(33656002)(1076003)(26005)(86362001)(2616005)(426003)(66946007)(66476007)(8676002)(66556008)(83380400001)(8936002)(38100700002)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IxGiNMDpTipCidmOBmNMrCgjeyM6Uoyl/DEITTGSFRqbXjveJNPYjo4cqxv0?=
 =?us-ascii?Q?Xxe59IoplAyWeH7DXWB0cPmrq8k2Iscp2QVd3XS5mkGH8G3npnIOK1dA6bSZ?=
 =?us-ascii?Q?sglI6S+vNKwFXOkdfozrwkoOoF5x9dr0Oq40IpPSHO5eZhNnHDMH+97fPRFs?=
 =?us-ascii?Q?6jj159N/J6PUdmyL0MujvFGyoTZTgrP6LnF+F6rIT9JCO1Iw9pMtrfcAFmpz?=
 =?us-ascii?Q?QW+c2JQnl/fSNyIabJ3j72e60bWhkZAiF8+87j4bxCjYqjTT+dYxxG4LMnLK?=
 =?us-ascii?Q?/1gtwuaQvNisdQXynWTnVjXvOwVIJV9bGicdztFfFKe4G1w+4a1fu8LbCMRh?=
 =?us-ascii?Q?J2NpPnvmXLKuTFtabvwKSYiO3B/hd+GCrI6Va/ef8fpYmyIrFWcpaHV+Ukxv?=
 =?us-ascii?Q?cI+k+eKYCntXaB2Ltu91JaVVzijbLzlWUTiS7I9hJD/Ti9pzKFdihWv7GQDk?=
 =?us-ascii?Q?8A8YtV28GhczVknyP/T+GFWONhO0wHjLr+uqQ2JvN17pSHanwWeuM5/Cv+uR?=
 =?us-ascii?Q?XHEhk537gLya7G+XKAr4b66y62Evvu07Rc59/+YABWXpAvg/ltWsvSv1J6aw?=
 =?us-ascii?Q?4d1SFuFSvhB07LiRw4amDYjBD8zJs7tieJUnzkgBhoyXNv/Kr3jBA0z+yu46?=
 =?us-ascii?Q?VuLJ5eC8JBhNV/az6RXG003AKq+sXEtgIiuR89JFlne9GaItsOjgsIE/KMbu?=
 =?us-ascii?Q?fWDFpqnorp48VoKShB/ZH8Mu+3sL2mvczyKe6X0mKOg/4GlEPUapA7c/oFzs?=
 =?us-ascii?Q?l+6E7lUbIFKSmNl4p4WJmrw9HKICQnSzioRQQA8U9EQv/87i3qtKJG6v8XTz?=
 =?us-ascii?Q?5glwyTyOM9SELd9U8EUTNB1z8PcKoGZ7+H72KTGmmckSCEZDU5DSr1apuurN?=
 =?us-ascii?Q?9CDw6wTFNS/j0R5hNvNrZLEM9nbtWK99ggCZV0EIJAGPq1SvfJUldQtUfb64?=
 =?us-ascii?Q?GO7QKlorsDJT1WCwXmkfwvqTujkXAt+QBi4Vq9zh77LhEVnIP1ChCFJh7t4H?=
 =?us-ascii?Q?9+GN8suuOiK6N9tFr1eIPqM/RpYJp6cBxp3t0xoRyIHl6XpEkQfdJ6PgWrpF?=
 =?us-ascii?Q?fWGcROiAUzV66InpE1SqejrpojpawZL1eNHaW+dRTbNDPh2eEGrZIMj1BBFh?=
 =?us-ascii?Q?nK08BI9EBR6g4XFH7OhM47N7tfNdH9+eNterjr2hmZhqMDhKlV620p3CdjBI?=
 =?us-ascii?Q?VJ+6q013/MwpKPvvc0kz/2Vt8Vqrqyd5NGLtSoGvvWbFxcazWyPX8HCAOrpI?=
 =?us-ascii?Q?w9Zd3HwaH5HJVw88OJmSN5/CY8mK07a2DW6jYfL50ZTrjDoakPgnb8brOJ7w?=
 =?us-ascii?Q?cS8gxHGe4ktjSBr1YtxEciYe7hkRT441NMOK1fiu5Fa/hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49261c9e-e64b-4827-66f8-08d9941fb4a7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 23:16:54.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgg@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 10, 2021 at 06:59:26PM -0500, Bob Pearson wrote:
> In rxe there are two separate pool APIs for creating a new object
> rxe_alloc() and rxe_alloc_locked(). Currently they are identical.
> Make rxe_alloc() take the pool lock which is in line with the other
> APIs in the library.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index ffa8420b4765..7a288ebacceb 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -352,27 +352,14 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
>  
>  void *rxe_alloc(struct rxe_pool *pool)
>  {
> -	struct rxe_type_info *info = &rxe_type_info[pool->type];
> -	struct rxe_pool_entry *elem;
> +	unsigned long flags;
>  	u8 *obj;
>  
> -	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
> -		goto out_cnt;
> -
> -	obj = kzalloc(info->size, GFP_KERNEL);
> -	if (!obj)
> -		goto out_cnt;
> -
> -	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
> -
> -	elem->pool = pool;
> -	kref_init(&elem->ref_cnt);
> +	write_lock_irqsave(&pool->pool_lock, flags);
> +	obj = rxe_alloc_locked(pool);
> +	write_unlock_irqrestore(&pool->pool_lock, flags);

But why? This just makes a GFP_KERNEL allocation into a GFP_ATOMIC
allocation, which is bad.

Jason
