Return-Path: <linux-rdma+bounces-4377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B705953864
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 18:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5371F247A8
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C81B9B57;
	Thu, 15 Aug 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RxZFR+TG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653F1B9B4F
	for <linux-rdma@vger.kernel.org>; Thu, 15 Aug 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739896; cv=none; b=PcwIiugDEYVcZfPjOXPXwCxeZIadoepRsVf3OJWZ6m7LIbtywf/B7WDZ2Vow/jm5C9zoNyX+NQnSGcOaFoqJ+P5PfCi2pNSJhi/BJNJjXwHdirGUvuXhK6Sml7Z/Qhe7nm51tz65QDyjUlG26cojt2zrBgnazNNFXJTxQ0xOCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739896; c=relaxed/simple;
	bh=jMlAZu9qZMpTmt+5bgGh6ITXoRYe8d6SMHX+V0KtlmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwHE2jgNNAHunRPD1h4AKk/HyxkjyBkuxJI6jcRHephxwQB7lM3PRv1QcZp7doXEUWWbIMcOQqX1Au/2ESsCK1oEbLCQm7uf1yaqT4D+FKENZcmvrjJJiTce1/xEa8RLrEjZTWCvMhwmqfq9/khjdxUvTtMs71SPV1ti4AcbFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RxZFR+TG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1da7cafccso69197485a.3
        for <linux-rdma@vger.kernel.org>; Thu, 15 Aug 2024 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723739893; x=1724344693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFTNWVqUYfCcABK8DrDnvPgSGbZWu7816sHlk6jkx8Q=;
        b=RxZFR+TGKXTQDbsqzfpah1I/T7aVTA8+O7fraZQ1XN35/D1ZQ/ZfVl8ByRPdKn4wcd
         OQUVQOhEx8Xg8/Xnh+hgKJ9EaT3vEbprJ984B3WeS+iypYy2VDg0ZlYO75fZ3i5lfNJq
         pTOmhwq5c68cnrHkxatzbADmXpqQJjv0oF4cM/fUWFebLQiJ4je4Wo9mSYEMsR1k/apC
         8O4cdeJpS9vHrjQqLVRQlijA/p1pH249Mw97rKC9e672XY0Dsn6QJ3PY0vusb/rBXBHt
         PWYSJ8Nbw5sDGrJSGLOLzvOwYzCJCn/N4MlxaC7OudvAuKwazHGEM9Nqu6yruII9e1vY
         67dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739893; x=1724344693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFTNWVqUYfCcABK8DrDnvPgSGbZWu7816sHlk6jkx8Q=;
        b=rtlBT3f1sNzy05hc48kIWxRwwmVeCH6RTvObYC2HpNLK+6PgRFZDex0M/F0b4bEz7m
         2hNzwpFKaQxebCqxYoM87jIxQq0QR27aFSD9j8U/jnB6oAojtvutyqkkjXtx90c3oXjy
         zs/rvyndnO6spsAFNXpIyfSkgla6gXGFtMKJXFl4a3+QwkiKijAjz/yXmxdx8aU6zU1I
         NJ68wa451BgTuhvVIVSvmhHUjW8nmix/V2dxMOIHk7l0eTc/BFBLc86KHfuSh3LVXbOg
         XtOvn3hIoITLPpKeZNn+P+rvRunZ9Rdh6EqoUBLqFc4zzATC6gV5TRm6hHU92iLj7tV/
         4QmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU9b0wWw69/t5MbPy0l/hO95O0H8vcrg+lBGgPJ2EUf2ZqHRjDeqdNsKmwdpZzS94I2kTfcoZJSle1bHjOAqQ/rRz/uyVaQqlSYQ==
X-Gm-Message-State: AOJu0Yw5q02/tEb5XAoXTiaa9zuBDg27BtQ73/9kyn+A8dlsfph95o2r
	6w4E9hf76ztBqJ1QROTLL1KGTa2Vhml8fSBGsunmjY0PpY9zzSsLK5GsNfnfpUE=
X-Google-Smtp-Source: AGHT+IHgB0euuLtojBmxwtFUei6W+/O9qvNh5LVT/DjkRkyeMw0VoI9tWPGBOYRiGDcx7MYqyoTeqQ==
X-Received: by 2002:a05:620a:4102:b0:79e:ffa3:d6a5 with SMTP id af79cd13be357-7a5069e5d9dmr18058585a.64.1723739893409;
        Thu, 15 Aug 2024 09:38:13 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff070181sm77535385a.63.2024.08.15.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:38:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sedUJ-0042Yt-Bf;
	Thu, 15 Aug 2024 13:38:11 -0300
Date: Thu, 15 Aug 2024 13:38:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Oliveira <martin.oliveira@eideticom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v5 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Message-ID: <20240815163811.GN3468552@ziepe.ca>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-4-martin.oliveira@eideticom.com>
 <ZrmuGrDaJTZFrKrc@infradead.org>
 <20240812231249.GG1985367@ziepe.ca>
 <ZrryAFGBCG1cyfOA@infradead.org>
 <20240813160502.GH1985367@ziepe.ca>
 <ZrwyD10ejPxowETN@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrwyD10ejPxowETN@infradead.org>

On Tue, Aug 13, 2024 at 09:26:55PM -0700, Christoph Hellwig wrote:
> On Tue, Aug 13, 2024 at 01:05:02PM -0300, Jason Gunthorpe wrote:
> > > Where do we block driver unbind with an open resource?  
> > 
> > I keep seeing it in different subsystems, safe driver unbind is really
> > hard. :\ eg I think VFIO has some waits in it
> 
> Well, waits for what? 

Looks like it waits for the fds to close at least. It has weird
handshake where it notifies userspace that the device is closing and
the userspace needs to close the fd. See vfio_unregister_group_dev()

In the past VFIO couldn't do anything else because it had VMAs open
that point to the device's mmio and it would be wrong to unbind the
driver and leave those uncleaned. VFIO now knows how to zap VMA so
maybe this could be improved, but it looks like a sizable uplift.

> Usuaully an unbind has to wait for something, but waiting for
> unbound references is always a bug.  And I can't think of any
> sensible subsystem doing this.

I've seen several cases over the years.. It can be hard in many cases
to deal with the issue. Like the VMA's above for instance. rdma also
had to learn how to do zap before it could do fast unbind.

Some places just have bugs where they don't wait and Weird Stuff
happens. There is a strange misconception that module refcounts
protect against unbind :\

Not saying this is good design, or desirable, just pointing out we
seem to tolerate this in enough other places.

In this case the only resolution I could think of would be to have the
rdma stack somehow register a notifier on the pgmap. Then we could
revoke the RDMA access synchronously during destruction and return
those refcounts.

That does seems a bit complicated though..

Jason

