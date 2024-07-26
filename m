Return-Path: <linux-rdma+bounces-4005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0B293CF2D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 10:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2281C21E14
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56E176FA3;
	Fri, 26 Jul 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI0ucwe2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3172176AD8;
	Fri, 26 Jul 2024 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981036; cv=none; b=F/xAdRVIDt0E61dKs0+2qEB0y9uXFpbk8DaTrcQygnWRLTJVbwu3inowHgdeh14xfMa2P5uwQXuuBHpt8xUSXfOEqYolLLExdQtj/L8GwVXAdM0DyhpEDdyJruOqW3c0c/0VWLagjrfu5pjcTnJ+MWFopn1DBUwoz+/JNF/ohC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981036; c=relaxed/simple;
	bh=BTt5Us5dm7G8K+LbZQHVtBk6uxr8bOQKlh2I6b//vKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoRqycRFh44CBQSBpEkZ4nwVtxaqUKktkYMgQSNS9mMiw6PT+J/+1FgWKdth3w0s6mMut5/EQ79TKCewQ2lW9wMjrLctZVWH6Fr7o4QwjxfqOOAc5mMMom4UGHnPiTeULoHFosypbJmFpIML+Scr6v3aRbBSa9NS+K5/5EW2VTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI0ucwe2; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f6b67d9608so223387e0c.2;
        Fri, 26 Jul 2024 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721981034; x=1722585834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO8PgoBu3Ddw0Sv6NYJhLole57AvnJIcGz5QbvN/cQo=;
        b=gI0ucwe2orEBbI0BJnZlBGMI7922B4hJCysrXeZ1NEKSOdty3UJ9F50F5FmjBobv4X
         iLmRsWkvGHaSzSy5QPkp27276RkX5XQv/aJFAVHu70OXIH9SuClI8pauYsnpfuylSVlQ
         9b2yF0DL4g9kbyyuXO92G+eluZNopcHjd2zEDOEEWOeoAlb1zaOxegxB0pDMc7himfuS
         J9gdl6rPz81ErOoBjSfC9f41cU6/rIRWh44cHD6BdkzpnctiTrkuHVBptn8gn9aLbt+d
         Kp3wZzx3xQwN3cPEXCSSIecP0GdMVNhO/fBOa92plCfKW4S4UewWamYtKfNmz1ztOH5q
         rBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981034; x=1722585834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO8PgoBu3Ddw0Sv6NYJhLole57AvnJIcGz5QbvN/cQo=;
        b=tE+e5bjLOpJVi6wYXF9T3FHey486hWwXLdzNdVMejMTcSYFaZMzXAE1pT5buHgERog
         57wJJPLsuxJu1iXOfFSTIDHNX9tvWl7S/wFYhBZmJhvCrK1+buQFxYN7sMJaq+DnCcGV
         MnL+UNtemb34YMP+SNepCp9XK2oT1otp+RX0DNKICRicopQ9S26QEqyvVNBIXmqlwy0o
         TTS9xBMfu3nUfxhQ5W2mSbTE0OgQntY2KDb5yGE3cbEawga1zg0bJ+jMIDLi3blONX9a
         +Q8GdJMG3XoYIEmmGoxnn/4Ams3Z/IcqK1bv8kXoX9mTMpAEzyjy+tAkPKrL1Cn9vLSc
         ZMSg==
X-Forwarded-Encrypted: i=1; AJvYcCUHJNNqxKF8VCF42qllIiYlRDAtpcAuSXORvXy665nn39P3J0XcCC8N5hUsJHIg1inm6MMDTWZGlmX9GD0SHvfx1LjYf2pbOD+YYY0trTCz96AsqyZq32y2Y3P9S9vpv1+71FFPTaY5d+DD5pfmjS2smehAN7LRrfpFLpzVhQ==
X-Gm-Message-State: AOJu0YwkU+9qMlBhoy2j3bWXJySc1BYm/jn3yj9AiK6d6/hWmMrrvnGn
	M6Tt6GX/yL8fZJ1Ukai8dKdHg7opaqd976RHIqnn7fU4Ai16doF9fblpNJ96aUu5KgcgxjVgp7s
	+wD5ugV+nl55Oliu6CxQFr7MEeR0=
X-Google-Smtp-Source: AGHT+IEwviavYtndhM/zpbHVcDNyNXdiW4qOQcD+2MfGjbhH7FYJ8xuzbXvbXxwryJxaDAUU7MfovoniuEMn60/iyAE=
X-Received: by 2002:a05:6122:3c8f:b0:4f6:b240:4af8 with SMTP id
 71dfb90a1353d-4f6ca57f693mr5756432e0c.11.1721981033546; Fri, 26 Jul 2024
 01:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm> <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com> <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
In-Reply-To: <20240725193125.GD14252@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 26 Jul 2024 10:03:36 +0200
Message-ID: <CAPybu_3GkgcORm0Jbp8ze_rjfXDws8xWT_sQcs_39KY54zpnQg@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jiri Kosina <jikos@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent

