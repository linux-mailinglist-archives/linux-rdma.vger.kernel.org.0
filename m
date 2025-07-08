Return-Path: <linux-rdma+bounces-11955-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A3AFC291
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 08:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2064A3F13
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 06:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1421CC4B;
	Tue,  8 Jul 2025 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hr6GQU9T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCF215F56;
	Tue,  8 Jul 2025 06:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955589; cv=none; b=HTBJttwf+wdyxjQCw/w/MqYJzXPCXRryO9Jqw0uXdRovaZ/jiwp5W1hPNexmZB/FZOR2N2bNd0mDGJIWbgeQ+YqttpZyv40Y8qUW/rCqSM0uhrXlyG223SylyjbW+C7ZFPSkMoEqsUA0r/IOPgxKx7jIiOKrSlVnXVMF5+jVGpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955589; c=relaxed/simple;
	bh=XIIeIcrNCGILL2Ab7UwjlwIM9ikdUmDwyHs/41Fsd1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1hgyJENEUDk0ANGgD5t+pKjq711YTfIm1HWrDTr2HXIZ9wcndUP5acyR+Yp3/eH/ksF4TalX8dE9flwBCv8BwFZs0BIHz26Y3Eznrklk95MEVS64zIAgkJEJsz0sqnEF8sW/IhAxxb1rWoELrF5GM+elVBLh/zZ6WqqDhLqsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hr6GQU9T; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751955582; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=00a02p8/QV+KKKOcQ7ATmh6Gos9w2u8Zz/Q2jIXVIqg=;
	b=Hr6GQU9T8mE3kqtNWl2al8MQ5WdHWuIRaqiGUPSUSB06AfcsB+ih77fgX1SpaPtggaLI9L6aRWflHbQw+U6dpafZqhloQaFF67pqoIDESoXPDFNu3PO9d9txGGwU/OR4ZA2W/dT8c3bh1pd03urV4E31U8ZsIBukbsmK0RcTE98=
Received: from 30.221.117.203(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WiL4Hbh_1751955580 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:19:41 +0800
Message-ID: <670cf530-1b8f-4a65-8df8-7aec154b1e57@linux.alibaba.com>
Date: Tue, 8 Jul 2025 14:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/smc: convert timeouts to
 secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250707-netdev-secs-to-jiffies-part-2-v2-0-b7817036342f@linux.microsoft.com>
 <20250707-netdev-secs-to-jiffies-part-2-v2-1-b7817036342f@linux.microsoft.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250707-netdev-secs-to-jiffies-part-2-v2-1-b7817036342f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/7/8 06:03, Easwar Hariharan 写道:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  net/smc/af_smc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 8d56e4db63e041724f156aa3ab30bab745a15bad..bdbaad17f98012c10d0bbc721c80d4c5ae4fb220 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2735,8 +2735,7 @@ int smc_accept(struct socket *sock, struct socket *new_sock,
>  
>  	if (lsmc->sockopt_defer_accept && !(arg->flags & O_NONBLOCK)) {
>  		/* wait till data arrives on the socket */
> -		timeo = msecs_to_jiffies(lsmc->sockopt_defer_accept *
> -								MSEC_PER_SEC);
> +		timeo = secs_to_jiffies(lsmc->sockopt_defer_accept);
>  		if (smc_sk(nsk)->use_fallback) {
>  			struct sock *clcsk = smc_sk(nsk)->clcsock->sk;
>  
> 

LGTM.
Reviewed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

