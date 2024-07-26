Return-Path: <linux-rdma+bounces-4030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1493D7AE
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 19:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27261C21CF1
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317717D34C;
	Fri, 26 Jul 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="L/AxQ2X/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE81CFAF
	for <linux-rdma@vger.kernel.org>; Fri, 26 Jul 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015220; cv=none; b=VcjJUAyTVPdV4g+73InoGkx1a7j32Ct5lAEt7DOAF1A3LoEGyAyFo4s1d9EuZT5uRTv3YVaG2hTsy6qWJB56XAIOsY6HWknrGbIzWtk6KCwOWsK3FVTidH+sUmrryskSvCkVu6qy7oSGskwkQRjC99kNK/J0prDZKZl5DNugSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015220; c=relaxed/simple;
	bh=e3N5bWu4r8Swl4BzWy7i9jr2amOi1C9JqeLg+IveS6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB3JSCK97Qb2kkBTSFqXBFhvXQ1ZfT0gRfbW2k2yxHykoZA77/wfXGSz+jEaQJT6l+RguN/nEEVnGO2bIYko7bFBL/+RXWXx9J+1aayggSpc/GzPkNL873Lpmr1f3PiuKB76V3133JZezX67ytZ8kuDkZIuiNwpKJJVsv81X1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=L/AxQ2X/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3684e2d0d8bso155570f8f.2
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jul 2024 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722015217; x=1722620017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/B7g0UHHGpKr5sLCW2cjeH3RTgEO1uT2YFJABG6Bsg=;
        b=L/AxQ2X/vE1foV9AVQePKmFWvxkRMHronlqCPy6jXR/gyJELOmzyDLNeyI6VRBvaku
         oQMl7tjz6k3zcRCvZN+wmSk3ZYyrga5l2odxYIe9VuIY/GDNigCm2+SWhBd8lZYRA5ZC
         aaRsduoOGrqWQ6HqDTHLMI/YlcbG9KQAZnhFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015217; x=1722620017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/B7g0UHHGpKr5sLCW2cjeH3RTgEO1uT2YFJABG6Bsg=;
        b=l2qtTVjgvyQrED5X1wBbI8Td7DtEApkwvDP5DUx966r71xRyYLMgA1DOplvO2mzumR
         ykoVxXNCEzi343OVQlP4cTck08jpBmkdJ8vz/CjRXHrg8jciFoyaaXjOGNMWeLneV+W1
         5dc2Y58HrnRtNT/Hk84ABCzqKFlGjJhsD8C2VxgpHBTI7kljWh4Lb1YP79voacXRFhGK
         EuchCChb/3uhYv/PITFOPfp0EaxxGEvtSeWQ2VJnI1dKCT+nhvRrmNXldahliVdVuB6i
         PvWC6AwdokxH3liuxLU9Wza3GG5GCBoSFEYi3XSie/XLXR+0VXoakV0g5xCtHdXbRZNV
         Kn/w==
X-Forwarded-Encrypted: i=1; AJvYcCWkAVbypZvpqsaIlPM2hZ4kvkf6FhzdpsSrr1rsIJO9nmWlkk6b5892cHxGWexX8DKNn9DfyNSa9y/l@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfnrC4y6yM0/UkZMyjwSyLv+Kc4DsHqCwxDM/kmowL8WB+Wux
	uO0t2gONSYNd5v0375Mc/MK3AWs6uEks3s45vKA9xx5mHtnHLDzpJYzqZ7gIt9o=
X-Google-Smtp-Source: AGHT+IG3ue2Wp3NAwG+80cC1hBEBaxqYkh1o6tYlzluNcJg5ps4z/XxOoMXpw4ib8InHKvN9IoLe0A==
X-Received: by 2002:a5d:59a2:0:b0:367:95e3:e4c6 with SMTP id ffacd0b85a97d-36b34cec909mr2845449f8f.1.1722015216751;
        Fri, 26 Jul 2024 10:33:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36858179sm5684617f8f.88.2024.07.26.10.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:33:36 -0700 (PDT)
Date: Fri, 26 Jul 2024 19:33:34 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <ZqPd7i22_oyPB2UN@phenom.ffwll.local>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 24, 2024 at 04:37:21PM -0400, James Bottomley wrote:
> On Wed, 2024-07-24 at 23:00 +0300, Laurent Pinchart wrote:
> [...]
> > What I get from the discussions I've followed or partcipated in over
> > the years is that the main worry of free software communities is
> > being forced to use closed-source userspace components, whether that
> > would be to make the device usable at all, or to achieve decent level
> > of performance or full feature set. We've been through years of
> > mostly closed-source GPU support, of printer "windrivers", and quite
> > a few other horrors. The good news is that we've so far overcome lots
> > (most) of those challenges. Reverse engineering projects paid off,
> > and so did working hand-in-hand with industry actors in multiple ways
> > (both openly and behind the scenes). One could then legitimately ask
> > why we're still scared.
> 
> I don't think I am.  We're mostly fully capable of expounding at length
> on the business rationale for being open if the thing they're hiding
> isn't much of a differentiator anyway (or they're simply hiding it to
> try to retain some illusion of control), so we shouldn't have any fear
> of being able to make our case in language business people understand.
> 
> I also think this fear is partly a mindset problem on our part.  We
> came out of the real fight for openness and we do embrace things like a
> licence that forces open code (GPL) and symbols that discourage
> proprietary drivers (EXPORT_SYMBOL_GPL), so we've somewhat drunk the
> FSF coolaid that if we don't stand over manufacturers every second and
> force them they'll slide back to their old proprietary ways.  However,
> if you look at the entirely permissive ecosystem that grew up after we
> did (openstack, docker, kubernetes, etc.) they don't have any such fear
> and yet they still have large amounts of uncompelled openness and give
> back.

This matches my experience. Legal and technical roadblocks help a bit in
the margins, but they don't matter. The open gpu stack is 90% MIT, and
nvidia and all the others have demonstrated for years how easy it is to
ignore the GPL'ed part.

What gets vendors involved is a successful project that drives revenue,
where they have a clear need for a seat at the table to make sure the good
times for them continue. Clear rules what it takes to get that seat is in
my experience really the driving force for private discussions with
vendors, and from that pov the most important thing I've ever done for the
open gpu stack is this little documentation section:

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements

Unlike laws you can legalese around and code you can trick with hacks for
an endless game of whack-a-mole the above doc was the real stick. And it
absolutely needed the carrot of the successful project that financially
matters to work.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

