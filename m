Return-Path: <linux-rdma+bounces-21436-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA9sCp+HGGq6kggAu9opvQ
	(envelope-from <linux-rdma+bounces-21436-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:21:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7EE5F6353
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F12D306D615
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A68407CE1;
	Thu, 28 May 2026 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyZNpRs+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5EE407CCA
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992196; cv=none; b=ilWgF18KRim3y2oJSfsLoUi3lT8xJBeX4lekjPoTRItqpZqnLmMo6rdNDMKkgUri6dCRoh4UU8TZd8i2OQTV5EIGfcoiWxv4wgfHkxe3qeI4H/n/lZemkpSgaKXemawEJfa9juJlHHNWHxBsPi4ziSv1eOLyy/a0yUTzIvuNJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992196; c=relaxed/simple;
	bh=Ds1Jip4Q+szH28JOmLE2MWPcuCX4YqkYawFCTzZTR90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5cpg5igKogWx8K4D17QadwHCiPJvnXT+z+kY9xF8sihtEhpIR/yxNek32oIbzQNBmhyjiRRh3Fxh0wEPvlFMagCMZCJ4ahqnSmMhtItqgQs55A9xl9OVImjmDbR16dqs2oHxZeWHmFgdj3u+Ga4t+gaQJSpOUIJ1U4EFZBp9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyZNpRs+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bc7b311e77so60798415ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779992194; x=1780596994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H98Vwp3bRkB0ayStNiyEfxNXiTSUpiEWRaZG/RbuOdc=;
        b=RyZNpRs+WU8aaHArotM1GhEH+4IG/W6JG/A180LYcb6mTAbHHfMA3yWAmrY+A2tCwJ
         hCaDauM5MjOTuOTGCKs0S+LnmxMyz73w/HFyeJIWiFBGq6owf2Ibf2s37PZw2q15/mXS
         6f77pnlux284O/7Id3CkJRFJpeeUeNb2UmM8c7arhefVic/AvOaOwKQ9ed537esl+aG4
         FYktz9N2sWlGqPOUNaO3T4IlEzWPJfu21Vvn1f7/T7T2nF54UnCmfcVNj953WncNb3MX
         jdeTrDcjKcPiXq/fbjjQ7vW7uf5M9eTU9HdmHeWRJx5Nfvn+Fh7aTrgghxa2b7/6A4Ga
         jhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992194; x=1780596994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H98Vwp3bRkB0ayStNiyEfxNXiTSUpiEWRaZG/RbuOdc=;
        b=lqChIZV+cOnYMKXLqOM2dzY9kdNkeK7x1YZMOP1624XzSHI9GABqnSd0Ni1roHuato
         xaatKHimphR9lPkFLzM7wFVyEtl/ii4DhZ2mIM+W04h/bKFmDZydDwLSrC2Ywv0+dl2x
         xQoL2INMgGzloYzOWkygdxx4Xqmq42PUd1NcX4AfivKY+tYxCfFLWv/d9RYE7tqEsfIQ
         Tb/PJPsAX9V588ZkHezDp87s3W/eJgvY5nqn9xQUhCiwxPILd81rVmR9Z/STj+QzfVpb
         DmOgMWNnTcbdROEo+jZNMjsFnS3jeVMPCe+TOsyauQTYBzdLNT8emm11v8Xo/thevqp0
         eMhg==
X-Forwarded-Encrypted: i=1; AFNElJ87YKGEvKYLsk8CEcaaG4mAFBaqVJrE0sSLJEEGVTZOn9ZFARz7FZfGn1mNxngd7xLcY2+bhZEQ2IWH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpln2VYsf5lFYoa19Qx7W0jEBevvM+2xw0NjR9G1potCEfGc57
	ibKKAj5a71NRWWZB+KphY0wsr0/n6VbJJqxN5lA+OfFJ2wCF263Ucwj+ZCNLXHMmyQ==
X-Gm-Gg: Acq92OHGYJLWp4/9vwL7IN2pYtz7XZDabQ6/ISBiiS4ilmNAXSWrJTbnRtcAD+dzwvA
	bhPWF6o0hpizqViI1AzZX7gyTzgiN4O2jGoVHpmCWDEDn4c2DCa8Fs0vo0GlkoFPfy9L912GuZt
	NkGAYV9ZUuNEooTBygGJx++eGXrJCyZUyjs2zIWzi1G8QHDLCcWpV7fBG5zMezQtn8F5p2NcVWR
	eCgpiPVPy2YPt1/W7GFY+PX2Is71p1kDD2W6tACTupZmhfPJkZ7ewQZ5m9F2c3tQztDZcOm/FJm
	k+6qOJeP1eQv4sz/S3I+OP1Vf7V/2kaKQGxlnGlmTfN/sR3yUR4Ve3USO5wqoHURzhx8CunNq/q
	foel2wYZ8Piy8nw36HEtnBWfJ1MuuueensUgVnA0C/gy6xNLHIHoGkw6EsDFC5OzIg3YOujaejv
	OLJhmaSSgyQEaR8HryTT305Gyso9cxD1GDuTIZaStgHvI3M+SLgQG6vBG7D/K510NyKGT+2YZe
X-Received: by 2002:a17:902:db05:b0:2bf:1845:baf5 with SMTP id d9443c01a7336-2bf1845bde2mr12584885ad.12.1779992193939;
        Thu, 28 May 2026 11:16:33 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dde4fsm198930285ad.67.2026.05.28.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:16:33 -0700 (PDT)
Date: Thu, 28 May 2026 18:16:30 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 05/11] selftests: Add additional kernel functions to
 tools/include/
Message-ID: <ahiGflOWOOk0U_b4@google.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <5-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21436-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6E7EE5F6353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-15 02:30 PM, Jason Gunthorpe wrote:
> These are needed by the VFIO mlx5 selftest in the following patches,
> which includes some headers from mlx5 and also needs a few more
> MMIO-related features.
> 
> - DECLARE_FLEX_ARRAY in new tools/include/linux/stddef.h (wraps
>   existing __DECLARE_FLEX_ARRAY from uapi/linux/stddef.h)
> 
> - dma_wmb/dma_rmb barriers: x86 uses compiler barrier
>   (DMA-coherent), arm64 uses dmb oshst/oshld (outer-shareable for
>   device visibility), generic fallback uses wmb/rmb
> 
> - ioread32be/iowrite32be in tools/include/asm-generic/io.h for
>   big-endian MMIO register access
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>

