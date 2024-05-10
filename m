Return-Path: <linux-rdma+bounces-2402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4438C2561
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9A5285C1F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99E127E05;
	Fri, 10 May 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTCvtAVV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A115770E9;
	Fri, 10 May 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346457; cv=none; b=To0SOBffFoMVXNd8MGQ52x8JZOzAZMYhXVhRlgpfnGqKXZJIz6e2EyIzXa88IUYpMbo2vfIL7FiKQVBqB6B1MOlC/pWaFJj4TRFyy+Zw6/vt+j7DHM1OK8hA6ZhfVXMoYHqzhwoP0zY2pefVbKtMARj+7mnEEoi1QeRxNqLxhmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346457; c=relaxed/simple;
	bh=eZBekDYueq7dTj3EsTrYhn+R0h/zbH2nacPZ/K9B/NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4hT/Mgzib4726pvmjbx9ggfiWX6LkxwrfudKY5n//6dV9rRyV0HWWkBe3hOWCCjDBndHwda7rqoNQZMxGDhmk6rQ+FleNdvfKe/HMKYSHfUM34fqcML8F9geXY3NSwZjpAMy3rb0BUR6vk0HAeex2pBGdJWYkm4Yf16QsWoyzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTCvtAVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2A3C113CC;
	Fri, 10 May 2024 13:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715346457;
	bh=eZBekDYueq7dTj3EsTrYhn+R0h/zbH2nacPZ/K9B/NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTCvtAVVDo3/1q9FVWn5n9hIT9a4LCPsmvKgAijCudRWBzqiL9pYeGXEpsPfhPIRo
	 BLnUvkETXi099248nl7CsJKtXgJkBZFjFtiQnehxwC2K5EMFb0SlSwY3fxHz8rKQIk
	 +O+fWeRJKT8Tzo85r3XyjgOAbXUpJxeNIOaoQ71s=
Date: Fri, 10 May 2024 14:07:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Shay Drory <shayd@nvidia.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, david.m.ertman@intel.com, rafael@kernel.org,
	ira.weiny@intel.com, linux-rdma@vger.kernel.org, leon@kernel.org,
	tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024051038-compare-canon-4161@gregkh>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
 <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>

On Fri, May 10, 2024 at 02:54:49PM +0200, Przemek Kitszel wrote:
> > > +static ssize_t auxiliary_irq_mode_show(struct device *dev,
> > > +				       struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct auxiliary_irq_info *info =
> > > +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
> > > +
> > > +	if (refcount_read(xa_load(&irqs, info->irq)) > 1)
> > 
> > refcount combined with xa?  That feels wrong, why is refcount used for
> > this at all?
> 
> Not long ago I commented on similar usage for ice driver,
> ~"since you are locking anyway this could be a plain counter",
> and author replied
> ~"additional semantics (like saturation) of refcount make me feel warm
> and fuzzy" (sorry if misquoting too much).
> That convinced me back then, so I kept quiet about that here.

But why is this being incremented / decremented at all?  What is that
for?

> The "use least powerful option" rule of thumb is perhaps more important.

Yes, but use a refcount properly if needed, I can't figure out why a
refcount is needed here at all, which is not a good sign.

> > > +	refcount_set(new_ref, 1);
> > > +	ref = __xa_cmpxchg(&irqs, irq, NULL, new_ref, GFP_KERNEL);
> > > +	if (ref) {
> > > +		kfree(new_ref);
> > > +		if (xa_is_err(ref)) {
> > > +			ret = xa_err(ref);
> > > +			goto out;
> > > +		}
> > > +
> > > +		/* Another thread beat us to creating the enrtry. */
> > > +		refcount_inc(ref);
> > 
> > How can that happen?  Why not just use a normal simple lock for all of
> > this so you don't have to mess with refcounts at all?  This is not
> > performance-relevent code at all, but yet with a refcount you cause
> > almost the same issues that a normal lock would have, plus the increased
> > complexity of all of the surrounding code (like this, and the crazy
> > __xa_cmpxchg() call)
> > 
> > Make this simple please.
> 
> I find current API of xarray not ideal for this use case, and would like
> to fix it, but let me write a proper RFC to don't derail (or slow down)
> this series.

Why do you need to use an xarray here at all?  Why isn't this just tied
directly to the aux device instead?

thanks,

greg k-h

