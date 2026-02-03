Return-Path: <linux-rdma+bounces-16449-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBVyFLvogWkFMAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16449-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 13:23:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4EAD8F56
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 13:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9705430762D9
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7944D33F8D8;
	Tue,  3 Feb 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="JrhQbOej";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dGIm5J11"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DD33DEFC;
	Tue,  3 Feb 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121329; cv=none; b=vFWFUEbrvDMffKjMtkeasoNig89LvfYjPcfH6bxPC9zM/6GCaJHE8zQU03Dx7F+NzmkUIs9h5yRlyy0XA4AV7nBzOBRCfRYFjCbrJKLJXJXtVIVmsX0vFASky1O1pJ1pU/AFLlzWML94mkn+5ugYzZcW1OEWkUXCHksuko6QeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121329; c=relaxed/simple;
	bh=8zD4Bvj2cpwqbR8C/vP8Ln3GAO7Ar/bTUXV87Og0liU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V+v5c1o9mN2oSLjKiVrfUeCVaHjSCyaKtVuLp3AT/onyhQC2oClybhgppo5wwqXvJr4W+JJGljrju+aQ+f5+CHOMHJeBqdm9qEDTOpWnVjZ1SUdPLdF3LDT6iVgS8MtHIXV9bVXuItI2zFWmi+wKwSTBgu4uciBwjZcCNVAnw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=JrhQbOej; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dGIm5J11; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA03E7A0064;
	Tue,  3 Feb 2026 07:22:03 -0500 (EST)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-10.internal (MEProxy); Tue, 03 Feb 2026 07:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770121323;
	 x=1770207723; bh=fGZzykM2xqfT9vl/Zx59SgBnmWMYXVx1CHV/AglyHZ4=; b=
	JrhQbOejE5+fMnYu6SLm8h7S8Goh+iSbdbXzTulxVZ32EU6ve0X1WzGVGMD31hSR
	LdcBqRyZJorqX353n/uVJzuW1GRokF3XtlH55Wxw6fw7/4rSe4fHZnomGF+TdfOT
	VylrHsf1zIl/3SJK1nZ9Sf6cqACGo8GsF6DVfsMybg5jIVQu/0fGBoNPkJVlivzU
	RFW08sdMpNNFhEcsdmZ/Qfg1T4SWcFQEFYS1lBFpo25JIKpDiTGcDBKceVRBQtMu
	cWsHWQHHGytbYuwGskWZHUeH/345ho2Z5dXWTha0tKUofZj6k3vLR1ZMUEToIHpa
	nc1PhXud/x0OVRWw19o5aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770121323; x=
	1770207723; bh=fGZzykM2xqfT9vl/Zx59SgBnmWMYXVx1CHV/AglyHZ4=; b=d
	GIm5J11Mh0lHqbz/OTcezUxIwUPaYSJRdvMcBGBTL+R9cROnaSpohFsg+mpWQYpS
	RjwrfGuDh3re5BEEl8tW4DNJRKeXpjCp+f8dYfD7g4t4IcsOpPNfiOgByFcURqE2
	m1OJBXDDcEqbgHWMy+LH+qU+EI35Y2hAPtBuQp1HdCOdBYxNmmmtQcjgYujuBhQ5
	EyGLWZEv1Bnn8BNNFHmwkUAZritTJ7ZGWFxRjZmRX79z5noMHtzqvFgTEf19RrJA
	BRdttz0Zhk5oDsrv5hQBjjL0V8oRKt5Tugens6Cq7vdm7EPh/MLqr+e8y6T0xuYp
	ZlYeOi/FswV77GDyvJv3g==
X-ME-Sender: <xms:a-iBaZtWCyOrbRf_y-KxZWVYUwdyyBxKPNB_iKZw1OEVbfEUhsQnWw>
    <xme:a-iBadT1FTipIQZio5fv-TqruRosSAF5-2pjwbBWwMQqhSVHdK2cfcIydjKzkou4P
    dVMCkAif6TJDKnklxKgQUTDg6p-KxRM6WUQ1ZdByPrC_wySRE3JpzMh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedttdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlihgt
    vgcuofhikhhithihrghnshhkrgdfuceorghlihgtvgesfhgrshhtmhgrihhlrdhimheqne
    cuggftrfgrthhtvghrnhepleevgfefgefgtdfftdeggeeufeekteeigeelffffgeetfeev
    ueevgfdvkeethfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehfrghsthhm
    rghilhdrihhmpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrlhgv
    gigrnhguvghrughuhigtkhesfhgsrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsg
    hruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghonheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:a-iBaQUNXgEChcQqhGjXpdYYKFwQLGmM1mmJpVYq6FwycRURHMsBkQ>
    <xmx:a-iBaci_UG9bbRVZPZUJ8WzJlYijNV5cmHiNAqstZIdwxMLLSLp6VA>
    <xmx:a-iBablhtUMINjc_uz-lyQCveVhtjFZBoTMbTeH9PMZm_YADhvQB8A>
    <xmx:a-iBaVwvdmOkuYgG8lN0UOMtto1Rxe_4XK_TzhDuXMI9S-H20Ny86g>
    <xmx:a-iBac1F2kgIIRN6cgA4go3Sif-p_9wyBkGbhiMLC7tigncveTfgSdHV>
