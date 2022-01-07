Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C5487F52
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jan 2022 00:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiAGXWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 18:22:21 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:60672
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229720AbiAGXWU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 18:22:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqFzlujtdoU3+OZz460REBsHU/0QDRbdZCUpY7qNl+6pAId+z2RmZle0ohMaU99fPRALBo4eHPVCvo2FCnBhPtW+4/oH+nn+XOr0BcF1z6rNqNVGMxS8s6gMFQ1lWvwFznyqssb3BMypPME5ebY4JLjkK4LVpVZo/jRQl2QT2YlxNZlxSw5cCil7re4PmGqvWlexaJmWmbtbMCiwjU6UThNe3FybdygMcwKHhtPXpQ6dFmHuieZ0ITMpGuSeDIKlMkPLDgy/4e1AExDSpLOKOWirtfP8eASeOUuV62B7ed9O8te1VMnbApY+hgcJ5jnCeBC5g59hWAhf0zyqY84H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWoErDvFbmO6MtGOF5HE+AzDGQYuCUlv1CWcVBNoRAU=;
 b=P3eMLEswGWgYQ6cFtIPToYIaU/i8Roi94kXsyldY7SCif9vqlNqwGUdCpwdJTqJUMj/9dsxL06yTdun3IUh7pq631dC6kFniVrEUjlfO4IVqDhVkJ+o8gL22oyOTwiebAfCz0T14JpO26azbtNzv0cQI61/58vd8MkBcf0UdXGSv/Pl50jhk1i+Avg1U4JsMk8uJO2wwQLYS3x3GcvTEh0hDO2e2yuBzG7SWW5+Dg54wfmFJ4cdtSOGbh4R4iscA9zkVQgysox1HMp9vz8jQ9xKiIzLoqRGzcqsAWyvg5oFr7pouvJH77csRqXbyQmTX0bLTfZ1fs9kz4A2F3Q9oug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWoErDvFbmO6MtGOF5HE+AzDGQYuCUlv1CWcVBNoRAU=;
 b=rxtu5qrCNBOpDkdr1+n5eB4UhIBVIl1WYTjxfguQSCPhX6NvpX2K91+V1cFPXL0f5C/PnckWpeMpjgnzfC0TS7oqmG8TYGl2IlpVM4TjTCrouZAmc7XzXC7tZjbsf71PAK3QhzjdShzSDlnaJDrzUf57Cm/ygSGVfPRSxh/gs/f+PvIueqle+wq5DCgbzb4uhKcvEL1MpxzC/5VZkrIgw9X2vLzrO/fHLP2SgVaY0hyJJAPG1ppZ3cpTKlKYaBb+DGbhfywoOHXAS7LiZ25iA3mFjUCJqUm1VqJ3oeuUXF0n5lxHFf8Q/pe1K/4PmzAyj3jFAg2LYuSyoHz/kbPhDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 23:22:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 23:22:18 +0000
Date:   Fri, 7 Jan 2022 19:22:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/7] RDMA/mlx5: Replace cache list with
 Xarray
