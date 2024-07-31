Return-Path: <linux-rdma+bounces-4131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8662942D82
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 13:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A28B221C0
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F31AD9FC;
	Wed, 31 Jul 2024 11:52:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B81AC441;
	Wed, 31 Jul 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426760; cv=none; b=X8oynMsUUdqR1QOB5L5Mm/22Zv2Pkuw9I5VniSGbWZujmc6SfnxQGlnO3llFpxA37eBjGj3XC9k+XJjulO4IxKi9lIrpoH6K8AmP4qCItcT0SnBepLuoCUumURZAB3oUFtR8BLnfQ3Oc71G0zVWzu3MJbpTTDxekXVOj6gp3Pp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426760; c=relaxed/simple;
	bh=NyMO6iO1dLHjOXTSR5oxTaF4XpTD6O/Z4OOw0DPhHq8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmLTZ+F57xgCzqlHVASWYDf2Gszwp+bfCQolun5jnbcM40yIyztoLHk6eIiGmqKAG+7+dnogxge7yiFnbBk7Y/8z63npG0EOZjwebXgLPS/CSElkKkZoZZQsNi71NlEkUiQamLwXKoQE/AaTlAThzhwGSokYbABF5l+RPtBEbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WYr4R0bPpz6K9nm;
	Wed, 31 Jul 2024 19:49:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 891D11408F9;
	Wed, 31 Jul 2024 19:52:33 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 31 Jul
 2024 12:52:32 +0100
Date: Wed, 31 Jul 2024 12:52:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, Jakub
 Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, "David Ahern" <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, "Jiri Pirko" <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v2 7/8] fwctl/mlx5: Support for communicating with mlx5
 fw
Message-ID: <20240731125232.00005aad@Huawei.com>
In-Reply-To: <20240729162217.GB3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<7-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<20240726171013.00006e67@Huawei.com>
	<20240729162217.GB3625856@nvidia.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> > > +static void mlx5ctl_remove(struct auxiliary_device *adev)
> > > +{
> > > +	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);  
> > 
> > So this is calling fwctl_put(&mcdev->fwctl) on scope exit.
> > 
> > Why do you need to drop a reference beyond the one fwctl_unregister() is dropping
> > in cdev_device_del()?  Where am I missing a reference get?  
> 
> fwctl_register() / fwctl_unregister() are pairs. Internally they pair
> cdev_device_add() / cdev_device_del() which decrease some internal
> cdev refcounts.
> 
> _alloc_device() / __free(mlx5ctl) above are the other pair.
> device_initialize() holds a reference from probe to remove.
> 
> It has to work this way because if cdev_device_del() would put back
> all the references we would immediately UAF, eg:
> 
> 	cdev_device_del(&fwctl->cdev, &fwctl->dev);
> 
> 	/* Disable and free the driver's resources for any still open FDs. */
> 	guard(rwsem_write)(&fwctl->registration_lock);
> 	guard(mutex)(&fwctl->uctx_list_lock);
>                     ^^^^^^^
>                        Must still be allocated
> 
> And more broadly, though mlx5 does not use this, it would be safe for
> a driver to do:
> 
>     fwctl_unregister();
>     kfree(mcdev->mymemory);
>           ^^^^^^ Must still be allocated!
>     fwctl_put(&mcdev->fwctl);
> 
> So we have the two steps where unregister makes it safe for the driver
> to begin teardown but keeps memory around, and the final put which
> releases the memory after driver teardown is done.
> 
> This is also captured in the cleanup.h notation:
> 
> 	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = fwctl_alloc_device(
> 		&mdev->pdev->dev, &mlx5ctl_ops, struct mlx5ctl_dev,
> 		fwctl);
>                                   ^^^^^^^^^^^^
>                Here we indicate we have a ref on the stack from
>                fwctl_alloc_device
> 
> 	auxiliary_set_drvdata(adev, no_free_ptr(mcdev));
>                                     ^^^^^^^^^^^^^^^^^ Move the ref
> 				    into drvdata
> 
> 	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);
>                                     ^^^^^^^^^^^ Move the ref out of
> 				    drvdata onto the stack
> 

Thanks for the explanation.  I clearly needed more coffee that day :)
Personally I find this to be a confusing use of scoped cleanup
as we aren't associating a constructor / destructor with scope, but
rather sort of 'adopting ownership / destructor'.

Assuming my caffeine level is better today, maybe device managed is
more appropriate?
devm_add_action_or_reset to associate the destructor by placing
it immediately after the setup path for both the allocate and unregister.
Should run in very nearly same order for teardown as what you have here.

Alternatively this is just a new pattern I should get used to.

Jonathan




