Return-Path: <linux-rdma+bounces-7315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41417A223D9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 19:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B261634D5
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEBD1E22FD;
	Wed, 29 Jan 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KMNg62Df"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA86D1E22E6
	for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175257; cv=none; b=LTf8YTYzdBzqwbaRsN8cRQCsbIEC4eOrAuurLtUw0/pKJQ1qj9H2i7kZWl1ExWu9hxuxjviJDRhdmUdNYYjn6BAV1kZ/QkWTHuG/aqE/cBekxzFn6IxodJ2DIee6GrJe/sSwIH7lTP9vM20jq28pEv6pimiRsM6vSPS4tJD9wkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175257; c=relaxed/simple;
	bh=SrflsmlL0ChiTFeT8MflcAtmU8DTpOMw98Tdz6kDa2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtbhzYZhRGCVGCeWpu13TW0t2grBHbcx/5rlkvZdgFCQrkinKle5nsuPPAsT43Zh4kYEzrfDhid7rlqVZrq5ACYAl2AAWy8s7V8wRDrJO/dgGTJ+zDX2+0VdTTdl8NXXnAFzYp2+ybrjnwwFnWurj1fo0h9B7c82mFGKuvLxuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KMNg62Df; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0d05601-0eee-4684-9ed0-d6da8938603b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738175243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuszRON8P8FWVqiJYlCZEXfuzBMBh/75nRHN6ub6BxI=;
	b=KMNg62Dfq0eqk6uv0YI8nGPHXnZzTfp8G4yv5uyZpRJCfVAwm+29YW5cHDC5BXpt5eXAm1
	+IAayxg5j0M480YymuvgmL1850PnWtuAgeTu0I7VE7MCF4SIfwewnt75nTADHIqPq/R2rn
	b3OcMGYgRUeDRCfdWWNVFm+sdsItw+0=
Date: Wed, 29 Jan 2025 19:27:20 +0100
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
Cc: linux-kernel@vger.kernel.org
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
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
In InfiniBand Architecture Specification, the following
"
The resulting bits are sent in order from the bit representing the 
coefficient of the highest term of the remainder polynomial. The least 
significant bit, most significant byte first ordering of the packet does 
not apply to the ICRC field.
"
and
"
The 32 Flip-Flops are initialized to 1 before every ICRC generation. The
packet is fed to the reference design of Figure 57 one bit at a time in 
the order specified in Section 7.8.1 on page 222. The Remainder is the 
bitwise NOT of the value stored at the 32 Flip-Flops after the last bit 
of the packet was clocked into the ICRC Generator. ICRC Field is 
obtained from the Remainder as shown in Figure 57. ICRC Field is 
transmitted using Big Endian byte ordering like every field of an 
InfiniBand packet.
"

It seems that big endian byte ordering is needed in ICRC field. I am not 
sure if MLX NIC can connect to RXE after this patchset is applied.

Thanks,
Zhu Yanjun

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


