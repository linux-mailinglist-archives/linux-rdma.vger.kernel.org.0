Return-Path: <linux-rdma+bounces-4015-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18993D504
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 16:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4333FB23263
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A52101E2;
	Fri, 26 Jul 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TsQXTjqN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998261CD06;
	Fri, 26 Jul 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003760; cv=none; b=P53iCwarPVZRkzAzGwijskuVRs1M6zjcJsE2DJ07lSyrdXvl0YwVUKxfrZgqWGnDSiNes6p8pVrPYApQF7BMj4fj5k220l2wm2t7XcEuLupSFgGUXyp1j3FiDF5mtSwKFPZhxoAHyQOagindOxN83Qh47jloIQ+oK0KyL8siXBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003760; c=relaxed/simple;
	bh=ptPTOXG6iazO8ssa3v+TQP7xqWA7KoIfLLeDca81Lbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycm6s2gl+U45PB1LmnkICQlYreZTEgQJBJauxogjk2/fY2qhMIPJNxpJacMs416vzQVZAYXICn2pUYhTuQEe1qwVGY4cPVf1qNXXyBMo/MGx5XGXNUwXsHN7M/GxCKOxUAjks1kNtqq8jnnULbPHFNPpoq3xA+izpDpG9C7SeXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TsQXTjqN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 706268CC;
	Fri, 26 Jul 2024 16:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722003712;
	bh=ptPTOXG6iazO8ssa3v+TQP7xqWA7KoIfLLeDca81Lbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsQXTjqNRjl4wY4e866kYoS2qEsti/RTobF94ZuINUxfgjrGuwBZTFKtUZPJ65mXE
	 QOGKCkKfZjv4pG2chRSxtpPkoDhovaRccJigwoaw8vpfC1INjShALevMF5rPXVGx7C
	 uEqYPyJAuo1stUGCNf45Gzdi0I1ftQuuYkLJ44Yk=
Date: Fri, 26 Jul 2024 17:22:17 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240726142217.GF28621@pendragon.ideasonboard.com>
References: <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
 <20240725194314.GS3371438@nvidia.com>
 <20240725200703.GG14252@pendragon.ideasonboard.com>
 <CAPybu_0C44q+d33LN8yKGSyv6HKBMPNy0AG4LkCOqxc87w3WrQ@mail.gmail.com>
 <20240726124949.GI32300@pendragon.ideasonboard.com>
 <20240726131106.GW3371438@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726131106.GW3371438@nvidia.com>

On Fri, Jul 26, 2024 at 10:11:06AM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 26, 2024 at 03:49:49PM +0300, Laurent Pinchart wrote:
> 
> > What is not an option exactly in my description above ? We have multiple
> > V4L2 drivers for ISPs. They receive ISP parameters from userspace
> > through a data buffer. It's not allowed to be opaque, but it doesn't
> > prevent vendor closed-source userspace implementations with additional
> > *camera* features, as long as the *hardware* features are available to
> > everybody.
> 
> How far do you take opaque?
> 
> In mlx5 we pass command buffers from user to kernel to HW and the
> kernel does only a little checking.

I won't comment on the mlx5 case in particular, I don't have enough
knowledge to do so.

When it comes to validation of commands by the kernel, at the very least
the kernel driver needs to be able to guarantee safety. For instance,
that means that any command that can result in DMA operations need to be
validated (e.g. verifying buffer addresses and sizes) and/or executed
partly by the driver (e.g. mapping a buffer through an IOMMU), depending
on hardware constraints.

> There is a 12kloc file describing the layout of alot of commands:
> include/linux/mlx5/mlx5_ifc.h
> 
> There is an open PDF describing in detail some subset of this:
> https://network.nvidia.com/files/doc-2020/ethernet-adapters-programming-manual.pdf
> 
> There are in-kernel implementations driving most of those commands.

For camera ISPs, most of the "commands" wouldn't be driven by the
kernel. I don't have expectations when it comes to what commands the
kernel exercises directly, I think that highly depends on the device
type.

> Other commands are only issued by userspace, and we have open source
> DPDK, rdma-core and UCX implementations driving them.
> 
> ie, this is really quite good as far as a device providing open source
> solutions goes.
> 
> However, no doubt there is more FW capability and commands than even
> this vast amount documents - so lets guess that propritary code is
> using this interface with unknown commands too.
> 
> From a camera perspective would you be OK with that? Let's guess that
> 90% of use cases are covered with fully open code. Do we also need to
> forcefully close the door to an imagined 10% of proprietary cases just
> to be sure open always wins?

For command buffers interpreted by a firmware, it would be extremely
difficult, if not impossible, to ensure that nothing undocumented is
possible to access from userspace. I think we have two issues here, one
of them is to define what we required to be openly accessible, and the
other to avoid vendors cheating by claiming to be more open than they
actually are.

I believe the latter can't be solved technically. At the end of the day
it's a matter of trust, and the only option I can see is to build that
trust with the vendors, and to make it clear that breaches of trust will
have consequences. A vendor that deliberately lies would end up on my
personal backlist for as long as they don't implement structural
solutions to be a better player in the ecosystem. What is acceptable as
consequences is for the communities to decide. We have previously banned
people or organizations from contributing to the kernel for certain
periods of time (the University of Minnesota case comes to my mind for
instance), and other options can be considered too.

As for the first issue, I think it's a difficult one as it is very
difficult to quantify the features covered by open implementations, as
well as their importance. You could have a 99% open command set where
the 1% would impact open implementations extremely negatively, the same
way you could have a 50% open command set where the other 50% isn't of
any use to anyone but the vendor (for instance used to debug the
firmware implementation).

For cameras, the feature set can I believe be expressed in terms of ISP
processing blocks that are usable by open implementations, as well as in
terms of the type of usage of those features. For instance, is it
acceptable that a vendor documents how to use 2D noise reduction but
makes 3D (temporal) noise reduction available only to close-source
userspace ? My personal answer is no. I want to aim for very close to
100% of the features, and certainly 100% of the "large" features. I can
close my eyes on features that are very very niche, but what is niche
today may not be tomorrow. For instance, if a camera ISP implements a
feature used only for very specific camera sensors targetted at
autonomous driving in a new generation of research prototypes that only
one company has access to, I'll be inclined to ignore that. That
technology may however become much more mainstream 5 years later.

The other aspect is the type of usage of the features. For camera ISPs
again, some parameters will be computed through a tuning process, and
will be fixed for the lifetime of the camera. I want those parameters to
be documented, to enable users to tune cameras for their own use cases.
This is less important in some market segments, such as laptops for
instance, but is crucial for embedded devices. This is an area where
I've previously been called unreasonable, and I don't think that's fair.
The tuned-and-immutable parameters are not plentiful, as most of the
tuning results in data that needs to be combined with runtime
information to compute ISP parameters, so the "this is for tuning only"
argument doesn't hold as much as one may think. For real immutable
parameters, a large number of them are related to image processing steps
that are very common and found in most ISPs, such as lens shading
correction or geometric distorsion correction. I don't see why we should
let vendors keep those closed.

I'm sorry that this discussion is turning into something very
camera-centric, but that's the relevant area I know best. I hope that
discussing problems related to device pass-through in different areas in
the open will help build a wider shared understanding of the problems,
and hopefully help designing solutions by better taking into account the
various aspects of the issues.

> Does closing the door have to come at the cost of a technically clean
> solution? Doing validation in the kernel to enforce an ideological
> position would severely degrade mlx5, and would probably never really
> be robust.

-- 
Regards,

Laurent Pinchart

