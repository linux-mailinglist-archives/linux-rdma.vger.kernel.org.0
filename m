Return-Path: <linux-rdma+bounces-3410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216579139F5
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1811F21B20
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4212F37B;
	Sun, 23 Jun 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DigYG/Q8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177C53E31
	for <linux-rdma@vger.kernel.org>; Sun, 23 Jun 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141580; cv=none; b=Xe5lk/fk42MqNOSubFYCDuItO8e/DvRxrWkQYyTJ0fsyM3onLAp5XbwJTrBtqWb6S2ffznrEqC3Bn0iGT1M5Fun6LeFnqnfuMXirNNAEFAWgD4Idvv9BKrLyhvf84lin9uZF/WXJomg32fahATWqiedDBfQNCY0s7tFnk1AAN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141580; c=relaxed/simple;
	bh=ljyVn6sr38jFgPDSUcIip0GOS0XdneIwPIrAqEZGroU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Znfi3gCUo6JVeCPrf5eCtj2pEUAWM3zsxYUTxL2HT31IqDgx7xfOqiaiKCUAfAXxQIyo+VQMJ5B0ruXk0i1D2qA8CiShkHsJRvnhZHdzWXmameAbEeN1fnzs7PplKcOMV6dcyI6wot4mQK+z2XHYGQ1vd/5QE9cx0YD/D7U3fDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DigYG/Q8; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dtatulea@nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719141575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRG1uM3WBpbpg3xypH5GmXKA53Zu/bQzjXzygmQbgxU=;
	b=DigYG/Q8xKuD3izwp/FP6cw0OBaL3fjO3FjEaWeadzNCm+alcSIbKcNdsrvJ4yRCmKq1y3
	IhaYVsl6dF8pjGbLUyhLGE+DkmXu6dK4BPqEqkw3iGODSQUha2MRSK+2F4/mC5DZGFs06o
	XsWENHpR5kfeW1yx+3nTmCYYBrMtEJ8=
X-Envelope-To: mst@redhat.com
X-Envelope-To: jasowang@redhat.com
X-Envelope-To: xuanzhuo@linux.alibaba.com
X-Envelope-To: eperezma@redhat.com
X-Envelope-To: saeedm@nvidia.com
X-Envelope-To: leon@kernel.org
X-Envelope-To: tariqt@nvidia.com
X-Envelope-To: si-wei.liu@oracle.com
X-Envelope-To: virtualization@lists.linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: cratiu@nvidia.com
Message-ID: <aea8bc89-ca09-45d7-82ba-05c1fad8bebd@linux.dev>
Date: Sun, 23 Jun 2024 19:19:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH vhost 18/23] vdpa/mlx5: Forward error in suspend/resume
 device
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
 <20240617-stage-vdpa-vq-precreate-v1-18-8c0483f0ca2a@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-18-8c0483f0ca2a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/17 23:07, Dragos Tatulea 写道:
> Start using the suspend/resume_vq() error return codes previously added.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index f5d5b25cdb01..0e1c1b7ff297 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3436,22 +3436,25 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>   {
>   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	int err;

Reverse Christmas Tree?

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun
>   
>   	mlx5_vdpa_info(mvdev, "suspending device\n");
>   
>   	down_write(&ndev->reslock);
>   	unregister_link_notifier(ndev);
> -	suspend_vqs(ndev);
> +	err = suspend_vqs(ndev);
>   	mlx5_vdpa_cvq_suspend(mvdev);
>   	mvdev->suspended = true;
>   	up_write(&ndev->reslock);
> -	return 0;
> +
> +	return err;
>   }
>   
>   static int mlx5_vdpa_resume(struct vdpa_device *vdev)
>   {
>   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>   	struct mlx5_vdpa_net *ndev;
> +	int err;
>   
>   	ndev = to_mlx5_vdpa_ndev(mvdev);
>   
> @@ -3459,10 +3462,11 @@ static int mlx5_vdpa_resume(struct vdpa_device *vdev)
>   
>   	down_write(&ndev->reslock);
>   	mvdev->suspended = false;
> -	resume_vqs(ndev);
> +	err = resume_vqs(ndev);
>   	register_link_notifier(ndev);
>   	up_write(&ndev->reslock);
> -	return 0;
> +
> +	return err;
>   }
>   
>   static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
> 


