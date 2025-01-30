Return-Path: <linux-rdma+bounces-7342-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE1A23187
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 17:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435F73A709A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBC21EBA19;
	Thu, 30 Jan 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kGtmDMmi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FE1E8837
	for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253391; cv=none; b=Om6eTNsja2n0b6311wG3qqxC2P1fjBUjBKcu6ByDjN7KpMkBkqKIncV5OjuFcAXFZHZbr2jhgLl4FElVx1qPMtkxRKK21fa638wG+jTf3yAf4ub8YCzZyPns84v9Dj7PGlzNEEC80aUEY424Pa4M0Gy1MESaxQkTWlQhLFOK0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253391; c=relaxed/simple;
	bh=+YGWdOLH796KgtIQHApwLPR2A7IV2UrR8iSarAPSu9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCv7mnPfwcuBdmy7KEWbUlxRMyR2DQJ955BR1GMO/0dJ4MNlhb0oabCOCjKgrd++BpXBXdo+oE+0SyljNhOqWvzEqpw4aUmqTGLS6veGRx1Xvi78uR9zHMBCul5PalZFqLWamFQtHe74hp2x6j2G6y/5cxeSsP9UTiMHPOrVZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=kGtmDMmi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436a03197b2so7254125e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 08:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1738253388; x=1738858188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHjECDXWr9DtzEWz0JXb8DxrPMtRT+1WnFwQ9T4qTYY=;
        b=kGtmDMmiKsOTTSd1nxMT6b/rVp8Z5iwuxjyUOhOlAE1wo+hzjW7SyxgXgNsvFmgv2G
         SG8uYz0MzKEpLQfvxVsSTMoQarFpR45K09iAM3/J4AHh7uxrUpwJ1JNr4+kTjfVc7rDA
         g5QKrnD707dqUeFathBYAk1d5nmn51t1dVDqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738253388; x=1738858188;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHjECDXWr9DtzEWz0JXb8DxrPMtRT+1WnFwQ9T4qTYY=;
        b=qv8bsHHlHsbUPo4MfTjJ5SeMRffjFeZ1xBXwYtGb8nq9a8mWPAQq/snTaOR2eSqJ+C
         NZGUiCQv/7BkHBMmAoPNIrCkVgJvcgkQxJfRaJdimATnGe4tC1il4RtkUJ7FpF0qK4Bs
         DBorQYgaJWEjR6UIbmPFl859qD4T9icSEdTdflMlnS5rx0MAzrrFeJtCXnFi7mrI7NUx
         MZXExOdokFx7s5QNa2TiRjH3sr8XHsMVh5kzAmGnEXBW1CwuPAzWzBbA3x7sGR4W58Um
         EE+r+I87hFSE4aIz2EyoEJ1fSNZ0MN8hbci0Yu8Ox2zrBu/8JUst7CPSG1BKlQNpiG39
         cz3g==
X-Forwarded-Encrypted: i=1; AJvYcCV24EAiGXLen3vJ3fZJfCy2Sf6d9Hd1foN7C/7lr/GRkUqsgqekkK6R4h8yH7HS4sZQqQA8vaj7pGxL@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYO4INA8KTFe1cPsqbcmqHAuxn1PcNrV11WMV1VnBEansVQCr
	TC1Ot41pzWGeLROhCCXfLCjdwUAPePQFQV2FZjCxtLGVxjulxPv/oeABlSFkvCM=
X-Gm-Gg: ASbGncvQH7Q/NK9xEiTJoJxLvqasLuQF0757upiIJKRDGdwxcfSGrPbqmGvnzDurBVC
	2p5yfVArZsW27LjO79grwJOR+fsh5VnDlH0kvjRj7pZHlh0i/FoKUTGfgLSCFgFINKoCENFiZNE
	RW/90iPbGfktE/NsBhcT2k+qi92/OhmJmdAj6Ndd3EufImyA+CZbDb8JIpjbvAiHan9WTWBa1FE
	cjRcUfCDiK792BXkYu8Atlv1+q9Ltz51AfvwKmhBRx6VciAVORloAr9X3cWj1iFpjfiBf26pgiX
	1TwUiyg9M0v5lyBqSTolVsMSm4M=
X-Google-Smtp-Source: AGHT+IHzkAlG33CPN/kMrEln846pAhOyRPiLkWV/nev8K+POyx7veXX/IQAiWwM1YsBE7oYiCeZW/A==
X-Received: by 2002:a05:600c:1e0d:b0:436:f960:3427 with SMTP id 5b1f17b1804b1-438dc40ffbbmr65699075e9.22.1738253387756;
        Thu, 30 Jan 2025 08:09:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2ef08sm64120395e9.22.2025.01.30.08.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 08:09:46 -0800 (PST)
