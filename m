Return-Path: <linux-rdma+bounces-4350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947FF95031F
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 12:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D0C1C2268E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2246A19AD70;
	Tue, 13 Aug 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vRJU9sAN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4499619AA5F;
	Tue, 13 Aug 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546728; cv=none; b=OY03rrgs+9iPbFUF0gqhguCWUNHhQxpZ//gzMX+DhYPGIMEG3Jc0+a6P//OEfzYzVKKcRHVlxy5VGcWODKmLurjqKve5waCOicfw1WVCUXHraDkZ5pIx0YU+I8/HBbSGWAa6nJkRmoJl0ZEi5E3UWTfP44w4kj78dk3YBERwoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546728; c=relaxed/simple;
	bh=amLSKSyOu/TcfOjB3E3e/dsqli4Esy0qc7vDMfnCbcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6dx4lVqfNUyrF0U06AxwPpHSO1UOVswto5PJ1WTH0R8cxJErPEL8XXlJwPLuN7Q+w5gDSg3OCr9Z5zf6pPQl6TOcVnLf0Nei2QYtJjcL0GyyxHqrdzaPKR4QI8DwbIEgsAdZXAqHMs6MlrI4MOFyszn+4phozZKzxHQmIiDt4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vRJU9sAN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A049B2EC;
	Tue, 13 Aug 2024 12:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1723546668;
	bh=amLSKSyOu/TcfOjB3E3e/dsqli4Esy0qc7vDMfnCbcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRJU9sANRKu+3vwmYfX2EQKmkIvXsWKIVnQ/85XypownXWAeXSs+pqSG9YBxgDbFK
	 rtZ8/4JRyY2GW7khAZAMiTOR0LHnX328e2WVMHsvY/ZHq80EYP+2FrX9k5UaswNaSy
	 WXDmMpomtpDTxzJChGbXQ+9/16+NxkW1qWXYjPiY=
Date: Tue, 13 Aug 2024 13:58:22 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240813105822.GD24634@pendragon.ideasonboard.com>
References: <CAPybu_1hZfAqp2uFttgYgRxm_tYzJJr-U3aoD1WKCWQsHThSLw@mail.gmail.com>
 <20240726105936.GC28621@pendragon.ideasonboard.com>
 <CAPybu_1y7K940ndLZmy+QdfkJ_D9=F9nTPpp=-j9HYpg4AuqqA@mail.gmail.com>
 <20240728171800.GJ30973@pendragon.ideasonboard.com>
 <CAPybu_3M9GYNrDiqH1pXEvgzz4Wz_a672MCkNGoiLy9+e67WQw@mail.gmail.com>
 <Zqol_N8qkMI--n-S@valkosipuli.retiisi.eu>
 <CAKMK7uGx=VjHCo90htuTE6Oi0b8rt_0NrPsfbZwFKA304m7BdA@mail.gmail.com>
 <CA+Ln22E1YXGykjKqVO+tT8d_3-GYSEf-zY0TEHJq3w7HQEhFhA@mail.gmail.com>
 <20240813102638.GB24634@pendragon.ideasonboard.com>
 <CA+Ln22EzL7M+BLXS6dFi0n80XXkQu1CuoUad0EtjZ2ZEnNX=Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Ln22EzL7M+BLXS6dFi0n80XXkQu1CuoUad0EtjZ2ZEnNX=Kg@mail.gmail.com>

On Tue, Aug 13, 2024 at 07:33:59PM +0900, Tomasz Figa wrote:
> 2024年8月13日(火) 19:27 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> > On Tue, Aug 13, 2024 at 07:17:07PM +0900, Tomasz Figa wrote:
> > > 2024年7月31日(水) 22:16 Daniel Vetter <daniel.vetter@ffwll.ch>:
> > > >
> > > > On Wed, 31 Jul 2024 at 13:55, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > > > > This is also very different from GPUs or accel devices that are built to be
> > > > > user-programmable. If I'd compare ISPs to different devices, then the
> > > > > closest match would probably be video codecs -- which also use V4L2.
> > > >
> > > > Really just aside, but I figured I should correct this. DRM supports
> > > > plenty of video codecs. They're all tied to gpus, but the real reason
> > > > really is that the hw has decent command submission support so that
> > > > running the entire codec in userspace except the basic memory and
> > > > batch execution and synchronization handling in the kernel is a
> > > > feasible design.
> > >
> > > FWIW, V4L2 also has an interface for video decoders that require
> > > bitstream processing in software, it's called the V4L2 Stateless
> > > Decoder interface [1]. It defines low level data structures that map
> > > directly to the particular codec specification, so the kernel
> > > interface is generic and the userspace doesn't need to have
> > > hardware-specific components. Hardware that consumes command buffers
> > > can be supported simply by having the kernel driver fill the command
> > > buffers as needed (as opposed to writing the registers directly).
> > > On the other hand, DRM also has the fixed function (i.e. V4L2-alike)
> > > KMS interface for display controllers, rather than a command buffer
> > > passthrough, even though some display controllers actually are driven
> > > by command buffers.
> > > So arguably it's possible and practical to do both command
> > > buffer-based and fixed interfaces for both display controllers and
> > > video codecs. Do you happen to know some background behind why one or
> > > the other was chosen for each of them in DRM?
> > >
> > > For how it applies to ISPs, there are both types of ISPs out in the
> > > wild, some support command buffers, while some are programmed directly
> > > via registers.
> >
> > Could you provide examples of ISPs that use command buffers ? The
> > discussion has remained fairly vague so far, which I think hinders
> > progress.
> >
> > > For the former, I can see some loss of flexibility if
> > > the command buffers are hidden behind a fixed function API, because
> > > the userspace would only be able to do what the kernel driver supports
> > > internally, which could make some use case-specific optimizations very
> > > challenging if not impossible.
> >
> > Let's try to discuss this with specific examples.
> 
> AFAIK Intel IPU6 and newer, Qualcomm and MediaTek ISPs use command
> buffers natively.

At the hardware level, firmware level, or both ? Is there a way we can
get more information about the structure of the command buffer and how
it is handled by the ISP for any of those three platforms ?

> > > [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-stateless-decoder.html
> > >
> > > > And actually good, because your kernel wont ever blow
> > > > up trying to parse complex media formats because it just doesn't.

-- 
Regards,

Laurent Pinchart

