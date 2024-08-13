Return-Path: <linux-rdma+bounces-4348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA9A950285
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 12:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2FE1C21989
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C701922C0;
	Tue, 13 Aug 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqBOgdaR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED718CBEB;
	Tue, 13 Aug 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545261; cv=none; b=mKmqXl4phqgxsSUgEY6POwBFq6rU6bsWra9aV9vQc2BARqY/AFX0WRblMHGcwGGsLC+mwwOsxlgab7/pAhbOkXtEZ6GZ86nlWM7ElJ2pZmfyh8DZOef27Xbw3PVSFHIqVRaAeU64h8r9d0U+epRCNYuc2RovYxFBklMwFhus84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545261; c=relaxed/simple;
	bh=fzXoe1isBjct/QtD2OM5E7SMpJeuXFjqSDl3SsBrgaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQXSoniujqZNxvlTqX3rR4uYWwd9rlyPbUreLCo4aWImk8vxdefW4+xanyBurpzkPg7f5H+a/alAv6t3ygensMsVUK/75l60t7KK89mD9NJjkTtRpauEM+vrNIINOvirtJdvwH8HimPHd0SEU9Ef/e1NYsEJBdog5TmsrdKgIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqBOgdaR; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f16d2f2b68so74344241fa.3;
        Tue, 13 Aug 2024 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723545258; x=1724150058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzXoe1isBjct/QtD2OM5E7SMpJeuXFjqSDl3SsBrgaE=;
        b=MqBOgdaR+8bt20K1m4Hake7eVGSstG0FonsxGcJEshaceIvNWjq3z03k4IR31oypj1
         fFN9Hba2/3fvVCoc8gj1Wf6AJwfP6ZZPh0OzGusj02DZN2lxP+8ZqGWsGcdzpsa1GZYV
         SWe2f3dJkjrVJs3pkR9yRQfO69XgXZU1CsrpKq5uuvXOxIOTGIf3H6lklEimsWu6zkog
         z4bXJCTOVV9JrshvpC3qH1rebox0fW5aIP5Lhv33+HKuCWo4GrEwaL8L/s/Rd6E91vs5
         FMJLF+CMVA4CJ/Fr4FwiTqzKRSlYnss/EpJIFK9bPHs3w0/H6U2mtk371GMx2GGOu+FJ
         N37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723545258; x=1724150058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzXoe1isBjct/QtD2OM5E7SMpJeuXFjqSDl3SsBrgaE=;
        b=OJDbtiurdojINUr2Gr4knN/RWdaZz5Af0uOFeV9qUmfxRT2VnjW+o+JXfnVW6iRohW
         H8CpjvfO/9sA2DeuKVuhSUDu+fyJOdtQixA9vgs1CuqJp8eUvU9uHHnJVRsLxSII/4V6
         N8Vm9CKr9UQpw6LUxyDpJEw26sSiaJguxhie2La1L9nlExvE29/98AuiOyGGT4Yj6PJ9
         43hdHOMx0GYUf4Bk1sphkjtQsLs9U5LYiTAbqXFLxiyj8FJsHNC+3ykcpsgmE9rF9/bS
         pxgkA71dMUMENC84et+qRxIEktPzIDHimwzWa4mqOpEazfKVl+xcq07CKiZBGrNhZqkY
         oRtw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Xwj57AIXy8ubMC1Yqi6JXDiQhgcq3JYKOhhSmqcgFSIGfcQnOKyhGZw1OaYRdT3fSXA3R5Qy9IJQ1Q==@vger.kernel.org, AJvYcCUtE0zcueduJGJrBlIjUAgIOBlrZL5w637lQlpTBZotReYTz8qAaUmDFasVQVy/Uow28zra+wTPHko=@vger.kernel.org, AJvYcCWbbB9Hlj2n3272RxpewsoxNB1fWCQOK9i4k2ssZdnu5M3Q5QSnFMwLJYaniv0fYGzRFacUrJcL@vger.kernel.org
X-Gm-Message-State: AOJu0YyB6ITibDAIWyHG1Wvtc59Hui5/S9SF9TzuAToOt9f4EF8aUqk4
	KnCamk2fOjjNQysqgvzgo4857P5s0zRV5SMRV33JBjbf/OHn+kY8eED22PhcenUU5bb7o4tOlio
	oErSIQG2z2OAJ5kPnCvpuvp1ORkQ=
