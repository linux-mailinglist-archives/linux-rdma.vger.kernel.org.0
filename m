Return-Path: <linux-rdma+bounces-3924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC83938DF1
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 13:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD931F21B48
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9383E16CD11;
	Mon, 22 Jul 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CbZzMVLW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB9316C87D;
	Mon, 22 Jul 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646632; cv=none; b=kkSep1FfX/tK+CFpTKt6x0DGYd6qbNI0DbeHK1+aNJaq2g9aUxfW23n3Y6ocMMoLyl3c34ROarwA0XLOHBt0cOi4bZu4mTsIeQgLijawk/XxGqqwobMqQMD9YszTmpW1dPFw47a1bmlbby8la1CNYVasX4bBCWHodE04DDpy6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646632; c=relaxed/simple;
	bh=oMAMO7sUOdgfshyC1TIa2Qwn/3USkETxBIrUqUtpAYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5KQXzvfXuOyY2NNWIEdeVEVDGc5+xWK3f4MskTvPV+rsiRhAEtoUkbxkEAmDRjP8wrvkP/PdifucO7wo9i811iWdl4eKlkKNHTJo+v1HX7U4ic7pJGpiuJhwZebIJGmkiFvIyZx7aFaC4ONkaft4XEvPAO5njqlzqWgZpsgBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CbZzMVLW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 606E52B3;
	Mon, 22 Jul 2024 13:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721646581;
	bh=oMAMO7sUOdgfshyC1TIa2Qwn/3USkETxBIrUqUtpAYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbZzMVLWkHzFV74YUZ4oHY+TeGQPt3u4JS2mp5UT/5pj5ppEZEyWik6S6YFlkZTQU
	 nAldbNDVyDPGpyirdejQG9HuSW+EzcUCWzvYhQPnpGX4kRecUWKQ7XqVqv64J1dPdW
	 /hZH+5Z9Pb+tFZ+i3oqV6Vg1VO+6ut24rRF98Wxw=
Date: Mon, 22 Jul 2024 14:10:04 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240722111004.GB13497@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240721192530.GD23783@pendragon.ideasonboard.com>
 <20240722073119.GA4252@unreal>
 <20240722085317.GA31279@pendragon.ideasonboard.com>
 <20240722104407.GB4252@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722104407.GB4252@unreal>

Hi Leon,

On Mon, Jul 22, 2024 at 01:44:07PM +0300, Leon Romanovsky wrote:
> On Mon, Jul 22, 2024 at 11:53:17AM +0300, Laurent Pinchart wrote:
> > On Mon, Jul 22, 2024 at 10:31:19AM +0300, Leon Romanovsky wrote:
> > > On Sun, Jul 21, 2024 at 10:25:30PM +0300, Laurent Pinchart wrote:
> > > > On Tue, Jul 09, 2024 at 03:15:13PM -0700, Dan Williams wrote:
> > > > > James Bottomley wrote:
> > > > > > > The upstream discussion has yielded the full spectrum of positions on
> > > > > > > device specific functionality, and it is a topic that needs cross-
> > > > > > > kernel consensus as hardware increasingly spans cross-subsystem
> > > > > > > concerns. Please consider it for a Maintainers Summit discussion.
> > > > > > 
> > > > > > I'm with Greg on this ... can you point to some of the contrary
> > > > > > positions?
> > > > > 
> > > > > This thread has that discussion:
> > > > > 
> > > > > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > > > > 
> > > > > I do not want to speak for others on the saliency of their points, all I
> > > > > can say is that the contrary positions have so far not moved me to drop
> > > > > consideration of fwctl for CXL.
> > > > > 
> > > > > Where CXL has a Command Effects Log that is a reasonable protocol for
> > > > > making decisions about opaque command codes, and that CXL already has a
> > > > > few years of experience with the commands that *do* need a Linux-command
> > > > > wrapper.
> > > > > 
> > > > > Some open questions from that thread are: what does it mean for the fate
> > > > > of a proposal if one subsystem Acks the ABI and another Naks it for a
> > > > > device that crosses subsystem functionality? Would a cynical hardware
> > > > > response just lead to plumbing an NVME admin queue, or CXL mailbox to
> > > > > get device-specific commands past another subsystem's objection?
> > > > 
> > > > My default answer would be to trust the maintainers of the relevant
> > > > subsystems (or try to convince them when you disagree :-)).
> > > 
> > > You know, trust is a two-way street. If you want to trust maintainers,
> > > they need to trust others as well. The situation where one maintainer
> > > says "I don't trust you, so I will not allow you and other X maintainers
> > > to do Y" is not a healthy situation.
> > > 
> > > > Not only should they know the technical implications best, they should also have
> > > > a good view of the whole vertical stack, and the implications of
> > > > pass-through for their ecosystem. 
> > > 
> > > It is wishful thinking. It is clearly not true for large subsystems
> > > and/or complex devices.
> > 
> > Are you saying that kernel communities behind large subsystems for
> > complex devices generally have no idea about what they're doing ? Or
> > that in a small number of particular cases those communities are
> > clueless ? Or does that apply to just the maintainer, not the whole
> > subsystem core developers ? I'd like to better understand the scale of
> > your claim here.
> 
> I don't know how you jumped from saying "the maintainers of the relevant
> subsystems" to "kernel communities". I'm talking about maintainers, not
> communities.

I wasn't too sure, so that's why I asked. I have also not been very
precise in my previous e-mails. When I mentioned trusting maintainers, I
meant trusting the combined knowledge of the relevant maintainer(s) and
core developer(s) for a subsystem. The number of people that this
covers, and how they collectively reach agreements, very much depends on
subsystems.

> There is no way to know everything about everything. In large subsystems,
> the stack above kernel is so vast, which makes it impossible to know all
> use cases. This is why some words (... good ... whole ...) in your sentence
> are not accurate.
> 
> So the idea that one maintainer somehow equal to the whole community and
> this person can block something for other members of the larger community
> is overreaching.

-- 
Regards,

Laurent Pinchart

