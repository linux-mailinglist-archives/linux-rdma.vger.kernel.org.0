Return-Path: <linux-rdma+bounces-4046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B493E8A6
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 18:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC3D1C2166D
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A05914C;
	Sun, 28 Jul 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BpnJniZT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0157333;
	Sun, 28 Jul 2024 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722185110; cv=none; b=rsmQhQAH5sSQ6DsOFjXodil7K1UxSlQIBTJdZwZgxQSJZ3vhvtCN8f0XM8z4XIFtd1c9+g/pfvSDGwuJNPcwQ2C5XaU/uYAG96rHWcXVVI5BPe8+sgMPKkiW0Qt/A1Kea/Pr03F//cW/TekD0gmzfPVoqptHHOA9b7prVBJenYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722185110; c=relaxed/simple;
	bh=Fj3/aV4POtO2MR7i2cNvXBBu8JJJZlkkeQWqYVEjicI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2CwbHfoKqrR3FaM61vT1VlKriV3MqJkcxlxNQwoXwjc16nm6l4G6QsG5Lo8UfUiiw5GPmMxUnPBs6yoWpeOzVolDvSshcEbTXqifdQaWCwt8dwehIBXNdhYW2NmiZGEjOoyFmP0j1IPfVtRBXjR55fMcDaVdbjoLOLpMPFy+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BpnJniZT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D63846BE;
	Sun, 28 Jul 2024 18:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722185061;
	bh=Fj3/aV4POtO2MR7i2cNvXBBu8JJJZlkkeQWqYVEjicI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpnJniZTUKn67cuiicfi+mUP98LsShEy6YhOiw5LW0JJqnp6Qd/cjTHb+mzbRSnvd
	 3YK1zsaek301YTx2Xt51SHpzsUyGQWw1vbhvDHGpw877w8qc4CC1y0KkyQefaaJZD/
	 ZbVaqIapLL5jO8ukhhvP8F0dacOkzvRka7XlUSBM=
Date: Sun, 28 Jul 2024 19:44:47 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240728164447.GH30973@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
 <89671fdc060bcb845373a4453f5eea8ee32311ba.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89671fdc060bcb845373a4453f5eea8ee32311ba.camel@HansenPartnership.com>

On Fri, Jul 26, 2024 at 12:49:20PM -0400, James Bottomley wrote:
> On Thu, 2024-07-25 at 22:31 +0300, Laurent Pinchart wrote:
> > On Wed, Jul 24, 2024 at 04:37:21PM -0400, James Bottomley wrote:
> > > On Wed, 2024-07-24 at 23:00 +0300, Laurent Pinchart wrote:
> > > [...]
> > > > What I get from the discussions I've followed or partcipated in
> > > > over the years is that the main worry of free software
> > > > communities is being forced to use closed-source userspace
> > > > components, whether that would be to make the device usable at
> > > > all, or to achieve decent level of performance or full feature
> > > > set. We've been through years of mostly closed-source GPU
> > > > support, of printer "windrivers", and quite a few other horrors.
> > > > The good news is that we've so far overcome lots (most) of those
> > > > challenges. Reverse engineering projects paid off, and so did
> > > > working hand-in-hand with industry actors in multiple ways
> > > > (both openly and behind the scenes). One could then legitimately
> > > > ask why we're still scared.
> > > 
> > > I don't think I am.  We're mostly fully capable of expounding at
> > > length on the business rationale for being open if the thing
> > > they're hiding isn't much of a differentiator anyway (or they're
> > > simply hiding it to try to retain some illusion of control), so we
> > > shouldn't have any fear of being able to make our case in language
> > > business people understand.
> > > 
> > > I also think this fear is partly a mindset problem on our part.  We
> > > came out of the real fight for openness and we do embrace things
> > > like a licence that forces open code (GPL) and symbols that
> > > discourage proprietary drivers (EXPORT_SYMBOL_GPL), so we've
> > > somewhat drunk the FSF coolaid that if we don't stand over
> > > manufacturers every second and force them they'll slide back to
> > > their old proprietary ways.  However, if you look at the entirely
> > > permissive ecosystem that grew up after we did (openstack, docker,
> > > kubernetes, etc.) they don't have any such fear and yet they still
> > > have large amounts of uncompelled openness and give back.
> > 
> > I don't think those are necessarily relevant examples,
> 
> Well they do show it is possible to get an open ecosystem based on the
> pull of business need instead of using a forcing function like the
> licence.

Yes, that's true. I still think it depends on the area, the market
players and the maturity of the technology, but licenses should
certainly not be regarded as being the only tool we can use.

