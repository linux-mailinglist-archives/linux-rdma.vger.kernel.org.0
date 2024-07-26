Return-Path: <linux-rdma+bounces-4029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC293D72D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90705B21689
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A15617C7CC;
	Fri, 26 Jul 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wWaPX4Ph";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wWaPX4Ph"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EB11C83;
	Fri, 26 Jul 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012565; cv=none; b=VNaMu29K52dS7lGosvQPSGo3tqgdnnKJlZY7JdCEtCazX3HxNd74rusDNct2wzBZ3X4zWQk8Bu2SU0RJnVC6pyo7t1x+V4gjLWc4AgMROrisutkTB+EIgkwGzgNP42lp4oRwWE+jL3J44jNpZL9s+ZbBoIH8MSycOG9xE7ck714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012565; c=relaxed/simple;
	bh=9CUA/RHQppq7pAtBlnYBLi9+Q+DOIxlO5I4+RhBfrFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dMQEJZXuq53nPYAlNNl+kCThqDt5BA5K4cA0USIu6fg5XBZy8zk7Ieb4MgtZ9D3uhLHQ3KYyO4uOdXfp8GvtCVGZnpqdnBgXjsErBMG1cyAJnJLXMaPtHU5yQ7QW365Hk95UoNtNuT6ZiBWXjOJQ/RbkZTmKkhLgbHr+Nq5acV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=wWaPX4Ph; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=wWaPX4Ph; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722012562;
	bh=9CUA/RHQppq7pAtBlnYBLi9+Q+DOIxlO5I4+RhBfrFc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=wWaPX4PhwjtGjv0soStizvhp4NuFo+GJJmxK2UiSDnLO992CybmbeexxFZRI7LC0A
	 tOHnvUcnkxEkVbDeEScBQSn92qJz5bHrioVZgtjsiqnGv+9htj+shHAEBLAYJV9v/A
	 tLwoMta4f+TS6x/jt7vig0h3ElKiVgHKft485s5s=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9FFA5128122D;
	Fri, 26 Jul 2024 12:49:22 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id BpIxJsMyLd-n; Fri, 26 Jul 2024 12:49:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722012562;
	bh=9CUA/RHQppq7pAtBlnYBLi9+Q+DOIxlO5I4+RhBfrFc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=wWaPX4PhwjtGjv0soStizvhp4NuFo+GJJmxK2UiSDnLO992CybmbeexxFZRI7LC0A
	 tOHnvUcnkxEkVbDeEScBQSn92qJz5bHrioVZgtjsiqnGv+9htj+shHAEBLAYJV9v/A
	 tLwoMta4f+TS6x/jt7vig0h3ElKiVgHKft485s5s=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B8DA4128100C;
	Fri, 26 Jul 2024 12:49:21 -0400 (EDT)
Message-ID: <89671fdc060bcb845373a4453f5eea8ee32311ba.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
  ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org,  netdev@vger.kernel.org, jgg@nvidia.com
Date: Fri, 26 Jul 2024 12:49:20 -0400
In-Reply-To: <20240725193125.GD14252@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
	 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
	 <20240724200012.GA23293@pendragon.ideasonboard.com>
	 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
	 <20240725193125.GD14252@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-07-25 at 22:31 +0300, Laurent Pinchart wrote:
