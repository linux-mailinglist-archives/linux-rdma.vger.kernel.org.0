Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B946D8CA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Dec 2021 17:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhLHQtr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 11:49:47 -0500
Received: from mail-bn1nam07on2054.outbound.protection.outlook.com ([40.107.212.54]:27711
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232343AbhLHQtr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Dec 2021 11:49:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F14ZA9+avqRALcBPWICCmkm+YXbz4a2bwmo1GSuEsXEA/G0AsXI/KVmQObBHWiVjZvNv1qo6g73nJ+ArzEC5DoOlV88LEn+YtJ4tEjaJ2qrx62Boc4DjR9gaSAmEYnk5mY5He80EVjEWATtphHQf+WwtSxz6YzkvB7gvQ0UBFtAU7kmiWuyRBS/gKIhvlmtu6z2MBxQeILj3ChiSrlW5xXO71yeLmSyEX929by9B0IrM++6/WU22wm8+sP9SXFS0lZZ0GcSWeGjfxA3RT7XQpuxccHGWMAEgHdHkhhMHg1v6I+pMzTf5ivSVX97RkHzmV1Rm+EL95Lvea/If/mO+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmCBVWtcDAX382j05d9K0+bSBr601xyyxOd6mqScVdQ=;
 b=D5hGTf3MupLkgxI+WSgHQ9OLZXtL3jrMU4wq/BrpzDuh3ASWDft/5NRdlXSwkXou+jgMYGrWc2dPd5kA2/0MMsTkbDLLIQNgS7jfA5XD8eJ/VASm/MN6xcdO1+GyLF7A4MQ2Ct4od1AfRRLE14MmR55QC6y5hVfBEtHg90IWp885aP9ZGS4V6wdBsnCRZERWoNbuogHTdzVnVsJ3Zy7fBbgzA6UMOCVu7tufzvmJ6AdBXR3hID83YlmbIz0KPzwkXkPaEiIe5LaQ3uOkM3RDo+xPIrtVBMLBBOxG4kIb4Qh8K3XvZDGMiUN8vU+lWNnqFoHYXh/ZdSRm5hGyOZ0AFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmCBVWtcDAX382j05d9K0+bSBr601xyyxOd6mqScVdQ=;
 b=uFX7ie1h4ucevqyrCLR9W37c8gvSa51reizMY2UkwVxs57nTq5p4hEjm8puKyEILwIhoLyGDyA06MmCuDyJyVtVeKpk0FlP7oOKa8KZjvVgtog+cPuKIfnfpBO9SsWqUyO+x7EmBu2u0Wm53PfFEcDS6lrAoeZoMv8oGUs95dn1Z3Glnbno1ilbzk/cADw1e61O1nowB5F94RXLIj+/vt5EeA8PmFY98ycHCLLcfG88ech+PfrmNUAeey1cn71MOqDHV6KGbBGn3qBFHs/Pgy1Yh3zquaeqmV95F3KcLIwMGpSVGquPo84Ujt5OMdtnw0brdY9RddxgBDRFUwbXXKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 8 Dec
 2021 16:46:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 16:46:12 +0000
Date:   Wed, 8 Dec 2021 12:46:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/7] RDMA/mlx5: Replace cache list with Xarray
Message-ID: <20211208164611.GB6385@nvidia.com>
References: <cover.1638781506.git.leonro@nvidia.com>
 <63a833106bcb03298489a80e88b1086684c76595.1638781506.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a833106bcb03298489a80e88b1086684c76595.1638781506.git.leonro@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9ab0b0c-d866-4515-462a-08d9ba6a3e5f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5048:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5048D99CC30A81EF80DE421CC26F9@BL1PR12MB5048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3wJV5u1FHYRoQGabQF6PL1Ya5ChNUOQInViO2LK+lbzxgNcBQBnbkDEvNYzQZj1TqIvdUJVZSWUaGI+a+RxsLC2quQ3DgLM2LpHOIsF3JjVXCnww2oWrVhkywjul3TLjErGpYDXhZBdYK6YqM3LiMGDq3zwPejgG81H9SnTrZNvfK1MYu+sEOwWgQQvKGUCzDYVKRXMpHoBa2e4krdpbtzamjXG0KKUIP0yCfH9TE3lKIfTdgb+UIStVLFs1/lbq/KRRHNXKSABrbUYwPqaH0uvg/wNsNs/7g3QRV0kCQd3OhF9waWqldR5mBHp82exbbiJ2xqtsGcQUulr10oKxLgaZi9Iy1ui2ns9l+hXEMFl48lj7OiloF8c+TNsfgGzp+HSJs2/5qvtqO8dmmMqL5jwTQUx5S3Eyvk6KBdxsq2ikhNYbEuTjuC+0owKoAycQLnIWXq888DCob4sZv8smrXhHl38HkXnsdCV+6xaFBURuBheJVwiNEuaTNY7O7Hfonkv0h8HHu0+lmLxOtkFkmBpdEwC10z5bBbqbRVAvPwKehp6N2c5QjhJ7WJ7qB92/WyzW9bwdaOErJfUD8HUoGxS6XKV/2PN4XllO4SoE4RJzB4nNLspk6kyxwJd3jWgL6u0XFmYJn7G046+BN4Pnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66556008)(6512007)(5660300002)(36756003)(4326008)(66946007)(86362001)(8676002)(2616005)(66476007)(6916009)(1076003)(26005)(33656002)(8936002)(186003)(508600001)(6506007)(83380400001)(316002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdYhKW2ztrCe+tQcdWjuODZM9fCiYT/5iYxMLcnBmPSKeAeJ4AuSazTwGIdl?=
 =?us-ascii?Q?f2ci3INydBV/XaILX4NDAxe+Zo+Qufg2InDqXv+RvGa9OEa00Qx2mEpXAknK?=
 =?us-ascii?Q?Nv+YqnCZh4tvA+lOKAXDnv69uADuvrwNkhSP05ju9I/EIV1Uxb6Hr+r2PwyW?=
 =?us-ascii?Q?SH9ZkZY3ELMC6siSW6y/SbX1IcePwdRNg/Wcn1VPwSi2e5Dkw0MRXMgbNMiW?=
 =?us-ascii?Q?/Lm3FGRblgzcZAeuW/j7B3wO0U/weThVs+0xgUbX3vojhUmpa9njA+wXXl/V?=
 =?us-ascii?Q?jUIymczubYPARKeW9B3sIH0HZkX08RsDn+eyCAAo6YXOOF6fXElo4pPoSsxe?=
 =?us-ascii?Q?c+I57XCy9rXpvTApn+bXOwe6ZOdi1R7dbo8Z5JxBHBqmqUntTeqDFu6Y9HlW?=
 =?us-ascii?Q?gxR2xaIvoWBM0SyjbWNCfbnbz6ciN+oXn1g0GhmxqOb4wXTCjgPf1ico+mp7?=
 =?us-ascii?Q?GnoPHU54BRe3mjP5CYLcIEdHiq2rE6GhmCoPzJfST8XhtipFlIsNP456Iwfg?=
 =?us-ascii?Q?x8XT1krxXmTJyzlPiWiIGZ2Mvpj58GKCiUcZRwtKWrNcCsF+A5tOgnzhNig6?=
 =?us-ascii?Q?PhWsgcwPWzn6DxL2AC53UQbxfHm5jHYfaIMUlefOMytQydTWSJDb2dHUcT55?=
 =?us-ascii?Q?jC8uaME7XAm8HDWpiGg9rXEdgdTicer0uARtmGmAx4BYgIUT7LsE2A/WnfNr?=
 =?us-ascii?Q?c/3i9+5eNYj79uDMiux615gc7IRRrEVg2bIcbK+l3r0Yyki0fXRYzshneIAr?=
 =?us-ascii?Q?qEVL2BDhr5yatMtM7bGGUjJI7gaCXXIHbrmkiwiDL9+DUEHucm3a2dtnjTcc?=
 =?us-ascii?Q?xtHJuipW/MKEjRZjS4+vScWSvz/jVa4/yGvUhqTewi73i0vW3ApPyJBz27XN?=
 =?us-ascii?Q?VudjbMsF0jMiHi3c6Y3i4acrwZNodZfB5CYgkPZrod/GFXD+5t4V58MRJZsf?=
 =?us-ascii?Q?kwSzDhThvLWIPcIVwc32Fr1pWpaAcvzqt7tnCe/Z1CYfxjS5relGTqtWetzI?=
 =?us-ascii?Q?v7mVcUuqS+r0QzftaMBVTBwaGRBnQVZhHJlV9itsn7d8hxDA9cVF1vSyS8hy?=
 =?us-ascii?Q?3IvnE27/94w8GXn8btoTdR9ewkBegeJU+d/Cv5G7Udpn5eXkV/6xelkKuuio?=
 =?us-ascii?Q?cqctV1KlHOvfaDmYGJEywkiou4Cd5vQ2JurdpeRsSIuNXiCnHeGmta3ZFhJm?=
 =?us-ascii?Q?eg31v5pvbtTioUvdV5m5hgdkt5H1A0PDQV0VoiF08UMZjlkiaHgDPWF58ZDK?=
 =?us-ascii?Q?7BiKkutYVUJgIQJACcoh4ffadCusGGgArSne7gi4TZd8uU9qv2VqU3HxQI6e?=
 =?us-ascii?Q?wa6g22H15TWVdiB3hc51wVMX48doxR8qRKogIQMcJdCIicsC+1XGUlWwmtXG?=
 =?us-ascii?Q?gt6AlRnBvR41Bxs5gSkeDOCMOlrmyC+UCq2zJh/tgPb1EQrFTcpy5hC80EfD?=
 =?us-ascii?Q?0uQaaGGtWHdXBoWO77f0tm7mwns10E7Lc3maXJW8C9K0I2ELPlENVQRMsNEs?=
 =?us-ascii?Q?jlUE7Zyah3L2c3D0ghMQT4yVnDggTi9Fdsno47muKOtSB0wVnrmUAUb9dSNv?=
 =?us-ascii?Q?awxcIISqAfcX4W/KuUI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ab0b0c-d866-4515-462a-08d9ba6a3e5f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:46:12.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3CK5Kqd5A1qZgcIc3CWHu4uCOBQ0FCfPwpiDadJO0MFUceN15NopHZHB6Djel1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> @@ -166,14 +169,14 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
>  
>  	WRITE_ONCE(dev->cache.last_add, jiffies);
>  
> -	spin_lock_irqsave(&ent->lock, flags);
> -	list_add_tail(&mr->list, &ent->head);
> -	ent->available_mrs++;
> +	xa_lock_irqsave(&ent->mkeys, flags);
> +	xa_ent = __xa_store(&ent->mkeys, ent->stored++, mr, GFP_ATOMIC);
> +	WARN_ON(xa_ent != NULL);
> +	ent->pending--;
>  	ent->total_mrs++;
>  	/* If we are doing fill_to_high_water then keep going. */
>  	queue_adjust_cache_locked(ent);
> -	ent->pending--;
> -	spin_unlock_irqrestore(&ent->lock, flags);
> +	xa_unlock_irqrestore(&ent->mkeys, flags);
>  }
>  
>  static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
> @@ -196,6 +199,25 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
>  	return mr;
>  }
>  
> +static int _push_reserve_mkey(struct mlx5_cache_ent *ent)
> +{
> +	unsigned long to_reserve;
> +	int rc;
> +
> +	while (true) {
> +		to_reserve = ent->reserved;
> +		rc = xa_err(__xa_cmpxchg(&ent->mkeys, to_reserve, NULL,
> +					 XA_ZERO_ENTRY, GFP_KERNEL));
> +		if (rc)
> +			return rc;

What about when old != NULL ?

> +		if (to_reserve != ent->reserved)
> +			continue;

There is an edge case where where reserved could have shrunk alot
while the lock was released, and xa_cmpxchg could succeed. The above
if will protect things, however a ZERO_ENTRY will have been written to
some weird place in the XA. It needs a 

 if (old == NULL) // ie we stored something someplace weird
    __xa_erase(&ent->mkeys, to_reserve)

> +		ent->reserved++;
> +		break;
> +	}
> +	return 0;
> +}
> +
>  /* Asynchronously schedule new MRs to be populated in the cache. */
>  static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
>  {
> @@ -217,23 +239,32 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
>  			err = -ENOMEM;
>  			break;
>  		}
> -		spin_lock_irq(&ent->lock);
> +		xa_lock_irq(&ent->mkeys);
>  		if (ent->pending >= MAX_PENDING_REG_MR) {
> +			xa_unlock_irq(&ent->mkeys);
>  			err = -EAGAIN;
> -			spin_unlock_irq(&ent->lock);
> +			kfree(mr);
> +			break;
> +		}
> +
> +		err = _push_reserve_mkey(ent);

