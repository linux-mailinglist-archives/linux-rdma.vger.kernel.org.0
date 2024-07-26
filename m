Return-Path: <linux-rdma+bounces-4006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9D93CF37
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 10:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13494283197
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4681176FA8;
	Fri, 26 Jul 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgQ6+fOy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197B176AAA;
	Fri, 26 Jul 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981095; cv=none; b=VD9AuE7Yr/VjQSy+nggorGzaVi5mTVf9qNQUuGdTVpqX0X0IpYGU3ProUYv60Q6rsjSukBDrwU5y+/FGOkY0ntZXxuA8X7jwve75DSPqQoe0IRe+SBXHYg0dWlxgOCGuvXDRyJygzgEB1FJ+c3Vp3A98ivKJw+EFqrKTIyaM82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981095; c=relaxed/simple;
	bh=3rCcaIKzprH0B1YUM6DsKtCcvO13lgaECYjxqPkORVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj+ToX7owYA555XjUQbIuRu5GigeXp668f+6rlu3b0ehXRkqNOWYdsyl4/63lYy1tuBQeWcC6SBWM/AHjJkj3Wy3T5wAqh3e8HUQn/PHQ7CwgPOBNQAIfoZ5OsuAyPhhB2YorkeEhQ67QRNAwP28IsUP7+hR42p8BKTbxiB4M74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgQ6+fOy; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f6d01961a7so156996e0c.2;
        Fri, 26 Jul 2024 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721981092; x=1722585892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rCcaIKzprH0B1YUM6DsKtCcvO13lgaECYjxqPkORVc=;
        b=PgQ6+fOyJQEWvv/M7SoHUmg/TAsDeLf3O1ylpbP5xAdn5nI7qjFdtMTkRfbrFjYTZ1
         +yxaO/AUjwp9EHddu5cwzTurM2N2uH5WY41rujIXHX3Jhm31+rINTG5amBZ7cvf1tU1R
         txERHFF0Dcx8ggcZ6NG1KChd1qhq5m0hwEilJhxZ5KmwR4mSN1HT/QGeUwv4q5jCRPbR
         38LfIc3jEIig8709yxRUI2/gZgkZUlUfpcrOuS9WfUl21skm2SUd/yGkYbK46vijltHj
         jaNsicVO6t94C8kpb3qPv91E/6I/vFnS+I2ecD7v2arEh834VxxyqLUK1n1p5mIbYLkI
         /NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981092; x=1722585892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rCcaIKzprH0B1YUM6DsKtCcvO13lgaECYjxqPkORVc=;
        b=L8E4SasIfLGb7m1F9i9Qj4oBqt7nrDzCgrqo6Pzmo0jO3IgJlD4JZpEcqaq+iZWyzy
         btfae7ABp5L8mIrzLPgL10ep1b3pSy0sepL/reGmK6VpxhHZ5V3Kdf3K+fYZjLZz8uRv
         ERNZc90huKBCj5hMXn8pCzqllTqspd/YmgpTRnPKN1udm/1p/ZtbkxU2rCVkF4hdoFXn
         J2c20aE/Q6gnPpQgbZViESDnEKQkdTwHazTR8n4EuBTquS4YW0Cn9hgk59ksPE7x7rVl
         hoRWsC4PKABJHHqGwUWPzDTk+zm43UVXaWNVhoaxlTZyo1KgmTZZ2pIcDmqoAtwBv/2K
         ubkw==
X-Forwarded-Encrypted: i=1; AJvYcCX2bPmdyZlRtlznTxsWizRSf0hpYPVhdlajHS0bobyfDYi6yrowUdf0ZXZduic4vZC1+XtGsqGKfaQYOvYAhI5xCGRJLFsmTCH7+DWCLP2PpcBm4wm2XNNGXBKBuZ9tfgw95vJbFaZR41nrGAfinyAT6zLTRrTR3ldY+dI+8g==
X-Gm-Message-State: AOJu0YxIxBmoDWmfYet0iHnKZKVmGdZ+qcVBPuUtyxCzFc++7/oM9/no
	95gcIiHl2JFoRE0nn500m38ro28qgPN8RlM+T2jQSBta3SJ5AMLB1j69g0qizwzXSYU1jbfHoy+
	UHFH5uT0vApcIad1dFzBkamf3GG42LL5+zEk=
