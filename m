Return-Path: <linux-rdma+bounces-4024-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4CD93D660
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 17:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40CAB239B2
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989E217C20D;
	Fri, 26 Jul 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8BKMy4B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721D7494;
	Fri, 26 Jul 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008622; cv=none; b=eCKlz0KFfYBApqNP0jKtjt0ymwlx5aI03elZVrwx9estTN7MNLt65JanWuOt+IhAVqzKMlF6RxiWlPi/QBvzC6RipPMTCKLet1sdwp6KmALuWxKlXDqPMwHR0baZHEfiEQDV08K2E5RV8QR6AkTAYHMEr3ceaqSrtkHUU2hPApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008622; c=relaxed/simple;
	bh=vhTnl45JIHDD0H+tAzwiMG4CnPR+IcEAAcDnIULISvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHPO6Jhfr1Lr+Y8p3Kum+f1QvdVXtM73ZTjC+VNTnMtTRSk3v1gN/+w5od3wEYZNehfyBBOziUB/0J7337VNkH20gXdpDaOx7c4TcxSk2QBB0lQAyFTf41GysmPXJSnDicK0tg1x89EI6CQyrnG1QwZM+OwqLFd8VY6HMrSUHws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8BKMy4B; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-49299adf8adso671660137.2;
        Fri, 26 Jul 2024 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722008619; x=1722613419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhTnl45JIHDD0H+tAzwiMG4CnPR+IcEAAcDnIULISvU=;
        b=I8BKMy4B7Pae2yiKBnoU1sdoczwC20rYXqC/Ct2uF74i/H4qpwDgM4F4Awu4lG9Cbp
         NSxwAZK4Cm1gd0bcXUaB5EGIRXP0GqYXMwfx7V8a1AZ+bysDuPPmtkRWI4ceJVPdZQqS
         svkL2qQiqp2X9OSgko7k/JowDgaz9Vt/oChmLs9cBdg24+BRJ1HD0dJwMe8NWooQylmR
         +EOlEJSidNITTAU9hATSB8wxEn1toCdJAJ061WWA/CSnj84Onz9cvy9zWIV8niQ+iYDD
         JSXHzm1F7z4ftR37xT7FGgKP5z/Vr3JZq+mex2V+kaJc4NR09iQkzFNPw32p/0YxWe/1
         Dtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722008619; x=1722613419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhTnl45JIHDD0H+tAzwiMG4CnPR+IcEAAcDnIULISvU=;
        b=TfBb/dfmnO+IFeiOd7IKw+ewFVJbr24FrKw27f4Pn3WVIOU6h3VeDQV1/MfscFyEGR
         lHJbpRYZ5ENBl3eHRvfRqiYhgBsEDOag2YecLkewugG8Sxbo9wrcrGKKuynpqYn8RBz6
         nyE3rSCSCiOtnWMNsa/2mN7/y0LUmoNU3He7eZfSZxAV9FfsS+uRiWchoRMxWFtf1bjC
         LS1zB74FWGaLWStObwUykvcPFKagQd3979Igvgk0/KNixM9FR3ujjcjTLOAHloPdj3bn
         KDnk4GdFyWMLJY4s5Ir1+D6AHlm5RkRDC6jhW75B7C9GY3Em1lIiUy/yXRljY0iStACz
         AHtg==
X-Forwarded-Encrypted: i=1; AJvYcCVLG01BXZ+PgMvp5gHn+slehlgrgzzcT4gsJ7onz7Ywcbn5xcCk7OuDVCLLptMgLCRli59TATRaxacU1tBkyPL9eAyev/zspDp4BPj/3m4upqKJJRcpfGB3WRKKZdv4oj0pTF2Sz0E6/PkHrEgW+IuUgg4xseQjWM4X3DC2Fg==
X-Gm-Message-State: AOJu0YwOZZpIx8StHa5nQR2V5AnOLD1gsCeikDiteFPG3xin6ppuVmXU
	pQF3qsUr6GCrgsGK1Dfty+LZJnNQslzEdo9xOn5NIK1n8K4d3RAfXD5IQzP66yYNVxXP5KljyW5
	dcpT2KCMA1sRen7/e3U9hGLLstEw=
X-Google-Smtp-Source: AGHT+IEgQo/9wg7PiJi8ZpLJHpZAGc14Lovj6s9bfiax6cs4MvM80xVDooEjreFb4OJvgA72u2z/UC90dgENbs/poBI=
X-Received: by 2002:a05:6102:f96:b0:493:ce48:a2ed with SMTP id
 ada2fe7eead31-493fa46f02emr93862137.29.1722008619379; Fri, 26 Jul 2024
 08:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com> <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com> <20240725194314.GS3371438@nvidia.com>
 <20240725200703.GG14252@pendragon.ideasonboard.com> <CAPybu_0C44q+d33LN8yKGSyv6HKBMPNy0AG4LkCOqxc87w3WrQ@mail.gmail.com>
 <20240726124949.GI32300@pendragon.ideasonboard.com> <20240726131106.GW3371438@nvidia.com>
 <20240726142217.GF28621@pendragon.ideasonboard.com>
