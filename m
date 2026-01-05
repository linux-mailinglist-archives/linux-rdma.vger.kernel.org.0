Return-Path: <linux-rdma+bounces-15301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0761ACF1D5F
	for <lists+linux-rdma@lfdr.de>; Mon, 05 Jan 2026 06:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27AB33009120
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jan 2026 05:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B532573D;
	Mon,  5 Jan 2026 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bsizm1x+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70C26A1B9
	for <linux-rdma@vger.kernel.org>; Mon,  5 Jan 2026 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589303; cv=none; b=L1rRlv5SDIz4mkom+RyM1epmmcdrZrzWsFWWiG1QfuEAVHIzfEUDazzxDcNIUnCcDyHOr2ljzdf3NHl2p45By87j0vwXWeCLen+ZAGdNHLHhsGdohKoSicfYqXr45cw05WqbTrTpj9hOf8HHb1fiqoZjd3XZYJcVc8LdnoUtjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589303; c=relaxed/simple;
	bh=NPlink7ctY4dKFyjDt3VUF5pc9NmRfk7QsHXudwmogo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmZOTR16nN2ejXHkK0xKQiRHqfu5+Ij6VR+Kvv7vN2oWN2T3Hw2HmKe/QwGw/uQkbX/stcFv8RAO/FSgJC2RyDJ/tHlZnsBoxQefNivf6Ntne4b0Rwhu5V7UTR9rYetV5Kdnc0ViLEzQm4Hq8idDK+rq3gMCuOeyBBaqE8zYVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bsizm1x+; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b5f9b55e-0d01-4315-8f01-72eba590ec67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767589287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdssMG/Km+sdH2F1rihUyWPjVyzOilg9V180fAaQ6OI=;
	b=Bsizm1x+j+TCU4dQkuNucfEyH+jXGScosUy7m7npAlIFzq6RvxCDhVWax49dXnHMbFWOYp
	3S5VipK/iaMdnsqyukdPwilrAWmi5PdfYWnmhG7EBsQPq0SGMnLLHJrlz/EsBGX7Io04q3
	DBV99YKpdK7BtjYE/DWUhgu1nZIeRlU=
Date: Sun, 4 Jan 2026 21:01:19 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 2/6] RDMA/core: Avoid exporting module local
 functions and remove not-used ones
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yishai Hadas <yishaih@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Parav Pandit <parav@nvidia.com>
References: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
 <20260104-ib-core-misc-v1-2-00367f77f3a8@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260104-ib-core-misc-v1-2-00367f77f3a8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/4 5:51, Leon Romanovsky 写道:
> From: Parav Pandit <parav@nvidia.com>
> 
> Some of the functions are local to the module and some are not used
> starting from commit 36783dec8d79 ("RDMA/rxe: Delete deprecated module
> parameters interface"). Delete and avoid exporting them.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/core/device.c | 30 ------------------------------
>   include/rdma/ib_verbs.h          |  2 --
>   2 files changed, 32 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 13e8a1714bbd..0b0efa9d93aa 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -361,34 +361,6 @@ static struct ib_device *__ib_device_get_by_name(const char *name)
>   	return NULL;
>   }
>   
> -/**
> - * ib_device_get_by_name - Find an IB device by name
> - * @name: The name to look for
> - * @driver_id: The driver ID that must match (RDMA_DRIVER_UNKNOWN matches all)
> - *
> - * Find and hold an ib_device by its name. The caller must call
> - * ib_device_put() on the returned pointer.
> - */
> -struct ib_device *ib_device_get_by_name(const char *name,
> -					enum rdma_driver_id driver_id)
> -{
> -	struct ib_device *device;
> -
> -	down_read(&devices_rwsem);
> -	device = __ib_device_get_by_name(name);
> -	if (device && driver_id != RDMA_DRIVER_UNKNOWN &&
> -	    device->ops.driver_id != driver_id)
> -		device = NULL;
> -
> -	if (device) {
> -		if (!ib_device_try_get(device))
> -			device = NULL;
> -	}
> -	up_read(&devices_rwsem);
> -	return device;
> -}
> -EXPORT_SYMBOL(ib_device_get_by_name);
> -
>   static int rename_compat_devs(struct ib_device *device)
>   {
>   	struct ib_core_device *cdev;
> @@ -2875,7 +2847,6 @@ int ib_add_sub_device(struct ib_device *parent,
>   
>   	return ret;
>   }
> -EXPORT_SYMBOL(ib_add_sub_device);
>   
>   int ib_del_sub_device_and_put(struct ib_device *sub)
>   {
> @@ -2894,7 +2865,6 @@ int ib_del_sub_device_and_put(struct ib_device *sub)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(ib_del_sub_device_and_put);
>   
>   #ifdef CONFIG_INFINIBAND_VIRT_DMA
>   int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 6aad66bc5dd7..e92bf2e44fd8 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -4545,8 +4545,6 @@ static inline bool ib_device_try_get(struct ib_device *dev)
>   void ib_device_put(struct ib_device *device);
>   struct ib_device *ib_device_get_by_netdev(struct net_device *ndev,
>   					  enum rdma_driver_id driver_id);
> -struct ib_device *ib_device_get_by_name(const char *name,
> -					enum rdma_driver_id driver_id);
>   struct net_device *ib_get_net_dev_by_params(struct ib_device *dev, u32 port,
>   					    u16 pkey, const union ib_gid *gid,
>   					    const struct sockaddr *addr);
> 


