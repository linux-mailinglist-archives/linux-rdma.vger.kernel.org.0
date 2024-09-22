Return-Path: <linux-rdma+bounces-5035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62C97E079
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 09:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1AE281540
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90CC19308E;
	Sun, 22 Sep 2024 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WTg4SCK7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ck9fR1vA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E71714DF;
	Sun, 22 Sep 2024 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726991608; cv=none; b=BXB/2dtCLHKOP0x9RBh4xCPipG0QFV2JRVfcklxlxuBYN+rCyfnKr10ORsPo8N4J9RRvz7BNUrmORINtrQoPokKQVbjU0dfd22Qz13YbN8MYGIFHoZmpC9gfeFH/Ovobk78jC0L8pDpQSlEvtvtbYHr79c9kP6amFJp3wCc5huk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726991608; c=relaxed/simple;
	bh=RnxEDmqYi58xxblh/2elLK2On8jjWvn31+HcyDQs2Tw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sWpfrrwW48KzwRe55/oMopc0+s90iT2FaV141Xp7U4XczDIKHUR5eKLVP6MkI7UopQwBMnOueHdnXHTP5WysAGpiekxvmG5dkOREFHbCJAg9RkMoh8jj0MNg5aDEtViIOzIUa99OhxOPLV/tSM4p2ph2L/kZBSVJpIrmfvgLjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WTg4SCK7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ck9fR1vA; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 23371138025D;
	Sun, 22 Sep 2024 03:53:25 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sun, 22 Sep 2024 03:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726991605;
	 x=1727078005; bh=QtaWawvvQ39ZGWhwZAM+wk43O+xWu43ctkOGufDANlo=; b=
	WTg4SCK7ZKahfqfM7lYYiEhNtnIT0IibS25Lmi3UMz0l+2y2dAGGeMnlK2t8QiVy
	EybR2vMJHg3SLiTlUlx5zTE2wE+pEwvVsOFZFVFiy5wZXRmZ9en7886qHfvcRYyE
	NccWP3g7D/QTiGby+/yywFDH77VWh3CgdGH2qF/G9I0LseT9xxPGDWqRRZPcLaKM
	z9kw4rOWEH+knInCrC/Tw65c4VNVgY/knK/v7RR4CDZ8dkqv6DwuA/MsEyDAwXfv
	ub+ysd6CjEJPvpwgiSAYEXoQy4yfwd14kdAeSJcfWw8Cg69AuddDnVU0qH5N6aGy
	TtiPUOyQ5LzlBKcePhlyyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1726991605; x=
	1727078005; bh=QtaWawvvQ39ZGWhwZAM+wk43O+xWu43ctkOGufDANlo=; b=c
	k9fR1vAujL8EsBM/M/jMAiGA9sgre59FmPS2yUud9KMxJV23y55+sL/YArc+CPIL
	nCZqYm++XJU+1WkpjRRCAYBiGDxI0DZh7dZl4MpGrakzyjP3RZ8G+uDvtlcumbZx
	nUyIc202eBe7enpc5rwLr8ZojRcEcnSl36yN0hkWpye+rxCdhG0yLtJMmdRmDDvx
	/F7WxqY5UlxgxFezlCIKYqSaGQPNmR5Cri/O67MMID88jgouh76zjhT+D96adPBK
	+zgg9yYiRk4jiAES0Mh4nYAbVYBzCjYHDVP447gh9Gqm/bj5TQx9U94u+XoDryDs
	yVIy4weu5Sm0D/3/fpgQA==
