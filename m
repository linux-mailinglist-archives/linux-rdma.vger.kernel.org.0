Return-Path: <linux-rdma+bounces-21993-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GdY/FkZyJ2o9xAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21993-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 03:54:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811C365BC3B
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 03:54:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BHWO72dQ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21993-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21993-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2481E301B919
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDE435EDA4;
	Tue,  9 Jun 2026 01:54:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51B346FB5;
	Tue,  9 Jun 2026 01:54:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970049; cv=none; b=BPXEjKKteN1Hn/zulX+rR7ESeLL9hY4sZXnNZKYwFiKyF5rQQQFNp6ry7zLMmpVo15XoAmFB7UxxffR1GUi5T6+B2zZTMpo79QDpOC6e70BJJiukzshNcZccqgcAxKyTPfSUNnaH5AI6/GCDNYhFEs3AkcjlesOVhLssOgK+p9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970049; c=relaxed/simple;
	bh=syoCoQCiIoeHQkWZiO8CebY45tjo9A1XOgBEJxvswNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAkyXdtljva7o0x4t+m5LmXMpIOrSlM+vC9wQ3f6tyl5lhUMqONtMGHIn/NZi9SpCJB8mgCTXOzqDCBSWlSMdKoxROSKuACDfsNKPw9mW/staQnlGEa2aPYGHv5HLpcjYuoVWfMCAralfYiuowUjOF6jMx+scll3sSnIO8d53Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHWO72dQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4381F00893;
	Tue,  9 Jun 2026 01:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780970048;
	bh=nWCr7TWbeO+9C4hHFF5VLh+qb82X3phwAc0B8Cb4TBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BHWO72dQ2fVRuwtJw6lBAMa8Hpw8RZwR4zRFOaWy0CU7ffrCpyZ1BntDlDGiVjHd2
	 87k6PoxPX0C6i6abNhsrr2/trCSIRRqmEXxMO5E3rzmAkogus/XGCXDOuH9kb5AjL5
	 zOEMZcu212S9Vo6kmswtiwjO7NcNbWdbfnWZykIaMElxi0O2rLG8fSpYqV05lW7oIQ
	 pUyovMG3NGSAye1yXybMVdtFqhupZdObJ/NFt7qjttysijROwbUITL+qLUOoHG3PnN
	 19DdAqN1t0jsOstgf4eQdCGPJoCLGFmKls9u8FQVe0UvJIoldx04kZUKROeCC8p9N6
	 G/J/rHLFfZv8w==
Date: Mon, 8 Jun 2026 18:54:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "Eran Ben Elisha"
 <eranbe@nvidia.com>, Feng Liu <feliu@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Simon Horman
 <horms@kernel.org>, Alexei Lazar <alazar@nvidia.com>, Nimrod Oren
 <noren@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Kees Cook
 <kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>, Eran Ben Elisha
 <eranbe@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Joe Damato <joe@dama.to>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/4] net/mlx5e: Bounds-check stats_nch in
 mlx5e_get_queue_stats_rx()
Message-ID: <20260608185406.6f9ac0bc@kernel.org>
In-Reply-To: <20260604135041.455754-4-tariqt@nvidia.com>
References: <20260604135041.455754-1-tariqt@nvidia.com>
	<20260604135041.455754-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21993-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:cratiu@nvidia.com,m:gal@nvidia.com,m:horms@kernel.org,m:alazar@nvidia.com,m:noren@nvidia.com,m:cjubran@nvidia.com,m:kees@kernel.org,m:lkayal@nvidia.com,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:haiyangz@microsoft.com,m:joe@dama.to,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 811C365BC3B

On Thu, 4 Jun 2026 16:50:40 +0300 Tariq Toukan wrote:
> mlx5e_get_queue_stats_rx() is invoked by the netdev stats core with
> an RX queue index 'i' from real_num_rx_queues. Today it only guards
> against priv->stats_nch == 0 and then dereferences
> priv->channel_stats[i] unconditionally.
> 
> During interface bring-up channel_stats[] is populated incrementally
> by mlx5e_channel_stats_alloc(), so a concurrent QSTATS netlink dump
> can call into the helper with i >= stats_nch. The non-zero check
> passes, channel_stats[i] is NULL, and the dereference panics.
> 
> Replace the non-zero check with an upper-bound check against
> stats_nch, which subsumes the zero check and prevents the
> out-of-bounds dereference.

I don't think there can be any race here?
The open/close and queue stats readers are under netdev->lock
Your description makes it sound as if we could access half-initialized
state?

Sure, the ndo path is tricky since it's lockless, but please don't
add unnecessary checks in the locked paths.
-- 
pw-bot: cr

