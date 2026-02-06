Return-Path: <linux-rdma+bounces-16639-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DUgKr27hWmOFgQAu9opvQ
	(envelope-from <linux-rdma+bounces-16639-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 11:00:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE122FC5BD
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 11:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A02B300B445
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884C3624AE;
	Fri,  6 Feb 2026 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UUOM6f+V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsLbZgLO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1D360752;
	Fri,  6 Feb 2026 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372024; cv=none; b=s+sd2nKoiPHjTin50vbYPqzkmfgsFrYjm856lUDYiI2JC6vYnYQI+3JgVN0KZWf3MlhCvCxVGVmSFoJ0LHdVpEIJrn7s4o63ibEpr3r3Xh7bvdHDYbux2GRuGwKHXqlRKGmt2VjZYQ59QXbDvJqeVvw0jCweO3mw5g45OKKgEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372024; c=relaxed/simple;
	bh=2JTvlmMeGGKKKRFKmiYP4bowNql5E2S4kFM2WmofBYc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e7cOB32uRt2OSgratyy8JK5hwdhFwpKsVhiogi/EtihrM4DXPnURv3uiUH3EHeoQEJ/MCz4AmzpK3rowEwyLG6OMC5DzASHrmmD7E/jb0otZN8q61rDYpDR0MuVpsh4tTp+d9ElFpIYdVqxxEPYeQ2fgAO5pN642tZ2iz5F2+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UUOM6f+V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsLbZgLO; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E59D14001C6;
	Fri,  6 Feb 2026 05:00:23 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 06 Feb 2026 05:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770372023;
	 x=1770458423; bh=Pz/rkam5VJHb19DKwCI0gMfUPBewaqOcVKlVT4axSgw=; b=
	UUOM6f+V11EFPWKryo6UcxbywvwKFPytV0/fNP0hiFg5aV52vGDxQ1eIVZofM55h
	eyYKzFtC/1XLbJhYwsdRyw0s4kGTP3zoxDlvBmVWFG0Y30q6OGyL62YhO4yF1BpC
	qJTMxBEdcnFe8YCs6KhkpKXqXc5EhRfRU0zPJY7s3xEgboyL92sGLHS0sD1BIGiQ
	PrVVnfnrM+WDAZu3nHqEF30aI4p2PV3tZx70V74EoJNBpdd+m9KaUG7z0GS8WMqi
	Lkc7YKmdIWJfnnFHdSaMOTkX56tybzoFIgU1fx1ffAgvDm1WE9uxmOHUtbi9s4rU
	CjWTBt+MUSx31wdOlYtd4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770372023; x=
	1770458423; bh=Pz/rkam5VJHb19DKwCI0gMfUPBewaqOcVKlVT4axSgw=; b=A
	sLbZgLObR+atv3fxxWm+CIh/RueSDykCI8uuyszcZ0LjYHV7jmRUdZQFzuwn/Qi4
	HqMZqKT2vJfF+T4CzCYD5LN7AvBg9We+9RfJJ3ljvG6SSHwT8HOs+MVKHoDBUdAK
	ngBabonXSAs98AJmlwkicwPv/5klcWxxxlGoAXwj0VpwPPHDFt4Bu5eeo/h4cXBQ
	w4Hhg41XA2PFE9O4WuYKwn2lKIcaC/HdEo0I8yh12+Wt2lU77H95gV96bE1NLRql
	4LsTKCOsEO0EGxNq8D98zSAcxorDglbL0jO4k6xAUlPzQH1KeiuqWzfgcyP49vpf
	dInqHahoFO+t+2rDMYQiw==
X-ME-Sender: <xms:truFaXnbv1cc8nooBhTDhTXDMIIeaQ-kT8iTUfXAxJ9QvOPTOUglxg>
    <xme:truFaVr8-dhV8fcs2OCKqRQt3Q4EJWDRCzcwEiopGEuKUMZV4e_QICI11VfoXUeAV
    yn6fhr3zHkvGgYgdP5SRGJfTHYRwbeksGe5s9hgpD3c7p-YifargUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtg
    hpthhtoheptghrrghtihhusehnvhhiughirgdrtghomhdprhgtphhtthhopehjihgrnhgs
    ohhlsehnvhhiughirgdrtghomhdprhgtphhtthhopehmsghlohgthhesnhhvihguihgrrd
    gtohhm
X-ME-Proxy: <xmx:truFafSKo3_S4ovA8oDjs0irZQ77XiVx2hHujeWaIfDMibHeigZXqA>
    <xmx:truFafSf79dVPmp_3e6qo_zkXgt8k2_kBkx-3Is9MGyHmAJCNPZ-dw>
    <xmx:truFabpuqL1FubEwRJ81iksq_uti-ewS_v0HW_n3d8v_dk0GgWUtwA>
    <xmx:truFafCMEEWtqhE9h8NcPLdtfTKIxUj3ycnyM57hRlNCCwU6mEHiGA>
    <xmx:t7uFac8R62d49k44kir1qcaSvC6khV8JZJcqwpinCfvrVQ43KszjafYD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 755BE700065; Fri,  6 Feb 2026 05:00:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3LZyQCFhUBg
Date: Fri, 06 Feb 2026 11:00:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jianbo Liu" <jianbol@nvidia.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Tariq Toukan" <tariqt@nvidia.com>, "Mark Bloch" <mbloch@nvidia.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: "Cosmin Ratiu" <cratiu@nvidia.com>, "Raed Salem" <raeds@nvidia.com>,
 Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <2ec67d1a-32ae-479e-99c2-dc5042d9f57e@app.fastmail.com>
In-Reply-To: <8da9781c-4b89-41cc-8810-8312ef7c2c81@nvidia.com>
References: <20260204130057.4107804-1-arnd@kernel.org>
 <8da9781c-4b89-41cc-8810-8312ef7c2c81@nvidia.com>
Subject: Re: [PATCH] [net-next] net/mlx5e: fix ip6_dst_lookup link failure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-16639-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: DE122FC5BD
X-Rspamd-Action: no action

On Fri, Feb 6, 2026, at 10:56, Jianbo Liu wrote:
> On 2/4/2026 9:00 PM, Arnd Bergmann wrote:
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
>> index 9cf394c66939..c298efe93f97 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
>> @@ -154,6 +154,7 @@ config MLX5_EN_IPSEC
>>   	depends on MLX5_CORE_EN
>>   	depends on XFRM_OFFLOAD
>>   	depends on INET_ESP_OFFLOAD || INET6_ESP_OFFLOAD
>> +	depends on IPV6!=m || MLX5_CORE=m
>
> Thanks for the fix.
> I received a report for this same error here: 
> https://lore.kernel.org/oe-kbuild-all/202512261850.P5Jp5BSz-lkp@intel.com/
>
> We were about to send a fix ourselves, it is to simply add:
>    depends on IPV6 || !IPV6
> Is there a specific reason to prefer "depends on IPV6!=m || 
> MLX5_CORE=m"? To me, the IPV6 || !IPV6 syntax seems a bit cleaner.

MLX5_EN_IPSEC needs the dependency, but this is a 'bool' symbols.

The "IPV6 || !IPV6" syntax only works on tristate symbols, so you'd
have to put it into CONFIG_MLX5_CORE itself, but MLX5_CORE does
not actually have the IPV6 dependency unless MLX5_EN_IPSEC is
enabled.

     Arnd

