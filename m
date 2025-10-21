Return-Path: <linux-rdma+bounces-13959-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E371BF72ED
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 228C14FA5A7
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1AA33FE3B;
	Tue, 21 Oct 2025 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="it9O2VWZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TR9YYpe4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362A340276;
	Tue, 21 Oct 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058503; cv=none; b=WizBzTvFV4flg0NkSA527CWphbe8eZglSE0s3hzYUNrcbHHqRgC4oxoD19qURnEZrwsCy+SbqQWekTkh6OQRdWcrFgLHVB71vTdqGoG9Ys4qlU8cMJ1nWn0+65/e6wz6e/3+aFuv7zNEqg795HvLwF6MOk7J3k5wrSgRxNV55Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058503; c=relaxed/simple;
	bh=y9hZjivPVSdX8b/3D2Z7/dyOlv2esXM7zlfteD0MmTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDdw1pnCbAUjvHVDwmQeeCwDmSEGod/sCZSIihK3oJxNSB74jH2ZlqUdlaUqL8vz0InFSUl1XQJts6TlcbP7E97W7QuJd2NQ/ttRWWF73QMLASr8CgPnoPQ8w9YxsoKCR2M4OqV8M6lX4lRHKeJPiH10w1t7QCnbj18r1wDo2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=it9O2VWZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TR9YYpe4; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77DD47A0064;
	Tue, 21 Oct 2025 10:54:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 21 Oct 2025 10:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761058498; x=
	1761144898; bh=e8TBjA/G5p3PECGmO3D+BZE/Bo+2WMOrXcYQORq5RFA=; b=i
	t9O2VWZGXuMDh0dibeXdssw/5G/tfJM/F8bxhaRD1P+QmIA4Nq748KQeU9FbuagC
	FiKmsEFPa3kiwOf6QZ6jaQZgPnqsO6yf0sj2Xk9jE8R47ZesoNAW0cVB5IOt+MYq
	mA39+041nQum643H5ZZK+k3j/gjvjAKjhTBHB8/oHnQp1lCdvV79uc7IQBAjHaGq
	SkyiamIhRQIFxKCaWWi2Jv8YFXEN1VeSYBub1z3cB5R7n1Fd9DOclWZwbjXr9Sa8
	tZtWod/YyPq39OeTQ1TMyh3fHgRbgIakMUkBy7u+uAyG5JajOHVP/P8/GHRwNxop
	2r04o5RfpsvHxSb6N3g+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761058498; x=1761144898; bh=e8TBjA/G5p3PECGmO3D+BZE/Bo+2WMOrXcY
	QORq5RFA=; b=TR9YYpe4Z7JJWuoQnMvgvOPdxdGf9eTgC8VmOBrObNYOA6/VxHs
	wLM9WxcFOkQrNy8L/MAX+aMzYrlHNOk4IHRUa0of6mwX52xb7PrNmTWrCchppbNN
	Rnj6us46bOHJnor4b0+KRk8dUipEnYPsC+5+lIb6qoHO/LpFvc1+LKJNY7irXGLV
	l5gqxt6USbeh9yC4ONDvEEPdiU7PYfAJkbTV4j+tgmLD/oLrhFC3taCJZA5YYOgX
	SsDrEZdbJfYveOaKqz7LEU7zAsnZxomXMFVmyBkG11fu7n2qlzzZ0QE78O+21GE4
	7JvANOfWADvbKVMY8aly6FnF51NnvytG+Dg==
X-ME-Sender: <xms:wZ73aAS2HXzyeT9vkQINkln7qvhW_qtjD6VTil1q_wgQt492ykp5AQ>
    <xme:wZ73aMscCWICUgmTJgoFYDghzd9NOPYHf9tUH8GYzPnsC-CxXxlojrjjObfqe3jXt
    lRrkre-HMLSQQKogCbhvEmTMo_vvbIaO-ZPaaIIuREocQFKpMsN>
