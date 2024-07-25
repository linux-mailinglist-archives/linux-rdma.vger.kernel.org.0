Return-Path: <linux-rdma+bounces-3994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CA93C8DF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 21:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0882820A6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581261FC5;
	Thu, 25 Jul 2024 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Xf7pRo3c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A74B5AE;
	Thu, 25 Jul 2024 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936653; cv=none; b=K5WuveX49QiUj0B91Yj2JTln/2miqhbVKzS2j9fLYusg8vGqjR7ET34BEB6zqbarfLOMohwtZQma0YlrY8D7JCuvECVpdtAv13IZ/ni2nWxwnOo6idCk6N8BZdrdEJuDmmsBG1BJKMgFSvLG+S2tH3Pii3KoYWSJTBXJXDdHHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936653; c=relaxed/simple;
	bh=bkmGLx6iVa0Wm4z0/S2ChGjzh2Gh9WCaVaWxRLbpUJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boQdSyi3mvR1z3xeM3qT4B4fR8BjlYhI5TraKDkcYRIMcYc8KNQ3qkhZbSBpW4GY1kKt+h7z99mX4AgpMHUs6KcVXGY3LYGqCeP92xCCQs8Nw0gCDe44krd8K4saDN+PQ1yQndnabbrhVQIGF3HGB9G59UJCdSJMS5JoA3toYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Xf7pRo3c; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-73-91-nat.elisa-mobile.fi [85.76.73.91])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56869471;
	Thu, 25 Jul 2024 21:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721936606;
	bh=bkmGLx6iVa0Wm4z0/S2ChGjzh2Gh9WCaVaWxRLbpUJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xf7pRo3cIuKSNUeik9xHd2hPhgR/3uBsnkuMnrnxwDEkqCkMGDGrE1IUqato6BIvt
	 pgffiD1eoOOh1ZekSuftI6jowRmmPAIdTaiQDi6OA85xeO10o63WM/Q9DXHk8064/j
	 VSlwsKBMXo//tvd2a4RWYJSEpH6b0u0/yrunChDQ=
Date: Thu, 25 Jul 2024 22:42:02 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240725194202.GE14252@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
 <20240725122315.GE7022@unreal>
 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
 <20240725132035.GF7022@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725132035.GF7022@unreal>

On Thu, Jul 25, 2024 at 04:20:35PM +0300, Leon Romanovsky wrote:
> On Thu, Jul 25, 2024 at 03:02:13PM +0200, Ricardo Ribalda Delgado wrote:
> > On Thu, Jul 25, 2024 at 2:23 PM Leon Romanovsky wrote:
> > > On Thu, Jul 25, 2024 at 11:26:38AM +0200, Ricardo Ribalda Delgado wrote:
> > > > On Wed, Jul 24, 2024 at 10:02 PM Laurent Pinchart wrote:
> > >
> > > <...>
> > >
> > > > It would be great to define what are the free software communities
> > > > here. Distros and final users are also "free software communities" and
> > > > they do not care about niche use cases covered by proprietary
> > > > software.
> > >
> > > Are you certain about that?
> > 
> > As a user, and as an open source Distro developer I have a small hint.
> > But you could also ask users what they think about not being able to
> > use their notebook's cameras. The last time that I could not use some
> > basic hardware from a notebook with Linux was 20 years ago.
> 
> Lucky you, I still have consumer hardware (speaker) that doesn't work
> with Linux, and even now, there is basic hardware in my current
> laptop (HP docking station) that doesn't work reliably in Linux.
> 
> > > > They only care (and should care) about normal workflows.
> > >
> > > What is a normal workflow?
> > > Does it mean that if user bought something very expensive he
> > > should not be able to use it with free software, because his
> > > usage is different from yours?
> > >
> > > Thanks
> > 
> > It means that we should not block the standard usage for 99% of the
> > population just because 1% of the users cannot do something fancy with
> > their device.
> 
> Right, the problem is that in some areas the statistics slightly different.
> 99% population is blocked because 1% of the users don't need it and
> don't think that it is "normal" flow.
> 
> > Let me give you an example. When I buy a camera I want to be able to
> > do Video Conferencing and take some static photos of documents. I do
> > not care about: automatic makeup, AI generated background, unicorn
> > filters, eyes recentering... But we need to give a way to vendors to
> > implement those things closely, without the marketing differentiators,
> > vendors have zero incentive to invest in Linux, and that affects all
> > the population.

I've seen these kind of examples being repeatedly given in discussions
related to camera ISP support in Linux. They are very misleading. These
are not the kind of features that are relevant for the device
pass-through discussion these day. Those are high-level use cases
implemented in userspace, and vendors can ship any closed-source
binaries they want there. What I care about is the features exposed by
the kernel to userspace API.

> > This challenge seems to be solved for GPUs. I am using my AMD GPU
> > freely and my nephew can install the amdgpu-pro proprietary user space
> > driver to play duke nukem (or whatever kids play now) at 2000 fps.
> > 
> > There are other other subsystems that allow vendor passthrough and
> > their ecosystem has not collapsed.
> 
> Yes, I completely agree with you on that.
> 
> > Can we have some general guidance of what is acceptable? Can we define
> > together the "normal workflow" and focus on a *full* open source
> > implementation of that?
> 
> I don't think that is possible to define "normal workflow". Requirement
> to have open-source counterpart to everything exposed through UAPI is a
> valid one. I'm all for that.

That's my current opinion as well, as least when it comes to the kernel
areas I mostly work with.

-- 
Regards,

Laurent Pinchart

