Return-Path: <linux-rdma+bounces-13577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4631B9213C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EA82A32BD
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E449B30F928;
	Mon, 22 Sep 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mtG2rvuJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsWjqxXY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14F30DEDA;
	Mon, 22 Sep 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556456; cv=none; b=CihG7d6LJhnMGUNy3kAxJZ7xIoGZKUt/j/XtE1sbWhnOeVbEqz5wrOPerBMtrxKMAPZNAtleWO+xZ6WPFJQf29OghQHAuGyvAzc/YPqldFQsXWc1LKoZL4YKWwReHWk2c+JnJWfOOIMRbVdBGazNYedrPPl1Ier2jktVLLNDeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556456; c=relaxed/simple;
	bh=WLw30Tf1j8Cie++dYGQQJq3f5lkPiJO5JJxaGR8TD1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5dB4CLgQAHxuOz45srT8ukrYfl3ZY8g50VzhbDlwu34PlhzEcctrCYEnoVI5+T44LvjIFPzkABHL/L6OxseK33XGUrKX1gMGBByloOROEXPfaeHWhOdwDZIhZtZ/7YEaAEaqew4ujFbLvuhg6zYoaKNHBNToV8h9vImFE4uhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mtG2rvuJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nsWjqxXY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E9AB1400179;
	Mon, 22 Sep 2025 11:54:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 22 Sep 2025 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758556452; x=
	1758642852; bh=oxbmvxOBKYdNbgHBaFZ5AkGpkPFUn4QrzOZOzIFtxQc=; b=m
	tG2rvuJrmZJwzsd4ms8sxHMlalW9irIC9aqq38BYtH+JvRS29uRY+tvCc01904Gl
	zn3JrrDSMlvzcm9IBGSmdC/LyYATIaDFyPt3lZGdR5maGRxhoff86RNZLzaoBDWX
	Wg1U4ievoHJCsVFdrLk6NPWs2WhlV+dMLOTEAyoppW1qNuYpahca5WrR1QJlrcnZ
	kvcUY8TjD+4CS2+t0swMDr89+YymjNp/zoLduqJ6MqLqs9bS1vv6cIrkIoMQ8Gfm
	tvrInQSsmB+bzZA8Q+eijWijVmlHXgJki4BViNnsQYc7qz7e3rJyFQLVBKb9trsT
	osMoyQytBqf/m6Zta8uZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758556452; x=1758642852; bh=oxbmvxOBKYdNbgHBaFZ5AkGpkPFUn4QrzOZ
	OzIFtxQc=; b=nsWjqxXY9cvdN+uve8bK4dzPewRJsaKNO4Av5SRaL76IJX7TdWS
	2A//+VkfLWnpJXWU67ezPAEjgpFpBXathURgGMCxHW3Y5en0VbSf3GE+K76FUcmR
	Srjggy6w7VTXdhGYb+mKD6t5ziuTLinUyMFtEWpXNNKqXDX70yOSbUTosn84jqsN
	3S2hnVw+Tl1CWCwD9GAFDi6w4IgoHC9NoO2r8k0MtMM7rUY33Hq72lPZuExmk1kC
	KPCVIzTNQYvOB7F4epn4RtDJVvN0N+YQ6odFISkcLEyH4ouiLhbxOzOC/LQr+jZk
	RIY6bXXSyNE42B0qpjO5ToX4W9p4nHLd/Aw==
X-ME-Sender: <xms:I3HRaBoeDfoXoIhoSSigbJ4yl5HK_xoZaiWyvylMmsxX7ctuEDp29A>
    <xme:I3HRaJOMTEDgIy11TXEehDqItHa-psWkd1vnKRFFBK9tzLtIptgBR8wxB8nQI3dLK
    qSLS75XnDAq1eOa-pgCnTOT6Ix_shQRXQNewjj9akY4S22Pikj0dBc>
X-ME-Received: <xmr:I3HRaHx0uUyOp3onyZIwZOY1U2Ol0YliEPY5IaAmNwvgv59E8O3k5Q6xBcXD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshhhshhhithhrihhtsehnvhhiughirgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthgr
    rhhiqhhtsehnvhhiughirgdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepug
    grvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehsrggvvggumhesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:I3HRaNw-dBO5K5QWiLRW1Rk5vRE2VFwoi5qak_soktcvSQjDFQyT-A>
    <xmx:I3HRaIKHxOm_xxH6sF1eCVYGo7IHMBZOetdW0fEmteKXD9YfDhjS7w>
    <xmx:I3HRaBjKqpPwCuaW34C51niT3KLihWZB1hzSBivZ2k4uJMgGQff9Og>
    <xmx:I3HRaBPaaD_gkLNgqCEgBbYn-f7-4Mon8OCvn1hY3SLG2ndzsw3ybA>
    <xmx:JHHRaCwxVADe0SYbhCCw0pNqgUuUvkDG89ucmi1MRg0GK4JLhAUVEBn0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 11:54:10 -0400 (EDT)
Date: Mon, 22 Sep 2025 17:54:09 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Boris Pismenny <borisp@nvidia.com>
Subject: Re: [PATCH net 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
Message-ID: <aNFxIfD2aPpB11dC@krikkit>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
 <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
 <20250914115308.6e991f7d@kernel.org>
 <0b7a83ec-d505-40c3-afa4-8f6474cd78d9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b7a83ec-d505-40c3-afa4-8f6474cd78d9@nvidia.com>

2025-09-22, 10:18:52 +0300, Shahar Shitrit wrote:
> 
> 
> On 14/09/2025 21:53, Jakub Kicinski wrote:
> > On Wed, 10 Sep 2025 09:47:40 +0300 Tariq Toukan wrote:
> >> When a netdev issues an RX async resync request, the TLS module
> >> increments rcd_delta for each new record that arrives. This tracks
> >> how far the current record is from the point where synchronization
> >> was lost.
> >>
> >> When rcd_delta reaches its threshold, it indicates that the device
> >> response is either excessively delayed or unlikely to arrive at all
> >> (at that point, tcp_sn may have wrapped around, so a match would no
> >> longer be valid anyway).
> >>
> >> Previous patch introduced tls_offload_rx_resync_async_request_cancel()
> >> to explicitly cancel resync requests when a device response failure
> >> is detected.
> >>
> >> This patch adds a final safeguard: cancel the async resync request when
> >> rcd_delta crosses its threshold, as reaching this point implies that
> >> earlier cancellation did not occur.
> > 
> > Missing a Fixes tag
> Will add
> > 
> >> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> >> index f672a62a9a52..56c14f1647a4 100644
> >> --- a/net/tls/tls_device.c
> >> +++ b/net/tls/tls_device.c
> >> @@ -721,8 +721,11 @@ tls_device_rx_resync_async(struct tls_offload_resync_async *resync_async,
> >>  		/* shouldn't get to wraparound:
> >>  		 * too long in async stage, something bad happened
> >>  		 */
> >> -		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX))
> >> +		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX)) {
> >> +			/* cancel resync request */
> >> +			atomic64_set(&resync_async->req, 0);
> > 
> > we should probably use the helper added by the previous patch (I'd
> > probably squash them TBH)
>
> It's not trivial to use the helper here, since we don't have the socket.

tls_device_rx_resync_async doesn't currently get the socket, but it
has only one caller, tls_device_rx_resync_new_rec, which does. So
tls_device_rx_resync_async could easily get the socket. Or just pass
resync_async to tls_offload_rx_resync_async_request_cancel, since
that's what it really needs?

-- 
Sabrina

