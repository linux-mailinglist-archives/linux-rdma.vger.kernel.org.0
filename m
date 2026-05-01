Return-Path: <linux-rdma+bounces-19834-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFcXAXV69GmLBgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19834-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 12:03:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 675934AB7FC
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 12:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B5B93015866
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0773612E3;
	Fri,  1 May 2026 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Kid+u6Ol"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79823EA89
	for <linux-rdma@vger.kernel.org>; Fri,  1 May 2026 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629804; cv=none; b=RavwtRo6Ayled8YbfDdzoDGGE/9ckWf6HD0XVJGMOqdVJNvAj8Lj41LmaP+Nw33JPKSn1WXFwiSj/e0wd0TqFd/yFleO0kKJYeud29w2xUckmACb8EloXoNvKDooKksckU1jxISXVUa8CqljCMhRyXI39qek28t02j/yCgg/F+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629804; c=relaxed/simple;
	bh=FSYftY8QuORJHCe8t1V2XVW+trM6gYk9XA6x4O1Ehpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPK10sZzZPsUveu3VPuiHBYcfeevhP5uEe6zUyUAZChCIp+zJgrqcHkvONL6Xfu+KdWI+UfVamyHd9PE8+6W0T9obz7vVpYXfpkXTgAh18WQ5kiZqeO9aaaPCeN7RQv/rxLSp1UseQ67qDf2mre0ReseXu2+eUKuEVtCpw1WaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Kid+u6Ol; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43fe62837baso999330f8f.3
        for <linux-rdma@vger.kernel.org>; Fri, 01 May 2026 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1777629802; x=1778234602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Su0c59s+EOGt4bGqynE6SKSlrnRdNQb/dtAHeJcNMSg=;
        b=Kid+u6OlSbGcKdUSB+idjqsnBx40kDmZKqqac6l7X0yknTEMLkeu37AD/l0rpuk5nc
         Qjh8bCkGZzboFuP1ZnH/Enq716GEFXnYjtjPM8MROJ9BEoGWbYMlczrE5p5Ra7I872QV
         PIMsJyipJjnCErBGPePcEFfu3fXsuRbotHQw/QZbMLt75iAjITMY1XD7ODsUiQYLIjV8
         ua8NHnI2k5OJh5PVmQ3dXTXyqPJ7LZeJGgWNRpNMlvSIAUbjAkcNhCuF5k6NHvISYsDi
         XbO6ToRyIEzdS0Ex+qGHvzKgPd5zY3Jr5uRgB+3gnzojeVhcpDZR3iZuNBu3qUd7WKOm
         6o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777629802; x=1778234602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su0c59s+EOGt4bGqynE6SKSlrnRdNQb/dtAHeJcNMSg=;
        b=eUjLTF31huT3CP1v9hi/a2Z7oxR9KmVcJpbiKcVI+sjhrmMfleOGUmZ0z3xR5SShPc
         ZnluTFManm5SmLVqwOF8cRN/VkRLlyqTnIUzS24qW6ZKrqKbctlBr+pUPJjZaMnaRHqj
         xqyeQLlZIYJFTwd7VzPoK2k7mX3kSM1DiXg0stgmTkV1+cipcrPgBfNJbuhWghavhipe
         fIHQQiQ9D7bm6YmgDif/TLE4AtLP+AMOrkTAlYOaoVg9E9Avss0VDmK9M7iq85MS8FJo
         3tsMICjz13Ws+svbb01/4bV3BbVBf2Nbz3gxkQlYzr944p2xLkNeJRni1SrdciV58e84
         wvCw==
X-Forwarded-Encrypted: i=1; AFNElJ9u709EcV0ogfwgTVxZPXJs+ZpkfiB4NyfoxvO1+BzIw/nhLGubq3ZkWNVXwYnei8CGWSnaO1hl3aBb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZRv6qab5dbu0yulfjiNnTQiSRbKjUzppuuxC/2mpXHdS2UJm
	9rHREPvDoaoluZuw5u2JbOlSzrpO/80Wstc+jimHuqFN+9eEZpV34rKw2vbA6k86jJo=