The test of ent->pending is out of date now since this can drop the
lock

It feels like pending and (reserved - stored) are really the same
thing, so maybe just directly limit the number of reserved and test it
after

> @@ -287,39 +318,37 @@ static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
>  {
>  	struct mlx5_ib_mr *mr;
>  
> -	lockdep_assert_held(&ent->lock);
> -	if (list_empty(&ent->head))
> +	if (!ent->stored)
>  		return;
> -	mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
> -	list_del(&mr->list);
> -	ent->available_mrs--;

> +	mr = __xa_store(&ent->mkeys, --ent->stored, NULL, GFP_KERNEL);
> +	WARN_ON(mr == NULL || xa_is_err(mr));

Add a if (reserved != stored)  before the below?

> +	WARN_ON(__xa_erase(&ent->mkeys, --ent->reserved) != NULL);

Also please avoid writing WARN_ON(something with side effects)

  old = __xa_erase(&ent->mkeys, --ent->reserved);
  WARN_ON(old != NULL);

Same for all places

>  static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
>  				bool limit_fill)
> +	 __acquires(&ent->lock) __releases(&ent->lock)

Why?

>  {
>  	int err;
>  
> -	lockdep_assert_held(&ent->lock);
> -

Why?

>  static void clean_keys(struct mlx5_ib_dev *dev, int c)
>  {
>  	struct mlx5_mr_cache *cache = &dev->cache;
>  	struct mlx5_cache_ent *ent = &cache->ent[c];
> -	struct mlx5_ib_mr *tmp_mr;
>  	struct mlx5_ib_mr *mr;
> -	LIST_HEAD(del_list);
> +	unsigned long index;
>  
>  	cancel_delayed_work(&ent->dwork);
> -	while (1) {
> -		spin_lock_irq(&ent->lock);
> -		if (list_empty(&ent->head)) {
> -			spin_unlock_irq(&ent->lock);
> -			break;
> -		}
> -		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
> -		list_move(&mr->list, &del_list);
> -		ent->available_mrs--;
> +	xa_for_each(&ent->mkeys, index, mr) {

This isn't quite the same thing, the above tolerates concurrent add,
this does not.

It should be more like

while (ent->stored) {
   mr = __xa_erase(stored--);

> @@ -1886,6 +1901,17 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
>  	}
>  }
>  
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

Put this close to _push_reserve_mkey() please

Jason
