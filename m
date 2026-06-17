Return-Path: <linux-rdma+bounces-22316-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fiGWDKujMmpQ3AUAu9opvQ
	(envelope-from <linux-rdma+bounces-22316-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:39:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8D69A2FA
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:39:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e0CCv8GK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22316-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22316-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D903E321AAD6
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553FE408623;
	Wed, 17 Jun 2026 13:34:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F575407CC8
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 13:34:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703276; cv=none; b=H8D9VGQxj2UzmNCI5bjYJGGpGrzf2wBR0fFPkMTI3FKYdVA0odKTJuJ86krBbdQu8AbKNn69COwa90zDubNGgQ28ZggIfb1IFFIJ6vzgySCskyhd1EThpIlj/xtvwbXmnvBvPv2x4cN/jmd3NfwjjAvckRdPHI/a6DdcJr8RNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703276; c=relaxed/simple;
	bh=4ymlhHB/SuWo+Hlll0cXhF2ouOVQETxm+yCrJv9/utc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0L7OzGfuk8O8LPA0mEmdEWiAoIMz6u5DpIdjWVNayO3sRg4RJkLhC5Q5uJiCepUz/+ARWC8Lg50owO3OL/m8VnI5I/QXcm5ZOeflQ5YoQ0gYwkSW2FMcj7tAJPnm7k7ZSc2XDdCixvhbn05NWWX3Vm363+5gHFfrsbh0Uaqi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0CCv8GK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213171F000E9;
	Wed, 17 Jun 2026 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703274;
	bh=qYXP8Oz5zX1Gw1/QdJizBexO2nNNt3BOfsxcF2+/R0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e0CCv8GKpghIhsKDnwpA+sBPnB3CT1E4B6J7pPE6E8ORYoQKHm93X+P8TIxs6Soih
	 /Hs4RouansCxB4WYInGv+H6Pi6OLDDoYZ7zC3bGU7jMbEgQ3DV/sRXpfvOyl0dG4cE
	 MliZxyizTP8yuLmcp8TAzVx6IMeQVhggoHShwLiCJr7JgdAnVkJqct6LAH2Agnc6i3
	 0tWEbbxuGhfuPEab5iG9oLvf6eitZDBLjRi70iXGsriaFXFOaur/AMJ+VeHmGyRQwc
	 fqwYBQ8hYcDEkls5DrFSWGA/5I5D0NxDjCxbHQA9N9Rvy7JVilIeJKHoXEeeEGGMgX
	 YP+afzH4BffYg==
Date: Wed, 17 Jun 2026 16:34:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: ogerlitz@ddn.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mark Zhang <markzhang@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Fix hardware address comparison length in
 netevent callback
Message-ID: <20260617133429.GA327369@unreal>
References: <20260617-fix-cma-ipoib-v1-1-03f869344304@ddn.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-fix-cma-ipoib-v1-1-03f869344304@ddn.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ogerlitz@ddn.com,m:jgg@ziepe.ca,m:markzhang@nvidia.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22316-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ddn.com:email,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EB8D69A2FA

On Wed, Jun 17, 2026 at 02:21:05PM +0300, Or Gerlitz via B4 Relay wrote:
> From: Or Gerlitz <ogerlitz@ddn.com>
> 
> The cited commit hardcoded the hardware address comparison len to ETH_ALEN.
> 
> This breaks IPoIB, which uses 20-byte addresses. By truncating the
> memcmp, the CMA may incorrectly assume the target address is
> unchanged and fails to abort the stalled connection.
> 
> Fix this by replacing ETH_ALEN with the dynamic neigh->dev->addr_len
> to correctly evaluate the full address regardless of the link layer.
> 
> Fixes: 925d046e7e52 ("RDMA/core: Add a netevent notifier to cma")
> Signed-off-by: Or Gerlitz <ogerlitz@ddn.com>
> ---
> I caught this while reviewing the RoCE netevent callback, 
> the patch is compile-tested only..
> ---
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks correct to me.

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>

