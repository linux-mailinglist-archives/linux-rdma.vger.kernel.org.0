Return-Path: <linux-rdma+bounces-804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31B841150
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jan 2024 18:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A187288819
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jan 2024 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A917B76C99;
	Mon, 29 Jan 2024 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="feAvIdVw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706E76C87
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jan 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550767; cv=fail; b=ATyuypege7DvBkpJsgJWuu5VKvKB2V34825ZSe2keDQQ+mLxRj/MF9y8vXqHESOHwGvBGaPxEff8PGw7fzCdbG+I9YdtGWpvSnaqiUg/86aPJbIaLUDal2pXZSaA9r08l1l2ort1fzo+UddGQ0pzKprF94EOasEjl3tg3DAw4v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550767; c=relaxed/simple;
	bh=SBZTfv+7W6Hcb6sMkGfy+QhB77nSTZ0fY+zdNJJwngk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h3ouryyD1i3xiHguI4L4/NAg5bet1InkV0o0ZrldB+8TQHnrZ1/f+Hvcgmw9P/NlGdevk47LYm4XvyIJTHvJlvQiVg9QnT1ErQKFvdH35WVU1yk5s/vO8NUNquCCxDhiqIfpzrDhRCgNHukV1bccXjTvhmx0DoFNPdUP0a0QxOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=feAvIdVw; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzeB7tO9hmADhY38HMhqYs8hLIgEmewaGBtbeyvT/ceCbMBTafdFKaYzCZaLOqyMQ2W79EzvG/6BC8nvHr7qkOK+UcxWrEzJ+YqRh3K6OKT54EFXhNE+rv8Bb2PaoPSg147mVwX86PzXwsjGU2KC73IwWVbatXxjuCdK2JjyVLJkN4PDxFvBfGXoyN2s2jdOA+SQmwGvTYqFm/nnl3+QBqcsx0m/sFpL15avYwgrQikjAbb01RuDQuAoc0LHfKtH8J2vDB0zRXJat2xqktrf1eMXjbVvnQLry3eK7j4EcUmX1JeBh476yT4efHaRUmiya5t2U4foYFn1dSeRNJO0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3uBBqsxN+njmh4O92Xd4CZmJj58kc4EG0q6rSl7rZs=;
 b=HUhQOOTehFXtlfEvqY+olcIsjVdbyv8Hto302WHiVrufNqm11/xh5CXFv2f3YTNGJah6xmTxmuBcfjIx0RVgBpWZBswKdz+5ztE6FpQxwM3jJNtvIAXhJrpJ8+xo/R//BRl4aDKGIYCeq5RYDbmeXe9cr8ZOUuAdQEcLTT0fQB/jRdY4/cHcLdWLuPvmRCd7hgXVFPncsZUiL9i0v3Tld8sUOXa1enCY8mo6Ye/eCkA17I42CEzUxUA2AthG+WpykJgC5DTDvIHzbppV/xl2eVSuwZZ1AHNA0K8K0sEuHDp5UQJO3yE/j6IMNi2Z4sOL3BgMu+B+8bdRlIvKy1ijLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3uBBqsxN+njmh4O92Xd4CZmJj58kc4EG0q6rSl7rZs=;
 b=feAvIdVwj/qDfojiovNWyxLuNBLOnZhmR41x2Vw9YybU30pE+TeUgSi63WFzikqqQ34ymM41477DmQ6kslsiNGvL+8XjlJ308W1Cz7d2IjLevgP3kllfRJDlugKIjNWSclkRwWeKpL+9NT8sMoLbXtKO0pxEeBrM0GfD3f4KVeb7wwHXyHKCXVUigV1kUyqFOESrgonvtUz46c9WYzaqrP+wATYAeEBYTV4CM9ATBqiR8Y0hdsoblmlp11i6SpVgXUPtZMInLjNR92NyXJDbOlSCsorKTzW/K4YGc7w0t+h9Ixa1R1xLsno89IeVzedq2Ld/MeobFnpZ9GyAKE4qRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 17:52:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:52:41 +0000
Date: Mon, 29 Jan 2024 13:52:39 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v1 5/6] RDMA/mlx5: Change check for cacheable
 user mkeys
Message-ID: <20240129175239.GY1455070@nvidia.com>
References: <cover.1706433934.git.leon@kernel.org>
 <20dc8ea1c606351b0491240d857977f724084345.1706433934.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20dc8ea1c606351b0491240d857977f724084345.1706433934.git.leon@kernel.org>
