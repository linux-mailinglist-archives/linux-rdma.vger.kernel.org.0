Return-Path: <linux-rdma+bounces-2883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD448FC9BB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 13:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDA728279A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46611922F5;
	Wed,  5 Jun 2024 11:08:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB921946D3;
	Wed,  5 Jun 2024 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585724; cv=none; b=V4P7y5Q2oPkXnARuR6CPeSlLpp/R+c5D+xHpKxdDzZfBCZo4wKg79spmdqjCCypEU5DSsURUQECYnYs2qy/2BLVnhYoED0fuS3uL6U+ZWr1/kxvWqiW4ZaHFDBSRGoQvknnEjIiBrWgVN9ZX4BRSbmrDNJDCITEiIyv2WWIhgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585724; c=relaxed/simple;
	bh=l4kG0ENxp5e/iTXDU0KZBxI0YMPvJKRQAC/Xg5l2eMQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3kTy77CSKZe/wO2kq2y0+7shreRPx7175LQquEA60p4gq0Qa7gNzkm226Df1SnRInLIATeK7eyJ3NeB1KTZSiyNIM+GVoQfgcsEfwoALcZQpr/QLGbmftWkBnbOc+GlgVvrg0uwqUqwyFfpjTiF69+PrBwZxIcEiYCxIMRWbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvPjH3phJz6K67M;
	Wed,  5 Jun 2024 19:04:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A06E1400C9;
	Wed,  5 Jun 2024 19:08:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 12:08:38 +0100
Date: Wed, 5 Jun 2024 12:08:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Itay
 Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, "David Ahern" <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, "Jiri Pirko" <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <20240605120838.00000da5@Huawei.com>
In-Reply-To: <20240604185200.GN19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240604093219.GN3884@unreal>
	<20240604155009.GJ19897@nvidia.com>
	<20240604180555.000063c2@Huawei.com>
	<20240604185200.GN19897@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 4 Jun 2024 15:52:00 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jun 04, 2024 at 06:05:55PM +0100, Jonathan Cameron wrote:
> 
> > Trick for this is often to define a small function that allocates both the
> > ida and the device. With in that micro function handle the one error path
> > or if you only have two things to do, you can use __free() for the allocation.  
> 
> This style is already followed here, the _alloc_device() is the
> function that does everything before starting reference counting (IMHO
> it is the best pattern to use). If we move the ida allocation to that
> function then the if inside release is not needed.
> 
> Like this:

LGTM (this specific code, not commenting on fwctl in general yet as needs
more thinking time!)

> 
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index d25b5eb3aee73c..a26697326e6ced 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -267,8 +267,7 @@ static void fwctl_device_release(struct device *device)
>  	struct fwctl_device *fwctl =
>  		container_of(device, struct fwctl_device, dev);
>  
> -	if (fwctl->dev.devt)
> -		ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
> +	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
>  	mutex_destroy(&fwctl->uctx_list_lock);
>  	kfree(fwctl);
>  }
> @@ -288,6 +287,7 @@ static struct fwctl_device *
>  _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
>  {
>  	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
> +	int devnum;
>  
>  	if (!fwctl)
>  		return NULL;
> @@ -296,6 +296,12 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
>  	init_rwsem(&fwctl->registration_lock);
>  	mutex_init(&fwctl->uctx_list_lock);
>  	INIT_LIST_HEAD(&fwctl->uctx_list);
> +
> +	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
> +	if (devnum < 0)
> +		return NULL;
> +	fwctl->dev.devt = fwctl_dev + devnum;
> +
>  	device_initialize(&fwctl->dev);
>  	return_ptr(fwctl);
>  }
> @@ -307,16 +313,10 @@ struct fwctl_device *_fwctl_alloc_device(struct device *parent,
>  {
>  	struct fwctl_device *fwctl __free(fwctl) =
>  		_alloc_device(parent, ops, size);
> -	int devnum;
>  
>  	if (!fwctl)
>  		return NULL;
>  
> -	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
> -	if (devnum < 0)
> -		return NULL;
> -	fwctl->dev.devt = fwctl_dev + devnum;
> -
>  	cdev_init(&fwctl->cdev, &fwctl_fops);
>  	fwctl->cdev.owner = THIS_MODULE;
>  
> Jason


