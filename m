Return-Path: <linux-rdma+bounces-13321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF40B555A2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 19:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFC81C88046
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 17:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776D326D77;
	Fri, 12 Sep 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="EUG7vElk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WWRlpmix"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4057E272802;
	Fri, 12 Sep 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699442; cv=none; b=ZAnVyvCBqJYOk2Pf42o5ZiBkKENPr1/yhEtZ2+blDSi7aA3htfNLV5jCLYbqQsNDAvjy1kX1kDzOWErD9qDnJIYxg9Sl45tBGTybzCeRW9/jN4hpmudyyC8dU7wcIT5w7MV3FtRw20g2BeNKWpQ0wYGvI5xrImtSbitqxbpT3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699442; c=relaxed/simple;
	bh=eax8y8xW7N2vbnmDVP9nCqvc1jEraI6bgftoeFD7b+A=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=cKtaM2vzdDs3YXzpCtTWAem5/wkqDC09eQhFoAopHFB+Eudta2aXW7HeDUQoUN6mZtPg5Tm5wWvsKTtNOW4QSLmLwKpAoJ/icL0G7YLVVAtx8ywg4xqJaxtRKER86gF/J2/od46SJK0XZamn24UZAeFwX55CxOg/VyN0jlWPOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=EUG7vElk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WWRlpmix; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 003DA7A0147;
	Fri, 12 Sep 2025 13:50:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 12 Sep 2025 13:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1757699437; x=1757785837; bh=jOO3/VpBgTCpFOcadQRlN
	50Bb//xBWB5RFE36505dpo=; b=EUG7vElkDWTi8QTn6ZQAhInT3jtUpaZB6LPHQ
	xn1wKV3hqGzQJDIdobIReORI+Mjm+Aq1MVK+Wb/7ETzWcB0z0vyCQBWxHNrVyX+/
	FQ99dsVE/y0a63ct9fsva0QBg7KsjvSoxd206lihiTLfLncUcOCKbE6zlA9WgOAw
	92/oo00fYLb7qLTuFTi0BU+7/3ENPnuQn0o4W3frG9L8O/+jAWLEEm/jaV1GSmSJ
	dVxF6SOOJUI+3x4SK3LLog7vyearUL8ztVS7x4w3EUL6k525BlxwufBGiO9YOpS+
	EJiItOarw0Z6bcvCOSGws+3e3QvYi5U703A896vprgs2jITGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757699437; x=1757785837; bh=jOO3/VpBgTCpFOcadQRlN50Bb//xBWB5RFE
	36505dpo=; b=WWRlpmixWCo7bakayTCnNzfKFfjbnvWwHAQbTGTJzpW+JlVZEwT
	k2HM7XYgoqBTl4tKtHusujUUp0M1TqrPBsnNLetKxUbaduekvaR148pB8TE1FDjK
	LlaeVxfzVEL1awWaXFIL7mJgvoyj7MW1AC3N+XiHqAm+8yNEj2yE9WXkgf6JqFXq
	1HqVSZk6/zW1iktnTfcZlKu5GbTK8UsVr5yFv9AEN6mf2stkH9OB/rdc3RfOW2T2
	2EeWBVSb0ZeXM3FbmAHeHnYefPgfNTz20qITmVS5S4GH4cKkqB/HGfo7F4VB8INR
	XMjNU4ay107d/6G7njR12KcMOEO8mEJ1F3A==
X-ME-Sender: <xms:bV3EaIl_jrwxVQuX9PR9J1C82NdBLPiyorxwc7566iWdnIilmH0ezw>
    <xme:bV3EaMb2CJI1IjR2r2qCIFo9rOX10V0S6fcPXCNMudJsri6W8TWN6-V3RJcwHgMV-
    zAzY2WLb3xZCYN_si0>
X-ME-Received: <xmr:bV3EaDx2766PZxXI0wfck25xCU7KL-UQ3g3VKA3sces5W_nscxdvELSOBv68j9L1BTpgrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghp
    thhtoheprghnrghnugdrrgdrkhhhohhjvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    epmhgrnhhjuhhnrghthhdrsgdrphgrthhilhesohhrrggtlhgvrdgtohhmpdhrtghpthht
    ohepphhrrgguhihumhhnrdhrrghhrghrsehorhgrtghlvgdrtghomhdprhgtphhtthhope
    hrrghjvghshhdrshhivhgrrhgrmhgrshhusghrrghmrghnihhomhesohhrrggtlhgvrdgt
    ohhm