Message-ID: <20220107232217.GA3108306@nvidia.com>
References: <cover.1640862842.git.leonro@nvidia.com>
 <58c847ceb443d1836fcf6c8602f2ccb5e84728d7.1640862842.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c847ceb443d1836fcf6c8602f2ccb5e84728d7.1640862842.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:208:23d::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d8b59a2-03d0-4432-7141-08d9d2348c5e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5077F20E8238CFAE5E3E694EC24D9@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5KQo1PkpZPfI+v0AVYbDSwMBQ+OkF9D9sJd0gtnz5FsfAyznompufUoTLcvcWo4nz1sln+dxavjk8ZHwiPwU0PTiesI3L9TJ9gIAWlbl8h4mq3b0KCVOlyUd+CS+Ly3SC+w+K0ohzuoYYmgOySDDEtZ7kWTvTW6/BQDG3CQBh64deoZw1ZGJop9Vl/m9oiLvgyUIZKcTOcYwDuSqPdDj5lUEBBlSw0TsWPs+xOgh6nH4H82hqWUX9x8UsbhI1EWqMVIRoUpM7qQS4S+N6Kqf+56Wbg74Ut7Nli6eAdH+5Qtincunz2kQlV0Q/3DBuhtIyksHQjAsI+tpmrDv2ak0+VzZtcYW3eMU06dTOQ2TEsQYS3zrD6r0VOtSmzKCRqdEVPeooMSJmo0Ew3iOX0OGsaBzU+XNKudxxC5zcoHhZNsqYkanHQC7+8Mx3HzxIR00ijX0sRZpSqub2Y6RCDy7oc7j2pqxCREp81VPg+cRSpodBrmDoghYhlAKBEdARFXzvEub9H/o4TdJRVqFWcCBLxsEGcV57QeEuuefCygcol0cRv50q6kFz1TuUSX7WVaJzFpz0yfJ2oW5d9m+/XyheBMT2xejB3xNOfhvkLkGZoAodhhiKNr46OFMsPoQyX0iKV6eKHiH9M+RR6eMuLVLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6486002)(83380400001)(1076003)(316002)(33656002)(66556008)(186003)(66476007)(6916009)(66946007)(36756003)(2616005)(2906002)(26005)(5660300002)(4326008)(8676002)(6512007)(6506007)(8936002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gHRcqLISfKOjpATliEUjTW6Sqi97jvXTixch8YGdg+asPzWqjEN5aIqj0rz8?=
 =?us-ascii?Q?N45lBluYS52OB4X4VSi4GckHx1t4OY8xC1tkDYDm+FPaH02Xqklx3M4qUECw?=
 =?us-ascii?Q?rYc+wyg+sB/ZrndmLY7BO75doWjvvOTIMA3JSgZ9w7/oEW7haw2UB7xxm7v2?=
 =?us-ascii?Q?vbRQptY/Ws12ryNOIEwc9hnG41AjO/kjS3ZS00F8VTjPPtVmVpApGTLsS7fV?=
 =?us-ascii?Q?HolEUIIqQuTe6pLx8jvwjKfzawO6tNArISqsNp8ouBChO9uXSVeu/BB3Ai0o?=
 =?us-ascii?Q?KYtLmJs16u8ZFj6k25k8DZJBe6tbJBrQyY3rUzeSAUO5CwSfPXSerMCGETlN?=
 =?us-ascii?Q?IbExniCTEQIrrARAA6MwV3HUMbEZxxJaND/QuVFRqgjGpYMzJmiT+y7aysbq?=
 =?us-ascii?Q?fbiL5ofTKcyxM8dTxyQJJKjkAY98YhoDpbiqFqtRbHDOACMwckLrM5CzZRqY?=
 =?us-ascii?Q?0GC2D1hQYRb3/fYXkctB2lstqTcDLh9cjr8YPLOgqOXOY/Mm37nrb3a/SNEw?=
 =?us-ascii?Q?srXOuDiwUKk8c+Kva+9WMgtm9FSxvq3HovJCp61cpoZJb7P2CdpVorzaqjFD?=
 =?us-ascii?Q?gc67T0ouN3BBr9g++T3uYKn8AuVz55VCz0yKNZDw9wEUNqPmUbx4XrXSZTwO?=
 =?us-ascii?Q?nM9q/vmtxV1yKO/NVnIFERBjvUxEMV9arpFYrWYhUfAa4gcEBQfS1L2ZFPQJ?=
 =?us-ascii?Q?L5AAlK3ia9fZcLNE6eyoICmNz3jODHR7km/OR4gvagspb7WtMNIExgVUCH9l?=
 =?us-ascii?Q?1w9FRFmdlBU6P+1fPrrrKmn+bfpklv5PhewmxgVSdCqGSawP1dLS2QZ6REog?=
 =?us-ascii?Q?jI88hLONctipzZ3Amr104X0s1PXHWEsHIjssbjRxzfy5sLrKtldCacMFuK3K?=
 =?us-ascii?Q?l7D1MTlD/kgbaNoqemsvdbZEyNLYdGLEhX0OLQqQwbpEuzycC+LiszFtupku?=
 =?us-ascii?Q?IWqRTMpP/c+2fQ9uBlo1VFqm/Fo75BfLpzEt1qk+wgOHNbZDCK/lK7Twz+dd?=
 =?us-ascii?Q?wyaqy0cKeSxWvEb/Z6FzFWygQAIspacvULoxrNnHJF+sVZYr7ipjnsNwp+6J?=
 =?us-ascii?Q?Mtla3QjEtsQiNw0cuPRqVvonMmSxPIyhRhn/b41nKGjVDWurZKoVaXT53lH4?=
 =?us-ascii?Q?yFtgb6tbBcH+vEn7urBU34zrbltDSUP8tyAfQPzXr1D+g0jPTbvAwITKZuUr?=
 =?us-ascii?Q?Z4y8ei4O2mEB9ERc7DxtxgCgZ368L3CcSI/84Vh5KVQM1I47UeYwqNTSPMA9?=
 =?us-ascii?Q?Clb1rdxvDmGTHsdnVtCxkDH4K6xDZJyH1XDF2vXjTrzTw8wBA5+bKn1wtS7C?=
 =?us-ascii?Q?ExNRR/daaih0Kt0LZ48iRt/LsZGFyD4e+zntjK1EklNXuI9fweI1hdWWcJPR?=
 =?us-ascii?Q?LP8gYFbOrrZEs9YMUUtw7X1BkSRDU7XjlkjVXSOg8aU94ZZtydiNAAEuktkW?=
 =?us-ascii?Q?iOFbdfOID0zC/2jE82BvD3hLk0en5dzFsgH0bbqXdZXu+Gl8afTYBJRTDCiC?=
 =?us-ascii?Q?WYOLzmo9XeyDdCxUVsniTVJrxWgPSjGvVM8MU4z1/jMHVEPm/AwDAjV+1157?=
 =?us-ascii?Q?SnCGM0Tlc4gsFfS3ikw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8b59a2-03d0-4432-7141-08d9d2348c5e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 23:22:18.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIAw7WDCHnPolMlMGEEt/AIgmUDOK8rLsri/gH8HML9A6+UB90jDY1fMSHtIKSDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 30, 2021 at 01:23:19PM +0200, Leon Romanovsky wrote:

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 2cba55bb7825..8936b504ff99 100644
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -147,14 +147,17 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
>  	struct mlx5_cache_ent *ent = mr->cache_ent;
>  	struct mlx5_ib_dev *dev = ent->dev;
>  	unsigned long flags;
> +	void *old;
>  
>  	if (status) {
>  		mlx5_ib_warn(dev, "async reg mr failed. status %d\n", status);
>  		kfree(mr);
> -		spin_lock_irqsave(&ent->lock, flags);
> -		ent->pending--;
> +		xa_lock_irqsave(&ent->mkeys, flags);
> +		ent->reserved--;
> +		old = __xa_erase(&ent->mkeys, ent->reserved);
> +		WARN_ON(old != NULL);
>  		WRITE_ONCE(dev->fill_delay, 1);
> -		spin_unlock_irqrestore(&ent->lock, flags);
> +		xa_unlock_irqrestore(&ent->mkeys, flags);
>  		mod_timer(&dev->delay_timer, jiffies + HZ);
>  		return;
>  	}

Since push_reserve_mkey was put in a function these stack
manipulation should be too, especially since  it is open coded again
in the err_undo_reserve label below

> @@ -166,14 +169,14 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
>  
>  	WRITE_ONCE(dev->cache.last_add, jiffies);
>  
> -	spin_lock_irqsave(&ent->lock, flags);
> -	list_add_tail(&mr->list, &ent->head);
> -	ent->available_mrs++;
> +	xa_lock_irqsave(&ent->mkeys, flags);
> +	old = __xa_store(&ent->mkeys, ent->stored, mr, GFP_ATOMIC);
> +	WARN_ON(old != NULL);
> +	ent->stored++;
>  	ent->total_mrs++;
>  	/* If we are doing fill_to_high_water then keep going. */
>  	queue_adjust_cache_locked(ent);
> -	ent->pending--;
> -	spin_unlock_irqrestore(&ent->lock, flags);
> +	xa_unlock_irqrestore(&ent->mkeys, flags);
>  }
>  
>  static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
> @@ -196,12 +199,48 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
>  	return mr;
>  }
>  
> +static int _push_reserve_mkey(struct mlx5_cache_ent *ent)
> +{
> +	unsigned long to_reserve;
> +	void *old;
> +
> +	while (true) {
> +		to_reserve = ent->reserved;
> +		old = __xa_cmpxchg(&ent->mkeys, to_reserve, NULL, XA_ZERO_ENTRY,
> +				  GFP_KERNEL);
> +
> +		if (xa_is_err(old))
> +			return xa_err(old);

Comment that this below is needed because xa_cmpxchg could drop the
lock and thus ent->reserved can change.

> +		if (to_reserve != ent->reserved || old != NULL) {

WARN_ON(old != NULL) ?  This can't happen right?

> +static int push_reserve_mkey(struct mlx5_cache_ent *ent)
> +{
> +	int ret;
> +
> +	xa_lock_irq(&ent->mkeys);
> +	ret = _push_reserve_mkey(ent);
> +	xa_unlock_irq(&ent->mkeys);
> +
> +	return ret;
> +}

Why not just use one function and a simple goto unwind?

> +
> +		xa_lock_irq(&ent->mkeys);
> +		err = _push_reserve_mkey(ent);
> +		if (err)
> +			goto err_unlock;
> +		if ((ent->reserved - ent->stored) > MAX_PENDING_REG_MR) {
>  			err = -EAGAIN;

Maybe this check should be inside push_reserve_mkey before it does any
xarray operation?

> @@ -286,40 +335,42 @@ static struct mlx5_ib_mr *create_cache_mr(struct mlx5_cache_ent *ent)
>  static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
>  {
>  	struct mlx5_ib_mr *mr;
> +	void *old;
>  
> +	if (!ent->stored)
>  		return;
> +	ent->stored--;
> +	mr = __xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY, GFP_KERNEL);
> +	WARN_ON(mr == NULL || xa_is_err(mr));
> +	ent->reserved--;
> +	old = __xa_erase(&ent->mkeys, ent->reserved);
> +	WARN_ON(old != NULL);
>  	ent->total_mrs--;
> +	xa_unlock_irq(&ent->mkeys);

This should avoid the double XA operations if reserved == stored.


> +		mr = __xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY,
> +				GFP_KERNEL);
> +		WARN_ON(mr == NULL || xa_is_err(mr));
> +		ent->reserved--;
> +		old = __xa_erase(&ent->mkeys, ent->reserved);
> +		WARN_ON(old != NULL);

'pop' should really be its own function too

> @@ -601,41 +655,35 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
>  static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
>  {
>  	struct mlx5_cache_ent *ent = mr->cache_ent;
> +	void *old;
>  
> -	spin_lock_irq(&ent->lock);
> -	list_add_tail(&mr->list, &ent->head);
> -	ent->available_mrs++;
> +	xa_lock_irq(&ent->mkeys);
> +	old = __xa_store(&ent->mkeys, ent->stored, mr, 0);
> +	WARN_ON(old != NULL);

This allocates memory, errors now have to be handled by falling back to dereg_mr.

Shouldn't this adjust reserved too?

Jason