> >  as far as device pass-through goes. Vendors have many times reverted
> > to proprietary ways, and they still do, at least in the areas of the
> > kernel I'm most active in.
> 
> I'm not going to argue that companies don't make bad business
> decisions: they definitely do.  And also there are huge reservoirs of
> proprietary mindset or fear of losing control in most of them which
> tend to drive these bad decisions.  I'm just saying we don't have to be
> all stick and no carrot.  If we can use the carrot to help them make
> better business decisions, and overcome the proprietary mindset that
> way, so much the better.
> 
> There are also valid reasons to do pass-through, like you don't want to
> invest in standardising the interface until you see that you have an
> actual market, which is how mixed standardised/pass through systems
> like DRM work (they allow innovation and experimentation, not all of
> which works).

This also matches what we routinely do in the kernel, where in-kernel
abstractions are usually developed when we have a handful of drivers
that need them. Standardizing interfaces with a single user is more
often than not a recipe for failure, not even mentioning the incurred
cost.

If the main motivation for pass-through is avoidance of the large costs
related to standardization when the market is in its infancy, I have no
big objection in principle. There could be other issues to take into
account though, that would make pass-through problematic for particular
cases. In any case, this wouldn't preclude documenting the whole device
API. When vendors want to keep part of the API secret and usable by
closed-source userspace, the discussion becomes quite different.

> >  I've seen first hand a large SoC vendor very close to opening a
> > significant part of their camera stack and changing their mind at the
> > last minute when they heard they could possibly merge their code
> > through a different subsystem with a pass-through blank cheque.
> 
> So is the learning here is that perhaps we should co-ordinate better?

I don't see how that could hurt :-) My experience with the pass-through
discussions so far is that many people in the kernel community are aware
of the overall issue, but most lack deep understanding of the
case-specific constraints. That's not really surprising as we can't be
expert in everything, but it easily leads to the wrong decisions being
made.

> > I'm willing to believe it can be different in other areas, which may
> > partly explain why different subsystems and different developers have
> > different biases and have trouble understand each other's point of
> > view.
> 
> I think that's true, due to different companies having different levels
> of proprietary mindset and other fears of not controlling their own
> destiny.  However, the basic fact remains that it will be in their best
> business interests to be more open if we can encourage it.

That's what we've been telling ISP vendors for 5 years, and it's
starting to show results. It's a long walk, but I agree it's the best
long term strategy. We however sometimes need to combine it with other
carrots or sticks along the way, in the shorter term.

> > > > I can't fully answer that question, but there are two points that
> > > > I think are relevant. Note that due to my background and
> > > > experience, this will be heavily biased towards consumer and
> > > > embedded hardware, not data centre-grade devices. Some
> > > > technologies from the latter however have a tendency to migrate
> > > > to the former over time, so the distinction isn't necessarily as
> > > > relevant as one may consider.
> > > > 
> > > > The first point is that hardware gets more complicated over time,
> > > > and in some markets there's also an increase in the number of
> > > > vendors and devices. There's a perceived (whether true or not)
> > > > danger that we won't be able to keep up with just reverse
> > > > engineering and a development model relying on hobyists. Getting
> > > > vendors involved is important if we want to scale.
> > > 
> > > Yes, but there are lots of not very useful complex devices being
> > > produced every day that fail to capture market share.  Not having
> > > reverse engineered drivers for them is no real loss.  If a device
> > > does gain market share, it gains a huge pool of users some of whom
> > > become interested in reverse engineering, so I think market forces
> > > actually work in our favour: we get reverse engineering mostly
> > > where the devices are actually interesting and capture market
> > > share.  It's self scaling.
> > 
> > I can't agree with that, sorry. Not only is the difficulty to
> > reverse-engineer some classes of devices increasing,
> 
> So it's a higher hill to climb: I didn't say it wasn't.  However for
> hugely popular devices there's still more likelihood of finding someone
> willing to climb it.  It's not a guarantee, just a probability, though.

Agreed.

> > but saying that only devices that make it to the top of the market
> > share chart are worth considering will leave many users on the side
> > of the road.
> 
> I'm afraid this is simple economics.  Suppose we had the budget to pay
> for reverse engineering, it's not going to cover everything, so we'd
> have to make choices and that would necessarily mean investing in
> devices that have utility to the greatest number of people.  So low
> market share devices would still be left out.

Sure, but my point was that we need to get vendors on board and not just
rely on reverse engineering if we want to scale.

-- 
Regards,

Laurent Pinchart