> On Wed, Jul 24, 2024 at 04:37:21PM -0400, James Bottomley wrote:
> > On Wed, 2024-07-24 at 23:00 +0300, Laurent Pinchart wrote:
> > [...]
> > > What I get from the discussions I've followed or partcipated in
> > > over the years is that the main worry of free software
> > > communities is being forced to use closed-source userspace
> > > components, whether that would be to make the device usable at
> > > all, or to achieve decent level of performance or full feature
> > > set. We've been through years of mostly closed-source GPU
> > > support, of printer "windrivers", and quite a few other horrors.
> > > The good news is that we've so far overcome lots (most) of those
> > > challenges. Reverse engineering projects paid off, and so did
> > > working hand-in-hand with industry actors in multiple ways
> > > (both openly and behind the scenes). One could then legitimately
> > > ask why we're still scared.
> > 
> > I don't think I am.  We're mostly fully capable of expounding at
> > length on the business rationale for being open if the thing
> > they're hiding isn't much of a differentiator anyway (or they're
> > simply hiding it to try to retain some illusion of control), so we
> > shouldn't have any fear of being able to make our case in language
> > business people understand.
> > 
> > I also think this fear is partly a mindset problem on our part.  We
> > came out of the real fight for openness and we do embrace things
> > like a licence that forces open code (GPL) and symbols that
> > discourage proprietary drivers (EXPORT_SYMBOL_GPL), so we've
> > somewhat drunk the FSF coolaid that if we don't stand over
> > manufacturers every second and force them they'll slide back to
> > their old proprietary ways.  However, if you look at the entirely
> > permissive ecosystem that grew up after we did (openstack, docker,
> > kubernetes, etc.) they don't have any such fear and yet they still
> > have large amounts of uncompelled openness and give back.
> 
> I don't think those are necessarily relevant examples,

Well they do show it is possible to get an open ecosystem based on the
pull of business need instead of using a forcing function like the
licence.

>  as far as device pass-through goes. Vendors have many times reverted
> to proprietary ways, and they still do, at least in the areas of the
> kernel I'm most active in.

I'm not going to argue that companies don't make bad business
decisions: they definitely do.  And also there are huge reservoirs of
proprietary mindset or fear of losing control in most of them which
tend to drive these bad decisions.  I'm just saying we don't have to be
all stick and no carrot.  If we can use the carrot to help them make
better business decisions, and overcome the proprietary mindset that
way, so much the better.

There are also valid reasons to do pass-through, like you don't want to
invest in standardising the interface until you see that you have an
actual market, which is how mixed standardised/pass through systems
like DRM work (they allow innovation and experimentation, not all of
which works).

>  I've seen first hand a large SoC vendor very close to opening a
> significant part of their camera stack and changing their mind at the
> last minute when they heard they could possibly merge their code
> through a different subsystem with a pass-through blank cheque.

So is the learning here is that perhaps we should co-ordinate better?

> I'm willing to believe it can be different in other areas, which may
> partly explain why different subsystems and different developers have
> different biases and have trouble understand each other's point of
> view.

I think that's true, due to different companies having different levels
of proprietary mindset and other fears of not controlling their own
destiny.  However, the basic fact remains that it will be in their best
business interests to be more open if we can encourage it.

> > > I can't fully answer that question, but there are two points that
> > > I think are relevant. Note that due to my background and
> > > experience, this will be heavily biased towards consumer and
> > > embedded hardware, not data centre-grade devices. Some
> > > technologies from the latter however have a tendency to migrate
> > > to the former over time, so the distinction isn't necessarily as
> > > relevant as one may consider.
> > > 
> > > The first point is that hardware gets more complicated over time,
> > > and in some markets there's also an increase in the number of
> > > vendors and devices. There's a perceived (whether true or not)
> > > danger that we won't be able to keep up with just reverse
> > > engineering and a development model relying on hobyists. Getting
> > > vendors involved is important if we want to scale.
> > 
> > Yes, but there are lots of not very useful complex devices being
> > produced every day that fail to capture market share.  Not having
> > reverse engineered drivers for them is no real loss.  If a device
> > does gain market share, it gains a huge pool of users some of whom
> > become interested in reverse engineering, so I think market forces
> > actually work in our favour: we get reverse engineering mostly
> > where the devices are actually interesting and capture market
> > share.  It's self scaling.
> 
> I can't agree with that, sorry. Not only is the difficulty to
> reverse-engineer some classes of devices increasing,

So it's a higher hill to climb: I didn't say it wasn't.  However for
hugely popular devices there's still more likelihood of finding someone
willing to climb it.  It's not a guarantee, just a probability, though.

> but saying that only devices that make it to the top of the market
> share chart are worth considering will leave many users on the side
> of the road.

I'm afraid this is simple economics.  Suppose we had the budget to pay
for reverse engineering, it's not going to cover everything, so we'd
have to make choices and that would necessarily mean investing in
devices that have utility to the greatest number of people.  So low
market share devices would still be left out.

James