In-Reply-To: <20240726142217.GF28621@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 26 Jul 2024 17:43:21 +0200
Message-ID: <CAPybu_3+J-e-s2+3KV51Nc4Z1rys98xnN6p_0xXkdag-no09JQ@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jiri Kosina <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:22=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Jul 26, 2024 at 10:11:06AM -0300, Jason Gunthorpe wrote:
> > On Fri, Jul 26, 2024 at 03:49:49PM +0300, Laurent Pinchart wrote:
> >
> > > What is not an option exactly in my description above ? We have multi=
ple
> > > V4L2 drivers for ISPs. They receive ISP parameters from userspace
> > > through a data buffer. It's not allowed to be opaque, but it doesn't
> > > prevent vendor closed-source userspace implementations with additiona=
l
> > > *camera* features, as long as the *hardware* features are available t=
o
> > > everybody.
> >
> > How far do you take opaque?
> >
> > In mlx5 we pass command buffers from user to kernel to HW and the
> > kernel does only a little checking.
>
> I won't comment on the mlx5 case in particular, I don't have enough
> knowledge to do so.
>
> When it comes to validation of commands by the kernel, at the very least
> the kernel driver needs to be able to guarantee safety. For instance,
> that means that any command that can result in DMA operations need to be
> validated (e.g. verifying buffer addresses and sizes) and/or executed
> partly by the driver (e.g. mapping a buffer through an IOMMU), depending
> on hardware constraints.
>
> > There is a 12kloc file describing the layout of alot of commands:
> > include/linux/mlx5/mlx5_ifc.h
> >
> > There is an open PDF describing in detail some subset of this:
> > https://network.nvidia.com/files/doc-2020/ethernet-adapters-programming=
-manual.pdf
> >
> > There are in-kernel implementations driving most of those commands.
>
> For camera ISPs, most of the "commands" wouldn't be driven by the
> kernel. I don't have expectations when it comes to what commands the
> kernel exercises directly, I think that highly depends on the device
> type.
>
> > Other commands are only issued by userspace, and we have open source
> > DPDK, rdma-core and UCX implementations driving them.
> >
> > ie, this is really quite good as far as a device providing open source
> > solutions goes.
> >
> > However, no doubt there is more FW capability and commands than even
> > this vast amount documents - so lets guess that propritary code is
> > using this interface with unknown commands too.
> >
> > From a camera perspective would you be OK with that? Let's guess that
> > 90% of use cases are covered with fully open code. Do we also need to
> > forcefully close the door to an imagined 10% of proprietary cases just
> > to be sure open always wins?
>
> For command buffers interpreted by a firmware, it would be extremely
> difficult, if not impossible, to ensure that nothing undocumented is
> possible to access from userspace. I think we have two issues here, one
> of them is to define what we required to be openly accessible, and the
> other to avoid vendors cheating by claiming to be more open than they
> actually are.
>
> I believe the latter can't be solved technically. At the end of the day
> it's a matter of trust, and the only option I can see is to build that
> trust with the vendors, and to make it clear that breaches of trust will
> have consequences. A vendor that deliberately lies would end up on my
> personal backlist for as long as they don't implement structural
> solutions to be a better player in the ecosystem. What is acceptable as
> consequences is for the communities to decide. We have previously banned
> people or organizations from contributing to the kernel for certain
> periods of time (the University of Minnesota case comes to my mind for
> instance), and other options can be considered too.
>
> As for the first issue, I think it's a difficult one as it is very
> difficult to quantify the features covered by open implementations, as
> well as their importance. You could have a 99% open command set where
> the 1% would impact open implementations extremely negatively, the same
> way you could have a 50% open command set where the other 50% isn't of
> any use to anyone but the vendor (for instance used to debug the
> firmware implementation).

It is not that difficult. You just have to define what an acceptable
implementation is. Eg

- Sharpness at specific light.
- Time of convergence for the Auto algorithms
- Noise ratio

We could even use the SoftISP implementation as reference. Is this ISP
working better or worse than SoftISP?


>
> For cameras, the feature set can I believe be expressed in terms of ISP
> processing blocks that are usable by open implementations, as well as in
> terms of the type of usage of those features. For instance, is it
> acceptable that a vendor documents how to use 2D noise reduction but
> makes 3D (temporal) noise reduction available only to close-source
> userspace ? My personal answer is no. I want to aim for very close to
> 100% of the features, and certainly 100% of the "large" features. I can
> close my eyes on features that are very very niche, but what is niche
> today may not be tomorrow. For instance, if a camera ISP implements a
> feature used only for very specific camera sensors targetted at
> autonomous driving in a new generation of research prototypes that only
> one company has access to, I'll be inclined to ignore that. That
> technology may however become much more mainstream 5 years later.

We can update our requirements in 5 years. Nothing is written in stone.

Also it is much easier to reverse engineer an open driver, with an
open userspace and a closed userspace than a close driver with a
closed userspace.


>
> The other aspect is the type of usage of the features. For camera ISPs
> again, some parameters will be computed through a tuning process, and
> will be fixed for the lifetime of the camera. I want those parameters to
> be documented, to enable users to tune cameras for their own use cases.
> This is less important in some market segments, such as laptops for
> instance, but is crucial for embedded devices. This is an area where
> I've previously been called unreasonable, and I don't think that's fair.
> The tuned-and-immutable parameters are not plentiful, as most of the
> tuning results in data that needs to be combined with runtime
> information to compute ISP parameters, so the "this is for tuning only"
> argument doesn't hold as much as one may think. For real immutable
> parameters, a large number of them are related to image processing steps
> that are very common and found in most ISPs, such as lens shading
> correction or geometric distorsion correction. I don't see why we should
> let vendors keep those closed.


We don't have enough leverage for that kind of requirement.

To be fair, we do not ask touchscreen manufacturers to document their
calibration files. Nor any other calibration file in the kernel.

The calibration file for me is like a firmware blob.



>
> I'm sorry that this discussion is turning into something very
> camera-centric, but that's the relevant area I know best. I hope that
> discussing problems related to device pass-through in different areas in
> the open will help build a wider shared understanding of the problems,
> and hopefully help designing solutions by better taking into account the
> various aspects of the issues.
>
> > Does closing the door have to come at the cost of a technically clean
> > solution? Doing validation in the kernel to enforce an ideological
> > position would severely degrade mlx5, and would probably never really
> > be robust.
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

