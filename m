Return-Path: <linux-rdma+bounces-3658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C104992818B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 07:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DD51C2282C
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 05:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B919C13B2B1;
	Fri,  5 Jul 2024 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiJQVhUy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D513AD31;
	Fri,  5 Jul 2024 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720158785; cv=none; b=LnlRdgVYnk+ZVuoTWCcTVvFZ6GVzqPPWAdr59QnZeFAnSr37IOjhTUi3bbLRW2o9L2O5ofPYE5wh20+zeayU9bY5Z8QW5gKOV1Rd22DCtPgrSrL6LaOvtzSHMM8tjYl+g2q4uKb7kDIC94wa5GPMjcUBcttGpO9lH4SY6fpMLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720158785; c=relaxed/simple;
	bh=jMHVZeNcRV8JsaFDa4g59qr7+S/J+FjO3I0snJlN7sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO/WRpMRzSaybjCWSy4Lv6NGBRxqEokeJ+oLW010EoW3eJnr38aF0cbA1Jw5H18ZOHeoVH27TpSucvVOXqSZz7godVQDX7l/yPcj0irn24MdchpV7h+KbkRnGUcKjcIUCBbPwF8Cyj0ghH31rUtLWRo9gUbuTeEo8RTJhfdZxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qiJQVhUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2318CC116B1;
	Fri,  5 Jul 2024 05:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720158784;
	bh=jMHVZeNcRV8JsaFDa4g59qr7+S/J+FjO3I0snJlN7sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiJQVhUy2scDBW9Mn0YOVrzNalfIGvoT/bT3ThsHPfOhzdn44FQylAgfr4Gp7VWcs
	 h/rUnMsXAqBUxheG5oEdOnrBJHMNnzm1vqkRHjUgLsX9zV6aDdFxEDScoOSEaPhXJR
	 wAdmsPkVtoh2qS9beiwZwVWcybINB3kdJojTd5+o=
Date: Fri, 5 Jul 2024 07:53:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drori <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v9 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024070533-smashing-kilowatt-8ac0@gregkh>
References: <20240703073858.932299-1-shayd@nvidia.com>
 <20240703073858.932299-2-shayd@nvidia.com>
 <2024070457-creatable-heroics-94cb@gregkh>
 <c2f4a607-2840-4468-9c16-2edaca7844be@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2f4a607-2840-4468-9c16-2edaca7844be@nvidia.com>

On Fri, Jul 05, 2024 at 08:35:33AM +0300, Shay Drori wrote:
> 
> 
> On 04/07/2024 13:41, Greg KH wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jul 03, 2024 at 10:38:57AM +0300, Shay Drory wrote:
> > > +/**
> > > + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> > > + * @auxdev: auxiliary bus device to add the sysfs entry.
> > > + * @irq: The associated interrupt number.
> > > + *
> > > + * This function should be called after auxiliary device have successfully
> > > + * received the irq.
> > > + * The driver is responsible to add a unique irq for the auxiliary device. The
> > > + * driver can invoke this function from multiple thread context safely for
> > > + * unique irqs of the auxiliary devices. The driver must not invoke this API
> > > + * multiple times if the irq is already added previously.
> > > + *
> > > + * Return: zero on success or an error code on failure.
> > > + */
> > > +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> > > +{
> > > +     struct auxiliary_irq_info *info __free(kfree) = NULL;
> > > +     struct device *dev = &auxdev->dev;
> > > +     char *name __free(kfree) = NULL;
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
> > > +     name = kasprintf(GFP_KERNEL, "%d", irq);
> > > +     if (!name)
> > > +             return -ENOMEM;
> > > +
> > > +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     info->sysfs_attr.attr.name = name;
> > > +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
> > > +                                   auxiliary_irqs_group.name);
> > > +     if (ret)
> > > +             goto sysfs_add_err;
> > > +
> > > +     info->sysfs_attr.attr.name = no_free_ptr(name);
> > 
> > This assignment of a name AFTER it has been created is odd.  I think I
> > know why you are doing this, but please make it obvious and perhaps
> > solve it in a cleaner way.
> 
> I am doing it since I want the name memory to be freed in case of
> sysfs_add_file_to_group() fails.
> I don’t see a cleaner way available with cleanup.h.
> 
> > Assigning this "deep" in a sysfs structure is not ok.
> 
> when creating sysfs dynamically, there isn't a cleaner way to assign the
> name memory.
> The closest and exact same use case for pci irq sysfs which uses dynamic
> sysfs is msi_sysfs_populate_desc().
> It does not use cleanup.h but still has to assign.
> I Don’t have any other ideas on how to implement it any more elegantly
> with cleanup.h.
> Do you prefer to assign it before sysfs_add_file_to_group() similar to
> msi_sysfs_populate_desc() and avoid cleanup.h for now?

No, what msi_sysfs_populate_desc() does is not good, the only objection
here is the assignment after-the-fact you are doing just to work around
cleanup.h.  Surely there's a better way to tell it not to free the
pointer at this point in time other than this.

> > > +     xa_store(&auxdev->irqs, irq, no_free_ptr(info), GFP_KERNEL);
> > > +     return 0;
> > > +
> > > +sysfs_add_err:
> > > +     xa_erase(&auxdev->irqs, irq);
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
> > > + * The driver must invoke this API when IRQ is released by the device.
> > > + */
> > > +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
> > > +{
> > > +     struct auxiliary_irq_info *info __free(kfree) = xa_load(&auxdev->irqs, irq);
> > 
> > No verification that this is an actual entry before you dereferenced it?
> > Bold move...
> 
> Driver must do this for allocated irq. So xa_load cannot fail.
> In previous versions we had WARN_ON to catch driver bugs, but you didn’t
> like it.

Yes, because if something can happen, you handle the error properly, you
don't reboot a machine.

> I think this is fine the way it is in v9.

No, you are now causing a NULL dereference (or close to it) if something
went wrong.  Properly check this and handle it correctly.

thanks,

greg k-h

