Return-Path: <linux-rdma+bounces-7302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED14EA21A38
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 10:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43DD7A40B9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4AD1AC435;
	Wed, 29 Jan 2025 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rpTtz9Rd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69C1AB6D4
	for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738143892; cv=none; b=H0nAoGx2BAWHAC3u3e8LhOHaxWKtDITPxOPBzW1Jff38dqF5/DvgaPcuAEZEV9HLiyKhJ9CNdopIYCt1x6ipIrW7NADRuAyEk8mfhnqmlTfeSpCiP4mcWFu9/UkHL2bZhiShjKRhIxluHrqclaHXL7WNzjQ68s1tI7go1I6xfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738143892; c=relaxed/simple;
	bh=NB+mrkHlJYhqFgI/s7MtofvjWsYHDwldvB+bLx5OzGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Kq2g9K+/LFLi3Z9H8Pu65ke53BmFJDLkJDjc12/iaern2HSsQyrnVztT3OnfYN2PTGC4CMaWFbII+B6H1pMVxGDHqZv/Kty02xR9itIPQSyJEGIrM/hIodHjcHPCqSTDFGjNauHnuhlit8yFR29/G4nOiqASETvmb955oOT41Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rpTtz9Rd; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738143886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ospkZMJl+ewSlQifWEgGSZnKjzC1MKUrYCRJpX9WsCk=;
	b=rpTtz9RddFXBuO95TNVrfP0ib5jZPGUShPa8dMVCyzcJUvrI43QDngSOQ1I8Upx9CgiSEy
	pDlBjNEqcUBbSd78NXdQ6GFt1l5SMZi4685O2A5jJIcdfG+s3+W1z5hfHYML6tgHTY3rJE
	d9WO/qKH80CO9dSg7add2NG2WPonIR4=
Date: Wed, 29 Jan 2025 10:44:39 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] RDMA/rxe: handle ICRC correctly on big endian systems
To: Eric Biggers <ebiggers@kernel.org>, linux-rdma@vger.kernel.org,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Bernard Metzler <bmt@zurich.ibm.com>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20250127223840.67280-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/1/27 23:38, Eric Biggers 写道:
> From: Eric Biggers <ebiggers@google.com>
> 
> The usual big endian convention of InfiniBand does not apply to the
> ICRC field, whose transmission is specified in terms of the CRC32
> polynomial coefficients.  The coefficients are transmitted in
> descending order from the x^31 coefficient to the x^0 one.  When the
> result is interpreted as a 32-bit integer using the required reverse
> mapping between bits and polynomial coefficients, it's a __le32.
> 
> The code used __be32, but it did not actually do an endianness
> conversion.  So it actually just used the CPU's native endianness,
> making it comply with the spec on little endian systems only.
> 
> Fix the code to use __le32 and do the needed le32_to_cpu() and
> cpu_to_le32() so that it complies with the spec on big endian systems.
> 
> Also update the lower-level helper functions to use u32, as they are
> working with CPU native values.  This part does not change behavior.
> 
> Found through code review.  I don't know whether anyone is actually
> using this code on big endian systems.  Probably not.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

In this commit, the little endian is used instead of big endian in the 
rxe source code. To x86_64 architecture, I am fine with this commit.

To other big endian architecture, e.g. ppc/ppc64, I do not have such 
host, thus, I can not make tests on the big endian host.