Date: Thu, 30 Jan 2025 17:09:44 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com,
	lyude@redhat.com, dakr@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, leon@kernel.org, jglisse@redhat.com,
	akpm@linux-foundation.org, GalShalom@nvidia.com,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC 1/5] mm/hmm: HMM API to enable P2P DMA for device private
 pages
Message-ID: <Z5ukSNjvmQcXsZTm@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com,
	lyude@redhat.com, dakr@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, leon@kernel.org, jglisse@redhat.com,
	akpm@linux-foundation.org, GalShalom@nvidia.com,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, linux-tegra@vger.kernel.org
References: <7282ac68c47886caa2bc2a2813d41a04adf938e1.camel@linux.intel.com>
 <20250128132034.GA1524382@ziepe.ca>
 <de293a7e9b4c44eab8792b31a4605cc9e93b2bf5.camel@linux.intel.com>
 <20250128151610.GC1524382@ziepe.ca>
 <b78d32e13811ef1fa57b0535749c811f2afb4dcd.camel@linux.intel.com>
 <20250128172123.GD1524382@ziepe.ca>
 <Z5ovcnX2zVoqdomA@phenom.ffwll.local>
 <20250129134757.GA2120662@ziepe.ca>
 <Z5tZc0OQukfZEr3H@phenom.ffwll.local>
 <20250130132317.GG2120662@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130132317.GG2120662@ziepe.ca>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Jan 30, 2025 at 09:23:17AM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 30, 2025 at 11:50:27AM +0100, Simona Vetter wrote:
> > On Wed, Jan 29, 2025 at 09:47:57AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 29, 2025 at 02:38:58PM +0100, Simona Vetter wrote:
> > > 
> > > > > The pgmap->owner doesn't *have* to fixed, certainly during early boot before
> > > > > you hand out any page references it can be changed. I wouldn't be
> > > > > surprised if this is useful to some requirements to build up the
> > > > > private interconnect topology?
> > > > 
> > > > The trouble I'm seeing is device probe and the fundemantal issue that you
> > > > never know when you're done. And so if we entirely rely on pgmap->owner to
> > > > figure out the driver private interconnect topology, that's going to be
> > > > messy. That's why I'm also leaning towards both comparing owners and
> > > > having an additional check whether the interconnect is actually there or
> > > > not yet.
> > > 
> > > Hoenstely, I'd rather invest more effort into being able to update
> > > owner for those special corner cases than to slow down the fast path
> > > in hmm_range_fault..
> > 
> > I'm not sure how you want to make the owner mutable.
> 
> You'd probably have to use a system where you never free them until
> all the page maps are destroyed.
> 
> You could also use an integer instead of a pointer to indicate the
> cluster of interconnect, I think there are many options..

Hm yeah I guess an integer allocater of the atomic_inc kind plus "surely
32bit is enough" could work. But I don't think it's needed, if we can
reliable just unregister the entire dev_pagemap and then just set up a new
one. Plus that avoids thinking about which barriers we might need where
exactly all over mm code that looks at the owner field.

> > And I've looked at the lifetime fun of unregistering a dev_pagemap for
> > device hotunplug and pretty firmly concluded it's unfixable and that I
> > should run away to do something else :-P
> 
> ? It is supposed to work, it blocks until all the pages are freed, but
> AFAIK ther is no fundamental life time issue. The driver is
> responsible to free all its usage.

Hm I looked at it again, and I guess with the fixes to make migration to
system memory work reliable in Matt Brost's latest series it should indeed
work reliable. The devm_ version still freaks me out because of how easily
people misuse these for things that are memory allocations.

> > An optional callback is a lot less scary to me here (or redoing
> > hmm_range_fault or whacking the migration helpers a few times) looks a lot
> > less scary than making pgmap->owner mutable in some fashion.
> 
> It extra for every single 4k page on every user :\
> 
> And what are you going to do better inside this callback?

Having more comfy illusions :-P

Slightly more seriously, I can grab some locks and make life easier,
whereas sprinkling locking or even barriers over pgmap->owner in core mm
is not going to fly. Plus more flexibility, e.g. when the interconnect
doesn't work for atomics or some other funny reason it only works for some
of the traffic, where you need to more dynamically decide where memory is
ok to sit. Or checking p2pdma connectivity and all that stuff.

But we can also do all that stuff by checking afterwards or migrating
memory around as needed. At least for drivers who cooperate and all set
the same owner, which I think is Thomas' current plan.

Also note that fundamentally you can't protect against the hotunplug or
driver unload case for hardware access. So some access will go to nowhere
when that happens, until we've torn down all the mappings and migrated
memory out.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

