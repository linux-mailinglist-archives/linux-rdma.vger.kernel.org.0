Return-Path: <linux-rdma+bounces-3983-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3956E93C2A8
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 15:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73B4281D00
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8148C19AD72;
	Thu, 25 Jul 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJghbAm2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F3199E8A;
	Thu, 25 Jul 2024 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912554; cv=none; b=FippXvbPHwsh7CWhoyl0mlr5dqnrJTKfFLsBYjEr/r4ItS6wKEr5LeuBcIwImCaEEll7ZMiGi64ZAegjkQpCoCw0srGz/R3iOGDc8052IBvvQvXU5I5v0gPULJXavUFbjNicFTHs2FShKVrAYIWJf3U4RfEJ9ZeqerWGTEHGOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912554; c=relaxed/simple;
	bh=0KsN8bTzJfBmQj967+w/L9AqPEgh6PQzXgnINTU0gQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4CaNoq0C9TyOjD/01sHd2HFDsjWt4RIzipCnjy7O0iRh29nExApW6iW0TSzIZde1AxqIwGnmzS+JRS7AICJPqlpkxrrI02+NzBuk+h5BA+7Uyc7l9zhOLJE5IsewL212ZMxjW+mPB/pBMoJPunryNzMfDr86b0kJiNHFcQyvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJghbAm2; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db157d3bb9so259478b6e.2;
        Thu, 25 Jul 2024 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721912552; x=1722517352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KsN8bTzJfBmQj967+w/L9AqPEgh6PQzXgnINTU0gQY=;
        b=dJghbAm2d3hQbRo6ryCDGxqfByJMPYh9fEv40j4cLd5g8lhiwUCbIozgQKszjDzIqn
         xwJixptyCXGcCd6oSxedeztTN5gPFbGdiDvbGynl7WYV3Y+e+ZIOcoYetXf4+KbGFr+8
         VphlwLkrMCJ8LkzvIzvoJEy5gF1Wlhl3zZFnhjvjVtGRukEndv9dqaUJ/Iyb3QSliZYA
         LPkxNx5S9e465bALYHUpfyj9l0YmOHiBdWQItnzjNZqqGg4iEk9cvJSFgyJ9BuTwEIYo
         DM488RXEjq2Es5QeJoB0ikWC+oKVtwPw/EM5YmjgYEWyI7OOGHaqj3Be8+3VsS78BgQX
         Ap6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721912552; x=1722517352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KsN8bTzJfBmQj967+w/L9AqPEgh6PQzXgnINTU0gQY=;
        b=ITyvNHPj5w9lE7MoHQq+EnirsYChlcy3AU2249teM6mojywXFhXk5S6+s8gtuTtPBo
         jGpj1HIfEumo7SEZ7Al+D8z/hvsHmN/LpoM3RBQrKQPzULsaHRyoNjG6wnd7qeUByNMB
         GuC+j2OI5+4W2A6hFbncHoOKzyw0h8pXHampqHYRScs596s4YR6SuPpa4p5h6Cxo/i3M
         5dwNS3Rj+T6Rt96glFTEk6mUinMPbv7M7ZzGemEie/QxIkXawswDkBVe1d8zmOATD61Z
         Z406AoV4Pt+eHOdAV6n7BtS+P53bTTTQE8Tpb1qBaEM4/zIJCLd41RGYY01uphNoEC91
         abkw==
X-Forwarded-Encrypted: i=1; AJvYcCVfsk4bvd+nrRowp3moRLHw8Q0RtX6iL168uQyw+OBvlRalFMLF+IJuY5Mo+gt1+fV2A701F4mu7jP27HcEhRCADVNmTVls2ZpNgYNjdnjHr0oEHSokRfJuaTBmRCXd1FXKY38Doky/D5Myl5Inzxfmx/156CCNoM3IrOEuvA==
X-Gm-Message-State: AOJu0YxmKTqGOXJQs1p70g5CLd5xwDkCHRFZ53NwYNhv9tw3ye6JuhG9
	7cD1nadFMhr3lDY0sP8LqInFN6WHCiBtlSbe6wPQocTxxxssaLg5lavgDbzqpXLiXG87Za5hSz8
	Q3VWtxfasIK0dVuUY8EQaqR8hQVI=
X-Google-Smtp-Source: AGHT+IFnwa2463n9AhT8ZQ4MfQ5LP7Y8xO4yJdy25Rk02R0VU5cXlOQdpYjPaSUGwmh63uOKNiEP9uSHrDvmPfERl9Y=
X-Received: by 2002:a05:6358:728:b0:1ac:f839:e001 with SMTP id
 e5c5f4694b2df-1acfb966725mr193976855d.22.1721912551739; Thu, 25 Jul 2024
 06:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm> <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com> <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
 <20240725122315.GE7022@unreal>
In-Reply-To: <20240725122315.GE7022@unreal>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 25 Jul 2024 15:02:13 +0200
Message-ID: <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Leon Romanovsky <leon@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jiri Kosina <jikos@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 2:23=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Jul 25, 2024 at 11:26:38AM +0200, Ricardo Ribalda Delgado wrote:
> > On Wed, Jul 24, 2024 at 10:02=E2=80=AFPM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
>
> <...>
>
> >
> > It would be great to define what are the free software communities
> > here. Distros and final users are also "free software communities" and
> > they do not care about niche use cases covered by proprietary
> > software.
>
> Are you certain about that?

As a user, and as an open source Distro developer I have a small hint.
But you could also ask users what they think about not being able to
use their notebook's cameras. The last time that I could not use some
basic hardware from a notebook with Linux was 20 years ago.

>
> > They only care (and should care) about normal workflows.
>
> What is a normal workflow?
> Does it mean that if user bought something very expensive he
> should not be able to use it with free software, because his
> usage is different from yours?
>
> Thanks

It means that we should not block the standard usage for 99% of the
population just because 1% of the users cannot do something fancy with
their device.

Let me give you an example. When I buy a camera I want to be able to
do Video Conferencing and take some static photos of documents. I do
not care about: automatic makeup, AI generated background, unicorn
filters, eyes recentering... But we need to give a way to vendors to
implement those things closely, without the marketing differentiators,
vendors have zero incentive to invest in Linux, and that affects all
the population.

This challenge seems to be solved for GPUs. I am using my AMD GPU
freely and my nephew can install the amdgpu-pro proprietary user space
driver to play duke nukem (or whatever kids play now) at 2000 fps.

There are other other subsystems that allow vendor passthrough and
their ecosystem has not collapsed.

Can we have some general guidance of what is acceptable? Can we define
together the "normal workflow" and focus on a *full* open source
implementation of that?

--=20
Ricardo Ribalda

