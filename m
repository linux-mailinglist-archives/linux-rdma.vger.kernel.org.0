Return-Path: <linux-rdma+bounces-9841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7FA9E7FF
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 08:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B607A58BC
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18A1B422A;
	Mon, 28 Apr 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HBDpWJnz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA919F120
	for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745820634; cv=none; b=LTDGEcJPOkQ9m7nRFL30h1My3DeI6ne/uAQ5CXZNIwWOCITEiVPMovouh1hfVrPg0yCvERGDsT2FVXGJ8jVUPUCyqqmd5WUGqz2/zO9yHAztwC0F2Jsyh5d5/Re/Eb51c8Pw+tdnKx0WJGIToFU7btkKy5B98Y3If1+6DMxbN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745820634; c=relaxed/simple;
	bh=zRq3rv+wVr/Yfb96CGYUhuAf6Baacx7aNhuBm3I3Esw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRjG2evK8wbNqbM9cZTozs1jPWjoxBBu4/vQuCMhpmSH7mpvcwZXw0oZXNzCWcaOHzasvD/zimE2n6AVjoOe0L2n/i9y7efTX7E/UmmJc5wIdTsqlbWQR57fy4+A2wA7OGvESr5Ittd6j3BYTQh/XxERtpeENcTwLwLQFmLMF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HBDpWJnz; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d21d80b-db20-4f00-bff0-147716693baf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745820619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCLCWvK9hdEXP9vwBpzf+o2i8WrHmJy0vm18h0TrVxY=;
	b=HBDpWJnzUtV7KaME04pnMTPpRnArISvJZtnnx99IFGUV4n6WjmX/BOrGWo4ph7P6DK8ZIM
	bWKuK1Ohpp/sf10ZVgZ+r9+0lB4jtrjsN5S0NjyqcMgePd+rpU7ZIzAK8BTkvvHnjh6VVp
	4T0ioagxnm7FAljXrfi7bKayaNoFiqk=
Date: Mon, 28 Apr 2025 08:10:17 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] svcrdma: Unregister the device if svc_rdma_accept() fails
To: cel@kernel.org, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250427163959.5126-1-cel@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250427163959.5126-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/27 18:39, cel@kernel.org 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> To handle device removal, svc_rdma_accept() registers an interest in
                                                            ^^^^^^^^ 
interface?

Except that, looks good to me.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> the underlying device when accepting a connection. However
> svc_rdma_free() is not invoked if svc_rdma_accept() fails. There
> needs to be a matching "unregister" in that case; otherwise the
> device cannot be removed.
> 
> Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM event handler")
> X-Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/svc_rdma_transport.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index aca8bdf65d72..5940a56023d1 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -575,6 +575,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>   	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
>   		ib_destroy_qp(newxprt->sc_qp);
>   	rdma_destroy_id(newxprt->sc_cm_id);
> +	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
>   	/* This call to put will destroy the transport */
>   	svc_xprt_put(&newxprt->sc_xprt);
>   	return NULL;


