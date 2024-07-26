Return-Path: <linux-rdma+bounces-4013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6464793D421
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D33286BAE
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C0617C7C7;
	Fri, 26 Jul 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BLJe92O9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6617C227;
	Fri, 26 Jul 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000164; cv=none; b=LBgat7JulFCabCsDGkA9JFiIEE3qVdpweHeiWGQJ38lo+uuWZUszmHJHz3mXKB56HTsv3E4sAmLop7sEjzuXIU0y1Wp5TSSvHQFPG9EJQnDQfTXTalF2udO3CDRldVuZIgv8pvdIsT4mbv+sPWjgiIxsVZd5kLlXmK2d8fcpuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000164; c=relaxed/simple;
	bh=kUSe+c2AZazugy9JtiEaOnVHrrpVwrlwFkF8YSYVgRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9bX1KmWqINgFp/3P6/8ekVpj57UvO+k64W1UgZXfzohbwN6JqfvH3CCOdTloJgr6R9DbOOy+ocHY30qQRIXlBQImiuWw7EbRPdFd2EJkDEdyyPTwxzbLXYVXeYK8ZSKcS+qnDtd0AYBdqBAu9IoFiVG1F1rHOL1RLb7qh0a1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BLJe92O9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1BFF883F;
	Fri, 26 Jul 2024 15:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722000116;
	bh=kUSe+c2AZazugy9JtiEaOnVHrrpVwrlwFkF8YSYVgRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLJe92O9dq1pWCnEDtNkuAiUriGnt591MAli5d16QtchjELf/qlqylOQ1gOizfbo/
	 QmuYpS24/5r1rogqjCAqMO0ub7lPKTIJvTulfzthElYF+UeQ61pW4P480EpBJS+2aA
	 1XakiNNkljjDStby4N+KYfY4lPZ43piBc4zH5iI4=
Date: Fri, 26 Jul 2024 16:22:20 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240726132220.GE28621@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
 <CAPybu_3GkgcORm0Jbp8ze_rjfXDws8xWT_sQcs_39KY54zpnQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_3GkgcORm0Jbp8ze_rjfXDws8xWT_sQcs_39KY54zpnQg@mail.gmail.com>

On Fri, Jul 26, 2024 at 10:03:36AM +0200, Ricardo Ribalda Delgado wrote:
> On Thu, Jul 25, 2024 at 9:32 PM Laurent Pinchart wrote:
> > On Wed, Jul 24, 2024 at 04:37:21PM -0400, James Bottomley wrote:
> > > On Wed, 2024-07-24 at 23:00 +0300, Laurent Pinchart wrote:
> > > [...]
> > > > What I get from the discussions I've followed or partcipated in over
> > > > the years is that the main worry of free software communities is
> > > > being forced to use closed-source userspace components, whether that
> > > > would be to make the device usable at all, or to achieve decent level
> > > > of performance or full feature set. We've been through years of
> > > > mostly closed-source GPU support, of printer "windrivers", and quite
> > > > a few other horrors. The good news is that we've so far overcome lots
> > > > (most) of those challenges. Reverse engineering projects paid off,
> > > > and so did working hand-in-hand with industry actors in multiple ways
> > > > (both openly and behind the scenes). One could then legitimately ask
> > > > why we're still scared.
> > >
> > > I don't think I am.  We're mostly fully capable of expounding at length
> > > on the business rationale for being open if the thing they're hiding
> > > isn't much of a differentiator anyway (or they're simply hiding it to
> > > try to retain some illusion of control), so we shouldn't have any fear
> > > of being able to make our case in language business people understand.
> > >
> > > I also think this fear is partly a mindset problem on our part.  We
> > > came out of the real fight for openness and we do embrace things like a
> > > licence that forces open code (GPL) and symbols that discourage
> > > proprietary drivers (EXPORT_SYMBOL_GPL), so we've somewhat drunk the
> > > FSF coolaid that if we don't stand over manufacturers every second and
> > > force them they'll slide back to their old proprietary ways.  However,
> > > if you look at the entirely permissive ecosystem that grew up after we
> > > did (openstack, docker, kubernetes, etc.) they don't have any such fear
> > > and yet they still have large amounts of uncompelled openness and give
> > > back.
> >
> > I don't think those are necessarily relevant examples, as far as device
> > pass-through goes. Vendors have many times reverted to proprietary ways,
> > and they still do, at least in the areas of the kernel I'm most active
> > in. I've seen first hand a large SoC vendor very close to opening a
> > significant part of their camera stack and changing their mind at the
> > last minute when they heard they could possibly merge their code through
> > a different subsystem with a pass-through blank cheque.
> 
> Without knowing who that large SoC vendor is, and what they will be
> willing to open, it is difficult to know what opportunity has been
> lost.

