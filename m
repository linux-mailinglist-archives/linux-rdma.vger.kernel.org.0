Return-Path: <linux-rdma+bounces-18114-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH6tEnjMsmlTPwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18114-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 15:23:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295F27344B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 15:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5D2C302FBB0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954A366DA5;
	Thu, 12 Mar 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/liI36l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA94347FD0;
	Thu, 12 Mar 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325349; cv=none; b=hm6IKJGyMNehLc4E0B21j1SkW9SJlRN7gs0xM6k4HPBIJlZyEOer4zXNHxq6enfy0WX2qzuUUcVxCP87Zc/XRRwIplDeNcanjxAvubEXg23sQ2L4LHnllIWVk5zHCmG/yEh9a0vKsytzbfVLj5/uMah6GEEuN3R5ulAe84v5e5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325349; c=relaxed/simple;
	bh=0s/R2RrhccOYlnxsTjyWadJAfgJmb6s/tMtg79chIiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbL64U8qRV773itJnk8nc7tgrRVdcZfsJnrkVYqXIhP8PcVrJ3V9frgrc33MGGPdynVELWdzhvE5Uz6rb4QFKTPvq2hjLswOSY4ydkCqd9I2XdM/8k9bIlbUQcHcG7e6yfp6KWw+YIZnXFRYSA9Wq3SR8cFTOWXSWhuW/zipH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/liI36l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8296C4CEF7;
	Thu, 12 Mar 2026 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773325348;
	bh=0s/R2RrhccOYlnxsTjyWadJAfgJmb6s/tMtg79chIiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k/liI36lgaLsXZEiA6lSPz0FqJIIOVm0EjShKPuee6L1gKgZLDPSfcnngH+QdBZhT
	 pu9LX8gcO6pNhnAIF/cdLh+7N13XLQdKOwggVpCikbxP7uRrg09oEWA8Fj41PR+2D4
	 ZdyZRPvAXQd8mx50LPc0O1PNHfvCdQLLJLsh/zh+5M9MVDx7KJLsLNRLPZOhPDlkYD
	 DzqFeu/XO+UFByPrgM2uNRnzkWxREafHNuSf07CXFazSmpb8CzvVC7/HZMb3QFRS2t
	 yGwH69V+CmWEy1XM16qe8k+LsrYRBwlsF/qKBlg5BfpY2qvsI2lq5T16LthG3LNnwx
	 PyrjBHDJGk6Rw==
Date: Thu, 12 Mar 2026 07:22:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 3/5] net/mlx5e: Report TX csum netdev stats
Message-ID: <20260312072226.7d77b38e@kernel.org>
In-Reply-To: <ec3a32e5-f866-4cb8-bbef-1bce699c461b@nvidia.com>
References: <20260309095519.1854805-1-tariqt@nvidia.com>
	<20260309095519.1854805-4-tariqt@nvidia.com>
	<20260310201852.0d5d1712@kernel.org>
	<ec3a32e5-f866-4cb8-bbef-1bce699c461b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18114-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8295F27344B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 11:50:10 +0200 Gal Pressman wrote:
> > Looking at drivers currently implementing this it seems like the idea
> > was to avoid having to increment two counters in the drivers, given
> > that TSO always implies csum offload  
> 
> I don't think I understand what you're trying to say here.

The existing drivers seem to do something like:

	tx->needs_csum += just_csum + tso_segs;

IOW for packets that need tso/uso they don't increment any csum stat 
on the fastpath.

