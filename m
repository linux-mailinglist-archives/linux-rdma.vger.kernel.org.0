Return-Path: <linux-rdma+bounces-2416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9658C3025
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 09:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D241F2236B
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 07:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30906FBEA;
	Sat, 11 May 2024 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZaMO7+l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F49746E;
	Sat, 11 May 2024 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413493; cv=none; b=uosP0alHLRguj4SnaQVlCzWrIqRzO1rLirLuDdt2AyHNjTuZxb64d/myOKk9crpmAbXJtOhxYAub3sDRZI4/w6Zqfkz3CW0waBxWWZozHJ1vYkiOMaCCBUp/3gNcSdZimZUgzRcoErc33rgBCrtz1izzRJX1ihj33FGnyYk+KCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413493; c=relaxed/simple;
	bh=7Mu4uGHH+Dhu1BjP1Nz4XKCKXlvsAHbhwbg8D7W9UbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVVFaTLvNVMhlu0Dh2IYcn2Sk0lifa+lwQzFSrpH3GBPVaATErs87P1Lr2PQa4wKH7Pp3ubo61Ye+hsH83nC0H8/VHKjne5iXfX59bkAzy9dpaH/bA0vXLDLSH6vhs8o3IhYAv+rs4DryDIpWNwIVdij9LQ6Zson0Fw9N8OvDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZaMO7+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36779C2BD10;
	Sat, 11 May 2024 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715413492;
	bh=7Mu4uGHH+Dhu1BjP1Nz4XKCKXlvsAHbhwbg8D7W9UbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZaMO7+l9Macyuc00FJ81bCifSeH1FvKcvRFlyGy9fywB784HN0Ctfu7LgCnWzpBK
	 StMGb7+LE0E4zAIENz9ZznerD+c2/L6xUmoPO6PqWb89DS64QXaeXdlh+3fzGf8Mbv
	 iuZK3C/bkzpf8/sdeWuDfxy82K4Djd/jj2IfAsxU=
Date: Sat, 11 May 2024 08:44:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Shay Drory <shayd@nvidia.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, david.m.ertman@intel.com, rafael@kernel.org,
	ira.weiny@intel.com, linux-rdma@vger.kernel.org, leon@kernel.org,
	tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024051114-gladly-feline-4302@gregkh>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
 <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>
 <2024051038-compare-canon-4161@gregkh>
 <ae6e151e-0c34-4ff8-a9f7-40e4cbdb9dee@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6e151e-0c34-4ff8-a9f7-40e4cbdb9dee@intel.com>

On Fri, May 10, 2024 at 04:01:01PM +0200, Przemek Kitszel wrote:
> On 5/10/24 15:07, Greg KH wrote:
> > On Fri, May 10, 2024 at 02:54:49PM +0200, Przemek Kitszel wrote:
> > > > > +static ssize_t auxiliary_irq_mode_show(struct device *dev,
> > > > > +				       struct device_attribute *attr, char *buf)
> > > > > +{
> > > > > +	struct auxiliary_irq_info *info =
> > > > > +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
> > > > > +
> > > > > +	if (refcount_read(xa_load(&irqs, info->irq)) > 1)
> > > > 
> > > > refcount combined with xa?  That feels wrong, why is refcount used for
> > > > this at all?
> > > 
> > > Not long ago I commented on similar usage for ice driver,
> > > ~"since you are locking anyway this could be a plain counter",
> > > and author replied
> > > ~"additional semantics (like saturation) of refcount make me feel warm
> > > and fuzzy" (sorry if misquoting too much).
> > > That convinced me back then, so I kept quiet about that here.
> > 
> > But why is this being incremented / decremented at all?  What is that
> > for?
> 
> [global]
> This is just a counter, it is used to tell if given IRQ is shared or
> exclusive. Hence there is a global xarray for that.
> And my argument is for this case precisely.
> 
> [other]
> There is also a separate xarray for each auxdev (IIRC) which is used as
> generic dynamic container [that stores sysfs attrs], any other would
> work (with different characteristics), but I see no problems with
> picking xarray here.

Again, why is an xarray needed, why isn't this part of the auxdevice
structure to start with?

thanks,

greg k-h

