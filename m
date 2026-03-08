Return-Path: <linux-rdma+bounces-17726-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JP8Krm9rWla6wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17726-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 19:19:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD20231985
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A10A83014694
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6958D392C29;
	Sun,  8 Mar 2026 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NSnqhmW4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AB30CD81
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993965; cv=none; b=LqwUyojfcQBcbaB26DQjRHQ192hwWbTGpQGj5DAviFtiN+HD/PW8XYlozl7z2vaWJjuYi3zmBq+wjQxK1pOmLirOSUiLtT+dbQn6LrIiPkpH94TNnZoHD5hrHD9+iPVt7/7ru1xOgSuISIWWukKm7tYNeSBFIvFyandeBEFk7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993965; c=relaxed/simple;
	bh=RFwQC+ynapVSJqHtn5HxtDxJR3xhkceo/7GA/6B7F8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0EdWnFjyeU42DaR6JxQw8v/Jp7eVxRbeBFvjWjC4immy3LOTY/g4t7knsMVQFPM/ZBtDDScv5C/EgtSR4mNq6LnMljkJLVRQyqz6ZiusJhJAVQjr5HFxzFimCbz+CwujHoLdhkvtC9I9qeqTwH6WUKWbenwDcv5ArvhwAGx4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NSnqhmW4; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50904a8f421so11610251cf.2
        for <linux-rdma@vger.kernel.org>; Sun, 08 Mar 2026 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772993962; x=1773598762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8l9HCiIJk8f6YJBdD7T3EgoBIxuKKvMDtuYccvH3ixY=;
        b=NSnqhmW4iChRXfe2lxZ7cshJTxxstp6S+yBIZcsp4Xk82pT2z6pheqN7RQMMHKBrCi
         g/pUtXqwZe/1lIyCFZoUqFeLyUryjPubE0qMegn7MrC8b1mHdhA0bReaQouYG5wf8ASg
         PRd1v4B4kbMPd8qB9JYc2AhZDRrvi5ULhlWmFX6xZr/JZ8bYa3+amMtn/lWIdq3JR3QH
         d80TfpbTF4mlT+vuxw9kW0YdD58LMesn/mEM8U/hfTucUpdhI23wqFFZD0iBUQmTcZkK
         pIpH7JInxVyHoaXEPHroaPNxqaxXFencPSbUD/hZ3iGtjgAhF/zeHFOWN8V08/fGZJFa
         n81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772993962; x=1773598762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l9HCiIJk8f6YJBdD7T3EgoBIxuKKvMDtuYccvH3ixY=;
        b=icbBhFTrERVdmuJvIGhx7QLUKefj+2bI8LtTKLv6IDb/2qUs/uWhnEXQLvrI2sEqPg
         tYiU72LdiunnR+Xq00Uwpy8ljLOFagYmEFA6iqbSGUv0qisliwrOXEjzD3IOhFJcQC1p
         NEM/A9uXiEYIycacP4197Wr6tNGwv3CPxmPTNrFsIOmS1sGwriBPUjEfKpS/mWWK7Dhe
         DMJSiuMAHZ9GSheNDS1b+zZATJ6m7DJkxWCTD8/RqvUgBfVLSzkgBspv0VfPbPujeegS
         OOaDyN3kQVqtNZjPX1QDQeB8LLRJo3HVbAWxHkTG2KxTI4O8ZOKsM4prIj8BwHGKGpYg
         b0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU5d5HTKTkS1Y0kDNigaJLgKgHz/F3Q03Qo9RtxlB+WACJIqbRP7oW5af+oZWiYrWlZJHYBlR/p2XNT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9jaPLxl0weBRCuxjqQeJfIvasqNUGMMFzq7cpBcENWQN9OXHz
	2K0JAkOMgVe2Lsw+pfTgbbaFfcvFFz5hmtTekFjHLKg/TLN76HNUe/pFcbWs9dTML70=
X-Gm-Gg: ATEYQzyNn4DGz/RrkpohOT9P76KaOC7nV3eebHt2IkSz1gCYtT5bWnreOhFzsZ8AWtO
	Awl2coc8/H1+IMJcoYKalaPG0oZPVxItQGNZgRjrV+zccdpk00moyFTgNAjC2Wvs80GcEWPMz/v
	ZMQEHiQOeWMbgz/OEA6Ay+BUL4FMMpRV7jApoFhhAmkSlTeW/N4Q6on1sXPUfBsDp030461rCzG
	J8UWz2vHaBKdchwD/v41thPYtQ1DNVw9nOfdwd+ByE2EyULlwxROUDE5Ex6GoR/+iHy92Sf9qad
	xPvkSRk7NjAsPaHITh7ct46xUYE6kZiqI63Exx3u1agoIDSaWv9Inw18ESCGcHSHCsKH/DZ2qWl
	7EznpN6JAWLPbBqJdfWo7TxuwR4H3dEm3gpsUEyhBlb9abnbisgF3hqjleG6JSEZGHT5MZC/tJv
	uSpLNrt9ZnlnaHGSJMmrnOQWQXusQPwh7lMaYwdut3+vDEV/DGGY4x29OfjuPSJfRz3WewbveEz
	3UpSZ4+0TlpQdlepYg=
X-Received: by 2002:ac8:574b:0:b0:506:534b:7871 with SMTP id d75a77b69052e-508f496e9b7mr109431651cf.46.1772993962390;
        Sun, 08 Mar 2026 11:19:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f653c566sm48622921cf.8.2026.03.08.11.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:19:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzIim-0000000AbBt-0YB7;
	Sun, 08 Mar 2026 15:19:20 -0300
Date: Sun, 8 Mar 2026 15:19:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260308181920.GH1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
X-Rspamd-Queue-Id: 4FD20231985
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17726-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.944];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 06:49:56PM +0200, Leon Romanovsky wrote:

> -This attribute indicates the CPU will not dirty any cacheline overlapping this
> -DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
> -multiple small buffers to safely share a cacheline without risk of data
> -corruption, suppressing DMA debug warnings about overlapping mappings.
> -All mappings sharing a cacheline should have this attribute.
> +DMA_ATTR_CPU_CACHE_OVERLAP

This is a very specific and well defined use case that allows some cache
flushing behaviors to work only under the promise that the CPU doesn't
touch the memory to cause cache inconsistencies.

> +Another valid use case is on systems that are CPU-coherent and do not use
> +SWIOTLB, where the caller can guarantee that no cache maintenance operations
> +(such as flushes) will be performed that could overwrite shared cache lines.

This is something completely unrelated. 

What I would really like is a new DMA_ATTR_REQUIRE_COHERENT which
fails any mappings requests that would use any SWIOTLB or cache
flushing.

It should only be used by callers like RDMA/DRM/etc where they have
historical uAPI that has never supported incoherent DMA operation and
are an exception to the normal DMA API requirements.

The problem is to limit the use of that flag to only a few approved
places. I fear adding such a flag wide open would open the door to
widespread driver abuse. These days we have 'export symbol for module'
so maybe there is a way to do it with safety?

I'd really like this right now because CC systems are forcing SWIOTLB
and things like RDMA userspace are unfixably broken with SWIOTLB. The
uAPI it has simply cannot work with it. I'd much rather to immediate
fail than suffer data corruption. Jiri was looking at adding some
hacky "is cc" check, but I'd far prefer a proper flag that covered all
the uAPI breaking cases.

Jason

