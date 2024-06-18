Return-Path: <linux-rdma+bounces-3279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E42D90D83E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4336D1C24632
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321A4D599;
	Tue, 18 Jun 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BHt4dUg3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFF1CD26;
	Tue, 18 Jun 2024 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726891; cv=none; b=YGLBDLN5o9hqBreSSxYX3qMy0i1hcdGxKL28yjN8cvOoUqJNOEvh8/XqxfyJp/hn0RMrDgSauJFLfm5KxITn0OyrRg5UAyzwoOicZdL1M8IRMwlFON2dxX421kFwnypaUh/3BuOerM2NvZpP+UQ3K5kBP4w2Poxye8QI1r+rxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726891; c=relaxed/simple;
	bh=zlIm1WzKbhNzUK7tcnez/bSSxuQpZcA+VINGnSx8DrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW1L7z0xn3My5wvx5NmScQ656gaAwQLXf8AV7II/lo/jxNEVpHGLQtNMpfOpML8oSgaG0DmGwD22YmV7W9o8f7+sc7z9dRObpkRKZH/RZbmayLO2d2yDMdXmjZ8X6UAlWZJPWukDlVmdcJ3dlLPpQDc0yUdhXZlRiFlHUpt2zjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BHt4dUg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D1CC3277B;
	Tue, 18 Jun 2024 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718726889;
	bh=zlIm1WzKbhNzUK7tcnez/bSSxuQpZcA+VINGnSx8DrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHt4dUg3tbNK71ZBewAGy/C6H730qgiamC6+fyFiy1kFiA6tCBt1OTuM5iiBK4r6C
	 V/9q9RZMcjPlfScxuXZtzpKwNjz/pM2yIn5nXSbmcErqObJ3xCD2p3hGUGEm+j5fL1
	 i1B0DRE6tT5SgYzzJBfkEvAlWkUABe15Yy1xtqaY=
Date: Tue, 18 Jun 2024 18:08:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Shay Drory <shayd@nvidia.com>, rafael@kernel.org, ira.weiny@intel.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, leon@kernel.org,
	tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>,
	pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, david.m.ertman@intel.com
Subject: Re: [PATCH net-next v7 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024061840-coping-rubbing-7af3@gregkh>
References: <20240618150902.345881-1-shayd@nvidia.com>
 <20240618150902.345881-2-shayd@nvidia.com>
 <ca97ec5b-9b46-4456-bf5b-37136aa7f1bf@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca97ec5b-9b46-4456-bf5b-37136aa7f1bf@intel.com>

On Tue, Jun 18, 2024 at 05:47:15PM +0200, Przemek Kitszel wrote:
> On 6/18/24 17:09, Shay Drory wrote:
> > PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
> > and virtual functions are anchored on the PCI bus. The irq information
> > of each such function is visible to users via sysfs directory "msi_irqs"
> > containing files for each irq entry. However, for PCI SFs such
> > information is unavailable. Due to this users have no visibility on IRQs
> > used by the SFs.
> > Secondly, an SF can be multi function device supporting rdma, netdevice
> > and more. Without irq information at the bus level, the user is unable
> > to view or use the affinity of the SF IRQs.
> > 
> > Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> > for supporting auxiliary devices, containing file for each irq entry.
> > 
> > For example:
> > $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> > 50  51  52  53  54  55  56  57  58
> > 
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > Signed-off-by: Shay Drory <shayd@nvidia.com>
> > 
> > ---
> > v6-v7:
> > - dynamically creating irqs directory when first irq file created (Greg)
> > - removed irqs flag and simplified the dev_add() API (Greg)
> > - move sysfs related new code to a new auxiliary_sysfs.c file (Greg)
> 
> [...]
> 
> > +static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
> > +{
> > +	int ret = 0;
> > +
> > +	mutex_lock(&auxdev->lock);
> > +	if (auxdev->dir_exists)
> > +		goto unlock;
> > +
> > +	xa_init(&auxdev->irqs);
> 
> due to below error handling you could end up with calling xa_init()
> twice (and this is a "library" code, so it does not matter how you
> handle this error in the current sole user ;))
> 
> > +	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
> > +	if (!ret)
> > +		auxdev->dir_exists = 1;
> > +
> > +unlock:
> > +	mutex_unlock(&auxdev->lock);
> > +	return ret;
> > +}
> > +
> 
> [...]
> 
> > --- a/include/linux/auxiliary_bus.h
> > +++ b/include/linux/auxiliary_bus.h
> > @@ -58,6 +58,7 @@
> >    *       in
> >    * @name: Match name found by the auxiliary device driver,
> >    * @id: unique identitier if multiple devices of the same name are exported,
> > + * @irqs: irqs xarray contains irq indices which are used by the device,
> >    *
> >    * An auxiliary_device represents a part of its parent device's functionality.
> >    * It is given a name that, combined with the registering drivers
> > @@ -138,7 +139,10 @@
> >   struct auxiliary_device {
> >   	struct device dev;
> >   	const char *name;
> > +	struct xarray irqs;
> > +	struct mutex lock; /* Protects "irqs" directory creation */
> >   	u32 id;
> > +	u8 dir_exists:1;
> 
> nit: I would make it a bool, or `bool: 1` if you really want

Why is this even needed?  It should "know" if the directory is there or
not, it can always be looked up, right?

thanks,

greg k-h

