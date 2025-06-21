Return-Path: <linux-rdma+bounces-11511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA119AE280E
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A11189B494
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D91531E3;
	Sat, 21 Jun 2025 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="P09la/GL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YvWVns99"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E742A96;
	Sat, 21 Jun 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495418; cv=none; b=aJPM8K/v10/l/i2NOrG5RrZ2+NrPBHIMKlRx80RTkvWt5Eoej1an7jja1PYNLsQBOUGxR707dtB1BzYUHMF1JobzvhwEigrJcdj5wuXIomauBtokvcaiHPQb2ZTjcy5HlSxj7HkcQfGLRGJLSTsFJ8YLKe4Y5m7lrqYVwCyrWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495418; c=relaxed/simple;
	bh=4rZ2ZnoUrbKDGr/2GBdIO1GUEN5PVZkrr7x6icSvihQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WnSkw3zw/VEZ+kMt5MlOONVzhnuuGd2HU01V8mI2559SJdFVhnECrBBW+Db0nakobvJUUs+pSG/rbtloGnsVA743jOyA8x81oI70e8pv5tUY+OYpIfFcPfETJWCH7uCl7YVC9tn+16Q4r3H60KTzLd7uQF5E+IiveT0TNiGdkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=P09la/GL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YvWVns99; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EE2261140170;
	Sat, 21 Jun 2025 04:43:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 21 Jun 2025 04:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750495414;
	 x=1750581814; bh=hOBt8DyvRAQ/Oc15WkOTB7b3qi20b8aOYJt2sH34Xjo=; b=
	P09la/GLSwtmAnFivcRAl35u7n35/5oOGFpvAJxwwMNUmTQ+ixzlKb51b+Az7ZmR
	fG8uIxihtph8FIdrN4s9RHuXI9PhYIgFJCMPMXEJ+sUHQe60YRPqB0HcV7Cv1I+1
	oMepQkkzsSu6QeGSi8TEdFjSUSzE+jPwK+KCT0oQD/VNvCdUkiOyGCZcSkRgdyy+
	ihrIi5kBzBzub2XlIjyfma+8X3ef0JPL/ACfEOrISuzj6q8aiNcMMbwlFCEhKPL2
	5AHG8dbyiYiFo9Sat8PyueEcamC/t66E1bqZOQXtFP0x/DPOVVOSYTxpYVk9xwM/
	0FLnpZ5NUCMo2x3+lZpv7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750495414; x=
	1750581814; bh=hOBt8DyvRAQ/Oc15WkOTB7b3qi20b8aOYJt2sH34Xjo=; b=Y
	vWVns99GN4o9HSFIbP1+z69sNblzaFOvLCc+3Nj532w1TV8zjaWjPNkmkQcIKAw7
	V6jawYxHYNOocsoBaiL5H+0lrigIIGyoH/0MqmUJBQsuqkBtxIVILvcPI4qVrMoM
	DNcHWs5hwvszJlN86k0i8l2OQIU656vVzpHCO44XDYppVBjv9iQWtJdF4Gq10oD2
	oO9jKeOeL4Oji9S1EdnbFpjzudVVrnz2ck91wtUSLI46VpsX3n7NB26y5RVdpFXn
	8LPwOm3O23rxuW8zFxJ7+82zmmpFFZdMCkWGJWutCZYP5nhQofnXaOXJ07uOzJF3
	f1PB2KsDYlsAec9pY5Ihw==