X-ClientProxiedBy: SN6PR01CA0013.prod.exchangelabs.com (2603:10b6:805:b6::26)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 43636bad-75d2-4ee5-aebc-08dc20f316c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jzYZjr9tqZUpIgx2NBf8EkdMZG5o7dBJlgnjfQoU14uhlBLXqhaNso0y9v3sPGSAv0AO2sHJ9rkCcsLH1TI9XK4GklOgsrjyUM9RniLdcgc21jZgohRV089B1XCriBrj9NH/6HE/1Sx/5BoMEc5IwuTONYUZfXv8G4XrTno/Qq8arNg6TfBuDTb69bXMmfi0YjHlaOCzOo8ldCj0bivqp0n9gpdp2GlzzHyN1SJ4ycE6Yf6DTqc8R0sKg6OvB1w5vn6GhsL9M+09VRX4bBKE5fdP7yhIlnE5KYKPrQ4hN+Nr4QPzBW+Se6MIIYL+XvoXw5qf7YnhaqMx72g/newcDH/+3wc4gQ3sN2/2qv7z9x+gycmSXNqKldhWB3OzSR49zfDGBnMGETmSudmiWNJF/M0ebGmk1za3D+T/1W4zrBZtqXVG2NtDgmFnIE3dXOojgG+rFWCIDKenw7NPrSz416vCDoNzUUHzBN3ADYHgt0w8b6DAqA2GdbXWeDp6rmA8nkbzudekvKXA6jHqmnnQvFW3O3rEn8W9Ecbp7cx2/KX/5H1i06V/mlj2gYUlsf0f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(83380400001)(36756003)(54906003)(66946007)(6916009)(86362001)(6506007)(316002)(8676002)(8936002)(66476007)(6486002)(26005)(478600001)(4326008)(107886003)(1076003)(2906002)(33656002)(5660300002)(2616005)(6512007)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PxXd3o6G3eFKiu3+SI4uGktgT5i9A5str2ssX8wkqxYr/RR0HFUxIYOptiV3?=
 =?us-ascii?Q?kT7ISJcAL75MmKy8cTrljekceQgzCioYroWhsq8bxB9zYCyt7DnUDKS2tGi7?=
 =?us-ascii?Q?wAfoUAZS3cJAsW9GfXo5aa3S6IlChumfEOjmmeUb1N3Li9bLdZ+EOQCgVbD1?=
 =?us-ascii?Q?g9H0El2vjR8L45z5PRZULT7dIEW/DnLLg83TvvDziTsIAE+IyOFjZcQXaMV1?=
 =?us-ascii?Q?Ykv2i9RnvcGksIs2vN3BR2VljNwUj+0HP/FXSsv0DO5hzpucIsPBWaRz///B?=
 =?us-ascii?Q?GLx5lBCxhK3xEUk3IVsmdyondMYrSWlclPZyXEe2BuLxZ8le1NT8eG/yJFL9?=
 =?us-ascii?Q?Qn+KPE6rcmHGwYaIifuntBvpY7OFJZTcmD5xAMwb8XgrJbFO8Xpbcc86KlXd?=
 =?us-ascii?Q?vkD5tCYXq1g93ZuWAyrlQzSxmGEqHKdtWko4pWSHj7hOY0IqNjUHCzg8Fr/3?=
 =?us-ascii?Q?9c2szQW+BqopHfOXfctX81aeGDNui0OQA/IUR+KQ4b+tDFRINOuRthM6/SVQ?=
 =?us-ascii?Q?j5IeHUkEWn8TCKaQIlm3NUmrk7qAQmFJyeUxBaGcpIUEaW89weAoneAFuDHk?=
 =?us-ascii?Q?dnhSsMSYcTd3a1ZtHzbZm6kSKO/jv6ulkhn2SLV9n4gnd15XmFyHUgFKU7KT?=
 =?us-ascii?Q?tvz5wjAPAZcZwr+nHn+HhqV7eId9cztx1O5Es7kO1zBbCZ9CshHFDP3v59qN?=
 =?us-ascii?Q?JDRUoPbODeUfIbGGbmIPP0h8saqAcsnbXSsTsnhy06b/z+mvzCC9NV2WmHfP?=
 =?us-ascii?Q?zQJU7DhSlVcFyifpwZElo76gIaHgEdwBkOnWIliIqBREN8TsMmgv5CJyv5i5?=
 =?us-ascii?Q?y7wgxpAKtfBaQVMCy8kTfxS3ey8EI9fUX7CzOeTaUQz3yw8F5jmzfnW6Lero?=
 =?us-ascii?Q?GBBlwBZomdcLFgwlGigbcrYaYlvhWP2ZAYwZPgyFy2Io5D9HcjtsNwRQk4+/?=
 =?us-ascii?Q?wbFBg5DA+kou/WYapLf/pT8dujW3xLzn30scKNmSPEifQH8T9gJ/3PY7GnsD?=
 =?us-ascii?Q?08V8CqFmP9pG5u4PPXRfJ4V0J6YsQnyPt8l1zWn9BQqCoYTMjZqnyM2CQpJP?=
 =?us-ascii?Q?9H235cYtb/xwVDFW+DPFKQmcTaNQDjhjcV1Y756AEAR7kO/sbHfyYZjwRUjM?=
 =?us-ascii?Q?vza/1CCQLYTqvjwJuMvwvkKgd2z2HwJ0Qj/kgW5lZNdIVPuuwlwRMa37rK/y?=
 =?us-ascii?Q?urD9wPcpab6T3V2Z3heYU69Ituw1X39kk0hDGKsWOiBB2h51JO1dbJvB0AOy?=
 =?us-ascii?Q?hnSwugrLAUCFlYJwu5/CklgkxvzaVvjxBmt9fiHkHcUy3dSMc0mGD9iIxSJV?=
 =?us-ascii?Q?ZDVtwPdk6HDcqpxtYSF43598fmeCUPiTpD/w5ASgAS0f44DUJ/zEBSRly/eC?=
 =?us-ascii?Q?ysMAm6SNu21ftO+NAlqAGng8iJ4af4OTocGosZNnsiuW7/2zfZgJoRkp2bPH?=
 =?us-ascii?Q?JM0FuGvHup3R4VSSNx8Ukanq+Bs6Uu2/ybO3cvm+IBdpPHo9PYzHGyAFufp8?=
 =?us-ascii?Q?KjHmc34GblIAFo11A0/FT9AK8ewGSNwp7aCAmgvbl0VNA/7+5UPlkInqrLyT?=
 =?us-ascii?Q?+59wqivol0LI7WiuKu0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43636bad-75d2-4ee5-aebc-08dc20f316c5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:52:41.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/+SXGTKSFoGQClmtmUIKJ2gB5oSDEt2nSy+zjJPk/7C8cSHeJVZOXyLTi8NsaYg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046

