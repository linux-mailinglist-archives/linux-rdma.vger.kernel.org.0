Return-Path: <linux-rdma+bounces-515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171368218A2
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 09:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A90E1C21726
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7B568C;
	Tue,  2 Jan 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG6FTr8a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23353BA;
	Tue,  2 Jan 2024 08:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46848C433C7;
	Tue,  2 Jan 2024 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704185898;
	bh=mgDLuKTiRK0fcEwuAINoY+MKZtrYC/YrQ/tRrnrWiO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LG6FTr8agk7bZXldCG9mlpFOSBl5YUPabX2gi451OhzE9OEPLQJ9B1Y++z+iM51IA
	 cDGbkE3t9rJyRAWCzmqWKgp+9Fcvk3BImfEYeJEpfQmo3gdVPcxbmf59SaLUiwmrYA
	 EFCEjeKHc9noMHC/5C43Ojp453A9Mu6Z6Ad49OmSI9/iuWu3aPv8heYQfCbmt31+Bf
	 sUzgv1DW4ttdo77EEF1dcguVjFsogjtEfnu4uoK6oQ251l5c+dXfuhFfPOoQuILbEP
	 wPMEzNGMaXpTQ/VrMGSPMoxmMHPZUTXp1jXV0IyGxyJSd76ktt/VrUzdEWdnOWw6X/
	 GkgmgRfWxQ6Vg==
Date: Tue, 2 Jan 2024 10:58:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Shifeng Li <lishifeng@sangfor.com.cn>
Cc: jgg@ziepe.ca, wenglianfa@huawei.com, gustavoars@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shifeng Li <lishifeng1992@126.com>
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
Message-ID: <20240102085814.GD6361@unreal>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102034335.34842-1-lishifeng@sangfor.com.cn>

On Mon, Jan 01, 2024 at 07:43:35PM -0800, Shifeng Li wrote:
> The mad_client will be initialized in enable_device_and_get(), while the
> devices_rwsem will be downgraded to a read semaphore. There is a window
> that leads to the failed initialization for cm_client, since it can not
> get matched mad port from ib_mad_port_list, and the matched mad port will
> be added to the list after that.
> 
>     mad_client    |                       cm_client
> ------------------|--------------------------------------------------------
> ib_register_device|
> enable_device_and_get
> down_write(&devices_rwsem)
> xa_set_mark(&devices, DEVICE_REGISTERED)
> downgrade_write(&devices_rwsem)
>                   |
>                   |ib_cm_init
>                   |ib_register_client(&cm_client)
>                   |down_read(&devices_rwsem)
>                   |xa_for_each_marked (&devices, DEVICE_REGISTERED)
>                   |add_client_context
>                   |cm_add_one
>                   |ib_register_mad_agent
>                   |ib_get_mad_port
>                   |__ib_get_mad_port
>                   |list_for_each_entry(entry, &ib_mad_port_list, port_list)
>                   |return NULL
>                   |up_read(&devices_rwsem)
>                   |
> add_client_context|
> ib_mad_init_device|
> ib_mad_port_open  |
> list_add_tail(&port_priv->port_list, &ib_mad_port_list)
> up_read(&devices_rwsem)
>                   |

How is this stack possible?

ib_register_device() is called by drivers and happens much later than ib_cm_init().

Thanks

> 
> Fix it by using the devices_rwsem write semaphore to protect the mad_client
> init flow in enable_device_and_get().
> 
> Fixes: d0899892edd0 ("RDMA/device: Provide APIs from the core code to help unregistration")
> Cc: Shifeng Li <lishifeng1992@126.com>
> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
> ---
>  drivers/infiniband/core/device.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 67bcea7a153c..85782786993d 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1315,12 +1315,6 @@ static int enable_device_and_get(struct ib_device *device)
>  	down_write(&devices_rwsem);
>  	xa_set_mark(&devices, device->index, DEVICE_REGISTERED);
>  
> -	/*
> -	 * By using downgrade_write() we ensure that no other thread can clear
> -	 * DEVICE_REGISTERED while we are completing the client setup.
> -	 */
> -	downgrade_write(&devices_rwsem);
> -
>  	if (device->ops.enable_driver) {
>  		ret = device->ops.enable_driver(device);
>  		if (ret)
> @@ -1337,7 +1331,7 @@ static int enable_device_and_get(struct ib_device *device)
>  	if (!ret)
>  		ret = add_compat_devs(device);
>  out:
> -	up_read(&devices_rwsem);
> +	up_write(&devices_rwsem);
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 
> 

