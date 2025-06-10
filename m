Return-Path: <linux-rdma+bounces-11128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97205AD3398
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 12:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E661894F14
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 10:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC528C5DF;
	Tue, 10 Jun 2025 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iOcb0tne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gg7p3Un6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B32857FB;
	Tue, 10 Jun 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551521; cv=none; b=N44ncUL6bgJqzf8B+yqMq7JBgm4y5GFPWfieq2/Rw5/Mmbkh9+7c5dEb+UCt7DFlJnt/12rilalvBIzIqD5B8P+Jo22vm0DlzMBbQYTBmjf/lolkWbJUkC6JazA7GgiGfGhi2g9h7JbDWwmxMDP3o55bhDy+F0zyoxmrmLGrBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551521; c=relaxed/simple;
	bh=9WK7hSDYtTBGiOmSCM+/Xokg8AgTOORRT28XK5CYneQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mjuj+Me1F+Qma8WEzp7NbVaziis5A+dODPu29fGtiIKdiETf3ODloKkGoJIKEMePL/rZGpQYgczpf+SZYvFmmgMs1Eqk9VydefAQn4AyhSsjXDNXqRR0Frp4zaO7OH1NFKl4ckkU+WulsWCk+dqzkzcPsyj51FR2RcMX3ZIq7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iOcb0tne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gg7p3Un6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 765CF25400E4;
	Tue, 10 Jun 2025 06:31:57 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 10 Jun 2025 06:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749551517;
	 x=1749637917; bh=wvswSfv94DZADgU8nnOAXvu3wXaGJW1Tu/yPF6mrszk=; b=
	iOcb0tneymz5Y7HrfWoOZ+X83sULhSkfN34CBdaYH1F3VeifOhERS9GN75pbPv+Y
	ImJICaa9RLLC7qX00QiB9kDrTLgT9biVYzw/BPlB65vRcnG8i5q+Bk//DnE+QYe6
	o2Dwaeemejf7FyXrUD+uKIkDAUchLSD1QMg9RICDLuxOR5nyV/gkCuf6ZG1hSche
	0J4S4s7tDr+JyjnUJd6GoSOjviYt8xVv5oHWTMKm14LDCVPlZs2TdrwLlMYBzkLi
	HJh/+/GrZ2Gj47mI/eeQ07H8AmX5+oZnK1P9p1c1HpTZokB2j99gDQmzeh/fLcS8
	ds+c0HmxqnaX8DI0/6k2og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749551517; x=
	1749637917; bh=wvswSfv94DZADgU8nnOAXvu3wXaGJW1Tu/yPF6mrszk=; b=g
	g7p3Un6QMhi+hS9sLYX+9CDBOjxBcIricwfThhGBhKZN3m9heBr13tRrTYSb133M
	x0uWnczRKg4FLjJVh1UHSUKnK3UIrlT4HdG3R24StB0VaglPDjs0iadHaOnPmL0a
	HBBCRr/TgDPqU9oODIDxqT1JCQhO0x75SgbJ3iBh6F6XIo91iunmxzG+tedKphNT
	FBzgvE68Qj99l8XNSsivJCGrOsrTLItPrKdIMri9QW1u6264Pdb5TksX+LTsJEVd
	Nra+s/JLIp6kTMWSsTTAhlURwYAg969IOPvkE/PKz/BuuJrbI4f/tx0ILKiMmzjW
	qYJs6+5rGOFNJbeDeLMPA==
X-ME-Sender: <xms:nAlIaJTJa3NuimZYGJ0bUpXnTb2wgCWEkI_uyrhvgCSKoGit_rngqw>
    <xme:nAlIaCzoZXBJTBh8nv6RpTtbfGCwc2Yo5KOmAgrK-InlWcn4saymVunIkCXpwcYDK
    WZmxOqHOsxvk9XuEcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghgiihonhgvshesghhoohhglh
    gvmhgrihhlrdgtohhmpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtohhmpdhr
    tghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghmvghiohhhrghssehnvhhiughirgdrtgho
    mhdprhgtphhtthhopehphhgruggurggusehnvhhiughirgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhrughmrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:nAlIaO2665F3QoSPFaIij7mAzQ8-XikMfQ8HGYXyTKYhy1eL3XolEQ>
    <xmx:nAlIaBDxrgjEVcf6_JGkSeNMd8fUv6HeKdwD5Lrn8uLrTW4d69PM5g>
    <xmx:nAlIaCjIFDYHhuSiTqwG_5ZM5KNpmfdw2PaWi9QNVhXeQEo1IHq8lQ>
    <xmx:nAlIaFrFc2ieTwTF4McdinPG9VFpJcPbMisTrxBmhFFq_akUAyUm4g>
    <xmx:nQlIaHqsrX3iXag_QJklPD_lGO1Wtp-BwaY6UzWNRt_wPL4e0ufoFMH3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 469A3700063; Tue, 10 Jun 2025 06:31:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4e66028a7d26eeea
