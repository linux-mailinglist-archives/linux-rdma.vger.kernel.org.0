Return-Path: <linux-rdma+bounces-19842-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGXCDlR+9WnZLgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19842-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 06:32:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6324B0E53
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 06:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2009930179D0
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 04:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A024F2D0C94;
	Sat,  2 May 2026 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ortqi6uW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUtDmXXB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDED1A9F97;
	Sat,  2 May 2026 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696333; cv=none; b=Lryt8aV5tsi1Y6jtCDXQCsAOcMl290ojOX/waXZcJo0denoHsPNkBWJjZR0yDH5TkB20FQvZqpEfheXGSOc1Exno4LyF2rKTOK5DMTKi3cFXT+aYVXi+p4qoiFeXY7TcvhAPIdjrIHJ49uzKCAs6XraKLlDJrB7DO2X1nQeX84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696333; c=relaxed/simple;
	bh=VvzNqcyWvOSXIgK/Bn248L/jEf6SxdUEYXGuhkZRyNQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m7savpaJtISdfieT8K0HSVe+O6SfhPyfoeJzsZA2wLKz5pdkxL+cjZtFlthkKT9q/6Aocj37LdAjTZXjbHcmzdnlmV/EHGrt6qG0K75TJHoxZTy2h9ezraVrS0iYgdGzAS+kLIkAwXRMFbwFMEO9dzUkvdQPV0WKypTaCaQ2d6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ortqi6uW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HUtDmXXB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 703E51400176;
	Sat,  2 May 2026 00:32:10 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Sat, 02 May 2026 00:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777696330;
	 x=1777782730; bh=BREJYA/ynimdlvkziKMjJqbroFR4YvUmHC1hcGjm9x8=; b=
	ortqi6uWikQ8D9//DCJX6HdxN8qFN/wNEWu0GjtX/JPurb0gBkR4R/br/H8uDKTd
	nmVrg/zHJo0fowP7PEuIKYgTWsjvTn/JdCJtKg4LDUDZerAGHgfF9Wi4dCDnEz/z
	xo7Cu6HZlvV/3FeDd6e5zuviTb21KWNY546Y37/CojJP/NnsnHd7W6hCdYhaIWB2
	ArmF0d7GHsn5B6tN9kr+tNJUVJ9hJfLXqTpV2a0cEtPuE1POhSO63SN8Qiz+45JU
	D8R7mCSTm10le84gZO/UDNJ7N5uJWx1tlUX9FBoTm+TUhhqIbt5kMjahBTcPcbkn
	JYkoZCpvAl2ZZlRXYr67xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777696330; x=
	1777782730; bh=BREJYA/ynimdlvkziKMjJqbroFR4YvUmHC1hcGjm9x8=; b=H
	UtDmXXBWutpUdoGrBRVkz3b0v9T8jZ9AxD3wms8UA4sCaccGEoiIGJpK176hlCs1
	++oYIaUXtDgRouEW/wv6KP3LjaKSxpYEltfcSD3oZEfFP6TyMC99JLukz1YL/v4G
	cjKGQjjPtr33m2OCkT0tTqbHjMzDxnYagJ1qStOR0GFdJeU7amfTXugPKwN62WUq
	hiyssUkSzOmygpsS8dCbuuyOvMh1Kb5d+dg7nkr6nXgnPKgEUPja215mCA1Cw5S1
	MsafOhxA8wAd/KM9YBS4Jec6jghW6ceGUIVgYIZwj1gCHRoczHzzL6q0RZXW//VV
	iH4LIN0H3D4mzXmiHQclQ==
X-ME-Sender: <xms:Sn71af8e8p1BZAIxzaNAVYGvLu3pfDMXKBpJ5rTpm9xoo5togOtt_A>
    <xme:Sn71aWggk1gjkF9-EHfQIMZHiV4bsxMT7xaTeKwa00mLlxXLEKvL1_2UxMe9e0Wxv
    hDOHgv0q7JWKiWysf5stfrURGwhzrGbcofLmOa0cnS1a18WrK_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelvddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetlhgvgicu
    hghilhhlihgrmhhsohhnfdcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrf
    grthhtvghrnhepgfeffeelgffgffevffetteeivdettdfgvdeiveefjeeffeffveetjeet
    udffgfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgr
    hheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrthgthhgvsheslhhishhtshdrlh
    hinhhugidruggvvhdprhgtphhtthhopehjghhgsehnvhhiughirgdrtghomhdprhgtphht
    thhopehmsghlohgthhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshgrvggvughmse
    hnvhhiughirgdrtghomhdprhgtphhtthhopehtrghrihhqthesnhhvihguihgrrdgtohhm
    pdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Sn71abxKiOXJB7RlQcQ0yz-wxuLtklAZqMqe2BAF8vmaUaUeZEd0oA>
    <xmx:Sn71af8FJynU3OCbEob14bK3zdFzrZp2mhbGaDRk_tZAmL75iuQH9g>
    <xmx:Sn71aZOKAri6LW5ABVGBIXnZ0WVwarqNA3Af0NJ3y5SX_iMTF7-AEQ>
    <xmx:Sn71afoF33idoETcqH1XenMvYie6Fa-e0WkFHEuikluE6lh-pDs1Zw>
    <xmx:Sn71aeZ3SmnZnKSEnikCL7LK8w_aZoWWQ1OImsJAmIbITGiETqVEP4kj>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 14AE715C008F; Sat,  2 May 2026 00:32:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALXc8_xz--ng
Date: Fri, 01 May 2026 22:31:49 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>, "David Matlack" <dmatlack@google.com>,
 kvm@vger.kernel.org, "Leon Romanovsky" <leon@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Mark Bloch" <mbloch@nvidia.com>, netdev@vger.kernel.org,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Shuah Khan" <shuah@kernel.org>,
 "Tariq Toukan" <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Message-Id: <71afd479-71b4-4ab7-bcbe-3f7b53bd11f4@app.fastmail.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DB6324B0E53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19842-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026, at 6:08 PM, Jason Gunthorpe wrote:
> Add an mlx5 driver to VFIO self test. This is largely a remix of the
> existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> to issue RDMA WRITE operations which effectively perform memory
> copies using DMA. Since mlx5 has a stable programming ABI this
> should work on devices from CX5 to current HW. The device FW must
> support the QP loopback configuration.

Does the PCI ID table in the series need some pruning then?  It includes CX4.
Thanks,

Alex

