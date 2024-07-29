Return-Path: <linux-rdma+bounces-4065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA37193F2F5
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 12:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825DC281397
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3E14430E;
	Mon, 29 Jul 2024 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gcgCp6ul"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C81428F2;
	Mon, 29 Jul 2024 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249558; cv=none; b=qg2TxEUppS8zm5cfiQHzad4lVc7CTtV9tzuzVwQTVjrHI8mYNpbcLSZwxDqvLl9F2sCYe+VLqS0cXaNvkU/fl0HjwE/OrMiA+jP1aBCnuGoVg6S6DCKQ0EqYbSs4b6RoC0L1ra+Xj8339y7qgrRKif2s9w/wIBxU8e1HRfa59RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249558; c=relaxed/simple;
	bh=BKYm1gVxY2wolZIK3me/oQRBJ4fiaRy6SZ62XyuXAfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjgtpQmddwAHFzJkmEnhh3fWYDdk51KyYegsOGMqibGapbns01oOmpQgs5kV7jKtcUzuQ/bCf5rRCy3PW7o+ijISEbF8t9T6SUanbLedktbgRJJIBmQVKllkYDXimfg35R6K5a9xodcebJHcMUBUQq+HN5W8EnHFurXyP6lE91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gcgCp6ul; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1700545A;
	Mon, 29 Jul 2024 12:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722249508;
	bh=BKYm1gVxY2wolZIK3me/oQRBJ4fiaRy6SZ62XyuXAfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcgCp6ul6rLkyYhgbxyEnQYsr+bftAXR9E1Io4+f51rNlf3O5iKRaZVXnsM+ffI9Z
	 3tyKA5s05n7utzBxOr94yyFzB6O+P3jE10ZOBIIWRHSJRk27M3amKRnjlJEsVY6OoK
	 8490b/esa/Pvy4IEoq6ISvpGYN8XrQF+yXuEEBPs=
Date: Mon, 29 Jul 2024 13:38:54 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729103854.GE2320@pendragon.ideasonboard.com>
References: <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
 <20240725122315.GE7022@unreal>
 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
 <20240725132035.GF7022@unreal>
 <20240725194202.GE14252@pendragon.ideasonboard.com>
 <CAPybu_3T8JNkZxf3pgCo4E4VJ3AZvY7NzeXdd7w9Qqe8=eV=9A@mail.gmail.com>
 <20240726131110.GD28621@pendragon.ideasonboard.com>
 <CAPybu_13+Axb2e_fVYeUv+S3UohbJXBYNF74Qd=pXz8_X3ic9g@mail.gmail.com>
 <20240728112358.GB30973@pendragon.ideasonboard.com>
 <CAPybu_0vNbwO6NkWb_P7F+1TZtddmAAgC69X8c0WtZ5P2JoeBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_0vNbwO6NkWb_P7F+1TZtddmAAgC69X8c0WtZ5P2JoeBg@mail.gmail.com>

