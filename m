Return-Path: <linux-rdma+bounces-4064-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF86293F2BD
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 12:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDBB1F22BEC
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A596C1428F2;
	Mon, 29 Jul 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OChiU8B2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5928399;
	Mon, 29 Jul 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249142; cv=none; b=B+t7M4a6A8BVkE2jqDju/Tyrg5fcxJe3nXfIPa3WM2vUdAciIywcp7GpgCjG5gcbV0VIYhbDXNYriKcZ9pfapwyjhx75wlup4AXWmSxw31oaIMMCjlwwd90Xk4VB/vCzOfQS5VvFVwEl6yIKH2b9ug2Vp9OGBZ1fW9k66MIjpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249142; c=relaxed/simple;
	bh=zDtZb5TlY8UVoz7TOOmWK6CYcY7iqhWtFcXZWax42YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK55xnyQfi/RwwnveoLeMtv2jfy5iaFbGCMAweFC0ixEcet2CduwtXF8c9rApcmGpBEzWUKoGLCIgTniRQGsqhAF9bqmUowvqCxQ2TSD8qK4ECeSbPlvAoaBozGVI/khhuBC6BXjOKGCnCzDPAyIrUweMFimBvfstXBE5DQAhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OChiU8B2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C53945A;
	Mon, 29 Jul 2024 12:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722249091;
	bh=zDtZb5TlY8UVoz7TOOmWK6CYcY7iqhWtFcXZWax42YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OChiU8B2qF06vmFNlVwvnwhI5k8Np6jaiPywwNqNbtdyAKdOmLO2Tigkax//XoDrg
	 TjbY2e//qMWlKnLQ4XQ8vtr7tpubOyl/t7MDsFM9E7xLENh5wkleSGjyzAo8bRcyUn
	 htJKAB+YJG4/ivUCIwFo4qD+gI6zX36OV8axsEEk=
Date: Mon, 29 Jul 2024 13:31:58 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729103158.GD2320@pendragon.ideasonboard.com>
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

Hi Ricardo,

