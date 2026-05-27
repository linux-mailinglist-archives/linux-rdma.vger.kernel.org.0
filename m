Return-Path: <linux-rdma+bounces-21349-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB+JI67mFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21349-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 14:42:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D45E459E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 14:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B6A7301F82D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC5405C21;
	Wed, 27 May 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UVUIw1Pe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9E405874
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885402; cv=none; b=F6IgIHZO9DwLnw3How8HMrlQo5dHlXkGaPIuq6XRBy0RXqvGmEbKw8JP5cBQ5xftEp2wrzVQQZbEEKI8Efv39MWHVp3w0yGgQ7GzU1cm+cxVmrt6VmhsnFFp6usV9U16srY53lSx8Ll39z9QdnJ/JWXfQCkLg3Nx7BM6y0Xv7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885402; c=relaxed/simple;
	bh=H7p6mpDtDLxmKvgOZ4pgS/ak1T+DvZzVyyf47SslWwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHuj0uioZlH4P684y4J2BHb0iwJ/5z2b+3Rn4EFP5B0pKHUrK2gdW/SmVrZ4JOYK2lqxQWhDQpXwW8kO/4z7MNu94s+tDZnDp9t1dB9hSfw3RKE6GgyXoVCW0klTg8FkjK4Q95SHq0goxyPQyCxK7TNSOcFnUJUGtCXoYBJFLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UVUIw1Pe; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-914bf787977so389675585a.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779885396; x=1780490196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
        b=UVUIw1Pe+iVgP2MaWntCCcmTVdFtxJ43P4b9vkG6V1hz2oZ71ktASAYU+aXvwRtFzI
         4rmquspQgOIxfrJO7NE5Dfk+n3R9xiugHdCOzkWe7AYTGau3DVbRW89DDJrhC81sLaE+
         o6a6B18gLyrs7UQieFJwpEBol3hnlgs0gxkWfow1CvLpCIRXlNPoMJCkG96es13xPOin
         4d0BYlETpf3nX4upGpx0q00LdG5X8YdDbvKEf+fu3iB+XUkiBHhr4sI76mCB3WkEdpEj
         PTk67x4NA2ZHuWq9h9KCgW/rVZvP8Ncl51og1pGtrBnuYvzZHf6c6yfaTHPsQzPzcR1n
         17pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885396; x=1780490196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
        b=NTKarRGQIv+Xb+A6dIRkQuk4F69jeLBzIfFpjNTHqXD22lPnHY85Y8Mxe4t5+O08dI
         yVPpm1Ai10R503Kbvb1yQfh5Eq3joKBxKhXxWdi/kBokcezSRTADUBKi9cSZjNZSxnbl
         4oVoX5TMaTs9LCl+pOzRqcxY0eoudJdi6Z5HqFl/zL+t+8+j8soOqYLf7z+d+dggOyi1
         HMV/xf8Fufb97hhw+4yYKkBfX8KXmQV3Cn+aB5XAfLTmzojuPTGUpI+0n5AfB4AM93hB
         owXjbX6xI0lmUqTm7z/6mMUTYvglXBGm7sokaO8BM8yV9yghyJlnXpARQSVRMYbvenzN
         2FbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uzp04UJLx0fwMcsleqi5HA06F9VfveHVx9tW3tbo3QsoE5IEhAWRXWl4sgbPy2/04QTU/m7xVafTA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2DNSVPukfqtYFOrEhvt9JGry4GfgB06nIWLX66npq45yMAXq
	pAtfGS6ucDSE1fbHIJj0F65aYw2VymAEkt2FK3A3VPYUxuYd82gXQJtdHTSGIBi/708=
X-Gm-Gg: Acq92OGAtlwCxZ8dL2Wc5hBjuKqnibZQyLyZdRFkjklo1846gZVMhXeoeF8rbqfmmN1
	lx+arj22uQE7+jv//euXjFYqL4vdqWxhcR9zB2LbqfJ2TrcKDcBwJIUHmznxM0KAqDcq8AFtZJB
	UN3Z0CH/cl/1WgGkIM6FclxcLHPFKtlubDSfckh2b30EnlOsE7VMWik4zmCxlHccFmqQhNyHeZn
	SCoaWFFPGNn3pAh0Pj56oDe6Ji25otAIJmtFXDhwoxtWQ8oSMa9+p+Fg+XQNVdCSwYA4DZ/sYRm
	auW1aquEVnxnYNVOr8lGCgji/EaRyWlq+uubXb6VquiB3/NQoKtffRoD6dkcF6NZ0p0XKa/ozDm
	WLOIBcTl+ycdBYSsBbsRUVw9YxeLnIodGDmZ7lCfHI/gwnQgaHK/ATgPXfRmx2eGW8jVixj4ko6
	aL0/i3A1nUKZf8BRmL+cVGB2MsOT9xNF1LYy3f5Q+U1cLtxrpmLlyIyuDYe1GYNhPnOCxuTPYhz
	XJMLg==
X-Received: by 2002:a05:620a:438a:b0:914:aaba:8d2e with SMTP id af79cd13be357-914b49336ddmr3211226285a.14.1779885395945;
        Wed, 27 May 2026 05:36:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8800e1dsm455621385a.34.2026.05.27.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:36:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSDUw-0000000EOYw-0lyZ;
	Wed, 27 May 2026 09:36:34 -0300
Date: Wed, 27 May 2026 09:36:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260527123634.GK2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21349-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A1D45E459E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 02:23:46PM +0200, Christian König wrote:

> Yeah that's a good point, I should probably rephrase the question.
> 
> I'm aware of how TPH works by adding the extra ST to the TLP.
> 
> But my question is how is that useful to a PCIe endpoint? What is the effect of the ST here?

TBH I've never heard Meta explain what their device is doing with
it. At least it seems to be super important to their device..

Jason

