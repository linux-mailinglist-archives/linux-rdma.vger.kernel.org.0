Return-Path: <linux-rdma+bounces-20830-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEoLM9+YCWqqhAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20830-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 12:30:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B65F560790
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 12:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33BFE300BDB9
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770562ECEAE;
	Sun, 17 May 2026 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0wT50jn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16F3C465;
	Sun, 17 May 2026 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779013849; cv=none; b=dJkrpCB4ssC6b1498AuWYNrBsoRtFziZV4n7JeEkSYxhUBy2amUbvthYsWmwgyXmk2OQq+BWa4GGbZJr5/uRHPW3k/JgOLj7h8hXtABLe0YV6w49YeUhygJkUhG4olC/PoKcSDDKTJVVSSUYJxUWKKuNx813BhyVRpXRAk2s1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779013849; c=relaxed/simple;
	bh=oKB4vZkKMB1iY1/10UVgDNZcxKd+ie6puFVXHVtNU/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2lBdkaDksqalWN+TxElgMItzbPkjVrJaimodOvLjbxzcO48O23keLHI2/Sd2FmV/GJlSReHSXRBvZkojJS0pLJuaBEU80q6KMamdqw/TI9INS2+pZzJW9QbUtsGznajn0VS+gQxVsxNoUdgJxESHmVN7Dm3tg9H4tUj8u6859E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0wT50jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA73C2BCB0;
	Sun, 17 May 2026 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779013848;
	bh=oKB4vZkKMB1iY1/10UVgDNZcxKd+ie6puFVXHVtNU/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0wT50jnfaVQBbzO+xoyYyLOQl4dDjwSyZLd7hHJUCot6si+daFBUL3+SACrsqY43
	 RFmcEMDQiu/QQyonJCIJI5kXaedKvoHYZOfpDECqLZ9vpROiHpjEpXJYsT65hF5Abp
	 XxY43BPJDRTD0XWXoeBNXhKGE/VIaovIOC7DesCqsR0yRcqoAnV/rjT7nyL0NoWK8g
	 gQt2vkVtZv3vxrcAHxyvDeZK/ucck1TJMfy+qMGdl95o4Hj/bcR5lka8uYSx9dU7tr
	 XodhGyrESKY9o0pFfrE1eJrLf7BfIyA1iza+GbIpbZXEu6rApSYzqiRv28vqvkcUTR
	 tJSq6T2+bIAxg==
Date: Sun, 17 May 2026 11:30:42 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@mellanox.com>,
	Maxim Mikityanskiy <maxtram95@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Saeed Mahameed <saeedm@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Paul Saab <ps@meta.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Paul Saab <ps@mu.org>
Subject: Re: [PATCH net] net/mlx5e: xsk: Fix unlocked writing to ICOSQ
Message-ID: <20260517103042.GB98116@horms.kernel.org>
References: <20260513064613.334602-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513064613.334602-1-tariqt@nvidia.com>
X-Rspamd-Queue-Id: 2B65F560790
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20830-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,mellanox.com,gmail.com,iogearbox.net,vger.kernel.org,meta.com,mu.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,mu.org:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 09:46:13AM +0300, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> During napi poll, when the affinity changes and there's still XSK work
> to be done, we trigger an ICOSQ interrupt on the new CPU. However, this
> triggering on the ICOSQ is done unprotected.
> 
> There are 2 such races:
> 
> A) mlx5e_trigger_irq() is called while mlx5e_xsk_alloc_rx_mpwqe() is
> running from a different CPU due to affinity change. This can happen
> because IRQ triggering is done after napi_complete_done(). At this point
> the NAPI can be scheduled on a different CPU. Like this:
> 
>   CPU A (old affinity, NAPI tail)    CPU B (new affinity, fresh NAPI)
>   -------------------------------    --------------------------------
>   napi_complete_done()  clears SCHED
>   mlx5e_cq_arm(...)
>                                      napi_schedule_prep() sets SCHED
>                                      mlx5e_napi_poll()
>                                        mlx5e_xsk_alloc_rx_mpwqe()
>                                          mlx5e_icosq_sync_lock() // noop
>                                          memcpy 640 B UMR body
>                                          advance sq->pc by 10
>   mlx5e_trigger_irq(&c->icosq)
>     wqe_info[pi] = {NOP, 1}
>     mlx5e_post_nop() advances sq->pc
> 
> B) mlx5e_trigger_irq() is called on the ICOSQ when
> mlx5e_trigger_napi_icosq() is running.
> 
> The obvious fix would be to lock the ICOSQ. But ICOSQ has an optimized
> locking scheme that doesn't work for this scenario. Kick the async ICOSQ
> instead which is always locked.

...

> Fixes: db05815b36cb ("net/mlx5e: Add XSK zero-copy support")
> Reported-by: Paul Saab <ps@mu.org>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