On Sun, Jan 28, 2024 at 11:29:15AM +0200, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> In the dereg flow, UMEM is not a good enough indication whether an MR
> is from userspace since in mlx5_ib_rereg_user_mr there are some cases
> when a new MR is created and the UMEM of the old MR is set to NULL.

Why is this a problem though? The only thing the umem has to do is to
trigger the UMR optimization. If UMR is not triggered then the mkey is
destroyed and it shouldn't be part of the cache at all.

> Currently when mlx5_ib_dereg_mr is called on the old MR, UMEM is NULL
> but cache_ent can be different than NULL. So, the mkey will not be
> destroyed.
> Therefore checking if mkey is from user application and cacheable
> should be done by checking if rb_key or cache_ent exist and all other kind of
> mkeys should be destroyed.
> 
> Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 12bca6ca4760..87552a689e07 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1857,6 +1857,11 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
>  	return ret;
>  }
>  
> +static bool is_cacheable_mkey(struct mlx5_ib_mkey *mkey)
> +{
> +	return mkey->cache_ent || mkey->rb_key.ndescs;
> +}
> +
>  int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  {
>  	struct mlx5_ib_mr *mr = to_mmr(ibmr);
> @@ -1901,12 +1906,6 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  		mr->sig = NULL;
>  	}
>  
> -	/* Stop DMA */
> -	if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length))
> -		if (mlx5r_umr_revoke_mr(mr) ||
> -		    cache_ent_find_and_store(dev, mr))
> -			mr->mmkey.cache_ent = NULL;
> -
>  	if (mr->umem && mr->umem->is_peer) {
>  		rc = mlx5r_umr_revoke_mr(mr);
>  		if (rc)

?? this isn't based on an upstream tree

> @@ -1914,7 +1913,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  		ib_umem_stop_invalidation_notifier(mr->umem);
>  	}
>  
> -	if (!mr->mmkey.cache_ent) {
> +	/* Stop DMA */
> +	if (!is_cacheable_mkey(&mr->mmkey) || mlx5r_umr_revoke_mr(mr) ||
> +	    cache_ent_find_and_store(dev, mr)) {

And now the mlx5r_umr_can_load_pas() can been lost, that isn't good. A
non-umr-able object should never be placed in the cache. If the mkey's
size is too big it has to be freed normally.

>  		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
>  		if (rc)
>  			return rc;

I'm not sure it is right to re-order this? The revokation of a mkey
should be a single operation, which ever path we choose to take..

Regardless the upstream code doesn't have this ordering so it should
all be one sequence of revoking the mkey and synchronizing the cache.

I suggest to put the revoke sequence into one function:

static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
{
	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);

	if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length)) {
		if (mlx5r_umr_revoke_mr(mr))
			goto destroy;

		if (cache_ent_find_and_store(dev, mr))
			goto destroy;
		return 0;
	}

destroy:
	if (mr->mmkey.cache_ent) {
		spin_lock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
		mr->mmkey.cache_ent->in_use--;
		mr->mmkey.cache_ent = NULL;
		spin_unlock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
	}
	return destroy_mkey(dev, mr);
}

(notice we probably shouldn't set cache_ent to null without adjusting in_use)

Jason

