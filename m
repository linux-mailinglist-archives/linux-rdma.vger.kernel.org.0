Return-Path: <linux-rdma+bounces-22233-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3hc/GFvwL2p0JQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22233-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 14:30:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E66686388
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 14:30:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jOQb8l0x;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22233-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22233-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B78D306D621
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B63E8351;
	Mon, 15 Jun 2026 12:25:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E130CD95;
	Mon, 15 Jun 2026 12:25:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526306; cv=none; b=jUH+jvflmVUaMHImE7a+B57bl7kqMSxGvHVDDASewWJnEjQa9Eb9WqhtH9naxI7+sFRWOKwOVi2hzhEOIGxdjzTbrRsdTNAo9gA59iLmCTtZiC/9+CL0HbOC5Rnwrv7dXbNodrra89gKPiUjeQgclqTdjqyRFbAMghnvQRdBmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526306; c=relaxed/simple;
	bh=BhZyPrFHfFCI2uYZ/ZfVpNsFdCKYdFUVl/LN8PH88L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDy9GwMD7SUvhYJ9hNiecYoM73Byqy8fTqwRdFQTkhymz6u3Gh1lpG7T+zPQVV/x7LkBWN7wHP7rDigAH2VueyiwCioksLqFYDOqPGjLnFZxS3v94nyyC12ku6wURflvN4FjAueA1J/PMfo7iap+MEjDqOs5a8F6egcuLeZFqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOQb8l0x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5299F1F000E9;
	Mon, 15 Jun 2026 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781526304;
	bh=R6hOtI8UaFHkE4M5u8Uc+3LIthWmoAE3HwYQQathdZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jOQb8l0xPCSazAlerFYQKsTGaWyXCmPqTBPLJrNrr7ErbkqBVEkFzz+FXglBT+yRf
	 SbHysIbxQjpVXpRloLEhDCCElGra4MPLSvhSg2df2sdH9Y6+1bBvPYFKLHmfOqjjpH
	 TbJ6YS3Z8O+2AzWp6SkaUq52aYF+icvxGNhp78RwKNPuS2sZw7Siee0cOV5HqQQqNl
	 a7Wn9WBD0+2yzObScKCI22YUEmIF+y7Z5fEtzpznIufHET5aDpjBkehqvGlO92Z5sB
	 7KL+SWvbyClwPKclG4llyt9r2KdD1KQFSx9YyYo+67aC7x53+DvbPgzpt1ef6djkqW
	 5oZcdVMtjy5+g==
Date: Mon, 15 Jun 2026 13:25:00 +0100
From: Simon Horman <horms@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Fix L3 tunnel entropy refcount leak
Message-ID: <20260615122500.GI712698@horms.kernel.org>
References: <20260613153631.1752-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613153631.1752-1-lirongqing@baidu.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22233-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8E66686388

On Sat, Jun 13, 2026 at 11:36:31PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> mlx5_tun_entropy_refcount_inc() counts both VXLAN and L2-to-L3
> tunnel reformat entries as entropy-enabling users. The matching
> decrement path only handled VXLAN, leaving L2-to-L3 tunnel entries
> counted after release.
> 
> Handle MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL in
> mlx5_tun_entropy_refcount_dec() as well so the enabling entry
> refcount remains balanced.
> 
> Fixes: f828ca6a2fb6 ("net/mlx5e: Add support for hw encapsulation of MPLS over UDP")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


