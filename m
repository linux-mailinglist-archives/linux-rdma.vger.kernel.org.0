Return-Path: <linux-rdma+bounces-14018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C28C0158D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 15:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03191A623D2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B42314D3F;
	Thu, 23 Oct 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="gbrVNIvJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KavW5QKn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD5315764;
	Thu, 23 Oct 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225851; cv=none; b=nMF773RhpwfVVnMifHMlB3xg+piVwGxK1hBp4C8/vrp1bXQX24nAjJgekgqeExJ14r68iZdw5upHoCHztD5fiaNoZdhQE0A4Ks8RJiiTNAGERSE5GL9xQiP9trosDIlOcIw/4WhX8oAnokQ/adF/oN6I76T6PF/Z9+hEjahdRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225851; c=relaxed/simple;
	bh=NS1pgPtjM3lsd8ne1GJVdlbH9l+MG4z+W6uxJqjyeMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCIFqy+DgjoOBoSospMZ0V/aHCmDGwmt/sm9zJxkDdV+7qTasbtgD94LUbuSuLSyQ6dgzY1Rs6SI0we1MwJ7JNJrWybu2RLlpDNXhhxXygSW61fL7TMahR0i1ThZajup0Qkc3XuXDTtWGErpbv2Herkgb4DYrvdcC1SFtcpFff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=gbrVNIvJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KavW5QKn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81BF57A0027;
	Thu, 23 Oct 2025 09:24:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 09:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761225844; x=
	1761312244; bh=v8siA3+ZqF8TsozuqQFbaOA4VzeoO6zGhDc7FvKunkk=; b=g
	brVNIvJXzSPoMrk4XlkDF4do3O9A9YDd9zDvZYJHmYJNDlbTqICCdxZLkymsxEgx
	xtIfJ+hO70Ho21I5XTKb9jotMENTprjObNqR5niFTW6tQ42PDLWRxHJopzsMHL/4
	9TtEatKuqrsrqg1EvIV9L20ge9c9S0HLMhGmm2FtR0iGcuZ/a6dBVpifBHBfDydV
	Z8TJNpx6F+eqC5J73mYeyL2Wp5HP87vsa5tTHYL2E+tlt+AZcPzFY7+oBlk9fsYr
	MgTBS38Qn0IdBhqFiWD2bEK5HWmCm4RZgog00fdId2K4ToTr39vaQLSLR5/NJdJG
	+2UDwhi1xkub8bNIb7Ejg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761225844; x=1761312244; bh=v8siA3+ZqF8TsozuqQFbaOA4VzeoO6zGhDc
	7FvKunkk=; b=KavW5QKnEqd/rQADjsOGjOX2MjQUgp/nxpfRZnZ7UjCnzP2zDOD
	4OLcTI2C7OsTYugJYoIsB1r6h2bNnlkOO9i8Mn5nowr1UEvQ4cMYCMYmpJVsOdVk
	kuj7VQ+GBlkuGNIeXqzwUPqflW94pI2yTr4iuMBQJWmtyKXExZjN7C9Nx9hzBv7v
	BfIaApUOG3jHvw2U/Zsk6uTUp/04FCEf1cdw+grEJd4zboGIUqH29BnY6ryo4SvM
	QvPvsRf288Xb/x8tdnT3mr+6gwujY8lGphifdK5EJIwMbyjfVfwux/m4eRSa7ane
	+3PWDtJevyvdgVvb64eqFzOpKyFVgQjU1mQ==
X-ME-Sender: <xms:cyz6aPuQ8tN8IZEum2daJLI4C-HxjolKFMCp80vU4MGam_X0R2-w9g>
    <xme:cyz6aP5gVJn3OjF84fc91v84ilu0Za-hOuDyNmRNM5WiNYC2JLUMs2jJUlXrrGL5X
    wVrg9Jh-mHlm-TMh1g7rUp0sFalg6w7u48mOBKsA4cFR68L1M4djQ>