Date: Tue, 10 Jun 2025 12:31:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Patrisious Haddad" <phaddad@nvidia.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Leon Romanovsky" <leon@kernel.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, "Chiara Meiohas" <cmeiohas@nvidia.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <a5c62d13-a8de-4efa-aa87-dfdf8a4e56bb@app.fastmail.com>
In-Reply-To: <fa916ae4-1ed3-4f90-8577-3666ff0fe84a@nvidia.com>
References: <20250610092846.2642535-1-arnd@kernel.org>
 <fa916ae4-1ed3-4f90-8577-3666ff0fe84a@nvidia.com>
Subject: Re: [PATCH] RDMA/mlx5: reduce stack usage in mlx5_ib_ufile_hw_cleanup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 10, 2025, at 11:50, Patrisious Haddad wrote:
> On 6/10/2025 12:28 PM, Arnd Bergmann wrote:

>>   void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
>>   {
>> -       struct mlx5_async_cmd async_cmd[MAX_ASYNC_CMDS];
>> +       struct mlx5_async_cmd *async_cmd;
> Please preserve reverse Christmas tree deceleration.
>>          struct ib_ucontext *ucontext = ufile->ucontext;
>>          struct ib_device *device = ucontext->device;
>>          struct mlx5_ib_dev *dev = to_mdev(device);
>> @@ -2678,6 +2678,10 @@ void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
>>          int head = 0;
>>          int tail = 0;
>>
>> +       async_cmd = kcalloc(MAX_ASYNC_CMDS, sizeof(*async_cmd), GFP_KERNEL);
>> +       if (WARN_ON(!async_cmd))
>> +               return;
>
> But honestly I'm not sure I like this, the whole point of this patch was 
> performance optimization for teardown flow, and this function is called 
> in a loop not even one time.
>
> So I'm really not sure about how much kcalloc can slow it down here, and 
> it failing is whole other issue.

Generally speaking, kcalloc is fairly quick and won't fail here,
but it can take some time under memory pressure if it ends up
in memory reclaim.

> I'm thinking out-loud here, but theoretically we know stack size and 
> this struct size at compile time , so can we should be able to add some 
> kind of ifdef check "if (stack_frame_size < struct_size)" skip this 
> function and maybe print some warning.
> (since it is purely optimization function and logically the code will 
> continue correctly without it - but if it needs to be executed then let 
> it stay like this and needs a big enough stack - which is most of today 
> systems anyway) ?

The thing I'm most interested here is the compile-time warning:
we currently have some configurations that have a very high warning
limit of 2048 bytes or even unlimited, which means that a number
of functions that accidentally use too much stack space (either from
a compiler misoptimization or a programmer error) are missed and
can end up causing problems later. I posted this patch as part of
a larger work to eventually reduce the default warning limit
for those corner cases.

The risk in this particular function to actually overflow is fairly
low since it gets called from sys_close() or __fput(), which
are not nested deeply. I can think of a couple of other ways to
keep your fast path and also build cleanly with a lower warning
limit.

- check which exact configurations actually trigger the high stack
  usage and then skip the optimization in those cases. The most
  likely causes are CONFIG_KASAN_STACK and CONFIG_KMSAN, both
  of which already make the kernel a lot slower.

- reduce MAX_ASYNC_CMDS to always stay under the warning limit, either
  picking a lower value unconditionally, or based on the Kconfig
  options that trigger it

- preallocate the array as part of an existing structure, whichever
  makes sense here (mlx5_ib_dev maybe?).

- reorganize the code in some other form to have the stack not
  blow the warning limit. As far as I can tell, I only see this
  particular one with clang but not gcc, and that often means
  it happens because of some particular inlining decisions that
  clang takes, and we can force them by adding strategic
  __always_inline or noinline annotations that make both compilers
  do the same thing.

      Arnd

