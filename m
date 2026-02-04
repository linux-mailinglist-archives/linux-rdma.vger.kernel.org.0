Return-Path: <linux-rdma+bounces-16519-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCGhBWJBg2kPkQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16519-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 13:53:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A9E60B4
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 13:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B05305DEC5
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10242365A10;
	Wed,  4 Feb 2026 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="DslEUpmi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9LaJ99s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653A19C566;
	Wed,  4 Feb 2026 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209298; cv=none; b=XK7MFKk7hsazaDs34EYfgRPo9JxCLWi71P0kVXxWhaJtcDZC4IWwZVolBNExlpGYLs6N9KiV6n5j5rtGW2qNFI18nZzY9CUE1iB0O9ZrKrxNcolQ7iroZiqfsGRdNNK9z5nYeyoK2Ki6uYqaL+whcpjipQs7r8RBKAzpO6VHKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209298; c=relaxed/simple;
	bh=eP3rPn2dzqlbo1vwTR0tBhodv/dzdNlRNQhpyeFUAUY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ypf/30O3cSV9xiIEvGpjT5i60rrXyVgeDEKOE38ujlA15yThynv7ieNEvaICh7sCCKNkhuOPK4ubqHG+e2HdFEqFf3azkZ81U/MSg0l4r6SU/lisCAS2uLQAE13XNaJddfCVQGiuCW5qJEG1WyJ7hrtzDuMtVIW5LkdnDbcPXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=DslEUpmi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9LaJ99s; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A2FB1400075;
	Wed,  4 Feb 2026 07:48:16 -0500 (EST)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-10.internal (MEProxy); Wed, 04 Feb 2026 07:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770209296;
	 x=1770295696; bh=dmnfWygW74BDj/24KZOTRiaFC7wuQ2NE4hjJ1haytuA=; b=
	DslEUpmitOLFfjtLF7kBoszh9SkFuBGdP1RdhgFhF4Tde1nI8NFTHU43MO6CA8Pr
	rqHOp4ojwJXwl76wBSWZQ2piagf1z1sjSvrWaurLPGjv++jIFhqkSyWfzYJMpJLh
	ADeGmiapMpiU/0Yw7b6IdlLM3FH/1ATMJLoAfubLRb2HwFkQZqUuIslpCmnxjU2D
	bXUAm7ACdPL+gUosbcZ602/VRt+5cxvyrL3Yk7fuN9B8UIHU1P43ooni9YUhqnKL
	pshgpensnhIIuE+Ls64XCDPkT9+9LVNX54hdmO17awyPSg3kzI7gMWNpNGpKAMEi
	l3j9h9Upn6D6+kcSYGpdLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770209296; x=
	1770295696; bh=dmnfWygW74BDj/24KZOTRiaFC7wuQ2NE4hjJ1haytuA=; b=b
	9LaJ99sHhcWBituHBP05OVBgPy1F8Q4hgWmwM+Eg7Sjxr2VwSL2fTTEhtX3EEQJD
	nIcQVjRpsOOTlvWnYIKp9N/Nivk8utr3Ft3VRRzFmOq+LSIhAZq/WjSF2qmOxHJs
	ehw8y+EqQkuumgNscbJvSHLYY+y+lPqUPNBjrm7p+fEUo0unTkQkBeSyX8vTb2iq
	gg3M4rfNcOuG5zuO61FU/a7s0HlhGLp1ywuwW47SlIWZ0r9YeToryghQVk4LOsOm
	ulXGilw4GajRMaLKftf9TzGF0PVzFxMB+A6SlBWUhHsLW/7xiQXmKI4v7EfWfAe3
	g/trq8R3NX1RNBPtNyHMA==
X-ME-Sender: <xms:D0CDaRNQS-NyQ1wl_xXEHW4dwodSLB6GWXUStfTg2u5hwBbo_D1StA>
    <xme:D0CDaez9FJhcW7VR25YwsG7KcioHTWRGPfVKMN7VE9BSo_qJnaqKvVhSFl-YJPnTG
    oVr2Kf2v8rQ2Wcvo33zChtKL7coiZJH1qzu5lYJV4Xu10dJNceDxSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlihgt
    vgcuofhikhhithihrghnshhkrgdfuceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrg
    hilhdrihhmqeenucggtffrrghtthgvrhhnpeeffefggeekudefteeujeeiieekleevtedt
    gffhgefggfetgfdvhfelheehhfekgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhi
    mhdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghlvgigrghnuggv
    rhguuhihtghksehfsgdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnh
    drkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgs
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:EECDaX2f14KUoPRgun5A2nf9sQeO6IHfg9lpyFYQUo_Dp09s14ySEg>
    <xmx:EECDaeDsS-BSIg3tLkvrZ_UESqAxdRgSEK6v4Jcwoo9DCIplKDA72g>
    <xmx:EECDafEkS2vGqfAHxixcsnj39fuwVwcyeAM2ZTlkYNDEWgvWmB5UYw>
    <xmx:EECDaTSePlPdivAsafnqMp5m7lvlNZuwOYZFz1wZ_7bSLeRXnih3AA>
    <xmx:EECDaaCAzanEjOz4543_AzSkiOXo8CLGxVCkRnqHJvTzLHjqGADzk5W8>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D933B33E0099; Wed,  4 Feb 2026 07:48:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1L92F6ESprk
