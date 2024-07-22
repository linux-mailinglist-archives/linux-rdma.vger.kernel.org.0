Return-Path: <linux-rdma+bounces-3919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BBD938A0B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 09:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3027280F43
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232C1BC3C;
	Mon, 22 Jul 2024 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSeFKj7l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674721B960;
	Mon, 22 Jul 2024 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633484; cv=none; b=KHmX9ItX9/jba1EK6eKBa4jFjjvx9G9w7SW72t5Jg+RnSnCPoPRytJSfEj6iEd6VAR1EOLyRfhRwjxgfJh67T3LUr6GWEQ7mKewnIBO0WsTR1mmZGFqvpEko4RGz2hBdRmejlMKt9nTb08eJ1M1dbkCdEu0Tbgn4nBm/ALhLFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633484; c=relaxed/simple;
	bh=iYIiUKbc+Z2zBm3LGnTzmWg6zFkv8DUVsKnrd4o2QVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3bCdEAuYQSXHJOakCBoGKBVJamexEv7H+eXn/f7OuQdHiun1Pl0xfJuisrDeljTtqikHOlS/OyswRIXSxLFempjrQtddy2Ip+1LCpprGLEhDFJMkz31+L0d0pOmLWzkj2Ok1YShc/DXee5sAiX7tvk7IZWImqDVoYwG0XMlB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSeFKj7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906AAC116B1;
	Mon, 22 Jul 2024 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721633484;
	bh=iYIiUKbc+Z2zBm3LGnTzmWg6zFkv8DUVsKnrd4o2QVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSeFKj7lxvq964npqvOUsM/B3k+zCb0OUgJvjEdyZSII9yhZ0z8Oqk5rmomTXxCdG
	 8xdMxbc668MIhcpe9q5DuhESYlLUl7WtIxOh6+pF2Yophb9b5dJSemHsvjZj22urdi
	 pbUupZSNSHe+joN/p3dRBmDY99LSIT9dD+4sdZZOuqmMMQuCoJmfh/Aqw6XbWD4qBs
	 BteBrZW2lemwCYe2BISpxOtTUODBCgy1cplZceShGQEZS8/EL6REmDUoplisnG1Zw1
	 quv6Z45V8agd6p0+GFDgHxxbYn9XPve8g99EQXzUOka8jdZG+fWcMRXSzqy1/iYR1w
	 4jhvL4/FDlpnw==
Date: Mon, 22 Jul 2024 10:31:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240722073119.GA4252@unreal>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240721192530.GD23783@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240721192530.GD23783@pendragon.ideasonboard.com>

On Sun, Jul 21, 2024 at 10:25:30PM +0300, Laurent Pinchart wrote:
> On Tue, Jul 09, 2024 at 03:15:13PM -0700, Dan Williams wrote:
> > James Bottomley wrote:
> > > > The upstream discussion has yielded the full spectrum of positions on
> > > > device specific functionality, and it is a topic that needs cross-
> > > > kernel consensus as hardware increasingly spans cross-subsystem
> > > > concerns. Please consider it for a Maintainers Summit discussion.
> > > 
> > > I'm with Greg on this ... can you point to some of the contrary
> > > positions?
> > 
> > This thread has that discussion:
> > 
> > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > 
> > I do not want to speak for others on the saliency of their points, all I
> > can say is that the contrary positions have so far not moved me to drop
> > consideration of fwctl for CXL.
> > 
> > Where CXL has a Command Effects Log that is a reasonable protocol for
> > making decisions about opaque command codes, and that CXL already has a
> > few years of experience with the commands that *do* need a Linux-command
> > wrapper.
> > 
> > Some open questions from that thread are: what does it mean for the fate
> > of a proposal if one subsystem Acks the ABI and another Naks it for a
> > device that crosses subsystem functionality? Would a cynical hardware
> > response just lead to plumbing an NVME admin queue, or CXL mailbox to
> > get device-specific commands past another subsystem's objection?
> 
> My default answer would be to trust the maintainers of the relevant
> subsystems (or try to convince them when you disagree :-)).

You know, trust is a two-way street. If you want to trust maintainers,
they need to trust others as well. The situation where one maintainer
says "I don't trust you, so I will not allow you and other X maintainers
to do Y" is not a healthy situation.

> Not only should they know the technical implications best, they should also have
> a good view of the whole vertical stack, and the implications of
> pass-through for their ecosystem. 

It is wishful thinking. It is clearly not true for large subsystems
and/or complex devices.

Thanks

