Return-Path: <linux-rdma+bounces-1660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC5890D8C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 23:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE561B240DC
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F2D13BAF3;
	Thu, 28 Mar 2024 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="F854slZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KV+i3NsX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46E13AA43;
	Thu, 28 Mar 2024 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664497; cv=none; b=hSEHDrA5HlWJ7vwAkIcJRDHko0UTsIaGd69JMsJTGX4ICHDb1UF3+/J53l8ojnFrKUapion6riCi0RXNh6q85PWqPC63UdqWs0p2JkhWKwx4ZaAUv8FSREN+X8SPtLg/tVy4dkJki1YF6JvIj7b5AXS572BZMGDptc1Emr4qQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664497; c=relaxed/simple;
	bh=mOFwk6M1zhT1iOVUqY/hGGV5E3pwFDgAZwnWalX/pJQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=OIeph8P2SNHt90RLN2Wp7xl1b/BsornDw10/RO4XNMfnrTP9eEQAbRJGvJ8/JtTDAFviHhJuqudJgs6332i1Zd8ZPgOZSY6Imf/6/c3XHubAlYyWVzZovZgedcYi554WHqHThiokuUB6KAzVjZGEpOTkernoBRA7vom4MH5tLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=F854slZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KV+i3NsX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E0D0D138011A;
	Thu, 28 Mar 2024 18:21:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 18:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711664494;
	 x=1711750894; bh=cqhIx11127blwZEBTGU6eCEpapLLuESTyHFNcTJ+wAY=; b=
	F854slZWo+i70tZfg0AmmCv4sr3It6R7pYK6uu3HjukPxABjiXNO5XylMrSp/Jn6
	srSLcsw2L9p50Grj4CBz853jcn3U6o4+RUcwwgH55s6+/IIURt5P+eqcmAkKYv7N
	FONPhqwkNpes2XrXmxtDYH5eHXxY+svSxIgBUOftX4JaG+uUu4RlOWoXI0P6v9L2
	wpKx/coJJOqekcDB7G6Qh6+ICfb8kPYeYI8BQw9cxaO7Dd2ymb7D65g6d8T/Rhom
	6yuyz0K1NaPoI3z3zpNn4vUdy5PTcu8y+1Qv1jEeBg68wn1BfUB6c8f6y/2vI4A4
	sWBvFTTFenv9lkFM/He+VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711664494; x=
	1711750894; bh=cqhIx11127blwZEBTGU6eCEpapLLuESTyHFNcTJ+wAY=; b=K
	V+i3NsX5NVTQf7lx8NVGlCi0ND2m63KVz90bXf1WdyOXTYP5kcOTYcDfxN5DPuUo
	Z2nWC8+DWGnA0gIGf5/bmBbQ8vTIh+DjTBR+cHR3rmFUAqcEYsbhCqcBZyLduNqy
	8ZkPcqTjFhDCHBZGRn3q5RWSP7cOzLJwpCEdzwf0zKLW88UxCNODRdHFPKjQAX+T
	u2A2vg5hy6H9BJlMPSPHX3eOuCAIOc6Vhkr7afdWU1DZFF9GwJF1N3hzStdIl7hu
	elT4qJP/1RkI4ttkEChmbCa2UxjipPQXFU9zZl/0W74o7olUDnBLoNc7tcfxZ97g
	+nZKfoATFKb/7hQBxdzVA==
X-ME-Sender: <xms:bu0FZlBJwW7ueuyC4kpoPA5sN5dLnRoH0TaoyJP9MKk5o8Wh7wXJvw>
    <xme:bu0FZjgz4A135ve_MYMJFqRJ2e8-TQkp871my8WhxYh7UR33hPkHkU13e3xpT3fjc
    FgoCxzYRxonsByalnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bu0FZgl3ehV8e4nLHD9CiSYyObE_6DOOvK5W2UflW3ueShY7mJst5w>
    <xmx:bu0FZvwwRvt8IScU4eWOmIWsERzNk5WKaTDuip_GpJa_91i6wp-B6Q>
    <xmx:bu0FZqQHeflmfFT5iRMLz1Z8KiHe5vXkUgyiXaWpc4ulOuFx4LjbWA>
    <xmx:bu0FZiY1fLk30sOTiaJawo29_qspSahZdJWUEirxNEFul09XEphSaA>
    <xmx:bu0FZjSvJhTpLjRx7TrKvKT33ho63rBL0584nLjGYTIkTQtV1Y5-2Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8C232B6008F; Thu, 28 Mar 2024 18:21:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <24a4f667-6eef-484d-8f9c-129d3ddf70a1@app.fastmail.com>
In-Reply-To: 
 <CAFhGd8pTdJNzmxhUaCpDkWpYiAP0Gvm6K=o+w5uE-g20M7u3rA@mail.gmail.com>
References: <20240328143051.1069575-1-arnd@kernel.org>
 <20240328143051.1069575-9-arnd@kernel.org>
 <CAFhGd8pTdJNzmxhUaCpDkWpYiAP0Gvm6K=o+w5uE-g20M7u3rA@mail.gmail.com>
Date: Thu, 28 Mar 2024 23:21:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Justin Stitt" <justinstitt@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Leon Romanovsky" <leon@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Jonathan Lemon" <jonathan.lemon@gmail.com>,
 "Maxim Mikityanskiy" <maxtram95@gmail.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Gal Pressman" <gal@nvidia.com>, Netdev <netdev@vger.kernel.org>,
 linux-rdma@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 8/9] mlx5: stop warning for 64KB pages
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024, at 23:09, Justin Stitt wrote:
> On Thu, Mar 28, 2024 at 7:32=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> When building with 64KB pages, clang points out that xsk->chunk_size
>> can never be PAGE_SIZE:
>
> This is under W=3D1 right? Otherwise this is a mighty annoying warning.

At the moment yes. I'm fairly sure that I've covered all the
common cases with thousands of randconfig builds, so we should
be able to make it the default when this series is fully merged.

     Arnd

