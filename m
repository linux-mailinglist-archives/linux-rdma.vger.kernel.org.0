Return-Path: <linux-rdma+bounces-2835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2824B8FB20D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D261C28368B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968D145FFA;
	Tue,  4 Jun 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtigBN5M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EE266A7;
	Tue,  4 Jun 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503748; cv=none; b=LlTyk6ZigG3utmyujxW95fhPrQCxIezL1PjCvbU+84v5pz0F4tZxIgksItbVyc3YAAvCgq2ViPbWvbT1q/eR0Lfwwlu5skSKkbRwUkfUFXRzNxrtmHfD6IpIhv9wAAARSEKPfCbfS6fw32jMgwQ6l0BeUEdV68z/s6BJYTyLDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503748; c=relaxed/simple;
	bh=VzJ8Fzy20WxViCnJYd8q5zvqvIU2EWkl8ZQDsXYO2N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maAKeDMVYlxtzsYO60APDgfpZmdve6mlkERRpYStoCSCC7O2OC1VjvLhxi/a9+CxIZB9mUwXBZU+SgSXOjuVwl+GCsQv9jziy5U7ZBCzAKCx8p/k6AKngnwrZk0BpmAI3MWVRcT8KqHv+h53kVs5uwiy8a+IJZs5Hd5z2Pdo2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtigBN5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEF5C2BBFC;
	Tue,  4 Jun 2024 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717503747;
	bh=VzJ8Fzy20WxViCnJYd8q5zvqvIU2EWkl8ZQDsXYO2N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtigBN5M9PT1p0ond8gNzYMF0fQ1Pz7e8gvKUX+pHtQi2/8NB6XgTBz+PCPe5G2iz
	 +esnK43uws2LBRgsQgFCAqM2n4U9CmPQSJ234y6bVIslOGlL2rmVh/uXXWe8EvwQZ5
	 zGko9m6ERVFGw8gAeUYRIRu2Ra19cF1R3agC0n4j9Lr8fMzUee9t7/OaI7/OsYHEfo
	 N43yXWaB04lVSMpZz5zHL/tqAsJbr4/2e0qt5B1Ovs+PVV05K0tkXVzMP+bY3cgCPz
	 qdNy3b+0iJYUUMjv29jerZa0ID9/4sM9M+PS70fs7JcZXWS7l2r1YR1xJQp66cLdPR
	 sJHObc2RWciCg==
Date: Tue, 4 Jun 2024 15:22:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character device
Message-ID: <20240604122221.GR3884@unreal>
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <6cfe00ce-1860-4aba-bcb8-54f8d365d2dc@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cfe00ce-1860-4aba-bcb8-54f8d365d2dc@linux.dev>

On Tue, Jun 04, 2024 at 02:16:12PM +0200, Zhu Yanjun wrote:
> On 03.06.24 17:53, Jason Gunthorpe wrote:
> > Each file descriptor gets a chunk of per-FD driver specific context that
> > allows the driver to attach a device specific struct to. The core code
> > takes care of the memory lifetime for this structure.
> > 
> > The ioctl dispatch and design is based on what was built for iommufd. The
> > ioctls have a struct which has a combined in/out behavior with a typical
> > 'zero pad' scheme for future extension and backwards compatibility.
> > 
> > Like iommufd some shared logic does most of the ioctl marshalling and
> > compatibility work and tables diatches to some function pointers for
> > each unique iotcl.
> > 
> > This approach has proven to work quite well in the iommufd and rdma
> > subsystems.
> > 
> > Allocate an ioctl number space for the subsystem.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >   MAINTAINERS                                   |   1 +
> >   drivers/fwctl/main.c                          | 124 +++++++++++++++++-
> >   include/linux/fwctl.h                         |  31 +++++
> >   include/uapi/fwctl/fwctl.h                    |  41 ++++++
> >   5 files changed, 196 insertions(+), 2 deletions(-)
> >   create mode 100644 include/uapi/fwctl/fwctl.h

<...>

> >   static int fwctl_fops_open(struct inode *inode, struct file *filp)
> >   {
> >   	struct fwctl_device *fwctl =
> >   		container_of(inode->i_cdev, struct fwctl_device, cdev);
> > +	struct fwctl_uctx *uctx __free(kfree) = NULL;
> > +	int ret;
> > +
> > +	guard(rwsem_read)(&fwctl->registration_lock);
> > +	if (!fwctl->ops)
> > +		return -ENODEV;
> > +
> > +	uctx = kzalloc(fwctl->ops->uctx_size, GFP_KERNEL |  GFP_KERNEL_ACCOUNT);
> > +	if (!uctx)
> > +		return -ENOMEM;
> > +
> > +	uctx->fwctl = fwctl;
> > +	ret = fwctl->ops->open_uctx(uctx);
> > +	if (ret)
> > +		return ret;
> 
> When something is wrong, uctx is freed in "fwctl->ops->open_uctx(uctx);"?
> 
> If not, the allocated memory uctx leaks here.

See how uctx is declared:
struct fwctl_uctx *uctx __free(kfree) = NULL;

It will be released automatically.
See include/linux/cleanup.h for more details.

Thanks

