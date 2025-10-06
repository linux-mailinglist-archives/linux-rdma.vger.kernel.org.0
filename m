Return-Path: <linux-rdma+bounces-13785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75309BBDF1B
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303F83BA8D4
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 11:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E317E4;
	Mon,  6 Oct 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qhMhXeJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B76/Ywx9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3E276049;
	Mon,  6 Oct 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751944; cv=none; b=ZLAgpu/du3/Kljx9O+L31PuxZzJKvASGvK8JZvnonPLtoF2OEZxBZOCIZbd/Ts+I5IAWaKJfG4bjsLVmvlmjKhysMBzdUcUPYLv5epY3pdK20ZMXTa33vDLsalJL3B8FELUoHJBogMy0kiZbpTPxuJwdgKDq1w0wcEMtA5CC9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751944; c=relaxed/simple;
	bh=vtj7u1PPyXg2zYDgNyYCdqqkCdW2GE7U6pgTcOk1lpY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EbvvjFeYXO9kw1x9w+iRuNPqGbQ+lgiL73aEToav5tJoTxe1V5g+FUqlI7LekZ7Lit6KY2ijzO7U9os5W/GDnZKWPcw12P2V2NzVlfJjksmj0e/QPcUn79TxGCDUixDgAZht8APyDGHw4xPDsX3tLmRe5bdtUsjGi+dl/zrVu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qhMhXeJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B76/Ywx9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 039E514000E2;
	Mon,  6 Oct 2025 07:59:02 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 06 Oct 2025 07:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759751942;
	 x=1759838342; bh=7GQ/0jR0gVdoLEQuuwM/Hs1zQEnI3s78mUUBE3R9tUM=; b=
	qhMhXeJkK0ZAsD8fQDGc9FkqBOdXuWYRz1JK0xf20I4m8zCP6yT4cHe6eiG+84zZ
	cJCFYYa7AJux2umtoU1iLS817iOgJYfby79rTIDeTuhj4id2EVjaHlj3O1oSn9xl
	JRufo260ZpCRun9DtA3wLjw+PTY57h6mY8oE8iEF9gQRB6B+4kI9e2qXa7i7PTKr
	n3r8e5ed+/HWyqSybNNiXxF7yu0a1kjVww4+d3zC8SqhBErxFuJtauZPMWwuOl+i
	qr9GOE1jsLW7upa8hXJT/EbRT8darbErd4x3bXzqJHGQU42NiR165Jjt6+jGYyK/
	NygIlALHsVC17dqMTDa3lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759751942; x=
	1759838342; bh=7GQ/0jR0gVdoLEQuuwM/Hs1zQEnI3s78mUUBE3R9tUM=; b=B
	76/Ywx9vbXjDjujzUcyhVWlQsYtwTAcOOGqpU1mFDCW9V5C6sUawSoYQlsCoVtgL
	C6wZ0lQd0fQca7BHIjvhBmSG3NWQslmNdruZ7pKIYs9lrDefQ0Mbt+cWHR/mQbkW
	Y2bNJcuzRXAbF41RqL0tAFwNCNZU6HewB0gGXAdf4OPIqLc8JLn/VmrM9uBWov1+
	p5DmYWIU/8PBsqOiSTKwrY7Xr58rluhEWeKgifUv8ujqGVHOZLjQ8bJOo1djywL/
	Figu72Xmtrwqj/ZzF5S+61uCsM55n3xyokp7LQZgyzxJ7ZbecLWFju/0I/mqy9nF
	RdQKng5NtssSajknVV/DA==
