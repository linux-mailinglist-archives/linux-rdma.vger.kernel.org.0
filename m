Return-Path: <linux-rdma+bounces-22150-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NphGKgNtK2pj9QMAu9opvQ
	(envelope-from <linux-rdma+bounces-22150-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 04:20:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80B676431
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 04:20:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ehDWcXW9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22150-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22150-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 367AB304AF81
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89283803C0;
	Fri, 12 Jun 2026 02:20:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6524301719;
	Fri, 12 Jun 2026 02:20:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781230834; cv=none; b=cpYHeq04AB8lxrx7HoCMJXSURg8k+dm2fFllsmDgHLMcW913fiHDkZjqIJkuNDR16AHhJMT2sKG0TH3G9o4Q0i6+Bcg+slrUIrqlQ8nYVfOr+DFqrBqAaeYtxbzbvNNGezCO3OTVCJvGPmL8kC+rUWDRmxQ7kS4H26000hPEaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781230834; c=relaxed/simple;
	bh=vpmKus06yL4rbLJ5tzxv4gej6TE0AhnBAZZvBiXColg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D76gpd/zMf4tC7U2Z98Kgz4NPCZHWZwATisG+Q0v4VZEyxnMXmp1t3vATdSSiOY1JcPAnA0c2ORx2o6D2260KkXKjOhLLdRk3u0JLRluXnrrwDeAI9birJrMR08Qg71kUkgxkybWdPaolp39IK/Zr7x5u1Lg5vlOXqnDjVAi0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehDWcXW9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946B31F000E9;
	Fri, 12 Jun 2026 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781230833;
	bh=vpmKus06yL4rbLJ5tzxv4gej6TE0AhnBAZZvBiXColg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ehDWcXW9iYg3r7KdsvIHjhffXDXu9/bgjpTf3TZWSnG1iIy8dahQePenrylZHh59d
	 EW7MwCfccp6Gxoj4pL52QM+zch+ePgnJNmVY8M8oOUFpZBJUAUNd9mbryOKvh/FCbc
	 GPYCIa8hygRS6MJUtTrsH8Xqz0etj8euyZkrU+7IyLlmBhvnuM9Gb2kr07C02gjEzn
	 MCZQsdZSS2n+/KqboPrKo/Ly/dCxBHNYjpDqnvABckA2xUbUd9BFUaguM8gAk0uzCv
	 5JVHQuNFY3ExwV+uxc3zI/WgldwHfCHBK10dkb0Vo18v0hCJ4jx2MlxpSdVa0ybx94
	 2NUjGrLhpsVJQ==
Date: Thu, 11 Jun 2026 19:20:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
 <edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
 <msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
 <kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
 <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 00/15] net/mlx5: Add switchdev mode support
 for Socket Direct single netdev, part 2/2
Message-ID: <20260611192031.1b3f7d0c@kernel.org>
In-Reply-To: <20260608135547.482825-1-tariqt@nvidia.com>
References: <20260608135547.482825-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22150-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A80B676431

On Mon, 8 Jun 2026 16:55:32 +0300 Tariq Toukan wrote:
> This series enables Socket Direct single netdev to operate in switchdev
> mode with shared FDB. SD single netdev combines multiple PCI functions
> behind a single netdev interface. To support switchdev offloads, these
> functions must participate in virtual LAG (shared FDB).

Have you checked both Sashikos? I picked 3 errors at random that show
up in both instances and none of them are covered by the list in the
cover letter (netdev's complain about patch 5, complaints about
buggy unwind paths)

