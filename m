Return-Path: <linux-rdma+bounces-1024-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3013855BF0
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 09:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA764282C60
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154811190;
	Thu, 15 Feb 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="G42iGkEX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+y/ru1I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E71DDAB;
	Thu, 15 Feb 2024 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984206; cv=none; b=a2RmVoDuYBAQAltlUjBiklnotvfUsN0MfGTcyVLqbUfZVyUsKhlIx0VFpfgKPELZJMHk7t3rrKvH2CSQIwnWKtyKTtCDFJ2JhuJ1VM/YPXbCknCIVmbj2+6+ns5y4stbMXAysXsl0ce5M5JHstNS+R9+52+PN4EON1Zu77+awNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984206; c=relaxed/simple;
	bh=W3WXonl3jw7eqUYff5oZbHwVrqKRRkZEbCSVq96r0Ks=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=A/5684lLpQ1qP9bhDz1cnt817+aggHL8KrHnHAHq9jImzkwc9SVRnQ1b50YA2gOh2aYZaWmDmePqbbv09kf65Ng9kOw0R63FvGPnGcEofCEyYrGpe6hVRvUYPEcymluYiNgBTga2HTSFWHA8qRjcZijpKgDvl00IVo9dKAkWpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=G42iGkEX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+y/ru1I; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 07BB711400D1;
	Thu, 15 Feb 2024 03:03:23 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 03:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707984203;
	 x=1708070603; bh=nruawRjfVtzHY6r13lnbTRpp78sGs8KHCPeUBSNQVaw=; b=
	G42iGkEXvMQX9bLghV8tpaLlKY2I87IzuH2ZbCDx2pP/zhsKJD3VVZ38fI+wrjaH
	zUSofYy5D+gMpQosh3Jn7rKgOuysv/BwkNGAcrL3OoSouqf57hhE6bPDMGwRJvAa
	Cgyl8/vfNAJLHDwxYS7sT31kOkJMPohG/XCgUBorJbyfGKPNVAuw3/ET1ue/wEV2
	NQhHhH8g1EW5eMZItBBV6ubgsYa4AMk3WsqBxAcW+Cd8zfLugmodCtHroMLlfbJg
	WDf7xKKctn6NQaukhXjQLSaXwLCy8f7AJILD6Sf3wuhpFucj/PuiFRjzUmJ8d+e2
	JJ4+u88HPLzBEKWaXQE6KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1707984203; x=
	1708070603; bh=nruawRjfVtzHY6r13lnbTRpp78sGs8KHCPeUBSNQVaw=; b=R
	+y/ru1IUwL92HBGtFHagy69xYtsWttfN4EaB+wm592yL+rOGSfrrHtubRKbDs6lw
	j4vjgXHad/KXDK8BxpEpLBTRFiG0Wki+5UrwKAbFpGiwIgRlUk9f05KN4Uh47ELm
	ee/EdCZHUsL5G96a2mnXe0C12+/Lu6sDtbNZImUr/5tn85y4bOEVeGcWVNzM1IMZ
	EGlRRcwACN+74cVCzgctaAsMZSqdbRzZtV/IoUYygPk5mKm41wGhgMc9nAvELKwV
	QDEjEZl+1qpwgBeKBj80ddFZ+k0n5l0LW88z7QPYCxLZ3KMlOtrbCbIvErpHzT1n
	ECsNd9m3b8YNYXlL8bG/Q==
X-ME-Sender: <xms:SsXNZZLOxCB7LLsapMnds01Lvvm0aahagP38taGZa8hjGigm69goqA>
    <xme:SsXNZVI88RdOQSnidaznTNgrllFe1-97OmsH2p5rEuQz9vqm99qgfixEut1P4B1-8
    XIDq_NzewnDzUhjUZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:SsXNZRuz4Jwc3mO9ITu768i7Q9mQmmMX0YvObNWfGC6V6qEAfLXoXQ>
    <xmx:SsXNZabwXXg9YQRj6deWT0cvniCFsdwm8H2xKZ7pf52TRwSBr9f-RA>
    <xmx:SsXNZQZfgK_nAAvM0fVJWqT9WhRcZb3_x0s3QGA_E1S36DV1CEoiQQ>
    <xmx:S8XNZQoig3wW3jHwOAJi0Syiy73Y_j3MOzegrtYSUdIYk1TV7PNtBw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A393BB6008D; Thu, 15 Feb 2024 03:03:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2ebe5a36-ce81-4d26-a12b-7affbd65c5e3@app.fastmail.com>
In-Reply-To: <84874528-daea-424d-af63-b9b86835fae6@linux.dev>
References: <20240213100848.458819-1-arnd@kernel.org>
 <84874528-daea-424d-af63-b9b86835fae6@linux.dev>
Date: Thu, 15 Feb 2024 09:03:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Zhu Yanjun" <yanjun.zhu@linux.dev>, "Arnd Bergmann" <arnd@kernel.org>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Yevgeny Kliteynik" <kliteyn@nvidia.com>,
 "Alex Vesker" <valex@nvidia.com>, "Hamdan Igbaria" <hamdani@nvidia.com>,
 Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: fix possible stack overflows
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024, at 01:18, Zhu Yanjun wrote:
> =E5=9C=A8 2024/2/13 18:08, Arnd Bergmann =E5=86=99=E9=81=93:

>>   static int
>> -dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx *=
rule_rx_tx,
>> +dr_dump_rule_rx_tx(struct seq_file *file, char *buff,
>> +		   struct mlx5dr_rule_rx_tx *rule_rx_tx,
>>   		   bool is_rx, const u64 rule_id, u8 format_ver)
>>   {
>>   	struct mlx5dr_ste *ste_arr[DR_RULE_MAX_STES + DR_ACTION_MAX_STES];
>> @@ -533,7 +532,7 @@ dr_dump_rule_rx_tx(struct seq_file *file, struct =
mlx5dr_rule_rx_tx *rule_rx_tx,
>>   		return 0;
>>  =20
>>   	while (i--) {
>> -		ret =3D dr_dump_rule_mem(file, ste_arr[i], is_rx, rule_id,
>
> Before buff is reused, I am not sure whether buff should be firstly=20
> zeroed or not.

I don't see why it would, but if you want to zero it, that would be
a separate patch that is already needed on the existing code,
which never zeroes its buffers.

    Arnd

