Return-Path: <linux-rdma+bounces-6502-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187979F0575
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 08:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6C3282E66
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C018BC3D;
	Fri, 13 Dec 2024 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fe/qjYbH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD91552FC
	for <linux-rdma@vger.kernel.org>; Fri, 13 Dec 2024 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074830; cv=none; b=k5/YGguNiwx831uccUZa2AnEhgnqXtDhHLNR+jk3YsKsc81MpvoW4PbZXnzUCYj308X89PSBMWkn8R/FYklO3/b40BF7lYy0AL04HJ3wVDOGWypK4roy7iHD5PUQuBndNNSPlak9xCPkek1eUNP3bZapI4S/2bLHh48Mo5vLUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074830; c=relaxed/simple;
	bh=Yl9FtTWfm5AJnHEzx+o37iffwW8fKKulQ7FYGqNq9CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JfZUhLL1cP/CG+JvICAvMf5SU3wJJaAzyw4LDhrPQtMF/Za4RnoXdY2s2dLS2gmj17wvcAdjnxOWB+D0XuUjHBM8iU8i/jxEGsnnA8x7AB66FxCmF47N6LtgUyF1VkudaliurlqfDzRkNeOW0nqJ2zPGNq/xPCFALp4GKQltpW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fe/qjYbH; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b82f5caf-09d7-49be-aa4a-8a402d6b89a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734074825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nANURs/9bFtfWppkan0ral+I/xL33sd1BSNCKM+vm0A=;
	b=Fe/qjYbHRIaCLni0Cg1MmAfesKD64Gc9dk106a0J+CwgwIWGpCgoOaqg+KAp9G0zVNSPUb
	rmoVkChvBHWjSyqH22crQf2UmGtJISvHkIAHGd2ttx3AWMasYw3UuKMQvPP8oVHY+FU8er
	X6F3tdk8Inx+0t/5G53EXDMZ7iQc8xM=
Date: Fri, 13 Dec 2024 08:26:58 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][net-next] net/mlx5: Pick the first matched node of
 priv.free_list in alloc_4k
To: Li RongQing <lirongqing@baidu.com>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20240823061648.17862-1-lirongqing@baidu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240823061648.17862-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/23 8:16, Li RongQing 写道:
> Pick the first node instead of last, to avoid unnecessary iterating
> over whole free list
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Your commit is to fix the problem from the following commit?
So the following should be needed.

Fixes: 2726cd4a2928 ("net/mlx5: Dedicate fw page to the requesting function"

commit 2726cd4a29280c20ea983be285a6aefe75b205a4
Author: Eran Ben Elisha <eranbe@mellanox.com>
Date:   Sun May 3 10:15:58 2020 +0300

     net/mlx5: Dedicate fw page to the requesting function

     The cited patch assumes that all chuncks in a fw page belong to the 
same
     function, thus the driver must dedicate fw page to the requesting
     function, which is actually what was intedned in the original fw pages
     allocator design, hence the fwp->func_id !

     Up until the cited patch everything worked ok, but now "relase all 
pages"
     is broken on systems with page_size > 4k.

     Fix this by dedicating fw page to the requesting function id via 
adding a
     func_id parameter to alloc_4k() function.

     Fixes: c6168161f693 ("net/mlx5: Add support for release all pages 
event")
     Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
     Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>

Zhu Yanjun

> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> index 972e8e9..cd20f11 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> @@ -228,6 +228,7 @@ static int alloc_4k(struct mlx5_core_dev *dev, u64 *addr, u32 function)
>   		if (iter->function != function)
>   			continue;
>   		fp = iter;
> +		break;
>   	}
>   
>   	if (list_empty(&dev->priv.free_list) || !fp)


