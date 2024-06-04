Return-Path: <linux-rdma+bounces-2816-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15A8FAEDB
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EE3287395
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C8C143862;
	Tue,  4 Jun 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0jRI4mi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DC23776;
	Tue,  4 Jun 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493544; cv=none; b=mewwhq6mDYaq71xcCB2zhVU4S2us/NSoc8zSP5F5OIhel2xaHxiDieElWFxYRoTDvJD5NBXjy3FuyNps2rgxoaex/Qq/KVkgCfGbMawlyWZIpfqoa/VW5uIpZw6tGV+FOGMcCIDArTc46bEAU1Xip0w1qRvGAT/aGpuL59n1jdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493544; c=relaxed/simple;
	bh=WbnbTofHxkrx5spG4fYxe59Me3aK8kFxL4l5hleeJcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcXYrPAr1qRiGyEgM+CEmckiHtVsGQXH/FKzDUGNCrWPUwHbVttAWRE7do6gFWHKNVE+ztMlLCo6BiDrSGPEgHtaCYm2g+85vUerU3dGQgf+afNrKVTb4TNTw5iRfAtPn1aD7eaJvid9qiRYmA64Hn3SyAeeqAfAbITtr9bDoLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0jRI4mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29689C2BBFC;
	Tue,  4 Jun 2024 09:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717493543;
	bh=WbnbTofHxkrx5spG4fYxe59Me3aK8kFxL4l5hleeJcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0jRI4mi3EdRcQYgF9pEa/gRYlCHIf6sBhGXBmPndUxYbrsyeeLEW/8Sfm3a20Fzg
	 MeLOvwKBiPo1OWfEl2uDOMB5FUbJ/Y4uav2hZeuNO8u9Ps+pw/Bh0cpWp+6jFxLPNp
	 kRar1fbeX+gaqiEP4V4+r6xUT4FCaufoJKKwj9nfQhyOpJSMBExEQsOUha/7P9jj2f
	 dYEbWrsjT69gMxDctMlj/JTo7xMp1UY0mbPIfZbbsbhzB5tPMvydaGjC5oGWQQvH+J
	 6MLj4wLAjtZE2lONLJA49KHrh80nJyX0FPEn0tsw61x5NKwtFtN2opIVtgoN0OkRM7
	 UPkA2bZvvIjEQ==
Date: Tue, 4 Jun 2024 12:32:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <20240604093219.GN3884@unreal>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>

On Mon, Jun 03, 2024 at 12:53:17PM -0300, Jason Gunthorpe wrote:
> Create the class, character device and functions for a fwctl driver to
> un/register to the subsystem.
> 
> A typical fwctl driver has a sysfs presence like:
> 
> $ ls -l /dev/fwctl/fwctl0
> crw------- 1 root root 250, 0 Apr 25 19:16 /dev/fwctl/fwctl0
> 
> $ ls /sys/class/fwctl/fwctl0
> dev  device  power  subsystem  uevent
> 
> $ ls /sys/class/fwctl/fwctl0/device/infiniband/
> ibp0s10f0
> 
> $ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
> fwctl0/
> 
> $ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
> dev  device  power  subsystem  uevent
> 
> Which allows userspace to link all the multi-subsystem driver components
> together and learn the subsystem specific names for the device's
> components.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  MAINTAINERS            |   8 ++
>  drivers/Kconfig        |   2 +
>  drivers/Makefile       |   1 +
>  drivers/fwctl/Kconfig  |   9 +++
>  drivers/fwctl/Makefile |   4 +
>  drivers/fwctl/main.c   | 174 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/fwctl.h  |  68 ++++++++++++++++
>  7 files changed, 266 insertions(+)
>  create mode 100644 drivers/fwctl/Kconfig
>  create mode 100644 drivers/fwctl/Makefile
>  create mode 100644 drivers/fwctl/main.c
>  create mode 100644 include/linux/fwctl.h

<...>

> +static struct fwctl_device *
> +_alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
> +{
> +	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
> +
> +	if (!fwctl)
> +		return NULL;

<...>

> +/* Drivers use the fwctl_alloc_device() wrapper */
> +struct fwctl_device *_fwctl_alloc_device(struct device *parent,
> +					 const struct fwctl_ops *ops,
> +					 size_t size)
> +{
> +	struct fwctl_device *fwctl __free(fwctl) =
> +		_alloc_device(parent, ops, size);

I'm not a big fan of cleanup.h pattern as it hides important to me
information about memory object lifetime and by "solving" one class of
problems it creates another one.

You didn't check if fwctl is NULL before using it.

> +	int devnum;
> +
> +	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
> +	if (devnum < 0)
> +		return NULL;
> +	fwctl->dev.devt = fwctl_dev + devnum;
> +
> +	cdev_init(&fwctl->cdev, &fwctl_fops);
> +	fwctl->cdev.owner = THIS_MODULE;
> +
> +	if (dev_set_name(&fwctl->dev, "fwctl%d", fwctl->dev.devt - fwctl_dev))

Did you miss ida_free() here?

> +		return NULL;
> +
> +	fwctl->ops = ops;
> +	return_ptr(fwctl);
> +}
> +EXPORT_SYMBOL_NS_GPL(_fwctl_alloc_device, FWCTL);

Thanks

