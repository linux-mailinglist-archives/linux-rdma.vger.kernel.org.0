Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885DD439DFE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 19:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhJYR6H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 13:58:07 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:31712
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234137AbhJYR6G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 13:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzTYKrshK5MJkeYV7iBYEVl0E2zoNrTYBIAZW1zERU4tfcqkzmQuUIKsU9VSbPQsI/wZxmpDIuYjp3nuMLd7UCCL7PCjWId4xqItNCpzbMuhk+A0KGprq64m0hgFnf5pkNTDHpt2ba2wPLVrDB9pgttpChIDMlNUv6e7l8ahAKuTsxBngI2HChrj5qUZVZ0JXNXKsGKS3J+CyttmXZ5vsxV1Ic8OVz6X8ii/c0L/9hBBY1isOVch6/7aUJIWnn9onMEomPp/OsoL4YyAK0ej4qgvuoTtFeyVP2JB0SLWl6iQAhvz6dgzIScAApqhSR8Sz6hwU9Qx4JQEecLeBRoegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXdpOezIbMrZjrXT+GGLBeOD5OWg5C4ebut4TlGohoM=;
 b=hmsmJDMzRpWVEDryERMZWt12nEWqt+WCQ74B4NOmVV8vCKfCYz6bPrUHMVNleiaZ+/H1DuL2xdRILERT4fbQ2OkxdJnaFrGa+31OLIZ6IBp4h4ZgZFjxiMrP8gNTG7bEnALL2SQTWZhhoOWXuJscfdQxAXnaUttgSkYlDEaYzn/6D6C8a/mnx/XzTQb3t46+ydZRVnU7wlQlVbLPsTbme2Q37kra9FKkRAuZuFkp6F9Re9kBbNJ6NNdAm0FRh3XhXJwGJ4Zvjn5lvayR0a1hL8kT0yNm8kNGUszdMjtYONHXIEzXdgq6JMqUVJcXk8ernP+SWW4H5xvFBbEXL0pSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXdpOezIbMrZjrXT+GGLBeOD5OWg5C4ebut4TlGohoM=;
 b=GgoWOcCWFIRGF/PXIW0/dL33JL6CMYs1E4+ea9KQP51o8/quEHyXjZ/13oZdIJlTe8oQjAXeVWVbptnl2T2s8i4naZ2G+ZkSAPaiDfQxIX7b6XZHMMwvbLyuh853k2YF5D1Nx1CTV9nQg1E4+gWeg2qh5P8dX4AzBj/Awziy3TMQxEZWG3Tyep/be+bLLKMHAL3iMykEG68kpOnCOLwQN6kpWG41WhSoM9VDv6ADn650zu9PNihbGAMzWxIoi3N5ABArcSg9wjfJpfj2bQCYZIHyYzsGdngmlN2FVOfggMOAA/Wj9uXjlqM51h3j4sWF9L2/bQOKkVGeGbMyHT3OCw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 17:55:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:55:43 +0000
Date:   Mon, 25 Oct 2021 14:55:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 01/10] RDMA/rxe: Make rxe_alloc() take pool
 lock
Message-ID: <20211025175540.GA433125@nvidia.com>
References: <20211022191824.18307-1-rpearsonhpe@gmail.com>
 <20211022191824.18307-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022191824.18307-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:332::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend Transport; Mon, 25 Oct 2021 17:55:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf4CC-001oht-Ri; Mon, 25 Oct 2021 14:55:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d21759b-bf97-421a-67e4-08d997e0aa21
