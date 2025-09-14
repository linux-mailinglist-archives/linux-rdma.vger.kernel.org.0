Return-Path: <linux-rdma+bounces-13343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F8EB56B64
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Sep 2025 20:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3554189CEB6
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Sep 2025 18:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37AB2848A3;
	Sun, 14 Sep 2025 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzXF3cyb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70F524F;
	Sun, 14 Sep 2025 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757875993; cv=none; b=V8TtUoSTKdYn1aoqsGLftv/8qu5tSMZtpa0bDMKNku7TZOHFAkD70dl46eAlxLgwHUGWO1Bmvc0JuZHbA/avx7DHQKYIozYnwY1V/Z3+9GFMzw0PaorTXKUX1p+aftegVnfnsYxBxS0Q31kA38phJp5TiAe0hikaWVkZ9SENFEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757875993; c=relaxed/simple;
	bh=vRulN5Ws2bSafIoz6k8RtzXdFbdwEv4KS1xaxUy+gdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkseBgluSbCxju0XpEO9MAeBIbJiSBgIVQlRTEb39v0qorHoQ6OaxakaKsVTpSts9CJO+s6K09g3UpT6P2vtinQocQLdrOEyJ3xAW8wroIXO8WQgZjMJV1OlRrajuSPqTtsNeUC2I/bPFOS3yDANRky2ceSSpkb7643wgjv0KpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzXF3cyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178C9C4CEF0;
	Sun, 14 Sep 2025 18:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757875990;
	bh=vRulN5Ws2bSafIoz6k8RtzXdFbdwEv4KS1xaxUy+gdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZzXF3cyb/MrINN76yKV+0IrvkIcBrVfD06i2yk4mUiyA6SN5gAe8OjNAZk1ZHeyk8
	 2xVr0UtahgZCTaXXFtWVUuGjax2mDJa1+s1FFKgjLzJ8f/YgyLslnWW6RKfXDjoHvF
	 HA6iBG5x/zpraaEWrkkpjFJFxI9hEElxtctjlIsxAx/6BgFo5P7zWFe65K80swmJrj
	 aRo6BaCdx5XBQR0R39JvvYVU5gqqR7PBdlUCF3Q6ITKpShlIZgm5+rVf6PEaxhA4Bs
	 LyUn+BLg0VCZKq7SV4t9nRHYixpD3YjtJeU/RHdyauHrzyosvg9dcVYkpZiLYdBFZ5
	 XJmyT+AHu1/FQ==
Date: Sun, 14 Sep 2025 11:53:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "John Fastabend"
 <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
Message-ID: <20250914115308.6e991f7d@kernel.org>
In-Reply-To: <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
	<1757486861-542133-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 09:47:40 +0300 Tariq Toukan wrote:
> When a netdev issues an RX async resync request, the TLS module
> increments rcd_delta for each new record that arrives. This tracks
> how far the current record is from the point where synchronization
> was lost.
> 
> When rcd_delta reaches its threshold, it indicates that the device
> response is either excessively delayed or unlikely to arrive at all
> (at that point, tcp_sn may have wrapped around, so a match would no
> longer be valid anyway).
> 
> Previous patch introduced tls_offload_rx_resync_async_request_cancel()
> to explicitly cancel resync requests when a device response failure
> is detected.
> 
> This patch adds a final safeguard: cancel the async resync request when
> rcd_delta crosses its threshold, as reaching this point implies that
> earlier cancellation did not occur.

Missing a Fixes tag

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f672a62a9a52..56c14f1647a4 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -721,8 +721,11 @@ tls_device_rx_resync_async(struct tls_offload_resync_async *resync_async,
>  		/* shouldn't get to wraparound:
>  		 * too long in async stage, something bad happened
>  		 */
> -		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX))
> +		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX)) {
> +			/* cancel resync request */
> +			atomic64_set(&resync_async->req, 0);

we should probably use the helper added by the previous patch (I'd
probably squash them TBH)

