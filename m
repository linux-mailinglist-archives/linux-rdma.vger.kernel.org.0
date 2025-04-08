Return-Path: <linux-rdma+bounces-9245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357ADA8098A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AE43BC42E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74EF268684;
	Tue,  8 Apr 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UuxwYwqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AXAp9fon"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA9269894;
	Tue,  8 Apr 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116063; cv=none; b=WxKla9l4KwplFUgFVAPXZpsyY/9nOBfqdzr3yyV+jEjEHRPmGdj6dOTF2gjplQz+AVdKCfpHdvPLb0We2C2rPsrBgz1RBYClLYrOsT6bfmfAeNrBQ66ReV+t/P6H8bPqRxfU2oGcWK2kArhIUZU6g6hzWohAiCjaT++Vi8Bjwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116063; c=relaxed/simple;
	bh=Hdn3jLFI8See6Ptbvyv1gRzc3n7aXo0ULCP6lBveVgE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hrTszEGaHnlI8Z35inANvdzG6ZB9R65ra4vY8Uk9PIiReceAv/6Vg73k4chEM7YiO+I+Jm0DbXwoVs7ZBN4ZTYu6gU/eghL+HuBsbW0xDsiLvV+a71Oqlu0cFO7wK2qEvPLOImJrjwZooogQq348A36MXV0qqUOPAmfTVReYhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UuxwYwqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AXAp9fon; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E12E71140209;
	Tue,  8 Apr 2025 08:41:00 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Tue, 08 Apr 2025 08:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744116060;
	 x=1744202460; bh=V7ZmAkvaEhI204wyVrWbjlfmvNARyEj1dEXY0oh8U8w=; b=
	UuxwYwqoDqV4H66atteXWjGjBKLkAzMCeiMTk30LDh8zTe+G9WojwI08cNCkdfxZ
	3kdFu/e7YOLYPk02BdAZ0pFuJ0KBHovSV5B//KOXcO9yCSv8fS/BsdCarD6L/WSD
	LoTnN+n0O2rA7ASEPSC0In7XabZ+opiReZLUC2Ct1JFCPcsgQV0F6/Im9ZVglE02
	cFyBX6QuIU99zLKS7jBAT45SV/MI0d4JGror22uyNNqoWlUczFt9C4wu3+D3zTM1
	n4DaBZDOXjqfo8H9dY7xCy6PAV897I2qRZFGR0AY/qB7M6hbTAslYS7zPDlAqh+g
	zaa0TjU3KwI6iJltRDsccQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744116060; x=
	1744202460; bh=V7ZmAkvaEhI204wyVrWbjlfmvNARyEj1dEXY0oh8U8w=; b=A
	XAp9fonXJwrqavrOpRbzR77hLdfL2m2imdqSblTpV2l3W6WUDoU0TRryHJzswZXN
	PbuVWeiqSbkvWKJpA2qk6UftelRN4L9eu8d3muQs6JgKhosj51kruTC0WnMI9JMa
	ByB8lu/3wDVL0TpEEJ+k75SoAqU4PEKhyDvlUcMq4amWz1JXFguX6w8cz5CfMObi
	y/ls/s0e2p2oBomM5PKazTHyIBeATsU4cgCR6xEJQYCjp7r1p7ytyiaNEqUllwDU
	/l9DSKzX/WnxZGWiZcxYju3ACC/W83D3jylHbdn0Dh8O23ANsbLtWJg4sONkqxgB
	EMbR3T0T7RzwRJWMEcyRA==
X-ME-Sender: <xms:XBn1ZxKwTjo6WW2swrnUIhmI5Xf0Rp5u1tqel2qDoqcQLsYx0uY1ng>
    <xme:XBn1Z9I_P7rj53pITsEGVK_pSBgyjEiKAAyNNVa9GPDeyT2nKQgz9ctonRFyNqPE3
    kXOZoDqJHgxzRcbfY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdhkoh
    gvnhhighesrghmugdrtghomhdprhgtphhtthhopeguvghnnhhishdruggrlhgvshhsrghn
    ughrohestghorhhnvghlihhsnhgvthifohhrkhhsrdgtohhmpdhrtghpthhtoheprhhosh
    htvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehjrghnihdrnhhikhhulhgr
    sehinhhtvghlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghs
    rdhhvghllhhsthhrohhmsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmh
    hsrghnrghllhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhigsehtrhgv
    sghlihhgrdhorhhg
X-ME-Proxy: <xmx:XBn1Z5swPQl3vhOwCP7emFm9hd6Dh7K-0giREaxS4drZOAJm3EyGCQ>
    <xmx:XBn1ZyZggGbzP_qf-zCt88Jn8c0-f0Ls7VAYtMmMeYXQ6HOOiG0xWA>
    <xmx:XBn1Z4bYVs5zWGlkOcKSobk5RpqWTbbm7gxoja2irR1uQSI00Vu08Q>
    <xmx:XBn1Z2Ax8TGQmlRowMjByriCcs5t6-Dwztw5p-TuNfOsa8HCHfGoqA>
    <xmx:XBn1Z0cb9cq0Gad53fgpARsJV6tLvWPJ08-BsotJV_GmQKJGl_1kxCgR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3E3AD2220073; Tue,  8 Apr 2025 08:41:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3342f2635bddf8ab
Date: Tue, 08 Apr 2025 14:40:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Jani Nikula" <jani.nikula@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux <linux@treblig.org>, "Maher Sanalla" <msanalla@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <e477f8c0-5478-43b5-9d59-297efc32d20e@app.fastmail.com>
In-Reply-To: <20250407182750.GA1727154@ziepe.ca>
References: <20250403144801.3779379-1-arnd@kernel.org>
 <20250407182750.GA1727154@ziepe.ca>
Subject: Re: [PATCH] RDMA/hfi1: use a struct group to avoid warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Apr 7, 2025, at 20:27, Jason Gunthorpe wrote:
> On Thu, Apr 03, 2025 at 04:47:53PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> On gcc-11 and earlier, the driver sometimes produces a warning
>> for memset:
>> 
>> In file included from include/linux/string.h:392,
>>                  from drivers/infiniband/hw/hfi1/mad.c:6:
>> In function 'fortify_memset_chk',
>>     inlined from '__subn_get_opa_hfi1_cong_log' at drivers/infiniband/hw/hfi1/mad.c:3873:2,
>>     inlined from 'subn_get_opa_sma' at drivers/infiniband/hw/hfi1/mad.c:4114:9:
>> include/linux/fortify-string.h:480:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror]
>>     __write_overflow_field(p_size_field, size);
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 
>> This seems to be a false positive, and I found no nice way to rewrite
>> the code to avoid the warning, but adding a a struct group works.
>
> Er.. so do we really want to fix it or just ignore this on gcc-11? Or
> is there really a compile bug here and it is mis-generating the code?
>
> The unneeded struct group seems ugly to me?

Having a clean build would be nice though. Do you think a patch
that just turns off the warning locally would be better?

      Arnd