X-Google-Smtp-Source: AGHT+IFQf6uBkibY15otBoNAQq1YHezfZ8+u3cXNIwNpeGJbOjExMfCzxCYaXKDYewH7buD8RCrm5VcdY8XNGaXhT2I=
X-Received: by 2002:a05:651c:1991:b0:2f1:922f:8751 with SMTP id
 38308e7fff4ca-2f2b70d3584mr30397801fa.0.1723545257786; Tue, 13 Aug 2024
 03:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPybu_1SiMmegv=4dys+1tzV6=PumKxfB5p12ST4zasCjwzS9g@mail.gmail.com>
 <20240725200142.GF14252@pendragon.ideasonboard.com> <CAPybu_1hZfAqp2uFttgYgRxm_tYzJJr-U3aoD1WKCWQsHThSLw@mail.gmail.com>
 <20240726105936.GC28621@pendragon.ideasonboard.com> <CAPybu_1y7K940ndLZmy+QdfkJ_D9=F9nTPpp=-j9HYpg4AuqqA@mail.gmail.com>
 <20240728171800.GJ30973@pendragon.ideasonboard.com> <CAPybu_3M9GYNrDiqH1pXEvgzz4Wz_a672MCkNGoiLy9+e67WQw@mail.gmail.com>
 <Zqol_N8qkMI--n-S@valkosipuli.retiisi.eu> <CAKMK7uGx=VjHCo90htuTE6Oi0b8rt_0NrPsfbZwFKA304m7BdA@mail.gmail.com>
 <CA+Ln22E1YXGykjKqVO+tT8d_3-GYSEf-zY0TEHJq3w7HQEhFhA@mail.gmail.com> <20240813102638.GB24634@pendragon.ideasonboard.com>
In-Reply-To: <20240813102638.GB24634@pendragon.ideasonboard.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Tue, 13 Aug 2024 19:33:59 +0900
Message-ID: <CA+Ln22EzL7M+BLXS6dFi0n80XXkQu1CuoUad0EtjZ2ZEnNX=Kg@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Sakari Ailus <sakari.ailus@iki.fi>, 
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B48=E6=9C=8813=E6=97=A5(=E7=81=AB) 19:27 Laurent Pinchart <laure=
nt.pinchart@ideasonboard.com>:
>
> Hi Tomasz,
>
> On Tue, Aug 13, 2024 at 07:17:07PM +0900, Tomasz Figa wrote:
> > 2024=E5=B9=B47=E6=9C=8831=E6=97=A5(=E6=B0=B4) 22:16 Daniel Vetter <dani=
el.vetter@ffwll.ch>:
> > >
> > > On Wed, 31 Jul 2024 at 13:55, Sakari Ailus <sakari.ailus@iki.fi> wrot=
e:
> > > > This is also very different from GPUs or accel devices that are bui=
lt to be
> > > > user-programmable. If I'd compare ISPs to different devices, then t=
he
> > > > closest match would probably be video codecs -- which also use V4L2=
.
> > >
> > > Really just aside, but I figured I should correct this. DRM supports
> > > plenty of video codecs. They're all tied to gpus, but the real reason
> > > really is that the hw has decent command submission support so that
> > > running the entire codec in userspace except the basic memory and
> > > batch execution and synchronization handling in the kernel is a
> > > feasible design.
> >
> > FWIW, V4L2 also has an interface for video decoders that require
> > bitstream processing in software, it's called the V4L2 Stateless
> > Decoder interface [1]. It defines low level data structures that map
> > directly to the particular codec specification, so the kernel
> > interface is generic and the userspace doesn't need to have
> > hardware-specific components. Hardware that consumes command buffers
> > can be supported simply by having the kernel driver fill the command
> > buffers as needed (as opposed to writing the registers directly).
> > On the other hand, DRM also has the fixed function (i.e. V4L2-alike)
> > KMS interface for display controllers, rather than a command buffer
> > passthrough, even though some display controllers actually are driven
> > by command buffers.
> > So arguably it's possible and practical to do both command
> > buffer-based and fixed interfaces for both display controllers and
> > video codecs. Do you happen to know some background behind why one or
> > the other was chosen for each of them in DRM?
> >
> > For how it applies to ISPs, there are both types of ISPs out in the
> > wild, some support command buffers, while some are programmed directly
> > via registers.
>
> Could you provide examples of ISPs that use command buffers ? The
> discussion has remained fairly vague so far, which I think hinders
> progress.
>
> > For the former, I can see some loss of flexibility if
> > the command buffers are hidden behind a fixed function API, because
> > the userspace would only be able to do what the kernel driver supports
> > internally, which could make some use case-specific optimizations very
> > challenging if not impossible.
>
> Let's try to discuss this with specific examples.

AFAIK Intel IPU6 and newer, Qualcomm and MediaTek ISPs use command
buffers natively.

>
> > [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-=
stateless-decoder.html
> >
> > > And actually good, because your kernel wont ever blow
> > > up trying to parse complex media formats because it just doesn't.
>
> --
> Regards,
>
> Laurent Pinchart

