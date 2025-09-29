Return-Path: <linux-rdma+bounces-13727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73791BA8C84
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 11:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F0D189FF56
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174BF2F068B;
	Mon, 29 Sep 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="rSEb0e6q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eic64eEs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CE2BDC2C;
	Mon, 29 Sep 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139649; cv=none; b=V8z7gGujBdgdn5PG89G8MwwEjQwZi2JLWkeF0JNO6bBfz4C1vcfC6UT05+lLSajEeJnD5GYag5g3b2QDKXSX5uMTAZRzzIMliZg9W3hlydKA8smXEiSVM3sxYJ+MzFPlib3ypOUYAMSx3dGRLbBv3WItXnqzNYqCNdhn4kLJnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139649; c=relaxed/simple;
	bh=v+wEtl5tHLqrDwnWMVgOrOW1sli01owpUUF4Of7bsgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jowkdct0TqysS+QxpYxibI0hiFX3YS30zc1Oon99elSiyPuxudmjWJsqas6jQLhMUnUfX2t8IVcNTkqv9zwEYU5NEqWd8eIltHxa5TUPyTYea/HuFsdL2y2s93EC6uKLMvj9+d5XfFCiq/wzZC4PKYLJlkF1ZrZUWbJLd41gJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=rSEb0e6q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eic64eEs; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AA6021D000DA;
	Mon, 29 Sep 2025 05:54:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 29 Sep 2025 05:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1759139644; x=
	1759226044; bh=/rc71YCEHhKLBV9D9Me9cJn+cjShEvg2fEZj5cVG/80=; b=r
	SEb0e6qK7s1Nhg7X/zrH5w/UhJiZB+fCjpTk2pVImI5lSwt4g+nnHjrs7eDtFQVA
	sQUjBtV86x7Puhbxo/AhNukgZmxJat9Vrju6hbQNsjmGoh0FYQqVuZpLX79PuZ91
	iQgKnlr4g868kDELzcIU5T4J1NiMp1HFoL/9f1DofrshNxvEdp121K8c0qzprX6v
	bipxSPAkKK8EPj6WruI43uuCnrCpiCUJLhDR0uUN7EhauwjPCzc73jpbUvm8XBcL
	WY8vGO7BzgQfCGR//yqx3fQIDH3xIYUjY7AP7k6N0lYK3ZvVZxHWwSvf8gbVtoEi
	pYIxbYqEjJIj7YmCGf20Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759139644; x=1759226044; bh=/rc71YCEHhKLBV9D9Me9cJn+cjShEvg2fEZ
	j5cVG/80=; b=Eic64eEsuV6/StBR02jIhXz6jcjLCkOF4JQjpjPJBW618CEMTZq
	GOX/XKWn1Hp5GBxzMj875Yst+DgkSKYodgw2RTbxeWTshyVtK8i/51IfYPIpAFeO
	vmDg+nmeTMqAYZtWRAjrwOWHfxCp7MQmxsJ2jjTAJOgkICbz8zGJp9nqI8d3jkiG
	G5zgpF/B5tUh4BcwHXztGZt98g6iecLzPPU/idx+1tjNJi3y/p3Wnq4yzMUvWVkJ
	paI7k9CkUPTPH8fw/X0mluECRjRQmBIWOQxQThdJQytfc/U962l64UANtk3yQJDU
	T+vBSPRD8/GWV64VEl/+vad5rPWlo7UWl4g==
X-ME-Sender: <xms:PFfaaCiL2pFsfzulugGhltWX93suoortmGzIG9DO5Ae6siwbeunagQ>
    <xme:PFfaaImPph8F7H74Ip1I2Oto3VnaplIrgUjhp2M7tnyjxSSc9M3EGHuXiYge1ERpa
    3yYg2rov06Hp5rGHU5lDG5HWgL0biP66dXPm2oDAtz45284p_D2uZs>
