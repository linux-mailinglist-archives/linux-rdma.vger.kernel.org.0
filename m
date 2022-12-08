Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6664660A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 01:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLHAji (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 19:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLHAjg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 19:39:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA628D671
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 16:39:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo9gzRpwr+1IBeyN8GgJwdt7rVK5UMrCfNMFDa5nFG2nVHfL3oaQ/eF/gp5e4LMQG5FhGURZvxVjsZ/0+F7z+WDnEBxciRG1pgRvV1bI/LzTMY7Xx3ahMTBYarhplsrHFcE4xePFgbX13S7SJXY5wWEc6JsRocEIY52b5Ljy+UhWYHWE5PF7O93kqIrCVO9vF+KoLhAtduZ5cs+ZY5GvtqVW0RkHPuHlAYGwKEEYcz5WkJCvlb4RDgHdeL/AFGHPdwXCJCgc+vxkAlnDt3uCQqt9M6j72hplMwByFavS+3d//8AhyVyIgzDXIkFcweQXR+baPUwaXzrs12OToCcGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0bkEIag/+/R4dctCXqp18BcjObLs+pPh1J1LBLzhGk=;
 b=ClVisjgKBhE6x9gyRufOKbrKWLazpzp8mA1kxqdeZ6cNxhLzeYxARFUB8U+eFO9W3WseaY5zLGcaPKfk61Qs5iLb/MMhWZQduFf7uIU5Jqrj4nB9Ho4UJj8FIBWJfIq3JKUlJJx50AIH+vZ1UXzrouFhZ3dsGwiF1zr5/RgHcuH4wmhuAU0rpQ0aOa46CM67cLFpzVUfpG/TDaNL1qNgwSv8ZODuLsI0TxGH2DA9FAwX2mJhCt/H8xriINi6NUW4GThKqY9vFnPH8vb6HUMh97sPBBou9IeUwaDZbKaTb6ngJqQ80P0M3Kqi3yoBzXB4IW7lIMMLuIPz4c1tjWklPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0bkEIag/+/R4dctCXqp18BcjObLs+pPh1J1LBLzhGk=;
 b=Eha50/Z1pbbwkFgMqX21LdHVGffPmlU9TadoVjsYrZQ3i7AnMJJlAn9jnrwaUhQD0BpR66z2nyHT1sv9IDPl3CXezwQucE8s4+xcaR0rZXIdISPOgcrLYdUEwXRd1wq0FERJandKjuzFobGqfxIwDPYCKopoM84xDsp7f6ln83+3GqPwwz3S5x86YVYLktPvIPReV4xBMKsqzJHF5eFLw/b95yli8kjmVq+ewGc422mtmduMstVBxBBzFmG483h1nyhBBnckOxonIpHOL6kCJAnPUSwezhaMI1DuYitgJvrkeAsmHQPxUgwQF10Za5t/jH4wDxJjD2YaqdhnBIDK5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 00:39:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 00:39:32 +0000
Date:   Wed, 7 Dec 2022 20:39:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com
Subject: Re: [PATCH v2 rdma-next 4/6] RDMA/mlx5: Introduce mlx5r_cache_rb_key
Message-ID: <Y5EyQ+VFbEmbe+W+@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
 <20221207085752.82458-5-michaelgur@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207085752.82458-5-michaelgur@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:208:329::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: ef834cf3-3116-493b-0995-08dad8b4ac77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1Phd5uc4XV6UVMuKwu5TNcyW1NVyJQepq5CADNQ3wXgtoQPyCASeqZx5Cg7kf0uPB0d/zBhLHKyLMSVAncgmvO8JUQxV7LO3eOnHRxb1R/ZyK8M9i+cWp1oqrXuqh3HfxYDpasS4kt4phEGYteQ1lRqmzjNBDBE7MKyzo1WBm38AsJuvXKGWYShW9E7ME1CA4Q3VxnDXZuJYvSeVGUzgg1Xf1p0CtwUjGSeq748evuTQvhC/D7Ib5peQjwMJCWzpvWP5fxeBjej+lDDOUS7p6XdtUeNN7GWORlPROPRoYaj4U511AIRUzob4HgeNz38j4T5HNI+M8GfUDKO4bJC2HV2CrHwwXjdm3qOfafLktgadsh/uSBtZSet6TNjpkxjEyu0iwv4GPKR0fDzowIy9XetsK1MfETxnuQIzzh4RaTzjiuOxR510TOC6WbGo3sdvRQ5KFxuOyp2Ky8sryvOJuo0xCYsxsg4AaboHxDTG/RV5Wmpo2WhTJVovoUwtQQ1V6rPtXjh+bmdMcK5UoeaS19LHqsfpVyqtnV8ap00UoKB4mwdheJGSpfTEp/LCMbcEESDvCwouJQtECVZotVlBMTTR9Czf+ZFvojVfFwk5GanUCKx3cWx4C9CNxFahuxY08qyGYGS1bJ5tqE66vtezw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199015)(86362001)(6506007)(478600001)(6486002)(36756003)(186003)(38100700002)(83380400001)(2616005)(6862004)(316002)(4326008)(5660300002)(6512007)(41300700001)(107886003)(66476007)(8936002)(26005)(66556008)(2906002)(6636002)(66946007)(8676002)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Hb7XotbrapZEl6mH5eSlp+R3eGBCAvmhWTMyyyXVUTIFnMLyhqbBiHX/i18?=
 =?us-ascii?Q?Mq++RR0wRZKSgWRN318BNmAWSSPkriUaonz4b1kGc4K5s/gjBu66ZhMvmfVJ?=
 =?us-ascii?Q?6nfWb8s4v1DTkYnVWX4ZyOxlYLOIZ46kp93EwigL7XI+RpR2kO8NBe6pKQqf?=
 =?us-ascii?Q?0RsltO/uPyxKIY5bVZt+ZaoAqWzrFaHPkI2JtmOuXhCoYdtl/vgGSFTkdeI0?=
 =?us-ascii?Q?O8jPAoICaGHJZ+KLB5f9Bo14R5TKKw0KHw4S2sjrNtDBsZyUkFQdXqakJfvm?=
 =?us-ascii?Q?fuuwZtKuuPKKcloO5r5FyrsL0QH91LYkSz7b9NY68brpzwDGajiFQiudmnFA?=
 =?us-ascii?Q?38WKd6KBrFNX8OsWGueFa+7kF6MFXcI6+iOGK9SosvkKvZj1FsYyB5m2yTfy?=
 =?us-ascii?Q?Zvc+8KQdyPmUB6Nl7b5W8AGDV53mm1lbe5WSMVrwKRb53FmMvjBTcNlCQjrF?=
 =?us-ascii?Q?Mazz+E/El1DEU95HbFv3H3jr2BTOgUR5FWRjZ+a2fa2v57ApA8oKbQ3tOsgc?=
 =?us-ascii?Q?9MP3o4hUgmx+1EGCkWZLU4IG0SRuDxkVnGT3eWfArKY3pC/oCxYGu8y0yCR+?=
 =?us-ascii?Q?DGItYB/G9yz7IwTIXdt+85oFWoib12vLuEJBE7VV0rAYSI1h+oOyQ7nqoH/8?=
 =?us-ascii?Q?AcsA+QYTlQ0l+5EQ53jYagmIzveD1NCY0G/RnLDA0maHmhXeG0GYZQOIQ2/F?=
 =?us-ascii?Q?76GGOecILHEhoSSkC2uHGC8QM/fTHVez/JM7JqVRcyfQM1229yBMMGn+Pf9A?=
 =?us-ascii?Q?1WBK7j5zbUeQhkmtRZDQbOU4gbiA2Twq1u6jMhnTNJYxgtZg0eC3vO0/F48u?=
 =?us-ascii?Q?OeZXZo0+/SkO8RstGgV5LYS1S3QYV3/CZdQ4RH8Xd+ewaxc6Ry80nPKq+TWX?=
 =?us-ascii?Q?ANu8zZUHgM8NMoGEweXWmrK3pPBZ9Uc6E0PtsHmlfkuOwB072yIw/j8hVbtA?=
 =?us-ascii?Q?E3Oy6IPiTlouyE7rSN0Mv3pZnbidDncM63XpDSf1y6L6h8x2keEw6jU01YZf?=
 =?us-ascii?Q?gpLFjumREP7UpXGGHw44p8qQaGCMdrASD97ZKgADvVqtEaqhHQfZm6hJ/nSn?=
 =?us-ascii?Q?+nM//517Gdy3aG2FIEpOxrt7ApfGmeflXDmDAzBv1My6c52b44o9Bbx4ikdQ?=
 =?us-ascii?Q?oQWTyWh9mOJLZUGW3RbcMUCULgB9f6vfQqw2+YNrFR9QLyhYA1JrXZxGbwjA?=
 =?us-ascii?Q?j5wAS5s5e2l3M2mf109WCktaIMfVZmRAPs2p7EpCs+RB6MA5/DQFMmsKy7Ff?=
 =?us-ascii?Q?qjRlAs9rj2DRHnTn4lXAVtQKtBCqJInsyEGDwTwQyJho5zJuweyphN6ggbaO?=
 =?us-ascii?Q?FvTNUtl7GA+bj5XP/wZCdL5BUQKqpHQlima/MgvqoXf8gdbdN7am6rIAyktW?=
 =?us-ascii?Q?Y12js9WRBSdEPvr1QCsdiKbKM66NeFykSwqBwtvjo8KiXvxvyLaiDdFRAXmq?=
 =?us-ascii?Q?4u0moRk7SDZKyGKRd+e7jJ2Dhy1E8kt9K+1XL+/eE0MW9oAvLAhTUtUN9Anl?=
 =?us-ascii?Q?Y7iTlltxz4CZVJ6GW9QzPsZlx6tNQADuqT0E1D5zNFhHY12Jlr56kA4YA6Qf?=
 =?us-ascii?Q?5LiC/jXl2KmAeP6RxhA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef834cf3-3116-493b-0995-08dad8b4ac77
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 00:39:32.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzygGIBfnX0LlFpb3Hzfbiv4i/nuRPb7ROvu+eESsdxNx0d1IQe28a10rN73r7Bn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 07, 2022 at 10:57:50AM +0200, Michael Guralnik wrote:
> Switch from using the mkey order to using the new struct as the key to
> the RB tree of cache entries.
> The key is all the mkey properties that UMR operations can't modify.
> Using this key to define the cache entries and to search and create
> cache mkeys.
> 
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  32 +++--
>  drivers/infiniband/hw/mlx5/mr.c      | 196 +++++++++++++++++++--------
>  drivers/infiniband/hw/mlx5/odp.c     |  26 ++--
>  3 files changed, 180 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 10e22fb01e1b..d795e9fc2c2f 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -731,17 +731,26 @@ struct umr_common {
>  	unsigned int state;
>  };
>  
> +struct mlx5r_cache_rb_key {
> +	u8 ats:1;
> +	unsigned int access_mode;
> +	unsigned int access_flags;
> +	/*
> +	 * keep ndescs as the last member so entries with about the same ndescs
> +	 * will be close in the tree
> +	 */

? How does this happen? The compare function doesn't use memcmp..

I think this comment should go in the compare function because the
search function does this:

> -	return smallest;
> +	return (smallest &&
> +		smallest->rb_key.access_mode == rb_key.access_mode &&
> +		smallest->rb_key.access_flags == rb_key.access_flags &&
> +		smallest->rb_key.ats == rb_key.ats) ?
> +		       smallest :
> +		       NULL;

So it isn't that they have to be close in the tree, it is that
"smallest" has to find a matching mode/flags/ats before finding the
smallest ndescs of the matching list. Thus ndescs must always by the
last thing in the compare ladder.

> +struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
> +				       int access_flags, int access_mode,
> +				       int ndescs)
> +{
> +	struct mlx5r_cache_rb_key rb_key = {
> +		.ndescs = ndescs,
> +		.access_mode = access_mode,
> +		.access_flags = get_unchangeable_access_flags(dev, access_flags)
> +	};
> +	struct mlx5_cache_ent *ent = mkey_cache_ent_from_rb_key(dev, rb_key);
> +	if (!ent)

Missing newline

>  struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
> -					      int order)
> +					      struct mlx5r_cache_rb_key rb_key,
> +					      bool debugfs)
>  {
>  	struct mlx5_cache_ent *ent;
>  	int ret;
> @@ -808,7 +873,10 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
> -	ent->order = order;
> +	ent->rb_key.ats = rb_key.ats;
> +	ent->rb_key.access_mode = rb_key.access_mode;
> +	ent->rb_key.access_flags = rb_key.access_flags;
> +	ent->rb_key.ndescs = rb_key.ndescs;

ent->rb_key = rb_key

>  int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
>  {
> +	struct mlx5r_cache_rb_key rb_key = {
> +		.access_mode = MLX5_MKC_ACCESS_MODE_MTT,
> +	};
>  	struct mlx5_mkey_cache *cache = &dev->cache;
>  	struct mlx5_cache_ent *ent;
>  	int i;
> @@ -838,19 +913,26 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
>  
>  	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
>  	timer_setup(&dev->delay_timer, delay_time_func, 0);
> +	mlx5_mkey_cache_debugfs_init(dev);
>  	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
> -		ent = mlx5r_cache_create_ent(dev, i);
> -
> -		if (i > MKEY_CACHE_LAST_STD_ENTRY) {
> -			mlx5_odp_init_mkey_cache_entry(ent);
> +		if (i > mkey_cache_max_order(dev))
>  			continue;

This is goofy, just make the for loop go from 2 to
mkey_cache_max_order() + 2 (and probably have the function do the + 2
internally)

Get rid of MAX_MKEY_CACHE_ENTRIES
> +
> +		if (i == MLX5_IMR_KSM_CACHE_ENTRY) {
> +			ent = mlx5_odp_init_mkey_cache_entry(dev);
> +			if (!ent)
> +				continue;

This too, just call mlx5_odp_init_mkey_cache_entry() outside the loop

And rename it to something like mlx5_odp_init_mkey_cache(), and don't
return ent.

Set ent->limit inside mlx5r_cache_create_ent()

And run over the whole rbtree in a final loop to do the final
queue_adjust_cache_locked() step.

> -void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
> +struct mlx5_cache_ent *mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
>  {
> -	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
> -		return;
> -	ent->ndescs = mlx5_imr_ksm_entries;
> -	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
> +	struct mlx5r_cache_rb_key rb_key = {
> +		.ats = 0,
> +		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
> +		.access_flags = 0,
> +		.ndescs = mlx5_imr_ksm_entries,

Don't need to zero init things here

Jason
