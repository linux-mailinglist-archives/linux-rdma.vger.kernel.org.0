Return-Path: <linux-rdma+bounces-21740-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NyECJPJJIWpoCgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21740-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 11:48:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C13563EA92
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 11:48:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YyBmZV6G;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21740-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21740-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B46DF300D54F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9E5360751;
	Thu,  4 Jun 2026 09:32:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD286235C01;
	Thu,  4 Jun 2026 09:32:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565542; cv=none; b=rCHJ/WSctzwjG+t5uZx0PwzUvfq+YGU/Pr35sIMupbrvDiLyHymGuhiADvKQGUurCMiKtRZlOyBa4weGhPab4kUfMe11VPO3NEu3upb5WDiQlp/Awkt+CAncfTos5SRRoZ3VliaF6PYqstOiURu589D02xhH2QfnMyrPB5+ayw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565542; c=relaxed/simple;
	bh=B3nQpGwmWoSnmHoeESFQ8ouMT93agTVIZNNfSDTw4/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee+eoX5lk8M8dJ5+JmQoxZ42sukqhVLenGBKShUf5Mj+awM90FbHQnAoYw6abhC63xmTXs8dR4DCAZssz+Vd566KqvnGmyqBa0V4cUvvZKmZ2vuSNFU2mpaFBuoayVz8MyS4bkLohkWXmm6dQVjlSYcJS73rBnkAZO2oOiF/Hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyBmZV6G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351901F00893;
	Thu,  4 Jun 2026 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780565541;
	bh=VL4VWJzeB4HS/d5/cXGyc8snM32gvnfTLIvoAz8tltQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YyBmZV6Gj1cw9+fUsn3OpPTIY9Tyirfyxsm83lLN3kFPcSdTGF0yVSUxogeAb2e1P
	 J78K+BfC4V5oCLrld/ZQN9YCB6IWjWnEy/rugxGH1SIg8f7f2cq58kd1kPalTrfzI4
	 C1h4rNNbbqj72uVVO24Whsil5lDipwmnr/SLilAHvzg8v+JEVqUoXYYLh8h5wSdfm7
	 ugC8+ZXKrFXGqM9G5fSMqyj0Oy6WY2patYjjbOYqvtI4DDG0JCGfcrHr5kEA9m8voE
	 ABxzBaK9bErXK1fNgIyifJciezd74niTT6ODNyaBjV2djZqDyoJZA9Cx9tRQtn7bZN
	 GYPSYu1bo0YdQ==
Date: Thu, 4 Jun 2026 10:32:15 +0100
From: Keith Busch <kbusch@kernel.org>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvmet-rdma: reject inline data with a nonzero offset
Message-ID: <aiFGHxci7FnDRUL1@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me>
 <ahm6Ksr3rfGdnOsN@kbusch-mbp>
 <20260604084624.120032-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604084624.120032-1-hexlabsecurity@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21740-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kbusch@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:linux-nvme@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C13563EA92

On Thu, Jun 04, 2026 at 08:46:33AM +0000, Bryam Vargas wrote:
> A nonzero inline offset is never legitimate here.  nvmet advertises
> icdoff = 0, nvme_rdma_setup_ctrl() refuses to use a controller that
> reports a nonzero icdoff ("icdoff is not supported!"), and
> nvme_rdma_map_sg_inline() sets the inline descriptor addr to icdoff, so
> a compliant initiator always sends offset 0.  nvmet_rdma_use_inline_sg()
> likewise assumes the inline data begins at the start of the first inline
> page (the RNIC DMAs it to page offset 0); any nonzero offset also
> mis-describes the scatterlist even when it is in bounds.

Wait, is this accurate? I'm pretty sure icdoff == 0 just means the host
can start the inline data immediately after the SQE, not that it
necessarily must do that. My understanding is offsets are still allowed
as long as the total length fits.