X-ME-Sender: <xms:88zvZswUEe2sIgNs0yt2yBoqQvSu0HGeqvenebB_of12vDntz6exHw>
    <xme:88zvZgQ_-6QUgvc1UjCL9PHzCytuckCD-jcSE1PsvhtFdRBakC7ckCPfm0qk4h-jq
    Vj5qL9dY2rRSNdO7KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeliedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeef
    keekleffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrrhhvvgesrghnughrohhiugdrtghomhdprhgtphhtthhopehmrggtohes
    rghnughrohhiugdrtghomhdprhgtphhtthhopehtkhhjohhssegrnhgurhhoihgurdgtoh
    hmpdhrtghpthhtohepkhgvvghstghoohhksegthhhrohhmihhumhdrohhrghdprhgtphht
    thhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhgvgidrghgrhi
    hnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:88zvZuXEp4Bhxe9GDs-ul9i_Z0tkpoiWXCY1dW3JxLluX97LKT9sdw>
    <xmx:88zvZqj_U-D4jl8Oj5nzSUNgzrUl4UTFUqMpDEn91ANnRScnkzGoCQ>
    <xmx:88zvZuCOmJbNoqqAo7D2V4q9w6INEpLlqhr-FAMWy-IMiNYx9KbuyA>
    <xmx:88zvZrKxuKaU8JX0j-NMpJeAVmsN5JaKtJbiAYljYofS5Jy9bJHPyg>
    <xmx:9czvZniffzmKKfYuyl9bawBoSXrPdUytsChDbU5Vu3BO6S47wQ4ODYSL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 867632220071; Sun, 22 Sep 2024 03:53:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 22 Sep 2024 07:52:34 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sasha Levin" <sashal@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Tariq Toukan" <tariqt@nvidia.com>, linux-rdma@vger.kernel.org
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Matthew Wilcox" <willy@infradead.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kees Cook" <keescook@chromium.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 "Todd Kjos" <tkjos@android.com>, "Martijn Coenen" <maco@android.com>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>
Message-Id: <de6cb179-b21f-4e2d-a329-da5c4a138878@app.fastmail.com>
In-Reply-To: <Zu_CeRfMKyyt4E5O@sashalap>
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
 <20240528-alice-mm-v7-2-78222c31b8f4@google.com> <Zu_CeRfMKyyt4E5O@sashalap>
Subject: Re: [PATCH v7 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 22, 2024, at 07:08, Sasha Levin wrote:
> On Tue, May 28, 2024 at 02:58:03PM +0000, Alice Ryhl wrote:
>>From: Arnd Bergmann <arnd@arndb.de>
>>
>>Rust code needs to be able to access _copy_from_user and _copy_to_user
>>so that it can skip the check_copy_size check in cases where the length
>>is known at compile-time, mirroring the logic for when C code will skip
>>check_copy_size. To do this, we ensure that exported versions of these
>>methods are available when CONFIG_RUST is enabled.
>>
>>Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
>>on x86 using the Android cuttlefish emulator.
>
> Hi folks,
>
> I've noticed a build failure using GCC 9.5.0 on arm64 allmodconfig
> builds:
>
> In file included from ./arch/arm64/include/asm/preempt.h:6,
>                   from ./include/linux/preempt.h:79,
>                   from ./include/linux/alloc_tag.h:11,
>                   from ./include/linux/percpu.h:5,
>                   from ./include/linux/context_tracking_state.h:5,
>                   from ./include/linux/hardirq.h:5,
>                   from drivers/net/ethernet/mellanox/mlx4/cq.c:37:
> In function 'check_copy_size',
>      inlined from 'mlx4_init_user_cqes' at 
> ./include/linux/uaccess.h:203:7:
> ./include/linux/thread_info.h:244:4: error: call to '__bad_copy_from' 
> declared with attribute error: copy source size is too small
>    244 |    __bad_copy_from();
>        |    ^~~~~~~~~~~~~~~~~
> make[7]: *** [scripts/Makefile.build:244: 
> drivers/net/ethernet/mellanox/mlx4/cq.o] Error 1
>
> I do not have CONFIG_RUST enabled in those builds.
>
> I've bisected the issue (twice!) and bisection points to this patch
> which landed upstream as 1f9a8286bc0c ("uaccess: always export
> _copy_[from|to]_user with CONFIG_RUST").
>
> Reverting said commit on top of Linus's tree fixes the build breakage.

Right, it seems we still need the fix I posted in

https://lore.kernel.org/lkml/20230418114730.3674657-1-arnd@kernel.org/

Tariq, should I resend this with your Reviewed-by, or can you
apply it from the old version and make sure it finds its way
into mainline and 6.11?

     Arnd

