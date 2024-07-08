Return-Path: <linux-rdma+bounces-3746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A68392A733
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 18:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34B92882BA
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7B148FF6;
	Mon,  8 Jul 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QJWe8Uzf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFB147C85
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jul 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455753; cv=none; b=Fthb/nhTxy2FXtc1TJHNbXARwvUoN77WJdc33QWmkvxSyjTqj+d8GVeFhVWdiCIFscMR/YpDSoisKcDKTw+EgGJDk1VVK4wLoeVNWoN05NrBi4Ijac+BGkzgPdR6Uky6eevOGgDXe/VvsYEU2nc+kyT33RgcxBg3YCoYTbU3ZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455753; c=relaxed/simple;
	bh=PtWdQP9TUf3UnSMasmAy0oliIW93Gy0/rpFK2mRdEJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8OE90q5gSo1wHE136S9V3zvO01xDftbMP7K0koxP+cTm2UaLICRhmUncocZKbkVMnYCT2KTpQ7DbSRwRV3gCkgvJw9Wca1tELjoqt1+hgZbaeic4Dbp5ToPyUetyG/6uBaI4O9094zxcy7yZCRpCbKhrACIdfEHNScq6eLzU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QJWe8Uzf; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dtatulea@nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720455748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRPeq+TIECbg3XiWASLi/Zq5CIq0PmJjCGCHnJ56A2o=;
	b=QJWe8UzfU5nl9s7j/pqbZ84E8FYKmD4BQ8Q5uOys5WliEQB1P/WBYp0Wg2KuIUwRxkrpI0
	kbInJY9PF8ekfMVxzjqS21hEotrIzVmLa1rMJbZHPb50Usl1f3IKTRuEwdP7+7bAOCAYoW
	HKXSLtRaPxdC/HidlS0Ol8/ueek8yqY=
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
Message-ID: <34ce285c-d87d-4116-adbc-a2d691cfa4c9@linux.dev>
Date: Mon, 8 Jul 2024 18:22:26 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
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
 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/17 17:07, Dragos Tatulea 写道:
> Currently, hardware VQs are created right when the vdpa device gets into
> DRIVER_OK state. That is easier because most of the VQ state is known by
> then.
> 
> This patch switches to creating all VQs and their associated resources
> at device creation time. The motivation is to reduce the vdpa device
> live migration downtime by moving the expensive operation of creating
> all the hardware VQs and their associated resources out of downtime on
> the destination VM.

Hi, Dragos Tatulea

 From the above, when a device is created, all the VQs and their 
associated resources are also created.
If VM live migration does not occur, how much resources are wasted?

I mean, to achieve a better downtime, how much resource are used?

"
On a 64 CPU, 256 GB VM with 1 vDPA device of 16 VQps, the full VQ
resource creation + resume time was ~370ms. Now it's down to 60 ms
(only VQ config and resume). The measurements were done on a ConnectX6DX
based vDPA device.
"
 From the above, the performance is amazing.
If we expect to use it in the production hosts, how much resources 
should we prepare to achieve this downtime?

Zhu Yanjun

> 
> The VQs are now created in a blank state. The VQ configuration will
> happen later, on DRIVER_OK. Then the configuration will be applied when
> the VQs are moved to the Ready state.
> 
> When .set_vq_ready() is called on a VQ before DRIVER_OK, special care is
> needed: now that the VQ is already created a resume_vq() will be
> triggered too early when no mr has been configured yet. Skip calling
> resume_vq() in this case, let it be handled during DRIVER_OK.
> 
> For virtio-vdpa, the device configuration is done earlier during
> .vdpa_dev_add() by vdpa_register_device(). Avoid calling
> setup_vq_resources() a second time in that case.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 37 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 249b5afbe34a..b2836fd3d1dd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2444,7 +2444,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
>   	mvq = &ndev->vqs[idx];
>   	if (!ready) {
>   		suspend_vq(ndev, mvq);
> -	} else {
> +	} else if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
>   		if (resume_vq(ndev, mvq))
>   			ready = false;
>   	}
> @@ -3078,10 +3078,18 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>   				goto err_setup;
>   			}
>   			register_link_notifier(ndev);
> -			err = setup_vq_resources(ndev, true);
> -			if (err) {
> -				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> -				goto err_driver;
> +			if (ndev->setup) {
> +				err = resume_vqs(ndev);
> +				if (err) {
> +					mlx5_vdpa_warn(mvdev, "failed to resume VQs\n");
> +					goto err_driver;
> +				}
> +			} else {
> +				err = setup_vq_resources(ndev, true);
> +				if (err) {
> +					mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> +					goto err_driver;
> +				}
>   			}
>   		} else {
>   			mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
> @@ -3142,6 +3150,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
>   		if (mlx5_vdpa_create_dma_mr(mvdev))
>   			mlx5_vdpa_warn(mvdev, "create MR failed\n");
>   	}
> +	setup_vq_resources(ndev, false);
>   	up_write(&ndev->reslock);
>   
>   	return 0;
> @@ -3836,8 +3845,21 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		goto err_reg;
>   
>   	mgtdev->ndev = ndev;
> +
> +	/* For virtio-vdpa, the device was set up during device register. */
> +	if (ndev->setup)
> +		return 0;
> +
> +	down_write(&ndev->reslock);
> +	err = setup_vq_resources(ndev, false);
> +	up_write(&ndev->reslock);
> +	if (err)
> +		goto err_setup_vq_res;
> +
>   	return 0;
>   
> +err_setup_vq_res:
> +	_vdpa_unregister_device(&mvdev->vdev);
>   err_reg:
>   	destroy_workqueue(mvdev->wq);
>   err_res2:
> @@ -3863,6 +3885,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>   
>   	unregister_link_notifier(ndev);
>   	_vdpa_unregister_device(dev);
> +
> +	down_write(&ndev->reslock);
> +	teardown_vq_resources(ndev);
> +	up_write(&ndev->reslock);
> +
>   	wq = mvdev->wq;
>   	mvdev->wq = NULL;
>   	destroy_workqueue(wq);
> 


