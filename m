Return-Path: <linux-rdma+bounces-12645-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC88B1FB60
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 19:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F113B7AA88F
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C160267B89;
	Sun, 10 Aug 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d2oUyoKQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FBA1DF75D;
	Sun, 10 Aug 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754847138; cv=none; b=ArGbwk6YSrQ5Kz/OK3dux391g9iP+P6FXzVKsqGbyH1Z0vQbe06RnmIC+rUdIXKV97F92kereJ6BjibRA4hQCmv1Bwu8rVgWpk99fgQnmZ9/zYYGymj00N5s6VbKYiy/1xwCHZfejdEEpza9S1Ra8koXgt3IGfP3Vx25GMSOuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754847138; c=relaxed/simple;
	bh=TNmUQ437s7eOKUcfVKHyRc4T6i8CUtA4TWoV3ciCMN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0rOLnXihTN5awBnE0NYyWUNNyG+FGn2RHXiAR4UsA4GR37Q2F6S4TXoFngE8SUqPNW37kINlFNWgAUT76VujqtkHob83i2tnqd+dqbIzQ7kIABDxiEdCdZaXm80ZJyTuwPmr1VLfZT1Sht3lrKmFS/09/Q1S4TBU5lXKQvlSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d2oUyoKQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AYabts41ywViN3lH6/8mBeNV/CtbPocv9+f3715eNQI=; b=d2oUyoKQjAlkYYjzqabnE8JhdT
	A7TTg6U0iA88OIcQafOU1XXEa7mLYSBkx9mW/mO18DHVPMM4wb8xVIK2HJ5UxGPumcyTn6wtSKNTP
	vC31BdYHbtRZ9fLXSN9RO4ZV3zmx5opY7WgMLC/QEUbBmW+JibenOeqBB7AlwoAukX6I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ul9tr-004Eep-KM; Sun, 10 Aug 2025 19:32:03 +0200
Date: Sun, 10 Aug 2025 19:32:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <ac09739a-eec5-4025-989e-a6a202fcfd63@lunn.ch>
References: <20250810171155.3263-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810171155.3263-1-ujwal.kundur@gmail.com>

On Sun, Aug 10, 2025 at 10:41:55PM +0530, Ujwal Kundur wrote:
> Sparse reports the following warnings:
> 
> net/rds/af_rds.c:245:22: warning: invalid assignment: |=
> net/rds/af_rds.c:245:22: left side has type restricted __poll_t
> net/rds/af_rds.c:245:22: right side has type int
> 
> __poll_t is typedef'ed to __bitwise while POLLERR is defined as 0x0008,
> force conversion.

Please could you split this up, one patch per type of problem.

> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 086a13170e09..9cd5905d916a 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -242,7 +242,7 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
>  	if (rs->rs_snd_bytes < rds_sk_sndbuf(rs))
>  		mask |= (EPOLLOUT | EPOLLWRNORM);
>  	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
> -		mask |= POLLERR;
> +		mask |= (__force __poll_t)POLLERR;

I don't like __force, it suggests something is wrong with the
design. If it is needed, it should be hidden away.

However:

~/linux/net$ grep -r POLLERR
caif/caif_socket.c:	wake_up_interruptible_poll(sk_sleep(sk), EPOLLERR|EPOLLHUP);
caif/caif_socket.c:		mask |= EPOLLERR;
rds/af_rds.c:		mask |= POLLERR;
bluetooth/af_bluetooth.c:		mask |= EPOLLERR |
sctp/socket.c:		mask |= EPOLLERR |
vmw_vsock/af_vsock.c:		mask |= EPOLLERR;
vmw_vsock/af_vsock.c:				mask |= EPOLLERR;
vmw_vsock/af_vsock.c:					mask |= EPOLLERR;
9p/trans_fd.c:		return EPOLLERR;
9p/trans_fd.c:	if (n & (EPOLLERR | EPOLLHUP | EPOLLNVAL)) {
mptcp/protocol.c:		mask |= EPOLLERR;
core/datagram.c:	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
core/datagram.c:		mask |= EPOLLERR |
core/sock.c:		wake_up_interruptible_poll(&wq->wait, EPOLLERR);
nfc/llcp_sock.c:		mask |= EPOLLERR |
smc/af_smc.c:		else if (flags & EPOLLERR)
smc/af_smc.c:			mask |= EPOLLERR;
phonet/socket.c:		return EPOLLERR;
iucv/af_iucv.c:		mask |= EPOLLERR |
unix/af_unix.c:		mask |= EPOLLERR;
unix/af_unix.c:		mask |= EPOLLERR |
ipv4/tcp.c:		mask |= EPOLLERR;
sunrpc/rpc_pipe.c:		mask |= EPOLLERR | EPOLLHUP;
atm/common.c:		mask = EPOLLERR;

So why is af_rds.c special? Or do all these files also give the same
warning?

Also:

https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/eventpoll.h#L34

#define EPOLLERR	(__force __poll_t)0x00000008

So your patch does nothing.

    Andrew

---
pw-bot: cr

