Return-Path: <linux-rdma+bounces-8374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50729A50A01
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 19:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707A118828E0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6AD24C062;
	Wed,  5 Mar 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W986ocoQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CB1A3176;
	Wed,  5 Mar 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199338; cv=none; b=oYBXOvpckmRj7mu6XGCddpovODrJPH0ZvvcbBLLue+sBkAgHbg23R/uYxvhXig0NUUeITiWWyXL/kGW+3e0jMofpIYhwOQBoo4qXcdYEE0aObV2XfBnEaI3PsWiyaK23RwIGESIZlif+BtttzG49nW7fPWEKv2PNrXF+nQXVY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199338; c=relaxed/simple;
	bh=pBny9ifWiptQqZ9hwjtC4ZSxlhIwIukDkjRyjC6JwaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okEUf24gEII7wEcbc9dDgt7a0drWPiBzNEUN1vorrkgQPG3JmsDKNt+utlBjtwEBfqzvXPXEPQRfiG2OcIY+yqSnsQ5ggBk4Wz/3oCCAw8KNrX5J3LJv07BnhZ6BQf+7lnFtwlBOKfxdJI0SQKe8tseLOAGPOqhub2gouZswr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W986ocoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33DAC4CED1;
	Wed,  5 Mar 2025 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199337;
	bh=pBny9ifWiptQqZ9hwjtC4ZSxlhIwIukDkjRyjC6JwaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W986ocoQKtJ6ZQgT46iwINV0zSY/df04EHobzRXH6PQgBUeQzuALAVDjqD/guMFud
	 WJqNmBfcJi3oDG3rJARj6saWRNsj0JUhCrBviCFj5EoZVrnoIjEZeMDL8VFKorTMqE
	 E14kAEJ8M9ZNNjj+jpW3jHeoL8Dcr2zvqkZrbrFWTCK8EW569TX0xfdP1oGbKGNyZA
	 zzeTL6ki4k6paKaCY2CBx4ZrXTix81w7HmScM9tW4VTaamwADQNnpDbUwzfXvApjYP
	 ujsuuNKT3vy/0MvFTMLwRw4pb3hwZsDka7LmCSJX/3Y4u90zzT4Q8oiAc0D/a0l8ji
	 JKe8cxi9CqpTQ==
Date: Wed, 5 Mar 2025 20:28:53 +0200
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
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250305182853.GO1955273@unreal>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>

On Wed, Mar 05, 2025 at 11:17:19AM -0700, David Ahern wrote:
> On 3/5/25 8:08 AM, Jiri Pirko wrote:
> > Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
> >> On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
> >>> I thought you were arguing that me opposing the addition was
> >>> "maintainer overreach". As in me telling other parts of the kernel
> >>> what is and isn't allowed. Do I not get a say what gets merged under
> >>> drivers/net/ now?
> >>
> >> The PCI core drivers are a shared resource jointly maintained by all
> >> the subsytems that use them. They are maintained by their respective
> >> maintainers. Saeed/etc in this case.
> >>
> >> It would be inappropriate for your preferences to supersede Saeed's
> >> when he is a maintainer of the mlx5_core driver and fwctl. Please try
> >> and get Saeed on board with your plan.
> >>
> >> If the placement under drivers/net makes this confusing then we can
> >> certainly change the directory names.
> > 
> > According to how mlx5 driver is structured, and the rest of the advanced
> > drivers in the same area are becoming as well, it would make sense to me
> > to have mlx5 core in separate core directory, maintained directly by driver
> > maintainer:
> > drivers/core/mlx5/
> > then each of the protocol auxiliary device lands in appropriate
> > subsystem directory.
> 
> +1
> 
> This is how I have structured our drivers -- core driver for owning the
> PCI device and hosting the APIs to communicate with hardware, an aux bus
> and then smaller subsystem focused drivers for the aux devices that make
> the device usable from different contexts.
> 
> I think we are ready to start upstreaming, but I am waiting to see how
> this falls out - to see if our core driver can land in a non-subsystem
> specific location (e.g., drivers/core) or if it needs to go with fwctl
> as a generic location.

Do it right, and push it to drivers/core. I'm aware of at least one
driver from huge company (not Nvidia) which is in preparation phase
before upstreaming, and will fit nicely into this model.

They have separated blocks for PCI, eth, RDMA and GPU.

Thanks

> 
> 
> 
> 