I would also like to discuss this in more details, but I can't do so
publicly :-( That's why I don't want to focus too much on this argument.

> I would argue that if they have cancelled their open plans based
> on an hypothesis, their willingness to open was not that high.

That's exactly what I previously described in this mail thread as areas
where cooperation with vendors is in its infancy. Convincing large
industry players is long term work, and it's very demotivating when you
think there's finally light at the end of the tunel, and plans gets
cancelled at the last minute. We're not giving up though.

> It would be more healthy for the ecosystem, if those discussions were
> done more openly, at least all the core maintainers should be
> involved.

Can you get all the camera vendors you work with to talk about all this
openly ? :-) We all know it's a difficult and long process.

> > I'm willing to believe it can be different in other areas, which may
> > partly explain why different subsystems and different developers have
> > different biases and have trouble understand each other's point of view.
> 
> It is not different in other areas, it is the same area. At the end of
> the day it is the same chip manufacturers, with the same legal teams.
> It is our attitude that is different.

I don't agree with that. Not only are there different manufacturers,
there are also different teams, with different approaches. The world is
not uniform.

> > > > I can't fully answer that question, but there are two points that I
> > > > think are relevant. Note that due to my background and experience,
> > > > this will be heavily biased towards consumer and embedded hardware,
> > > > not data centre-grade devices. Some technologies from the latter
> > > > however have a tendency to migrate to the former over time, so the
> > > > distinction isn't necessarily as relevant as one may consider.
> > > >
> > > > The first point is that hardware gets more complicated over time, and
> > > > in some markets there's also an increase in the number of vendors and
> > > > devices. There's a perceived (whether true or not) danger that we
> > > > won't be able to keep up with just reverse engineering and a
> > > > development model relying on hobyists. Getting vendors involved is
> > > > important if we want to scale.
> > >
> > > Yes, but there are lots of not very useful complex devices being
> > > produced every day that fail to capture market share.  Not having
> > > reverse engineered drivers for them is no real loss.  If a device does
> > > gain market share, it gains a huge pool of users some of whom become
> > > interested in reverse engineering, so I think market forces actually
> > > work in our favour: we get reverse engineering mostly where the devices
> > > are actually interesting and capture market share.  It's self scaling.
> >
> > I can't agree with that, sorry. Not only is the difficulty to
> > reverse-engineer some classes of devices increasing, but saying that
> > only devices that make it to the top of the market share chart are worth
> > considering will leave many users on the side of the road.
> 
> Today we have left BILLIONS of users at the other side of the road.

Because we're the only ones to be blamed, or more accuretely, the blame
is solely on me. Vendors are all saints who want the best for the world.
This argument doesn't hold. Please stop with this, I don't want to get
to name calling.

> > > > Second, I think there's a fear of regression. For some categories of
> > > > devices, we have made slow but real progress to try and convince the
> > > > industry to be more open. This sometimes took a decade of work,
> > > > patiently building bridges and creating ecosystems brick by brick.
> > > > Some of those ecosystems are sturdy, some not so. Giving pass-through
> > > > a blank check will likely have very different effects in different
> > > > areas. I don't personally believe it will shatter everything, but I'm
> > > > convinced it carries risk in areas where cooperation with vendors is
> > > > in its infancy or is fragile for any other reason.
> > >
> > > I also think we're on the rise in this space.  Since most cloud
> > > workloads are on Linux, there's huge market pressure on most "found in
> > > the cloud" devices (like accelerators and GPUs) to have an easy to
> > > consume Linux story.  Nvidia is a case in point.  When it only cared
> > > about fast games on some other OS, we get shafted with a proprietary
> > > graphics drivers.  Now it's under pressure to be the number one AI
> > > accelerator provider for the cloud it's suddenly wondering about open
> > > source drivers to make adoption easier.
> >
> > I can't comment on Nvidia and their inference engines in particular. The
> > server market may be in a better position that the consumer and embedded
> > market, and if that's the case, I'm happy for the servers. That doesn't
> > solve the issues in other markets though.
> >
> > > > Finally, let's not forget that pass-through APIs are not an all or
> > > > nothing option. To cite that example only, DRM requires GPU drivers
> > > > to have an open-source userspace implementation to merge the kernel
> > > > driver, and the same subsystems strongly pushes for API
> > > > standardization for display controllers. We can set different rules
> > > > for different cases.
> > >
> > > I certainly think we can afford to experiment here, yes.

-- 
Regards,

Laurent Pinchart