X-Google-Smtp-Source: AGHT+IHAgEHkTed+iTxJYkjK6Lc6SKUhzp889QWaP7H+G0eNF/WSvKeCMUoix3SK8LBJobMWRbeeDiJOVMNy/vPSSd4=
X-Received: by 2002:a05:6122:2901:b0:4f3:207a:c664 with SMTP id
 71dfb90a1353d-4f6c5c9455bmr6315323e0c.14.1721981092053; Fri, 26 Jul 2024
 01:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240721192530.GD23783@pendragon.ideasonboard.com> <CAPybu_2tUmYtNiSExNGpsxcF=7EO+ZHR8eGammBsg8iFh3B3wg@mail.gmail.com>
 <20240722111834.GC13497@pendragon.ideasonboard.com> <CAPybu_1SiMmegv=4dys+1tzV6=PumKxfB5p12ST4zasCjwzS9g@mail.gmail.com>
 <20240725200142.GF14252@pendragon.ideasonboard.com>
In-Reply-To: <20240725200142.GF14252@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 26 Jul 2024 10:04:33 +0200
Message-ID: <CAPybu_1hZfAqp2uFttgYgRxm_tYzJJr-U3aoD1WKCWQsHThSLw@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 10:02=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Mon, Jul 22, 2024 at 01:56:11PM +0200, Ricardo Ribalda Delgado wrote:
> > On Mon, Jul 22, 2024 at 1:18=E2=80=AFPM Laurent Pinchart wrote:
> > > On Mon, Jul 22, 2024 at 12:42:52PM +0200, Ricardo Ribalda Delgado wro=
te:
> > > > On Sun, Jul 21, 2024 at 9:25=E2=80=AFPM Laurent Pinchart wrote:
> > > > > On Tue, Jul 09, 2024 at 03:15:13PM -0700, Dan Williams wrote:
> > > > > > James Bottomley wrote:
> > > > > > > > The upstream discussion has yielded the full spectrum of po=
sitions on
> > > > > > > > device specific functionality, and it is a topic that needs=
 cross-
> > > > > > > > kernel consensus as hardware increasingly spans cross-subsy=
stem
> > > > > > > > concerns. Please consider it for a Maintainers Summit discu=
ssion.
> > > > > > >
> > > > > > > I'm with Greg on this ... can you point to some of the contra=
ry
> > > > > > > positions?
> > > > > >
> > > > > > This thread has that discussion:
> > > > > >
> > > > > > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.co=
m
> > > > > >
> > > > > > I do not want to speak for others on the saliency of their poin=
ts, all I
> > > > > > can say is that the contrary positions have so far not moved me=
 to drop
> > > > > > consideration of fwctl for CXL.
> > > > > >
> > > > > > Where CXL has a Command Effects Log that is a reasonable protoc=
ol for
> > > > > > making decisions about opaque command codes, and that CXL alrea=
dy has a
> > > > > > few years of experience with the commands that *do* need a Linu=
x-command
> > > > > > wrapper.
> > > > > >
> > > > > > Some open questions from that thread are: what does it mean for=
 the fate
> > > > > > of a proposal if one subsystem Acks the ABI and another Naks it=
 for a
> > > > > > device that crosses subsystem functionality? Would a cynical ha=
rdware
> > > > > > response just lead to plumbing an NVME admin queue, or CXL mail=
box to
> > > > > > get device-specific commands past another subsystem's objection=
?
> > > > >
> > > > > My default answer would be to trust the maintainers of the releva=
nt
> > > > > subsystems (or try to convince them when you disagree :-)). Not o=
nly
> > > > > should they know the technical implications best, they should als=
o have
> > > > > a good view of the whole vertical stack, and the implications of
> > > > > pass-through for their ecosystem. This may result in a single NAK
> > > > > overriding ACKs, but we could also try to find technical solution=
s when
> > > > > we'll face such issues, to enforce different sets of rules for th=
e
> > > > > different functions of a device.
> > > > >
> > > > > Subsystem hopping is something we're recently noticed for camera =
ISPs,
> > > > > where a vendor wanted to move from V4L2 to DRM. Technical reasons=
 for
