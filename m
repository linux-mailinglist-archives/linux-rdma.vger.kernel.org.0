Return-Path: <linux-rdma+bounces-11510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC9AE2750
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 06:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E693BF192
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 04:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686921586C8;
	Sat, 21 Jun 2025 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bhJQytKc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEE54918
	for <linux-rdma@vger.kernel.org>; Sat, 21 Jun 2025 04:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750479195; cv=none; b=o3vS3qpc+CQMR9lkSwNWd1SOViOsb/nPW3la8E5nrwGRybO4SG5TrnCrgRfvpXNyIDiDx726lT8jlMhjDh3ucbC+kRuoshlJ1Au/rjzAbVlt9j+xLqvW6iX+udoGcP9+L0IGraTpxGda/maYN8A3Oomd6Q6hKK1OYwggxmrukPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750479195; c=relaxed/simple;
	bh=iNBqdvzRqvmlcLnFyD/xAgbAkKbUplPAdShitn7Qiow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHYlyTnmPSilQUUkpJi5FFkLnwQ+yLpTnxyn5nVUmtxvlx7z32PGlfHW8/Krb9W3SQqF8pnviD+tXVU1B3MaaeIvT0dqxx0pRIZcmrZ50pN+ZCt2LKBIxMspnkbvVIRaNyinP3zRGkA47SFNOROxluYXZ03CS3vVdio24iTaees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bhJQytKc; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d04fee6-5d95-4c50-b2b1-ee67f42932e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750479180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcR9MO+hlXNQyGNXtt8eel8mEQz/tmmVsCpo4bl1TuM=;
	b=bhJQytKcmXzZHfXkKScUGun4ArSRk5pFSwjbO7AGNiThQclcGPOq3XPM+KL7q78BpOIgUK
	CNaTy6mWdzeoS6+QWpkC1dSBUC+t57/HF+dCDjp/3kMjGG2pX7A9aBaqORPmKZp+Gfdf4/
	0wZk5mkoTqN2DirLqB3OSe9VNX7DvCY=
Date: Fri, 20 Jun 2025 21:12:40 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: work around clang stack size warning
To: Arnd Bergmann <arnd@kernel.org>, Bernard Metzler <bmt@zurich.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Showrya M N <showrya@chelsio.com>,
 Eric Biggers <ebiggers@google.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250620114332.4072051-1-arnd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250620114332.4072051-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/20 4:43, Arnd Bergmann 写道:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang inlines a lot of functions into siw_qp_sq_process(), with the
> aggregate stack frame blowing the warning limit in some configurations:
> 
> drivers/infiniband/sw/siw/siw_qp_tx.c:1014:5: error: stack frame size (1544) exceeds limit (1280) in 'siw_qp_sq_process' [-Werror,-Wframe-larger-than]
> 
> The real problem here is the array of kvec structures in siw_tx_hdt that
> makes up the majority of the consumed stack space.

Because the array of kvec structures in siw_tx_hdt consumes the majority 
of the stack space, would it be possible to use kmalloc or a similar 
dynamic memory allocation function instead of allocating this memory on 
the stack?

Would using kmalloc (or an equivalent) also effectively resolve the 
stack usage issue?
Please note that I’m not questioning the value of this commit—I’m simply 
curious whether there might be an alternative solution to the problem.

Thanks,
Yanjun.Zhu

> 
> Ideally there would be a way to avoid allocating the array on the
> stack, but that would require a larger rework. Add a noinline_for_stack
> annotation to avoid the warning for now, and make clang behave the same
> way as gcc here. The combined stack usage is still similar, but is spread
> over multiple functions now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/infiniband/sw/siw/siw_qp_tx.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
> index 6432bce7d083..3a08f57d2211 100644
> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> @@ -277,6 +277,15 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
>   	return PKT_FRAGMENTED;
>   }
>   
> +static noinline_for_stack int
> +siw_sendmsg(struct socket *sock, unsigned int msg_flags,
> +	    struct kvec *vec, size_t num, size_t len)
> +{
> +	struct msghdr msg = { .msg_flags = msg_flags };
> +
> +	return kernel_sendmsg(sock, &msg, vec, num, len);
> +}
> +
>   /*
>    * Send out one complete control type FPDU, or header of FPDU carrying
>    * data. Used for fixed sized packets like Read.Requests or zero length
> @@ -285,12 +294,11 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
>   static int siw_tx_ctrl(struct siw_iwarp_tx *c_tx, struct socket *s,
>   			      int flags)
>   {
> -	struct msghdr msg = { .msg_flags = flags };
>   	struct kvec iov = { .iov_base =
>   				    (char *)&c_tx->pkt.ctrl + c_tx->ctrl_sent,
>   			    .iov_len = c_tx->ctrl_len - c_tx->ctrl_sent };
>   
> -	int rv = kernel_sendmsg(s, &msg, &iov, 1, iov.iov_len);
> +	int rv = siw_sendmsg(s, flags, &iov, 1, iov.iov_len);
>   
>   	if (rv >= 0) {
>   		c_tx->ctrl_sent += rv;
> @@ -427,13 +435,13 @@ static void siw_unmap_pages(struct kvec *iov, unsigned long kmap_mask, int len)
>    * Write out iov referencing hdr, data and trailer of current FPDU.
>    * Update transmit state dependent on write return status
>    */
> -static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
> +static noinline_for_stack int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
> +					 struct socket *s)
>   {
>   	struct siw_wqe *wqe = &c_tx->wqe_active;
>   	struct siw_sge *sge = &wqe->sqe.sge[c_tx->sge_idx];
>   	struct kvec iov[MAX_ARRAY];
>   	struct page *page_array[MAX_ARRAY];
> -	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_EOR };
>   
>   	int seg = 0, do_crc = c_tx->do_crc, is_kva = 0, rv;
>   	unsigned int data_len = c_tx->bytes_unsent, hdr_len = 0, trl_len = 0,
> @@ -586,14 +594,16 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
>   		rv = siw_0copy_tx(s, page_array, &wqe->sqe.sge[c_tx->sge_idx],
>   				  c_tx->sge_off, data_len);
>   		if (rv == data_len) {
> -			rv = kernel_sendmsg(s, &msg, &iov[seg], 1, trl_len);
> +
> +			rv = siw_sendmsg(s, MSG_DONTWAIT | MSG_EOR, &iov[seg],
> +					 1, trl_len);
>   			if (rv > 0)
>   				rv += data_len;
>   			else
>   				rv = data_len;
>   		}
>   	} else {
> -		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
> +		rv = siw_sendmsg(s, MSG_DONTWAIT | MSG_EOR, iov, seg + 1,
>   				    hdr_len + data_len + trl_len);
>   		siw_unmap_pages(iov, kmap_mask, seg);
>   	}


