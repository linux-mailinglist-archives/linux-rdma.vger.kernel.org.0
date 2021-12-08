Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD4C46DD5F
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Dec 2021 21:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhLHVCG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 16:02:06 -0500
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:12192
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236037AbhLHVCG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Dec 2021 16:02:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOeL3yMhAtxHGXvJg869efGaBhdh0/93qcC3e4mDgG+kOmy+XKcsnOvnwZHXXH7pKNNHfhYVj349ObHmfV8V2nziR04vL5BEXi4X/ViaaKlypPxCLn/ZhkzX815pWEmnVhY0iRNN/l5xX7edeEKwodYEXXfXLjUevhKDRsGM+tr8cRklr+GZ9qmiFjdhLp8aniCo4QnlHoddHCnGeX9Gi9gmf9DJ8Mwb4gbe1BODwQSlwDT2N2yZYuM2UM+eIC5TF6h9tQs5N9Jqwcu96WEIkFIud54c37S83k7pZyK/ZfC4x+1BuzDix8RhoAQmwpf2jNzWw8xmSEZnqG0QaFVf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtCSOqgbanTt6C+Pj0Prpj8AMvLasyn9Wjc4vtri07Y=;
 b=gPLCI3051xRjEUt+pBcnzF68Uv9YhVdorsuRtWTB6XrKjnEQ6Pir6VC+zPN5NNGNtp/jFogSV3AQe2Hq/JF/L9rZQ1DP58n9iL1k4qAcfxlpVZTbgNJiXxxVA6jlOqk/YiysMJszDhkM4zM5frGDcXhUfff2CeTXpMO9mUsw8Fqo/VXXa9oZvDQyzDrJpHQ00ziHbxn2tETNjKn+zmU4pVEXT8ygxU/faESNOt16M2odawolCaUwcHyVNhVy53nUk3JJCMuANheJRXhqXKUqjLQVbtIp4LhZyaCYWzYz9oeVvKmJiI6DB3aJWS01lYWbNcJrvyplKu2nGI3BXZ5VWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtCSOqgbanTt6C+Pj0Prpj8AMvLasyn9Wjc4vtri07Y=;
 b=Yrgy4wdSiW/UilC4xEj35MH+ttFu4pZ/89NgPQE/uhhlzWPlkDoxQcWYVf5g8UCXZWIZAQpNrtuNtW0xIuLfNKX/QHR+ZU1A4rXO2APs+tfmsbbDT87Enu5n22eWNRu0QmilXpOzYOmBV0yOLy0lJbI7vt45Mu2XL/O66AvnfybC3pJTuYbmfr0g6gm9G8Wk8SEagdoKxObYeEiIBt9lz0YU11KsfW0f5pgv2Ib5Robfddc1EOE/bykHejabaeRYieAhsbqtdwUfsKwnRJH/donJ3waeq/o/8Y3Dk/hkDfhjvXWf9rX6QdsRHU7X2KPDGs1NYZxC8E8VcEASL5nkjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Wed, 8 Dec
 2021 20:58:32 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 20:58:32 +0000
Date:   Wed, 8 Dec 2021 16:58:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/7] RDMA/mlx5: Change the cache structure to
 an RB-tree
Message-ID: <20211208205830.GH6385@nvidia.com>
References: <cover.1638781506.git.leonro@nvidia.com>
 <3afa3e9b25bb95894e65144c3fbbc5be456d7c16.1638781506.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3afa3e9b25bb95894e65144c3fbbc5be456d7c16.1638781506.git.leonro@nvidia.com>
