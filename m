Return-Path: <linux-rdma+bounces-4004-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215E93CF28
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 10:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37AC282E80
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CCE17624C;
	Fri, 26 Jul 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWTmiO09"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17818628;
	Fri, 26 Jul 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980967; cv=none; b=eeUMoLgaE8ePt7MNngJn+qrJFkx2ov54L15qrzM3/7HPJdJexe+l13FWZGEONxvxK+JfjfLQN0Kc3smYDS+KU4v7UQ90wmlcoVti890/b0KHH+37Ymeg3Yb+ftAwNg+Ow/7ZkMki6SF1323qEzb3J6iz9LM22kp3/fiCq6R34Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980967; c=relaxed/simple;
	bh=yfgwK2MPXVPzVUi1QrklU0n+NaMJDWAqlb2j6JLPwqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1s5dXvWrz1qKS/Dzu0STRFx+veHOBdNnhdVjvzrV24C1iO97yR+cQCWUqiXf3HtIwKwo/ELZYDFPCcMdOUNKBsU8p9QupSnJ3+IwhItvHXG1DFXhmg9z/7wNCm2EB/Usw+sxdID8ZBlv9+z2L3tJRnwl5DOqQJehQTrCjYmGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWTmiO09; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f52a3938bbso186707e0c.0;
        Fri, 26 Jul 2024 01:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721980965; x=1722585765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfgwK2MPXVPzVUi1QrklU0n+NaMJDWAqlb2j6JLPwqQ=;
        b=LWTmiO09vlfCxt7CCy+KPXvX3rF5BHqxxCmJEaWsMv6NKbAHpk8hSkp7eweHA5wIqD
         OBOmUhBhZ+ZniEuChJJINkLaTfHb9Ih0uiYmDlMcPQ+uW7xev4BGnHZveAlGTXf7xllR
         Do9+zem1a2eTGHdwbVHL7BUPPGzBfUuMZE4RbZAGYiMuP5g8aBL+n9YfZepv10AMWjFz
         d9ymuBEfE7APhqclsXP9ONm8VLCuzzqjqECTFShaZUIIFOal1wbzCNb6HWM6sK+h08iM
         zRIBQv9gpeqc6bkCciBm1yZGuU5mc6l0Wd6/xmqmRLNhGeFpSeclz8TX0q2P4YXXuQxE
         SU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980965; x=1722585765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfgwK2MPXVPzVUi1QrklU0n+NaMJDWAqlb2j6JLPwqQ=;
        b=jZmROXjMfSnk/3/tGiAwp1Lia1HQ8leJfpNGcpkbU0oi3sUZnDDk6h6jxunNWYMujM
         fU8RHTWWi3kJjmRfl/i76A6ShJERRoU3o3i3K9+ZNqyyPWdmWZUrxOWWefzBpz1qAAQX
         dN8dqm1p+82fJJ7l8FDFlYRPsaWmI+vmcTVoQcWUCh0y5GTc829CX8EYW6e+yEVWpdJc
         bclZN6vf7SnnV/mkWg0Fv9uq+dtovRGp6kJeZx1sGZgY5ZmKbcevOd3B+rL/ujJJWLsF
         NTtkUPqXmv+y5ABDbBxmvIdGM0u7Nal6XI5QQ7hj+E5fEB+eXHz5VNLXSjl8lx344670
         8ETQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/CLsUewnGdMUXO3KSX8JxFQheieiz6c57IrrQ6sako9ivGRTh+V7OnSgSuJKThv2U6isq7hOpPYafxm8H1uR6P8a6D7K/D/SofEUzK/WaXyunLNFiImQabwylA4DTNel2FZL280TIokfMpTSX819AhBCDoeErT1yxmYBoaA==
X-Gm-Message-State: AOJu0Ywx9xDZ3ZhLE6Mc78VHNAWwga6NvXgYa5l7cKyzrLfLXF0K3YQn
	c24qm1WaP9Nb0YADlTo2NzHg59WAgBhqqLeV1Jf+75RkHcfCZI0SBmorfvhcJhTI4RQBJdhBDBq
	Wu2M459exXOJ+bqaSnAA6dV99qfg=
X-Google-Smtp-Source: AGHT+IH3vefarYAZ/LsPSJn7jwW/U5kg8LXSCMGlYNggHO0vlTKn1Wit/j3vZJj1yMX4xhY6+QlvWN5uAgd5lNw6Rgw=
X-Received: by 2002:a05:6122:2901:b0:4f3:207a:c664 with SMTP id
 71dfb90a1353d-4f6c5c9455bmr6308946e0c.14.1721980964874; Fri, 26 Jul 2024
 01:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm> <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com> <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
 <20240725122315.GE7022@unreal> <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
 <20240725132035.GF7022@unreal> <20240725194202.GE14252@pendragon.ideasonboard.com>