X-ME-Received: <xmr:cyz6aD2FZFoxm4RVduKw-jcWDYVxxT2weLaB-MsdfP2Tc-a7WGqv5UO71RNq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeiheejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cyz6aCj8Z7qaiZJJ8WOIFFvobrdn1_rkV5RlZg8iB6tgn0z1Zxc2qA>
    <xmx:cyz6aDq9lVDRbMXU4kzJZS-hHzHVZaW8Z7IABwoMOpOwOuRIIL6eNg>
    <xmx:cyz6aFN9zet1J68apfUExYGQyz_kfPda9GucqoJNVuYVg64-eCyQvg>
    <xmx:cyz6aP34RaLGUHOHVhdK_StRNUPn_ax7OSN8WEjXELie_TwwU3-j6Q>
    <xmx:dCz6aKCIMfw8ccefOP3DbifynBB1E0cTQMJr0t1W7CpmMS7--eEmQzg0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 09:24:03 -0400 (EDT)
Date: Thu, 23 Oct 2025 15:24:01 +0200
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
Message-ID: <aPoscT48Xg6RqOvC@krikkit>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
 <1760943954-909301-3-git-send-email-tariqt@nvidia.com>
 <aPemno8TB-McfE24@krikkit>
 <ae854fd5-dda1-416a-9327-ac8f9f7d25ba@nvidia.com>
 <aPjSbFE-nQwDHUu1@krikkit>
 <41428323-618b-4d54-899a-b2a5eafb6a03@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41428323-618b-4d54-899a-b2a5eafb6a03@nvidia.com>

2025-10-23, 13:44:54 +0300, Shahar Shitrit wrote:
> On 22/10/2025 15:47, Sabrina Dubroca wrote:
> > 2025-10-22, 14:38:17 +0300, Shahar Shitrit wrote:
> >> On 21/10/2025 18:28, Sabrina Dubroca wrote:
> >>> 2025-10-20, 10:05:53 +0300, Tariq Toukan wrote:
> >>>> Fixes: 138559b9f99d ("net/tls: Fix wrong record sn in async mode of device resync")
> >>>
> >>> The patch itself looks good, but what issue is fixed within this
> >>> patch? The helper will be useful in the next patch, but right now
> >>> we're only resetting the resync_async status. The only change I see
> >>> (without patch 3) is that we won't call tls_device_rx_resync_async()
> >>> next time we decrypt a record in SW, but it wouldn't have done
> >>> anything.
> >>>
> >>> Actually, also in patch 1/3, there is no "fix" is in that patch.
> >>>
> >>
> >> I agree about patch 1/3 so I'll remove the fixes tag.
> >>
> >> For this patch, indeed at this point the WARN() was already fired,
> >> however, the bug being addressed is the unnecessary work the TLS module
> >> continues to do. For my liking, the wasted CPU cycles and resources
> >> alone justify the fix, even if we've already issued a warning.
> >> What do you think?
> > 
> > Is there any work being done/avoided other than calling
> > tls_device_rx_resync_async and returning immediately?
> > 
> > With or without the patch, tls_device_rx_resync_new_rec will be called
> > during stream parsing.
> > 
> > Currently, resync_async->req doesn't get reset so we'll call
> > tls_device_rx_resync_async. We're still in async phase, rcd_delta is
> > still USHRT_MAX, and we're done, tls_device_rx_resync_new_rec returns.
> > 
> > With the patch, we'll see that resync_async->req is 0 and avoid
> > calling tls_device_rx_resync_async.
> > 
> > Did I miss something else?
> > 
> My bad, you are right. The unnecessary work the invocation of
> tls_device_rx_resync_async.
> OK so there are some options; I can either simply remove the fixes tag
> and leave the patch as is, or I can also remove the call to
> tls_offload_rx_resync_async_request_cancel() at that point so the patch
> only introduces the helper (and then submit a patch to net-next that
> adds the call to tls_offload_rx_resync_async_request_cancel when
> rcd_delta == USHRT_MAX to improve the behavior).
> 
> what do you think it's the best to do?

I'd leave the patch as is, just without the Fixes tag.

With the Subject typo fixed and the Fixes tag removed:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