X-ClientProxiedBy: CH2PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:610:56::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52bd3641-bbc7-4fc9-03e4-08d9ba8d7e37
X-MS-TrafficTypeDiagnostic: BL1PR12MB5223:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52233C474EDBBCCB52E44BD3C26F9@BL1PR12MB5223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kfxyb0BXmdZURzERt1mccj8JIcQMJ63DCiOlfjOF4IVazouqa4mxjVc6l85gLJorMGD9eZzDj5XeQ6DWJUmqHN5u7chEHyeR7NEASCx77eSgYpNKnV2dLkeuAHTCNGHIOAeLCMMZ9LqqT61ql3YsT6kEKt8FEm0oQDslLAwIoYBxyxWwydTR3PtElDpddUWmjZP77lctj2bG3SBz8y9SqLWoM+BbFRSkNBGyyF5d6jiYjujWOW2LS8j9lpDbzEgLt0VaYc8ceIN3jG4Lx7vZrdjZiqUcMR+JuutpzIW9SNy720oWBga4OWiTOGqwBXotFYNSjS6cTdGeY+gvRGsutDPP0m1uBIvAgVy08rrMJK/czUab+Gd00hC7kwB0cc17mr0IpRBYoDNqeXc9Mb1caY8LuJrnAMDa3AmDgD+kADbpVSpB2ynviCtLcf+6qoVtzEmg+oQPw9GwDnM+M5BROppZqwPkcQRNYlEwebuZMvM9W8vzwHCEBIzMl4sDltSlRHHPWlmJ3T+vIprvQpG7mbVDWO1A5tfUy7IQ7yjRdJ3xx7rRC4faXp0P/2dNUJyhbw/aszHojoL3+OA73+jXNs6CF2oktkgfxykSfcLd2iNPmJ4m5Tlhopnq0hLEZjX88QLOSFg/JuXEb8r8krGA1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(6506007)(508600001)(66946007)(6916009)(6512007)(8936002)(86362001)(8676002)(2906002)(316002)(33656002)(38100700002)(26005)(83380400001)(6486002)(36756003)(1076003)(2616005)(5660300002)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DmJNBGIS7mCPbrPjzpIAEcR6K2EFKi7d9NIbSk3hLxw/aA1azonnMmNqJ+xx?=
 =?us-ascii?Q?QLmJ1UhuJpy7anzBR3aVAzQQd6+D/lvhNWifGjZDLqXSYRSL8kjo5m+CmPAa?=
 =?us-ascii?Q?Hiq3TnVw9qYnPvglsXM5ZxLsG96EP/+3WalXRbWQYK4TbkDLks/usxQo27qV?=
 =?us-ascii?Q?dzhUvY8QHJMMDVGGbTcZpOAlP+/EyaV5wSitbU5Dsn7/+OKSKILOnPGjr+RD?=
 =?us-ascii?Q?RAXCdPpV8dCNFBolMU0rEtpxYYpIhGU2cy1EMJtk5n9nhBLx6jqtUlIHmfd4?=
 =?us-ascii?Q?cHPg6xjSgkKfeeu+gA8ajEGIsFjaM0RdA4GRpzY1MxTEw2sjoRgilTZJ9NQ9?=
 =?us-ascii?Q?jV8/W62iCmDBuqB5mOLLQzB/UR7sRnx0VCzV1YyQvxS4g6MX19qXjw3/wiN6?=
 =?us-ascii?Q?gjYYMWgtmMeTU1Nu8H7Fk2TPg4BLcx+HO8ZHawpAucT0/MUf2ymMXz31OJeK?=
 =?us-ascii?Q?q/LdDsgazgZg53+34yAM8t/8uCtfWtuayleVV6uGy0XZGaS5fZoBdYxzXi5y?=
 =?us-ascii?Q?y9RkFTG6vxrv+4KNvFHve9v+QEIeGj8DtyyDHu+BFWI8CAw+USW740aUG813?=
 =?us-ascii?Q?6qexsV4bOpWSsedkXb0n5VnyumUhwjfaXU+dWehjgEO9TSy4v8jsHtIb0n0+?=
 =?us-ascii?Q?mfqNv/tQYTUTN67S6OTu1MZkvYGC3o+yMXfQDZ3d/SjBo5BxzyOZAo+fVAJG?=
 =?us-ascii?Q?460CZ86y4sIJG+ylhGHUSp5jtgdqnOnmTKcmk+uC1L5syY9dba/Z8gos+Hp1?=
 =?us-ascii?Q?enTcbaOFcCGTNH8QleCz8acanKsoXGYnhC8p4zfHviTvcXVWlk4uXvFg4aZw?=
 =?us-ascii?Q?WbtH6T0pVuiqfBkPhJrJNtx8zl7ExlGDZkuVBz+eFVF0xYIITP3EXAx7lUjI?=
 =?us-ascii?Q?juNDd5DbgQfgn4McXlDSJreSeLQ19RL4m4ya8JGaGd3QCMfqhMXhGFIoeIB4?=
 =?us-ascii?Q?vXSoFV1fnLpXZp6mWFtmsxmFDy31voG0MRLTWnA4oUBFyHD5xVHTUM+cMRam?=
 =?us-ascii?Q?JtmcQHwjW2va9Vzv7NEPdhnPxEPYDGlWEU3qAmhXJV43iZ9TCVhQI/cf2Zm5?=
 =?us-ascii?Q?acaoZBw/2iKojvHJ8ba/cLV0zYGa5ylg1k8fgdyuyLyT6ykdXkhOBdg1Co4R?=
 =?us-ascii?Q?ULGRMqE/604Ogv7TgAfXNaF3J9bJTTanKB+IK2sD8RegeDTNL1e7XAKM37Et?=
 =?us-ascii?Q?zat08hE3O/8+Mu3oXdC8uQDSA1EpW+UFrX2eWX3Wk8wDjRwLhsvChxUV784Y?=
 =?us-ascii?Q?8frFCQqL95RPTfsgoaxpzO0+YzQwVU2emls7CGhCJwhAkjuE80FBJ1vj3fc+?=
 =?us-ascii?Q?N3RNH1N5zMhD5WGqA29lVqsZKtGxbuG3EAFyb6xWI+196fKSqaqkNEji/oL0?=
 =?us-ascii?Q?+0H4yZTd6SR90AfP8UU0S6BLxBwGuUb/QSZnGh6i4yxH/n/B/+OI3aoyBRul?=
 =?us-ascii?Q?pddX2S2mzSCP0ygWy6kgWMNRLq6NX1VMCtiRSInoUxoTRSUCEJ1gmocdvmP4?=
 =?us-ascii?Q?ML+gi73L3O4fZLCPAj5hnzJvhxS1Lbn5O0ac9PgZTRKHyV4JLn6zpFZV7XaC?=
 =?us-ascii?Q?mgAqhZXbrhSZd7BVkgk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bd3641-bbc7-4fc9-03e4-08d9ba8d7e37
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 20:58:32.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLMQ5ZaYCxurLvdXd3S8MXej3wuzBYeVU7+6k+BoHyFLG3YcGAKPleuFlqWKaJzp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 11:10:49AM +0200, Leon Romanovsky wrote:

