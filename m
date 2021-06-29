Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8937F3B7935
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhF2USr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhF2USr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:18:47 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A9C061760
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:16:18 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s17so278960oij.0
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/od40hQAm+UQc2PNe7QEJF6inz5GD2/iU8cgLB9lG3g=;
        b=FFiWeTKDcWhK7FDLehALq2wjmnZRweC7va/EgOTSH6u9vnos/7L/2yMbhTAhFWthiE
         +PHnei2vDAh0+z1Lcbrhl2iHt36t8EUqXMNetH0Ydq1hpSUOJRuXhYvuG5lvjTkK0Qyu
         QMNn8MYVIzJq3St6XGs6Q0IKF3x7+1G4kxUsbS1W3NxhPQdPcCP4yM4JCdFovbHwBFQx
         CEA2weRFMpnNyEmn/9zoXbmWPr0fHKyLt007+nn/f5uhEdQApVAjNC9YkI4u/X6XTM3z
         nErDgYYkTxfiLFNIBxLdhHz0/cXkzrF40AG+WmLD54JkXB01N9+Pl8hdVVjyLNznpPU0
         wVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/od40hQAm+UQc2PNe7QEJF6inz5GD2/iU8cgLB9lG3g=;
        b=K85EQ/jXKcHkNnap3bTwF3NNFTTKFp+LhEoGvmdT0Q3iB3Lno52NH/+g06I8Z9T1Fx
         Q1+NiT1ntUZi/pZSXx0ienstgMAoFTTfQM/z3lefP/HYIB5S6DmpUirGgJ+0g/izKOym
         LVGcURR8Sf/zDzTxETQwGsEPkUq6aveBKkVWfGAwPD40scR21dk/AY8ToGHzwBZknpJ4
         L9AvRzkOy/HLm+oZL/AFDYuQyLMkhROfb+i5u+0o2FEzDIftmHYysqE2kfj083AJ+Xil
         yCkk9EgUKN2v+NpOF1YWO+kaCaoj6CifmPn4KMDdAMoFy02Pu7e4dUg0h8V5KhTUutQ8
         bMSw==
X-Gm-Message-State: AOAM531MJBCcbDiOIsLgm3tdacU7ioTRcaOL9nL5+5DFFhMvsczQroN7
        y1Pbr1NDKxomGzha5hIb3Z78PfPvn60=