Thanks,

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_icrc.c | 41 +++++++++++++++-------------
>   1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
> index fdf5f08cd8f17..ee417a0bbbdca 100644
> --- a/drivers/infiniband/sw/rxe/rxe_icrc.c
> +++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
> @@ -38,26 +38,26 @@ int rxe_icrc_init(struct rxe_dev *rxe)
>    * @next: starting address of current segment
>    * @len: length of current segment
>    *
>    * Return: the cumulative crc32 checksum
>    */
> -static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
> +static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
>   {
> -	__be32 icrc;
> +	u32 icrc;
>   	int err;
>   
>   	SHASH_DESC_ON_STACK(shash, rxe->tfm);
>   
>   	shash->tfm = rxe->tfm;
> -	*(__be32 *)shash_desc_ctx(shash) = crc;
> +	*(u32 *)shash_desc_ctx(shash) = crc;
>   	err = crypto_shash_update(shash, next, len);
>   	if (unlikely(err)) {
>   		rxe_dbg_dev(rxe, "failed crc calculation, err: %d\n", err);
> -		return (__force __be32)crc32_le((__force u32)crc, next, len);
> +		return crc32_le(crc, next, len);
>   	}
>   
> -	icrc = *(__be32 *)shash_desc_ctx(shash);
> +	icrc = *(u32 *)shash_desc_ctx(shash);
>   	barrier_data(shash_desc_ctx(shash));
>   
>   	return icrc;
>   }
>   
> @@ -67,18 +67,18 @@ static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
>    * @skb: packet buffer
>    * @pkt: packet information
>    *
>    * Return: the partial ICRC
>    */
> -static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> +static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   {
>   	unsigned int bth_offset = 0;
>   	struct iphdr *ip4h = NULL;
>   	struct ipv6hdr *ip6h = NULL;
>   	struct udphdr *udph;
>   	struct rxe_bth *bth;
> -	__be32 crc;
> +	u32 crc;
>   	int length;
>   	int hdr_size = sizeof(struct udphdr) +
>   		(skb->protocol == htons(ETH_P_IP) ?
>   		sizeof(struct iphdr) : sizeof(struct ipv6hdr));
>   	/* pseudo header buffer size is calculate using ipv6 header size since
> @@ -89,11 +89,11 @@ static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   		RXE_BTH_BYTES];
>   
>   	/* This seed is the result of computing a CRC with a seed of
>   	 * 0xfffffff and 8 bytes of 0xff representing a masked LRH.
>   	 */
> -	crc = (__force __be32)0xdebb20e3;
> +	crc = 0xdebb20e3;
>   
>   	if (skb->protocol == htons(ETH_P_IP)) { /* IPv4 */
>   		memcpy(pshdr, ip_hdr(skb), hdr_size);
>   		ip4h = (struct iphdr *)pshdr;
>   		udph = (struct udphdr *)(ip4h + 1);
> @@ -137,23 +137,27 @@ static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>    *
>    * Return: 0 if the values match else an error
>    */
>   int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   {
> -	__be32 *icrcp;
> -	__be32 pkt_icrc;
> -	__be32 icrc;
> -
> -	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> -	pkt_icrc = *icrcp;
> +	/*
> +	 * The usual big endian convention of InfiniBand does not apply to the
> +	 * ICRC field, whose transmission is specified in terms of the CRC32
> +	 * polynomial coefficients.  The coefficients are transmitted in
> +	 * descending order from the x^31 coefficient to the x^0 one.  When the
> +	 * result is interpreted as a 32-bit integer using the required reverse
> +	 * mapping between bits and polynomial coefficients, it's a __le32.
> +	 */
> +	__le32 *icrcp = (__le32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> +	u32 icrc;
>   
>   	icrc = rxe_icrc_hdr(skb, pkt);
>   	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
>   				payload_size(pkt) + bth_pad(pkt));
>   	icrc = ~icrc;
>   
> -	if (unlikely(icrc != pkt_icrc))
> +	if (unlikely(icrc != le32_to_cpu(*icrcp)))
>   		return -EINVAL;
>   
>   	return 0;
>   }
>   
> @@ -162,14 +166,13 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>    * @skb: packet buffer
>    * @pkt: packet information
>    */
>   void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   {
> -	__be32 *icrcp;
> -	__be32 icrc;
> +	__le32 *icrcp = (__le32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> +	u32 icrc;
>   
> -	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
>   	icrc = rxe_icrc_hdr(skb, pkt);
>   	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
>   				payload_size(pkt) + bth_pad(pkt));
> -	*icrcp = ~icrc;
> +	*icrcp = cpu_to_le32(~icrc);
>   }


