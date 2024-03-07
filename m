Return-Path: <linux-rdma+bounces-1314-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE21874F06
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 13:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3661C243A7
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BAD12AAF6;
	Thu,  7 Mar 2024 12:29:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAE12AACD;
	Thu,  7 Mar 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814540; cv=none; b=mVsUI2yIbxTepVrcHzJ8w6hCyG9Nl0i1Gj3d1r3aqMADbvhq+J3egyDNp/vVm7JENPTxh4Q+XrZAeVtvhaWuUvOq3WZehv+WwtUB6lfSNauoL01VkT3Q/SCKVfcwrcJbPeplqBnCs+AQ8IuQA89Rcq64AIoncAkveks2NbiwCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814540; c=relaxed/simple;
	bh=dVNW0oddv3N048br45hJLhMcLswgKfiqOYg11zbnmDY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=duOmoVWd+uH22Ri9A9KQ+Zqc3JUsBDOQMbY8VWfhHTyxEM5HOU7+fj+DFB2qaJq+U/f/oyGVWoltkzVpP/yLnd4DHKkMtxGHOIHtl+FmUwDUDe7us2LIt+ykRcVN40xavccGLC6qFpvxJdlSGHaltsSKuRrUlRAa2/xGPaFXAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tr7pr2kmCz1xq8c;
	Thu,  7 Mar 2024 20:27:16 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 43254140336;
	Thu,  7 Mar 2024 20:28:55 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 20:28:54 +0800
Subject: Re: [RFC PATCH net-next v1 1/2] net: mirror skb frag ref/unref
 helpers
To: Mina Almasry <almasrymina@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger
	<stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
References: <20240306235922.282781-1-almasrymina@google.com>
 <20240306235922.282781-2-almasrymina@google.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <8ef17e46-3d14-e010-c721-6fca3d57f78f@huawei.com>
Date: Thu, 7 Mar 2024 20:28:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240306235922.282781-2-almasrymina@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/3/7 7:59, Mina Almasry wrote:

...

>  
>  int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 1f918e602bc4..6d234faa9d9e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1006,6 +1006,21 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
>  EXPORT_SYMBOL(skb_cow_data_for_xdp);
>  
>  #if IS_ENABLED(CONFIG_PAGE_POOL)
> +bool napi_pp_get_page(struct page *page)
> +{
> +
> +	struct page *head_page;
> +
> +	head_page = compound_head(page);
> +
> +	if (!is_pp_page(page))

I would use the head_page for is_pp_page(), I am not sure it
matters that much, but I believe it is the precedent.

Maybe do the below and remove head_page varible:
page = compound_head(page);

> +		return false;
> +
> +	page_pool_ref_page(head_page);
> +	return true;
> +}
> +EXPORT_SYMBOL(napi_pp_get_page);
> +

...

> -
>  static void skb_kfree_head(void *head, unsigned int end_offset)
>  {
>  	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
> @@ -4199,7 +4183,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
>  			to++;
>  
>  		} else {
> -			__skb_frag_ref(fragfrom);
> +			__skb_frag_ref(fragfrom, skb->pp_recycle);
>  			skb_frag_page_copy(fragto, fragfrom);
>  			skb_frag_off_copy(fragto, fragfrom);
>  			skb_frag_size_set(fragto, todo);
> @@ -4849,7 +4833,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  			}
>  
>  			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
> -			__skb_frag_ref(nskb_frag);
> +			__skb_frag_ref(nskb_frag, nskb->pp_recycle);
>  			size = skb_frag_size(nskb_frag);
>  
>  			if (pos < offset) {
> @@ -5980,10 +5964,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>  	/* if the skb is not cloned this does nothing
>  	 * since we set nr_frags to 0.
>  	 */
> -	if (skb_pp_frag_ref(from)) {
I guess it worth mentioning that skb->pp_recycle is only checked once,
and skb->pp_recycle is checked for every frag after this patch.

> -		for (i = 0; i < from_shinfo->nr_frags; i++)
> -			__skb_frag_ref(&from_shinfo->frags[i]);
> -	}
> +	for (i = 0; i < from_shinfo->nr_frags; i++)
> +		__skb_frag_ref(&from_shinfo->frags[i], from->pp_recycle);
>  
>  	to->truesize += delta;
>  	to->len += len;
> 

