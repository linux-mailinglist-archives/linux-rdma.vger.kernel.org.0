Return-Path: <linux-rdma+bounces-4132-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43819942D91
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 13:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE11E1F248D9
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DED1AE87B;
	Wed, 31 Jul 2024 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="g6peNjGX";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qPS5rZgA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36451AE85F;
	Wed, 31 Jul 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426892; cv=pass; b=MP5j8Ic+rYRep/S6lYqKbC0Bwj/0MipBbhha+gEOgivezx8hXkDfB4++qXG6F9e1oKsR+u4tKE6xVW5Tws4rgpX0GYciXJe3zWR+gcRrC2/DJQlw2RFxPnd9ONq9h1nfnED+qPLZmrrFVgea/QYiPAezIOd3F7SRoKZVOgEp2sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426892; c=relaxed/simple;
	bh=CABhSGcfV5m959vRFj2jXSon8QSPqxU94n4Aq6QlzcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDwy0I8MRymWt482l2e9hq5yBRJg8Ip4jzdJw9CJDaGRcRjv6QrvIlKXh2Sdk6/b4HhwoMMLfoMpFq5QKUMF8H7U4cCVfBh3rL3qSbdf2mjFX0BvVQK0SchUFFfioN9kEyYk/Iss8zlxf62q4O2C09pnKPkn3070LTtVTX3ZHXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=g6peNjGX; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qPS5rZgA; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4WYrB01v8Qz49Pyq;
	Wed, 31 Jul 2024 14:54:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1722426888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q73OLXKZfqxibEgrERITEML62ne5GXDemgEd0/Awk2E=;
	b=g6peNjGXFDxU8tdvEuHUXz8VhfaIwltAbHapf0j8W5l2f3ge/rNc8EKeVrUL6W1SfcsUSg
	twXjLWaRfCTtSppXzs2H/43H5vKT2rH35X6lVTFnRcn1q4+yj/cwdfqsGbm2CoC03V6/Ku
	jj9nL0z17c3VXEp45GD0D6c5gMcwqyDbEBrEOaI9jKesgvkhoqB5ldvZXmLmhJa35zDIDX
	Gm5Iy8Naph8OcKXPWKimH1GwJmJpObBHcy69tRnks6+QNsele2g95rHJAE7tbzySxzbsLH
	hpCX1yI12GNIgzL6qzKPr32FIOoJCrSK1qwhSh1QMZ1x+xSdig0iuHanoTNQ5A==
