Return-Path: <linux-rdma+bounces-11722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF886AEB856
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 14:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FDA5683B9
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C33B2D9783;
	Fri, 27 Jun 2025 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hh//5ggT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8121DA5F;
	Fri, 27 Jun 2025 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751029188; cv=none; b=mbbHvdtpVnor+eyt2FEEHwUziEqcVl8UfHU9mwKqdTvW7Oz6mz/kxrSgZTR5Uu2xPkTiE1/CaJObB8JN2uWoFbGVjY9wy2iPGZsI87VfGWzB85bMrf0zOTFs85FsO56H7HlZfDHQjbSSrlY5PSCCTG+3tBd+HC72StQuWiVmI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751029188; c=relaxed/simple;
	bh=sxxrsQ5znIOR0zAZ9VFlPXrvegzb/RjwRIfKwJxWkgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ees12D8TuopFzVspuW+njdITthB8qsncrdxGPcCOX+XcIk8X9lGdo6O4/NJh930GGJ2Qz/ExJJVuDlNhM/Sv/WIqJfgqb7WRQ9O4kEBgtrKvvYzXBLG7KD0gOzcc1exqEHh8lI8ZgrrQK6nVB9inhAmUz5XXCu1yNV1fvQ/h56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hh//5ggT; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751029175; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=y1HmmioUmA1Hiu866s5sKEElL12eyROC1gMmhCxYxu4=;
	b=Hh//5ggTLAe5h6J/MPYVf+QvQSINvf7oLcgYRj2hltxmZpnBxMHn1+9BT+bGFotFLao73C/FCwL8pvzKsGRL5dw0SfnDh4vWtX5kbaYkrO6SbGYgQ8uZVmyzyGHz4uoS5PZqYWC5xF1+PiYuTDCbQnuERSMEReGMLAjGP5X7sb0=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WfX.dqD_1751029173 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Jun 2025 20:59:33 +0800
Date: Fri, 27 Jun 2025 20:59:33 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/9] net/smc: Drop nr_pages_max initialization
Message-ID: <20250627125933.GE10186@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
 <20250626-splice-drop-unused-v2-7-3268fac1af89@rbox.co>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626-splice-drop-unused-v2-7-3268fac1af89@rbox.co>

On 2025-06-26 10:33:40, Michal Luczaj wrote:
>splice_pipe_desc::nr_pages_max was initialized unnecessarily in
>commit b8d199451c99 ("net/smc: Allow virtually contiguous sndbufs or RMBs
>for SMC-R"). Struct's field is unused in this context.
>
>Remove the assignment. No functional change intended.
>
>Suggested-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> net/smc/smc_rx.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
>index e7f1134453ef40dd81a9574d6df4ead95acd8ae5..bbba5d4dc7eb0dbb31a9800023b0caab33e87842 100644
>--- a/net/smc/smc_rx.c
>+++ b/net/smc/smc_rx.c
>@@ -202,7 +202,6 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
> 			offset = 0;
> 		}
> 	}
>-	spd.nr_pages_max = nr_pages;
> 	spd.nr_pages = nr_pages;
> 	spd.pages = pages;
> 	spd.partial = partial;
>
>-- 
>2.49.0
>

