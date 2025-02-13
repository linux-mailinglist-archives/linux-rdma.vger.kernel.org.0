Return-Path: <linux-rdma+bounces-7727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EFCA341D8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 15:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B209316538C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93CB281364;
	Thu, 13 Feb 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFhExKZI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61256281345;
	Thu, 13 Feb 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456721; cv=none; b=WNSO2/sa1vpP0BJnarIjuRURpqO4azENC4MtGAE7CWk9nGV0jgxJObuwuke6dEItBHRvAtvPMgVwM6Uu2VPy9ffsaFa9EQ3uYwcSccEMvzdJ+GjW8geuFLvPHFIrTAjn3O7G48V4cTnjLOR2skngjoAET/9IUKPHv2YS6Ny+R0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456721; c=relaxed/simple;
	bh=6E5SX+fs6O60hhZe8Qygi+YphymUSg0AYRAGUisCLi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Krx7YxibmvMVJAyLvDIoBfKu/RK2Vgt8Vxg5+ejFU/hXtywg+EFE+cDEU96IB8ajhGV0wAlqiVkppEfJh2Lpo22T2w47/UMpi3Lozc/pXC94ILMQSYDSABrJ3X7f3sTyj/6POAzWJ61bimtiFonfw/RDnjD+tLAsrOFrh0VNk4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFhExKZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF21AC4CED1;
	Thu, 13 Feb 2025 14:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739456720;
	bh=6E5SX+fs6O60hhZe8Qygi+YphymUSg0AYRAGUisCLi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFhExKZIhZbBJVwAlMefC/LreHiyt9BVV3SZnS/xtDnc3z2nJHlVRJoPxAUwwBhkG
	 2S/p191EG+mv/BKb3a88miTfVwyr2WAo6nFICJekdDxwEvIIJauUu749YRNP88f1lH
	 GVlOKy8eEy0PMLdk644kzFOdiIVDT1gf5thE1zih8G6LhaSpPDvvJoK1aIPoHGZZnB
	 I3LeyMXF4EkoZj+E3TbhJPECkBlkF0CeRAiqeQRyvoF7oYNhUfWwgUkStK56/ufZGn
	 jsxHGKTz2IxVhrFJpVf/5RzMcHT4xGYmWvbVYbf+4pievC4dqR8arJ28Af4HolIT7q
	 dTtLq0c9D4rrQ==
Date: Thu, 13 Feb 2025 16:25:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 07/10] fwctl/mlx5: Support for communicating with mlx5
 fw
Message-ID: <20250213142516.GM17863@unreal>
References: <7-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <daca71bd-547d-406c-83d8-05f8508703b2@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daca71bd-547d-406c-83d8-05f8508703b2@intel.com>

On Thu, Feb 13, 2025 at 02:19:38PM +0100, Przemek Kitszel wrote:
> On 2/7/25 01:13, Jason Gunthorpe wrote:
> > From: Saeed Mahameed <saeedm@nvidia.com>
> 
> In part this is a general feedback for the subsystem too.
> 
> > +FWCTL MLX5 DRIVER
> 
> I don't like this design.
> That way each and every real driver would need to make another one to
> just use fwctl.
> 
> Why not just require the real driver to call fwctl_register(opsstruct),
> with the required .validate, .do_cmd, etc commands backed there?
> There will be much less scaffolding.

We invented auxiliary_bus to actually reduce scaffolding. The auxiliary
devices allow split of complex, multi-subsystem devices without need
to create hard binding of their drivers.

It allows for every subsystem to have its own independent driver, which
can be loaded separately, something that is not possible with your idea.

> 
> Or the intention is to have this little driver replaced by OOT one,
> but keep the real (say networking) driver as-is from intree?

No, please read the purpose here drivers/base/auxiliary.c:

....
   23  * In some subsystems, the functionality of the core device (PCI/ACPI/other) is
   24  * too complex for a single device to be managed by a monolithic driver (e.g.
   25  * Sound Open Firmware), multiple devices might implement a common intersection
   26  * of functionality (e.g. NICs + RDMA), or a driver may want to export an
   27  * interface for another subsystem to drive (e.g. SIOV Physical Function export
   28  * Virtual Function management).  A split of the functionality into child-
   29  * devices representing sub-domains of functionality makes it possible to
   30  * compartmentalize, layer, and distribute domain-specific concerns via a Linux
   31  * device-driver model.
....

> 
> > +++ b/drivers/fwctl/mlx5/main.c
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> > +/*
> > + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> 
> -2025
> 
> > + */
> > +#include <linux/fwctl.h>
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/mlx5/device.h>
> > +#include <linux/mlx5/driver.h>
> 
> this breaks abstraction (at least your headers are in nice place, but
> this is rather uncommon, typical solution is to have them backed inside
> the driver directory) - the two drivers will be tightly coupled

FWCTL driver is connected to auxiliary device which is managed by some
other driver core (in our case mlx5_core). It is coupled by design.

> 
> > +module_auxiliary_driver(mlx5ctl_driver);
> > +
> > +MODULE_IMPORT_NS("FWCTL");
> > +MODULE_DESCRIPTION("mlx5 ConnectX fwctl driver");
> > +MODULE_AUTHOR("Saeed Mahameed <saeedm@nvidia.com>");
> > +MODULE_LICENSE("Dual BSD/GPL");
> > diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> > index 7a21f2f011917a..0790b8291ee1bd 100644
> > --- a/include/uapi/fwctl/fwctl.h
> > +++ b/include/uapi/fwctl/fwctl.h
> > @@ -42,6 +42,7 @@ enum {
> >   enum fwctl_device_type {
> >   	FWCTL_DEVICE_TYPE_ERROR = 0,
> > +	FWCTL_DEVICE_TYPE_MLX5 = 1,
> 
> is that for fwctl info to be able to properly report what device user
> has asked ioctl on? Would be great to embed 32byte long cstring of
> DRIVER_NAME, to don't need each and every device to come to you and
> ask for inclusion, that would also resolve problem of conflicting IDs
> (my-driver-id prior-to and after upstreaming)

Yes, we do want to make sure that FWCTL is used for upstream code and
don't want to open it for any out-of-tree drivers, which wants to use
this interface but didn't send it to upstream.

Thanks

> 
> 

