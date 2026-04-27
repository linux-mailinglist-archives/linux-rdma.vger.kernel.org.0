Return-Path: <linux-rdma+bounces-19583-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFXnMABY72n5AQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19583-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 14:35:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66395472909
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 14:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DD22300644A
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 12:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4477A3A9631;
	Mon, 27 Apr 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX2SKNlw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B73F9C0
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293310; cv=none; b=hpdtBV/kj56zQ2HSP4j6L0gooQrplsgq5LEof988E+S4wbgCmITm3rkbDauVqXB0RvWqhfvG+0uXnVIX3lE/g+VoBSeIU5sDc93oJ2w3FDBbWuT9HmkTBe810OACy4D95wTb05FuI96lBluA1pj3FYrxvObA0U8tBq6K3UrmUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293310; c=relaxed/simple;
	bh=3HYWUiEdemEaCQruPtJ6hJQxuyAJh/B6JNvduhRCa5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW4vRfxwTwHqUL2IPbZb21kTxbd6u4bCGaVNmdePG980QcsdaHdEtXp56IyEOG/S2eMD23TwQzzoGWaTc1FOZy6jPtXyQRcL7bzOBenlQC3yghLQqkXSoug3ckipZzfrE/GWJSPOsg+C9Gea+73qVYOq74/QIpTWJo9JxpERtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX2SKNlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2D6C19425;
	Mon, 27 Apr 2026 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777293309;
	bh=3HYWUiEdemEaCQruPtJ6hJQxuyAJh/B6JNvduhRCa5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PX2SKNlw0rW1O6sibeJXmph0TIWDy/TgOtYRlBGUVx1JIvJXrXEL5MFj1xpDJIB/X
	 kwHx4ENM4oH74xbWJuzWq6x1q/wq9sAapUXc5n8VnpIscZIooIYqLz57/YadHtwTmd
	 6QqMWUZN3jMuN04wKwvBD3IkSmkWO+8fE81SNJEcdfOhuYjTLndPD2TwQKJGJDgbso
	 3CCV7O1XdcFUWps0lyyHBp+RvRe6KSeZr3NAJ8BReDfUcEVrOxAaLwZyiDEMAafMt+
	 mh9NFmhvI9/vMSko8gnovOqni4FPxHLN57pdJcSg6E0fLeiPqRD/O7IT+ob1l9AYrU
	 pfRe2dLdDk5LQ==
Date: Mon, 27 Apr 2026 15:35:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix unsafe socket release during namespace
 cleanup
Message-ID: <20260427123503.GI440345@unreal>
References: <20260424043522.22901-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424043522.22901-1-yanjun.zhu@linux.dev>
X-Rspamd-Queue-Id: 66395472909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19583-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 06:35:22AM +0200, Zhu Yanjun wrote:
> Since all the sockets are created in rdma link create command
> and destroyed in rdma link delete command, keeping
> udp_tunnel_sock_release in rxe_ns_exit risks a "double-free" if
> the namespace and the device are being cleaned up simultaneously.

Please add a ladder diagram to clarify how it can be possible.

Thanks

> 
> Fixes: 13f2a53c2a71 ("RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_ns.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> index 8b9d734229b2..53add78b8e3a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -39,26 +39,6 @@ static void rxe_ns_exit(struct net *net)
>  {
>  	/* called when the network namespace is removed
>  	 */
> -	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> -	struct sock *sk;
> -
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk4);
> -	rcu_read_unlock();
> -	if (sk) {
> -		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> -		udp_tunnel_sock_release(sk->sk_socket);
> -	}
> -
> -#if IS_ENABLED(CONFIG_IPV6)
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk6);
> -	rcu_read_unlock();
> -	if (sk) {
> -		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
> -		udp_tunnel_sock_release(sk->sk_socket);
> -	}
> -#endif
>  }
>  
>  /*
> -- 
> 2.43.0
> 
> 

