Return-Path: <linux-rdma+bounces-4346-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A517295023D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 12:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F901C21057
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637C18B480;
	Tue, 13 Aug 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au6J91jU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D9189BB1;
	Tue, 13 Aug 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544248; cv=none; b=qY9fJZrUMFQ34d/wcVHCClla73PgcZRXx+BENLwHnvRp2YOaXmKPsHKLCAsXcxwAxprkOl4ursVlp+kZQDwuor394GxwJ72aPDRwCnWNJmi3JgTpYqOl4QjYGSk2miSgyhCf/WEoct/uOe0AdpTUdEA1gCibZ3nXY5GTjB83Wjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544248; c=relaxed/simple;
	bh=KmX/8SPO59kZCItf8lFjsmaMIQZs6UpEn4Kx0JHZWT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ffma/PwjE92C+udB55pBulljGTpU96kpQa9+zxF1OaeUcQmxGgeEUG2BLBNTiuF0WHUesgC9BpVke5w4eFNi2kQZTSW03DRtY4BpcsP3r8h9mg/F09dccYIa6yiXzS0v28Nv9rGTTBjTyEMivyraY42SUiict7fnk2yB54OtgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au6J91jU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so70237221fa.2;
        Tue, 13 Aug 2024 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723544245; x=1724149045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmX/8SPO59kZCItf8lFjsmaMIQZs6UpEn4Kx0JHZWT0=;
        b=au6J91jUgyjYnaSCdiHGhRIfD6BZZ6Fh2oaTDVgUh66I71StNH3CtYiyynVAiPDHIW
         BVnvpKD7RVR1FCnZATfesGzzWSTqjaHd46vchecwNUqU+62DxlJH8z7whVn6c0WR4MLi
         vm6S5dcJ1XllGt6uam3tEKZ/UgTi8utDzRVsBYnenO/daql6wXjk6x6fWU49sahLxP27
         YKlG32IrDqJ273S5KDE43YudswXe+R50X9LZwMDgdJiBj7gA9ybZTamtxp5eh1PUU46u
         +MmE7XPYqJBEcVNcbUt4I9OSbyjUy/yCA2/M/J5EgCQjYHp16BDJlBHnAVNqLE+NM3IU
         WXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723544245; x=1724149045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmX/8SPO59kZCItf8lFjsmaMIQZs6UpEn4Kx0JHZWT0=;
        b=Iz5riUjoccy+bB7jpo0ZwnQmk8jSJK+HH9lsXPTNddfUO9KmmjrgG6rHWRhCqE9uEP
         ZasYiyOG6csNlS5KojhrIKHSa3QXgvaHwd5W+2Em1nsCoOXnsmk/qOZG/BntHSGcalXE
         3cbYIDYLkXN37IxGrz2llC+Vw2IlLmYyD7KmT1QfsDimakLL07MWnjGMLg84RwLv0Kyu
         QzWHtmMJK809ZWnXUilzFd1QxGENoO/Et+vHgziA87wLL2nrVMXkGkP+66s8g8Jfqoc6
         u9o4mf+KjBtS6IrGHWDbiRLtHiOPC/3iZDJpukRa4Ex84M3uDAaxIKBnNQfHwJOofB4V
         xObg==
X-Forwarded-Encrypted: i=1; AJvYcCW95/XAfDq7SNYf0aj5dVVVeKcvtn6HDZcMM4wW/pOhyPeLo79fPu5nXnXeXRpGForAw6TzLjHZNED/m9Eu2goByUo7vzfA2rCLw7pE26Ylb9YeyNePWM0cgPOBpjAqYeOCLiiN0EO39+Mox+iQmdL5+LjHsF1zvo9hfd3sfw==
X-Gm-Message-State: AOJu0YxzsadO+exi9wLcrxyhiUrM6wAdCrKSA9msFutvRLmwc9LPa+sa
	spxEPv2hUeuq+lYwSeQocp9MP1ykUBubjLVZDaDOPdLm3jkjNG/Q7Thlhi+HkbjpDvv8yg6DEuN
	ihGa7Zaabb+fokuvAIDBk7b9pubY=
