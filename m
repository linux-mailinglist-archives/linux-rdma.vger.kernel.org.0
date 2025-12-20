Return-Path: <linux-rdma+bounces-15112-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D279CD2692
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 04:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F1BD301B498
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 03:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933729B8D9;
	Sat, 20 Dec 2025 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UnGU7HCB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6C27F754
	for <linux-rdma@vger.kernel.org>; Sat, 20 Dec 2025 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766202725; cv=none; b=DzcDb9qKg3JvknoNvGwE+YMTfNCRNBon5pGBScWV+Wuhk1KQCY5kXPA2/dAFxp9AuZFHZE6xAcIe++UypryWZPy0aFShFDcV3+l8BHDenmQxCabRpRA0P6AMd6tD+N3rMXP/VRuf9EESMZSn8UGiJ2eMqyxq/DwERyb9grub/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766202725; c=relaxed/simple;
	bh=OwbHp0AbLWSXtOh2YPalZlSa2qLKhue0yTJYw57Gl28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXqRSCxj4W2wVhZ/R0LXgoGaeBx9pRBDXMYbhB/jNXaFzUvIFXIKemJqXXsfn8Hu5SXHhUyHhnEm2kFwOgtQHQW0Dt8Gj95qCuSi9EpLeSH8EcSWREefccvweS0L4y6iac+SNvH1g5rRElzt0NA+KywSAt1LO2lAuU1R8MPUIJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UnGU7HCB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ccc0635-7c0e-4a18-8469-9c5b6d9b268f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766202711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YmgFoa/sYdHKV9LZw+lYy5sZn0vDTnpqdQhf3UADQU=;
	b=UnGU7HCBraNr8WLWlbXUntWPSVqbGJn09SHZTiz1WTynG1HnEE4sFn2jvXS1emCrpsi/Oz
	tA+TJiCMbEuXZx6QwEPHQx5Dagu/fyiOD0zUoBwPeHk7PCGHWNZDW18VUmBAWisL40BT7A
	1uCZLi6HzfPOalExJ8Dz6K/CqylBaQg=
Date: Fri, 19 Dec 2025 19:51:37 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: let rxe_reclassify_recv_socket() call
 sk_owner_put()
To: Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, netdev@vger.kernel.org,
 linux-cifs@vger.kernel.org
References: <20251219140408.2300163-1-metze@samba.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251219140408.2300163-1-metze@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/19 6:04, Stefan Metzmacher 写道:
> On kernels build with CONFIG_PROVE_LOCKING, CONFIG_MODULES
> and CONFIG_DEBUG_LOCK_ALLOC 'rmmod rdma_rxe' is no longer
> possible.
> 
> For the global recv sockets rxe_net_exit() is where we
> call rxe_release_udp_tunnel-> udp_tunnel_sock_release(),
> which means the sockets are destroyed before 'rmmod rdma_rxe'
> finishes, so there's no need to protect against
> rxe_recv_slock_key and rxe_recv_sk_key disappearing
> while the sockets are still alive.
> 
> Fixes: 80a85a771deb ("RDMA/rxe: reclassify sockets in order to avoid false positives from lockdep")
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-cifs@vger.kernel.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>

Thanks a lot. IIRC, there is a similar commit for SIW driver. Thus, I am 
not sure if there is a similar problem in SIW driver or not.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_net.c | 32 +++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0195d361e5e3..0bd0902b11f7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -64,7 +64,39 @@ static inline void rxe_reclassify_recv_socket(struct socket *sock)
>   		break;
>   	default:
>   		WARN_ON_ONCE(1);
> +		return;
>   	}
> +	/*
> +	 * sock_lock_init_class_and_name() calls
> +	 * sk_owner_set(sk, THIS_MODULE); in order
> +	 * to make sure the referenced global
> +	 * variables rxe_recv_slock_key and
> +	 * rxe_recv_sk_key are not removed
> +	 * before the socket is closed.
> +	 *
> +	 * However this prevents rxe_net_exit()
> +	 * from being called and 'rmmod rdma_rxe'
> +	 * is refused because of the references.
> +	 *
> +	 * For the global sockets in recv_sockets,
> +	 * we are sure that rxe_net_exit() will call
> +	 * rxe_release_udp_tunnel -> udp_tunnel_sock_release.
> +	 *
> +	 * So we don't need the additional reference to
> +	 * our own (THIS_MODULE).
> +	 */
> +	sk_owner_put(sk);
> +	/*
> +	 * We also call sk_owner_clear() otherwise
> +	 * sk_owner_put(sk) in sk_prot_free will
> +	 * fail, which is called via
> +	 * sk_free -> __sk_free -> sk_destruct
> +	 * and sk_destruct calls __sk_destruct
> +	 * directly or via call_rcu()
> +	 * so sk_prot_free() might be called
> +	 * after rxe_net_exit().
> +	 */
> +	sk_owner_clear(sk);
>   #endif /* CONFIG_DEBUG_LOCK_ALLOC */
>   }
>   


