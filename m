Return-Path: <linux-rdma+bounces-2638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F468D22E3
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 20:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC069B22722
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D416246453;
	Tue, 28 May 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGdW0yBJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD044C7E;
	Tue, 28 May 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919207; cv=none; b=eo4kR8O2eto7gKsM/ZMu7NOD7VDtQ2PkNYyZr/ChKcbxDklOni/RwcAyjbTvqFhECNfBzteHMaaFkBxcQJrnSkz4eOOqzBsBBxRz4Hx5hpgfZmmPBIA4U/bB5OPqUEQ8vf86w4CEb0IDrSJKTlxXibPDFq+kRoFR6uP9RCpKB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919207; c=relaxed/simple;
	bh=EBpocNbTbdzrhYBqZxwCzCJlT995g3wl4iXLBSp+0/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO8WLelbZ/k1XswD3B01k8K+wLfQEZ6kyomeiC4Cx1U0Tj4s2jivHMiDC/vbPhae2P0QCoSpHCsspEmLjLgirFUK39gDXnrP+VueCtzoMfoI+EaO6uQcnMAaJEV+2EwuTEY0/oL1nCVflW5U+Jnp4m96twdAq/cKAb/5+yjGHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GGdW0yBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801BFC3277B;
	Tue, 28 May 2024 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716919207;
	bh=EBpocNbTbdzrhYBqZxwCzCJlT995g3wl4iXLBSp+0/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGdW0yBJWNpktuyt6n6bS0lqmmJqPep6iUcO4NhJN7sA8nuG76z1M0pPWce3ibnUR
	 5/0I3884KBEm+4xE7yfco4RoKezOHyHSw16IpC66CrVV5bA1Aa5aYzZKXp9neYJnv+
	 mtts4/XorANFbDt8ru44/b//inGU0t5AyC4sknko=
Date: Tue, 28 May 2024 20:00:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v5 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024052829-pretended-dad-ac9b@gregkh>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <20240528091144.112829-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528091144.112829-2-shayd@nvidia.com>

On Tue, May 28, 2024 at 12:11:43PM +0300, Shay Drory wrote:
> +#ifdef CONFIG_SYSFS
> +/* Xarray of irqs to determine if irq is exclusive or shared. */
> +static DEFINE_XARRAY(irqs);
> +/* Protects insertions into the irqs xarray. */
> +static DEFINE_MUTEX(irqs_lock);

You access the irq xarray without grabbing the lock in places :(

But again, I fail to see why the xarray is needed at all, why isn't the
needed information here:

> +struct auxiliary_irq_info {
> +	struct device_attribute sysfs_attr;
> +	int irq;
> +};

Right there^ should contain everything you need, NOT a global array and
lock at all.

> +/* Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
> + * shared or exclusive.

Why are you using networking comment style here?  :)

> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index de21d9d24a95..760fadb26620 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -58,6 +58,7 @@
>   *       in
>   * @name: Match name found by the auxiliary device driver,
>   * @id: unique identitier if multiple devices of the same name are exported,
> + * @irqs: irqs xarray contains irq indices which are used by the device,
>   *
>   * An auxiliary_device represents a part of its parent device's functionality.
>   * It is given a name that, combined with the registering drivers
> @@ -138,6 +139,7 @@
>  struct auxiliary_device {
>  	struct device dev;
>  	const char *name;
> +	struct xarray irqs;

wait, why is an xarray added here too?  That feels wrong, or odd, or
something as you seem to have multiple xarrays here when it feels like
you need none.

confused,

greg k-h

