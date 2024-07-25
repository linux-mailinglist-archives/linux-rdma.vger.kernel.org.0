Return-Path: <linux-rdma+bounces-3984-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1592193C2D9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 15:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE88D1F217B9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317BA19CD15;
	Thu, 25 Jul 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQATLw6H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2D19CCFC;
	Thu, 25 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913641; cv=none; b=d3WtUR+lBiPFOAsaqnYbi/DjCS0CKpXI3r0eAFdUBTRtVEzGOBY/iUj/JBkhCm/zNPK2J4InCiuWL6kdVXxBPLP0WiVOzFNVAhwpKJi61+A6bg2F3e/hSZdj1urWr40Dm9jj/Apu2oxju21wKdGR6D/filFYwAfIbofyuVf8Wso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913641; c=relaxed/simple;
	bh=BmN7iV9wcpqqgQhGKBwK/OUJL+8kNs8M4kyoFh/EA5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFO2Hvtd/1j1t7KrcvG82EbuCHvR+27Sl2pcdcpS3THXh/YWlfzqzmRwCrBbrneOQuuRxXs8lnqt2pnLHmcsoxEc4nI8tl7Gz2vZLRui0Jpd/+2LaZII0S/XWsYnordub8C9Ks1VB9HzGi/iROB0i40RRIpDpahCHlbM62mn2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQATLw6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3A5C116B1;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913640;
	bh=BmN7iV9wcpqqgQhGKBwK/OUJL+8kNs8M4kyoFh/EA5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQATLw6HWeqgFz9KizJ2ajfn87+VrCK09Eirr/Pz15fWJ9VV4aV+poDrKBrWY0SYl
	 c1/UbHfxG+5jraTqOBv27qpfbzfEUariScd5geaihQ1+6LrUq54CxMuYpwFnB302HL
	 XQfkoakUP56rA3Ei3jnBb46V7phCRB4EXspQR2cKEqHFvu7RzYLVRNZfHDBZrubPl5
	 gEvOojZXqbVtiif2y1XdYpHhPUSkKPbq6wyRE8a5gBS7Ggz4TSBaIq1XyljBjXyhsj
	 CHy+y87owApN4Q3NJs8vt8om/S/a1zyHiKjAxBBDRXb8W9nQ33P2We64mt5/l/RKE0
	 g39OA3pfY7Mhg==
Date: Thu, 25 Jul 2024 16:20:35 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240725132035.GF7022@unreal>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
 <20240725122315.GE7022@unreal>
 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>

On Thu, Jul 25, 2024 at 03:02:13PM +0200, Ricardo Ribalda Delgado wrote:
> On Thu, Jul 25, 2024 at 2:23 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Jul 25, 2024 at 11:26:38AM +0200, Ricardo Ribalda Delgado wrote:
> > > On Wed, Jul 24, 2024 at 10:02 PM Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com> wrote:
> >
> > <...>
> >
> > >
> > > It would be great to define what are the free software communities
> > > here. Distros and final users are also "free software communities" and
> > > they do not care about niche use cases covered by proprietary
> > > software.
> >
> > Are you certain about that?
> 
> As a user, and as an open source Distro developer I have a small hint.
> But you could also ask users what they think about not being able to
> use their notebook's cameras. The last time that I could not use some
> basic hardware from a notebook with Linux was 20 years ago.

Lucky you, I still have consumer hardware (speaker) that doesn't work
with Linux, and even now, there is basic hardware in my current
laptop (HP docking station) that doesn't work reliably in Linux.

> 
> >
> > > They only care (and should care) about normal workflows.
> >
> > What is a normal workflow?
> > Does it mean that if user bought something very expensive he
> > should not be able to use it with free software, because his
> > usage is different from yours?
> >
> > Thanks
> 
> It means that we should not block the standard usage for 99% of the
> population just because 1% of the users cannot do something fancy with
> their device.

Right, the problem is that in some areas the statistics slightly different.
99% population is blocked because 1% of the users don't need it and
don't think that it is "normal" flow.

> 
> Let me give you an example. When I buy a camera I want to be able to
> do Video Conferencing and take some static photos of documents. I do
> not care about: automatic makeup, AI generated background, unicorn
> filters, eyes recentering... But we need to give a way to vendors to
> implement those things closely, without the marketing differentiators,
> vendors have zero incentive to invest in Linux, and that affects all
> the population.
> 
> This challenge seems to be solved for GPUs. I am using my AMD GPU
> freely and my nephew can install the amdgpu-pro proprietary user space
> driver to play duke nukem (or whatever kids play now) at 2000 fps.
> 
> There are other other subsystems that allow vendor passthrough and
> their ecosystem has not collapsed.

Yes, I completely agree with you on that.

> 
> Can we have some general guidance of what is acceptable? Can we define
> together the "normal workflow" and focus on a *full* open source
> implementation of that?

I don't think that is possible to define "normal workflow". Requirement
to have open-source counterpart to everything exposed through UAPI is a
valid one. I'm all for that.

Thanks

> 
> -- 
> Ricardo Ribalda

