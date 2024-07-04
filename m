Return-Path: <linux-rdma+bounces-3644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0F927438
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 12:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE27B238E1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 10:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D161ABC4E;
	Thu,  4 Jul 2024 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PfxpnSDV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F221ABC3F;
	Thu,  4 Jul 2024 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089670; cv=none; b=EXJllssXOxi8EQCJunrOWJnUWcXD77Xr/7+NnfEVqUmIwyFoAZJm45c5+sO2YotfYdhDIOpRHBJ79u7jJyd5oVoeJfnAD58ntWK7WcA6jXFumhDqRlpWkZYyAh5uSNqEBde4RT5/ISmbptUpSkBuoJ1ZvXFzJEKHf9GSMWSrQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089670; c=relaxed/simple;
	bh=0x4ZOi9C7DdyMVJHpVTHw/IUws1rmnmEhR3InDO/NCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R370++X8Jw0Ed5t3Dzf6kVdfJrWCnuCxWjhu07P9Pap/VTLP+F8VhgzpthD+x9Vev/UV1ErQ05Hf4ZDTzNxMxy21W4614cTVn5E6/rGWGkFWnGWhtaUadyNWGirEzMuWEVpaZYf2y5BkRKNBN2jPg7o5igwK/lgGlyS3sR52gKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PfxpnSDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D389C3277B;
	Thu,  4 Jul 2024 10:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720089669;
	bh=0x4ZOi9C7DdyMVJHpVTHw/IUws1rmnmEhR3InDO/NCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfxpnSDVtQammiKOSkdkXaVFG2FUdEKrU1AnZCxMGXnNzO4Ghr7CmaYD+mhqlOLQD
	 BAOxqTeTtdLBUm0n3spesrabPFFcHsnrH+ogh6fxRkiZubuWTiOtcH5nVUtBKe+qet
	 EioEXA38Aej7+z9BVUEoukfVg12glFhs3q2BWGlU=
Date: Thu, 4 Jul 2024 12:41:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v9 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024070457-creatable-heroics-94cb@gregkh>
References: <20240703073858.932299-1-shayd@nvidia.com>
 <20240703073858.932299-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703073858.932299-2-shayd@nvidia.com>

On Wed, Jul 03, 2024 at 10:38:57AM +0300, Shay Drory wrote:
> +/**
> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: The associated interrupt number.
> + *
> + * This function should be called after auxiliary device have successfully
> + * received the irq.
> + * The driver is responsible to add a unique irq for the auxiliary device. The
> + * driver can invoke this function from multiple thread context safely for
> + * unique irqs of the auxiliary devices. The driver must not invoke this API
> + * multiple times if the irq is already added previously.
> + *
> + * Return: zero on success or an error code on failure.
> + */
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct auxiliary_irq_info *info __free(kfree) = NULL;
> +	struct device *dev = &auxdev->dev;
> +	char *name __free(kfree) = NULL;
> +	int ret;
> +
> +	ret = auxiliary_irq_dir_prepare(auxdev);
> +	if (ret)
> +		return ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	sysfs_attr_init(&info->sysfs_attr.attr);
> +	name = kasprintf(GFP_KERNEL, "%d", irq);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	info->sysfs_attr.attr.name = name;
> +	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
> +				      auxiliary_irqs_group.name);
> +	if (ret)
> +		goto sysfs_add_err;
> +
> +	info->sysfs_attr.attr.name = no_free_ptr(name);

This assignment of a name AFTER it has been created is odd.  I think I
know why you are doing this, but please make it obvious and perhaps
solve it in a cleaner way.  Assigning this "deep" in a sysfs structure
is not ok.


> +	xa_store(&auxdev->irqs, irq, no_free_ptr(info), GFP_KERNEL);
> +	return 0;
> +
> +sysfs_add_err:
> +	xa_erase(&auxdev->irqs, irq);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
> +
> +/**
> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: the IRQ to remove.
> + *
> + * This function should be called to remove an IRQ sysfs entry.
> + * The driver must invoke this API when IRQ is released by the device.
> + */
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct auxiliary_irq_info *info __free(kfree) =	xa_load(&auxdev->irqs, irq);

No verification that this is an actual entry before you dereferenced it?
Bold move...

greg k-h

