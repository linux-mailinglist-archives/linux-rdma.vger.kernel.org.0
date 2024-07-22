Return-Path: <linux-rdma+bounces-3921-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E89F0938D98
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213121C2100A
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 10:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7616C69D;
	Mon, 22 Jul 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwBbXJ+f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8DC16A399;
	Mon, 22 Jul 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644992; cv=none; b=IMV0NLKlcLih4w+Nbeocg4EUXxSniND4E3KVBXkhC5OXaiRizFoKxlquMu/byJya2shjFZ9qvuqZS892Hw03iQjtzu9CTmfy3Mlcq5HmfpFodMSDCnELrckQfTSaug1jtF+67OhYDrQRAHpMMA1hImQTSuHiP3wVf8JZcl7SJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644992; c=relaxed/simple;
	bh=i2aicMWrmaQuMvS/7Vlq9vUnRfVdITWeWRbf7ny+PJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7ZJY6pS3Rs/rQnK5cRiqcW017ba4ZPnst17Y9cldT6SX1wBu99PIohDk5MmVMjEhlEcVCjNkYQsE3mAe8DFLPGKgq2r+jUDyDfQiYCtytNgwKdcrL5Jey2b9Cn5CGGf9sX98HTL9GEVNkXLlVxgZEgkdkYmxlssHGIMJk+IOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwBbXJ+f; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-82c30468266so168531241.0;
        Mon, 22 Jul 2024 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721644990; x=1722249790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2aicMWrmaQuMvS/7Vlq9vUnRfVdITWeWRbf7ny+PJ4=;
        b=kwBbXJ+fiLADZ7/A6BSSKi8Y5mNZIkErKV0Qy4mGd8AL2+akIhTJ0hdHaq/dYslX+6
         MW22RhLg34PDFvFbrMmwKeIzaYTB8C98QILsGrJ5XYe8ae6H/wrfQvV7M74lwlHzMQdO
         H6w/xdzaCLI8EgUWTeZJQx1Kzhs56KB5vuwczy5EgwVtOWtkz4vxWYeHZI6/ZE0zai2J
         GuWlQDcpQ+CCfmq2Hxr16E0MvXqPlK4zi19ulmTve9gEE41/8k2g2U5bAI+joulnqUFf
         +ZNM/cVV+eCRNFMNVbe5USl0MQp6XSJocmmqx3QKvrcUX+WaftAeYrBDTqkgGtQ2lSJA
         lx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721644990; x=1722249790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2aicMWrmaQuMvS/7Vlq9vUnRfVdITWeWRbf7ny+PJ4=;
        b=KQPV8eEwjQ/QAil6YbC9fVrj0gNa9a10FqkpG4OyKwxIOl2EH75eiiA+tnlGTun3eo
         Pudb9VXQKGGYy8YaoHVi5T/gxiX2nCswNopLqO1OZo5WQH+3Xf6RAqMVf3ud8MVzZe2h
         ROSeCeJcY65vNIJwlr0UFMa3z+55loAyeRaAhsoGgroOfAVqNC7kgDFj4uzfi90dtEFN
         QeUhF7Gh04fnwbvOOhUdkgONnDhWPbo7p1vqa7UcpmF827zquiL6pKqVL3uoF8WCDz2I
         o3QBIJmrX0cUMzo9W8GpuRZT73jf2S00jDDYKD1Wl8POSVKcHLr4GW3Xl09Q/9roUdZF
         Wo7A==
X-Forwarded-Encrypted: i=1; AJvYcCWdD6zrEMq9Y8Mcb7RFgsr5xUtksP5KHuIVciOQqDRCoydYzJmaCgPuv5XIM6FFz5TeayOeIe/pUgX4UcQZf6YelhCN0o+rv92nMUPHajJPe0V6C9Pw6Ls8w5pOIAQM0/BO7Z9/K3XnpDB8qzFWWBOKTZodkCjl46NMoR1XtQ==
X-Gm-Message-State: AOJu0YwoAN+v84Ke6A3HVxMTXIy5cAhwGBrQ5wpY64CnFIsiBTpArHl1
	7PL2adw/51cbI9t+ioEKMHqaIyZo90m4/6wZYdFWQNDBbKZDb6+b8bjM5I49a0wqVjwTCwaPKVP
	hY+/4qMUYnoH+crsxDAk9wKwabgs=
