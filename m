Return-Path: <linux-rdma+bounces-22367-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sSIjOQGYNGpHcQYAu9opvQ
	(envelope-from <linux-rdma+bounces-22367-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 03:14:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA6D6A3851
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 03:14:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ICqXFW8o;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22367-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22367-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D40493018088
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 01:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB92E7BD3;
	Fri, 19 Jun 2026 01:14:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF32DB785;
	Fri, 19 Jun 2026 01:14:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831670; cv=none; b=fagDjS+p04Z8vyY80DgvL+kbHb6tEL02igrRXPM7o65pl8d9zDQ1ate+tGIGN+p38UgqkpgTZoA4WjCEA8xJV8OfBj0hfmxayhO0GQjmMsUAewympEZYlMnBLhZQ2e8JuVUKtt5Q7GHZL8bxNhRIbhd93SLZnZNfsJaIiw1VYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831670; c=relaxed/simple;
	bh=BoZtJVybHCvAECJ1jMtLJtD59NMzb7kcuwTaF8rCz2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGCA9u8T9Jaz9dBXLqf+TIIMmF6wiY6BsiZe0saArYnLT8LF5IY8TGjvXlx3e7AD2VgvyMa8ML9i3Bi1uQz/tovNq6JONkHJCM0Mve+y3YDyXAfV09XHnhaR1HA6hLo08/l88b1EmUvpgZ/fk3X3LwsZObAzDRKWoZnlN3W3xLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICqXFW8o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47B51F000E9;
	Fri, 19 Jun 2026 01:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781831669;
	bh=UXABefMRX/VS4lJZ7cuXaBgHZUJreMWHuU8waiRz59E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ICqXFW8obJpbyYu4j/Eij/Ax5OGEEudBSr2va2cadiFFdwZ7evz7lk4P3lwks2Mx/
	 xwqpdImJWwnbWuVKpqAEy/8rQMUL4KxGuzSMxvcdCyfb/coP8c2hbj3lUWcKTD1Aae
	 Wt+tOgOlpH2ov80zB6IOqSoHsVTqzaeTJ4Z01xWBMo/IqVTSk60ISZpWYMdN2hf9CU
	 4MkwJ15IGihVwbrx/+vhOy9+EC2FjO7jqbnrO0EbR1N5yUXUfT+QzropEU9pwezf8f
	 OVLsZgPWz+NHJkkEMH5FlpQaleBGBt5+UDKiqxQD+ZcbQY9phsAcd2IxjnVqnG+nkA
	 L2gJhnNo5oB9g==
Date: Thu, 18 Jun 2026 18:14:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>, Feng Liu
 <feliu@nvidia.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Lama Kayal"
 <lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>
Subject: Re: [PATCH net V2 0/3] net/mlx5e: Fix crashes in dynamic
 per-channel stats and HV VHCA agent
Message-ID: <20260618181428.3da6edad@kernel.org>
In-Reply-To: <20260617140127.573117-1-tariqt@nvidia.com>
References: <20260617140127.573117-1-tariqt@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22367-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BA6D6A3851

On Wed, 17 Jun 2026 17:01:24 +0300 Tariq Toukan wrote:
> Since per-channel stats were converted to be allocated and published
> lazily at first channel open in commit fa691d0c9c08 ("net/mlx5e:
> Allocate per-channel stats dynamically at first usage"),
> priv->channel_stats[] and priv->stats_nch are filled in
> incrementally during interface bring-up. This opened a window in
> which the various stats readers - most of them reachable from
> userspace via netlink/netdev stats queries - can race with
> mlx5e_open_channel() on another CPU and observe partially
> initialized state. The HV VHCA stats agent, which is created
> before the channels are opened, hits related problems of its own.
> 
> This series by Feng fixes the resulting crashes.

No longer(?) applies:

Applying: net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
Applying: net/mlx5e: Fix HV VHCA stats agent registration race
Applying: net/mlx5e: Fix publication race for priv->channel_stats[]
error: patch failed: drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5533
error: drivers/net/ethernet/mellanox/mlx5/core/en_main.c: patch does not apply
Patch failed at 0003 net/mlx5e: Fix publication race for priv->channel_stats[]
-- 
pw-bot: cr

