Return-Path: <linux-rdma+bounces-3524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768CD9185B4
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320A5B26E7E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DD618A942;
	Wed, 26 Jun 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="feEKhsJo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61318C32A
	for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415531; cv=none; b=Q84j60P/rQv0sx5SNfpqaqfpW5btN/3mSrE7Tfr+EqLsqzU+0gfkzuZgupRdLlBFDIxmOlGxYOfsEm4rvYg3nMb4UJlShlTnKKBQWJffchQrKb4rihpy2Fe3xBc+fjzB82XKSAjWn2gEdRltHLUzPZ08IcSnyqT0MbWql2uBmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415531; c=relaxed/simple;
	bh=EHZR1GZqhhvEM/SxvJ5oM8w7ugHdI12FQjE7HuwaT/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esXzJHObO+bqTI9uWMizfPRy6d+v1HDTwiIBckEOAENvYmPcy3Rr+Mt/EFBopokFrXcKZMuU/IIThsLizIGOE6ouhgWjOUi007Owtp5G4j0OFhkidJjE2CkuwllRLHlvXA5hCGsKJFv+mJ5Pe74DidrWg28IKdehjX1/RNUCe44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=feEKhsJo; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-80f9e894b7eso1107711241.2
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719415529; x=1720020329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIGjSE4PWjuRQNSWCnLapYdSUQTn7TC/B7/KXpEiSE0=;
        b=feEKhsJoMpSPdVYuYNWJkE2G3Ht7EKKbONeff65V1tKoMt722zDD9uoqfnQz5KD+CP
         U7RVxD7dD1GG3oQgiUxAHm/FGsBtKra89ATdFeCm9A4EbPDMGPtMH5twtBsM0WBZqNv+
         K6a9qQWFuhze0CJwFmP74cwAjyuiEBkiwtU/FIPzdS2aFCLau+CVBdk02fpVaMMUHyIY
         34kCwgASnevNM7XmFaILRPKwGCGI+q3jCchErqb0XPrWa3vaz3Ip1hPllHUZDpTRts44
         5NHL/N61WJXU6pdmuFBdBBzzhMok68CCB6EV6rBx69xEUGN0eDfr7JJzoqUeNXgybgrv
         ZRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415529; x=1720020329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIGjSE4PWjuRQNSWCnLapYdSUQTn7TC/B7/KXpEiSE0=;
        b=eHNvGJXhFcsYNjPSD7a7JL4kwVYyFVz9Y0JOP9H1AkLOGwRStMI2kB01xtlHO7GXqd
         4H1+i6sn1aVZH3j1dRQfEE2wrBO9XafP9W/58lAu+d/iIWa0sFfRB14tkPLl3xT/l9WK
         RfdgOO8fNIYYbtOFLsyo/xMAg9OE2KLvGv8yrCEOqgWdf6cfKmBVv2qpQY0U0NMQbHPq
         SJWeG7XRhKM/Jgsyg/jlJI1BSazNdToHby/CncyVJXOGnKNZDcP5WeUhmZ7ClYDcjQuq
         JJRK5cc/tCs5p907y5foq9VQNb0RCdZNdZFI+7+yId3juLGYxXEsmppTDhCjJraflVim
         ER+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrUPOgzY73QaHrWpSHN6KvS4b5kPu3F6TxZn2F/VMHdQ6Jn2jgSLJtnH3Hf4j+vT+0YelK7tFO4JO3Q5bde2gmIC/icQI+Xv+ZMg==
X-Gm-Message-State: AOJu0YxulOr/QUssVsLoxZD77kC6eOjGHPumx10OaKdUQYPyKToNjeI3
	7htv4+Tjxcx743zQSv8Kjq1330qXhy/Gm47pR+IEBZDRvWNQopga0x6MUtOljgOB6Ly88joY8YO
	+
X-Google-Smtp-Source: AGHT+IFCybx2IWZ53e8yjjVdEA5pbBozcSJVksdLnS/q+pEBcqSyVEItEyWXOxVe2GAMvor1IQfNwQ==
X-Received: by 2002:a05:6102:214a:b0:48f:46df:3b7d with SMTP id ada2fe7eead31-48f52c92d89mr7908004137.35.1719415529083;
        Wed, 26 Jun 2024 08:25:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44501ee383esm14392081cf.5.2024.06.26.08.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:25:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sMUWW-00DXQ6-0w;
	Wed, 26 Jun 2024 12:25:28 -0300
Date: Wed, 26 Jun 2024 12:25:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fred lu <fredluo89@gmail.com>
Cc: jgunthorpe@obsidianresearch.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [rdma-core] Question about udma_from_device_barrier() on x86_64
Message-ID: <20240626152528.GX791043@ziepe.ca>
References: <CAHpo+uq5zfKTC0+cc8jSsdeoNcvsWfDRWS-zr242uprHZNrDew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHpo+uq5zfKTC0+cc8jSsdeoNcvsWfDRWS-zr242uprHZNrDew@mail.gmail.com>

On Wed, Jun 26, 2024 at 10:46:18PM +0800, fred lu wrote:
>    Hi Jason,
>    Given that x86 architectures provide strong memory ordering guarantees
>    for loads and stores by default, it seems that the explicit use of
>    'lfence' may not be necessary for ensuring memory consistency in many
>    cases.
>    So why  not remove 'lfence' from the definition of
>    udma_from_device_barrier() for x86_64, similar to the change made in
>    udma_to_device_barrier() as seen in patch below?

The trouble with these barriers is none of us really know the x86
definition well enough to be certain of any change. At this point
lfence is proven to work.

Perhaps it would be OK to remove it, perhaps it will mess up PCIe
relaxed ordering, or SSE non-temporal, I just don't know.

To even motivate someone to look at this there would need to be
benchmark results indicating there is a significant gain to be had.

Jason

