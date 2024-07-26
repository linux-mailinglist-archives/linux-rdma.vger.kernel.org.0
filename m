Return-Path: <linux-rdma+bounces-4028-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A76393D6BB
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 18:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C031C22FB3
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A14C17C7BC;
	Fri, 26 Jul 2024 16:10:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F2200AF;
	Fri, 26 Jul 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010219; cv=none; b=GWX7I5sELOWvNA5/54b6pwUFnkhBC2roZdlaKz9LqNoPdJhHOJaYUTobo0t29OKsqpUYKznROro9dpOKUW75SUM5oCMjqjWBAS7tAY0Nk5K7GqSPKhmMsaXStDsmJw39RLrCe70j7/FlUtNQk/tOhJUhTczl4QRuaM2MBiQy0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010219; c=relaxed/simple;
	bh=YKgmSzZlu4BIydzWn7bGVh7bITwoK6YWkJlzgZoKcWs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ax+PGVZdJWy16Qhnqhopq++Dkfvb9SsOdqmzxoUiHFfpzyHxpbv7OIMlcpNXgStMGQIav9dh+jpEDJ5Wl+OA9KsM6kdXdJiSKVa1afLHXGiw8IWDqCn/5IV6YMnK8KzU97nkBYZ4aHPeLhEF92n0d2VJle4lDHeoUq28hz94/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVt2C0zlDz6K9Kk;
	Sat, 27 Jul 2024 00:07:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D2AAB1404FC;
	Sat, 27 Jul 2024 00:10:14 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 17:10:14 +0100
Date: Fri, 26 Jul 2024 17:10:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, Jakub
 Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v2 7/8] fwctl/mlx5: Support for communicating with mlx5
 fw
Message-ID: <20240726171013.00006e67@Huawei.com>
In-Reply-To: <7-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<7-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 19:47:31 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> mlx5's fw has long provided a User Context concept. This has a long
> history in RDMA as part of the devx extended verbs programming
> interface. A User Context is a security envelope that contains objects and
> controls access. It contains the Protection Domain object from the
> InfiniBand Architecture and both togther provide the OS with the necessary
> tools to bind a security context like a process to the device.
> 
> The security context is restricted to not be able to touch the kernel or
> other processes. In the RDMA verbs case it is also restricted to not touch
> global device resources.
> 
> The fwctl_mlx5 takes this approach and builds a User Context per fwctl
> file descriptor and uses a FW security capability on the User Context to
> enable access to global device resources. This makes the context useful
> for provisioning and debugging the global device state.
> 
> mlx5 already has a robust infrastructure for delivering RPC messages to
> fw. Trivially connect fwctl's RPC mechanism to mlx5_cmd_do(). Enforce the
> User Context ID in every RPC header so the FW knows the security context
> of the issuing ID.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

A few minor comments + a reference counting question.

> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> index 37147a695add9a..e5ee2d46d43126 100644
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -7,3 +7,17 @@ menuconfig FWCTL
>  	  support a wide range of lockdown compatible device behaviors including
>  	  manipulating device FLASH, debugging, and other activities that don't
>  	  fit neatly into an existing subsystem.
> +
> +if FWCTL

Why not use depends on FWCTL?

> +config FWCTL_MLX5
> +	tristate "mlx5 ConnectX control fwctl driver"
> +	depends on MLX5_CORE
> +	help
> +	  MLX5CTL provides interface for the user process to access the debug and
> +	  configuration registers of the ConnectX hardware family
> +	  (NICs, PCI switches and SmartNIC SoCs).
> +	  This will allow configuration and debug tools to work out of the box on
> +	  mainstream kernel.
> +
> +	  If you don't know what to do here, say N.
> +endif

> diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
> new file mode 100644
> index 00000000000000..5e64371d7e5508
> --- /dev/null
> +++ b/drivers/fwctl/mlx5/main.c



> +static void mlx5ctl_remove(struct auxiliary_device *adev)
> +{
> +	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);

So this is calling fwctl_put(&mcdev->fwctl) on scope exit.

Why do you need to drop a reference beyond the one fwctl_unregister() is dropping
in cdev_device_del()?  Where am I missing a reference get?

> +
> +	fwctl_unregister(&mcdev->fwctl);
> +}
> +
> +static const struct auxiliary_device_id mlx5ctl_id_table[] = {
> +	{.name = MLX5_ADEV_NAME ".fwctl",},
> +	{},

No point in comma after terminating entries

> +};
> +MODULE_DEVICE_TABLE(auxiliary, mlx5ctl_id_table);
> +
> +static struct auxiliary_driver mlx5ctl_driver = {
> +	.name = "mlx5_fwctl",
> +	.probe = mlx5ctl_probe,
> +	.remove = mlx5ctl_remove,
> +	.id_table = mlx5ctl_id_table,
> +};
> +
> +module_auxiliary_driver(mlx5ctl_driver);
> +
> +MODULE_IMPORT_NS(FWCTL);
> +MODULE_DESCRIPTION("mlx5 ConnectX fwctl driver");
> +MODULE_AUTHOR("Saeed Mahameed <saeedm@nvidia.com>");
> +MODULE_LICENSE("Dual BSD/GPL");

> +#endif


