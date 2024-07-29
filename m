Return-Path: <linux-rdma+bounces-4061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F47093F201
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 11:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92916B23C85
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20A143C6F;
	Mon, 29 Jul 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYVRQXQI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144A31448C6;
	Mon, 29 Jul 2024 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247065; cv=none; b=EYDTa074T+isDPcVaVdQqRqN0e83ORsRGW0qQ98dfK9opiNTtp9wenuize6xb10GUwltpKMXlZiDqDfRLKsOfnDd1IFNQal6vUPzD+sJai+8SyetsxvCtCyLs++Tlgx5H8QWi45aT52ht8spIWw+3/DCgb84bEieUMK75IhiWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247065; c=relaxed/simple;
	bh=JqcDExkQZtJTDVurvD9ArJW4AkQVdzzoc+bgMSZdQJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQd4GqZubZY6jpM/1toxl9CkqJ5J8IFQ8OlPxiNHnfBRuvyrX5zFRYCVCvrf+F7AKwnyLUjxYu1KMhmwmdgUJp4Ph1oNsPTSh3zs4ZZvpuJzWiXrCnqQicohGoRZtwyLwdJVDNCWHaNFfPshPpp9FPXsBOAnpZMBMTUc3Fu2huc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYVRQXQI; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f50dd3eab9so1067413e0c.1;
        Mon, 29 Jul 2024 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722247063; x=1722851863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqcDExkQZtJTDVurvD9ArJW4AkQVdzzoc+bgMSZdQJQ=;
        b=FYVRQXQIhpgvlOsGz9qzkfkMqUfxVeh/LWcsfzBhJEhPYxu729HeVvNyj5liSqbEum
         nVPtgJOkwLtieS45KlzbHS+nmlsPk3vCN9pZUUFoCbI2z8DQg4OHjjNprqlbqP/jwotz
         uzI75le6gEWvjGrqgPM+O1DkCmoeF6ZrIJrKQ6PtVTzVAqO0tutDw90s5GSVvd1ZHebR
         X+AAocMTNEffY3ImxE8kfEN3yUCb3MoPt0lr1ntG5Z7Fjz6XpWWes8BCby7lpzO7bzxA
         8XcAEffheVdFAzdSuYsZ9CQdLLutaVesbw8AmCpNRSVcJwdtHg7kKd15Sb67/R/IWA4R
         FvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722247063; x=1722851863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqcDExkQZtJTDVurvD9ArJW4AkQVdzzoc+bgMSZdQJQ=;
        b=Iv9NeBdgLALdagYMV0exGtHBAgEEyomsaopo85zQHfDJ7Lg9p9qFmzbJ4qtPq1CMgX
         u+qgJONhEJcKQxQoglNbV0809UgBJ4YXQXMvQl4R/OP8kiQ1zO9IP4tNykZxvQuDupGE
         M3VrTv6LG4xaarWdb9jSdUB+Y6PdEzLie27RgnUTHU6yznQI5jt/4vcSZ2Uv6C+zWvAe
         0E4KB9NW5lqQryidUG6Jr4Dq4KD8QqAhZVPGJYmUNaILNxA9piIaAQzDvdAhFSK8/mFN
         bWGcme5ooJUvaEpmImnC05HzIQcCHEXuCVsOdn6wrCe+YwtLtHwsOqUDps/JTvuhtXuH
         hlyg==
X-Forwarded-Encrypted: i=1; AJvYcCUUPlByPO/U/0/Kem25ywv/cQoB4l1ESX8vu+hwG5TjfpjCbO6TGaIW9Gg20CYV8W/PXSrp7ngwIZsJDmt54M/jjbHEMxSmBivXk6/ggTpu19DnvYl13QjFbTTtJ7vaZQk/Er0c8Tuc2UF7LKU5IbZdmDQgrNe/ECR12q8xEw==
X-Gm-Message-State: AOJu0YzC9uYGE2T0xA+qQ8s/IU9gHDCD6LSrGzAVB1lNBFnU6MxSy8An
	E9M1gIR95Q3mcKqWUsEF0Xi4TEoNWQ625LCLkVc6Eop1xp81FfcZrFVA6sCcYwjfak6LyET7DLf
	QFvID0QFGV1Tgd1sCWKZtl51alY0=
X-Google-Smtp-Source: AGHT+IHsjpDawESGxmKbCK2z+BLTQAoL6pYIbhvdXMo/2gPdtKxaVhd5G4+Ba3TocPKBd5+k4kJ/t4vCYihpRJw9CP4=
X-Received: by 2002:a05:6102:3050:b0:48f:a858:2b52 with SMTP id
 ada2fe7eead31-493fad9af5cmr7268350137.29.1722247062886; Mon, 29 Jul 2024
 02:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com> <20240725194314.GS3371438@nvidia.com>
 <20240725200703.GG14252@pendragon.ideasonboard.com> <CAPybu_0C44q+d33LN8yKGSyv6HKBMPNy0AG4LkCOqxc87w3WrQ@mail.gmail.com>
 <20240726124949.GI32300@pendragon.ideasonboard.com> <20240726131106.GW3371438@nvidia.com>
 <20240726142217.GF28621@pendragon.ideasonboard.com> <CAPybu_3+J-e-s2+3KV51Nc4Z1rys98xnN6p_0xXkdag-no09JQ@mail.gmail.com>
 <20240728152509.GC30973@pendragon.ideasonboard.com>
