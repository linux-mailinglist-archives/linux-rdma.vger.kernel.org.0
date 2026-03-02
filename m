Return-Path: <linux-rdma+bounces-17361-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE94ApZSpWmU8wUAu9opvQ
	(envelope-from <linux-rdma+bounces-17361-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 10:04:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D861D5341
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 10:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED10E3024451
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3C93876D6;
	Mon,  2 Mar 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RrA52l3b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2EA33ADBA
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442078; cv=none; b=aAFv3lHO8DkATU2dWplrsq3/zefniDzZSEXugROl/2qZYrOix7uYAJOC6eCCPULh4hXV0Q/NC7pU/5/Pexd2BxTFybe8p5iBTYeFNL7Ix+NxEv3TuNYphi3b9muQ6/cAnsM6XRJkrhzXDgEqCEJhKQkAgGrPPAuSZjLdgL7tH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442078; c=relaxed/simple;
	bh=O7thirgE/HmH5gPIPWkZO3RkV6af64nRGWm0dBCW59Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKdYRbSmZxtyL3fkHDu3g1QAJVGdG+7ne2fCWJ9T/SzPcVRFvsDTV+dnRGBgxgfcnHYphyruqMaVWOsi/axsmb2BA18y1h+S3QA79Tw78oMzPZkmD6robqgc/E4de6SmCpM7Kl8C0FNbZksDd0Fz22W1SsZ6IJjSEviYzj2UByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RrA52l3b; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0D3471A2117;
	Mon,  2 Mar 2026 09:01:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D46905FE89;
	Mon,  2 Mar 2026 09:01:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80AAA10369517;
	Mon,  2 Mar 2026 10:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772442073; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NatQwThJvajcx8kzrOyk8duEdQeD0wDtLj00K/M0jVo=;
	b=RrA52l3bxUkrs68CzjlH+eUAASGK1rdtkxtcwY/JLXcYLWEvnkrgQR2m8p5YUlq2sp3OD3
	4x8czOfzEOF4arj0ayiQxXXHL8XR9a8eoVGT4oQSKQxgd4/bnratP9wIlsUiLRqdcWaHu7
	Nvl1NgmVBGdqJaLnDx0IadewB2wS/Qccv0wgbGkBGtr3eMmsF5ZIeeQ6G01eriOI4jmTc2
	2EW/rXaraBQH1xhbBcFAXfLwkSP4Gx/O/1v+KMChnLo9gtJOG1NAEtph7/l+gq4qUt1064
	3lXMKgVbmEndCBIf1piM7EJg7Cgx8u8DhA9DBd6VEmRQSFdl5BZBfWJKHXlatw==
Message-ID: <f2ce4c3b-407e-4c01-b117-c646feed877f@bootlin.com>
Date: Mon, 2 Mar 2026 10:00:36 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback
 support
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260219130050.2390226-1-bjorn@kernel.org>
 <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org>
 <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org>
 <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
 <20260223150401.7993b11a@kernel.org>
 <CAJ+HfNjmRjr6VtRijmN9=4zPwxstw9B8D-_XVn3hwJzNHka1Jw@mail.gmail.com>
 <363527d6-1f29-4399-83a7-978785d1e11f@lunn.ch>
 <CAJ+HfNhwM82H-sgbz0+WJGRjXJc8Ww0aCnp_YTNi-CB4aBMi=w@mail.gmail.com>
 <4c51f18c-5eb1-4a9e-93b9-70cf7a4fd387@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <4c51f18c-5eb1-4a9e-93b9-70cf7a4fd387@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17361-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,broadcom.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 75D861D5341
X-Rspamd-Action: no action

Hello Andrew, BJörn,

On 25/02/2026 14:14, Andrew Lunn wrote:
>>> Suddenly does something else.
>>
>> Indeed!
>>
>>> Is this an ABI break? How do we make this reliable so implementing
>>> more loopbacks at different levels does not change how you use
>>> --set-loopback?
>>
>> Isn't this somewhat similar to what we have with ifindex/phy_index,
>> but potentially unstable when modules are swapped/changed?
> 
> If you hot plug hardware, a new PHY pops into existence, i don't think
> it is too unreasonable for the hot plugable parts to change ids. I
> would however expect the fixed parts to keep there IDs.

That's indeed the phy index behaviour.

> 
> But here we are talking about software, a kernel upgrade/downgrade
> causing the IDs to change.
>  
>> Instead of ids, use string name and/or topology indices (e.g.
>> phy_index)? All three -- owner, phy_index, name tuple?

The overall approach after all these discussions sounds fine to me, I do
think that the index of the component that does the loopback needs to be
there somewhere, when relevant.

Either through a name string, or a combo of an enum indicating the
component type (MAC/PHY/Module/etc.) + its index. I think it's safe to
assume that indices will fit in u32 ?

something like :

# MAC PCS loopback
ethtool --set-loopback eth0 loc mac name pcs

# PHY id 2 PMA loopback (I'm making things up here)
ethtool --set-loopback eth0 loc phy id 2 name pma

That way we can extend that fairly easily for, say, combo-port devices
where we could select which of the port we want to loopback :)

Maxime