X-Google-Smtp-Source: AGHT+IFhScItchLF1iJqQ4iYhnptQKfT2dckty3sGEo+32YHCTWlDw7U1UawqMZL5QB26JIAFxLk/CC80jRRXwZTRGE=
X-Received: by 2002:a05:6102:809a:b0:48f:4bba:778c with SMTP id
 ada2fe7eead31-49283dfaf76mr8861012137.8.1721644990072; Mon, 22 Jul 2024
 03:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch> <20240721192530.GD23783@pendragon.ideasonboard.com>
In-Reply-To: <20240721192530.GD23783@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 22 Jul 2024 12:42:52 +0200
Message-ID: <CAPybu_2tUmYtNiSExNGpsxcF=7EO+ZHR8eGammBsg8iFh3B3wg@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 9:25=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Jul 09, 2024 at 03:15:13PM -0700, Dan Williams wrote:
> > James Bottomley wrote:
> > > > The upstream discussion has yielded the full spectrum of positions =
on
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
> > I do not want to speak for others on the saliency of their points, all =
I
> > can say is that the contrary positions have so far not moved me to drop
> > consideration of fwctl for CXL.
> >
> > Where CXL has a Command Effects Log that is a reasonable protocol for
> > making decisions about opaque command codes, and that CXL already has a
> > few years of experience with the commands that *do* need a Linux-comman=
d
> > wrapper.
> >
> > Some open questions from that thread are: what does it mean for the fat=
e
> > of a proposal if one subsystem Acks the ABI and another Naks it for a
> > device that crosses subsystem functionality? Would a cynical hardware
> > response just lead to plumbing an NVME admin queue, or CXL mailbox to
> > get device-specific commands past another subsystem's objection?
>
> My default answer would be to trust the maintainers of the relevant
> subsystems (or try to convince them when you disagree :-)). Not only
> should they know the technical implications best, they should also have
> a good view of the whole vertical stack, and the implications of
> pass-through for their ecosystem. This may result in a single NAK
> overriding ACKs, but we could also try to find technical solutions when
> we'll face such issues, to enforce different sets of rules for the
> different functions of a device.
>
> Subsystem hopping is something we're recently noticed for camera ISPs,
> where a vendor wanted to move from V4L2 to DRM. Technical reasons for
> doing so were given, and they were (in my opinion) rather excuses. The
> unspoken real (again in my opinion) reason was to avoid documenting the
> firmware interface and ship userspace binary blobs with no way for free
> software to use all the device's features. That's something we have been
> fighting against for years, trying to convince vendors that they can
> provide better and more open camera support without the world
> collapsing, with increasing success recently. Saying amen to
> pass-through in this case would be a huge step back that would hurt
> users and the whole ecosystem in the short and long term.

In my view, DRM is a more suitable model for complex ISPs than V4L2:

- Userspace Complexity: ISPs demand a highly complex and evolving API,
similar to Vulkan or OpenGL. Applications typically need a framework
like libcamera to utilize ISPs effectively, much like Mesa for
graphics cards.

- Lack of Standardization: There's no universal standard for ISPs;
each vendor implements unique features and usage patterns. DRM
addresses this through vendor-specific IOCTLs

- Proprietary Architectures: Vendors often don't fully disclose their
hardware architectures. DRM cleverly only necessitates a Mesa
implementation, not comprehensive documentation.


Our current approach of pushing back against vendors, instead of
seeking compromise, has resulted in the vast majority of the market
(99% if not more) relying on out-of-tree drivers. This leaves users
with no options for utilizing their cameras outside of Android.

DRM allows a hybrid model, where:
- Open Source Foundation: Standard use cases are covered by a fully
open-source stack.
- Vendor Differentiation: Vendors retain the freedom to implement
proprietary features (e.g., automatic makeup) as closed source.

This approach would allow billions of users to access their hardware
more securely and with in-tree driver support. Our current stubborn
pursuit of an idealistic goal has already negatively impacted both
users and the ecosystem.

The late wins, in my opinion, cannot scale to the consumer market, and
Linux will remain a niche market for ISPs.


If such a hybrid model goes against Linux goals, this is something
that should be agreed upon by the whole community, so we have the same
criteria for all subsystems.



--
Ricardo Ribalda

