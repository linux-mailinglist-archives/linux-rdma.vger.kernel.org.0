Return-Path: <linux-rdma+bounces-8659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D1DA5F4E6
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59521188B853
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674326770B;
	Thu, 13 Mar 2025 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na9vtaZz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1FE42052;
	Thu, 13 Mar 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870134; cv=none; b=ChshtTYIAo2BqzqRTmCK1exnqZqdbEtcw7TnSMWLOQrrJQMrp5+Tb4yK5iu7FpFr1s+Hz5DMBLBLjHxt0IKvdCS9/pwBzoq4V54iJHWoc23uENcuzp0YU2j8WS3nht8atNSb1eSShm41HJJZMFDgecR7y2s5+UEcIVxurb/SSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870134; c=relaxed/simple;
	bh=IgK5NTQVJ4ndLcVx8X26Yq65Ki9bz6QeXktpQ+rC+jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRMRfkGwacjVMC/ZAxRn7VGwm+XVIOul/NlmT6No8iw30ZX/+Bp2SrnbPPHGuR6KwFNwm1RknNoZaoiLjwWC7Evlny1YQHygjEYlzbxAqs9ctVqykAds8FoWfDgLlKuFkJ766F+ybvXXNXysSLUpvZPXTzrwxmUCfCkNhWKYjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na9vtaZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA78C4CEE5;
	Thu, 13 Mar 2025 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741870133;
	bh=IgK5NTQVJ4ndLcVx8X26Yq65Ki9bz6QeXktpQ+rC+jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Na9vtaZzWnrl00UAI6t9ajPnmhLddOufTG4FtBqL8v/gjKjtNzUGaI35JWz9xA7nl
	 xkOlBHoXEKfWTY4ZuXuS1Rjx79+TgCayF2Uzp842iFRp6vCBfRiV9/aY2wrTBFxzLS
	 WjlNy0akOxiKHA1fDw7v5CSsPJ6Vk6EnrAXiSdKWM7Aqd44VidqVjeS/hPJjYcfeS+
	 Swm4X3nJLrUQbrc4Q/Ws05gzAWe39rS2z3UDQUZdoGBtyg0Wsdaz82QSLmtmSKGeVa
	 X1btDUKNM36evwqDUeww8b+jnFDBRKBkHiaLxO4zQLOdYhSlkrXpVC6o/88zEv7K7L
	 E5ZsK6zvcDRzQ==
Date: Thu, 13 Mar 2025 14:48:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	"Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250313124847.GM1322339@unreal>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>

On Thu, Mar 13, 2025 at 01:30:52PM +0100, David Ahern wrote:
> On 3/5/25 7:28 PM, Leon Romanovsky wrote:
> > On Wed, Mar 05, 2025 at 11:17:19AM -0700, David Ahern wrote:
> >> On 3/5/25 8:08 AM, Jiri Pirko wrote:
> >>> Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
> >>>> On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
> >>>>> I thought you were arguing that me opposing the addition was
> >>>>> "maintainer overreach". As in me telling other parts of the kernel
> >>>>> what is and isn't allowed. Do I not get a say what gets merged under
> >>>>> drivers/net/ now?
> >>>>
> >>>> The PCI core drivers are a shared resource jointly maintained by all
> >>>> the subsytems that use them. They are maintained by their respective
> >>>> maintainers. Saeed/etc in this case.
> >>>>
> >>>> It would be inappropriate for your preferences to supersede Saeed's
> >>>> when he is a maintainer of the mlx5_core driver and fwctl. Please try
> >>>> and get Saeed on board with your plan.
> >>>>
> >>>> If the placement under drivers/net makes this confusing then we can
> >>>> certainly change the directory names.
> >>>
> >>> According to how mlx5 driver is structured, and the rest of the advanced
> >>> drivers in the same area are becoming as well, it would make sense to me
> >>> to have mlx5 core in separate core directory, maintained directly by driver
> >>> maintainer:
> >>> drivers/core/mlx5/
> >>> then each of the protocol auxiliary device lands in appropriate
> >>> subsystem directory.
> >>
> >> +1
> >>
> >> This is how I have structured our drivers -- core driver for owning the
> >> PCI device and hosting the APIs to communicate with hardware, an aux bus
> >> and then smaller subsystem focused drivers for the aux devices that make
> >> the device usable from different contexts.
> >>
> >> I think we are ready to start upstreaming, but I am waiting to see how
> >> this falls out - to see if our core driver can land in a non-subsystem
> >> specific location (e.g., drivers/core) or if it needs to go with fwctl
> >> as a generic location.
> > 
> > Do it right, and push it to drivers/core. I'm aware of at least one
> > driver from huge company (not Nvidia) which is in preparation phase
> > before upstreaming, and will fit nicely into this model.
> > 
> > They have separated blocks for PCI, eth, RDMA and GPU.
> > 
> 
> Adding that group here after an offlist discussion with that team. If I
> understand correctly, their preferred driver breakout is:
> 
> 
>       ┌───────────────────────────────────────────────────────────┐
>       │                      Platform Driver                      │
>       │                      habanalabs                           │
>       └────────▲───────────────────▲────────────────────▲─────────┘
>                │AUX                │AUX                 │AUX
>       ┌────────┴────────┐ ┌────────┴────────┐ ┌─────────┴─────────┐
>       │ Accel Driver    │ │ Ethernet Driver │ │ InfiniBand Driver │
>       │ habanalabs_accel│ │ habanalabs_en   │ │ habanalabs_ib     │
>       └─────────────────┘ └─────────────────┘ └───────────────────┘

You got it right.

> 
> So that means 3 different vendors and 3 different devices looking for a
> similar auxbus based hierarchy with a core driver not buried within one
> of the subsystems.
> 
> I guess at this point we just need to move forward with the proposal and
> start sending patches.
> 
> Seems like drivers/core is the consensus for the core driver?

Yes, anything that is not aux_core is fine by me.

drivers/core or drivers/aux.

Thanks

> 