On Mon, Jul 29, 2024 at 11:58:43AM +0200, Ricardo Ribalda Delgado wrote:
> On Sun, Jul 28, 2024 at 7:18 PM Laurent Pinchart wrote:
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
> >
> > I'm sorry, but this kind of argument makes me wonder if you know how
> > ISPs work :-(
> 
> Laurent, you know for a while and I am not new in this area. Let's
> keep the discussion civil. Can we?

That's what puzzles me. I've known you for a while and know all the
expertise you've accumulated in different technical areas related to
cameras. Despite that, we seem to speak different languages, our world
views are complete mismatches. I wonder where the disconnection is.

> > > I suspect that you want to avoid them handled in DRM because then you
> > > prefer the v4l2 openness requirements.
> >
> > I certainly prefer that, but I also think we would end up having the
> > exact same openness requirement with DRM. That's at least what I would
> > aim for.
> >
> > I do also suspect that you want to handle ISPs in DRM only because you
> > believe it would give vendors a free pass-through card, and that the
> > technical arguments you brought up in the discussions are just a
> > distraction.
> 
> Let's put it this way:
> 
> If tomorrow a vendor sends to the ML a camera stack that looks like this:
> 
> - V4L2 driver for capture

No issue with that.

> - DRM driver for ISP

No issue if there are compeling *technical* arguments to do so.

> - Libcamera implementation with open algorithms
> - Everything released with an Open Licence
> - The camera stack is production ready: Meaning that it could be
> included without any vendor blob in a distro like ChromeOS.

Obviously no issues with this either.

> Would you NACK it because the vendor did not release the calibration software?

I've never asked for the calibration/tuning software to be made
open-source or even publicly available, so no nack for that.

> Would you NACK it because the vendor could also release another userspace?

We've made it clear since the beginning in libcamera that closed
implementation of ISP control algorithms are totally fine as an
alternate implementation, so no issue either.

> That NACK will benefit the users? in what timeframe? Another decade?
> 
> Does the rest of the kernel community agree on that? I thought that we
> were doing Linux for world domination :)
> 
> > > There are no technical benefit
> > > from v4l2 for using ISPs:
> > >
> > > ```
> > > Everyone agrees that the current V4L2 API is not very suitable for the
> > > current generation of ISPs: it is too cumbersome.
> > > ```
> > > https://linuxtv.org/news.php?entry=2022-11-14-1.hverkuil
> >
> > And we've improved the situation since then, and landed/landing more ISP
> > drivers. There's further ongoing improvements pending.
> 
> We are indeed improving, but I still agree with the original statement.
> 
> > > > > > > > > Our current approach of pushing back against vendors, instead of
> > > > > > > > > seeking compromise, has resulted in the vast majority of the market
> > > > > > > > > (99% if not more) relying on out-of-tree drivers. This leaves users
> > > > > > > > > with no options for utilizing their cameras outside of Android.
> > > > > > > > >
> > > > > > > > > DRM allows a hybrid model, where:
> > > > > > > > > - Open Source Foundation: Standard use cases are covered by a fully
> > > > > > > > > open-source stack.
> > > > > > > > > - Vendor Differentiation: Vendors retain the freedom to implement
> > > > > > > > > proprietary features (e.g., automatic makeup) as closed source.
> > > > > > > >
> > > > > > > > V4L2 does as well, you can implement all kind of closed-source ISP
> > > > > > > > control algorithms in userspace, as long as there's an open-source
> > > > > > > > implementation that exercises the same hardware features. A good analogy
> > > > > > >
> > > > > > > Is it really mandatory to have an open-source 3A algorithm? I thought
> > > > > > > defining the input and output from the algorithm was good enough.
> > > > > >
> > > > > > What really matters is documenting the ISP parameters with enough
> > > > > > details to allow for the implementation of open-source userspace code.
> > > > > > Once you have that, 3A is quite simple. You can refine it (especially
> > > > > > AWB) to great length, for instance using NPUs to compute parameters, and
> > > > > > there's absolutely no issue with such userspace implementations being
> > > > > > closed.
> > > > > >
> > > > > > In practice, some vendors prefer documenting the parameters by writing
> > > > > > an open-source userspace implementation, partly maybe because developers
> > > > > > are more familiar writing code than formal documentation. I would be
> > > > > > fine either way, as long as there's enough information to make use of
> > > > > > the ISP.
> > > > >
> > > > > Even with vendor passthrough there is still a need to provide a full
> > > > > open source implementation (probably based on libcamera).
> > > >
> > > > We have a different interpretation of "full" :-) I want to aim for
> > > > "full" to cover all the features exposed by the driver UAPI. There could
> > > > be some exceptions that we can discuss if there are compeling arguments,
> > > > but that would result in a 99% coverage, not a 20%, 50% or 80% coverage.
> > >
> > > Full means that I can use my camera using debian main and nothing more
> > > than that.  It is a pretty accepted description of what fully open
> > > means.
> >
> > Thanks to the soft ISP support we've just landed in libcamera, and the
> > IPU6 ISYS driver merged in mainline, you will be able to use your camera
> > with Debian main as soon as it integrates recent enough versions of the
> > kernel and libcamera packages. I hope you don't consider that as full
> > support.
> 
> It is not "full support" because it is missing a lot of the basic
> characteristics..
> 
> Why don't you want to describe what are the objective characteristics
> that an Open Camera stack should have?

Because that is difficult to do, and may not lead to a very useful
outcome. I'm willing to brainstorm it though, but I don't have a
ready-made answer at the moment.