In-Reply-To: <20240728152509.GC30973@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 29 Jul 2024 11:57:25 +0200
Message-ID: <CAPybu_28xdSSz43wd+yY25_0SbGUBPOpgbKhknUoibbNiQBQfg@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jiri Kosina <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 5:25=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Jul 26, 2024 at 05:43:21PM +0200, Ricardo Ribalda Delgado wrote:
> > On Fri, Jul 26, 2024 at 4:22=E2=80=AFPM Laurent Pinchart wrote:
> > > On Fri, Jul 26, 2024 at 10:11:06AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Jul 26, 2024 at 03:49:49PM +0300, Laurent Pinchart wrote:
> > > >
> > > > > What is not an option exactly in my description above ? We have m=
ultiple
> > > > > V4L2 drivers for ISPs. They receive ISP parameters from userspace
> > > > > through a data buffer. It's not allowed to be opaque, but it does=
n't
> > > > > prevent vendor closed-source userspace implementations with addit=
ional
> > > > > *camera* features, as long as the *hardware* features are availab=
le to
> > > > > everybody.
> > > >
> > > > How far do you take opaque?
> > > >
> > > > In mlx5 we pass command buffers from user to kernel to HW and the
> > > > kernel does only a little checking.
> > >
> > > I won't comment on the mlx5 case in particular, I don't have enough
> > > knowledge to do so.
> > >
> > > When it comes to validation of commands by the kernel, at the very le=
ast
> > > the kernel driver needs to be able to guarantee safety. For instance,
> > > that means that any command that can result in DMA operations need to=
 be
> > > validated (e.g. verifying buffer addresses and sizes) and/or executed
> > > partly by the driver (e.g. mapping a buffer through an IOMMU), depend=
ing
> > > on hardware constraints.
> > >
> > > > There is a 12kloc file describing the layout of alot of commands:
> > > > include/linux/mlx5/mlx5_ifc.h
> > > >
> > > > There is an open PDF describing in detail some subset of this:
> > > > https://network.nvidia.com/files/doc-2020/ethernet-adapters-program=
ming-manual.pdf
> > > >
> > > > There are in-kernel implementations driving most of those commands.
> > >
> > > For camera ISPs, most of the "commands" wouldn't be driven by the
> > > kernel. I don't have expectations when it comes to what commands the
> > > kernel exercises directly, I think that highly depends on the device
> > > type.
> > >
> > > > Other commands are only issued by userspace, and we have open sourc=
e
> > > > DPDK, rdma-core and UCX implementations driving them.
> > > >
> > > > ie, this is really quite good as far as a device providing open sou=
rce
> > > > solutions goes.
> > > >
> > > > However, no doubt there is more FW capability and commands than eve=
n
> > > > this vast amount documents - so lets guess that propritary code is
> > > > using this interface with unknown commands too.
> > > >
> > > > From a camera perspective would you be OK with that? Let's guess th=
at
> > > > 90% of use cases are covered with fully open code. Do we also need =
to
> > > > forcefully close the door to an imagined 10% of proprietary cases j=
ust
> > > > to be sure open always wins?
> > >
> > > For command buffers interpreted by a firmware, it would be extremely
> > > difficult, if not impossible, to ensure that nothing undocumented is
> > > possible to access from userspace. I think we have two issues here, o=
ne
> > > of them is to define what we required to be openly accessible, and th=
e
> > > other to avoid vendors cheating by claiming to be more open than they
> > > actually are.
> > >
> > > I believe the latter can't be solved technically. At the end of the d=
ay
> > > it's a matter of trust, and the only option I can see is to build tha=
t
> > > trust with the vendors, and to make it clear that breaches of trust w=
ill
> > > have consequences. A vendor that deliberately lies would end up on my
> > > personal backlist for as long as they don't implement structural
> > > solutions to be a better player in the ecosystem. What is acceptable =
as
> > > consequences is for the communities to decide. We have previously ban=
ned
> > > people or organizations from contributing to the kernel for certain
> > > periods of time (the University of Minnesota case comes to my mind fo=
r
> > > instance), and other options can be considered too.
> > >
> > > As for the first issue, I think it's a difficult one as it is very
> > > difficult to quantify the features covered by open implementations, a=
s
> > > well as their importance. You could have a 99% open command set where
> > > the 1% would impact open implementations extremely negatively, the sa=
me
> > > way you could have a 50% open command set where the other 50% isn't o=
f
> > > any use to anyone but the vendor (for instance used to debug the
> > > firmware implementation).
> >
> > It is not that difficult. You just have to define what an acceptable
> > implementation is. Eg
> >
> > - Sharpness at specific light.
> > - Time of convergence for the Auto algorithms
> > - Noise ratio
>
> Those may just be bad examples, but I think they showcase how little
> these discussions are based on technical expertise and facts. Just

