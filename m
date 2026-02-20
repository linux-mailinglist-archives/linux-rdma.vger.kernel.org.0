Return-Path: <linux-rdma+bounces-17030-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJX6H2MAmGmV/AIAu9opvQ
	(envelope-from <linux-rdma+bounces-17030-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 07:34:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23025164FA3
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 07:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E868130210D7
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 06:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF52C0F84;
	Fri, 20 Feb 2026 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EBZTLNua"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60961D555;
	Fri, 20 Feb 2026 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771569245; cv=none; b=WahIVQI47Q55CSFc1udc8paWKMHCtZSwy9tHbFKwSc/JpZ0HDeBm2MF3iJVsD5Hc1K/Z/j523qEQ6JjsuoIlAznMgvHF72NMmViVq0G/hD4NkSfptcxlX81vjh20e5+53TH/nopO/+XihlD4+3xAFDFwl49aO3xAJudMwJFCS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771569245; c=relaxed/simple;
	bh=Ial17sfZgdVRiZ5JFwlMSLgTFo1LPcexMHaX94onETg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaKhh8VE288m0eWH7LRIaKcgC6cBcPCt3so3uponeLN33D/7uD4Tuy8eGpS/BtkJ5aFn8mCf5aq1q/tNkuLpneztQKDwVoBAYCMJn0IW1vi5ErFVLl847hjQKyTXXB3XgX7aMRW74hwbZqZjkZvPAoo8bmPoiIXdTDsjcOqlbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EBZTLNua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A349DC116D0;
	Fri, 20 Feb 2026 06:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771569245;
	bh=Ial17sfZgdVRiZ5JFwlMSLgTFo1LPcexMHaX94onETg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBZTLNuay2yyKESIcWpEoKJGo4zBffSI2G6ymTPRJKLu8EuK6qk9cn+K+b8PyMmKp
	 plAp5fIjthS+U/Ei/t32XPcpzz6MbCPJuTVZjCOgCCqS9kwQrGvma9WOTpLDVFhZUf
	 Xr1/SToJ9JyGZCP1mOfOjglWaUbH/cM5KfDRuGhs=
Date: Fri, 20 Feb 2026 07:34:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Amir Tzin <amirtz@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH V2] driver core: auxiliary bus: Fix sysfs creation on bind
Message-ID: <2026022040-casualty-dexterity-543c@gregkh>
References: <20260219210435.1769394-1-tariqt@nvidia.com>
 <DGJCHYS3SKIQ.1TIHQCMEOCRC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGJCHYS3SKIQ.1TIHQCMEOCRC@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17030-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23025164FA3
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 12:59:45AM +0100, Danilo Krummrich wrote:
> On Thu Feb 19, 2026 at 10:04 PM CET, Tariq Toukan wrote:
> > +/**
> > + * auxiliary_device_sysfs_irq_dir_init - initialize the IRQ sysfs directory
> > + * @auxdev: auxiliary bus device to initialize the sysfs directory.
> > + *
> > + * This function should be called by drivers to initialize the IRQ directory
> > + * before adding any IRQ sysfs entries. The driver is responsible for ensuring
> > + * this function is called only once and for handling any concurrency control
> > + * if needed.
> > + *
> > + * Drivers must call auxiliary_device_sysfs_irq_dir_destroy() to clean up when
> > + * done.
> > + *
> > + * Return: zero on success or an error code on failure.
> > + */
> > +int auxiliary_device_sysfs_irq_dir_init(struct auxiliary_device *auxdev)
> >  {
> > -	int ret = 0;
> > -
> > -	guard(mutex)(&auxdev->sysfs.lock);
> > -	if (auxdev->sysfs.irq_dir_exists)
> > -		return 0;
> > +	int ret;
> >  
> > -	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
> > +	ret = sysfs_create_group(&auxdev->dev.kobj, &auxiliary_irqs_group);
> >  	if (ret)
> >  		return ret;
> >  
> > -	auxdev->sysfs.irq_dir_exists = true;
> >  	xa_init(&auxdev->sysfs.irqs);
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_dir_init);
> > +
> > +/**
> > + * auxiliary_device_sysfs_irq_dir_destroy - destroy the IRQ sysfs directory
> > + * @auxdev: auxiliary bus device to destroy the sysfs directory.
> > + *
> > + * This function should be called by drivers to clean up the IRQ directory
> > + * after all IRQ sysfs entries have been removed. The driver is responsible
> > + * for ensuring all IRQs are removed before calling this function.
> > + */
> > +void auxiliary_device_sysfs_irq_dir_destroy(struct auxiliary_device *auxdev)
> > +{
> > +	xa_destroy(&auxdev->sysfs.irqs);
> > +	sysfs_remove_group(&auxdev->dev.kobj, &auxiliary_irqs_group);
> > +}
> > +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_dir_destroy);
> >  
> >  /**
> >   * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> > @@ -45,7 +70,8 @@ static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
> >   * @irq: The associated interrupt number.
> >   *
> >   * This function should be called after auxiliary device have successfully
> > - * received the irq.
> > + * received the irq. The driver must call auxiliary_device_sysfs_irq_dir_init()
> > + * before calling this function for the first time.
> 
> I'm not convinced by this approach. This adds two new sources of bugs for
> drivers.
> 
>   1. Drivers can now forget to call auxiliary_device_sysfs_irq_dir_init()
>      *before* auxiliary_device_sysfs_irq_add().
> 
>   2. Drivers can forget to call auxiliary_device_sysfs_irq_dir_destroy().
> 
> Instead, I suggest to keep the current approach and just replace
> devm_device_add_group() with devm_auxiliary_device_add_group(), which in its
> devres callback additionally clears auxdev->sysfs.irq_dir_exists.
> 
> In terms of the auxdev->sysfs.lock, I think this can still be removed, as it
> wasn't needed in the first place.
> 
> auxiliary_device_sysfs_irq_add() must only be called from a scope where the
> auxiliary device is guaranteed to be bound, so there can't be a concurrent
> unbind.
> 
> There may only be multiple concurrent calls to auxiliary_device_sysfs_irq_add()
> itself, and in this case irq_dir_exists can just be an atomic.
> 
> Yes, we're still stuck with an atomic for irq_dir_exists, but the driver API
> remains much simpler and less error prone.

I agree, your recommendations make sense.  And I still hate this irq
addition to auxdevices :(

thanks,

greg k-h

