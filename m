Return-Path: <linux-rdma+bounces-13976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB6BFBEAC
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 14:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BF2E349424
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 12:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139B347FCA;
	Wed, 22 Oct 2025 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="UxGR4x5p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fT55qfJg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CB3191A1;
	Wed, 22 Oct 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137274; cv=none; b=iS9ZBhgR45njmPbpUBIuHwdhzNtGdg487O2XV3QSmWUavucxLVwm8U9MjMPXRAG0FvJajZDmrdsFImpZrt6/7G+tZyCuj3FZmbaQ+o5FZuG9tu0C0yKX4UQoEghAeHTgU3jSiGmQfM8kK/R0HuLQUgZtAmGcy+6eZnutCmqZdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137274; c=relaxed/simple;
	bh=cG8noai2W8YSEH0BaQ/J3UBAfOo9Q7IkDxX/lpAP9nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvk9QTKVCbKv+5H5OnTzOWyXnaWJ9bRAR/QJW+N3RXvO7/5e0HXccrQUlGWE7IQJIGYDD3FPOlnEgMuACzk13UUjF4+nOpF9MTJZkclcUARY9NhNzR24uDxw/tRkIQsa+0n1Wo0/wLPWUuctLNZsfRMzIuC9v5sNrD0Dq58o0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=UxGR4x5p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fT55qfJg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6DA88EC0169;
	Wed, 22 Oct 2025 08:47:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 08:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761137263; x=
	1761223663; bh=A0VTtOmF5fNkFsxu94lUPFDgCfNpNIBkLTSLEFv6gqo=; b=U
	xGR4x5prz5fCol3kOscuXG6QOjiCn0+d5bvyN2/wF7nRE/NMK/RhAabi9O+c+nuf
	nDAcgE6XY3iauM5Qu8cQtKNFA2W3ICgXdriFYVh14gI8MQzcJPw7wcr0pkrPkW4A
	mw/LQWjcwx07IWBiRSzxlWkrWkTmgKDQRLyLRS1mleeqLH1Har+jIFYexmy47IQf
	PEvleO9SVwlJi8wW154c6ymwKDmWwN+M4DBmXRNYsbiG9rhCWYpFYsZPmDaELFVC
	FaYPs05NhRzx8BQm/2BI9flN7IBkmAa7xQfG59cm8voFvXeEPdFRTcWXQCCnjUqf
	OVNCWmf/hOpGEmkaPAJwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761137263; x=1761223663; bh=A0VTtOmF5fNkFsxu94lUPFDgCfNpNIBkLTS
	LEFv6gqo=; b=fT55qfJgjWEqR5nUDft9SPPWdfqaK0ng3PrjLypNe4ShSJKHrft
	+AXpGh6ACch5/deY9frIrWqmztWoYRn+CiY9fw4W+pCJYPZL2MIOx1v5xaO7bzKH
	O4bvrcha2WS4eYPgnuZupFxUhcr/yzvkx6onxv6spmtPYXeByVeZer8T8oEkRQEV
	D2FaW/R8aSkNWKVf1SJEa1ivplEti6MFemvpO9xrwhmxNSH59ryOSQ6UXsIZis5P
	GhxCTapHGGQYcw5IQxkuRy1YE9v99gJwt7yUCp7uHOj7fIIwXukqNQMBL4k1SnRh
	1Ns6LNnh1WKEOyI6Ygl3nM8q2dClmmomSVg==
X-ME-Sender: <xms:btL4aNEQ3e6Bezih54dU1Et7tIqNvDCmiNdX6sBTGk4i42AdrCbDYg>
    <xme:btL4aBwTTyt1ogYxKQIYe4Pk6j16O-TUUPBIGTl2890ozGNYDWf4QFdjLaVJqlyOt
    4ai49zpQ6sCvVBKLvZH0zMltspK_Uig1WiWNmguMJRi2qvl3F__LBk>
