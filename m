Return-Path: <linux-rdma+bounces-5036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B697E1CB
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 15:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC53B20C44
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E0139D;
	Sun, 22 Sep 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Irk/UfnB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5537637;
	Sun, 22 Sep 2024 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727010999; cv=none; b=pmhPUazS9Zt7J+MvT/IjzjG607Kr0LjwX5cRqXhRs0O39hYCAk4pHQjytWaBgCMTwLm4J1bHs0GjXwa3dCt3Y6ClxpMSad1OOCSNFiFxaRMttRFNtkolc1Rw3s1Qfew5srqPNfSQi0Q/0fV9RdJre2XuHZfL1dntG0uw0hIhcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727010999; c=relaxed/simple;
	bh=3rRxgBShBqpcovq3vY/cbRQuMcbMgN8wYzfCKoUgETc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUeG8QPJ9GeSYsAAWRevUhypyU4ivffRyPA9nX6nFxavTRG9HKaKTU+eOtVxMtzMuHQXSWcgaqHlh7iXYENxzPGZduswyvFaARNPyWkwnH9aq/x7KtvJJWw0OroEOruN5E/3WZyZr+PAqcdtT8Uvryywv8Bcm+lO6LbHxi9Cjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Irk/UfnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23012C4CEC3;
	Sun, 22 Sep 2024 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727010998;
	bh=3rRxgBShBqpcovq3vY/cbRQuMcbMgN8wYzfCKoUgETc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Irk/UfnBn6jTTFmkWa1K7ZeS+4/YWB2bCmxuN1B7ZVJjaodHUx5aFeM2ehw4DuxzX
	 b66W57SuuU7jqJa8j5lZiqkwHxV6rQrPUxovtTUFwA8cGYLkaPmtqtc1RzOa1sXNe2
	 tfMXAghm/WeLXreLVI59kwqR3Wj0xO/kfP35KdhSVKK/BsioPfZFm6SLhwKQKS4j8j
	 oHewziQjOaM/JwLiDQjfw9MVNft6DoB21oX7ltnQ/rVSi4zGoBODdHKuTMCpmTNip8
	 6hQAqjYOnKo8GZCFWZ7WBtEWoxOXDQKqvnCGjGVmdCNW3V/loH39rSJoGii63rnXW1
	 LKPS7udjAsubA==
Date: Sun, 22 Sep 2024 09:16:36 -0400
From: Sasha Levin <sashal@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alice Ryhl <aliceryhl@google.com>, Tariq Toukan <tariqt@nvidia.com>,
	linux-rdma@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Message-ID: <ZvAYtImQujuiHIVe@sashalap>
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
 <20240528-alice-mm-v7-2-78222c31b8f4@google.com>
 <Zu_CeRfMKyyt4E5O@sashalap>
 <de6cb179-b21f-4e2d-a329-da5c4a138878@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <de6cb179-b21f-4e2d-a329-da5c4a138878@app.fastmail.com>

On Sun, Sep 22, 2024 at 07:52:34AM +0000, Arnd Bergmann wrote:
>On Sun, Sep 22, 2024, at 07:08, Sasha Levin wrote:
>> On Tue, May 28, 2024 at 02:58:03PM +0000, Alice Ryhl wrote:
>>>From: Arnd Bergmann <arnd@arndb.de>
>>>
>>>Rust code needs to be able to access _copy_from_user and _copy_to_user
>>>so that it can skip the check_copy_size check in cases where the length
>>>is known at compile-time, mirroring the logic for when C code will skip
>>>check_copy_size. To do this, we ensure that exported versions of these
>>>methods are available when CONFIG_RUST is enabled.
>>>
>>>Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
>>>on x86 using the Android cuttlefish emulator.
>>
>> Hi folks,
>>
>> I've noticed a build failure using GCC 9.5.0 on arm64 allmodconfig
>> builds:
>>
>> In file included from ./arch/arm64/include/asm/preempt.h:6,
>>                   from ./include/linux/preempt.h:79,
>>                   from ./include/linux/alloc_tag.h:11,
>>                   from ./include/linux/percpu.h:5,
>>                   from ./include/linux/context_tracking_state.h:5,
>>                   from ./include/linux/hardirq.h:5,
>>                   from drivers/net/ethernet/mellanox/mlx4/cq.c:37:
>> In function 'check_copy_size',
>>      inlined from 'mlx4_init_user_cqes' at
>> ./include/linux/uaccess.h:203:7:
>> ./include/linux/thread_info.h:244:4: error: call to '__bad_copy_from'
>> declared with attribute error: copy source size is too small
>>    244 |    __bad_copy_from();
>>        |    ^~~~~~~~~~~~~~~~~
>> make[7]: *** [scripts/Makefile.build:244:
>> drivers/net/ethernet/mellanox/mlx4/cq.o] Error 1
>>
>> I do not have CONFIG_RUST enabled in those builds.
>>
>> I've bisected the issue (twice!) and bisection points to this patch
>> which landed upstream as 1f9a8286bc0c ("uaccess: always export
>> _copy_[from|to]_user with CONFIG_RUST").
>>
>> Reverting said commit on top of Linus's tree fixes the build breakage.
>
>Right, it seems we still need the fix I posted in
>
>https://lore.kernel.org/lkml/20230418114730.3674657-1-arnd@kernel.org/
>
>Tariq, should I resend this with your Reviewed-by, or can you
>apply it from the old version and make sure it finds its way
>into mainline and 6.11?

The patch above fixes the build issue for me, thanks!

-- 
Thanks,
Sasha