On Thu, Jul 25, 2024 at 9:32=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Jul 24, 2024 at 04:37:21PM -0400, James Bottomley wrote:
> > On Wed, 2024-07-24 at 23:00 +0300, Laurent Pinchart wrote:
> > [...]
> > > What I get from the discussions I've followed or partcipated in over
> > > the years is that the main worry of free software communities is
> > > being forced to use closed-source userspace components, whether that
> > > would be to make the device usable at all, or to achieve decent level
> > > of performance or full feature set. We've been through years of
> > > mostly closed-source GPU support, of printer "windrivers", and quite
> > > a few other horrors. The good news is that we've so far overcome lots
> > > (most) of those challenges. Reverse engineering projects paid off,
> > > and so did working hand-in-hand with industry actors in multiple ways
> > > (both openly and behind the scenes). One could then legitimately ask
> > > why we're still scared.
> >
> > I don't think I am.  We're mostly fully capable of expounding at length
> > on the business rationale for being open if the thing they're hiding
> > isn't much of a differentiator anyway (or they're simply hiding it to
> > try to retain some illusion of control), so we shouldn't have any fear
> > of being able to make our case in language business people understand.
> >
> > I also think this fear is partly a mindset problem on our part.  We
> > came out of the real fight for openness and we do embrace things like a
> > licence that forces open code (GPL) and symbols that discourage
> > proprietary drivers (EXPORT_SYMBOL_GPL), so we've somewhat drunk the
> > FSF coolaid that if we don't stand over manufacturers every second and
> > force them they'll slide back to their old proprietary ways.  However,
> > if you look at the entirely permissive ecosystem that grew up after we
> > did (openstack, docker, kubernetes, etc.) they don't have any such fear
> > and yet they still have large amounts of uncompelled openness and give
> > back.
>
> I don't think those are necessarily relevant examples, as far as device
> pass-through goes. Vendors have many times reverted to proprietary ways,
> and they still do, at least in the areas of the kernel I'm most active
> in. I've seen first hand a large SoC vendor very close to opening a
> significant part of their camera stack and changing their mind at the
> last minute when they heard they could possibly merge their code through
> a different subsystem with a pass-through blank cheque.

Without knowing who that large SoC vendor is, and what they will be
willing to open, it is difficult to know what opportunity has been
lost. I would argue that if they have cancelled their open plans based
on an hypothesis, their willingness to open was not that high.

It would be more healthy for the ecosystem, if those discussions were
done more openly, at least all the core maintainers should be
involved.

>
> I'm willing to believe it can be different in other areas, which may
> partly explain why different subsystems and different developers have
> different biases and have trouble understand each other's point of view.

It is not different in other areas, it is the same area. At the end of
the day it is the same chip manufacturers, with the same legal teams.
It is our attitude that is different.


>
> > > I can't fully answer that question, but there are two points that I
> > > think are relevant. Note that due to my background and experience,
> > > this will be heavily biased towards consumer and embedded hardware,
> > > not data centre-grade devices. Some technologies from the latter
> > > however have a tendency to migrate to the former over time, so the
> > > distinction isn't necessarily as relevant as one may consider.
> > >
> > > The first point is that hardware gets more complicated over time, and
> > > in some markets there's also an increase in the number of vendors and
> > > devices. There's a perceived (whether true or not) danger that we
> > > won't be able to keep up with just reverse engineering and a
> > > development model relying on hobyists. Getting vendors involved is
> > > important if we want to scale.
> >
> > Yes, but there are lots of not very useful complex devices being
> > produced every day that fail to capture market share.  Not having
> > reverse engineered drivers for them is no real loss.  If a device does
> > gain market share, it gains a huge pool of users some of whom become
> > interested in reverse engineering, so I think market forces actually
> > work in our favour: we get reverse engineering mostly where the devices
> > are actually interesting and capture market share.  It's self scaling.
>
> I can't agree with that, sorry. Not only is the difficulty to
> reverse-engineer some classes of devices increasing, but saying that
> only devices that make it to the top of the market share chart are worth
> considering will leave many users on the side of the road.

Today we have left BILLIONS of users at the other side of the road.


>
> > > Second, I think there's a fear of regression. For some categories of
> > > devices, we have made slow but real progress to try and convince the
> > > industry to be more open. This sometimes took a decade of work,
> > > patiently building bridges and creating ecosystems brick by brick.
> > > Some of those ecosystems are sturdy, some not so. Giving pass-through
> > > a blank check will likely have very different effects in different
> > > areas. I don't personally believe it will shatter everything, but I'm
> > > convinced it carries risk in areas where cooperation with vendors is
> > > in its infancy or is fragile for any other reason.
> >
> > I also think we're on the rise in this space.  Since most cloud
> > workloads are on Linux, there's huge market pressure on most "found in
> > the cloud" devices (like accelerators and GPUs) to have an easy to
> > consume Linux story.  Nvidia is a case in point.  When it only cared
> > about fast games on some other OS, we get shafted with a proprietary
> > graphics drivers.  Now it's under pressure to be the number one AI
> > accelerator provider for the cloud it's suddenly wondering about open
> > source drivers to make adoption easier.
>
> I can't comment on Nvidia and their inference engines in particular. The
> server market may be in a better position that the consumer and embedded
> market, and if that's the case, I'm happy for the servers. That doesn't
> solve the issues in other markets though.
>
> > > Finally, let's not forget that pass-through APIs are not an all or
> > > nothing option. To cite that example only, DRM requires GPU drivers
> > > to have an open-source userspace implementation to merge the kernel
> > > driver, and the same subsystems strongly pushes for API
> > > standardization for display controllers. We can set different rules
> > > for different cases.
> >
> > I certainly think we can afford to experiment here, yes.
>
> --
> Regards,
>
> Laurent Pinchart
>


--
Ricardo Ribalda