X-ME-Received: <xmr:btL4aANQ0fXjMGQrweBEeB5jSNSHGiUCqlLL99WZytnwIIN_rJEGuv8wSkN2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhshhhihhtrhhithesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepthgrrhhiqhhtsehnvhhiughirgdrtghomhdprhgtphhtthho
    pegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhr
    tghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhope
    gurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepshgrvggvughmsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:btL4aHY2cEgQ5oAEwnbWjKGTQJXkrLeTgxOlPHDif_ZVBHJfHP0s1w>
    <xmx:btL4aHCkYJI7e_tAGd7oK2eUrwXHE9FnycAOK1tKUr0z0bxn7xc-Eg>
    <xmx:btL4aFFztDSOhYWv6as5lPawGIKsfpfePls_vebU0jVM1eE1sKqRNw>
    <xmx:btL4aCPqxjcguybzLXs9GpJRrXrFnyhhQogzZnxlLe3Ui4jjnua84g>
    <xmx:b9L4aD6aVsdbAZnIoIe_n-m7skbUYKWwR6azazsP8Bs5320J6r1k4Lct>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 08:47:41 -0400 (EDT)
Date: Wed, 22 Oct 2025 14:47:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net V2 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
Message-ID: <aPjSbFE-nQwDHUu1@krikkit>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
 <1760943954-909301-3-git-send-email-tariqt@nvidia.com>
 <aPemno8TB-McfE24@krikkit>
 <ae854fd5-dda1-416a-9327-ac8f9f7d25ba@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae854fd5-dda1-416a-9327-ac8f9f7d25ba@nvidia.com>

2025-10-22, 14:38:17 +0300, Shahar Shitrit wrote:
> 
> 
> On 21/10/2025 18:28, Sabrina Dubroca wrote:
> > nit if you end up respinning, there's a typo in the subject:
> > s/rdc_delta/rcd_delta/
> > 
> > 
> > 2025-10-20, 10:05:53 +0300, Tariq Toukan wrote:
> >> From: Shahar Shitrit <shshitrit@nvidia.com>
> >>
> >> When a netdev issues a RX async resync request for a TLS connection,
> >> the TLS module handles it by logging record headers and attempting to
> >> match them to the tcp_sn provided by the device. If a match is found,
> >> the TLS module approves the tcp_sn for resynchronization.
> >>
> >> While waiting for a device response, the TLS module also increments
> >> rcd_delta each time a new TLS record is received, tracking the distance
> >> from the original resync request.
> >>
> >> However, if the device response is delayed or fails (e.g due to
> >> unstable connection and device getting out of tracking, hardware
> >> errors, resource exhaustion etc.), the TLS module keeps logging and
> >> incrementing, which can lead to a WARN() when rcd_delta exceeds the
> >> threshold.
> >>
> >> To address this, introduce tls_offload_rx_resync_async_request_cancel()
> >> to explicitly cancel resync requests when a device response failure is
> >> detected. Call this helper also as a final safeguard when rcd_delta
> >> crosses its threshold, as reaching this point implies that earlier
> >> cancellation did not occur.
> >>
> >> Fixes: 138559b9f99d ("net/tls: Fix wrong record sn in async mode of device resync")
> > 
> > The patch itself looks good, but what issue is fixed within this
> > patch? The helper will be useful in the next patch, but right now
> > we're only resetting the resync_async status. The only change I see
> > (without patch 3) is that we won't call tls_device_rx_resync_async()
> > next time we decrypt a record in SW, but it wouldn't have done
> > anything.
> > 
> > Actually, also in patch 1/3, there is no "fix" is in that patch.
> > 
> 
> I agree about patch 1/3 so I'll remove the fixes tag.
> 
> For this patch, indeed at this point the WARN() was already fired,
> however, the bug being addressed is the unnecessary work the TLS module
> continues to do. For my liking, the wasted CPU cycles and resources
> alone justify the fix, even if we've already issued a warning.
> What do you think?

Is there any work being done/avoided other than calling
tls_device_rx_resync_async and returning immediately?

With or without the patch, tls_device_rx_resync_new_rec will be called
during stream parsing.

Currently, resync_async->req doesn't get reset so we'll call
tls_device_rx_resync_async. We're still in async phase, rcd_delta is
still USHRT_MAX, and we're done, tls_device_rx_resync_new_rec returns.

With the patch, we'll see that resync_async->req is 0 and avoid
calling tls_device_rx_resync_async.

Did I miss something else?

-- 
Sabrina