X-ME-Sender: <xms:Ba_jaEfGweUCEwN3MH9DoD4rXHqUcGIMIKY0UFGVRyI43VB3fwoeSA>
    <xme:Ba_jaBAKqCIEh2FrkI6Rx4soK0iddDYv5Kxnj7hFhAy03QtSJWKgn_uO-bqey-NY9
    -odQKcd38I7loLduSZJESt6NvHqwDdnmkcr_iwGQ0AknDPY-WjctbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefuddtfeeukefgteduieeiuedvjeelgfettddtiefhfeefhfefffelvefhveeileen
    ucffohhmrghinhepghhoohhglhgvshhouhhrtggvrdgtohhmpdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhn
    ugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgs
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrnhguvghrshdrrhhogigvlhhlsehlihhnrghrohdrohhrghdp
    rhgtphhtthhopegsvghnjhgrmhhinhdrtghophgvlhgrnhgusehlihhnrghrohdrohhrgh
    dprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrghdprhgt
    phhtthhopehnrghrvghshhdrkhgrmhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpth
    htoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhkfhhtqdhtrhhirghgvgeslhhishhtshdrlhhinhgrrh
    hordhorhhg
X-ME-Proxy: <xmx:Ba_jaKAGybnjVE-uWoUnRgJKlfqjmUKzRGjKe5q7nuLC4S_gzhkSwQ>
    <xmx:Ba_jaNQtNC8ngmUykBG9GqraoJJS2h74jGCmuEaZ-J-FY_CxmDAl6A>
    <xmx:Ba_jaMQac1xHqd8lsMQhNQm3ubOhUb9e6Pvi3vfNwtW0XA_CJZBaWg>
    <xmx:Ba_jaLIU2c2cSGXiBrkAGglM2IVJxfWblgLf2CqrhvL0QcX1LqRTvA>
    <xmx:Ba_jaO_bqHvRa8C_Gf8CDe9AB-0F0mHSrqoHkmY2exYkdtLoOdXjHIvZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 73FF3700065; Mon,  6 Oct 2025 07:59:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOEbzVvuXYlJ
Date: Mon, 06 Oct 2025 13:58:41 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 Netdev <netdev@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>, linux-rdma@vger.kernel.org
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Patrisious Haddad" <phaddad@nvidia.com>,
 "Michael Guralnik" <michaelgur@nvidia.com>,
 "Moshe Shemesh" <moshe@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Jakub Kicinski" <kuba@kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>,
 "Nathan Chancellor" <nathan@kernel.org>
Message-Id: <a2357b92-8a8a-4d79-afb8-0bb8aee244ac@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYt+9QZ4TwEx7+m2S5Vtn7cq1N54oGceSR72upZJTrzkng@mail.gmail.com>
References: 
 <CA+G9fYu-5gS0Z6+18qp1xdrYRtHXG_FeTV0hYEbhavuGe_jGQg@mail.gmail.com>
 <CA+G9fYt+9QZ4TwEx7+m2S5Vtn7cq1N54oGceSR72upZJTrzkng@mail.gmail.com>
Subject: Re: next-20251002: arm64: gcc-8-defconfig: Assembler messages: Error: unknown
 architectural extension `simd;'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 6, 2025, at 13:31, Naresh Kamboju wrote:
> + linux-rdma@vger.kernel.org
>
> On Mon, 6 Oct 2025 at 17:00, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>> ### Build error log
>> /tmp/cclfMnj9.s: Assembler messages:
>> /tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
>> make[8]: *** [scripts/Makefile.build:287:
>> drivers/net/ethernet/mellanox/mlx5/core/wc.o] Error 1
>>
>> Suspecting commit,
>> $ git blame -L 269 drivers/net/ethernet/mellanox/mlx5/core/wc.c
>> fd8c8216648cd8 (Patrisious Haddad 2025-09-29 00:08:08 +0300 269)
>>          (".arch_extension simd;\n\t"
>> fd8c8216648cd net/mlx5: Improve write-combining test reliability for
>> ARM64 Grace CPUs
>>
>> ## Source
>> * Kernel version: 6.17.0
>> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
>> * Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
>> * Architectures: arm64
>> * Toolchains: gcc-8
>> * Kconfigs: defconfig
>>

Nathan already analyzed the problem and suggested a fix, but I could
not find a patch on the mailing list so far and sent his suggestion
now. Please check

https://lore.kernel.org/all/20251006115640.497169-1-arnd@kernel.org/

    Arnd

