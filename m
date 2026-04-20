Return-Path: <linux-rdma+bounces-19438-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNtbAMhp5mnBvwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19438-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 20:00:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F18F343263A
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 20:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE33B30722D4
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D5037F8BC;
	Mon, 20 Apr 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwZ54zp2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E050537AA99;
	Mon, 20 Apr 2026 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704960; cv=none; b=uqX/N1O/K6ART4zg5E5h0qjggu/WErDE6yDpuarv4oeZ5qWw1BOKj2xhUlBDdTT0ODGEw68/YTObG6UcvWslroJ0NYwtUhxgUt8BQA+RPGao9UfwTzquptciYy6ED9w5aMZs0P8YsFVEAFRqk9pyOwb9gy1ZtrxM/21+r4U33OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704960; c=relaxed/simple;
	bh=DLukSzjKif0rd+z1DTc2dsEwnYvZX8jjHgLQdJFDodQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlbkU2frBCcCVEVFtsZT2+xXPMKYYxrg6JkHCoUrT7s9jLZKQKZ4nBsYmvQbbuzC714Cl8ee4sr1oXIMUUAebGqngmqsHBpV2MO4BLrwYowFt2FvidrVmaPh3PeKPyIvdxttP8nnh6/Tke+n3kK3ovr3GE+9oFB7aoiWEJslJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwZ54zp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F50FC19425;
	Mon, 20 Apr 2026 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776704959;
	bh=DLukSzjKif0rd+z1DTc2dsEwnYvZX8jjHgLQdJFDodQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lwZ54zp2eGmwsW2UUBaM3dGojPNZCCDfSRnJMhYFJPaBOReJ+ERN4ftMws2H+P523
	 RrVKDwaELhjMx5xtgYgmNqY3ncrQTOxUm9BQeOFASK8xBavnmferllDQwn49McryE3
	 j947s2x+fg0JgQc8ctLZKVn6+6O4iJhtpz8TSPWM8ZKldRu4ryBAHuDS1bug/zg+nK
	 i8XjWW5xtykE/GKQ3MpGjRj5Wy3eT3q6ilO6ZL5qMOS/190YFRKdlB8j5OHaeNh7xD
	 MSaAoUuV0OCkx84QdbWRdv5G1wYTWaCqKUZDG5NfTwqUFjUD6YFwD92wxwZAa8rHq+
	 vKwDRf+C96GjA==
Date: Mon, 20 Apr 2026 10:09:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com"
 <daniel.zahka@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "leon@kernel.org" <leon@kernel.org>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Raed Salem
 <raeds@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, "kees@kernel.org"
 <kees@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "edumazet@google.com"
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Message-ID: <20260420100917.1e4be22a@kernel.org>
In-Reply-To: <d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	<20260418190848.204170-1-kuba@kernel.org>
	<d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
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
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,redhat.com,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-19438-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F18F343263A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 10:30:46 +0000 Cosmin Ratiu wrote:
> > When psp_dev_create() fails, this function now returns without
> > setting
> > psp->psp, leaving it as NULL. However, priv->psp remains allocated
> > and
> > non-NULL.
> > 
> > Does this leave the RX datapath vulnerable to a NULL pointer
> > dereference?
> > 
> > If priv->psp is non-NULL, the NIC RX initialization path can still
> > call
> > mlx5_accel_psp_fs_init_rx_tables(), which creates hardware flow
> > steering
> > rules to intercept UDP traffic.
> > 
> > If a UDP packet triggers these rules, the hardware flags the CQE with
> > MLX5E_PSP_MARKER_BIT. The RX fast-path sees the marker and invokes
> > mlx5e_psp_offload_handle_rx_skb(), which dereferences the pointer
> > unconditionally:
> > 
> > u16 dev_id = priv->psp->psp->id;
> > 
> > Since priv->psp->psp is NULL, this will cause a kernel panic. Should
> > priv->psp be cleaned up, or the error propagated, to prevent flow
> > rules
> > from being installed when registration fails?  
> 
> First, this is preexisting. But more importantly, it's impossible to
> trigger:
> - with no PSP devs, there can be no PSP SAs installed.
> - with no SAs, PSP decryption cannot succeed.
> - all unsuccessfully decrypted PSP packets are dropped by steering.
> - the RX handler will not see any PSP packets with the marker set.
> 
> This patch fixes the comparatively way more likely scenario of
> psp_dev_register failing and then mlx5e_psp_unregister passing the
> error pointer to psp_dev_unregister, which will do unpleasant things
> with it.

Sure but why are you leaving the priv->psp struct in place and whatever
FS init has been done? IOW if you really want PSP init to not block
probe why is mlx5e_psp_register() a void function rather than
mlx5e_psp_init() ? Ignoring errors from psp_dev_create()
makes no sense to me - what are you protecting from? kmalloc(GFP_KERNEL)
failing?

