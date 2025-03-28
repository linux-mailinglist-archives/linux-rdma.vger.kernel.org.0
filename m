Return-Path: <linux-rdma+bounces-9023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C05A74A83
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 14:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FBA189B675
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD11494D9;
	Fri, 28 Mar 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XChseV0c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQxAMH9P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDC13DBB1;
	Fri, 28 Mar 2025 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168055; cv=none; b=NwhyiqjS74K0/wV6zmoD8MF7WKWo/x/APqI7UM155gwDPb7G96bGEwRwAkNLBiCwmSHW6lMiFOLaEsLvmftnOyhedYRBSckSHjIbOtkE+092n0/c3yB3EEweecLByculX+nz74TbisxZWgJubfbqKROWXfKXLdoEuisgMQjDCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168055; c=relaxed/simple;
	bh=UhYTpTLxViWjTIx4U2fR+YH2GIQfmU38Fl1+ewcphqg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uD4aPmJo78PHYlT/itDMLSN034P+6TQ4AQh/bbMVE9DuJvAfNwPPFUztYUVIH+oHqKsv2KSursonuKhUJWk3v+F79Lr+/aoDCUU4Ti0t3Un2v9/FqUsHjCrOjuHdMmBHA3v0f5vjvmZN6gO0g+d4bWje2tt4ZvFOH9heYgmqUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XChseV0c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQxAMH9P; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A991D114019E;
	Fri, 28 Mar 2025 09:20:51 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 28 Mar 2025 09:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743168051;
	 x=1743254451; bh=8WS+YUbx2J8hBpzV40D2XS75QbzuBOzvjxGlik91qWw=; b=
	XChseV0c9/qkhnhlNYlNrP6mNL72jWbwxj8R+II58+E+YQinQRAv5mKMBDdEPeiR
	qcFV1fd1VLnXHilYNcSzX2t4vwHoIc0c/buXak1RkFNQWrj7BEtcXLQ8SugOW58o
	PSYNZx41mJTZEBZ4evMcDaQa/p33c6FpKy3F7qvznXNLgukpj0VqnQlG8O8WWTph
	mQcEi2e4x5OhEKDMxkVzkNd0bPIBzMfZjYkCPd66/rwG7h6OfTU/ib6BL27TEhUe
	kWGT03+LDs6/TgnzIn9fGXIC43m66+OWrO9qeewCYyLpzcm3Jz7jnMS9j70bq8J2
	prNBLmJgX4cqtwpVnstjiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743168051; x=
	1743254451; bh=8WS+YUbx2J8hBpzV40D2XS75QbzuBOzvjxGlik91qWw=; b=H
	QxAMH9PXE6htYyOjFD3rRAxzjVif5Ej4mSORf/aPy4mc1X/eZHEhKoVG/2CD0gz/
	twhUuaY8+G7aZQR/3zWgnoUKgsgtl78jce0IUWMTVUnHXYRie1dplxGGkFdtnfPi
	51VwYTei+nNSP2mXQTBYZnsH8w3752Z/HT6jtY+3fkErMFcXoR79rw5PUHfBNDrx
	CID/jOGlly/7kHaSr1GobumDCwTFYg69gUf/ozuYUu5wL1CcE/Yyosaa9odGLkGy
	HbnICQBmYhoHPWYYy7K41T96rkKoEnjxKBIyUAdG/G8taoTOxRyXqyMzIhEhe+Gv
	ZDVFIvLtpA+YkCD3T4MhQ==
X-ME-Sender: <xms:M6LmZ3asNqcHtOR7zjY1UpjhHXmFoQ_JhNh1pjEo_VNJIp6awaYLWA>
    <xme:M6LmZ2aO9-lTXPaHWHc3UMM2RA99lnMNwl5evKTHvWO5efJcBF0-t9QVxd5shrVE5
    KQjcdJ-DCaoN3-vRXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    vghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgslhhotghhsehnvhhiughirg
    drtghomhdprhgtphhtthhopehmohhshhgvsehnvhhiughirgdrtghomhdprhgtphhtthho
    pehphhgruggurggusehnvhhiughirgdrtghomhdprhgtphhtthhopehtrghrihhqthesnh
    hvihguihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:M6LmZ5-dv7m1xeyzM__6dXG9cPiDQV2_DdmQ3Z4Iag7pHSEU8YnTJw>
    <xmx:M6LmZ9piqrNdGPCSUwauQ1sPGqtrMlPXLctUN0l6QoT1mskiUVSJmA>
    <xmx:M6LmZyq3l_1V6NccK9JM0JNb7iIbJw_fwChXNXa7tJg-IZzctrsIow>
    <xmx:M6LmZzRVxw89wLxZ0CjuHwSJT9JJF7DO08ALccwBHEwAAuZyBXp95Q>
    <xmx:M6LmZx3u5ZohGo0u3mInfwHYw_fWiygbHFVnMAyU4f9NRLTtFnWusV2I>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3D2E52220073; Fri, 28 Mar 2025 09:20:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8b2d4b03a137eab5
Date: Fri, 28 Mar 2025 14:20:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Leon Romanovsky" <leon@kernel.org>,
 "Patrisious Haddad" <phaddad@nvidia.com>, "Mark Bloch" <mbloch@nvidia.com>,
 "Tariq Toukan" <tariqt@nvidia.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Moshe Shemesh" <moshe@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <cdaf0e11-3de2-4979-8112-7865c63c0ffd@app.fastmail.com>
In-Reply-To: <20250328131513.GB20836@ziepe.ca>
References: <20250328131022.452068-1-arnd@kernel.org>
 <20250328131513.GB20836@ziepe.ca>
Subject: Re: [PATCH] RDMA/mlx5: hide unused code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 28, 2025, at 14:15, Jason Gunthorpe wrote:
> On Fri, Mar 28, 2025 at 02:10:17PM +0100, Arnd Bergmann wrote:
>
> IDK, I'm tempted to revert 36e0d433672f ("RDMA/mlx5: Compile fs.c
> regardless of INFINIBAND_USER_ACCESS config")
>
> I don't think that was so well thought out. The entire file was
> designed to be USER_ACCESS only because it uses all this mechanism.
>
> #ifdefing away half the file seems ugly.

That sounds better to me, yes. I assumed that a later patch
required that one, but I don't see such a dependency.

     Arnd

