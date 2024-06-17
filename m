Return-Path: <linux-rdma+bounces-3197-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D7490AB26
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D202852A0
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5E91946A7;
	Mon, 17 Jun 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L0zn0Uns"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A0190069
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620454; cv=none; b=Z9FAfUXmYEMCfKX7DWrWlsLjcfJWyn7yvOjegvgeLKwj4fGlmcOgNxKbL71Qj/sXvFU2Z41UYTEWO+T8aQge5lVD6/8dqvRQ8VsxFEcHArDIwU84i74WghhqK92dugKKiJGNcJC5HeXIESUaYXDgJENaHz5KQS9kmX/9HXYzE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620454; c=relaxed/simple;
	bh=NN/LB0iNyF5p+kAW7Oq5/02O/+o/KCvnyEWLGVqd5qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQj5v+9XXs5W2h+LrB5rlMZnBi2fYBZRvcjGR0VowLa9lodOD/AucwyDI04Sis0GgVcaTz2tzkE8YTLkmZnpxZL0JFcVeh5AH9lsBNDxZ6egGG/2ituD6COXjLHE31URfy9kGXwLmQxPuEr2SM/t1r7jdaSlF0GkxCZnD7S0BqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L0zn0Uns; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lihongfu@kylinos.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718620449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iGdIENTyDHyME+nFTGWO+3nQ6WZFYygsaPwHXuXkSU=;
	b=L0zn0UnsHEsGZxAMQaTatGqMp8CyargCRzVqGcZHIFzQHG6PyUgUiZuA3aMZepu1NdKYqR
	oXLn4BIu2lnZ0ljQdqRJ4imkaN16h3MsIDly6m6xylZDPoPey74BnVA5mHoydNie4zqkmX
	1T91UaDKhf7Un0TEsHkYnLp3TEi/dTc=
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: allison.henderson@oracle.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: rds-devel@oss.oracle.com
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <5a2cbc3e-bb37-4753-9c47-b196399ecf0a@linux.dev>
Date: Mon, 17 Jun 2024 18:34:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rds:Simplify the allocation of slab caches
To: Hongfu Li <lihongfu@kylinos.cn>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 allison.henderson@oracle.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20240617075435.110024-1-lihongfu@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240617075435.110024-1-lihongfu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/17 15:54, Hongfu Li 写道:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
> ---
>   net/rds/tcp.c      | 4 +---
>   net/rds/tcp_recv.c | 4 +---
>   2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index d8111ac83bb6..3dc6956f66f8 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -719,9 +719,7 @@ static int __init rds_tcp_init(void)
>   {
>   	int ret;
>   
> -	rds_tcp_conn_slab = kmem_cache_create("rds_tcp_connection",
> -					      sizeof(struct rds_tcp_connection),
> -					      0, 0, NULL);
> +	rds_tcp_conn_slab = KMEM_CACHE(rds_tcp_connection, 0);

KMEM_CACHE is declared as below:

/*
  * Please use this macro to create slab caches. Simply specify the
  * name of the structure and maybe some flags that are listed above.
  *
  * The alignment of the struct determines object alignment. If you
  * f.e. add ____cacheline_aligned_in_smp to the struct declaration
  * then the objects will be properly aligned in SMP configurations.
  */
#define KMEM_CACHE(__struct, __flags)                                   \
                 kmem_cache_create(#__struct, sizeof(struct __struct),   \
                         __alignof__(struct __struct), (__flags), NULL)

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Thanks a lot.

Zhu Yanjun

>   	if (!rds_tcp_conn_slab) {
>   		ret = -ENOMEM;
>   		goto out;
> diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
> index c00f04a1a534..7997a19d1da3 100644
> --- a/net/rds/tcp_recv.c
> +++ b/net/rds/tcp_recv.c
> @@ -337,9 +337,7 @@ void rds_tcp_data_ready(struct sock *sk)
>   
>   int rds_tcp_recv_init(void)
>   {
> -	rds_tcp_incoming_slab = kmem_cache_create("rds_tcp_incoming",
> -					sizeof(struct rds_tcp_incoming),
> -					0, 0, NULL);
> +	rds_tcp_incoming_slab = KMEM_CACHE(rds_tcp_incoming, 0);
>   	if (!rds_tcp_incoming_slab)
>   		return -ENOMEM;
>   	return 0;


