Return-Path: <linux-rdma+bounces-755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C697D83C2D6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 13:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727601F25B6D
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698114EB52;
	Thu, 25 Jan 2024 12:53:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435BB1BC46
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187185; cv=none; b=TyKtH7ls8CZmospUp+cc3RLbbp8rGuBnCZTg8PbfVVHnTkKSXfM57L/eSjvYU1lPmMk3tGkPuC7WgVKsVy+BJxLovJCwRn89YaYQfYLkYEDmK2U4nKHsQ3TZ+fRpwzB2kBA4A9bOaJDBde9VJloMgIkGrGEd6b5vHTb9BCQVJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187185; c=relaxed/simple;
	bh=lFdP9QNOUBK2yOU8C8JHAphl4rSygC0zOdFiYiQsCbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OUgJyZdCkdhpjLCaW8rDDSpt+TDoXnI5c314LHY9gU0ti9SYb5NU+cKmXSrVFND76QMOR4z4brWlQvJveVUJCKCZ/VperIZ5PQhRmN9e8WNobHG+AqKBPGuhNPOzbXFGXKPfTDgh4opIdhIky/bsNryX4+JHcDsJSPtWwSxjKaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TLLKs1gqyz1Q8Bx;
	Thu, 25 Jan 2024 20:51:13 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id C3CE71400D4;
	Thu, 25 Jan 2024 20:52:58 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 20:52:58 +0800
Message-ID: <36037101-dd46-d956-4555-d02eeb04dd0b@hisilicon.com>
Date: Thu, 25 Jan 2024 20:52:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH rdma-next 5/6] RDMA/mlx5: Change check for cacheable user
 mkeys
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, Tamar
 Mashiah <tmashiah@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
References: <cover.1706185318.git.leon@kernel.org>
 <4641d8f79a88b07925cab0d8cd1ffc032a9115ef.1706185318.git.leon@kernel.org>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <4641d8f79a88b07925cab0d8cd1ffc032a9115ef.1706185318.git.leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/1/25 20:30, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> In the dereg flow, UMEM is not a good enough indication whether an MR
> is from userspace since in mlx5_ib_rereg_user_mr there are some cases
> when a new MR is created and the UMEM of the old MR is set to NULL.
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
> index 12bca6ca4760..3c241898e064 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1857,6 +1857,11 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
>  	return ret;
>  }
>  
> +static bool is_cacheable_mkey(struct mlx5_ib_mkey mkey)

I think it's better using a pointer as the parameter instead of the struct itself.

Junxian

> +{
> +	return mkey.cache_ent || mkey.rb_key.ndescs;
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
> @@ -1914,7 +1913,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  		ib_umem_stop_invalidation_notifier(mr->umem);
>  	}
>  
> -	if (!mr->mmkey.cache_ent) {
> +	/* Stop DMA */
> +	if (!is_cacheable_mkey(mr->mmkey) || mlx5r_umr_revoke_mr(mr) ||
> +	    cache_ent_find_and_store(dev, mr)) {
>  		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
>  		if (rc)
>  			return rc;