X-ME-Sender: <xms:tnBWaER4YLzMf5xi1Z203mxC3ZmFhB9kWqcxfh8btFkWhuLEzGuiMg>
    <xme:tnBWaBxpxv-Hu22BkZmFaOcu3CaVKb1Aw3YSTpDujnvfTvJDMB027snpKkl7t_lX0
    Ya-DXOJ42I7YzbPxXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddutdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsghhrghrrghtsegthhgvlhhsihhordgtohhmpdhrtghpthhtohepsh
    hhohifrhihrgestghhvghlshhiohdrtghomhdprhgtphhtthhopehnihgtkhdruggvshgr
    uhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvggsihhggh
    gvrhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvohhnsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tnBWaB1BGk8sCxo4cR8ptzpQrBlMmeFvfJ6JGxxKmxHj5T9wNty-Bw>
    <xmx:tnBWaIAzTbaxNHP_ZUECuEkeT4Lmi1N0z4_RPKjyolIXdIvyu4_zeA>
    <xmx:tnBWaNixZ7FpObsDwab5XzJSFVeb-5VWHxlFmbK-yN_31aGPP4LuFA>
    <xmx:tnBWaEpl9Xauk4k1QQg4lWesnbl9djMv_sXnnRs_q7C8d8gvWLjO4Q>
    <xmx:tnBWaBs718JWZYIXtKYvFNjsiypan0SKgMdlXEwhEJru0Ul1U7FjYW72>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EF5A7700063; Sat, 21 Jun 2025 04:43:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T72ae95e6125674c9
Date: Sat, 21 Jun 2025 10:43:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Zhu Yanjun" <yanjun.zhu@linux.dev>, "Arnd Bergmann" <arnd@kernel.org>,
 "Bernard Metzler" <bmt@zurich.ibm.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Leon Romanovsky" <leon@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Potnuri Bharat Teja" <bharat@chelsio.com>,
 "Showrya M N" <showrya@chelsio.com>, "Eric Biggers" <ebiggers@google.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <ca2eaa50-c3ed-491d-ab38-65a7c1dc2820@app.fastmail.com>
In-Reply-To: <2d04fee6-5d95-4c50-b2b1-ee67f42932e2@linux.dev>
References: <20250620114332.4072051-1-arnd@kernel.org>
 <2d04fee6-5d95-4c50-b2b1-ee67f42932e2@linux.dev>
Subject: Re: [PATCH] RDMA/siw: work around clang stack size warning
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025, at 06:12, Zhu Yanjun wrote:
> =E5=9C=A8 2025/6/20 4:43, Arnd Bergmann =E5=86=99=E9=81=93:
>
> Because the array of kvec structures in siw_tx_hdt consumes the majori=
ty=20
> of the stack space, would it be possible to use kmalloc or a similar=20
> dynamic memory allocation function instead of allocating this memory o=
n=20
> the stack?
>
> Would using kmalloc (or an equivalent) also effectively resolve the=20
> stack usage issue?

Yes, moving the allocation somewhere else (kmalloc, static variable,
per siw_sge, per siw_wqe) would avoid the high stack usage effectively,
it's a tradeoff and I picked the solution that made the most sense
to me, but there is a good chance another alternative is better here.

The main differences are:

- kmalloc() adds runtime overhead that may be expensive in a
  fast path

- kmalloc() can fail, which adds complexity from error handling.
  Note that small allocations with GFP_KERNEL do not fail but instead
  wait for memory to become available

- If kmalloc() runs into a low-memory situation, it can go through
  writeback, which in turn can use more stack space than the
  on-stack allocation it was replacing

- static allocations bloat the kernel image and require locking that
  may be expensive

- per-object preallocations can be wasteful if a lot of objects
  are created, and can still require locking if the object is used
  from multiple threads

As I wrote, I mainly picked the 'noinline_for_stack' approach
here since that is how the code is known to work with gcc, so
there is little risk of my patch causing problems.

Moving the both the kvec array and the page array into
the siw_wqe is likely better here, I'm not familiar enough
with the driver to tell whether that is an overall improvement.

A related change I would like to see is to remove the
kmap_local_page() in this driver and instead make it
depend on 64BIT or !CONFIG_HIGHMEM, to slowly chip away
at the code that is highmem aware throughout the kernel.
I'm not sure if that that would also help drop the array
here.

     Arnd

