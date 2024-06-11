Return-Path: <linux-rdma+bounces-3056-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC77290402B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 17:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317451F2472D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373BC38390;
	Tue, 11 Jun 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VpU2PriE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2836AF5
	for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120184; cv=none; b=UOYrcC2pL9xW2LRZasBfzP3J7Vw90pTE3BS1dyTM7sia30kS45T5AyBMJCd5eq15EH7tP29aic1DEQKwSCbIVY2X8jEsiBn2PHLXpLESjsxyRCt4pv+1wIh9CyDLBfY/fmS3QSiU+vWryT6yMzs3pn4UUvh5jS9KrlkgDnn9Q+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120184; c=relaxed/simple;
	bh=sEvDMhi2LuNyC8HUxfzbzLy5zJ19f9pPX5EayeZseQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TouTivutC0v6d6/rX9++e2gB60KEX/KXrCedsmBmA5HXmMP1MPRqZISgPjt0uwNZAK9zXMwUG4REVPFsHzu4Qn7WT4WOevq9xFIH6WFs5jlhS+j0ZfgXaz5hzOhh2sCGtmf/dudmx5w3WtXkz+6AuHORW9ndFLb83fLE8bZL8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=VpU2PriE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c83f21854so495507e87.2
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2024 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718120181; x=1718724981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYiOKqOztGolPpdiFV4XN2+aPrwTQCSjwVf5L3ie3JA=;
        b=VpU2PriEzpgMIFyyyzm+bvOy4kdakkYgKJgVXhD2Scn3XjwpDUJIU+3MT5meZ8HDlB
         ZUzyin6R1YyFa7o4/K4XlHRgRbzy/9NSTv6mCMJQGebgsQLmKQQuaDinTgRfWNl7sZrK
         c03Sk97VJc1sHHRd0hOS+yHlA+1UGjhjilErE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718120181; x=1718724981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYiOKqOztGolPpdiFV4XN2+aPrwTQCSjwVf5L3ie3JA=;
        b=GjohV9jQL+3MOmRlpdzkKjy5Xv8i0ZxHqMF9KCix6Qia3g6ETBZIz4MjsZvevu100B
         4brfTFcAIIjHq6mRZ9EZ6ShnfMZ9dX50xrKl+Srn3HlzJT2CailEFkWEHJLZbVmhyV9u
         ESAAvffRtJY2ihWEmG8Ucilw82wQxUHwsUHq2DWZkQahh3UsaZ+3hyz8CXp+AIdNDobP
         bjmI/wiByaKsQnOCLJ1BTY/c9NrnnIxUaEzC/jnvw9gqAKoclCth2HrahNAtYiCoNRTH
         PM8iKPeTrHJN58HgUNx6y2oRu5nS25FoepzbRbngo4H7ZuG1q2R+JsTopuUZepRUUeR2
         caJA==
X-Forwarded-Encrypted: i=1; AJvYcCWUGOH4gcIxUAucKmlkiQa+cdKqqu1ptLYZJRKyrutXS2nA3vhvvPeYW7XWnFNWFR/W6XQLQJJG3BS/O5+leBgdLW2CCWR3qiZscw==
X-Gm-Message-State: AOJu0Ywu5WnWCTIznkCHoEVjlT1Eq0cdGDdYQRSKeLD8thFQ7gHJZkb4
	c0Y5vD/XpWUQz1f0DL1hH6OnubwVG4zV2iOZjMWs6KpOftSYBSIXMlehdtcQ30s=
X-Google-Smtp-Source: AGHT+IEqvd8t7yV4Y08H9toKdWjldXNuJHx8xMhVZIiBly5rz0ehyy1t+vkdmGULc+LniJtZqK7xKQ==
X-Received: by 2002:a19:9107:0:b0:52b:c06d:70cf with SMTP id 2adb3069b0e04-52bc06d7164mr5715253e87.4.1718120180437;
        Tue, 11 Jun 2024 08:36:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42274379b83sm10409345e9.28.2024.06.11.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:36:19 -0700 (PDT)
