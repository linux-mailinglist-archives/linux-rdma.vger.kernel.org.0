Return-Path: <linux-rdma+bounces-3925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DED938DFF
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 13:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711D8281C8A
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3716CD11;
	Mon, 22 Jul 2024 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mtIRlKok"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE91C2E;
	Mon, 22 Jul 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721647135; cv=none; b=WEowB04eq0nipabSf2BRBhAHfYc+acI5pjaCSGmZxf45tGNJgy+GfF4sTKAx7Drq+AV5E4Fpe5fh3lR/zhlQQM5Ea7OVR0e2d8nlLIDU/k5QqGTtYNa54vTZAGasZX2aXlvzN1DIqYha/4GEuL7m0N6ZYr3mvBEvHBkikxhbEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721647135; c=relaxed/simple;
	bh=swgTGV0XRNkTA3W9jRX2LqDzlHWaqrN2dct1jvT11Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnOahG3X1HHPpbpARsO57QZ9RZfhz2//bAQpACRd6djUj2duoWe+I8KEnCyzVmB3X5y1L+FbMSMPKwurUHWhAk3g4/flQhB3jk6v64NiZ8wjTNOUjht2dpf9LDGab9aSIXDVuJII7DxT1Qo9A7YA+0LXcAWdjWj2FacPKp0yeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mtIRlKok; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC6782B3;
	Mon, 22 Jul 2024 13:18:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721647091;
	bh=swgTGV0XRNkTA3W9jRX2LqDzlHWaqrN2dct1jvT11Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtIRlKokMuprxMHcz59xVdqrbG+I7HUu8q/3njc6TJFQZi627dxyWAM8urCmL5TVr
	 Hc69BQ8rOrAKsou05kSSKIusd5uBj49yC4dYNA7mhGZomIHYBqwFx5b019Nlahth1C
	 8hwSl4vxASAfQAThAytEq9E2JhEI0uRkDYNaUj4k=
Date: Mon, 22 Jul 2024 14:18:34 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240722111834.GC13497@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240721192530.GD23783@pendragon.ideasonboard.com>
 <CAPybu_2tUmYtNiSExNGpsxcF=7EO+ZHR8eGammBsg8iFh3B3wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_2tUmYtNiSExNGpsxcF=7EO+ZHR8eGammBsg8iFh3B3wg@mail.gmail.com>

Hi Ricardo,

On Mon, Jul 22, 2024 at 12:42:52PM +0200, Ricardo Ribalda Delgado wrote:
> On Sun, Jul 21, 2024 at 9:25 PM Laurent Pinchart wrote:
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
> > subsystems (or try to convince them when you disagree :-)). Not only
> > should they know the technical implications best, they should also have
> > a good view of the whole vertical stack, and the implications of
> > pass-through for their ecosystem. This may result in a single NAK
> > overriding ACKs, but we could also try to find technical solutions when
> > we'll face such issues, to enforce different sets of rules for the
> > different functions of a device.
> >
> > Subsystem hopping is something we're recently noticed for camera ISPs,
> > where a vendor wanted to move from V4L2 to DRM. Technical reasons for
> > doing so were given, and they were (in my opinion) rather excuses. The
> > unspoken real (again in my opinion) reason was to avoid documenting the
> > firmware interface and ship userspace binary blobs with no way for free
> > software to use all the device's features. That's something we have been
> > fighting against for years, trying to convince vendors that they can
> > provide better and more open camera support without the world
> > collapsing, with increasing success recently. Saying amen to
> > pass-through in this case would be a huge step back that would hurt
> > users and the whole ecosystem in the short and long term.
> 
> In my view, DRM is a more suitable model for complex ISPs than V4L2:

I know we disagree on this topic :-) I'm sure we'll continue the
conversation, but I think the technical discussion likely belongs to a
different mail thread.

> - Userspace Complexity: ISPs demand a highly complex and evolving API,
> similar to Vulkan or OpenGL. Applications typically need a framework
> like libcamera to utilize ISPs effectively, much like Mesa for
> graphics cards.
> 
> - Lack of Standardization: There's no universal standard for ISPs;
> each vendor implements unique features and usage patterns. DRM
> addresses this through vendor-specific IOCTLs
> 
> - Proprietary Architectures: Vendors often don't fully disclose their
> hardware architectures. DRM cleverly only necessitates a Mesa
> implementation, not comprehensive documentation.

This point isn't technical and is more on-topic for this mail thread.

V4L2 doesn't require hundreds of pages of comprehensive documentation in
text form. An open-source userspace implementation that covers the
feature set exposed by the driver is acceptable in place of
documentation (provided, of course, that the userspace code wouldn't be
deliberately obfuscated). This is similar in spirit to the rule for GPU
DRM drivers.

> Our current approach of pushing back against vendors, instead of
> seeking compromise, has resulted in the vast majority of the market
> (99% if not more) relying on out-of-tree drivers. This leaves users
> with no options for utilizing their cameras outside of Android.
> 
> DRM allows a hybrid model, where:
> - Open Source Foundation: Standard use cases are covered by a fully
> open-source stack.
> - Vendor Differentiation: Vendors retain the freedom to implement
> proprietary features (e.g., automatic makeup) as closed source.

V4L2 does as well, you can implement all kind of closed-source ISP
control algorithms in userspace, as long as there's an open-source
implementation that exercises the same hardware features. A good analogy
for people less familiar with ISPs is shader compilers, GPU vendors are
free to ship closed-source implementations that include more
optimizations, as long as the open-source, less optimized implementation
covers the same GPU ISA, so that open-source developers can also work on
optimizing it.

Thinking that DRM would offer a free pass-through path compared to V4L2
doesn't seem realistic to me. Both subsystems will have similar rules.

> This approach would allow billions of users to access their hardware
> more securely and with in-tree driver support. Our current stubborn
> pursuit of an idealistic goal has already negatively impacted both
> users and the ecosystem.
> 
> The late wins, in my opinion, cannot scale to the consumer market, and
> Linux will remain a niche market for ISPs.
> 
> If such a hybrid model goes against Linux goals, this is something
> that should be agreed upon by the whole community, so we have the same
> criteria for all subsystems.

-- 
Regards,

Laurent Pinchart

