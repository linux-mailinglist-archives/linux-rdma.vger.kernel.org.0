Return-Path: <linux-rdma+bounces-22305-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q2jOKEloMmoxzgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22305-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 11:26:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F924697E3D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 11:26:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z63GtVAn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22305-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22305-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 385EE300B996
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE72F39E178;
	Wed, 17 Jun 2026 09:25:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9579385D9D;
	Wed, 17 Jun 2026 09:25:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688357; cv=none; b=gQV5WeN4hAWnBLsdgenpbha5Tgnp8YbuVTeUBGaLf4cA4Q+sqeAYTuenUznnjueFNt0/dpWzqJv07Idz5N2uvW+l1Zrj1DPyOi4vwkTQvpZgV7ioefZXXHubq6xUYdUnT7KvhV4hXbxYk/kn6jOwn4BiIjmS0/9JVgvoS2smuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688357; c=relaxed/simple;
	bh=pGPsGk9474Sf621m1a9EbjOhC8of9KJ1+NPcaOiGnuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjb1oDpmC0GsRsOz7Hoo/tbgtxOoXenVeVOgEqETlvigIK6WRGmvli/yIpErW5uZ6S0AtIlr4lSuuHXwVP1tTCQ4s3jrP0m5kZXAJV8DCgljy7iNVDygAIffuKqxWhE3roivqkSvaOXGWr12qSL02et9abdkpcqnVsAcRW9qGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z63GtVAn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC1C1F000E9;
	Wed, 17 Jun 2026 09:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781688356;
	bh=kNmA5R3v1h2GDeEpX7P6zR+iU210JS6UXSK5tbKyMCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z63GtVAnM9NeW3gc0rqRwmF1LOtifNmvF8NAE6seJFxwvSzQ49A2iUaGhLRp+kf7b
	 y1LHKg+lNZ96uhLoh4qkUKHKUb4U2endrZi8748Y3lFHA9oGJzbOoOSoZqEGxdeM24
	 WxdZSogWzShUc8EdhB+0I8NQwDqIQfE50cCwQi+c2rXhzA5KQtcqdG8VGet0SgOy8j
	 Vyk/2yAclKoqFgloi2uv6SeZkI+ZyXHRnBGISXh8vD7t+xxJuCapPGOIak6pxZtcv2
	 L51XpN8+2XYutplBlxzaLsgs1DKzcqcPQ44L3c+JoZOnXf5uNmz0kN6H9EqYa0pxqo
	 1+tUJsR0u6g5w==
Date: Wed, 17 Jun 2026 12:25:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian Konig <christian.koenig@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 4/4] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Message-ID: <20260617092550.GT327369@unreal>
References: <20260615065912.2177918-1-zhipingz@meta.com>
 <20260615065912.2177918-5-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615065912.2177918-5-zhipingz@meta.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:jgg@ziepe.ca,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22305-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F924697E3D

On Sun, Jun 14, 2026 at 11:59:01PM -0700, Zhiping Zhang wrote:
> Query dma-buf PCI TPH metadata when registering a dma-buf MR for
> peer-to-peer access to a PCIe endpoint and use it to program
> requester-side TPH on the outbound mkey. If the exporter has no
> metadata, fall back to the existing no-TPH path.
> 
> Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> steering tags into local ST entries when table mode is active, and add
> mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> index.
> 
> For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> creation and release it again when the MR is returned to the pool or
> the backing mkey is destroyed, while leaving the generic FRMR pool core
> unchanged.
> 
> Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> modular mlx5_ib builds link cleanly.

The commit message explains *what* the patch does, but it lacks context on
*why* the change is needed. The 'what' is mostly clear from reading the code;
the important part missing here is the rationale behind the change.

Thanks

