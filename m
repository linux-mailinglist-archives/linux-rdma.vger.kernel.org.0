Return-Path: <linux-rdma+bounces-20774-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFGfAKtTB2oqywIAu9opvQ
	(envelope-from <linux-rdma+bounces-20774-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:11:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3D5548F2
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7AB9304A9F9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D44C9570;
	Fri, 15 May 2026 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN/Af64x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5844BCADD;
	Fri, 15 May 2026 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864206; cv=none; b=dXk5M4L2kYgnq5DnVRNCcRW9qubZIxmVRwVGocjfrBFEIaVm/pympuYxTdlggrRN+TIZ241La2hA5VjJW3D9RSVIvxORg88mOaunOidyvr8ZNap6NUbQUyQzUwTz5FYl1Bh9bCKqXJQVOD02X3GBml6QO+FX+ZE3Nttt6SgSHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864206; c=relaxed/simple;
	bh=dZHgEcaZBIQfE1fvYidv499aEgftN6jjFY8pvgQKqmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCAmYz2rExTe06zmjwj25WYuP4ss1OTtqY1ImeuUtH5mi+wvfqnsTogV/eXrWlATaI6uBU11bNNTk80qaplWpbba8ubheMm2eXnOU+pIt98maTHwyAmdLEx6KKY9X9+WKvaks2468aVAh0/NSL1u0VVAprFwNRlXDn/DvJmmH8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN/Af64x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4C9C2BCB0;
	Fri, 15 May 2026 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778864206;
	bh=dZHgEcaZBIQfE1fvYidv499aEgftN6jjFY8pvgQKqmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RN/Af64xbNg/u1YS5KlA/eqkY1kPJEeIanb4/QGBrhMQryB7pSzhHEp4nSDXdmrS9
	 JKe5y0kPXp+q/V3Hs78g+cmmaylvS7PqyiEGnNTtfaJgZsLdulkr1Jf2iA73KWMfgF
	 JrgIz5h6F9KIP3CPtgdNkYJj7kp2L2Vju5m8hvBpf8RaMueYWypp9PxThPVp0MBZrh
	 5EkMeBkMXaeERogYPdYeqY0HvLR2ZanKBj+8/svwU7XyIfmSBbp0fUIw+Nle2Wifkq
	 jgvzO53yIh4gSJfG9AI8636Itb8hUb1ignxEMZVg43XdVWKbM+wJ/hxssRd974kAi+
	 MkQJeBXyV+Uzg==
Date: Fri, 15 May 2026 17:56:41 +0100
From: Simon Horman <horms@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/mlx5e: Fix eswitch mode block underflow on
 IPsec acquire SA
Message-ID: <20260515165641.GF227382@horms.kernel.org>
References: <20260510225903.13184-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510225903.13184-1-prathameshdeshpande7@gmail.com>
X-Rspamd-Queue-Id: 20B3D5548F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20774-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 11:59:00PM +0100, Prathamesh Deshpande wrote:
> mlx5e_xfrm_add_state() handles acquire-flow temporary SAs by allocating
> software state and skipping hardware offload setup.
> 
> That path jumps to the common success label before taking the eswitch mode
> block. After tunnel-mode validation was moved earlier, the common success
> label unconditionally calls mlx5_eswitch_unblock_mode(). For acquire SAs,
> this decrements esw->offloads.num_block_mode without a matching increment.
> 
> Return directly after installing the acquire SA offload handle, so only the
> paths that successfully called mlx5_eswitch_block_mode() call the matching
> unblock.
> 
> Fixes: 22239eb258bc ("net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