X-MS-TrafficTypeDiagnostic: BL1PR12MB5335:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5335C55550E267FD48D88C19C2839@BL1PR12MB5335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oZvGRSA9c9+kdH/KMwJ45huMD7SfHT1+nTV+Q6rAjpGjgzjYKLED7fVYVBG10RcbGtq2HcJn8nwxOqHaGFzbKXo0EMhTmCJL1YKWKVThKII80sQhrUHiQosp4fXjoTBb41itCOhTJbViA3o8OosO1Lk0TyLeiUluDNaw9l1KnHFlafMYS8VB5uLu09RaQYjejRrGi6MfYmuNraeEVp6OIBnrOmf7coouIQfglQRIZgBOymUX080t0Egt7bfyMCDafIRPYQhmilacoRQ+e6amqwIyoDDF88MowLqPSDQjiupv/0viSN+EL2K/omLdIRJ9CRT5gEGi2IQzPRzg2YahEbccRUZkfJ91YQ8bNsKZaTUb34j08QzN9xK46kAJHpAe0Q9UbfSPAxGghi88hTFnwKAhpVvw0zHYFe2UNgYURRTalsz2DOTyoivvl7mOHuCWbPIWqqyVr1sM3Z5BEzEJBtm9RepUlLM7805o6XffDEz0mc3BEWsg86JOSePFn10gC+HHklORig9KFLe//NyWfi8JEAoIy2xz2CmjwElT+udNCfHCoVhGshT+Xd0fV+9GLN0WdmKvHEtMA2N90dDEl1rOkJE+lRRK0eLswMV8k4JSyP3ySdRxoorsryFs/AxjvLgnY11CFVqWkwRhez3tHSLkkD/gPbk0P0W+mZhuVCsBqReDaa2bEofG5AaI1OwZeeTJXevWOiU39QNwOj+ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2616005)(66476007)(83380400001)(6916009)(33656002)(8676002)(66556008)(86362001)(508600001)(4326008)(26005)(38100700002)(36756003)(2906002)(426003)(9786002)(66946007)(9746002)(1076003)(5660300002)(8936002)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VBMjCNmOpKaMMpdq1sVXVsIxJgwPXZfKgy1+Sb5hW1S3kwtKPX6y8yFDX2XP?=
 =?us-ascii?Q?XX/WnnvKmupNp+02tTsGGgfvFhq7C0wRP2A03z87ZfsZW1jix5q6QhIebHYJ?=
 =?us-ascii?Q?zFhvpdaAIIZs54VfxTB3RvBDrU0TRW0xXOimUtoJy8qRq8p5pJBf0lSNW7ip?=
 =?us-ascii?Q?vFUs2FurWW126NX++cSI25uhMfbK3QxgGA8/ogj0juOAKc10tPnAB+WkubiD?=
 =?us-ascii?Q?ndJdJ41yHiErwVkY9Gkx2N5EZTUjAl9CosCSugqtvhGx0o3B6qymn8cjZMiN?=
 =?us-ascii?Q?n5xyhz5D5hebKm4dyOJBTdGGUBxVy/Ac53LK7OWYCgoVFP/lGa5gOiZ4DPbz?=
 =?us-ascii?Q?ixLfAoRxu+Xd7e7LU6CLN5BSkzrXxcx8YVJrlNN00vUkf31dXd8m+HDrVx7t?=
 =?us-ascii?Q?VI6O+yQ5du8+81HgLRo8ZCGyvLWJrWwwEKclYFZKNYWt+pR5y8fA16hFYi0Q?=
 =?us-ascii?Q?E9iuAVX+xlHW9SsAXXnJwddozZkunj4oKSp5aP+ckMo8Ssdm2FEorifb72De?=
 =?us-ascii?Q?Su5ay0EUzcm0CRmAWsv1w5Wqwvlda7L3c88I1rC13voCGj6D/UlQwvIZUhve?=
 =?us-ascii?Q?1LPiXbgti4bFIqJwRmtaJ7a6//uGLeCiuKkCAHqHzYKpnx6Expkz4lw2UB20?=
 =?us-ascii?Q?sQJEcuB6of1C6nr8s1hfVNOh8IZqHaD4pWJtY7Ny3avw+KUu1zGErG/kr4+R?=
 =?us-ascii?Q?888jdPkZrk2YlpDdrpSWFP3JAZvJS4HrorzyS3JQNw/CYksWjDQrueXN1pX1?=
 =?us-ascii?Q?0oB5aFx/BcoVP2gcVFn7/MlrvroVJgDr9nh/cE7h1bEVwhukjesuhhQ5dyra?=
 =?us-ascii?Q?gjBTaWrnglicnCfvrUElJNXhLMWNBHfvtbtA7/pKjfUCbXjoTmxEGcAg++qk?=
 =?us-ascii?Q?2sUO60awMbOrEm06HGo7pZZKndXejILfxqDR49maijC2YQOZ6QB1ZDUlwh8b?=
 =?us-ascii?Q?XGBRxdEBnK2uXoqmpXoCED/q3MgqW4qAAuwWywkY189UEGfaX3SXT4r2WCJo?=
 =?us-ascii?Q?jkwMxeymBdABGqgmyboJjo6PBpsTsnBJW7fKbtRz/3QHoWQ4obhUFWHWq25D?=
 =?us-ascii?Q?BoTFNnCbmRHM09emysUuMmQARkllWzGoUsLjyokSGPREPChdGLyHTcLGdHsB?=
 =?us-ascii?Q?97kcKVASkjNPGKizY3FgMK5/l6ns3WoZupASVBFpZLPkBbCahLb+XN+FiiCW?=
 =?us-ascii?Q?ou5Qa6T+xw5T+0wN3jtFk0fcYUt7IJtnpKlX//jn50EkA0JwYrWLKDx/l1Fz?=
 =?us-ascii?Q?eb4X8fkD/E3EqHDC1VaLwbJ/5q5fXyehZAAC/mFgYIZROa9E30Rbog6seV0V?=
 =?us-ascii?Q?h4YMY6HjTc/8mwNR1QfBhaL30F3dlgHeBf9gabQhj6mrpL5PJCOeqWm1cTJZ?=
 =?us-ascii?Q?oWHnJJjP9agKhfKf+Znr6XNmu2mHFugzMO2eEuWJSvPbK4KZn2nPKS935u0f?=
 =?us-ascii?Q?th3Atrvewz9YiMbXvl5cZ2Y+N/zW6/UerKiOsWJOzL4iTI6kQh/3N9MJeXR5?=
 =?us-ascii?Q?1pLym+fgaHV4vA85/onpWfXyzvS1wO7znJaSeyGNlOIXrxBNoq+gsUSWZd/n?=
 =?us-ascii?Q?sKzntJwiR2Va1ALgHYQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d21759b-bf97-421a-67e4-08d997e0aa21
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:55:43.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eWbeWhLEZ6plg88WPdfyHYO5zRXvVeRLVu1wIP5i6rCMC/+4opkx4X3JLLlSiHm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 22, 2021 at 02:18:16PM -0500, Bob Pearson wrote:
> In rxe_pool.c there are two separate pool APIs for creating a new object
> rxe_alloc() and rxe_alloc_locked(). Currently they are identical except
> for GFP_KERNEL vs GFP_ATOMIC. Make rxe_alloc() take the pool lock which
> is in line with the other APIs in the library and was the original intent.
> Keep kzalloc() outside of the lock to avoid using GFP_ATOMIC.
> Make similar change to rxe_add_to_pool. The code checking the pool limit
> is potentially racy without a lock. The lock around finishing the pool
> element provides a memory barrier before 'publishing' the object.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> v3
>   Kept rxe_alloc and rxe_alloc_locked separate to allow use of GFP_KERNEL
>   in rxe_alloc
> 
>  drivers/infiniband/sw/rxe/rxe_pool.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 7b4cb46edfd9..8138e459b6c1 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -356,39 +356,51 @@ void *rxe_alloc(struct rxe_pool *pool)
>  {
>  	struct rxe_type_info *info = &rxe_type_info[pool->type];
>  	struct rxe_pool_entry *elem;
> +	unsigned long flags;
>  	u8 *obj;
>  
> +	write_lock_irqsave(&pool->pool_lock, flags);
>  	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>  		goto out_cnt;
> +	write_unlock_irqrestore(&pool->pool_lock, flags);

Atomic's don't need locks this isn't racy as is today


>  	obj = kzalloc(info->size, GFP_KERNEL);
> -	if (!obj)
> -		goto out_cnt;
> +	if (!obj) {
> +		atomic_dec(&pool->num_elem);
> +		return NULL;
> +	}
>  
> +	write_lock_irqsave(&pool->pool_lock, flags);
>  	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
> -
>  	elem->pool = pool;
>  	kref_init(&elem->ref_cnt);
> +	write_unlock_irqrestore(&pool->pool_lock, flags);

And none of this needs a lock either

The 'release' operation should be provided by the code that writes a
non-thread-local pointer, not by the code that initializes it a
pointer that never leaves the stack.

Jason