> +static struct mlx5_cache_ent *ent_search(struct mlx5_mr_cache *cache, void *mkc)

mlx5_cache_ent_find() ?

This search isn't really what I would expect, it should stop if it
finds a (somewhat) larger and otherwise compatible entry instead of
continuing to bin on power of two sizes.

> +	struct rb_node *node = cache->cache_root.rb_node;
> +	int size = MLX5_ST_SZ_BYTES(mkc);

size_t not int

> +	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
> +	if (dev->cache.maintained_cache && !force) {
> +		int order;

unsigned int

> +		/*
> +		 * Try to get an mkey from pool.
> +		 */
> +		order = order_base_2(ndescs) > 2 ? order_base_2(ndescs) : 2;
> +		MLX5_SET(mkc, mkc, translations_octword_size,
> +			 get_mkc_octo_size(access_mode, 1 << order));
> +		mutex_lock(&dev->cache.cache_lock);
> +		ent = ent_search(&dev->cache, mkc);
> +		mutex_unlock(&dev->cache.cache_lock);

Why is it OK to drop the lock here? What is protecting the ent pointer
against free?

> +	if (ent && (ent->limit || force)) {

What locking protects ent->limit ?

> +		xa_lock_irq(&ent->mkeys);
> +		if (!ent->stored) {
> +			if (ent->limit) {
> +				queue_adjust_cache_locked(ent);
> +				ent->miss++;
> +			}
> +			xa_unlock_irq(&ent->mkeys);
> +
> +			err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
> +			if (err)
> +				goto err;

So if there is no entry we create a bigger one rounded up to pow2?

> +
> +			WRITE_ONCE(ent->dev->cache.last_add, jiffies);
> +			xa_lock_irq(&ent->mkeys);
> +			ent->total_mrs++;
> +			xa_unlock_irq(&ent->mkeys);

May as well optimize for the normal case, do the total_mrs++ before
create_mkey while we still have the lock and undo it if it fails. It
is just minor stat reporting right?

> +		} else {
> +			xa_ent = __xa_store(&ent->mkeys, --ent->stored,
> +					  NULL, GFP_KERNEL);
> +			WARN_ON(xa_ent == NULL || xa_is_err(xa_ent));
> +			WARN_ON(__xa_erase(&ent->mkeys, --ent->reserved) !=
> +				NULL);

This whole bigger block want to be in its own function 'mlx5_ent_get_mkey()'

Then you can write it simpler without all the duplicated error
handling and deep indenting

>  			queue_adjust_cache_locked(ent);
> -			ent->miss++;
> -		}
> -		xa_unlock_irq(&ent->mkeys);
> -		err = create_cache_mkey(ent, &mr->mmkey.key);
> -		if (err) {
> -			kfree(mr);
> -			return ERR_PTR(err);
> +			xa_unlock_irq(&ent->mkeys);
> +			mr->mmkey.key = (u32)xa_to_value(xa_ent);
>  		}
> +		mr->cache_ent = ent;
>  	} else {
> -		mr = __xa_store(&ent->mkeys, --ent->stored, NULL,
> -				GFP_KERNEL);
> -		WARN_ON(mr == NULL || xa_is_err(mr));
> -		WARN_ON(__xa_erase(&ent->mkeys, --ent->reserved) != NULL);
> -		queue_adjust_cache_locked(ent);
> -		xa_unlock_irq(&ent->mkeys);
> -
> -		mr->mmkey.key = (u32)xa_to_value(xa_ent);
> +		/*
> +		 * Can not use a cache mkey.
> +		 * Create an mkey with the exact needed size.
> +		 */
> +		MLX5_SET(mkc, mkc, translations_octword_size,
> +			 get_mkc_octo_size(access_mode, ndescs));
> +		err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
> +		if (err)
> +			goto err;
>  	}

I think this needs to be broken to functions, it is hard to read with
all these ifs and inlined locking

>  
> +static int ent_insert(struct mlx5_mr_cache *cache, struct mlx5_cache_ent *ent)
> +{
> +	struct rb_node **new = &cache->cache_root.rb_node, *parent = NULL;
> +	int size = MLX5_ST_SZ_BYTES(mkc);
> +	struct mlx5_cache_ent *cur;
> +	int cmp;
> +
> +	/* Figure out where to put new node */
> +	while (*new) {
> +		cur = container_of(*new, struct mlx5_cache_ent, node);
> +		parent = *new;
> +		cmp = memcmp(ent->mkc, cur->mkc, size);
> +		if (cmp < 0)
> +			new = &((*new)->rb_left);
> +		else if (cmp > 0)
> +			new = &((*new)->rb_right);
> +		else
> +			return -EEXIST;
> +	}
> +
> +	/* Add new node and rebalance tree. */
> +	rb_link_node(&ent->node, parent, new);
> +	rb_insert_color(&ent->node, &cache->cache_root);
> +
> +	return 0;
> +}

This should be near the find

> +
> +static struct mlx5_cache_ent *mlx5_ib_create_cache_ent(struct mlx5_ib_dev *dev,
> +						       int order)
> +{
> +	struct mlx5_cache_ent *ent;
> +	int ret;
> +
> +	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
> +	if (!ent)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ent->mkc = kzalloc(MLX5_ST_SZ_BYTES(mkc), GFP_KERNEL);
> +	if (!ent->mkc) {
> +		kfree(ent);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	ent->ndescs = 1 << order;
> +	mlx5_set_cache_mkc(dev, ent->mkc, 0, MLX5_MKC_ACCESS_MODE_MTT,
> +			   PAGE_SHIFT);
> +	MLX5_SET(mkc, ent->mkc, translations_octword_size,
> +		 get_mkc_octo_size(MLX5_MKC_ACCESS_MODE_MTT, ent->ndescs));
> +	mutex_lock(&dev->cache.cache_lock);
> +	ret = ent_insert(&dev->cache, ent);
> +	mutex_unlock(&dev->cache.cache_lock);
> +	if (ret) {
> +		kfree(ent->mkc);
> +		kfree(ent);
> +		return ERR_PTR(ret);
> +	}
> +
> +	xa_init_flags(&ent->mkeys, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
> +	ent->dev = dev;
> +
> +	INIT_WORK(&ent->work, cache_work_func);
> +	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);

And the ent should be fully setup before adding it to the cache

Jason
