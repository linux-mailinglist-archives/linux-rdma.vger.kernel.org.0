Return-Path: <linux-rdma+bounces-3293-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0990E3A9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 08:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60B91C214CA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 06:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619096F305;
	Wed, 19 Jun 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lZxkk/X2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653057CA6;
	Wed, 19 Jun 2024 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779507; cv=none; b=uuCUyYFiUzfyo+vwNzHjMW0LDPaJRSbl/nqqH7UYVyVpwfVU2H4FEW9M/1kozoe7eRon/0K+g+5PvDZlTUs08oKRP69pEnHp331GWBatp3j4S8q+76R2YdRerThKI5v0TDZs9A/BdxegFidH/DPMYqvT9WiypPQPltzLWP4jv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779507; c=relaxed/simple;
	bh=wrr20MYlmJISLBZ479QlSzHWiXSvqajc/N4FejGC6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRMKLvHHmA6zK3hNIZqvkcoUzZ3H6NKpSmLnuAn9h9dZC2/UIHc0oA2K8gXPzQhYqhUk+sjNMqVo3mqJ/vYf6OQodjXuqKVzPxoI8Noh1umjLCkqrxFyMeleTc2cr8KOOOzO8xyb3tMts9yFHYWV1hlSVCIqf+msXz7p5S/Vuss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lZxkk/X2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E71C2BBFC;
	Wed, 19 Jun 2024 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718779506;
	bh=wrr20MYlmJISLBZ479QlSzHWiXSvqajc/N4FejGC6KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZxkk/X2t6o2mOv0en5iHcSA2iE9lZIzB19u2GMP7o3dDN79r0B9ISqeXXR3g59rz
	 uSYkvEgLQrMLOXxR1mID/iVjJs2lajdu2crb+01NmLmua8X4qNjMc+4bMetgMRUWWw
	 CSWeHRHK5Ju0W+YwRpuJno/NXEHDBIJD73NyNt8c=
Date: Wed, 19 Jun 2024 08:45:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drori <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v7 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024061903-brutishly-hamper-af47@gregkh>
References: <20240618150902.345881-1-shayd@nvidia.com>
 <20240618150902.345881-2-shayd@nvidia.com>
 <2024061849-cupped-throwback-4fee@gregkh>
 <21f7e9b8-00aa-4e1f-a769-9606834a234b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f7e9b8-00aa-4e1f-a769-9606834a234b@nvidia.com>