Date: Wed, 04 Feb 2026 14:47:55 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Gal Pressman" <gal@nvidia.com>
Cc: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Igor Russkikh" <irusskikh@marvell.com>,
 "Boris Pismenny" <borisp@nvidia.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "David Ahern" <dsahern@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Alexander Duyck" <alexanderduyck@fb.com>,
 linux-rdma@vger.kernel.org, "Dragos Tatulea" <dtatulea@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Message-Id: <b4bfec13-34a1-4320-bac9-338e909f15d5@app.fastmail.com>
In-Reply-To: <ae132d54-6fb1-40fb-b172-d5683a872ae9@nvidia.com>
References: <20260125121649.778086-1-gal@nvidia.com>
 <20260125121649.778086-2-gal@nvidia.com>
 <willemdebruijn.kernel.218d53621fba7@gmail.com>
 <fb617b34-7760-4e3f-903f-c7380d28ed40@app.fastmail.com>
 <ae132d54-6fb1-40fb-b172-d5683a872ae9@nvidia.com>
Subject: Re: [PATCH net-next 1/3] udp: gso: Use single MSS length in UDP header for
 GSO_PARTIAL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-16519-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,marvell.com,nvidia.com,kernel.org,fb.com,vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 693A9E60B4
X-Rspamd-Action: no action

On Tue, Feb 3, 2026, at 15:51, Gal Pressman wrote:
> Hello Alice,
>
> On 03/02/2026 14:20, Alice Mikityanska wrote:
>>>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>>>> index 19d0b5b09ffa..89e0b48b60ae 100644
>>>> --- a/net/ipv4/udp_offload.c
>>>> +++ b/net/ipv4/udp_offload.c
>>>> @@ -483,11 +483,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>>>  	struct sock *sk = gso_skb->sk;
>>>>  	unsigned int sum_truesize = 0;
>>>>  	struct sk_buff *segs, *seg;
>>>> +	__be16 newlen, msslen;
>>>>  	struct udphdr *uh;
>>>>  	unsigned int mss;
>>>>  	bool copy_dtor;
>>>>  	__sum16 check;
>>>> -	__be16 newlen;
>>>>  	int ret = 0;
>>>>  
>>>>  	mss = skb_shinfo(gso_skb)->gso_size;
>>>> @@ -555,6 +555,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>>>  		return segs;
>>>>  	}
>>>>  
>>>> +	msslen = htons(sizeof(*uh) + mss);
>>>> +
>>>>  	/* GSO partial and frag_list segmentation only requires splitting
>>>>  	 * the frame into an MSS multiple and possibly a remainder, both
>>>>  	 * cases return a GSO skb. So update the mss now.
>> 
>> What about the frag_list case? The comment says it would be a GSO SKB
>> too (as I understand frag_list, it would be a linked list of SKBs
>> forming one single packet). Is it appropriate to set UDP len = MSS in
>> this case too? I'm not sure which code reads UDP len afterwards, I
>> couldn't find any, so maybe its value doesn't matter at all (except for
>> hardware, which this patch aims for).
>
> The behavior should be the same, the structure of the skbs the packet
> originated from shouldn't affect this change.
>
>> 
>> Is it possible that this GSO_PARTIAL or frag_list packet shows up in
>> tcpdump with UDP len set like this? E.g., if the GSO_PARTIAL
>> segmentation happens before entering a veth pipe, and tcpdump listens on
>> the other end? If so, tcpdump could fail to parse such a packet.
>
> You will see a large packet with a single MSS value in tcpdump, and
> that's consistent with the behavior we have for UDP tunnels.
> tcpdump parses the packet without any issues.

Yeah, just checked tcpdump: it shows the full payload, regardless of UDP
length and IP length in the headers. Sounds good to me, thanks for the
clarifications!

>> 
>> I haven't tried to reproduce any of these yet; I decided to ask first
>> because you have more context. I'll appreciate if you can give me a clue
>> whether my concerns are valid or not.
>> 
>> Other than that, I think the patch could be made simpler, if you just
>> drop mss *= gso_segs below, and stick to newlen, which would be equal to
>> msslen (now unneeded), and newlen and mss are not used anywhere else.
>> I'll include this simplification in my next series, if you don't mind.
>
> Feel free :).

