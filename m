Return-Path: <linux-rdma+bounces-8121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA86A45BB6
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CE67A9998
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A366E2459D4;
	Wed, 26 Feb 2025 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iTSGAAcQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a0zv25Vy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6097212FB0;
	Wed, 26 Feb 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565628; cv=none; b=OEJZGCLjaGP8jzVKer2x/0COGMFRAc00bRJAKznmkTIXJqEu98cfBjsfzYbHnwaIqaZyf0+j1LowOSqjPLCcJwI0O3l1BT1dA0HfA5bocZwRRdxQoKVzPNnCbs2I4SxpdDHGclzpKqckZhi/hQfjRpKo3FfoYlxlFbO2kXj262Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565628; c=relaxed/simple;
	bh=ibiAbM7U15d81SL+9NxE2cVChkopyMlETlRnbQEzLJ4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjawZMW1QJIvTNFbIuy26pGHkUHqzWqLu+hTiAXh7sgHmlnSl6Y72E1me74uci6bGtwM0k9PkrNc/w2qqc4kWsrH5M+gxMxp3QsjW2Zhz5oJ6bKoWfh/nLzpJ6oTpxmg3q9wKmK0+3hz3cxvEl18RotGCO8BZL0rKd7BEkH/ukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iTSGAAcQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a0zv25Vy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:27:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740565625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKDCuHoBotGYfLtjr4AigiHbn1F5VHyjfxr3ba2FbSk=;
	b=iTSGAAcQgUNMfXp2gfLmraOB0EER6og8UbOP04DUwDwSUP4m1Rk2hw4ca9H2XHUEQPLhz1
	zyf2vt8aeiEpjY8S19BuZlC9Px9P0s1MOs3NwLNxvJda+McmqJdZu4+0gbRprGVQxr/xib
	EQxu5rV8U52ooCUqbtsGlU8LoplaCVHd7zqWhK853HQN8weEbC2sDFnjZRe7nwZ6sAwaFp
	fq5gdm85MPQLP/1yS8Fd28LCVfNPyEMlwoT9voxWXkKCbOUrs625i0OKmiJhO7pxKm3mfA
	qXDXn7ckSikJww32ICRif+N8xVOQOG3oS2mZc07XgIjp+iqQ75OQbAyO5l7liw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740565625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKDCuHoBotGYfLtjr4AigiHbn1F5VHyjfxr3ba2FbSk=;
	b=a0zv25VyDv4YPbXuTuw8QlRnZSM+n0+dV3TEhjzD/o89/3ZQTdm25/9KDS2gGfqQIuGB6M
	yDq5QY/PLO0Tp/Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joe Damato <jdamato@fastly.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 0/2] page_pool: Convert stats to u64_stats_t.
Message-ID: <20250226102703.3F7Aa2oK@linutronix.de>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
 <Z7izmyDRvTmKpN4-@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z7izmyDRvTmKpN4-@LQ3V64L9R2>

On 2025-02-21 12:10:51 [-0500], Joe Damato wrote:
> On Fri, Feb 21, 2025 at 12:52:19PM +0100, Sebastian Andrzej Siewior wrote:
> > This is a follow-up on
> > 	https://lore.kernel.org/all/20250213093925.x_ggH1aj@linutronix.de/
> >=20
> > to convert the page_pool statistics to u64_stats_t to avoid u64 related
> > problems on 32bit architectures.
> > While looking over it, the comment for recycle_stat_inc() says that it
> > is safe to use in preemptible context.
>=20
> I wrote that comment because it's an increment of a per-cpu counter.
>=20
> The documentation in Documentation/core-api/this_cpu_ops.rst
> explains in more depth, but this_cpu_inc is safe to use without
> worrying about pre-emption and interrupts.

I don't argue that it is not safe to use in preemptible context. I am
just saying that it is not safe after the rework. If it is really used
like that, then it is no longer safe to do so (after the rework).

> > The 32bit update is split into two 32bit writes and if we get
> > preempted in the middle and another one makes an update then the
> > value gets inconsistent and the previous update can overwrite the
> > following. (Rare but still).
>=20
> Have you seen this? Can you show the generated assembly which
> suggests that this occurs? It would be helpful if you could show the
> before and after 32-bit assembly code.

=E2=80=A6

So there are two things:
First we have alloc_stat_inc(), which does
	#define alloc_stat_inc(pool, __stat)    (pool->alloc_stats.__stat++)

so on x86 32bit this turns into
|        addl    $1, 120(%ebx)   #, pool_15(D)->alloc_stats.fast
|        adcl    $0, 124(%ebx)   #, pool_15(D)->alloc_stats.fast

So the lower 4 byte are incremented before the higher 4 byte are.

recycle_stat_inc() is using this_cpu_inc() and performs a similar
update. On x86-32 it turns into
|         movl    836(%ebx), %eax # pool_15(D)->recycle_stats, s
|         pushf ; pop %edx        # flags
|         cli
|         movl    %fs:this_cpu_off, %ecx  # *_20,
|         addl    %ecx, %eax      #, _42
|         addl    $1, (%eax)      #, *_42
|         adcl    $0, 4(%eax)     #, *_42
|         testb   $2, %dh #, flags
|         je      .L508   #,
|         sti
|.L508:

so the update can be performed safely in preemptible context as the CPU
is determined within the IRQ-off section and so is the increment itself
performed. It updates always the local value belonging to the CPU.

Reading the values locally (on the CPU that is doing the update) is okay
but reading the value from a remote CPU while an update might be done
can result in reading the lower 4 bytes before the upper 4 bytes are
visible.
This can lead to an inconsistent value on 32bit which is likely
"corrected" on the next read.
Thus my initial question: Do we care? If so, I suggest to use u64_stats
like most of the networking stack. However if we do so, the update must
be performed with disabled-BH as I assume the updates are done in
softirq context. It must be avoided that one update preempts another.

Sebastian

