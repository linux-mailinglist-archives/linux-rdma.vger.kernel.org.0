Return-Path: <linux-rdma+bounces-8361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE031A500DD
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 14:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC802166D91
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7B24C667;
	Wed,  5 Mar 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuGvP8gx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E224C093;
	Wed,  5 Mar 2025 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182198; cv=none; b=ncoZ1Jg/1Ar6HkZMzmL1UxbnllaMIOwBF0wC1TwOHTzhP6nYsOtG8Pt1/QO7PzhIkyiYGj+kMlOE8VWH3lGvG0R9LiensfyNbqicxjUlBaXHsaxwzYqcVUJV3pHayNEIN55V9IJZCETaUVAZCTSi5EYoKpufq1CT5fralK8LLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182198; c=relaxed/simple;
	bh=hACYmry5mavoy9iGc/jMWpNIkRV3U5lEjMTQ96xfWCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRCBrOf8x19Dt2b7Ft5zosz/jo7GCFWfPWgPAOM9DeAy+8vd/85S9ic0Fid9f3sfvgmNlp4dv2547Y4FQ1Fo7q93TxX8qor6LJmFxcMyGa7YwO5Dm4Bh0nMr4JahkXyRxf697Bwe2NYkIkml3/Y5LybfX8aHdZOFxO4Yo1P1q6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuGvP8gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD54C4CEE2;
	Wed,  5 Mar 2025 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741182197;
	bh=hACYmry5mavoy9iGc/jMWpNIkRV3U5lEjMTQ96xfWCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuGvP8gxvKyOG4pVV97o44Bea/z9eiB1V32/1KVIhtMAOxvjYZGYd6+cOSuQKSj/V
	 krBnRsoH6SpzchtGBVSSzVBBAhq4Winr0MbOO00ScW0ahfYNQQqk+5WWUvNA/4Z0rC
	 qF/HPn65YqPeHuZ7mcdFjq1P4cx0K+5NDRmDxecBt8pL868/Qj9PclFcyIB3t0mTRa
	 mJAF55Ohqo/TQzzbRo105l+CSvjloHQEc7CyO4a5V3VWUQ3kOCvSH02drFInDwyTfH
	 NckSZIUyhnkEQvoyLo+quKfFNrUUNRfpSyKAZeWZiC+7vYjVUhOPLPTWZQRqBCOIo5
	 P6r0oPYcqzgNQ==
Date: Wed, 5 Mar 2025 15:43:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250305134312.GK1955273@unreal>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305133254.GV133783@nvidia.com>

On Wed, Mar 05, 2025 at 09:32:54AM -0400, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
> > On Tue, 4 Mar 2025 10:00:36 -0400 Jason Gunthorpe wrote:
> > > I never agreed to that formulation. I suggested that perhaps runtime
> > > configurations where netdev is the only driver using the HW could be
> > > disabled (ie a netdev exclusion, not a rdma inclusion).
> > 
> > I thought you were arguing that me opposing the addition was
> > "maintainer overreach". As in me telling other parts of the kernel
> > what is and isn't allowed. Do I not get a say what gets merged under
> > drivers/net/ now?
> 
> The PCI core drivers are a shared resource jointly maintained by all
> the subsytems that use them. They are maintained by their respective
> maintainers. Saeed/etc in this case.
> 
> It would be inappropriate for your preferences to supersede Saeed's
> when he is a maintainer of the mlx5_core driver and fwctl. Please try
> and get Saeed on board with your plan.
> 
> If the placement under drivers/net makes this confusing then we can
> certainly change the directory names.

I suggested it before to Jakub and it looks like he is not opposing to it.
https://lore.kernel.org/all/20250211075553.GF17863@unreal/

Thanks

> 
> Jason
> 