> Asking vendors to fulfill a set of characteristics is more realistic
> than asking them to document the ISP hardware, the ISP algos,  the
> calibration files, the calibration tools...
> 
> > > > > So you will have enough information to use all the common
> > > > > functionality of a camera.
> > > > >
> > > > > > > AFAIK for some time there was no ipu3 open source algorithm, and the
> > > > > > > driver has been upstream.
> > > > > >
> > > > > > It sneaked in before we realized we had to enforce rules :-) That's
> > > > > > actually a good example, when we wrote open-source userspace support, we
> > > > > > realized that the level of documentation included in the IPU3 kernel
> > > > > > header was nowhere close to what was needed to make use of the device.
> > > > > >
> > > > > > > > for people less familiar with ISPs is shader compilers, GPU vendors are
> > > > > > > > free to ship closed-source implementations that include more
> > > > > > > > optimizations, as long as the open-source, less optimized implementation
> > > > > > > > covers the same GPU ISA, so that open-source developers can also work on
> > > > > > > > optimizing it.
> > > > > > >
> > > > > > > I believe a more accurate description is that in v4l2 is that we
> > > > > > > expect that all the registers, device architecture and behaviour to be
> > > > > > > documented and accessed with standard IOCTLs. Anything not documented
> > > > > > > cannot be accessed by userspace.
> > > > > > >
> > > > > > > In DRM their concern is that there is a fully open source
> > > > > > > implementation that the user can use. Vendors have custom IOCTLs and
> > > > > > > they can offer proprietary software for some use cases.
> > > > > >
> > > > > > Custom ioctls are not closed secrets in DRM, so comparing custom ioctls
> > > > > > vs. standard ioctls isn't very relevant to this discussion. I really
> > > > > > don't see how this would be about ioctls, it's about making the featured
> > > > > > exposed by the drivers, through whatever means a particular subsystem
> > > > > > allows, usable by open userspace.
> > > > > >
> > > > > > > > Thinking that DRM would offer a free pass-through path compared to V4L2
> > > > > > > > doesn't seem realistic to me. Both subsystems will have similar rules.
> > > > > > >
> > > > > > > DRM does indeed allow vendors to pass random command buffers and they
> > > > > > > will be sent to the hardware. We cannot do that in v4l2.
> > > > > >
> > > > > > You can pass a command buffer to a V4L2 device and have the driver send
> > > > > > it to the device firmware (ISPs using real command buffers usually run a
> > > > > > firmware). If you want the driver to be merged upstream, you have to
> > > > > > document the command buffer in enough details.
> > > > >
> > > > > Documenting with "enough details" is not enough. In V4L2, we have to
> > > > > deeply inspect every single buffer to make sure that it is not sending
> > > > > an unknown combination of command+arguments, or in other situations we
> > > > > construct the command buffer in the driver.
> > > > >
> > > > > > > I might be wrong, but GPU drivers do not deeply inspect the command
> > > > > > > buffers to make sure that they do not use any feature not covered by
> > > > > > > mesa.
> > > > > >
> > > > > > That's correct, but I don't think that's relevant. The GPU market has
> > > > > > GLSL and Vulkan. An open-source compliant implementation will end up
> > > > > > exercising a very very large part of the device ISA, command submission
> > > > > > mechanism and synchronization primitives, if not all of it. There's
> > > > > > little a vendor would keep under the hood and use in closed-source
> > > > > > userspace only. For cameras, there's no standard userspace API that
> > > > > > covers by design a very large part of what is the ISP equivalent of a
> > > > >
> > > > > Libcamera supports Camera HAL3, gstreamer, v4l2, pipewire...
> > > >
> > > > Those are not comparable to GLSL or Vulkan, they are much higher level.
> > > >
> > > > > If we are afraid of vendors providing "toy" implemententations to pass
> > > > > the openness requirements, we can add more features/tests to
> > > > > libcamera.
> > > > >
> > > > > And at the end of the day, there will be humans deciding if what a
> > > > > vendor has provided is good enough or not.
> > > > >
> > > > > > GPU ISA. Even "command buffers" are not a proper description of the
> > > > > > parameters the vast majority of ISPs consume.
> > > > >
> > > > > Modern ISPs are definitely going in the direction of "command buffers"
> > > >
> > > > Examples please, with technical details. I've seen this argument being
> > > > used for at least a year, with very little evidence. There are ISPs that
> > > > are more programmable than others, but in practice firmwares mostly
> > > > expose fixed functions, not ISA-level programmability.
> > >
> > > You have not seen many programmable ISPs in v4l2 because they cannot
> > > be supported with v4l2.
> >
> > I have not seen many programmable ISPs, period. I would like to see
> > concrete examples of those ISPs, with technical details of the hardware
> > and firmware, disregarding which kernel API we would use.
> 
> Just to name one with some public details, Synopsys has a family of devices:
> https://www.synopsys.com/dw/ipdir.php?ds=ev7x-vision-processors
> You can do standard ISP + AI with one core, pretty cool.

It's a vision processor, not a camera ISP. Those are different beasts.

> Most of the time, Camera ISPs are nothing more than DSPs plus a
> firmware with the computer vision algos.

Not for camera ISPs, no.

> If there is no framework to use a programmable ISP, vendors will keep
> putting everything on the firmware and exposing parameters.

For vision processors that's not even the case, vendors use a full
pass-through implementation, with fully closed compilers. It's a
completely different story.

> > > Instead vendors have to create huge firmwares that limits the
> > > capability of the device.
> > > I do not want to look into those firmwares.
> > >
> > > > > > > > > This approach would allow billions of users to access their hardware
> > > > > > > > > more securely and with in-tree driver support. Our current stubborn
> > > > > > > > > pursuit of an idealistic goal has already negatively impacted both
> > > > > > > > > users and the ecosystem.
> > > > > > > > >
> > > > > > > > > The late wins, in my opinion, cannot scale to the consumer market, and
> > > > > > > > > Linux will remain a niche market for ISPs.
> > > > > > > > >
> > > > > > > > > If such a hybrid model goes against Linux goals, this is something
> > > > > > > > > that should be agreed upon by the whole community, so we have the same
> > > > > > > > > criteria for all subsystems.

-- 
Regards,

Laurent Pinchart