X-Gm-Gg: AeBDieuNSi1KqYDwfu1NVHtYiatMttWAQ5dHX8/OEtEipJdLCfgZXPRXX9lOFzW621A
	XTOhI0OSb7uWELV95VYbC1APk/Og55AgWmdVKQedTnizQ57BSKXEPmcIsvjBR1YxWniBsItXclZ
	axkLKcHgwCH4x6NUaqE45knO8AkaK5DydY9b8sVxDEL7K5UfbBP+n2zM1plwv/lixeJSoYKzVAX
	BTKggsDZF/DE+LoeAVYs61wQiMu5cJkKIX/QstbTfOJqpRB+WlBICMQgvuHm3VvBJ154oXBzMld
	5uoZ07UJZGpM3QGH+1MgHX7fnfznJRQuikn46SscUhB2OSirtaNn2GzI3zx0+6RSYceObbs/JNP
	W4QtNEz2tIH35Klitgwu+bPRetcueCkI7ZjSmpTlKvHm9s4reOWOayH3xLTO1F/HQ11m61d+p7h
	zpcS3XllBJhTGUSIQ47kbiSec=
X-Received: by 2002:a5d:584a:0:b0:43f:ea91:63ff with SMTP id ffacd0b85a97d-4493ded555bmr11715307f8f.10.1777629801487;
        Fri, 01 May 2026 03:03:21 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26d2::3de:68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cf97sm4271919f8f.6.2026.05.01.03.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 03:03:21 -0700 (PDT)
Date: Fri, 1 May 2026 11:03:20 +0100
From: Matt Fleming <mfleming@cloudflare.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net] net/mlx5e: Fix use-after-free in
 mlx5e_tx_reporter_timeout_recover
Message-ID: <afR5d7siUuKMRR8o@matt-Precision-5490>
References: <20260408184458.1274662-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408184458.1274662-1-matt@readmodwrite.com>
X-Rspamd-Queue-Id: 675934AB7FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19834-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mfleming@cloudflare.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:dkim,cloudflare.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, Apr 08, 2026 at 07:44:58PM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> mlx5e_tx_reporter_timeout_recover() accesses sq->netdev after
> mlx5e_safe_reopen_channels() has torn down and freed the channel (and
> its embedded SQs). Replace the three sq->netdev references with
> priv->netdev which is safe because priv outlives channel teardown.
> 
> The netdev_err() call already used priv->netdev for this reason; make
> the trylock/unlock and health_channel_eq_recover calls consistent.
> 
> This fixes the following KASAN splat:
> 
>   BUG: KASAN: use-after-free in mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
>   Read of size 8 at addr ffff889860ed0b28 by task kworker/u113:2/5277
> 
>   Call Trace:
>    mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
>    devlink_health_reporter_recover+0xa2/0x150
>    devlink_health_report+0x254/0x7c0
>    mlx5e_reporter_tx_timeout+0x297/0x380 [mlx5_core]
>    mlx5e_tx_timeout_work+0x109/0x170 [mlx5_core]
>    process_one_work+0x677/0xf20
>    worker_thread+0x51f/0xd90
>    kthread+0x3a5/0x810
>    ret_from_fork+0x208/0x400
>    ret_from_fork_asm+0x1a/0x30
> 
> Fixes: 83ac0304a2d7 ("net/mlx5e: Fix deadlocks between devlink and netdev instance locks")
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> index afdeb1b3d425..8409ae73768f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> @@ -160,13 +160,13 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
>  	 * channels are being closed for other reason and this work is not
>  	 * relevant anymore.
>  	 */
> -	while (!netdev_trylock(sq->netdev)) {
> +	while (!netdev_trylock(priv->netdev)) {
>  		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
>  			return 0;
>  		msleep(20);
>  	}
>  
> -	err = mlx5e_health_channel_eq_recover(sq->netdev, eq, sq->cq.ch_stats);
> +	err = mlx5e_health_channel_eq_recover(priv->netdev, eq, sq->cq.ch_stats);
>  	if (!err) {
>  		to_ctx->status = 0; /* this sq recovered */
>  		goto out;
> @@ -186,7 +186,7 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
>  		   "mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(%d).\n",
>  		   err);
>  out:
> -	netdev_unlock(sq->netdev);
> +	netdev_unlock(priv->netdev);
>  	return err;
>  }
>  
> -- 
> 2.43.0
> 

Hey there, any thoughts on this?

Thanks,
Matt

