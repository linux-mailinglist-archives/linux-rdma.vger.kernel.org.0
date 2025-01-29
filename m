Return-Path: <linux-rdma+bounces-7313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91398A223A2
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 19:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C18D3A48C0
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94B01E1027;
	Wed, 29 Jan 2025 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kw4kYcgw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3E12DD95
	for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174311; cv=none; b=lOklO3ITzxNZ2YRhLTmGSh3+jmoWnOnemL7GoKK0iehYIdrmncNGeRNtW2FRheZ4Tnm+8okBa4do2qEq4xguvex/hqB5cF6LOEXfo7SQGbn9Ax62yyZS4KoYuumrFmJqo0BCPs0eD/TaX1BY66tOusi00ijHHCV11UmaWlnHzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174311; c=relaxed/simple;
	bh=2VMCFHe6TAoYhSnRaaEs0vvVGkCPtU2pM0uj5QOsXvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjOV2OmNNUdEkmGHl7JgucNVWHnf8pXubPGzexyDK4EFhMJbXOpV4oD8Jtyc/WrACbXyG0Z1p+sP65yPXuzv3CB87s1GaDAZjQH3hz53pv/GHDayAOmyLcVFRU+wMmCWQvFPePDY7WzdQLoq6DG/nY9uoTxh6f6tRXjcZvoIgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kw4kYcgw; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <048daa22-fdc6-4f5f-9fa3-e023dc421aab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738174297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ucg1UGnTRUyjA0To+rmMuDRod1jYtDux4BwxrLAs2pk=;
	b=Kw4kYcgwqqzrmAM96zVrn9hAemk82VSaCvfn5VKrqogKUxEseNfBlthTM/EUJkPkc1c0kt
	3tq9nOZCg0sOlW1xuT5aov2/P7uv3mIL2pqnMNS+HsFN0t5nO+9+a5nR6hIQxu7CMR4irX
	rjgjr1/j34ZZ6JwNAjq0pIgPEPuu4RI=
Date: Wed, 29 Jan 2025 19:11:35 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] RDMA/rxe: consolidate code for calculating ICRC of
 packets
To: Eric Biggers <ebiggers@kernel.org>, linux-rdma@vger.kernel.org,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-kernel@vger.kernel.org
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-3-ebiggers@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250127223840.67280-3-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/1/27 23:38, Eric Biggers 写道:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since rxe_icrc_hdr() is always immediately followed by updating the CRC
> with the packet's payload, just rename it to rxe_icrc() and make it
> include the payload in the CRC, so it now handles the entire packet.
> 
> This is a refactor with no change in behavior.

In this commit, currently the entire packet are checked while the header 
is checked in the original source code.

Now it can work between RXE <----> RXE.
I am not sure whether RXE <---> MLX can work or not.

If it can work well, I am fine with this patch.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_icrc.c | 36 ++++++++++++----------------
>   1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
> index ee417a0bbbdca..c7b0b4673b959 100644
> --- a/drivers/infiniband/sw/rxe/rxe_icrc.c
> +++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
> @@ -60,26 +60,24 @@ static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
>   
>   	return icrc;
>   }
>   
>   /**
> - * rxe_icrc_hdr() - Compute the partial ICRC for the network and transport
> - *		  headers of a packet.
> + * rxe_icrc() - Compute the ICRC of a packet
>    * @skb: packet buffer
>    * @pkt: packet information
>    *
> - * Return: the partial ICRC
> + * Return: the ICRC
>    */
> -static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> +static u32 rxe_icrc(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   {
>   	unsigned int bth_offset = 0;
>   	struct iphdr *ip4h = NULL;
>   	struct ipv6hdr *ip6h = NULL;
>   	struct udphdr *udph;
>   	struct rxe_bth *bth;
>   	u32 crc;
> -	int length;
>   	int hdr_size = sizeof(struct udphdr) +
>   		(skb->protocol == htons(ETH_P_IP) ?
>   		sizeof(struct iphdr) : sizeof(struct ipv6hdr));
>   	/* pseudo header buffer size is calculate using ipv6 header size since
>   	 * it is bigger than ipv4
> @@ -118,17 +116,23 @@ static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   	bth = (struct rxe_bth *)&pshdr[bth_offset];
>   
>   	/* exclude bth.resv8a */
>   	bth->qpn |= cpu_to_be32(~BTH_QPN_MASK);
>   
> -	length = hdr_size + RXE_BTH_BYTES;
> -	crc = rxe_crc32(pkt->rxe, crc, pshdr, length);
> +	/* Update the CRC with the first part of the headers. */
> +	crc = rxe_crc32(pkt->rxe, crc, pshdr, hdr_size + RXE_BTH_BYTES);
>   
> -	/* And finish to compute the CRC on the remainder of the headers. */
> +	/* Update the CRC with the remainder of the headers. */
>   	crc = rxe_crc32(pkt->rxe, crc, pkt->hdr + RXE_BTH_BYTES,
>   			rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES);
> -	return crc;
> +
> +	/* Update the CRC with the payload. */
> +	crc = rxe_crc32(pkt->rxe, crc, payload_addr(pkt),
> +			payload_size(pkt) + bth_pad(pkt));
> +
> +	/* Invert the CRC and return it. */
> +	return ~crc;
>   }
>   
>   /**
>    * rxe_icrc_check() - Compute ICRC for a packet and compare to the ICRC
>    *		      delivered in the packet.
> @@ -146,18 +150,12 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   	 * descending order from the x^31 coefficient to the x^0 one.  When the
>   	 * result is interpreted as a 32-bit integer using the required reverse
>   	 * mapping between bits and polynomial coefficients, it's a __le32.
>   	 */
>   	__le32 *icrcp = (__le32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> -	u32 icrc;
>   
> -	icrc = rxe_icrc_hdr(skb, pkt);
> -	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
> -				payload_size(pkt) + bth_pad(pkt));
> -	icrc = ~icrc;
> -
> -	if (unlikely(icrc != le32_to_cpu(*icrcp)))
> +	if (unlikely(rxe_icrc(skb, pkt) != le32_to_cpu(*icrcp)))
>   		return -EINVAL;
>   
>   	return 0;
>   }
>   
> @@ -167,12 +165,8 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>    * @pkt: packet information
>    */
>   void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   {
>   	__le32 *icrcp = (__le32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> -	u32 icrc;
>   
> -	icrc = rxe_icrc_hdr(skb, pkt);
> -	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
> -				payload_size(pkt) + bth_pad(pkt));
> -	*icrcp = cpu_to_le32(~icrc);
> +	*icrcp = cpu_to_le32(rxe_icrc(skb, pkt));
>   }