> > > > > doing so were given, and they were (in my opinion) rather excuses=
. The
> > > > > unspoken real (again in my opinion) reason was to avoid documenti=
ng the
> > > > > firmware interface and ship userspace binary blobs with no way fo=
r free
> > > > > software to use all the device's features. That's something we ha=
ve been
> > > > > fighting against for years, trying to convince vendors that they =
can
> > > > > provide better and more open camera support without the world
> > > > > collapsing, with increasing success recently. Saying amen to
> > > > > pass-through in this case would be a huge step back that would hu=
rt
> > > > > users and the whole ecosystem in the short and long term.
> > > >
> > > > In my view, DRM is a more suitable model for complex ISPs than V4L2=
:
> > >
> > > I know we disagree on this topic :-) I'm sure we'll continue the
> > > conversation, but I think the technical discussion likely belongs to =
a
> > > different mail thread.
> > >
> > > > - Userspace Complexity: ISPs demand a highly complex and evolving A=
PI,
> > > > similar to Vulkan or OpenGL. Applications typically need a framewor=
k
> > > > like libcamera to utilize ISPs effectively, much like Mesa for
> > > > graphics cards.
> > > >
> > > > - Lack of Standardization: There's no universal standard for ISPs;
> > > > each vendor implements unique features and usage patterns. DRM
> > > > addresses this through vendor-specific IOCTLs
> > > >
> > > > - Proprietary Architectures: Vendors often don't fully disclose the=
ir
> > > > hardware architectures. DRM cleverly only necessitates a Mesa
> > > > implementation, not comprehensive documentation.
> > >
> > > This point isn't technical and is more on-topic for this mail thread.
> > >
> > > V4L2 doesn't require hundreds of pages of comprehensive documentation=
 in
> > > text form. An open-source userspace implementation that covers the
> > > feature set exposed by the driver is acceptable in place of
> > > documentation (provided, of course, that the userspace code wouldn't =
be
> > > deliberately obfuscated). This is similar in spirit to the rule for G=
PU
> > > DRM drivers.
> >
> > In DRM vendors typically define a custom IOCTL per driver to pass
> > command buffers.
> > Only the command buffer structure, and a mesa implementation using
> > that command buffer to support the standard features is required.
> >
> > In V4l2 custom IOCTLs are discouraged. Random command buffers cannot
> > be passed from userspace, they are typically formed in the driver from
> > a strictly checked struct.
>
> V4L2 has a mechanism to pass buffers between userspace and kernelspace,
> and that mechanism is used in mainline drivers to pass camera ISP
> parameters. They're not called "command buffers" but that's just a
> difference in terminology. The technical means to pass command buffers
> to the driver is thus there, I see no meaningful difference with DRM.
> Where things can differ is in the contents of those buffers, and the
> requirements for documentation or open userspace implementations, but
> that's not a technical question.

There are two things here:

- The political/strategic/philosophical/religious aspect: The industry
definitely prefers the strategic requirements imposed by DRM. In fact
some vendors had some huge legal troubles when they had tried to
follow v4l2 requirements.
- The technical aspect: DRM is more mature when it comes to
sending/receiving buffers to the hardware, and an ISP looks *much*
more similar to an accel device or a GPU than a UVC camera.


>
> > > > Our current approach of pushing back against vendors, instead of
> > > > seeking compromise, has resulted in the vast majority of the market
> > > > (99% if not more) relying on out-of-tree drivers. This leaves users
> > > > with no options for utilizing their cameras outside of Android.
> > > >
> > > > DRM allows a hybrid model, where:
> > > > - Open Source Foundation: Standard use cases are covered by a fully
> > > > open-source stack.
> > > > - Vendor Differentiation: Vendors retain the freedom to implement
> > > > proprietary features (e.g., automatic makeup) as closed source.
> > >
> > > V4L2 does as well, you can implement all kind of closed-source ISP
> > > control algorithms in userspace, as long as there's an open-source
> > > implementation that exercises the same hardware features. A good anal=
ogy
> >
> > Is it really mandatory to have an open-source 3A algorithm? I thought
> > defining the input and output from the algorithm was good enough.
>
> What really matters is documenting the ISP parameters with enough
> details to allow for the implementation of open-source userspace code.
> Once you have that, 3A is quite simple. You can refine it (especially
> AWB) to great length, for instance using NPUs to compute parameters, and
> there's absolutely no issue with such userspace implementations being
> closed.
>
> In practice, some vendors prefer documenting the parameters by writing
> an open-source userspace implementation, partly maybe because developers
> are more familiar writing code than formal documentation. I would be
> fine either way, as long as there's enough information to make use of
> the ISP.
>

