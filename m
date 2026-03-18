Return-Path: <linux-rdma+bounces-18365-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE7yFOgGu2kgeQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18365-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 21:11:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB1D2C2615
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 21:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472EE302B22F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D463F7E75;
	Wed, 18 Mar 2026 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="DkWczbrN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFF3ED13A
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864674; cv=none; b=atNurOm+vvIhASm6cW3AdU4uE+hyvjLhxD3HgsiZJd3q/O3aNvypjuytnIIZ5EPK+JPm7UETpkVeCsArrGbb0VtdX62VMt6J7vG/6wgFDjy563a5pJsBKOxtLZ5IUeAnRjV6H1dRrh7DiGVd2BY40jHSCQBO8RNo4dUS3wH310k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864674; c=relaxed/simple;
	bh=7V+tpJcHPHKkKArRby9B/AEvv+A6I5U8x69esMrCnRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLhZNqHUGisYKq9Fs+4oRpbKj2EaGBkqYLF7uKX5UBJldhlUUBAQmxxxpZcBrVOpz37tO/oqhsVX+bvavhaMbL4cWTZtLxq2c77sOQZsZqMM6WxLzA3Q/ZQqpZ9AE2EuqjnFkFUXnfyYEgHu9/McODS5U6S4SN24PmpQyQuZ13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=DkWczbrN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82985f42664so232312b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773864672; x=1774469472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcrjf6o6BBsskimuOBs0/X8mHwc2XWl98zNiH3etscg=;
        b=DkWczbrNIQVEjlE5M+pjSo5y5lJ+by1T8j93RepF68fSx2hJNsN3z/LP14spf2xTxD
         GjHNvBYIMtS9I1INUMEa9oAH70XyhYqcm42elsdox7gMSJoDGd57sSjTB5mSan9qvCsV
         eFlvtmd5JdQXQs1kjwSyZQPsYqDcKk4aFGRq7Dg4FgPkLrQBkMQ35JwbJbhSV8s2I33p
         ndebk4WsWZ/wndb1k/sYfJTDKIYBd//H3X325h17nxGmnatVLHabxX2djDTegEdlLaOq
         jvApSI+LinleIAO+nE8hXcutT4HnR+QMWsgbX152KBdlxgJt5fhGeLLe9LsBOYOLnIdH
         05zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864672; x=1774469472;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcrjf6o6BBsskimuOBs0/X8mHwc2XWl98zNiH3etscg=;
        b=LAyQbO6RrTVmCP2iZqgAMMpk972QGDAda1yNNo14XUnpQ3s1O3H+7qSdEXXyMh4sNw
         KW3+3pq0Ju7WUny/S8f5Xcas3wKELo8ze5kshQrQvBtYEJcZM6KWymptiZGOYLg7r8qF
         2lU9Qn2AIpPrB24WJvG8z0WntHRKI141PDOsFETFiteVSLPhpE1JWR0HHYGAvgBbqxHf
         6VKa/WUEjr0TEBSmbWWGDLzSYLqhjZyIC7FQzXhyGVO63cWUEI0mQXlSQ46v24X4+21j
         DSAjBbZg8g2MdoAf+pUZGlWvTqE7Ny/fSl196LtUZ23PEk/AHZl7KHhvevytaGBdCDPu
         VQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4eAW4x5cID6Z0/cClqO7NYkAxZkwzoxL81LSDzuizmCWiEJtWlYo08JZFcwwAsoqlh1JCxKBxb+c7@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBG9/Io0fxzhVN8Apwve8i5yq6Yp3BAKBpC/ryKxtKEEYTmFT
	22eQnF6xPs6qYp8y1sui50e5goN+Ab9pDolQvFtPCm6HrFTPmylm611OpVy5uVqCSeg=
X-Gm-Gg: ATEYQzzN3cU97ssBd6JpOt/+cAd+IDpZBnjOk2bVdZ4fVX2q7CwK4EhdGlPZOBmsKIG
	AFxZxyfmsQdRccC9t2kF7E5kDUlE6Dibukkbchzg9o4Hl/6JTMlRXiYbjpDUcOcwrxv1T51c4cm
	D7aTY/RFLolt8Rk49/iNEY1KHq1wJfQPYlCQkk03mxhuYwzEFMnxLWIZ7R4Y3JM92l3J3tPq1E9
	BT5Q1r+Be1ndVKx8yE1j61MFv+QhJ3hiWeGpqtjb5xNBOY9T5IVPseoBES9WpVAJ0IQ2KRNfZKT
	KLiVFOD4oL3h0TJZZXxw3X5l77+6W30288VgREQKllmnZJSLrtdKzjZtGvtl9lHXmFTWrfYVSmi
	Hv9d94xXNjrWHJXiu/z3NdEto8B8PgJjh6/4tnDT9Uu1TfkcwFn8hAkstYQNpApLV0XpwHr/j0i
	2tN9Y=
X-Received: by 2002:a05:6a00:2183:b0:829:9c9c:1720 with SMTP id d2e1a72fcca58-82a6ae70a0dmr4132616b3a.38.1773864672197;
        Wed, 18 Mar 2026 13:11:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1869sm4227445b3a.40.2026.03.18.13.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:11:11 -0700 (PDT)
Date: Wed, 18 Mar 2026 13:11:11 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5e: Add hds-thresh query support via
 ethtool
Message-ID: <absG34VIYtLLTF+X@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <20260317104934.16124-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317104934.16124-1-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18365-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,dama.to:email,devvm20253.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9BB1D2C2615
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:49:34PM +0200, Tariq Toukan wrote:
> From: Nimrod Oren <noren@nvidia.com>
> 
> Add support for reporting HDS (Header-Data Split) threshold via
> ethtool. When applicable, mlx5 hardware splits packets of all sizes with
> no configurable threshold, so report both hds-thresh and hds-thresh-max
> as 0 (i.e. always split regardless of size).
> 
> Signed-off-by: Nimrod Oren <noren@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 4a8dc85d5924..bb61e2179078 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -371,6 +371,9 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
>  	param->tx_max_pending = 1 << MLX5E_PARAMS_MAXIMUM_LOG_SQ_SIZE;
>  	param->rx_pending     = 1 << priv->channels.params.log_rq_mtu_frames;
>  	param->tx_pending     = 1 << priv->channels.params.log_sq_size;
> +
> +	kernel_param->hds_thresh = 0;

I think this is populated by the core before the call to get_ringparam and it
looks like it is defaulted to 0, so I think this assignment is unnecessary.

But everything else seems fine, so:

Reviewed-by: Joe Damato <joe@dama.to>

