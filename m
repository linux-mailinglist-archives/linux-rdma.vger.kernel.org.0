Return-Path: <linux-rdma+bounces-1355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF5877555
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 05:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4B5282638
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC517F6;
	Sun, 10 Mar 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y9elywXD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BD16FF58
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710046414; cv=none; b=NxzHrlv9LoSVAMv753nTKCd5NYfQ/QMic1b0vzZc8Z30l7e2gldtwgbGEWfPwlTwbCuqHwtiVvt+FBcA4Wp7YokElJfopz2+eRnOIqVu08XJ92KOip1s/Yv1LemWi7aeshyK4uZNLbJAfQTBYZNzneVQ733T7Mx15BhwiHfLkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710046414; c=relaxed/simple;
	bh=+M5/D3rA/Qm/pKCZPYWYSQSBNzUmBrlAdlHD3eIkNA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhJT9WiDDm+OjETZdcCn1hM+lqKZcADaGIH18hSCs7LCJUkzT4YBf9hmpJ1AZFefSKmCmZUA2rc515YmjPJxCKnr5NmLlQH0z1J8EmTCnI5nHJCkYUVAzezw1XPzm3P4FJXrUvSyIhwBenRs4AHlXrScuhMYvUaZ2ONkHarp8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y9elywXD; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d508574-c2b8-489b-a26d-71b1c36961cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710046409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MfpnvfCFCpDGN6RtbnA1IMFWuCTDp/YHUNDd+urhXvA=;
	b=Y9elywXDtnQ7uLAWp0rfk8mONQnZAu/7agWecQM5Gv2K4KTPbcYKM15DxzYmucCl5V84av
	m0rOdUylsJDu2i9diwUnOzmyuZv1K6kI2j4OojqmyoT+SWIiG6l4Dh0DOlYKe/YXQ112Uv
	NTCTStj7A5nv0mJ2Wpwtvsdl6xQXYcs=
Date: Sun, 10 Mar 2024 05:53:26 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of
 re-reading it
To: linke li <lilinke99@qq.com>
Cc: Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_32C3AEB0599DF0A0010A862439636CDA2707@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <tencent_32C3AEB0599DF0A0010A862439636CDA2707@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/3/9 13:27, linke li 写道:
> In siw_orqe_start_rx, the orqe's flag in the if condition is read using
> READ_ONCE, checked, and then re-read, voiding all guarantees of the
> checks. Reuse the value that was read by READ_ONCE to ensure the
> consistency of the flags throughout the function.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>   drivers/infiniband/sw/siw/siw_qp_rx.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
> index ed4fc39718b4..f5f69de56882 100644
> --- a/drivers/infiniband/sw/siw/siw_qp_rx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
> @@ -740,6 +740,7 @@ static int siw_orqe_start_rx(struct siw_qp *qp)
>   {
>   	struct siw_sqe *orqe;
>   	struct siw_wqe *wqe = NULL;
> +	u16 orqe_flags;
>   
>   	if (unlikely(!qp->attrs.orq_size))
>   		return -EPROTO;
> @@ -748,7 +749,8 @@ static int siw_orqe_start_rx(struct siw_qp *qp)
>   	smp_mb();
>   
>   	orqe = orq_get_current(qp);
> -	if (READ_ONCE(orqe->flags) & SIW_WQE_VALID) {

In this if test, READ_ONCE is needed to read orqe->flags. But in this 
commit, this READ_ONCE is moved to other places.

In a complicated environment, for example, this function is called many 
times at the same time and orqe->flags is changed at the same time, I am 
not sure if this will introduce risks or not.

if you need to ensure the consistency of the flags throughout the 
function, not sure if the following is better or not.

if (((orqe_flags=READ_ONCE(orqe->flags))) & SIW_WQE_VALID) {

Thanks,
Zhu Yanjun

> +	orqe_flags = READ_ONCE(orqe->flags);
> +	if (orqe_flags & SIW_WQE_VALID) {
>   		/* RRESP is a TAGGED RDMAP operation */
>   		wqe = rx_wqe(&qp->rx_tagged);
>   		wqe->sqe.id = orqe->id;
> @@ -756,7 +758,7 @@ static int siw_orqe_start_rx(struct siw_qp *qp)
>   		wqe->sqe.sge[0].laddr = orqe->sge[0].laddr;
>   		wqe->sqe.sge[0].lkey = orqe->sge[0].lkey;
>   		wqe->sqe.sge[0].length = orqe->sge[0].length;
> -		wqe->sqe.flags = orqe->flags;
> +		wqe->sqe.flags = orqe_flags;
>   		wqe->sqe.num_sge = 1;
>   		wqe->bytes = orqe->sge[0].length;
>   		wqe->processed = 0;