Could you perhaps provide better examples of what are good objective
characteristics of an open implementation. ?

Those characteristics have been directly extracted from actual OS
certification requirements for Camera stacks.

> singling out one example, the convergence time is driven by the
> userspace implementation of the ISP control algorithms. That is *not*
> something we want to force vendors to disclose. It isn't related to the
> ISP parameters and the UAPI the driver exposes to userspace.

I am not talking about the driver UAPI. I am saying that the Open
implementation provided by vendors to land their code must not be a
"toy" implementation, but have good characteristics.

You said yourself that with the "new rules" we also demand a reference
open ISP control algorithm.

Would you be OK with an open algorithm that cannot converge in a
reasonable time? I hope not.


>
> > We could even use the SoftISP implementation as reference. Is this ISP
> > working better or worse than SoftISP?
> >
> > > For cameras, the feature set can I believe be expressed in terms of I=
SP
> > > processing blocks that are usable by open implementations, as well as=
 in
> > > terms of the type of usage of those features. For instance, is it
> > > acceptable that a vendor documents how to use 2D noise reduction but
> > > makes 3D (temporal) noise reduction available only to close-source
> > > userspace ? My personal answer is no. I want to aim for very close to
> > > 100% of the features, and certainly 100% of the "large" features. I c=
an
> > > close my eyes on features that are very very niche, but what is niche
> > > today may not be tomorrow. For instance, if a camera ISP implements a
> > > feature used only for very specific camera sensors targetted at
> > > autonomous driving in a new generation of research prototypes that on=
ly
> > > one company has access to, I'll be inclined to ignore that. That
> > > technology may however become much more mainstream 5 years later.
> >
> > We can update our requirements in 5 years. Nothing is written in stone.
>
> That at least we agree on :-)
>
> > Also it is much easier to reverse engineer an open driver, with an
> > open userspace and a closed userspace than a close driver with a
> > closed userspace.
>
> Closed kernel drivers are a GPL violation. Do you have any example, or
> do you mean out-of-tree drivers ? I don't think out-of-tree vs. mainline

I am not a lawyer, so I am not capable of discussing violations of any Lice=
nse.

I mean close and out-of-tree. Just two name two well known drivers
with a binary blob:
- fgrlx
- nvidia proprietary.

> drivers would make much difference when it comes to reverse engineering,
> if the mainline driver is just a pass-through driver.

If you have an usable open source camera stack, reverse engineering
the userspace closed implementation should not be a big challenge.

>
> > > The other aspect is the type of usage of the features. For camera ISP=
s
> > > again, some parameters will be computed through a tuning process, and
> > > will be fixed for the lifetime of the camera. I want those parameters=
 to
> > > be documented, to enable users to tune cameras for their own use case=
s.
> > > This is less important in some market segments, such as laptops for
> > > instance, but is crucial for embedded devices. This is an area where
> > > I've previously been called unreasonable, and I don't think that's fa=
ir.
> > > The tuned-and-immutable parameters are not plentiful, as most of the
> > > tuning results in data that needs to be combined with runtime
> > > information to compute ISP parameters, so the "this is for tuning onl=
y"
> > > argument doesn't hold as much as one may think. For real immutable
> > > parameters, a large number of them are related to image processing st=
eps
> > > that are very common and found in most ISPs, such as lens shading
> > > correction or geometric distorsion correction. I don't see why we sho=
uld
> > > let vendors keep those closed.
> >
> > We don't have enough leverage for that kind of requirement.
>
> I very much disagree with that.
>
> > To be fair, we do not ask touchscreen manufacturers to document their
> > calibration files. Nor any other calibration file in the kernel.
> >
> > The calibration file for me is like a firmware blob.
>
> It may be for you, but I don't think it is an accurate description for
> the rest of the industry.

Can you define who the industry is here?

In my job I have visibility on who and how they create that
calibration file, and the release cycle is identical to the firmware.

>
> > > I'm sorry that this discussion is turning into something very
> > > camera-centric, but that's the relevant area I know best. I hope that
> > > discussing problems related to device pass-through in different areas=
 in
> > > the open will help build a wider shared understanding of the problems=
,
> > > and hopefully help designing solutions by better taking into account =
the
> > > various aspects of the issues.
> > >
> > > > Does closing the door have to come at the cost of a technically cle=
an
> > > > solution? Doing validation in the kernel to enforce an ideological
> > > > position would severely degrade mlx5, and would probably never real=
ly
> > > > be robust.
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Ricardo Ribalda