In-Reply-To: <20240725194202.GE14252@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 26 Jul 2024 10:02:27 +0200
Message-ID: <CAPybu_3T8JNkZxf3pgCo4E4VJ3AZvY7NzeXdd7w9Qqe8=eV=9A@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Leon Romanovsky <leon@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jiri Kosina <jikos@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent

On Thu, Jul 25, 2024 at 9:44=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Jul 25, 2024 at 04:20:35PM +0300, Leon Romanovsky wrote:
> > On Thu, Jul 25, 2024 at 03:02:13PM +0200, Ricardo Ribalda Delgado wrote=
:
> > > On Thu, Jul 25, 2024 at 2:23=E2=80=AFPM Leon Romanovsky wrote:
> > > > On Thu, Jul 25, 2024 at 11:26:38AM +0200, Ricardo Ribalda Delgado w=
rote:
> > > > > On Wed, Jul 24, 2024 at 10:02=E2=80=AFPM Laurent Pinchart wrote:
> > > >
> > > > <...>
> > > >
> > > > > It would be great to define what are the free software communitie=
s
> > > > > here. Distros and final users are also "free software communities=
" and
> > > > > they do not care about niche use cases covered by proprietary
> > > > > software.
> > > >
> > > > Are you certain about that?
> > >
> > > As a user, and as an open source Distro developer I have a small hint=
.
> > > But you could also ask users what they think about not being able to
> > > use their notebook's cameras. The last time that I could not use some
> > > basic hardware from a notebook with Linux was 20 years ago.
> >
> > Lucky you, I still have consumer hardware (speaker) that doesn't work
> > with Linux, and even now, there is basic hardware in my current
> > laptop (HP docking station) that doesn't work reliably in Linux.
> >
> > > > > They only care (and should care) about normal workflows.
> > > >
> > > > What is a normal workflow?
> > > > Does it mean that if user bought something very expensive he
> > > > should not be able to use it with free software, because his
> > > > usage is different from yours?
> > > >
> > > > Thanks
> > >
> > > It means that we should not block the standard usage for 99% of the
> > > population just because 1% of the users cannot do something fancy wit=
h
> > > their device.
> >
> > Right, the problem is that in some areas the statistics slightly differ=
ent.
> > 99% population is blocked because 1% of the users don't need it and
> > don't think that it is "normal" flow.
> >
> > > Let me give you an example. When I buy a camera I want to be able to
> > > do Video Conferencing and take some static photos of documents. I do
> > > not care about: automatic makeup, AI generated background, unicorn
> > > filters, eyes recentering... But we need to give a way to vendors to
> > > implement those things closely, without the marketing differentiators=
,
> > > vendors have zero incentive to invest in Linux, and that affects all
> > > the population.
>
> I've seen these kind of examples being repeatedly given in discussions
> related to camera ISP support in Linux. They are very misleading. These
> are not the kind of features that are relevant for the device
> pass-through discussion these day. Those are high-level use cases
> implemented in userspace, and vendors can ship any closed-source
> binaries they want there. What I care about is the features exposed by
> the kernel to userspace API.

The ISPs are gradually becoming programmable devices and they indeed
help during all of those examples.

Userspace needs to send/receive information from the ISP, and that is
exactly what vendors want to keep in the close.

Describing how they implement those algorithms is a patent minefield
and their differentiating factor.

>
> > > This challenge seems to be solved for GPUs. I am using my AMD GPU
> > > freely and my nephew can install the amdgpu-pro proprietary user spac=
e
> > > driver to play duke nukem (or whatever kids play now) at 2000 fps.
> > >
> > > There are other other subsystems that allow vendor passthrough and
> > > their ecosystem has not collapsed.
> >
> > Yes, I completely agree with you on that.
> >
> > > Can we have some general guidance of what is acceptable? Can we defin=
e
> > > together the "normal workflow" and focus on a *full* open source
> > > implementation of that?
> >
> > I don't think that is possible to define "normal workflow". Requirement
> > to have open-source counterpart to everything exposed through UAPI is a
> > valid one. I'm all for that.
>
> That's my current opinion as well, as least when it comes to the kernel
> areas I mostly work with.
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Ricardo Ribalda