X-ME-Received: <xmr:wZ73aJ4Xjrbow_RMdx2ooP2_w0ZopW6CGhYp9cvewZbf4-G_v4wgXVgNb_uO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrrhhiqhhtsehnvhhiughirgdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrg
    htrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdp
    rhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepsh
    grvggvughmsehnvhhiughirgdrtghomhdprhgtphhtthhopehlvghonheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepmhgslhhotghhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:wZ73aHhyQ459w1oBSExPwqpMUUQWZnTumXnEVk7X7bF184kZ5vhxVg>
    <xmx:wZ73aLlcwRhBBDc8H6j9YC1syXp88CAoFPWu8r-Gx5Y-hNiUO5Ux0Q>
    <xmx:wZ73aGu72UbTJpHl85n5botiz5GOr5We-l-sjmRJbOV-avvW-p6p9A>
    <xmx:wZ73aBBObg03Uuluwz_Zm5Tya-6H4YmRvKOqtVIuqOQvCohJZLs-PA>
    <xmx:wp73aHzJad1Q3RCxa9jbtbyKT5blmvONKL34JZrItO2MDuuo3fBtCmC6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:54:57 -0400 (EDT)
Date: Tue, 21 Oct 2025 16:54:55 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net V2 3/3] net/mlx5e: kTLS, Cancel RX async resync
 request in error flows
Message-ID: <aPeev-zbATKMq1pY@krikkit>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
 <1760943954-909301-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1760943954-909301-4-git-send-email-tariqt@nvidia.com>

2025-10-20, 10:05:54 +0300, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> When device loses track of TLS records, it attempts to resync by
> monitoring records and requests an asynchronous resynchronization
> from software for this TLS connection.
> 
> The TLS module handles such device RX resync requests by logging record
> headers and comparing them with the record tcp_sn when provided by the
> device. It also increments rcd_delta to track how far the current
> record tcp_sn is from the tcp_sn of the original resync request.
> If the device later responds with a matching tcp_sn, the TLS module
> approves the tcp_sn for resync.
> 
> However, the device response may be delayed or never arrive,
> particularly due to traffic-related issues such as packet drops or
> reordering. In such cases, the TLS module remains unaware that resync
> will not complete, and continues performing unnecessary work by logging
> headers and incrementing rcd_delta, which can eventually exceed the
> threshold and trigger a WARN(). For example, this was observed when the
> device got out of tracking, causing
> mlx5e_ktls_handle_get_psv_completion() to fail and ultimately leading
> to the rcd_delta warning.
> 
> To address this, call tls_offload_rx_resync_async_request_cancel()
> to cancel the resync request and stop resync tracking in such error
> cases. Also, increment the tls_resync_req_skip counter to track these
> cancellations.
> 
> Fixes: 0419d8c9d8f8 ("net/mlx5e: kTLS, Add kTLS RX resync support")
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en_accel/ktls_rx.c     | 33 ++++++++++++++++---
>  .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  4 +++
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +++
>  3 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> index 5fbc92269585..ae325c471e7f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> @@ -339,14 +339,19 @@ static void resync_handle_work(struct work_struct *work)
>  
>  	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags))) {
>  		mlx5e_ktls_priv_rx_put(priv_rx);
> +		priv_rx->rq_stats->tls_resync_req_skip++;
> +		tls_offload_rx_resync_async_request_cancel(&resync->core);
>  		return;
>  	}
>  
>  	c = resync->priv->channels.c[priv_rx->rxq];
>  	sq = &c->async_icosq;
>  
> -	if (resync_post_get_progress_params(sq, priv_rx))
> +	if (resync_post_get_progress_params(sq, priv_rx)) {
> +		priv_rx->rq_stats->tls_resync_req_skip++;

There's already a tls_resync_req_skip++ at the end of
resync_post_get_progress_params() just before returning an error, so I
don't think this one is needed? (or keep this one and remove the one
in resync_post_get_progress_params, so that tls_resync_req_skip++ and
_cancel() are together like in the rest of the patch)

Other than that, I don't understand much about the resync handling in
the driver and how the various bits fit together, but the patch looks
consistent.

> +		tls_offload_rx_resync_async_request_cancel(&resync->core);
>  		mlx5e_ktls_priv_rx_put(priv_rx);
> +	}
>  }

-- 
Sabrina

