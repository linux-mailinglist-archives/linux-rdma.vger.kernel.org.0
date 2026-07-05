Return-Path: <linux-rdma+bounces-22767-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6C/BBM5MSmqWBAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22767-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 14:23:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CD6709F16
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 14:23:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ccYSssf9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22767-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22767-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 251A33010520
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4037DAD5;
	Sun,  5 Jul 2026 12:23:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E3347C5;
	Sun,  5 Jul 2026 12:23:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783254215; cv=none; b=o+Vji4pf3oEv2doa1haQO3G/BBZC3wR/RpHYCEtvsTBOIR17pFIYCEzXpI5nyxyY+32XthkuRETScuejPHTv7UYUoKY9GeP3WT/q4DjS1+GSQi/iCvNyM5/Ntu8kLF3SfDdmFAI8rAZskM1iYKBFQk4+ZMlrV8Rl41lURf5508I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783254215; c=relaxed/simple;
	bh=4g+LZKfrFxs5XnRjSF67DG+do8egYrtWBYeY/0NkhHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YY+/utBb+xRJIKpnOTxlsfi1rmylA4XzUSVCYfBCIK4XzgRkpyGWJHFzNLuPP6ZoaXopMgxynCXUr+GfhHawJ2Aa/mwgLIZEMbmqYCfaUOEYN3lNq3DytCS9bSq9J/78eq1M22BTaBZJJwhjIqdIE7rq5WpaMbBicy+MJdhDCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccYSssf9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FFB1F000E9;
	Sun,  5 Jul 2026 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783254214;
	bh=IGRzBFpxYJkqdPzQVDMI1fZRLatIruYcnTLxOERf58I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ccYSssf9PRR8PwHP4idyfIC4a5Tuvsolrcr1NlRJoDipskp75VXrKmfNUagvOD8WP
	 KEM8rWEtl8vK9/emoPzDVTBazk3uOhW3YLkE2TOwG3uDSraPptNCZvyg9Arl0uKQlM
	 kguts+qjbUbXtycAJVrfRiDZ/gEbwqelnqzlngwJyKzb3qDH6aqqukz8gz0YzG8FT6
	 SqYNouWZppRsUy6U0yygofwzzC9vHM6ZAhC2KXvfZtfASxn2tfV8QR8ACYLF76DxPP
	 Gg3ub4A4l54AtdCBb96LG3VGRfLbamJ/R7pYmcM6WVw21WvzK0vII+BFXe5SozYSzw
	 MAZMma2SsgWnw==
Date: Sun, 5 Jul 2026 15:23:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jianhao.xu@seu.edu.cn, zilin@seu.edu.cn
Subject: Re: [PATCH] RDMA/hfi1: fix init_one() probe failure cleanup
Message-ID: <20260705122328.GD15188@unreal>
References: <20260627060159.2543686-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627060159.2543686-1-dawei.feng@seu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22767-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unreal:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32CD6709F16

On Sat, Jun 27, 2026 at 02:01:59PM +0800, Dawei Feng wrote:
> init_one() allocates hfi1_devdata before validating several module
> parameters and initializing PCIe.  Failures in these paths currently jump
> to bail and leak the devdata allocated by hfi1_alloc_devdata().
> 
> Probe failures after hfi1_init_dd() need a different cleanup path.  On
> failure, hfi1_init_dd() frees devdata itself, but after it succeeds the
> driver also owns RX state and MSI-X interrupt resources that must be
> released before postinit_cleanup().
> 
> Fix the early paths to free devdata directly, keep the hfi1_init_dd()
> failure path to PCIe cleanup only, and release MSI-X and RX resources on
> post-hfi1_init_dd() failures.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1.1.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have an
> HFI1 adapter to test with, no runtime testing was able to be performed.
> 
> Fixes: 7724105686e7 ("IB/hfi1: add driver files")
> Fixes: 57f97e96625f ("IB/hfi1: Get the hfi1_devdata structure as early as possible")
> Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>  drivers/infiniband/hw/hfi1/init.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Just move hfi1_validate_rcvhdrcnt() to be before hfi1_alloc_devdata()
and remove error prints.

Thanks

