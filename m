Return-Path: <linux-rdma+bounces-4023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EBB93D657
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 17:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDD51F24C4C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA717BB3A;
	Fri, 26 Jul 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYf+tYcH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E11BC46;
	Fri, 26 Jul 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008470; cv=none; b=jSLtI+swlrYt4nQbn/jRSTT/ucpA5I+/wvPFemF4rxFaiZ6clMVAOgBGzPPyFtx4Z7BvMHnl70+9XW32JRjqSle7265KMPA6rdV0L6VuhIWZZejRO94SGZEIW0k5lapd2vz1PapjdB1DcGQjpfOeefzYG38yztpgO12zoR4LzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008470; c=relaxed/simple;
	bh=+m9x2lcJKmFscPw/9L4WK4+WahMLKs9QvMZUOIPxGMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX6w48MeCDITtDM0oyXLvIQCN6TumaFjSXBItA2AFLDP8FWL/a5RBLUrbH2XeRrcqcCSVYp78Y2cCWQn2MOLY1zFcwlbLhIH7lSEORgBhfmH8N+arj1rn24hb/oc6sBEbgaPorZKz9Xn0FGqyjRelXty5XuOs59tFDvVDggTPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYf+tYcH; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-825809a4decso275358241.0;
        Fri, 26 Jul 2024 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722008468; x=1722613268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+m9x2lcJKmFscPw/9L4WK4+WahMLKs9QvMZUOIPxGMg=;
        b=dYf+tYcHYD0bS/dKoPFga+I7uRqYaqzafFnHmuavzxBRmeE/UyMJbKe1srv9Udv3Z/
         Ff5OCHDWqXJ3cQIXwRV4ZLpkNMeqaE79hwwL9XH2SS59xe2SLQt69HLAb+C+mLYzSeh8
         N1SXAkIF6OOj0jRwYEcOKNjHLy4wHi1Z3avhjxDcz9hwgWISHaSxDvnZHqnjteWUxUJ9
         alBxGiEcYQs3aKv5emzrybJFduOz/6RN/vUE6eMOGvitnQbXBztOu1Pga9F1rYDWT7BE
         xCc3MfsldNtimATjWrWVAM8C1KGtM4HeQ9zVyvhKzuekwrhNh0V7dlOyr3jZpp3Psf0Z
         blrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722008468; x=1722613268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m9x2lcJKmFscPw/9L4WK4+WahMLKs9QvMZUOIPxGMg=;
        b=HxY7Yg5N/ADLZF3bnjcPhFe6y8oRPSyRm2U5rmRuz3YBwVzH6oOy4u1SQvt2lvVjDN
         Z7173l7+4pCng0tHRcjV0qQoT02ZMiIFxKlCbF8pg3q/8eb54Nlfzv9AfjXBDbESPF1F
         GDN14UdjUN199i/UkQHbgxJYGXN4hBbZsa0l0mdmRZUV4Cg7aMbLk5oi06NIw7Olaq5Z
         mHDhMK84cVw8TRCTtmqQBy/7e3ZTXmbZHzJe4vL2GjvE0K9XN36wf59tk0quvHXDopUU
         LzdcCTltRtOWsN93dUixtijL48Ek55r+pNP0MvLrmqe9/rUjFXMan/Haqn/7g+0Fwhbz
         TBPA==
X-Forwarded-Encrypted: i=1; AJvYcCV2WcFtc5cCTXeKqaWkr2ajZw483xXMyTv5dphCK6vwMJQ4lSVMpxzh3z2PeTdi32hwKf9EsQ5o1evf7vuyEXcE/JPHfhVs33LBvNt1kRn3F+xGEdBAeunMnAIu+aGqs7QlVSFSpNPSzb93YVkzMSptY5AYdeI9FVE7ajvd2w==
X-Gm-Message-State: AOJu0Yy9B5U8SjEzLyOtCd46HQ2It78R2KCrVEfEru9KoBHQet1e9mQq
	2kj9vPy+vdY/IM3o7J8qwmue6556JutdexApubXM9S1+HENmOifP7J2Hi0193V/bQoVvE7BxnOw
	Upd/Kh2LHVlMJ6TPQ9HCFfO3QMdA=
X-Google-Smtp-Source: AGHT+IEIIg66IecM+6lEWsGJgeICrY3+CjQGH9NUCEAv6vWv8s9rAshSONg/Ak9ihQ0DSZvfIRGMhFGCI3VQ9cTgx04=
X-Received: by 2002:a05:6102:dca:b0:48f:e8c6:7c53 with SMTP id
 ada2fe7eead31-493fadc7a4bmr7313137.31.1722008468133; Fri, 26 Jul 2024
 08:41:08 -0700 (PDT)
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
 <CAPybu_3T8JNkZxf3pgCo4E4VJ3AZvY7NzeXdd7w9Qqe8=eV=9A@mail.gmail.com> <20240726131110.GD28621@pendragon.ideasonboard.com>