Received: from hillosipuli.retiisi.eu (80-248-247-191.cust.suomicom.net [80.248.247.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WYr9n0pG6zyR7;
	Wed, 31 Jul 2024 14:54:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1722426879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q73OLXKZfqxibEgrERITEML62ne5GXDemgEd0/Awk2E=;
	b=qPS5rZgA+7a0Xd8aNq9BNzjvzFQ3p8rKjnagbi4sY1vkJL13rV3CjRzUUX6Sm6cq14lD5r
	V2rAAGfLh5mQgTHuec5oA0wsCpowQCRagMLR2VPoA89rBbng2A6hRyER0bKCu5L/5hzp3P
	tCgCpmloES/ASqCnwH/BitjwFZWRapI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1722426879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q73OLXKZfqxibEgrERITEML62ne5GXDemgEd0/Awk2E=;
	b=kRMe7VUbp8oYJeTuJ2ZqADBr9fA8bLhnnHDx7jTUyxVXhZImQAqswtIlOQ549zP2v/okIr
	e4mr9mQxUAm+AgOMMpEOWyJCKORZFkF4Qb8PTF2F2Hqr1INdJDYs9JfQuLf8QAkQawOT+g
	+u1GUrNzK15tWAwz35mFxHWSvsFk2J8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1722426879; a=rsa-sha256; cv=none;
	b=LeE3YNUhXrlDHmV+0Kc9dt6cNQaXo6eNBYQkVdtK+FEAaADFHjhX0xJBPrB+cN9APsBVSM
	XN98oPOVI8lO86OO+2Ysd9zMj7DgCvETqzP3M6+KfWtKvbfqRXYwhTQiYLtlBR/qP4bXRu
	uXfOKgMA++MhRnMS35I6TshWKb4tug0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id ABD82634C94;
	Wed, 31 Jul 2024 14:54:36 +0300 (EEST)
Date: Wed, 31 Jul 2024 11:54:36 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <Zqol_N8qkMI--n-S@valkosipuli.retiisi.eu>
References: <20240721192530.GD23783@pendragon.ideasonboard.com>
 <CAPybu_2tUmYtNiSExNGpsxcF=7EO+ZHR8eGammBsg8iFh3B3wg@mail.gmail.com>
 <20240722111834.GC13497@pendragon.ideasonboard.com>
 <CAPybu_1SiMmegv=4dys+1tzV6=PumKxfB5p12ST4zasCjwzS9g@mail.gmail.com>
 <20240725200142.GF14252@pendragon.ideasonboard.com>
 <CAPybu_1hZfAqp2uFttgYgRxm_tYzJJr-U3aoD1WKCWQsHThSLw@mail.gmail.com>
 <20240726105936.GC28621@pendragon.ideasonboard.com>
 <CAPybu_1y7K940ndLZmy+QdfkJ_D9=F9nTPpp=-j9HYpg4AuqqA@mail.gmail.com>
 <20240728171800.GJ30973@pendragon.ideasonboard.com>
 <CAPybu_3M9GYNrDiqH1pXEvgzz4Wz_a672MCkNGoiLy9+e67WQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_3M9GYNrDiqH1pXEvgzz4Wz_a672MCkNGoiLy9+e67WQw@mail.gmail.com>

Hi Ricardo, Laurent,

On Mon, Jul 29, 2024 at 11:58:43AM +0200, Ricardo Ribalda Delgado wrote:
> On Sun, Jul 28, 2024 at 7:18 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > On Fri, Jul 26, 2024 at 05:40:16PM +0200, Ricardo Ribalda Delgado wrote:
> > > On Fri, Jul 26, 2024 at 12:59 PM Laurent Pinchart wrote:
> > > > On Fri, Jul 26, 2024 at 10:04:33AM +0200, Ricardo Ribalda Delgado wrote:
> > > > > On Thu, Jul 25, 2024 at 10:02 PM Laurent Pinchart wrote:
> > > > > > On Mon, Jul 22, 2024 at 01:56:11PM +0200, Ricardo Ribalda Delgado wrote:
> > > > > > > On Mon, Jul 22, 2024 at 1:18 PM Laurent Pinchart wrote:
> > > > > > > > On Mon, Jul 22, 2024 at 12:42:52PM +0200, Ricardo Ribalda Delgado wrote:
> > > > > > > > > On Sun, Jul 21, 2024 at 9:25 PM Laurent Pinchart wrote:
> > > > > > > > > > On Tue, Jul 09, 2024 at 03:15:13PM -0700, Dan Williams wrote:
> > > > > > > > > > > James Bottomley wrote:
> > > > > > > > > > > > > The upstream discussion has yielded the full spectrum of positions on
> > > > > > > > > > > > > device specific functionality, and it is a topic that needs cross-
> > > > > > > > > > > > > kernel consensus as hardware increasingly spans cross-subsystem
> > > > > > > > > > > > > concerns. Please consider it for a Maintainers Summit discussion.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm with Greg on this ... can you point to some of the contrary
> > > > > > > > > > > > positions?
> > > > > > > > > > >
> > > > > > > > > > > This thread has that discussion:
> > > > > > > > > > >
> > > > > > > > > > > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > > > > > > > > > >
> > > > > > > > > > > I do not want to speak for others on the saliency of their points, all I
> > > > > > > > > > > can say is that the contrary positions have so far not moved me to drop
> > > > > > > > > > > consideration of fwctl for CXL.
> > > > > > > > > > >
> > > > > > > > > > > Where CXL has a Command Effects Log that is a reasonable protocol for
> > > > > > > > > > > making decisions about opaque command codes, and that CXL already has a
> > > > > > > > > > > few years of experience with the commands that *do* need a Linux-command
> > > > > > > > > > > wrapper.
> > > > > > > > > > >
> > > > > > > > > > > Some open questions from that thread are: what does it mean for the fate
> > > > > > > > > > > of a proposal if one subsystem Acks the ABI and another Naks it for a
> > > > > > > > > > > device that crosses subsystem functionality? Would a cynical hardware
> > > > > > > > > > > response just lead to plumbing an NVME admin queue, or CXL mailbox to
> > > > > > > > > > > get device-specific commands past another subsystem's objection?
> > > > > > > > > >
> > > > > > > > > > My default answer would be to trust the maintainers of the relevant
> > > > > > > > > > subsystems (or try to convince them when you disagree :-)). Not only
> > > > > > > > > > should they know the technical implications best, they should also have
> > > > > > > > > > a good view of the whole vertical stack, and the implications of
> > > > > > > > > > pass-through for their ecosystem. This may result in a single NAK
> > > > > > > > > > overriding ACKs, but we could also try to find technical solutions when
> > > > > > > > > > we'll face such issues, to enforce different sets of rules for the
> > > > > > > > > > different functions of a device.
> > > > > > > > > >
> > > > > > > > > > Subsystem hopping is something we're recently noticed for camera ISPs,
> > > > > > > > > > where a vendor wanted to move from V4L2 to DRM. Technical reasons for
> > > > > > > > > > doing so were given, and they were (in my opinion) rather excuses. The
> > > > > > > > > > unspoken real (again in my opinion) reason was to avoid documenting the
> > > > > > > > > > firmware interface and ship userspace binary blobs with no way for free
> > > > > > > > > > software to use all the device's features. That's something we have been
> > > > > > > > > > fighting against for years, trying to convince vendors that they can
> > > > > > > > > > provide better and more open camera support without the world
> > > > > > > > > > collapsing, with increasing success recently. Saying amen to
> > > > > > > > > > pass-through in this case would be a huge step back that would hurt
> > > > > > > > > > users and the whole ecosystem in the short and long term.
> > > > > > > > >
> > > > > > > > > In my view, DRM is a more suitable model for complex ISPs than V4L2:
> > > > > > > >
> > > > > > > > I know we disagree on this topic :-) I'm sure we'll continue the
> > > > > > > > conversation, but I think the technical discussion likely belongs to a
> > > > > > > > different mail thread.
> > > > > > > >
> > > > > > > > > - Userspace Complexity: ISPs demand a highly complex and evolving API,
> > > > > > > > > similar to Vulkan or OpenGL. Applications typically need a framework
> > > > > > > > > like libcamera to utilize ISPs effectively, much like Mesa for
> > > > > > > > > graphics cards.
> > > > > > > > >
> > > > > > > > > - Lack of Standardization: There's no universal standard for ISPs;
> > > > > > > > > each vendor implements unique features and usage patterns. DRM
> > > > > > > > > addresses this through vendor-specific IOCTLs
> > > > > > > > >
> > > > > > > > > - Proprietary Architectures: Vendors often don't fully disclose their
> > > > > > > > > hardware architectures. DRM cleverly only necessitates a Mesa
> > > > > > > > > implementation, not comprehensive documentation.
> > > > > > > >
> > > > > > > > This point isn't technical and is more on-topic for this mail thread.
> > > > > > > >
> > > > > > > > V4L2 doesn't require hundreds of pages of comprehensive documentation in
> > > > > > > > text form. An open-source userspace implementation that covers the
> > > > > > > > feature set exposed by the driver is acceptable in place of
> > > > > > > > documentation (provided, of course, that the userspace code wouldn't be
> > > > > > > > deliberately obfuscated). This is similar in spirit to the rule for GPU
> > > > > > > > DRM drivers.
> > > > > > >
> > > > > > > In DRM vendors typically define a custom IOCTL per driver to pass
> > > > > > > command buffers.
> > > > > > > Only the command buffer structure, and a mesa implementation using
> > > > > > > that command buffer to support the standard features is required.
> > > > > > >
> > > > > > > In V4l2 custom IOCTLs are discouraged. Random command buffers cannot
> > > > > > > be passed from userspace, they are typically formed in the driver from
> > > > > > > a strictly checked struct.
> > > > > >
> > > > > > V4L2 has a mechanism to pass buffers between userspace and kernelspace,
> > > > > > and that mechanism is used in mainline drivers to pass camera ISP
> > > > > > parameters. They're not called "command buffers" but that's just a
> > > > > > difference in terminology. The technical means to pass command buffers
> > > > > > to the driver is thus there, I see no meaningful difference with DRM.
> > > > > > Where things can differ is in the contents of those buffers, and the
> > > > > > requirements for documentation or open userspace implementations, but
> > > > > > that's not a technical question.
> > > > >
> > > > > There are two things here:
> > > > >
> > > > > - The political/strategic/philosophical/religious aspect: The industry
> > > > > definitely prefers the strategic requirements imposed by DRM. In fact
> > > > > some vendors had some huge legal troubles when they had tried to
> > > > > follow v4l2 requirements.
> > > >
> > > > That's I'm willing to debate.
> > > >
> > > > > - The technical aspect: DRM is more mature when it comes to
> > > > > sending/receiving buffers to the hardware, and an ISP looks *much*
> > > > > more similar to an accel device or a GPU than a UVC camera.
> > > >
> > > > But this I don't agree with. I think we should forgo the technical
> > > > discussion and stop pretending that DRM is better for this use case from
> > > > a technical point of view, and focus on the other aspect of the
> > > > discussion. (We can of course reopen the technical discussion if new
> > > > concrete arguments emerge.)
> > >
> > > I disagree. ISP devices are EXACTLY the same as accel devices.

