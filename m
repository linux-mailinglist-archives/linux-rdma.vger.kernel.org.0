Return-Path: <linux-rdma+bounces-3920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A7E938B8D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BDA1F20F77
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6416A37C;
	Mon, 22 Jul 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rCbLLRpF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452535280;
	Mon, 22 Jul 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638418; cv=none; b=n2/fXvNm0knur+c5eJRoL8keY4E9Ryumfx+dGBUk9cN3F7yInHdMHYqMhMXpaQa8hTh90YmYcueqj9g+nOAvY+Mb1G8b2IJ/QVf323NS2VKFYnATZqcSYKRVBjWp/wHnHMc6qkBxGCjZAzB2BABAid41C1i0wdnylN97G0gLDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638418; c=relaxed/simple;
	bh=2M6txpJs4OiG3fc/4Kurm55TcQChxwioxX65X5P68/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMjJ92uyMTs4Q8UM9bgiiJWZVMV2o0+sfY190cGDocjlrfJlyz2TWieT9FP3fE4hFbLSsqjkAh4Iqoh1VsWPuEAYU4KGKlfGnDPoyi4VGGTf6DqrNHdlyuI8txLAMqpv5zeyuYABnoecJjeu0WNtzCVqvZozxhY1Lf+1aVeAl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rCbLLRpF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 368CE2B3;
	Mon, 22 Jul 2024 10:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721638374;
	bh=2M6txpJs4OiG3fc/4Kurm55TcQChxwioxX65X5P68/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCbLLRpF54/qNxWj+Gvtt3g7rLu6Gz7kwmJwWO6XuJK3zOGyweKtkt2y1M+8whdOn
	 ozcpPUVFR7Prs+0pTo/RnGqJCCQw2Ktsk4YU3AhtjKBnmCdZMwsnu1KqC3/kymFEht
	 odC2TqwIv1wdEfVVSuSLH5ZCxD5AUOElM12TrOSU=
Date: Mon, 22 Jul 2024 11:53:17 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240722085317.GA31279@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240721192530.GD23783@pendragon.ideasonboard.com>
 <20240722073119.GA4252@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722073119.GA4252@unreal>

On Mon, Jul 22, 2024 at 10:31:19AM +0300, Leon Romanovsky wrote:
> On Sun, Jul 21, 2024 at 10:25:30PM +0300, Laurent Pinchart wrote:
> > On Tue, Jul 09, 2024 at 03:15:13PM -0700, Dan Williams wrote:
> > > James Bottomley wrote:
> > > > > The upstream discussion has yielded the full spectrum of positions on
> > > > > device specific functionality, and it is a topic that needs cross-
> > > > > kernel consensus as hardware increasingly spans cross-subsystem
> > > > > concerns. Please consider it for a Maintainers Summit discussion.
> > > > 
> > > > I'm with Greg on this ... can you point to some of the contrary
> > > > positions?
> > > 
> > > This thread has that discussion:
> > > 
> > > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > > 
> > > I do not want to speak for others on the saliency of their points, all I
> > > can say is that the contrary positions have so far not moved me to drop
> > > consideration of fwctl for CXL.
> > > 
> > > Where CXL has a Command Effects Log that is a reasonable protocol for
> > > making decisions about opaque command codes, and that CXL already has a
> > > few years of experience with the commands that *do* need a Linux-command
> > > wrapper.
> > > 
> > > Some open questions from that thread are: what does it mean for the fate
> > > of a proposal if one subsystem Acks the ABI and another Naks it for a
> > > device that crosses subsystem functionality? Would a cynical hardware
> > > response just lead to plumbing an NVME admin queue, or CXL mailbox to
> > > get device-specific commands past another subsystem's objection?
> > 
> > My default answer would be to trust the maintainers of the relevant
> > subsystems (or try to convince them when you disagree :-)).
> 
> You know, trust is a two-way street. If you want to trust maintainers,
> they need to trust others as well. The situation where one maintainer
> says "I don't trust you, so I will not allow you and other X maintainers
> to do Y" is not a healthy situation.
> 
> > Not only should they know the technical implications best, they should also have
> > a good view of the whole vertical stack, and the implications of
> > pass-through for their ecosystem. 
> 
> It is wishful thinking. It is clearly not true for large subsystems
> and/or complex devices.

Are you saying that kernel communities behind large subsystems for
complex devices generally have no idea about what they're doing ? Or
that in a small number of particular cases those communities are
clueless ? Or does that apply to just the maintainer, not the whole
subsystem core developers ? I'd like to better understand the scale of
your claim here.

-- 
Regards,

Laurent Pinchart

