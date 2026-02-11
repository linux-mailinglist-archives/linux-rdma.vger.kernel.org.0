Return-Path: <linux-rdma+bounces-16765-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAoGCnOejGmPrgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16765-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 16:21:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 876A0125923
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 16:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F8D7303A264
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13C2D77E3;
	Wed, 11 Feb 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="B8mgWjQd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1C2C08C4;
	Wed, 11 Feb 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823067; cv=none; b=p1AVxF5Yo26/XvJh2gvzN+E8Vy9JPCIkpUy4/loI3K15W2StbUE6K1zTMiLqNDns/xtOUBxZM/ItTrUhESd7E6jsZxKjLsnbLbTiXcwxGPSfeuJ2BeHAFIl0QZB3umHS4DZCqpzwK8DdBpchZfHM0oPsttsWhhQu/jQl+3oo2Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823067; c=relaxed/simple;
	bh=0MLZxyQknulDh/U4SeQLKQDGwHPJs/KtVJ4GWJBwLV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaXis2GGMop5FRsqtkqVymkOSmj4ofO+w5sqcy44pgsb+MESgTtVYBW53KYikc/EP2QEKcfWOasGXAfs7swFtgIwL4TUrEBHTMsB+YpDE1xhyveCEOoGf2nCvVOs8rKynnvEosgC5Hei982mBGhSih7O1Bj1F8xx3kN+Ek93FLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=B8mgWjQd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fCt1mXtXsrM+uE3o2ZX6dd5zNn3nWdOqkvzF/O8Zj1s=; b=B8mgWjQdAB3gusYf18Pfi4EIOt
	Aruiwi5kxYGkgVOjrTYgt49fOwTgEi5TuQWXp49Gfem2TxB8tebMkwVoW0dQ8AybDcZigC4KdEjoA
	QoUvTcjSQ0mDa1MAaV14q0RhnsUbApuiEaJk7SKvaNSdsQ20/Iz+STMWWBvkzHxXlyZEWPvVAbCfs
	lwQ7tJCHfRxGlC3DhaAGSHAgVey+PiJhqZGkUdpuUlPFiLNkADgSq1u6Aj5pbcOEaQ7P1pol+v+ug
	vCFCnkg3gA2+D3aEtK5+LE73eMSBm4CahjAuaWWfCWJR7/NvIiwUVLtEtzI2LACPwYr6m4dNRZ0OC
	/qjgwVwQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vqBy9-00B7bD-LL; Wed, 11 Feb 2026 15:17:34 +0000
Date: Wed, 11 Feb 2026 07:17:28 -0800
From: Breno Leitao <leitao@debian.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, dcostantino@meta.com, 
	rneu@meta.com, kernel-team@meta.com
Subject: Re: [PATCH net] net/mlx5e: Skip NAPI polling when PCI channel is
 offline
Message-ID: <aYycsIGsth4ob1sU@gmail.com>
References: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
 <09a77964-37bf-4b3c-bfa9-8939eb7761ab@gmail.com>
 <aYyHNGBPu0dEIEzS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYyHNGBPu0dEIEzS@gmail.com>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16765-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 876A0125923
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 05:44:56AM -0800, Breno Leitao wrote:
> On Wed, Feb 11, 2026 at 01:26:35PM +0200, Tariq Toukan wrote:
> > On 09/02/2026 20:01, Breno Leitao wrote:

> > If the problem is that the WARN_ON is being called at a high rate, then it
> > should be rate-limited.
> 
> That would be a solution as well, and I am happy to pursue it, if that one is
> more appropriate

In fact, I got more inclined to try to fix it in iommu code, let's see how it
goes.

https://lore.kernel.org/all/20260211-dma_io_mmu-v1-1-cf89e24437af@debian.org/

--
pv-bot: closed