Feedback-ID: ice914951:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0AE8433E009A; Tue,  3 Feb 2026 07:22:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1L92F6ESprk
Date: Tue, 03 Feb 2026 14:20:16 +0200
From: "Alice Mikityanska" <alice@fastmail.im>
To: "Gal Pressman" <gal@nvidia.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>
Cc: "Igor Russkikh" <irusskikh@marvell.com>,
 "Boris Pismenny" <borisp@nvidia.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "David Ahern" <dsahern@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Alexander Duyck" <alexanderduyck@fb.com>,
 linux-rdma@vger.kernel.org, "Dragos Tatulea" <dtatulea@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Message-Id: <fb617b34-7760-4e3f-903f-c7380d28ed40@app.fastmail.com>
In-Reply-To: <willemdebruijn.kernel.218d53621fba7@gmail.com>
References: <20260125121649.778086-1-gal@nvidia.com>
 <20260125121649.778086-2-gal@nvidia.com>
 <willemdebruijn.kernel.218d53621fba7@gmail.com>
Subject: Re: [PATCH net-next 1/3] udp: gso: Use single MSS length in UDP header for
 GSO_PARTIAL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16449-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@fastmail.im,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,nvidia.com:email,fastmail.im:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 6A4EAD8F56
X-Rspamd-Action: no action

On Mon, Jan 26, 2026, at 19:53, Willem de Bruijn wrote:
> Gal Pressman wrote:
>> In GSO_PARTIAL segmentation, set the UDP length field to the single
>> segment size (gso_size + UDP header) instead of the large MSS size.
>> This provides hardware with a template length value for final
>> segmentation, similar to how tunnel GSO_PARTIAL handles outer headers
>> in UDP tunnels.
>> 
>> This will remove the need to manually adjust the UDP header length in
>> the drivers, as can be seen in subsequent patches.
>> 
>> This was suggested by Alex in 2018:
>> https://lore.kernel.org/netdev/CAKgT0UcdnUWgr3KQ=RnLKigokkiUuYefmL-ePpDvJOBNpKScFA@mail.gmail.com/
>> 
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> This only affects the udp header value when using GSO_PARTIAL, and
> these are the only two drivers that adversize USO using GSO_PARTIAL.

I stumbled upon this patch when I was rebasing my stuff and saw a
(trivial) conflict. I've got a couple of questions on this change, and
I'd be glad if you could clarify it for me.

>> ---
>>  net/ipv4/udp_offload.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>> index 19d0b5b09ffa..89e0b48b60ae 100644
>> --- a/net/ipv4/udp_offload.c
>> +++ b/net/ipv4/udp_offload.c
>> @@ -483,11 +483,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>  	struct sock *sk = gso_skb->sk;
>>  	unsigned int sum_truesize = 0;
>>  	struct sk_buff *segs, *seg;
>> +	__be16 newlen, msslen;
>>  	struct udphdr *uh;
>>  	unsigned int mss;
>>  	bool copy_dtor;
>>  	__sum16 check;
>> -	__be16 newlen;
>>  	int ret = 0;
>>  
>>  	mss = skb_shinfo(gso_skb)->gso_size;
>> @@ -555,6 +555,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>  		return segs;
>>  	}
>>  
>> +	msslen = htons(sizeof(*uh) + mss);
>> +
>>  	/* GSO partial and frag_list segmentation only requires splitting
>>  	 * the frame into an MSS multiple and possibly a remainder, both
>>  	 * cases return a GSO skb. So update the mss now.

What about the frag_list case? The comment says it would be a GSO SKB
too (as I understand frag_list, it would be a linked list of SKBs
forming one single packet). Is it appropriate to set UDP len = MSS in
this case too? I'm not sure which code reads UDP len afterwards, I
couldn't find any, so maybe its value doesn't matter at all (except for
hardware, which this patch aims for).

Is it possible that this GSO_PARTIAL or frag_list packet shows up in
tcpdump with UDP len set like this? E.g., if the GSO_PARTIAL
segmentation happens before entering a veth pipe, and tcpdump listens on
the other end? If so, tcpdump could fail to parse such a packet.

I haven't tried to reproduce any of these yet; I decided to ask first
because you have more context. I'll appreciate if you can give me a clue
whether my concerns are valid or not.

Other than that, I think the patch could be made simpler, if you just
drop mss *= gso_segs below, and stick to newlen, which would be equal to
msslen (now unneeded), and newlen and mss are not used anywhere else.
I'll include this simplification in my next series, if you don't mind.

>> @@ -584,7 +586,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>  		if (!seg->next)
>>  			break;
>>  
>> -		uh->len = newlen;
>> +		uh->len = msslen;
>>  		uh->check = check;
>>  
>>  		if (seg->ip_summed == CHECKSUM_PARTIAL)
>> -- 
>> 2.40.1
>>

