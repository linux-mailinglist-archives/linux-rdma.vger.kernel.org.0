Return-Path: <linux-rdma+bounces-12362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2FBB0BDB5
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 09:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720CC1882742
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB55826E714;
	Mon, 21 Jul 2025 07:34:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41035E55B;
	Mon, 21 Jul 2025 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083248; cv=none; b=JaYbqY/k9Frls88iggwAG5TgPXBmLSAjyo5CCEBeLONQBwAw9OspCxClCOFe4NIyQewi0dX/DoHW9CpG+Jyj6Wb2F7JRxhMj5vYDHMg++h6sKSa754nkZO71qEvnCBFKpKqDsQlXUCqcRf32CeoxwdlRJ7juUTz5Y+2JcYt2ibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083248; c=relaxed/simple;
	bh=WoY52mdM6qL8jzyebF+SZbQq2npMHxjFoEKVnzShIyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e1EANdQdNuEmKx8bAjAcfyGOFwFg1LzOxXxABmhilA7KQGDcFack9TsgEc+qgC/fzLQxTRJYlgqNGiyuMNg05D++NHUGVaI3ndY+X0gZF1DZ1pmESimpjVtMi228+ncJrmRlxd5O8nEyh8adpoLIU1I/uEWUZN11kMqbLqxJops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4blscK4LsPz27j2F;
	Mon, 21 Jul 2025 15:34:57 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B95C81402C4;
	Mon, 21 Jul 2025 15:33:57 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Jul 2025 15:33:56 +0800
Message-ID: <6fdee098-230a-4c30-bfe8-1175fecb5dad@huawei.com>
Date: Mon, 21 Jul 2025 15:33:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Cleanup error handle in
 mlx5e_tc_sample_init()
To: <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250625102047.483300-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250625102047.483300-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

ping...

On 2025/6/25 18:20, Yue Haibing wrote:
> post_act is initialized in mlx5e_tc_post_act_init(), which never return
> NULL. And if it is invalid, no need to alloc tc_psample mem.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  .../ethernet/mellanox/mlx5/core/en/tc/sample.c   | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
> index 5db239cae814..1b083afbe1bc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
> @@ -619,26 +619,30 @@ mlx5e_tc_sample_init(struct mlx5_eswitch *esw, struct mlx5e_post_act *post_act)
>  	struct mlx5e_tc_psample *tc_psample;
>  	int err;
>  
> -	tc_psample = kzalloc(sizeof(*tc_psample), GFP_KERNEL);
> -	if (!tc_psample)
> -		return ERR_PTR(-ENOMEM);
> -	if (IS_ERR_OR_NULL(post_act)) {
> +	if (IS_ERR(post_act)) {
>  		err = PTR_ERR(post_act);
>  		goto err_post_act;
>  	}
> +
> +	tc_psample = kzalloc(sizeof(*tc_psample), GFP_KERNEL);
> +	if (!tc_psample) {
> +		err = -ENOMEM;
> +		goto err_post_act;
> +	}
>  	tc_psample->post_act = post_act;
>  	tc_psample->esw = esw;
>  	err = sampler_termtbl_create(tc_psample);
>  	if (err)
> -		goto err_post_act;
> +		goto err_create;
>  
>  	mutex_init(&tc_psample->ht_lock);
>  	mutex_init(&tc_psample->restore_lock);
>  
>  	return tc_psample;
>  
> -err_post_act:
> +err_create:
>  	kfree(tc_psample);
> +err_post_act:
>  	return ERR_PTR(err);
>  }
>  

