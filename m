Return-Path: <linux-rdma+bounces-13962-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C262FBF7690
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 17:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7418D4664A4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618E340A64;
	Tue, 21 Oct 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="illozJEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zDZnIRCs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F118F40;
	Tue, 21 Oct 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060517; cv=none; b=dzOlHhSuXk6QR33YXLFuSfA1ATgXeXjpQbWJayISvduh2B+z4/WmNr9r9quQXbbZRnv16Cf/GRAj8qC8h9I7kSGeYyE5zyQlMtvmt4Ja7XThL1Fq1rlQqCY6usIrPCqHgJpuP5WqRnt8BYvQhubV0M22PDS089wR7e0Hyc7m9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060517; c=relaxed/simple;
	bh=U49MvGVLzCqO4hQorwFLQBzFnxw3haJO6lOXYCje+Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACrOggPGOCosOVXKqBmwPvtUdHaY8fGjYTJdu72Zyv0AnFeBqsU9WBD7+Ex9oznceuynsxzF76f2yRt3RKfQ+q5NbN6zy5kDUsamGUL+SIgSHhjeFIXR8tpmpFukdGOyL8VkyiMlREScstr/iJD1xBior1AzLBWbUPdTINuA6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=illozJEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zDZnIRCs; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 678BE7A00F6;
	Tue, 21 Oct 2025 11:28:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 11:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761060513; x=
	1761146913; bh=RsSUkrCMKOIZxBieiWhZiSAasxCCl0dZ3IycAPFI1Z8=; b=i
	llozJEcDwTEnTUNBLxxSbL1ju1AXDFkwFINDkDMWCBSN3cQsCrUY0xMqldTjyXbk
	mb9EU5kmUtbGKe8x7WUtHPvWWJffwERZBQD10EYu203QoMLjEZ0ft52k3URqoAVD
	4QWlsWgFeSd4GL3Y8nXKJH2JS7g1MRGXbaF71wpUxPr15WMSnI5imFrRFpLL7bEQ
	hT1Qx+BI7MzU+T0HlkztqLL0VBbQW5xx5cl5VXkuSMSGBhXR4pGpDfb1DkZaEc3d
	tnYLOPj2q4dxabsreQBW0WO896QuXm+fzUaw6VUerUSzTlXpFINztKf4pWMN8r8p
	uixCkNbwoHih4MRY2oZkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761060513; x=1761146913; bh=RsSUkrCMKOIZxBieiWhZiSAasxCCl0dZ3Iy
	cAPFI1Z8=; b=zDZnIRCsLrpj8ykWp5MruUFvf3HmG6nJy+rqSYJGpubpU7w4vyz
	KyI+bBDWx7BmteyeGwO4ZyfxrkZ1qXBGenGJyPJKU7MYEke1LGBYnMOHWpQHZWEY
	aQA7XJPoCZSm5pOZAPRGbJ5IzVoRa25HKmLT0J4uxjiuRwZ/htBTzVVV4tsbjTQ2
	+FsS1K176ynrE2kqlF3i2i1W+vZ7D6cO0e8BDBQfEvInuV7vIDyS0yvdpVFWI8Pi
	5wPRaGWsqDKZBB9eXmpcFLqTilbAIAHTtmM/mqKH6TEvCgXMcn9fm+rSG+PN03t6
	E1SNmtyrtJNcoHTVz9UCzW+dCHY9poEqE1A==
X-ME-Sender: <xms:oKb3aEo5xXABWs-iE0--njefAg-uXIOKF2pu0xHSGVkDPqcapFKDOw>
    <xme:oKb3aKEEEU1dO_gCJtJfwteF0iM6emprr2phWf1W0Vsvjfme8yYD4HDOPW_haPVBu
    9hIFIJZ9S8S_s8cMlYM0tHZg0hl5iZlvWxCfI6hucKnbc30dvBZxUA>
X-ME-Received: <xmr:oKb3aKSj_pDb_MxuG7PXdoVURPvzKUZ3ztVguQ2o7W14AYBDlPnpisnIFxFe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedutdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:oKb3aAN4S8qGvgOjOjb0k6yxZQelzEGCPd2UrZh2WKG8nN7fZ7i71w>
    <xmx:oKb3aHk7nI2ULWYKx2-5v7GPRvrYjeTqlCxwSOz3wN8n_PCHmNeinA>
    <xmx:oKb3aCbYEcENiDKWuZ0jL08Z3ruuT23N8OraPXUDJcpemp8KizMKkQ>
    <xmx:oKb3aNQ2fo5pV4tLQD5rKPm9iVxvLxa4YT4kqykVtJsshJPYxJ8mPw>
    <xmx:oab3aAOR1ilAtzKsOP-KQ7oavNqnP634HWbezqw5opN9CUkSbGs1jOgP>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 11:28:32 -0400 (EDT)
Date: Tue, 21 Oct 2025 17:28:30 +0200
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
Subject: Re: [PATCH net V2 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
Message-ID: <aPemno8TB-McfE24@krikkit>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
 <1760943954-909301-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1760943954-909301-3-git-send-email-tariqt@nvidia.com>

nit if you end up respinning, there's a typo in the subject:
s/rdc_delta/rcd_delta/


2025-10-20, 10:05:53 +0300, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> When a netdev issues a RX async resync request for a TLS connection,
> the TLS module handles it by logging record headers and attempting to
> match them to the tcp_sn provided by the device. If a match is found,
> the TLS module approves the tcp_sn for resynchronization.
> 
> While waiting for a device response, the TLS module also increments
> rcd_delta each time a new TLS record is received, tracking the distance
> from the original resync request.
> 
> However, if the device response is delayed or fails (e.g due to
> unstable connection and device getting out of tracking, hardware
> errors, resource exhaustion etc.), the TLS module keeps logging and
> incrementing, which can lead to a WARN() when rcd_delta exceeds the
> threshold.
> 
> To address this, introduce tls_offload_rx_resync_async_request_cancel()
> to explicitly cancel resync requests when a device response failure is
> detected. Call this helper also as a final safeguard when rcd_delta
> crosses its threshold, as reaching this point implies that earlier
> cancellation did not occur.
> 
> Fixes: 138559b9f99d ("net/tls: Fix wrong record sn in async mode of device resync")

The patch itself looks good, but what issue is fixed within this
patch? The helper will be useful in the next patch, but right now
we're only resetting the resync_async status. The only change I see
(without patch 3) is that we won't call tls_device_rx_resync_async()
next time we decrypt a record in SW, but it wouldn't have done
anything.

Actually, also in patch 1/3, there is no "fix" is in that patch.

-- 
Sabrina