X-Google-Smtp-Source: ABdhPJw8kHM1jVdgYA4Wdiq9cpfy3VlDPuKpH/a+BROBNqvfIfzsTO4/VEX0cOcKcsnoewDOfcVljg==
X-Received: by 2002:a05:6808:f10:: with SMTP id m16mr472221oiw.72.1624997777742;
        Tue, 29 Jun 2021 13:16:17 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85? (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id a76sm2047345oii.26.2021.06.29.13.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 13:16:17 -0700 (PDT)
Subject: Re: [PATCH 7/7] RDMA/rxe: Extend ICRC to support nonlinear skbs
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210629201412.28306-1-rpearsonhpe@gmail.com>
 <20210629201412.28306-8-rpearsonhpe@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <b2736253-e066-4148-66e5-2ae9601231b6@gmail.com>
Date:   Tue, 29 Jun 2021 15:16:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629201412.28306-8-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/29/21 3:14 PM, Bob Pearson wrote:
> Make ICRC calculations aware of potential non-linear skbs.
> This is a step towards getting rid of skb_linearize() and its
> extra data copy.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_icrc.c | 150 +++++++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_loc.h  |   4 +-
>  drivers/infiniband/sw/rxe/rxe_net.c  |   7 +-
>  drivers/infiniband/sw/rxe/rxe_recv.c |   2 +-
>  4 files changed, 103 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
> index f5ebd9d23d12..d730c76bbeae 100644
> --- a/drivers/infiniband/sw/rxe/rxe_icrc.c
> +++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
> @@ -63,97 +63,134 @@ static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *addr,
>  }
>  
>  /**
> - * rxe_icrc_hdr - Compute a partial ICRC for the IB transport headers.
> + * rxe_icrc_packet - Compute the ICRC for a packet
>   * @skb: packet buffer
>   * @pkt: packet information
> + * @icrcp: pointer to returned ICRC
>   *
> - * Returns the partial ICRC
> + * Support linear or nonlinear skbs with frags
> + *
> + * Returns ICRC in *icrcp and 0 if no error occurs
> + * else returns an error.
>   * For details see the InfiniBand Architecture spec and Annex 17
>   * the RoCE v2 spec.
>   */
> -static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> +static int rxe_icrc_packet(struct sk_buff *skb, struct rxe_pkt_info *pkt,
> +				__be32 *icrcp)
>  {
> +	struct skb_shared_info *info = skb_shinfo(skb);
> +	struct rxe_dev *rxe = pkt->rxe;
> +	struct iphdr *ip4h;
> +	struct ipv6hdr *ip6h;
>  	struct udphdr *udph;
>  	struct rxe_bth *bth;
> -	__be32 crc;
> -	int length;
> -	int hdr_size = sizeof(struct udphdr) +
> +	__be32 icrc;
> +	int hdr_size;
> +	u8 pseudo_hdr[128];
> +	int resid;
> +	int bytes;
> +	int nfrag;
> +	skb_frag_t *frag;
> +	u8 *addr;
> +	int page_offset;
> +	int start;
> +	int len;
> +	int ret;
> +
> +	hdr_size = rxe_opcode[pkt->opcode].length + sizeof(struct udphdr) +
>  		(skb->protocol == htons(ETH_P_IP) ?
> -		sizeof(struct iphdr) : sizeof(struct ipv6hdr));
> -	/* pseudo header buffer size is calculate using ipv6 header size since
> -	 * it is bigger than ipv4
> -	 */
> -	u8 pshdr[sizeof(struct udphdr) +
> -		sizeof(struct ipv6hdr) +
> -		RXE_BTH_BYTES];
> -
> -	/* This seed is the result of computing a CRC with a seed of
> -	 * 0xfffffff and 8 bytes of 0xff representing a masked LRH.
> -	 */
> -	crc = 0xdebb20e3;
> +			sizeof(struct iphdr) : sizeof(struct ipv6hdr));
>  
> -	if (skb->protocol == htons(ETH_P_IP)) { /* IPv4 */
> -		struct iphdr *ip4h;
> +	start = skb->network_header + skb->head - skb->data;
> +	ret = skb_copy_bits(skb, start, pseudo_hdr, hdr_size);
> +	if (unlikely(ret)) {
> +		pr_warn_ratelimited("Malformed skb\n");
> +		return ret;
> +	}
>  
> -		memcpy(pshdr, ip_hdr(skb), hdr_size);
> -		ip4h = (struct iphdr *)pshdr;
> +	if (skb->protocol == htons(ETH_P_IP)) { /* IPv4 */
> +		ip4h = (struct iphdr *)pseudo_hdr;
>  		udph = (struct udphdr *)(ip4h + 1);
> +		bth = (struct rxe_bth *)(udph + 1);
>  
>  		ip4h->ttl = 0xff;
>  		ip4h->check = CSUM_MANGLED_0;
>  		ip4h->tos = 0xff;
>  	} else {				/* IPv6 */
> -		struct ipv6hdr *ip6h;
> -
> -		memcpy(pshdr, ipv6_hdr(skb), hdr_size);
> -		ip6h = (struct ipv6hdr *)pshdr;
> +		ip6h = (struct ipv6hdr *)pseudo_hdr;
>  		udph = (struct udphdr *)(ip6h + 1);
> +		bth = (struct rxe_bth *)(udph + 1);
>  
> -		memset(ip6h->flow_lbl, 0xff, sizeof(ip6h->flow_lbl));
>  		ip6h->priority = 0xf;
>  		ip6h->hop_limit = 0xff;
>  	}
>  
>  	udph->check = CSUM_MANGLED_0;
> -
> -	bth = (struct rxe_bth *)(udph + 1);
> -	memcpy(bth, pkt->hdr, RXE_BTH_BYTES);
> -
> -	/* exclude bth.resv8a */
>  	bth->qpn |= cpu_to_be32(~BTH_QPN_MASK);
>  
> -	length = hdr_size + RXE_BTH_BYTES;
> -	crc = rxe_crc32(pkt->rxe, crc, pshdr, length);
> +	icrc = 0xdebb20e3;
> +	icrc = rxe_crc32(pkt->rxe, icrc, pseudo_hdr, hdr_size);
> +
> +	resid = (payload_size(pkt) + 0x3) & ~0x3;
> +	nfrag = -1;
> +
> +	while (resid) {
> +		if (nfrag < 0) {
> +			addr = skb_network_header(skb) + hdr_size;
> +			len = skb_tail_pointer(skb) - skb_network_header(skb);
> +		} else if (nfrag < info->nr_frags) {
> +			frag = &info->frags[nfrag];
> +			page_offset = frag->bv_offset + hdr_size;
> +			addr = kmap_atomic(frag->bv_page) + page_offset;
> +			len = frag->bv_len;
> +		} else {
> +			pr_warn_ratelimited("Malformed skb\n");
> +			return -EINVAL;
> +		}
> +
> +		bytes = len - hdr_size;
> +		if (bytes > 0) {
> +			if (bytes > resid)
> +				bytes = resid;
> +			icrc = rxe_crc32(rxe, icrc, addr, bytes);
> +			resid -= bytes;
> +			hdr_size = 0;
> +		} else {
> +			hdr_size -= len;
> +		}
> +
> +		if (nfrag++ >= 0)
> +			kunmap_atomic(addr);
> +	}
> +
> +	*icrcp = ~icrc;
>  
> -	/* And finish to compute the CRC on the remainder of the headers. */
> -	crc = rxe_crc32(pkt->rxe, crc, pkt->hdr + RXE_BTH_BYTES,
> -			rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES);
> -	return crc;
> +	return 0;
>  }
>  
>  /**
>   * rxe_check_icrc - Compute ICRC for a packet and compare to the ICRC
> - *		    delivered in the packet.
> - * @skb: packet buffer with packet info in cb[] (receive path)
> + *		    in the packet.
> + * @skb: packet buffer
> + * @pkt: packet information
>   *
>   * Returns 0 if the ICRCs match or an error on failure
>   */
> -int rxe_icrc_check(struct sk_buff *skb)
> +int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>  {
> -	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>  	__be32 *icrcp;
>  	__be32 packet_icrc;
> -	__be32 computed_icrc;
> +	__be32 icrc;
> +	int ret;
>  
>  	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
>  	packet_icrc = *icrcp;
>  
> -	computed_icrc = rxe_icrc_hdr(skb, pkt);
> -	computed_icrc = rxe_crc32(pkt->rxe, computed_icrc,
> -		(u8 *)payload_addr(pkt), payload_size(pkt) + bth_pad(pkt));
> -	computed_icrc = ~computed_icrc;
> +	ret = rxe_icrc_packet(skb, pkt, &icrc);
> +	if (unlikely(ret))
> +		return ret;
>  
> -	if (unlikely(computed_icrc != packet_icrc)) {
> +	if (unlikely(icrc != packet_icrc)) {
>  		if (skb->protocol == htons(ETH_P_IPV6))
>  			pr_warn_ratelimited("bad ICRC from %pI6c\n",
>  					    &ipv6_hdr(skb)->saddr);
> @@ -162,7 +199,6 @@ int rxe_icrc_check(struct sk_buff *skb)
>  					    &ip_hdr(skb)->saddr);
>  		else
>  			pr_warn_ratelimited("bad ICRC from unknown\n");
> -
>  		return -EINVAL;
>  	}
>  
> @@ -174,15 +210,19 @@ int rxe_icrc_check(struct sk_buff *skb)
>   *		       correct position after the payload and pad.
>   * @skb: packet buffer
>   * @pkt: packet information
> + *
> + * Returns 0 on success or an error
>   */
> -void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> +int rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>  {
>  	__be32 *icrcp;
> -	__be32 icrc;
> +	int ret;
>  
>  	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> -	icrc = rxe_icrc_hdr(skb, pkt);
> -	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
> -				payload_size(pkt) + bth_pad(pkt));
> -	*icrcp = ~icrc;
> +
> +	ret = rxe_icrc_packet(skb, pkt, icrcp);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	return 0;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index e8e87336469b..09836cdb1e89 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -194,8 +194,8 @@ int rxe_responder(void *arg);
>  
>  /* rxe_icrc.c */
>  int rxe_icrc_init(struct rxe_dev *rxe);
> -int rxe_icrc_check(struct sk_buff *skb);
> -void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt);
> +int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt);
> +int rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt);
>  
>  void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 4d109e5b33ff..d708ff19e774 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -434,8 +434,11 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>  		goto drop;
>  	}
>  
> -	if (rxe_must_generate_icrc)
> -		rxe_icrc_generate(skb, pkt);
> +	if (rxe_must_generate_icrc) {
> +		err = rxe_icrc_generate(skb, pkt);
> +		if (unlikely(err))
> +			goto drop;
> +	}
>  
>  	if (pkt->mask & RXE_LOOPBACK_MASK) {
>  		memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 01d425b3991e..7f51b9e92437 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -383,7 +383,7 @@ void rxe_rcv(struct sk_buff *skb)
>  		goto drop;
>  
>  	if (rxe_must_check_icrc) {
> -		err = rxe_icrc_check(skb);
> +		err = rxe_icrc_check(skb, pkt);
>  		if (unlikely(err))
>  			goto drop;
>  	}
> 
Please ignore. This was sent in error. Only patches 0-5 belong.