Even with vendor passthrough there is still a need to provide a full
open source implementation (probably based on libcamera).

So you will have enough information to use all the common
functionality of a camera.

> > AFAIK for some time there was no ipu3 open source algorithm, and the
> > driver has been upstream.
>
> It sneaked in before we realized we had to enforce rules :-) That's
> actually a good example, when we wrote open-source userspace support, we
> realized that the level of documentation included in the IPU3 kernel
> header was nowhere close to what was needed to make use of the device.
>
> > > for people less familiar with ISPs is shader compilers, GPU vendors a=
re
> > > free to ship closed-source implementations that include more
> > > optimizations, as long as the open-source, less optimized implementat=
ion
> > > covers the same GPU ISA, so that open-source developers can also work=
 on
> > > optimizing it.
> >
> > I believe a more accurate description is that in v4l2 is that we
> > expect that all the registers, device architecture and behaviour to be
> > documented and accessed with standard IOCTLs. Anything not documented
> > cannot be accessed by userspace.
> >
> > In DRM their concern is that there is a fully open source
> > implementation that the user can use. Vendors have custom IOCTLs and
> > they can offer proprietary software for some use cases.
>
> Custom ioctls are not closed secrets in DRM, so comparing custom ioctls
> vs. standard ioctls isn't very relevant to this discussion. I really
> don't see how this would be about ioctls, it's about making the featured
> exposed by the drivers, through whatever means a particular subsystem
> allows, usable by open userspace.
>
> > > Thinking that DRM would offer a free pass-through path compared to V4=
L2
> > > doesn't seem realistic to me. Both subsystems will have similar rules=
.
> >
> > DRM does indeed allow vendors to pass random command buffers and they
> > will be sent to the hardware. We cannot do that in v4l2.
>
> You can pass a command buffer to a V4L2 device and have the driver send
> it to the device firmware (ISPs using real command buffers usually run a
> firmware). If you want the driver to be merged upstream, you have to
> document the command buffer in enough details.

Documenting with "enough details" is not enough. In V4L2, we have to
deeply inspect every single buffer to make sure that it is not sending
an unknown combination of command+arguments, or in other situations we
construct the command buffer in the driver.

>
> > I might be wrong, but GPU drivers do not deeply inspect the command
> > buffers to make sure that they do not use any feature not covered by
> > mesa.
>
> That's correct, but I don't think that's relevant. The GPU market has
> GLSL and Vulkan. An open-source compliant implementation will end up
> exercising a very very large part of the device ISA, command submission
> mechanism and synchronization primitives, if not all of it. There's
> little a vendor would keep under the hood and use in closed-source
> userspace only. For cameras, there's no standard userspace API that
> covers by design a very large part of what is the ISP equivalent of a

Libcamera supports Camera HAL3, gstreamer, v4l2, pipewire...

If we are afraid of vendors providing "toy" implemententations to pass
the openness requirements, we can add more features/tests to
libcamera.

And at the end of the day, there will be humans deciding if what a
vendor has provided is good enough or not.

> GPU ISA. Even "command buffers" are not a proper description of the
> parameters the vast majority of ISPs consume.

Modern ISPs are definitely going in the direction of "command buffers"


>
> > > > This approach would allow billions of users to access their hardwar=
e
> > > > more securely and with in-tree driver support. Our current stubborn
> > > > pursuit of an idealistic goal has already negatively impacted both
> > > > users and the ecosystem.
> > > >
> > > > The late wins, in my opinion, cannot scale to the consumer market, =
and
> > > > Linux will remain a niche market for ISPs.
> > > >
> > > > If such a hybrid model goes against Linux goals, this is something
> > > > that should be agreed upon by the whole community, so we have the s=
ame
> > > > criteria for all subsystems.
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

