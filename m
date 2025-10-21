Return-Path: <linux-rdma+bounces-13960-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78B0BF731B
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB2718815F0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AA534029D;
	Tue, 21 Oct 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PazWs+dZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kk76gNOg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D4340295;
	Tue, 21 Oct 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058545; cv=none; b=tKFVLOqJhLZpKonYKaKgmQX9kFtTRcAsyiufWvly6gBIolcKs0gOAQ8XcR/1NfspDkteDpctmQEZiGg3yam6riKcB/f4b2ePxUuVDxye1y2bbmdS6qxsZCNFGj142OWP8WVRGiwAdPVlgu/F1mq19IPgMn3++uznPrHhVR8JTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058545; c=relaxed/simple;
	bh=ZHKXRQnOr45eMNPdTrXJCDdwQdNWjeacIeNiXkeVips=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjD+n1JDnnsbMc7vyBBvBdWIuDo76pMrnucOTFE2k6xgtm/rONikfILwcZiSxhL/ti5OhZMZL+BkOCfMjbiXax2Ys8HCIy0lgwRt+9znjKKMmWY7Kvvy9vkqhFqf69JoilEKDnFnQbn1YKBQZtFS9IbN60mIF8nb7RmFRf9u1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PazWs+dZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kk76gNOg; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BDA637A007D;
	Tue, 21 Oct 2025 10:55:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 10:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761058541; x=
	1761144941; bh=uKgl255miv6qiJG3yGmCoN/VZZMKpbBf187RZlaNjO4=; b=P
	azWs+dZr2N7GwfVwiaCqsNKMJUBpT/CbRxIjt7zMcYc3lrFMzI3Pitjn59atg81S
	aRiiyz0y5PV4NZ/kfYEpLkpNExUjUZSWL/iH0mLgpW4OBj3jXvhUq1rKh23nOemm
	EXXUvvmSF2vdy26MBUKC5NmrPbNf6rC749fmPGAFtVi5Bkb1oTPdZRbkDE57lSmA
	tkIfj1zqOqdlHsH/OD3VpZCGE4+8KmtdyWp/idlWko0W7+0hJkkT0p6BJiY4Ycyx
	1N8OYXcbQZ1bXRh9zrQuGPG6mapSDc8/BZ/LLVFnH2TdnrHlIGAZkwGlGYGdmxml
	I5lC6wRvsoP3lE7SoI+Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761058541; x=1761144941; bh=uKgl255miv6qiJG3yGmCoN/VZZMKpbBf187
	RZlaNjO4=; b=Kk76gNOgqsutCTopivhiMFGEu1BaW5EQigqy43wfK6PUse72527
	HJN/AR9Yn3DpDOnJpECGvHGDfv8kiWqA9DBZ6PsvvF9/wAL+HlSS8wr3Pu73OHuC
	eZnaa5ViEeuU7SR+NfDxwg7voS6lUwCsUmGXZVuwJrMpgxdlKZzqBS2CeZI+2G6D
	kIELo7jQ1KRLECH0xuu69z0yr2vZfd8kfXFp9d7+qqnvzOQw5/wtKm14cpxFC50k
	4MdeeRiwpgEyGeR8XmSsb6zIE5HRv7mN3EcdtpzDuSeVd0MJ/JWW3XOGA9yQX5Zc
	hRNO6swJvgKVICdwMOEdT343aUSz4JeX9RA==
X-ME-Sender: <xms:7Z73aLM42opTAPPOzaEgrKiRUTPCEAL2M9SbJP_TVRjCOumu98Z9WA>
    <xme:7Z73aFYaRshthxN2eWD2fQPMIrDFjk3moGUdhYxMdaNCZ8fzkhVzpK2IHN8bp4Hqd
    qfcokGhdxFuY_Q0LHEOAFYx_Tax3emdKWZV7JO_FBojOtmdxaqwvw>
X-ME-Received: <xmr:7Z73aLV_9bDi-Hdon0Gkc78G4gqqRId6pf15DIR_EbR_W5tVHQFrq9xDJp5->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedutddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7Z73aEBxys00l640kfuF3svzG3WD_28Z_BrMdhOt0ol5urTIuKUjAw>
    <xmx:7Z73aHIo1ch1YA76Gfx8vmGTXswxpJodOw45_OC5U_LhBxbX2u-Tbw>
    <xmx:7Z73aCt0woBC6upWARhNWGZqCOyAcp3rOH1Fivb5Ll5TaaW8xqjYFA>
    <xmx:7Z73aPUieQMrkwuFG0qJAjEo06A0rrGUwL07S_dDl4GH7_30WZMJvA>
    <xmx:7Z73aPh3Uh8ax1XU8PtTxFZ7xUTnENmpxvAhyXgS3wzM6PlVXkI9uUJs>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:55:40 -0400 (EDT)
Date: Tue, 21 Oct 2025 16:55:39 +0200
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
Subject: Re: [PATCH net V2 1/3] net: tls: Change async resync helpers argument
Message-ID: <aPee6zUrKP-HNqTo@krikkit>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
 <1760943954-909301-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1760943954-909301-2-git-send-email-tariqt@nvidia.com>

2025-10-20, 10:05:52 +0300, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Update tls_offload_rx_resync_async_request_start() and
> tls_offload_rx_resync_async_request_end() to get a struct
> tls_offload_resync_async parameter directly, rather than
> extracting it from struct sock.
> 
> This change aligns the function signatures with the upcoming
> tls_offload_rx_resync_async_request_cancel() helper, which
> will be introduced in a subsequent patch.
> 
> Fixes: 0419d8c9d8f8 ("net/mlx5e: kTLS, Add kTLS RX resync support")
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  9 ++++++--
>  include/net/tls.h                             | 21 +++++++------------
>  2 files changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

