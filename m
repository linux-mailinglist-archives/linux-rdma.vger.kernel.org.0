Return-Path: <linux-rdma+bounces-1073-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8F85B4A0
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 09:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A2C1C21A7E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC445C611;
	Tue, 20 Feb 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kdqW2l0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jXqLLpIS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34C5C5EF;
	Tue, 20 Feb 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416737; cv=none; b=e8YubkOUc57L0qvAFtdkVTXSJRQaSua6q1jzYRRpt5QZ7a6nkvVmecNPbDBpYHZGwr99qyeyz2EwDsyCEKr0o5+DnqGf4ysLV5yUxYKyjPxNsm8Qabx5r/7t20dlUlNQnxTsu+hsta8+RFH0nmnfv23NSIaGpMKg4HBIEaJeKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416737; c=relaxed/simple;
	bh=6fhWeR1skHIaeVT56IgW7/ZRjTOHRdJQKKLKOdXi/44=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=s3AP3Kun/cYF2FAYJqsn33P3l50gvjB61Ayf+EKICxvMO9K+1cV182w0jJ+HYKB/azmpkoyzv4vX+544Vu0d/OhEUwL49gfSVMuiNNrSodAU1amOJWI36X/kx3hDShi8fJQebmwdtVMjIFM+wTbBHlM7r6fTx3XxGqF/Ecu/nKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kdqW2l0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jXqLLpIS; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4485C320030E;
	Tue, 20 Feb 2024 03:12:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 03:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708416732; x=1708503132; bh=g86RjqfeIk
	2lRMsjMG7R0Z/s1eUewX0ypn7zMKPtPqI=; b=kdqW2l0Lc++8tT/GjBVik33QGN
	e2PFW5lEGTQza7J9d17OGfQ6d3/VVptas0D2fv8EyY76DRizj68Io4qM3zAVceBB
	cCqMEqlNvrpIB++E+N7XoLl4N5kJeUzoteM12HY9RPWVZ9/z12F3gq54RUtL4B5o
	rKi2u09+610i5/6WcBr6CSlH4IvYubOvA36YPkhMAlEBAtJGQCRb1w140FDHRuWk
	Jf+zAOu6rSquKZfTLklAV0mWWQR3nuM1xWVk2vJhbhhZi3OQK/HPUAs1Y4s8McQ4
	TIfHf9948RVmQmxvI/Taru9FR81jYUfb/P9y5geMyoYFCRvr2bCpqGEm/H+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708416732; x=1708503132; bh=g86RjqfeIk2lRMsjMG7R0Z/s1eUe
	wX0ypn7zMKPtPqI=; b=jXqLLpIS0CkK2gAg23OyzdabR2hyYGs+OkeYGw1JNsPA
	BjS+6ja4HS4w8stEX8RSvEnvVh9qDDLpkAuk4Y+o//iyfc+MQqSXfR0veeZA+MKZ
	gSyN5lic5E5X6j+aUT22jm1JbsXbaO3kM/rYHPj2004tL/Vw4GVu55DxYTszs40c
	mPg238JDaaLStUeFY+ylWjcmxp6LNt5i1RDhCDsBvwejsvx2mZ+5BYRHLvUHQM/5
	eWJZRl/8J7Id9dvHrABCqgp2ZCpVf3B3be5lWVuldSR9pDplp/8n8gQ9d+FEmH1h
	Q3z6ZlBXpMe0gef228xhW/GqmXsRHOEGCDL1JQ95HQ==
X-ME-Sender: <xms:3F7UZQ3Ep8tV3mn_tyP6sd-cGLrnVksGUkBnd6CRAklUjE1xMr4lPg>
    <xme:3F7UZbFDhLouqjhWwwnNct9pT9BOQSmr5kaI2LdkycEnVzvRoLJwlfk7MmvoOy4rZ
    WExLeJChgMgI_oELRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3F7UZY4wrhvlN0vfsmYjtHJwsIOjDlo7RVwtgF4LSHS9T_UvCl_4BA>
    <xmx:3F7UZZ2slXQjUiICjN91hlV0KGr8x17uC2_Fi98Ry4Gb6134N2I5tQ>
    <xmx:3F7UZTFRz59Vv4xEWcsbQIfyYo-7qKKahXR2hCtQbqbzIHgZDC_N0Q>
    <xmx:3F7UZTEuaXMZKp-AE2gpgBms1oH4ARs4ikFOt7LCTmwOaQephVo4zw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 818BAB6008D; Tue, 20 Feb 2024 03:12:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <726459a9-c549-4fec-9a4d-61ae1da04f0a@app.fastmail.com>
In-Reply-To: <20240220080624.GQ40273@kernel.org>
References: <20240219100506.648089-1-arnd@kernel.org>
 <20240219100506.648089-2-arnd@kernel.org> <20240220080624.GQ40273@kernel.org>
Date: Tue, 20 Feb 2024 09:11:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Simon Horman" <horms@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Saeed Mahameed" <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Zhu Yanjun" <yanjun.zhu@linux.dev>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Yevgeny Kliteynik" <kliteyn@nvidia.com>,
 "Alex Vesker" <valex@nvidia.com>, "Hamdan Igbaria" <hamdani@nvidia.com>,
 Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] net/mlx5: fix possible stack overflows
Content-Type: text/plain

On Tue, Feb 20, 2024, at 09:06, Simon Horman wrote:
> On Mon, Feb 19, 2024 at 11:04:56AM +0100, Arnd Bergmann wrote:

> Hi Arnd,
>
> With patch 1/2 in place this code goes on as:
>
> 	switch (action->action_type) {
> 	case DR_ACTION_TYP_DROP:
> 		memset(buff, 0, sizeof(buff));
>
> buff is now a char * rather than an array of char.
> siceof(buff) doesn't seem right here anymore.
>
> Flagged by Coccinelle.

Rihgt, that would be bad. It sounds like we won't use patch 1/2
after all though, so I think it's going to be fine after all.
If the mlx5 maintainers still want both patches, I'll rework
it to use the fixed size.

     Arnd

