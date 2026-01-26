Return-Path: <linux-rdma+bounces-16040-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBa9ACPWd2mFlwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16040-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 22:01:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C04B8D6C6
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 22:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E77BC3024286
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 21:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078F2DCC05;
	Mon, 26 Jan 2026 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KTPYxeta"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B42DBF78
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461273; cv=none; b=tewfhQOvHCkDHbDbeD/b+w3+KE6GmirhZbDtQFnTTez4CqpyUjbsSCDtkAA1DdO1K7cGiAnCaLWOD1n9/AQ/BXhEWBJN67yG5QU55VfznJ8y+sI/mODnfV9labcGqyzMsxedlZbR79n0GKtVb9r5EMncLSG1L/ycm+Lnd+PhuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461273; c=relaxed/simple;
	bh=/uBBJ41PsJ+poHfkbr45RI19WGdtV1Pwu8dAjRjrE+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPn2q2yFXD2urHYCmKUOaQFrf1Wzuz8RGUhoSGA5hqXk7lOvFFaWnJlN2pxOV3L9rEDJqeoTYt4LZDvj2q1A3N41/tvKkrMFH1bd2zoneiGkbGHecnpSEqMCUMv7xGHfDccNow/TGHZNToA71B9f9vIk6C91v9r7Jfb4WZeHLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KTPYxeta; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-894703956b8so76912946d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769461270; x=1770066070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu3uAyHuSXXXZq6VSWtVG72sHh/RWKg7/MHSYDvcONg=;
        b=KTPYxetaZVJvlzB6z/ibcN296ocJf+ii0brsCcDknUKpZd53MF4Nsrnt9PFuGdCvPf
         6hBJkjzdsY9IU1sWTOfcdDEzJ1Z/kNYIxSepDaD4h3YCSuVfmuSxp67QZnugOGQwZr2D
         4P3AfhKJYQuSQlWocd1ajXXLm48AAXYbQVA/jUBgCnypTz6JDt9UaBIVF6px671WWhoX
         d4rQrSpjUFDW56f14igx015+PRXkHoSOEFxvkl/nIibAgCiz4P6Jfy9it4sqotlARFUs
         jVNvax7g3fvFI5tewtPizooOxkNr4fWNEpObXZ9xlbuGx40NjuY67DmO1bH+fqR9L18M
         k5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769461270; x=1770066070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu3uAyHuSXXXZq6VSWtVG72sHh/RWKg7/MHSYDvcONg=;
        b=WSBSpewFlYHduDkkHutqbfbul0yI/1XXGA1xcHqjKgNPZqOqTP+Gzay3EAhmWBZ5R3
         3tuWaSFljag927P7MUBisGL6/tctEBKAl1Kfjxg5JGJtjBumhkxoLpQJl2oqt6ir+f+X
         RzUHT3zLMm4pZDQgkHHKuRQhdAf23XNogtihFno/xRoV1JjdbGdKIcsLjg4QNPwYDN/u
         JjbfTqMhM3dvDGOa+4IANVVnre9mLOsCCiOZqUO0FsgIIX2uPWUISPs5VM9Qbf0YMJE/
         A9URTxmYtGup/C7QYy40cjk7eek059Io31y5wrxpR1T2A6KbSpgJ01Y+pidC6sGWL44N
         kvJw==
X-Forwarded-Encrypted: i=1; AJvYcCVifDfU45AvRti4xYdhh4WKNGRV3cYkKPF1cF84eMx8YOYnQ1hj45rVDjjW9kRObyEuVX+zAg9NmtlY@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5tDVByEgBtsEG7g8etpdyYBc+vYZK7UFXEnhzrQJ3hDfdnrO
	U2AGfqt6za9t23iyNuVg7FhML2Lf+VeBVWhaQGtHEliL0MFsrxScWyTFPj3TjpkPDWc=
X-Gm-Gg: AZuq6aJ81i4Ir4F69t06NtZbpIjetMb6IT3+rmp0ioyCgADFkIKlMa3rOgK4L701VOe
	3eT8Qs2qKHbtQQoyC6c8HiKP9SHvUgiOAchNtKiFA7Ll1hcs1mb6xDC6B9D3SrBZJ7emyp/zRSO
	CnZax2mhVkf5ZnIvZX6VHBXyHE5WJfsNVV6jDqFSGzN+vBMn/vfeqg6iFLkG0lYCftfz0K49/H9
	NjIm7xykCtsge5W7d5OruL+etScdyb/lscXvPioVazvLPJ8Bf/gdTtb3S6E/RBGBTjn9/JGIofh
	yCWXUH6IqShXTn+It8ehzm2zi+VXDCXH5UwyL65kcwPO0ByxT6TptKj8nnw781v8rHmUL+EiY+M
	Obv9IYAlICahPwr5JHnGBUgxvL9HMv2V+2i6ArY+5cJQW0WUJAhKjm8yxdsma/zDopDVr+C4aeS
	QVapssv7P2UOEmJSBPtpoKr686Mt8309HMu065PodfkBPQReyOx7p6q1OugUib6t7TmhU=
X-Received: by 2002:a05:6214:1cc9:b0:894:7b34:dacd with SMTP id 6a1803df08f44-894b06f336dmr73487126d6.31.1769461270245;
        Mon, 26 Jan 2026 13:01:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894918b1436sm104983856d6.35.2026.01.26.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 13:01:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vkThs-00000008z30-31vX;
	Mon, 26 Jan 2026 17:01:08 -0400
Date: Mon, 26 Jan 2026 17:01:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <20260126210108.GD1641016@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
 <aXfQ1LFNDUrfeuHf@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXfQ1LFNDUrfeuHf@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-16040-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C04B8D6C6
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 08:38:44PM +0000, Pranjal Shrivastava wrote:
> I noticed that Patch 5 removes the invalidate_mappings stub from 
> umem_dmabuf.c, effectively making the callback NULL for an RDMA 
> importer. Consequently, dma_buf_attach_revocable() (introduced here)
> will return false for these importers.

Yes, that is the intention.

> Since the cover letter mentions that VFIO will use
> dma_buf_attach_revocable() to prevent unbounded waits, this appears to
> effectively block paths like the VFIO-export -> RDMA-import path..

It remains usable with the ODP path and people are using that right
now.

> Given that RDMA is a significant consumer of dma-bufs, are there plans
> to implement proper revocation support in the IB/RDMA core (umem_dmabuf)? 

This depends on each HW, they need a way to implement the revoke
semantic. I can't guess what is possible, but I would hope that most
HW could at least do a revoke on a real MR.

Eg a MR rereg operation to a kernel owned empty PD is an effective
"revoke", and MR rereg is at least defined by standards so HW should
implement it.
 
> It would be good to know if there's a plan for bringing such importers
> into compliance with the new revocation semantics so they can interop
> with VFIO OR are we completely ruling out users like RDMA / IB importing
> any DMABUFs exported by VFIO?

It will be driver dependent, there is no one shot update here.

Jason

