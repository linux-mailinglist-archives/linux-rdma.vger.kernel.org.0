Return-Path: <linux-rdma+bounces-21472-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF4MNZ3gGGoJoggAu9opvQ
	(envelope-from <linux-rdma+bounces-21472-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 02:41:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3847D5FBBD5
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 02:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25DB303B6C5
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 00:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9CD34BA49;
	Fri, 29 May 2026 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Voo/MuvU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7F1A6803;
	Fri, 29 May 2026 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015253; cv=none; b=M2pZdqfgPD8oNpIQxQnqOUw3i/uAMQFetyz7b1pDvBpxh7idYPGcw8QObd8KTQz6rZfIVyQy8w6EB4BX1dTX/2yIIv9VrX1O/O8dLDvXCGYXyzRSovWiEZK3gPn/cThAPUUytFZ/LXWQB3g8j1PlA7mrQio3UqsXp+tNwYGrvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015253; c=relaxed/simple;
	bh=THSiL7+uoAJO/+0Yptqolv5/OGwpg5Tw5Un4fZFdJl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bckL4iTiuTdpRTVqr5lOTbNS1U6xD2ze9qEdj0fFZ+FpLor6R1P9DpQoMilMNr4j6vyDJB/FBPOeibsVyVen3fgs0GxYQEh8t1TWdnB69L1y2pYRvy3ZPbjdtNXi7g3K74YqBnZjBV7A/OOcvALVKGLHWW8p1RsKWCi8MmSjeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Voo/MuvU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6AA1F000E9;
	Fri, 29 May 2026 00:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780015252;
	bh=+B+TmL+1xk+lcmsV4goQvaHyJorMsCHPBDE/CaQgM2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Voo/MuvU3WcLDKbPxOBlCw1Xm8gk4CyTf5iQGcD81FOTdkCADbcZJFrg9I6XDHLRJ
	 hhtlKxe7Jcg5wMY+dVE5gnpTaRJ9iS736f8SK0r8uh907sS32YxyEqmvPZy8fVd01N
	 /PYDRtM1z/HFU0yEwyp3b2HKCZ6/zGomJNb+9uz7Bk/XIC0CxCZP5dd3PkhYAiJYLN
	 gjV0U2HQBiQyxhe8i4zPpLQmjzYcRAcaVULb6fpIl6bfD4kjxz5fvZNmpp6G5Nehps
	 KlRJfADfePAqhGrYWdH8AahC6kg17YplUJ4ULzGfzK354oqFr4rVffNRR4lWmIBzg8
	 Yw23iDTGvXq9w==
Date: Thu, 28 May 2026 17:40:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
 <noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
 <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
 <horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
 <moshe@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH net-next 00/13] net/mlx5: Add switchdev mode support for
 Socket Direct single netdev, part 1/2
Message-ID: <20260528174050.6421e472@kernel.org>
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21472-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3847D5FBBD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 15:54:14 +0300 Tariq Toukan wrote:
> This series enables Socket Direct single netdev to operate in switchdev
> mode with shared FDB. See detailed feature description by Shay below.

kdoc warning in here:

Warning: drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c:140 No description found for return value of 'mlx5_lag_shared_fdb_create'
-- 
pw-bot: cr

