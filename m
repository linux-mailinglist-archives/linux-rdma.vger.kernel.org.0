Return-Path: <linux-rdma+bounces-12057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501CFB012CA
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jul 2025 07:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E23643E6E
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jul 2025 05:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3F71C6FF4;
	Fri, 11 Jul 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PSi6BlcI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GWXdiMNB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77DE1C3F0C;
	Fri, 11 Jul 2025 05:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212363; cv=none; b=iwnlAFmJLGTFaznrxyb6YO9ailUWqIUg4SaPK3aqiY8NlqJi50YR0+veXApdB9jV3KHr2LYXe1lD3zjIWxTLfBwsh+Ui/M//NtzRk092MjgORT4rfoGDvKrM4qmVd6y+fqmJU67KNDiFSIacVrJGkHf8WmiJnrw6yz6SPVR9omU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212363; c=relaxed/simple;
	bh=9ucvJIUZd3lzV1IhAOQuxr0u8UjYarIJXu4lClXxnTk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dUNBUWYK6I247J+m350enBBjh7yz1QIvt9P/uOplonbCaUuyQn0v5x7j01Y2WvssNz6Ki1+jniZfC7wU4E86oB0xQZhR96b6tInZWkSHAjB0vFooExNxZbjqCtuHplCUlUChm9dOJ8hQNuUBp0Lu77cNXaIZDDNReA4DuhWDYhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PSi6BlcI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GWXdiMNB; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA6F27A00B7;
	Fri, 11 Jul 2025 01:39:20 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 01:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752212360;
	 x=1752298760; bh=chvThCxO3+lhCYsUPOVSRTIK6aMhUEoN4Vgs/mqYZNo=; b=
	PSi6BlcIZ7/z8rrM/zz3bPAyJF0m7zKs70o330W6P/8Ih4acKstn9gD6bxb3FzWS
	qunMJpdYKUrJhv3aHZDYVqSpmeZ0Xmpa7TnzHknzqvbakso+gi5KmChjfHF3tI+i
	vFplN2yBc+yPwCTUai88K8GFmOXQo+1a5Lxs142kwzzwdqcPRCfoag6KtgM54Gxr
	c2xOcW/2fD9qMtHD0GPWlyNOd6YTF9tFlhd7atCzyAAEN7VipU43tB6mGT7VhGbS
	WnDfHATxGvDUaZcHyY+aISh0lZLwnTAJZwrmzNV7Sv55P3pwCOr2+Wd6OFaiVV3Y
	6IySK3ljimx6aIIFZOGv1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752212360; x=
	1752298760; bh=chvThCxO3+lhCYsUPOVSRTIK6aMhUEoN4Vgs/mqYZNo=; b=G
	WXdiMNBvDBgMMiuaaEJ3i/eE72Ehl1SqwW3Ovogu6ZF49thDC0DirBGVlFJKrHJX
	ErEkmVz7j53Ku2hZ0/oVh54TUhykCjvH1cOU832a0it5QxUVhsI4NyMVA/gMSs0F
	bSnxsoT2nW+nmyoFey8fQvgTr7NH8gjDOAnYwKnkG+YcYqC9S2pvkx9E4QUCcuQy
	+bBfBF66qCugrazOQ4R0wpouPzEb7yD9QwbQ+V0GmBcRYs/pjpVixYuwdJQFSfqs
	WTD7zgzx7BZ1I3z3EFnqFa2fyOqjmU6uQ1dwNo3nKmUoDKm6hpKjBTCwrDEPryVA
	DLogrH4iXYZHNCuiJKSoQ==
X-ME-Sender: <xms:iKNwaLWRekUwP2zNILAUeqAphPbYzHSeKT13lwc1_prXqBJKRIqW7g>
    <xme:iKNwaDnE6kSoycPxB2nIdxeLcK60wrPS2U2Phd0_VOiPTxJKIX1tS3BQMGC_nxHtr
    2Bdu_Fodqrh3psu92I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopeihrghnjhhunhdriihhuheslhhinhhugidruggvvhdprhgtphhtthhopehmsghloh
    gthhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhhoshhhvgesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepphgrrhgrvhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepph
    hhrgguuggrugesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumh
    grsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iKNwaCdMcAtm6SdDLTPC_yBD29xPssDMeFASal3IvW4JINS8kfgGnQ>
    <xmx:iKNwaJnf71yW-vH75zJsKMA19RHxWnpiGjgKsQssr09LvdkxdKD-nw>
    <xmx:iKNwaNC6g6bPKsUbQF-T9fy4Ma84xJndDQ2n-PT_2nDMEnnMp2cOkA>
    <xmx:iKNwaLMsKGFXbigMcVaioD6D6YFm02OwCf49gsTo9TxhAHyJEcEwZw>
    <xmx:iKNwaPr0NWxdVPb-hP9Fiqe4_rtxPIaTgkOEh9yj5RpJRrlAS5Wcop19>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 36EB3700068; Fri, 11 Jul 2025 01:39:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2778526bbcf2655b
Date: Fri, 11 Jul 2025 07:39:00 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Zhu Yanjun" <yanjun.zhu@linux.dev>, "Arnd Bergmann" <arnd@kernel.org>,
 "Leon Romanovsky" <leon@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Parav Pandit" <parav@nvidia.com>
Cc: "Mark Bloch" <mbloch@nvidia.com>,
 "Patrisious Haddad" <phaddad@nvidia.com>, "Moshe Shemesh" <moshe@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <a707f0d2-6514-45e2-b123-70013a18c633@app.fastmail.com>
In-Reply-To: <94e50246-5182-4b73-be59-9ce8e9afcfbb@linux.dev>
References: <20250710080955.2517331-1-arnd@kernel.org>
 <94e50246-5182-4b73-be59-9ce8e9afcfbb@linux.dev>
Subject: Re: [PATCH] RDMA/mlx5: fix linking with CONFIG_INFINIBAND_USER_ACCESS=n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 10, 2025, at 22:12, yanjun.zhu wrote:
> On 7/10/25 1:09 AM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The check for rdma_uattrs_has_raw_cap() is not possible if user
>> access is disabled:
>> 
>> ERROR: modpost: "rdma_uattrs_has_raw_cap" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
>
> https://patchwork.kernel.org/project/linux-rdma/patch/72dee6b379bd709255a5d8e8010b576d50e47170.1751967071.git.leon@kernel.org/
>
> The issue you described seems to be the same as the one discussed in the 
> link above. Could you try applying the commit from that link and see if 
> the problem still persists?

That one looks fine, I'm sure it's sufficient without my patch.

    Arnd

