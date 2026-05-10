Return-Path: <linux-rdma+bounces-20319-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ4UNvTWAGovNQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20319-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 21:05:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1D6505E2B
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 21:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9251300CC3B
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B133264F2;
	Sun, 10 May 2026 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEVolGo3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BBD128816;
	Sun, 10 May 2026 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439891; cv=none; b=F3KZ01kRZbC4oF6hprDH+0E1mCheRBG0Z7+8suIW5LVi2xnqzsHLz51Ghy1xhQudOJfEJXdZRFtUEkZflsv6ayJ9QZ3pQkHadgjV7UfENjp7A0e2ZciFCX9ohiD2uRsD5gKbZo0/lCwtn92urFtxowYum/caeEcrN7xemE0CA/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439891; c=relaxed/simple;
	bh=aQbc/QVq95sGucB9UEvS4jGavWCx7gSfzspn9++JN4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q25thDF4jj+7UU5x2Dv2x2KQxfujcfziOlrOl1ufKnn1Mr52Ol2P9eoDW8UhtIWl2YchSogz0Lwd2CTg2KY4XZE4BISzLoOzTD+8rCYPei1U4BcnV7Pmo2wH/nhF1tdjBj6/pRbUlHRAUNTErcEIOC0BxNJMIaRhXUTgVxg4III=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEVolGo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C42C2BCB8;
	Sun, 10 May 2026 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778439891;
	bh=aQbc/QVq95sGucB9UEvS4jGavWCx7gSfzspn9++JN4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEVolGo3KMx1vDtObZeSeGH3B463rY+XqoJy95YboL15xmfThE4QwCEqzNPmvcCRV
	 wJ2UZK7ohPTqxtGZ2slRGByZ6nXMQdqcwy/+zyblvRplTzzOJ+QsFXZ53VCpSkpZ7P
	 yp5juwgMVH+jHinP6Nmw1NLrtfb49vzkkc0KAEXinqcgLbsUZuCIyRl9I4uUpdzLHB
	 ZXW3z5F8xFXojxsGCclph3gXgirxeD+a7OnEocoXx+hOx7jmgoa7CRWqgBQk3q231r
	 VKNDHYEqrYrH8YXk//KXqTFbSJJl3IUWC7fBebXF6aC1RM7lu4butZJg3Eu32YdCui
	 kFLvKe1h07ppQ==
Date: Sun, 10 May 2026 20:04:45 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Christoph Paasch <cpaasch@openai.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Vlad Dogaru <vdogaru@nvidia.com>, Kees Cook <kees@kernel.org>,
	Alex Vesker <valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: DR, Remove unused field of struct
 mlx5dr_matcher_rx_tx
Message-ID: <20260510190445.GZ15617@horms.kernel.org>
References: <20260507173443.320465-1-tariqt@nvidia.com>
 <20260507173443.320465-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507173443.320465-4-tariqt@nvidia.com>
X-Rspamd-Queue-Id: 3B1D6505E2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20319-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 08:34:43PM +0300, Tariq Toukan wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Remove a field that was never used.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


