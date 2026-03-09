Return-Path: <linux-rdma+bounces-17780-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCq1CmbKrmnEIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17780-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 14:25:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C0B239B52
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 506C930A1E11
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F063C1967;
	Mon,  9 Mar 2026 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CN9uuD88"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764613B8BD1
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062441; cv=none; b=dL2jPZI3kxShMSPI5NtDmzFx32U9mzEHIlkX5Q0tZhH24hNFDfj8zri+Si5+/ZudHd9stLs0pGl23ZUFohAXyw3tXwHNIF07loeK5KYzrBRvshXmS3RChwkLC+E5cWOntoIZCnSBJ3CcKjJZWa/pEmqS5/VQ5FFymbfkDkUy+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062441; c=relaxed/simple;
	bh=j2vrFZdiKMAYuLt1g2IsWM44uA/l0EgALyShPIZleAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMXjdIIlBTuBm2CDGDYEc+9gvYleKLGjvg5T8k+oXQAE/+YSn9JNH3R7EuKnwQjGS4uwefuV82oJJy6hmHQPgpqB6UqCgOT6TcXDsUh9xsumc7UruCtZ8wctqIufMjvHYAPDTavUVwtSJPIJsELiEjGrYABGo2enIq4LSJnrvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CN9uuD88; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899fc265126so107685766d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2026 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773062439; x=1773667239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNhIcDXSP15bQbG0gfsf887zPsyic2zzORmBXzBTWec=;
        b=CN9uuD88F9vzYXsS8YRsdthDpxhCmm8pt01yMkmT7p4xLFpxceiHKIFtPZ4QGlRhs9
         jQSYQo7GVpZu1sYH68J2aBQBoAuz2ouHVjKzFU70cMFyPFdxL9l1OJGm68+SiFgsw1MP
         EtuThe0SAIu0IAOvpi7DEe96q9kLUytvrnXv5Q9zKLtX12GylYbQ2NT9JVfLGJ99I0q0
         U0sNAsqfVOT7lgxGq5DeddaVzWO2s2uFvtBXSL73WXYg4pHJCiwbay5Dvu86Z30irVjO
         w2Ji+IeYley+jt5A0tx4V8orkd84yiaMoBzcmB0psmQUdSkZe99POfLBisbOzr5U4mrV
         i4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062439; x=1773667239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNhIcDXSP15bQbG0gfsf887zPsyic2zzORmBXzBTWec=;
        b=eRMc7GhM5bzznB0t6RVzgpBJN9z3Pr5nBcuBzo0mMYYaAtyw60p8wmgFyuJ4W0kJNQ
         NovbZScu+Dt9NFq7bsVw0/kAJ1ij/icswqh8NKlLEi68GtoowNeN0sSjpbUKzC9xge7m
         Pvz8YBEnQlIMFmyHKx784BAjiPePZzEHMOIWKUwYN2w/dsJtfGmi2XqWjMxZaUbifd03
         AyBvoHJ54vk1vzl0a7Q1egIUf+hw6QSaJj5VgT6lfAv5XObHUZXv/x5NYYWGYB2kqfah
         S7tnUvWbkkaW1fEk3jbNY2ZWoaWNJ4y+oMSv2InITO8jA1B75gEzje1123OFQ4r3tcnh
         N9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcqRCURf+RvsrD7NHmH/Ct9Naov1UYBdCnSwscdI9ydSSD4ksFzxNwdppesOO2LNjqIqCM+pmJ+qBa@vger.kernel.org
X-Gm-Message-State: AOJu0YwgxwYvX+KHknYy0/w77rFvELQhyYpCO63RdHjU+C+k8rBIqhCr
	AsBufVXW7w2Ud1CZC0vXLzs7dJfWr0ZXtndH+OmsSWRwBff3Aynw57SkTnBCD0YB0fM=
X-Gm-Gg: ATEYQzyQBf/yTBAXwaHX4KDlvgA0wvqM9SJwjJ6f2IwOJPDKsIi1m06qXfmusjsPz1u
	fYzgGPn3HdWhtDUxW26NHhQcdB6zfH3oCFP9T3pojzwtMTFBo/RHrcMxGyCV4RZwpEApbZVN2T6
	peQg9cJao1Mgnapiv2yOrrbso4vLEEMk8gLT84QPKP/8xgEL5va2BgcnC2Gr3lapyMxwMA0BaA9
	Kn13sQr+Dmw7pBP00Hfag7nh3sfBMxOyUgrTXPO2WoZBbZwr4ABy5X/azYsjLbcPut+ftWSMVJN
	lyzAaClec8uiXnmUk1F5w6evvWFI5f7ULMMsaxqmBS2CJiBGHIUZG5bWY0qEXC5CzxcE/sLGYcJ
	4UZlixkyA2qNRUVrGRkPzuQDdyEJuU1bxTbJxV/QRy5eMGuiI/c9OKc3ONRyctS8hTpl8U/gHbI
	3lN+ewTvKMr5NxPHprmI2seeca6lI21IsgZk2luHzzFadNJQVIYnpXMleDnlEgaOffEE5IzzDX3
	zEfW/Hp
X-Received: by 2002:ad4:5f05:0:b0:89a:77:42d1 with SMTP id 6a1803df08f44-89a30c2c07dmr163990476d6.66.1773062439445;
        Mon, 09 Mar 2026 06:20:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140f7ebsm74752146d6.6.2026.03.09.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:20:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzaXG-0000000G7pH-11Zd;
	Mon, 09 Mar 2026 10:20:38 -0300
Date: Mon, 9 Mar 2026 10:20:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260309132038.GL1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
X-Rspamd-Queue-Id: 80C0B239B52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17780-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 01:30:24PM +0100, Marek Szyprowski wrote:

> My question here is if RDMA works on any non-coherent DMA systems? 

The in kernel components do work, like storage, nvme over fabrics, netdev.

The user API (uverbs) does not work at all, and has never worked.

I think DRM has similar issues too where most of their DMA API usage
is OK but some places where they interact win pin_user_pages() have
the same issues as RDMA.

This is why I'd like a new attribute DMA_ATTR_REQUIRE_COHERENCE that
these special cases can use to fail instead of data corrupt.

Jason

