Return-Path: <linux-rdma+bounces-13606-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8029CB974FF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 21:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7408D19C85F9
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC862303A07;
	Tue, 23 Sep 2025 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Zp2S/ayo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFHFZW/s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160A253B40;
	Tue, 23 Sep 2025 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654992; cv=none; b=mfjMlXsoFDIHfCzirOV6b/EwWzg+YW2LcP99MkKK0YtA4o0mAnzHLdSslDQ1yDo1vWpyxMAqbJeHpRWyZcdKJ1PTYoXiuhKxH5BFrcmJWHC4qcMD+SSsP36INGZ0eXHCBBL4m48BF5MiX6aXyCzC5bS2dMjMd623YEXAR9rd/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654992; c=relaxed/simple;
	bh=IJHG6yycS6S8dldJrHLDiinG/3420rWau44WtRsz5q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkRd0CoaTZ+5v2abolPphHTDGVyCn7kVcR2A4zqnV+ej9UYbWkhEVBrRY+1aPUpgDq0Cs1cAd/vtUWsqmnEbUoKbmv0wOr7bMr1M0MpWOE0e8dEk4+wBaJbYUnpDULBjeRtkQZDkNCt4Kb25GrFjmELvdqpM6dqg11ywtylJElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Zp2S/ayo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFHFZW/s; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 974861D00326;
	Tue, 23 Sep 2025 15:16:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 15:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758654987; x=
	1758741387; bh=F/lIzpuxwbfLK3RKvJxbBVrGA9PfZ7e710XDlbp9jgs=; b=Z
	p2S/ayoXVO+HI7g3BAgXLwthV48phD7tr4tP8ykV8a2Ec85+9fMFT9oR/4nGsgmk
	fLf3XfQbxwx2v6jvtwjT5QCwUFeVnHQA9Gpch5F1VqvfCM9/Zc/jGOH0GbzdEsqt
	7Qt/YAVIQRLXgM5b2p0/uQ3yVY92BoBHHWnE196tvcbIABqQfyNjR6dPopZ3qvmh
	ZQcl2BERGPJ6PY9AGbYofPskwGU5EGK27Bc9KlwHKZknbPGwiHw4q7gZ5Oya2TP0
	JenGySNPJ2lGQOe5k4dAi/vRNHPI1h4btt24fFqzOMmdivPy6wBWP1cs+KmxyCNs
	dy9ovO8XTWYlNTa06uOrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758654987; x=1758741387; bh=F/lIzpuxwbfLK3RKvJxbBVrGA9PfZ7e710X
	Dlbp9jgs=; b=OFHFZW/sIg67aGl6Yddf7/hyD+N1RIzVTNqC4LmN+T0VF4N73yr
	g/6UtKf8tJDSTm1eECZbsZC+sGvAxew39aZM9e2/xQMUg62fwtJBEWX7/9oGy98x
	5kDKieG27fJYX62dcZZIizJ8AnJLquFSLJYTSY8PCwZEbcSvTqto5UxYWWwYVFR+
	Sb/KFSd83AojfQnlcwkI38GwR27t9aJGtcfDDrUZWI/Sb1DWN664fUZf3VCTMlQm
	LkzcKEVI6qGuNyvC2DM56o11UR0tZig7/ZzpD6mWdMtodzcCZMIzIU0LbkZwgs1L
	e+6JSE/dQgD7dycGuzO4eTqaOsM0Uy5IFYw==
X-ME-Sender: <xms:CvLSaIRCE3IocT8oBuUSiLzmkiYJilE417w2_tgXm_o-3OBKwaaJAg>
    <xme:CvLSaLVJWV3MkYPnWr4rPpbFKgvBt3hagsJpyp_4H-ijTorrZ4UbFw4NFtB3qjG8r
    nGWDYELvR9utGsCMKafXbkc3AF53SMh-s0vmSXBU2AppAUpXgPAfdM>
X-ME-Received: <xmr:CvLSaPaHavSWPrp2oeLH1OtGRnyF-Wv6yJmnpB2BWmIzIQE5QXEM5f95tRFn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudehgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:CvLSaM4l0VHBL52m8YbDUjN_2xpX4o4gAvoWpb2i_-Rp5aa_onz0_w>
    <xmx:CvLSaIxI6LHQWvm3cMn3vSLwTmVqjIZo5TVvrfmVEXW3qwf_o-FSJQ>
    <xmx:CvLSaFr3iosz6xs2rtibVgzqal1gFEAl8yfcqLbb7lzYnrbdtQus4g>
    <xmx:CvLSaC1rXSezqHQ9Ufy7RNR0wdZpk0-Ogh2pIbs02vzqb_hg6QxtjA>
    <xmx:C_LSaHfGXPGZQmTdGWCPeJlxK_1l_NZe7FLFfFh6cqbYPtHDrZ7LxRjn>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 15:16:26 -0400 (EDT)
Date: Tue, 23 Sep 2025 21:16:24 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Shahar Shitrit <shshitrit@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Boris Pismenny <borisp@nvidia.com>
Subject: Re: [PATCH net 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
Message-ID: <aNLyCP9gXWgaAUkm@krikkit>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
 <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
 <aMQ48Ba7BcHKjhP_@krikkit>
 <b5790517-a15e-43be-ba70-fbc9dbe2b6c9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5790517-a15e-43be-ba70-fbc9dbe2b6c9@nvidia.com>

2025-09-22, 10:16:21 +0300, Shahar Shitrit wrote:
> 
> 
> On 12/09/2025 18:14, Sabrina Dubroca wrote:
> > 2025-09-10, 09:47:40 +0300, Tariq Toukan wrote:
> >> From: Shahar Shitrit <shshitrit@nvidia.com>
> >>
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
> >>
> >> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> >> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> >> ---
> >>  net/tls/tls_device.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
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
> > 
> > Do we still need to WARN here? It's a condition that can actually
> > happen (even if it's rare), and that the stack can handle, so maybe
> > not?
> > 
> You are right that now the stack handles this, but removing the WARN
> without any alternative, will remove any indication that something went
> wrong and will prevent us from improving by searching the error flow
> where we didn't cancel the request before reaching here. We can maybe
> replace the WARN with a counter. what do you think?

Do you use CONFIG_DEBUG_NET in your devel/test kernels? If so,
DEBUG_NET_WARN_ONCE would be an option. Or is it more so that
users/customers can report the problem (ie on production kernels
without CONFIG_DEBUG_NET) - in that case, the counter would work
better.
But if you really think that this condition indicates a driver bug,
maybe the WARN is still appropriate. Jakub, what do you think?


BTW, I was also thinking that the documentation
(Documentation/networking/tls-offload.rst) could maybe be improved a
bit with a description of how async resync works and how the driver is
expected to use the tls_offload_rx_resync_async_request_{start,end}
(and now _cancel) helpers. The section on "Stream scan
resynchronization" is pretty abstract.

-- 
Sabrina