On Mon, Jul 29, 2024 at 11:56:45AM +0200, Ricardo Ribalda Delgado wrote:
> On Sun, Jul 28, 2024 at 1:24 PM Laurent Pinchart wrote:
> > On Fri, Jul 26, 2024 at 05:40:50PM +0200, Ricardo Ribalda Delgado wrote:
> > > On Fri, Jul 26, 2024 at 3:11 PM Laurent Pinchart wrote:
> > > > On Fri, Jul 26, 2024 at 10:02:27AM +0200, Ricardo Ribalda Delgado wrote:
> > > > > On Thu, Jul 25, 2024 at 9:44 PM Laurent Pinchart wrote:
> > > > > > On Thu, Jul 25, 2024 at 04:20:35PM +0300, Leon Romanovsky wrote:
> > > > > > > On Thu, Jul 25, 2024 at 03:02:13PM +0200, Ricardo Ribalda Delgado wrote:
> > > > > > > > On Thu, Jul 25, 2024 at 2:23 PM Leon Romanovsky wrote:
> > > > > > > > > On Thu, Jul 25, 2024 at 11:26:38AM +0200, Ricardo Ribalda Delgado wrote:
> > > > > > > > > > On Wed, Jul 24, 2024 at 10:02 PM Laurent Pinchart wrote:
> > > > > > > > >
> > > > > > > > > <...>
> > > > > > > > >
> > > > > > > > > > It would be great to define what are the free software communities
> > > > > > > > > > here. Distros and final users are also "free software communities" and
> > > > > > > > > > they do not care about niche use cases covered by proprietary
> > > > > > > > > > software.
> > > > > > > > >
> > > > > > > > > Are you certain about that?
> > > > > > > >
> > > > > > > > As a user, and as an open source Distro developer I have a small hint.
> > > > > > > > But you could also ask users what they think about not being able to
> > > > > > > > use their notebook's cameras. The last time that I could not use some
> > > > > > > > basic hardware from a notebook with Linux was 20 years ago.
> > > > > > >
> > > > > > > Lucky you, I still have consumer hardware (speaker) that doesn't work
> > > > > > > with Linux, and even now, there is basic hardware in my current
> > > > > > > laptop (HP docking station) that doesn't work reliably in Linux.
> > > > > > >
> > > > > > > > > > They only care (and should care) about normal workflows.
> > > > > > > > >
> > > > > > > > > What is a normal workflow?
> > > > > > > > > Does it mean that if user bought something very expensive he
> > > > > > > > > should not be able to use it with free software, because his
> > > > > > > > > usage is different from yours?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > > It means that we should not block the standard usage for 99% of the
> > > > > > > > population just because 1% of the users cannot do something fancy with
> > > > > > > > their device.
> > > > > > >
> > > > > > > Right, the problem is that in some areas the statistics slightly different.
> > > > > > > 99% population is blocked because 1% of the users don't need it and
> > > > > > > don't think that it is "normal" flow.
> > > > > > >
> > > > > > > > Let me give you an example. When I buy a camera I want to be able to
> > > > > > > > do Video Conferencing and take some static photos of documents. I do
> > > > > > > > not care about: automatic makeup, AI generated background, unicorn
> > > > > > > > filters, eyes recentering... But we need to give a way to vendors to
> > > > > > > > implement those things closely, without the marketing differentiators,
> > > > > > > > vendors have zero incentive to invest in Linux, and that affects all
> > > > > > > > the population.
> > > > > >
> > > > > > I've seen these kind of examples being repeatedly given in discussions
> > > > > > related to camera ISP support in Linux. They are very misleading. These
> > > > > > are not the kind of features that are relevant for the device
> > > > > > pass-through discussion these day. Those are high-level use cases
> > > > > > implemented in userspace, and vendors can ship any closed-source
> > > > > > binaries they want there. What I care about is the features exposed by
> > > > > > the kernel to userspace API.
> > > > >
> > > > > The ISPs are gradually becoming programmable devices and they indeed
> > > > > help during all of those examples.
> > > >
> > > > I'd like to see more technical information to substantiate this claim.
> > > > So far what I've sometimes seen is ISPs that include programmable
> > > > elements, but hiding those behind a firmware that exposes a fixed
> > > > (configurable) pipeline. I've also heard of attempts to expose some of
> > > > that programmability to the operating system, which were abandoned in
> > > > the end due to lack usefulness.
> > > >
> > > > > Userspace needs to send/receive information from the ISP, and that is
> > > > > exactly what vendors want to keep in the close.
> > > >
> > > > But that's exactly what we need to implement an open userspace ecosystem
> > > > :-)
> > > >
> > > > > Describing how they implement those algorithms is a patent minefield
> > > > > and their differentiating factor.
> > > >
> > > > Those are also arguments I've heard many times before. The
> > > > differentiating factor for cameras today is mostly in userspace ISP
> > > > control algorithms, and nobody is telling vendors they need to open all
> > > > that.
> > >
> > > I disagree. The differentiating factor is what the ISP is capable of
> > > doing and how they do it. Otherwise we would not see new ISPs in the
> > > market.
> >
> > Hardware certainly evolves, but it's far from being the main
> > differentiating factor in the markets and use cases you're usually
> > referring to.
> >
> > > If you define the arguments passed to an ISP you are defining the
> > > algorithm, and that is a trade secret and/or a patent violation.
> >
> > Are you confusing ISP processing blocks, sometimes referred to as
> > algorithms, and ISP control algorithms ? There is absolutely no way to
> > do anything with an ISP, not even the bare minimum, if you don't know
> > what parameters to pass to it.
> 
> Any ISP released in the last few years has *hundreds of thousands* of
> parameters.

Could you substantiate that claim ? That doesn't match what I've seen
(unless perhaps you count each entry in LSC tables or large tone mapping
LUTs as separate parameters).

> We only modify hundreds of parameters during runtime. Those are the
> ones we need to be documented.
> 
> If we enforce a "usable open camera stack", we will have the
> documentation and the code needed to use the ISP.
> 
> Asking vendors to document *ALL* the parameters means describing how
> they have implemented the internals of the ISP camera algorithms.
> 
> > > > When it comes to patents, we all know how software patents is a
> > > > minefield, and hardware is also affected. I can't have much sympathy for
> > > > this argument though, those patents mostly benefit the largest players
> > > > in the market, and those are the ones who currently claim they can't
> > > > open anything due to patents.
> > >
> > > Big players do not usually sue each other. The big problem is patent
> > > trolls that "shoot at everything that moves".
> > >
> > > I dislike patents, but it is the world we have to live in. No vendor
> > > is going to take our approach if they risk a multi million dollar
> > > lawsuit.
> >
> > When was the last time anyone heard of big players pushing to reform the
> > patent system ? At best there are initiatives such as OIN, which some
> > large companies have supporting. It's still a workaround though.
> >
> > > > > > > > This challenge seems to be solved for GPUs. I am using my AMD GPU
> > > > > > > > freely and my nephew can install the amdgpu-pro proprietary user space
> > > > > > > > driver to play duke nukem (or whatever kids play now) at 2000 fps.
> > > > > > > >
> > > > > > > > There are other other subsystems that allow vendor passthrough and
> > > > > > > > their ecosystem has not collapsed.
> > > > > > >
> > > > > > > Yes, I completely agree with you on that.
> > > > > > >
> > > > > > > > Can we have some general guidance of what is acceptable? Can we define
> > > > > > > > together the "normal workflow" and focus on a *full* open source
> > > > > > > > implementation of that?
> > > > > > >
> > > > > > > I don't think that is possible to define "normal workflow". Requirement
> > > > > > > to have open-source counterpart to everything exposed through UAPI is a
> > > > > > > valid one. I'm all for that.
> > > > > >
> > > > > > That's my current opinion as well, as least when it comes to the kernel
> > > > > > areas I mostly work with.

-- 
Regards,

Laurent Pinchart

