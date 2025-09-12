Return-Path: <linux-rdma+bounces-13319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F8B55303
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 17:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B4AC71FD
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F0D31CA78;
	Fri, 12 Sep 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="YpCc6mTm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQN79vfI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591E27B356;
	Fri, 12 Sep 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690104; cv=none; b=mT8oBXG5pZUZ6poNnBNP8faLexO98u3L1f8PEgq6bMCMM2t251KN57gJ1NumRC+nOB+pG2HQwokyDwV0GYHPIc9KeE7eqFZ8waV/dZhGOFqjpzDv2+x6ZaypdjjnNksD2LGbAqdGGlzO/guthzvGd726JB4wuagLSWn7oDXDuWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690104; c=relaxed/simple;
	bh=sTA7wdLLP5StoLzQlnJfbA/m/hasnjg9SRRfSR18UGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2RI3B2BwuRIbvu8fSSZuMg/rLNfopRNGg5kzUid4t8XegAxRyX78eg8gc95iI+blv2Ai9n9bJ5zKAjCc4l+Am1IEgl8ujbS4Cf1aKHk2yhBOJVuaKuEdv/kjPUADZehrFtisLJBWovEWdpaNwtq5lI1xLXVdjWEoIPdL5EXZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=YpCc6mTm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQN79vfI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24A8A1400420;
	Fri, 12 Sep 2025 11:15:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 12 Sep 2025 11:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757690100; x=
	1757776500; bh=uvtZXsfcELV22AtbWmz3YRzUDbKCxWdiP6BvEqTMA3I=; b=Y
	pCc6mTmRbZ1PT+/u0Ku5tHOy3vZGinnuCT1oYEMaTR6M6tAYDYg12RLHY1WrZ84W
	qcs+iKRF9g+RmsmeffRAob1lH1jH8AdSzX++E8/IFgN5eBBFB/RwCpkM/Mm6cUBU
	h5HMTdU1hwb8WHLdEAkHkFZwYMQ115lyuH9D2IdhEVO7bICR9bO/4n+S4/ylTPXi
	DxiEmqL7+UDNocYRG8ct6xFnNxrtkmZRfYr7LIj9sMYwmkgDiN3XqPiFfALzikqL
	zOce/QfGHw4QlVr7qttCxjCFXXbRsQxISDsyAf23ud7iY0hO9+sN7i30TmLwN5by
	aI+bCu4hMRXcg+gEzkPFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757690100; x=1757776500; bh=uvtZXsfcELV22AtbWmz3YRzUDbKCxWdiP6B
	vEqTMA3I=; b=dQN79vfIb3K02YjC3P/u9/D+Y8Ug+2xruRrTk0h4gSS4AnwCt/K
	CsrMvG7iPWfXm9S2BrGBIU15m8AHDhkOvceGRGhlhVewELUsnt910wYdujOMbtiD
	5lZXmCgfp6WahdRwiDSmzbkkqrwk2sDkAPxNrVW7muCA0VxlY6uKfj4dZovAZ9a9
	FvXh4Xb5XC/E0VRwjz2WcHkHafhG3+QEWqRrZZUPTnsM8+LO7k1i8cDhPCxKyHF+
	jdpFQFdBPKQu6hJC37gIRPj3WERuNXnLSAXHjG5eYDRAY/ARMJQNYemic0uRtzBz
	YX0M6ahP82mwTFn9ONcZWzx88doIVL1uTXw==
X-ME-Sender: <xms:8zjEaPiw75v6e0-ZjTS1NqzxwkjqUUEn4uiUJRWuYXDUou1T6wrIGw>
    <xme:8zjEaH2x_gY7709oabEQ71Jw0gcxmG72T4HWvDL9AcmnnmZDIqxZyRoOvUcWTzC1i
    zqCXRVm8uDxELe3c8c>
X-ME-Received: <xmr:8zjEaEkeqrKPKhyY4z2sr2HXFazIUuieO5nCT51fjQszPpLNy3yBCQ1VTPWW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtrghrihhqthesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrth
    drtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhr
    tghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehsrg
    gvvggumhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmsghlohgthhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:8zjEaOuW7JgBvUC7YndKSAwADOCWAYc3fihhz8Lz9Ys1f7GvnWWeHw>
    <xmx:8zjEaM2vXWhfhufI4Mvq_3cT1BFykhcyD_ageMNbZaFforq90Uj9uw>
    <xmx:8zjEaCRG0UIdhYyt0j0dwt6ZE_Ze1ZCz3mxP-30XXXDWhjT8hu_SdQ>
    <xmx:8zjEaIuzh5Xt5akEBi6fRAh4YPjYIOFdHwTcUBhfNUrIdW0AIvlY9Q>
    <xmx:9DjEaLI5-lBhMfa3tbkMJi5kCLWWuGWd-N_NOYv8zH1PN7OIQfO0CZIN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 11:14:58 -0400 (EDT)
Date: Fri, 12 Sep 2025 17:14:56 +0200
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
	Gal Pressman <gal@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
Message-ID: <aMQ48Ba7BcHKjhP_@krikkit>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
 <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1757486861-542133-3-git-send-email-tariqt@nvidia.com>

2025-09-10, 09:47:40 +0300, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
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
> 
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  net/tls/tls_device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
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

Do we still need to WARN here? It's a condition that can actually
happen (even if it's rare), and that the stack can handle, so maybe
not?

> +			/* cancel resync request */
> +			atomic64_set(&resync_async->req, 0);
>  			return false;
> +		}
>  
>  		/* asynchronous stage: log all headers seq such that
>  		 * req_seq <= seq <= end_seq, and wait for real resync request
> -- 
> 2.31.1
> 

-- 
Sabrina

