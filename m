Return-Path: <linux-rdma+bounces-2701-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753F8D4E48
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172D81F245E1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32B17C230;
	Thu, 30 May 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SEUafb3d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E90143C40;
	Thu, 30 May 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080371; cv=none; b=AQ97CW+NzmF/8Qnl3g4f9L6lj+Ut2ng9iM6pCttB5Esnh5KJ++3m0MfxegHfju5N8NkNIYMJpY9cwthXLfqxaaCvvamNg9smQsxMWU7ltPfTF/eLvhHCaOmc9gmaNnpBxNl/G/zx8Zku9S8cc18J2aCubZJgaoWMXV9kYWceabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080371; c=relaxed/simple;
	bh=gGFC3ez7u5SWieL0OmII6ee3CDNqiS9OXFUswGuhEno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am9zJJwhPToGpTBEBfKOcm+x9/Qnngtf+UHorRPU02ELe1wRDId3DKQAiQ8yAj7Qv0q0zY5aWe8C2rwggSaHU1CI+TGWETKXJ3aU8KYiWysqlBqDXc6pIGnRVsdRneFe0sRgARvdr08I3sTBZfqvQSj7BwlZy/9TP5o6h7iA3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SEUafb3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82693C2BBFC;
	Thu, 30 May 2024 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717080370;
	bh=gGFC3ez7u5SWieL0OmII6ee3CDNqiS9OXFUswGuhEno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEUafb3dFo6xnl3u40CCvUfUd0W+KN/NehN5BQq6rhjgVL7cEhTLp+1DIEUVrlzHQ
	 GWVLob3uZdFOS15aSopAaE2Vv8akkX+dIDkQS3/KGkeeWH5nYr5QKm1BoyyFbEjQGP
	 pLzwGsuqOseXFEBV6sUEwihRW92AXohqhNpSNZGM=
Date: Thu, 30 May 2024 16:46:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drori <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v5 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024053007-eldest-extending-3b19@gregkh>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <20240528091144.112829-2-shayd@nvidia.com>
 <2024052829-pretended-dad-ac9b@gregkh>
 <49c0676c-0b23-4df4-aa3c-d13e578e28f1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c0676c-0b23-4df4-aa3c-d13e578e28f1@nvidia.com>

On Wed, May 29, 2024 at 09:29:33AM +0300, Shay Drori wrote:
> 
> 
> On 28/05/2024 21:00, Greg KH wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, May 28, 2024 at 12:11:43PM +0300, Shay Drory wrote:
> > > +#ifdef CONFIG_SYSFS
> > > +/* Xarray of irqs to determine if irq is exclusive or shared. */
> > > +static DEFINE_XARRAY(irqs);
> > > +/* Protects insertions into the irqs xarray. */
> > > +static DEFINE_MUTEX(irqs_lock);
> > 
> > You access the irq xarray without grabbing the lock in places :(
> > 
> > But again, I fail to see why the xarray is needed at all, why isn't the
> > needed information here:
> > 
> > > +struct auxiliary_irq_info {
> > > +     struct device_attribute sysfs_attr;
> > > +     int irq;
> > > +};
> > 
> > Right there^ should contain everything you need, NOT a global array and
> > lock at all.
> 
> 
> 1) one xarray is per aux device that indicates which IRQs irqs are used
> by this device. this xarray is holding the info above.

Ok, please document that better, it's not obvious.

> 2) second xarray is global that tracks if irq share between multiple aux
> devices or exclusive to aux device.

That should not be a "global" thing, as now you are getting into what
the msi irq core should be handling, NOT the aux device.

Userspace should be able to determine, just by the number, if it is
"shared" or not by looking at them all, so why need to add complex logic
here to attempt to also mirror this information?

Doesn't the irq layer track this sufficiently?  And it wouldn't even be
correct if an irq was "shared" by a device that was NOT controlled by an
aux device so it could be incorrect.

thanks,

greg k-h