...

> Most of the time, Camera ISPs are nothing more than DSPs plus a
> firmware with the computer vision algos.
> 
> If there is no framework to use a programmable ISP, vendors will keep
> putting everything on the firmware and exposing parameters.

ISPs, as the name suggests, tend to be purpose-built devices, even if some
support some degree of programmability. Even in those cases, the
programmable hardware often assumes pixels are being processed so they
can't be meaningfully used for general-purpose computation. The majority of
devices still has a hardware pipeline with no programmability.

This is also very different from GPUs or accel devices that are built to be
user-programmable. If I'd compare ISPs to different devices, then the
closest match would probably be video codecs -- which also use V4L2.

Also many ISPs use sensor input directly. That introduces timing
constraints that have implications on the API, too, as well as the use of
V4L2/MC APIs by those devices today. I'd rather not see device using an
entirely different API such as DRM in the same pipeline.

I believe we agree V4L2 isn't a great API for camera ISPs but then again I
don't think just switching to DRM is a solution that reasonably covers even
much of the problem area. Some ISPs could be fine using it as such from
purely technical point of view but there are be those for which DRM isn't
an option at all (mainly those having a sensor input).

So in my opinion we either need to improve V4L2/MC to better support those
devices or have an entirely new UAPI for them.

-- 
Kind regards,

Sakari Ailus

