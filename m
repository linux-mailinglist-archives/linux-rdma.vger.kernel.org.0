Return-Path: <linux-rdma+bounces-6053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECB69D539B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 20:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405E61F22399
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0F19FA93;
	Thu, 21 Nov 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bOO/faOt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2D200A3
	for <linux-rdma@vger.kernel.org>; Thu, 21 Nov 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218748; cv=none; b=UlKw3AKQhUpu1NsQDQR34QRCH8RHyd3IboYgiU9RrMNAdX0pncD53j2lZlK7T4/uC0NCTpu2w4DlhuHxIBgRJgDMBN3LUYpnJraCA/2BYpqNJZPCNNh4bybhm8HNxxXiU+at0yo1h7pgXPb+dQ63J4pNUix/Ek+xEicl21DNjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218748; c=relaxed/simple;
	bh=ziL5KwyFVyg9SwKIbhyM1H83IRN94KGEOAt7H+aUFZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVvdXjSo7TYWLcH4mTr3wjCkJb0jKjEw9DUheNPWsDN5qfrgyYAPtMVCk/RcrvNKzEkjir/w2eQ4bwc0rmSrsnbg/ymXwQZsdn31+KEfxC1MYWsnPmFQfyxjqkd75p+xuFK9qtBYgQDnRmeVkvAuuU63V/8Hn/E5fLqZ4e49mQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bOO/faOt; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <578339be-b555-42cb-b7db-1d3e7b6c7017@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732218741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmal/P0rGGdkoCFkoKxklau6YyE1aZukTegpTUdvzSs=;
	b=bOO/faOtk2NHL+v2Gf71mGg4RaeG7Y5YIKG/yUHrbPbtRaDiNuftt93I1ES51rk67gywwj
	GFMqnGa8arYzWbCQ9f1dvAmaH/X5U/9qLmdKpxji7O6zH+QPWdTZA+TusXyQzeWsEmUG3C
	E5+Czqk+QuSKl/5yVmnu7brpstrDVkQ=
Date: Thu, 21 Nov 2024 20:52:16 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc] RDMA/core: Fix ENODEV error for iWARP test over
 vlan
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>, jgg@nvidia.com,
 leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com
References: <20241119061850.18607-1-anumula@chelsio.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241119061850.18607-1-anumula@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/11/19 7:18, Anumula Murali Mohan Reddy 写道:
> If traffic is over vlan, cma_validate_port() fails to match
> net_device ifindex with bound_if_index and results in ENODEV error.
> As iWARP gid table is static, it contains entry corresponding  to
> only one net device which is either real netdev or vlan netdev for
> cases like  siw attached to a vlan interface.
> This patch fixes the issue by assigning bound_if_index with net
> device index, if real net device obtained from bound if index matches
> with net device retrieved from gid table
> 
> Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
> Link: https://lore.kernel.org/all/ZzNgdrjo1kSCGbRz@chelsio.com/
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>   drivers/infiniband/core/cma.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 64ace0b968f0..97657e1810d8 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -689,7 +689,7 @@ cma_validate_port(struct ib_device *device, u32 port,
>   	const struct ib_gid_attr *sgid_attr = ERR_PTR(-ENODEV);
>   	int bound_if_index = dev_addr->bound_dev_if;
>   	int dev_type = dev_addr->dev_type;
> -	struct net_device *ndev = NULL;
> +	struct net_device *ndev = NULL, *pdev = NULL;

In the original source code, the local variables lay out in the form of 
Reverse Christmas Tree.
But the new code breaks the rule of Reverse Christmas Tree.

Zhu Yanjun

>   
>   	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
>   		goto out;
> @@ -714,6 +714,21 @@ cma_validate_port(struct ib_device *device, u32 port,
>   
>   		rcu_read_lock();
>   		ndev = rcu_dereference(sgid_attr->ndev);
> +		if (ndev->ifindex != bound_if_index) {
> +			pdev = dev_get_by_index_rcu(dev_addr->net, bound_if_index);
> +			if (pdev) {
> +				if (is_vlan_dev(pdev)) {
> +					pdev = vlan_dev_real_dev(pdev);
> +					if (ndev->ifindex == pdev->ifindex)
> +						bound_if_index = pdev->ifindex;
> +				}
> +				if (is_vlan_dev(ndev)) {
> +					pdev = vlan_dev_real_dev(ndev);
> +					if (bound_if_index == pdev->ifindex)
> +						bound_if_index = ndev->ifindex;
> +				}
> +			}
> +		}
>   		if (!net_eq(dev_net(ndev), dev_addr->net) ||
>   		    ndev->ifindex != bound_if_index) {
>   			rdma_put_gid_attr(sgid_attr);