In-Reply-To: <20240726131110.GD28621@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 26 Jul 2024 17:40:50 +0200
Message-ID: <CAPybu_13+Axb2e_fVYeUv+S3UohbJXBYNF74Qd=pXz8_X3ic9g@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Leon Romanovsky <leon@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jiri Kosina <jikos@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:11=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Jul 26, 2024 at 10:02:27AM +0200, Ricardo Ribalda Delgado wrote:
> > On Thu, Jul 25, 2024 at 9:44=E2=80=AFPM Laurent Pinchart wrote:
> > > On Thu, Jul 25, 2024 at 04:20:35PM +0300, Leon Romanovsky wrote:
> > > > On Thu, Jul 25, 2024 at 03:02:13PM +0200, Ricardo Ribalda Delgado w=
rote:
> > > > > On Thu, Jul 25, 2024 at 2:23=E2=80=AFPM Leon Romanovsky wrote:
> > > > > > On Thu, Jul 25, 2024 at 11:26:38AM +0200, Ricardo Ribalda Delga=
do wrote:
> > > > > > > On Wed, Jul 24, 2024 at 10:02=E2=80=AFPM Laurent Pinchart wro=
te:
> > > > > >
> > > > > > <...>
> > > > > >
> > > > > > > It would be great to define what are the free software commun=
ities
> > > > > > > here. Distros and final users are also "free software communi=
ties" and
> > > > > > > they do not care about niche use cases covered by proprietary
> > > > > > > software.
> > > > > >
> > > > > > Are you certain about that?
> > > > >
> > > > > As a user, and as an open source Distro developer I have a small =
hint.
> > > > > But you could also ask users what they think about not being able=
 to
> > > > > use their notebook's cameras. The last time that I could not use =
some
> > > > > basic hardware from a notebook with Linux was 20 years ago.
> > > >
> > > > Lucky you, I still have consumer hardware (speaker) that doesn't wo=
rk
> > > > with Linux, and even now, there is basic hardware in my current
> > > > laptop (HP docking station) that doesn't work reliably in Linux.
> > > >
> > > > > > > They only care (and should care) about normal workflows.
> > > > > >
> > > > > > What is a normal workflow?
> > > > > > Does it mean that if user bought something very expensive he
> > > > > > should not be able to use it with free software, because his
> > > > > > usage is different from yours?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > It means that we should not block the standard usage for 99% of t=
he
> > > > > population just because 1% of the users cannot do something fancy=
 with
> > > > > their device.
> > > >
> > > > Right, the problem is that in some areas the statistics slightly di=
fferent.
> > > > 99% population is blocked because 1% of the users don't need it and
> > > > don't think that it is "normal" flow.
> > > >
> > > > > Let me give you an example. When I buy a camera I want to be able=
 to
> > > > > do Video Conferencing and take some static photos of documents. I=
 do
> > > > > not care about: automatic makeup, AI generated background, unicor=
n
> > > > > filters, eyes recentering... But we need to give a way to vendors=
 to
> > > > > implement those things closely, without the marketing differentia=
tors,
> > > > > vendors have zero incentive to invest in Linux, and that affects =
all
> > > > > the population.
> > >
> > > I've seen these kind of examples being repeatedly given in discussion=
s
> > > related to camera ISP support in Linux. They are very misleading. The=
se
> > > are not the kind of features that are relevant for the device
> > > pass-through discussion these day. Those are high-level use cases
> > > implemented in userspace, and vendors can ship any closed-source
> > > binaries they want there. What I care about is the features exposed b=
y
> > > the kernel to userspace API.
> >
> > The ISPs are gradually becoming programmable devices and they indeed
> > help during all of those examples.
>
> I'd like to see more technical information to substantiate this claim.
> So far what I've sometimes seen is ISPs that include programmable
> elements, but hiding those behind a firmware that exposes a fixed
> (configurable) pipeline. I've also heard of attempts to expose some of
> that programmability to the operating system, which were abandoned in
> the end due to lack usefulness.
>
> > Userspace needs to send/receive information from the ISP, and that is
> > exactly what vendors want to keep in the close.
>
> But that's exactly what we need to implement an open userspace ecosystem
> :-)
>
> > Describing how they implement those algorithms is a patent minefield
> > and their differentiating factor.
>
> Those are also arguments I've heard many times before. The
> differentiating factor for cameras today is mostly in userspace ISP
> control algorithms, and nobody is telling vendors they need to open all
> that.

I disagree. The differentiating factor is what the ISP is capable of
doing and how they do it. Otherwise we would not see new ISPs in the
market.

If you define the arguments passed to an ISP you are defining the
algorithm, and that is a trade secret and/or a patent violation.

>
> When it comes to patents, we all know how software patents is a
> minefield, and hardware is also affected. I can't have much sympathy for
> this argument though, those patents mostly benefit the largest players
> in the market, and those are the ones who currently claim they can't
> open anything due to patents.

Big players do not usually sue each other. The big problem is patent
trolls that "shoot at everything that moves".

I dislike patents, but it is the world we have to live in. No vendor
is going to take our approach if they risk a multi million dollar
lawsuit.


>
> > > > > This challenge seems to be solved for GPUs. I am using my AMD GPU
> > > > > freely and my nephew can install the amdgpu-pro proprietary user =
space
> > > > > driver to play duke nukem (or whatever kids play now) at 2000 fps=
.
> > > > >
> > > > > There are other other subsystems that allow vendor passthrough an=
d
> > > > > their ecosystem has not collapsed.
> > > >
> > > > Yes, I completely agree with you on that.
> > > >
> > > > > Can we have some general guidance of what is acceptable? Can we d=
efine
> > > > > together the "normal workflow" and focus on a *full* open source
> > > > > implementation of that?
> > > >
> > > > I don't think that is possible to define "normal workflow". Require=
ment
> > > > to have open-source counterpart to everything exposed through UAPI =
is a
> > > > valid one. I'm all for that.
> > >
> > > That's my current opinion as well, as least when it comes to the kern=
el
> > > areas I mostly work with.
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Ricardo Ribalda