On Wed, Jun 19, 2024 at 09:33:12AM +0300, Shay Drori wrote:
> 
> 
> On 18/06/2024 19:13, Greg KH wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, Jun 18, 2024 at 06:09:01PM +0300, Shay Drory wrote:
> > > diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
> > > new file mode 100644
> > > index 000000000000..3f112fd26e72
> > > --- /dev/null
> > > +++ b/drivers/base/auxiliary_sysfs.c
> > > @@ -0,0 +1,110 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> > > + */
> > > +
> > > +#include <linux/auxiliary_bus.h>
> > > +#include <linux/slab.h>
> > > +
> > > +struct auxiliary_irq_info {
> > > +     struct device_attribute sysfs_attr;
> > > +};
> > > +
> > > +static struct attribute *auxiliary_irq_attrs[] = {
> > > +     NULL
> > > +};
> > > +
> > > +static const struct attribute_group auxiliary_irqs_group = {
> > > +     .name = "irqs",
> > > +     .attrs = auxiliary_irq_attrs,
> > > +};
> > > +
> > > +static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
> > > +{
> > > +     int ret = 0;
> > > +
> > > +     mutex_lock(&auxdev->lock);
> > > +     if (auxdev->dir_exists)
> > > +             goto unlock;
> > 
> > You do know about cleanup.h, right?  Please use it.
> > 
> > But what exactly are you trying to protect here?  How will you race and
> > add two irqs at the same time?  Driver probe is always single threaded,
> > so what would be calling this at the same time from multiple places?
> 
> 
> mlx5 driver requests IRQs on demand for PCI PF, VF, SFs.
> And it occurs from multiple threads, hence we need to protect it.

How are irqs asked for, for the same device, from multiple threads?
What threads exactly?  What is causing these irqs to be asked for?

But ok, that's fine, if you want to do this, then properly protect the
allocation, don't just half-protect it like you did here :(

> > > +
> > > +     xa_init(&auxdev->irqs);
> > > +     ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
> > > +     if (!ret)
> > > +             auxdev->dir_exists = 1;
> > > +
> > > +unlock:
> > > +     mutex_unlock(&auxdev->lock);
> > > +     return ret;
> > > +}
> > > +
> > > +/**
> > > + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> > > + * @auxdev: auxiliary bus device to add the sysfs entry.
> > > + * @irq: The associated interrupt number.
> > > + *
> > > + * This function should be called after auxiliary device have successfully
> > > + * received the irq.
> > > + *
> > > + * Return: zero on success or an error code on failure.
> > > + */
> > > +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> > > +{
> > > +     struct device *dev = &auxdev->dev;
> > > +     struct auxiliary_irq_info *info;
> > > +     int ret;
> > > +
> > > +     ret = auxiliary_irq_dir_prepare(auxdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     info = kzalloc(sizeof(*info), GFP_KERNEL);
> > > +     if (!info)
> > > +             return -ENOMEM;
> > > +
> > > +     sysfs_attr_init(&info->sysfs_attr.attr);
> > > +     info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
> > > +     if (!info->sysfs_attr.attr.name) {
> > > +             ret = -ENOMEM;
> > > +             goto name_err;
> > > +     }
> > > +
> > > +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
> > 
> > So no lock happening here, either use it always, or not at all?
> 
> 
> the lock is only needed to protect the group (directory) creation, which
> will be used by all the IRQs of this auxdev.
> parallel calls to this API will always be with different IRQs, which
> means each IRQ have a unique index.

You are inserting into the sysfs group at the same time?  You are
calling xa_insert() at the same time?  Is that protected with some
internal lock?  If so, this needs to be documented a bunch here.

Allocating irqs is NOT a fast path, just grab a lock and do it right
please, don't make us constantly have to stare at the code to ensure it
is correct.

> > > +     if (ret)
> > > +             goto auxdev_xa_err;
> > > +
> > > +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
> > > +                                   auxiliary_irqs_group.name);
> > 
> > You do know that you are never going to see these files from the
> > userspace library tools that watch sysfs, right?  libudev will never see
> > them as you are adding them AFTER the device is created.
> > 
> > So, because of that, who is really going to use these files?
> 
> To learn about the interrupt mapping of the SF IRQs.

Who is going to "learn"?  Again, you are creating files that our
userspace tools will miss, so what userspace tools are going to be able
to learn anything here?

This is strongly implying that all of this is just a debugging aid.  So
please, put this in debugfs where that type of thing belongs.

> > > +     if (ret)
> > > +             goto sysfs_add_err;
> > > +
> > > +     return 0;
> > > +
> > > +sysfs_add_err:
> > > +     xa_erase(&auxdev->irqs, irq);
> > > +auxdev_xa_err:
> > > +     kfree(info->sysfs_attr.attr.name);
> > > +name_err:
> > > +     kfree(info);
> > 
> > Again, cleanup.h is your friend.
> > 
> > > +     return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
> > > +
> > > +/**
> > > + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
> > > + * @auxdev: auxiliary bus device to add the sysfs entry.
> > > + * @irq: the IRQ to remove.
> > > + *
> > > + * This function should be called to remove an IRQ sysfs entry.
> > > + */
> > > +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
> > > +{
> > > +     struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
> > > +     struct device *dev = &auxdev->dev;
> > > +
> > > +     sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
> > > +                                  auxiliary_irqs_group.name);
> > > +     xa_erase(&auxdev->irqs, irq);
> > > +     kfree(info->sysfs_attr.attr.name);
> > > +     kfree(info);
> > > +}
> > > +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
> > > diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> > > index de21d9d24a95..96be140bd1ff 100644
> > > --- a/include/linux/auxiliary_bus.h
> > > +++ b/include/linux/auxiliary_bus.h
> > > @@ -58,6 +58,7 @@
> > >    *       in
> > >    * @name: Match name found by the auxiliary device driver,
> > >    * @id: unique identitier if multiple devices of the same name are exported,
> > > + * @irqs: irqs xarray contains irq indices which are used by the device,
> > >    *
> > >    * An auxiliary_device represents a part of its parent device's functionality.
> > >    * It is given a name that, combined with the registering drivers
> > > @@ -138,7 +139,10 @@
> > >   struct auxiliary_device {
> > >        struct device dev;
> > >        const char *name;
> > > +     struct xarray irqs;
> > > +     struct mutex lock; /* Protects "irqs" directory creation */
> > 
> > Protects it from what?
> 
> please look the answer above

You need to document it here.  Or somewhere.  Don't rely on an email
thread from 10 years ago for when you look at this in 10 years and
wonder what is going on...

> > >        u32 id;
> > > +     u8 dir_exists:1;
> > 
> > I don't think this is needed, but if it really is, just use a bool.
> 
> 
> If you know of an API that query whether a specific group is exists on
> some device, can you please share it with me?
> I came out empty when I looked for one :(

Normally sysfs groups are NOT created this way at all.  Oh wait, they
can be now, why not use the new feature where a group is created by the
core but only exposed if an attribute is added there?

Will that work here?  See commit d87c295f599c ("sysfs: Introduce a
mechanism to hide static attribute_groups") for details.  That should
solve the issue of trying to figure out if the directory is present or
not logic.

thanks,

greg k-h

