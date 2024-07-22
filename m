Return-Path: <linux-rdma+bounces-3928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C73938FE5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 15:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE9D1F21A30
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D716D9AD;
	Mon, 22 Jul 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMOMs/J1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103DE2CA9;
	Mon, 22 Jul 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654913; cv=none; b=O1yDPWcF6LBx39jw8EiB8JQEF4Df4m5wEAD5Uh9xTY3DfgvuCUlCBEP4CV44gWyyyXOaLqSRH5z5yzJoBW6bRv+eWjNtempYbXPhuEi2XOMd8TZ4oDdR85BvKAZHpA6kgEv0PNS2FWgYpE+myTVcvaKC6pwkHdOQdqaA5DEIGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654913; c=relaxed/simple;
	bh=UcEsWIhE2uiv/TK5CEJj8fkoG0bdYOhggahUfSTwZR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQBp+NwyMU7i6bx74RNRseO8+LbpXFUPk/TDGy0WC0oO23r17CNpa+h9B29Pv/4YrwnOm2DcDmJxEMaQFxKMNyptv1K5XUj3718i6qBgnbmnz1Lrgzb2I6/4OKky1yZ3DgiJQSuqs+CBop+G5GPUEHT4Q0Lwd67MsTC0iqc/fso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMOMs/J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360A3C116B1;
	Mon, 22 Jul 2024 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721654912;
	bh=UcEsWIhE2uiv/TK5CEJj8fkoG0bdYOhggahUfSTwZR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMOMs/J1jxVcwGQ93xMu9ZFHxgRESqCCKUPR2JBlMAVkwIlUMZUM50DqUPhe3cLLM
	 TjdNEObAHw2ly65MH886awgzxnS+M4dSJngP4Rz48dCU1pOz815sGWcDtMi6NldLTW
	 RtQtLJJ9NObxQZW2K04YcW96k6YGpLFMZ9kGSQfsn47eNy9JC8VQI/y2ubO0PnvNcQ
	 cCx1k8/M7si/Ymxd29SVy+gtP7X/MduGkO46W7w4bHpsfalmfEKYwMEO7lt9+iTGqD
	 9sJIf1Y5u1jrw9yubZwZEvtbUkMDnq+tbByzuZreMBbujVxH3FmvuNmAOOJCYVwVRw
	 NJ+EzCI+xk7oQ==
Date: Mon, 22 Jul 2024 16:28:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240722132828.GC4252@unreal>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240721192530.GD23783@pendragon.ideasonboard.com>
 <20240722073119.GA4252@unreal>
 <20240722085317.GA31279@pendragon.ideasonboard.com>
 <20240722104407.GB4252@unreal>
 <20240722111004.GB13497@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722111004.GB13497@pendragon.ideasonboard.com>

On Mon, Jul 22, 2024 at 02:10:04PM +0300, Laurent Pinchart wrote:
> Hi Leon,
> 
> On Mon, Jul 22, 2024 at 01:44:07PM +0300, Leon Romanovsky wrote:
> > On Mon, Jul 22, 2024 at 11:53:17AM +0300, Laurent Pinchart wrote:
> > > On Mon, Jul 22, 2024 at 10:31:19AM +0300, Leon Romanovsky wrote:
> > > > On Sun, Jul 21, 2024 at 10:25:30PM +0300, Laurent Pinchart wrote:
> > > > > On Tue, Jul 09, 2024 at 03:15:13PM -0700, Dan Williams wrote:
> > > > > > James Bottomley wrote:
> > > > > > > > The upstream discussion has yielded the full spectrum of positions on
> > > > > > > > device specific functionality, and it is a topic that needs cross-
> > > > > > > > kernel consensus as hardware increasingly spans cross-subsystem
> > > > > > > > concerns. Please consider it for a Maintainers Summit discussion.
> > > > > > > 
> > > > > > > I'm with Greg on this ... can you point to some of the contrary
> > > > > > > positions?
> > > > > > 
> > > > > > This thread has that discussion:
> > > > > > 
> > > > > > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > > > > > 
> > > > > > I do not want to speak for others on the saliency of their points, all I
> > > > > > can say is that the contrary positions have so far not moved me to drop
> > > > > > consideration of fwctl for CXL.
> > > > > > 
> > > > > > Where CXL has a Command Effects Log that is a reasonable protocol for
> > > > > > making decisions about opaque command codes, and that CXL already has a
> > > > > > few years of experience with the commands that *do* need a Linux-command
> > > > > > wrapper.
> > > > > > 
> > > > > > Some open questions from that thread are: what does it mean for the fate
> > > > > > of a proposal if one subsystem Acks the ABI and another Naks it for a
> > > > > > device that crosses subsystem functionality? Would a cynical hardware
> > > > > > response just lead to plumbing an NVME admin queue, or CXL mailbox to
> > > > > > get device-specific commands past another subsystem's objection?
> > > > > 
> > > > > My default answer would be to trust the maintainers of the relevant
> > > > > subsystems (or try to convince them when you disagree :-)).
> > > > 
> > > > You know, trust is a two-way street. If you want to trust maintainers,
> > > > they need to trust others as well. The situation where one maintainer
> > > > says "I don't trust you, so I will not allow you and other X maintainers
> > > > to do Y" is not a healthy situation.
> > > > 
> > > > > Not only should they know the technical implications best, they should also have
> > > > > a good view of the whole vertical stack, and the implications of
> > > > > pass-through for their ecosystem. 
> > > > 
> > > > It is wishful thinking. It is clearly not true for large subsystems
> > > > and/or complex devices.
> > > 
> > > Are you saying that kernel communities behind large subsystems for
> > > complex devices generally have no idea about what they're doing ? Or
> > > that in a small number of particular cases those communities are
> > > clueless ? Or does that apply to just the maintainer, not the whole
> > > subsystem core developers ? I'd like to better understand the scale of
> > > your claim here.
> > 
> > I don't know how you jumped from saying "the maintainers of the relevant
> > subsystems" to "kernel communities". I'm talking about maintainers, not
> > communities.
> 
> I wasn't too sure, so that's why I asked. I have also not been very
> precise in my previous e-mails. When I mentioned trusting maintainers, I
> meant trusting the combined knowledge of the relevant maintainer(s) and
> core developer(s) for a subsystema

Unfortunately, the reason for this topic proposed for Maintainer's summit
is that the maintainer and core developers are disagree and there is no way
to resolve it, because it is not technical difference, but a philosophical one.


> The number of people that this covers, and how they collectively reach
> agreements, very much depends on subsystems.
> 
> > There is no way to know everything about everything. In large subsystems,
> > the stack above kernel is so vast, which makes it impossible to know all
> > use cases. This is why some words (... good ... whole ...) in your sentence
> > are not accurate.
> > 
> > So the idea that one maintainer somehow equal to the whole community and
> > this person can block something for other members of the larger community
> > is overreaching.
> 
> -- 
> Regards,
> 
> Laurent Pinchart