X-ME-Received: <xmr:PFfaaDq7fVOYYa6arnJvPXpq9QWseFlCUKMacbYh8yii2WEbegayKHaKNB6v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejjeejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:PFfaaMIRvUf6bUVE3fnJWlnUVp1hkEtLQMeRV3eUeJcv1dTLsXcQFw>
    <xmx:PFfaaHD3SHp-4n1tjYdfJYZW7D8pKjvoZHPj0XNKR-opAYa591WxIw>
    <xmx:PFfaaG5GBqxIzocndHZte0a_wM-IlgfX1UuJ4znnUioqYy-5PRSF-g>
    <xmx:PFfaaLEOWgMlarRMyiq1pj7p86xSR4rwlKdhr36EMjssVgqF6kcYcQ>
    <xmx:PFfaaGp_rF8iLiksS-1kTyh9KMojhfeOrAZYPMBbe7sK6kmYN4C_BweF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 05:54:03 -0400 (EDT)
Date: Mon, 29 Sep 2025 11:54:01 +0200
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
Message-ID: <aNpXOS3DmdtD9RU0@krikkit>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
 <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
 <20250914115308.6e991f7d@kernel.org>
 <0b7a83ec-d505-40c3-afa4-8f6474cd78d9@nvidia.com>
 <aNFxIfD2aPpB11dC@krikkit>
 <cd0210cc-2531-4711-8a15-2fbae77cbf0a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd0210cc-2531-4711-8a15-2fbae77cbf0a@nvidia.com>

2025-09-28, 09:35:48 +0300, Shahar Shitrit wrote:
> 
> 
> On 22/09/2025 18:54, Sabrina Dubroca wrote:
> > 2025-09-22, 10:18:52 +0300, Shahar Shitrit wrote:
> >>
> >>
> >> On 14/09/2025 21:53, Jakub Kicinski wrote:
> >>> On Wed, 10 Sep 2025 09:47:40 +0300 Tariq Toukan wrote:
> >>>> When a netdev issues an RX async resync request, the TLS module
> >>>> increments rcd_delta for each new record that arrives. This tracks
> >>>> how far the current record is from the point where synchronization
> >>>> was lost.
> >>>>
> >>>> When rcd_delta reaches its threshold, it indicates that the device
> >>>> response is either excessively delayed or unlikely to arrive at all
> >>>> (at that point, tcp_sn may have wrapped around, so a match would no
> >>>> longer be valid anyway).
> >>>>
> >>>> Previous patch introduced tls_offload_rx_resync_async_request_cancel()
> >>>> to explicitly cancel resync requests when a device response failure
> >>>> is detected.
> >>>>
> >>>> This patch adds a final safeguard: cancel the async resync request when
> >>>> rcd_delta crosses its threshold, as reaching this point implies that
> >>>> earlier cancellation did not occur.
> >>>
> >>> Missing a Fixes tag
> >> Will add
> >>>
> >>>> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> >>>> index f672a62a9a52..56c14f1647a4 100644
> >>>> --- a/net/tls/tls_device.c
> >>>> +++ b/net/tls/tls_device.c
> >>>> @@ -721,8 +721,11 @@ tls_device_rx_resync_async(struct tls_offload_resync_async *resync_async,
> >>>>  		/* shouldn't get to wraparound:
> >>>>  		 * too long in async stage, something bad happened
> >>>>  		 */
> >>>> -		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX))
> >>>> +		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX)) {
> >>>> +			/* cancel resync request */
> >>>> +			atomic64_set(&resync_async->req, 0);
> >>>
> >>> we should probably use the helper added by the previous patch (I'd
> >>> probably squash them TBH)
> >>
> >> It's not trivial to use the helper here, since we don't have the socket.
> > 
> > tls_device_rx_resync_async doesn't currently get the socket, but it
> > has only one caller, tls_device_rx_resync_new_rec, which does. So
> > tls_device_rx_resync_async could easily get the socket. Or just pass
> > resync_async to tls_offload_rx_resync_async_request_cancel, since
> > that's what it really needs?
> > 
> yes these are options, but we don't like too much passing the socket to
> tls_device_rx_resync_new_rec() merely for this matter.

Why not? If you felt the need to add a comment saying we're canceling
the request, using a helper instead that says it does the canceling is
a pretty decent reason to add whatever argument
tls_device_rx_resync_async needs (or swap resync_async for the socket
if you don't want to add another argument).

> Also we wanted to
> keep tls_offload_rx_resync_async_request_cancel in the same format of
> tls_offload_rx_resync_async_request_start/end meaning to have the socket
> as a parameter.

Then they could easily be changed to make the 3 helpers consistent
(all taking resync_async), since
tls_offload_rx_resync_async_request_start/end are used exactly once
each.

-- 
Sabrina