Date: Tue, 11 Jun 2024 17:36:17 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <Zmhu8egti-URPFoB@phenom.ffwll.local>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605135911.GT19897@nvidia.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, Jun 05, 2024 at 10:59:11AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 04, 2024 at 04:56:57PM -0700, Dan Williams wrote:
> > * Introspection / validation: Subsystem community needs to be able to
> >   audit behavior after the fact.
> > 
> >   To me this means even if the kernel is letting a command through based
> >   on the stated Command Effect of "Configuration Change after Cold Reset"
> >   upstream community has a need to be able to read the vendor
> >   specification for that command. I.e. commands might be vendor-specific,
> >   but never vendor-private. I see this as similar to the requirement for
> >   open source userspace for sophisticated accelerators.
> 
> I'm less hard on this. As long as reasonable open userspace exists I
> think it is fine to let other stuff through too. I can appreciate the
> DRM stance on this, but IMHO, there is meaningfully more value for open
> source in trying get an open Vulkan implementation vs blocking users
> from reading their vendor'd diagnostic SI values.
> 
> I don't think we should get into some kind of extremism and insist
> that every single bit must be documented/standardized or Linux won't
> support it.

I figured it might be useful to paint what we do in DRM with a bit more
nuance. In the principles, we're indeed fairly radical in what we require,
but in practice we aim for a much more pragmatic approach in what we
merge. There's two major axis here:

1. One is ecosystem maturity. One end is 3d, with vulkan as the clear
industry standard, and an upstream full-featured userspace driver in
mesa3d is the only technically reasonable choice. And all gpu vendors
agree and by this year even nvidia started hiring an upstream team. But
this didn't happen magically overnight, it took 1-2 decades of background
discussions and tactical push&pulling to get there.

The other end is currently AI accelerators. It's a complete mess, where
across the platform (client, edge, cloud), customer and vendor dimension
every point has a different stack. And the problem is so obvious that
everyone is working to fix this, which means currently
https://xkcd.com/927/ is happening in parallel. Just to get things going
we're accepting pretty much anything that's a notch above total garbage
for userspace and for merging into the kernel.

2. The other part is how much it impacts applications. If you can't run
the same application across different vendors, the case for an upstream
stack becomes a lot weaker. At the other end is infrastructure enabling
like device configuration, error handling and recovery, hw debugging and
reliablity/health reporting. That's a lot more vendor specific in nature
and needs to be customized anyway per deployement. And only much higher in
the stack, maybe in k8s, can a technically reasonable unification even
happen.  So again we're much more lenient about infrastructure enabling
and uapi than stuff applications will use directly.

Currently that's enough of a mess in drm that I feel like enforcing
something like fwctl is still too much. But maybe once fwctl is
established with other subsystems/devices we can start the conversations
with vendors to get this going a few years down the road.

Both together mean we land a lot of code that's questionable at best,
clear garbage at worst. But since we've been in the merging garbage
business just to get things going for decades, we've become pretty good at
dealing with the kernel internal and uapi fallout, some say too good. But
personally I don't think there's a path to where we are with 3d/vulkan
that doesn't go through years of this kind of suck, and very much merged
into upstream kind of suck.

For all the concerns about trusting vendors/devices to not abuse very broad
uapi interfaces: Modern accelerator command submission boils down to "run
this context at this $addr", and the kernel never ever directly sees
anything more fly by. That's the same interface you need for a no-op job
as a full blown AI workload, so in theory maximal abuse potential.

In practice, it doesn't seem to be an issue, at least not beyond the
intentionally pragmatic choices where we merge kernel code with known
sub-par/incomplete userspace. I'm not sure why, but to my knowledge all
attempts to break the spirit of our userspace rules while following the
letter die in vendor-internal discussions, at least for all the
established upstream driver teams.

And for new ones it takes years of private chats to get them going and
fully established in upstream anyway.

Maybe one reason we have a bit an extremist reputation is that all the
public takes are the radical principled requirements, while the actual
pragmatic discussions mostly happen in private.

tldr; fwctl as I understand it feels like a bridge to far for drm today,
but I'd very much like someone else to make this happen so we could
eventually push towards adoption too.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