X-ME-Proxy: <xmx:bV3EaLbQOuqtTAnNM0kBHo9ixoYMN9cMAKNGDllBVigdbOVZ5W3HWw>
    <xmx:bV3EaEx2i1Vs0RodSOgtZwoeqTjfO0aUI_FoRgqneckILNqvmeaAVQ>
    <xmx:bV3EaEFGgFtnNaMKHSt4ldGSwTMK95z5TMgrkDyVMSThjmZH5dwTDA>
    <xmx:bV3EaMxzD3Ka62Ob1cU_M1hsJGNLpXR9QeiaZiTpBQw0uO4hN_K2Bw>
    <xmx:bV3EaBlbKCFvpeWRk-ya1HfpP1RSEqDMTNmqHF96E7BDX_le2ajZCybh>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 13:50:36 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id BAF079FC97; Fri, 12 Sep 2025 10:50:35 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B9F829FC38;
	Fri, 12 Sep 2025 10:50:35 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Nikolay Aleksandrov <razor@blackwall.org>
cc: Pradyumn Rahar <pradyumn.rahar@oracle.com>,
    linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
    andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
    anand.a.khoje@oracle.com, rama.nichanamatlu@oracle.com,
    manjunath.b.patil@oracle.com, rajesh.sivaramasubramaniom@oracle.com
Subject: Re: [PATCH RFC net 1/1] net/bonding: add 0 to the range of
 arp_missed_max
In-reply-to: <4daaaa7e-7a02-4e4c-be3e-c390d7f6e612@blackwall.org>
References: <20250912091635.3577586-1-pradyumn.rahar@oracle.com>
 <4daaaa7e-7a02-4e4c-be3e-c390d7f6e612@blackwall.org>
Comments: In-reply-to Nikolay Aleksandrov <razor@blackwall.org>
   message dated "Fri, 12 Sep 2025 14:15:06 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3123999.1757699435.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Sep 2025 10:50:35 -0700
Message-ID: <3124000.1757699435@famine>

Nikolay Aleksandrov <razor@blackwall.org> wrote:

>On 9/12/25 12:16, Pradyumn Rahar wrote:
>> NetworkManager uses 0 to indicate that the option `arp_missed_max`
>> is in unset state as this option is not compatible with 802.3AD,
>> balance-tlb and balance-alb modes.
>> This causes kernel to report errors like this:
>> kernel: backend0: option arp_missed_max: invalid value (0)
>> kernel: backend0: option arp_missed_max: allowed values 1 - 255
>> NetworkManager[1766]: <error> [1757489103.9525] platform-linux: sysctl:=
 failed to set 'bonding/arp_missed_max' to '0': (22) Invalid argument
>> NetworkManager[1766]: <warn>  [1757489103.9525] device (backend0): fail=
ed to set bonding attribute 'arp_missed_max' to '0'
>> when NetworkManager tries to set this value to 0
>> Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
>> ---
>>   drivers/net/bonding/bond_options.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/net/bonding/bond_options.c
>> b/drivers/net/bonding/bond_options.c
>> index 3b6f815c55ff..243fde3caecd 100644
>> --- a/drivers/net/bonding/bond_options.c
>> +++ b/drivers/net/bonding/bond_options.c
>> @@ -230,7 +230,7 @@ static const struct bond_opt_value bond_ad_user_por=
t_key_tbl[] =3D {
>>   };
>>     static const struct bond_opt_value bond_missed_max_tbl[] =3D {
>> -	{ "minval",	1,	BOND_VALFLAG_MIN},
>> +	{ "minval",	0,	BOND_VALFLAG_MIN},
>>   	{ "maxval",	255,	BOND_VALFLAG_MAX},
>>   	{ "default",	2,	BOND_VALFLAG_DEFAULT},
>>   	{ NULL,		-1,	0},
>
>This sounds like a problem in NetworkManager, why not fix it?
>The kernel code is correct and there are many other options which don't m=
ake sense in these
>modes, we're not going to add new states to them just to accommodate brok=
en user-space code.
>
>The option's definition clearly states:
>               .unsuppmodes =3D BIT(BOND_MODE_8023AD) | BIT(BOND_MODE_TLB=
) |
>                               BIT(BOND_MODE_ALB)

	In addition to Nikolay's comment, permitting arp_missed_max to
be set to zero implies that zero is a valid setting for the option.
That's not the case here, as a setting of zero makes no logical sense in
the context of its documented behavior:

arp_missed_max

        Specifies the number of arp_interval monitor checks that must
        fail in order for an interface to be marked down by the ARP monito=
r.

        In order to provide orderly failover semantics, backup interfaces
        are permitted an extra monitor check (i.e., they must fail
        arp_missed_max + 1 times before being marked down).

        The default value is 2, and the allowable range is 1 - 255.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