X-Google-Smtp-Source: AGHT+IFKjzuQaaf7e6bx4QvZ27kpa0HEv9KUIhMC9T4vRSl72ApvXVH6j9YQ6g0WwTQ5j/N7cDwtQbTX3PXfdwV5l1A=
X-Received: by 2002:a2e:be8e:0:b0:2ef:1b93:d2b6 with SMTP id
 38308e7fff4ca-2f2b71482d5mr23578061fa.8.1723544244394; Tue, 13 Aug 2024
 03:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721192530.GD23783@pendragon.ideasonboard.com>
 <CAPybu_2tUmYtNiSExNGpsxcF=7EO+ZHR8eGammBsg8iFh3B3wg@mail.gmail.com>
 <20240722111834.GC13497@pendragon.ideasonboard.com> <CAPybu_1SiMmegv=4dys+1tzV6=PumKxfB5p12ST4zasCjwzS9g@mail.gmail.com>
 <20240725200142.GF14252@pendragon.ideasonboard.com> <CAPybu_1hZfAqp2uFttgYgRxm_tYzJJr-U3aoD1WKCWQsHThSLw@mail.gmail.com>
 <20240726105936.GC28621@pendragon.ideasonboard.com> <CAPybu_1y7K940ndLZmy+QdfkJ_D9=F9nTPpp=-j9HYpg4AuqqA@mail.gmail.com>
 <20240728171800.GJ30973@pendragon.ideasonboard.com> <CAPybu_3M9GYNrDiqH1pXEvgzz4Wz_a672MCkNGoiLy9+e67WQw@mail.gmail.com>
 <Zqol_N8qkMI--n-S@valkosipuli.retiisi.eu> <CAKMK7uGx=VjHCo90htuTE6Oi0b8rt_0NrPsfbZwFKA304m7BdA@mail.gmail.com>
In-Reply-To: <CAKMK7uGx=VjHCo90htuTE6Oi0b8rt_0NrPsfbZwFKA304m7BdA@mail.gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Tue, 13 Aug 2024 19:17:07 +0900
Message-ID: <CA+Ln22E1YXGykjKqVO+tT8d_3-GYSEf-zY0TEHJq3w7HQEhFhA@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, 
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dan Williams <dan.j.williams@intel.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8831=E6=97=A5(=E6=B0=B4) 22:16 Daniel Vetter <daniel.v=
etter@ffwll.ch>:
>
> On Wed, 31 Jul 2024 at 13:55, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > This is also very different from GPUs or accel devices that are built t=
o be
> > user-programmable. If I'd compare ISPs to different devices, then the
> > closest match would probably be video codecs -- which also use V4L2.
>
> Really just aside, but I figured I should correct this. DRM supports
> plenty of video codecs. They're all tied to gpus, but the real reason
> really is that the hw has decent command submission support so that
> running the entire codec in userspace except the basic memory and
> batch execution and synchronization handling in the kernel is a
> feasible design.

FWIW, V4L2 also has an interface for video decoders that require
bitstream processing in software, it's called the V4L2 Stateless
Decoder interface [1]. It defines low level data structures that map
directly to the particular codec specification, so the kernel
interface is generic and the userspace doesn't need to have
hardware-specific components. Hardware that consumes command buffers
can be supported simply by having the kernel driver fill the command
buffers as needed (as opposed to writing the registers directly).
On the other hand, DRM also has the fixed function (i.e. V4L2-alike)
KMS interface for display controllers, rather than a command buffer
passthrough, even though some display controllers actually are driven
by command buffers.
So arguably it's possible and practical to do both command
buffer-based and fixed interfaces for both display controllers and
video codecs. Do you happen to know some background behind why one or
the other was chosen for each of them in DRM?

For how it applies to ISPs, there are both types of ISPs out in the
wild, some support command buffers, while some are programmed directly
via registers. For the former, I can see some loss of flexibility if
the command buffers are hidden behind a fixed function API, because
the userspace would only be able to do what the kernel driver supports
internally, which could make some use case-specific optimizations very
challenging if not impossible.

[1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-stat=
eless-decoder.html

> And actually good, because your kernel wont ever blow
> up trying to parse complex media formats because it just doesn't.
> -Sima
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>

