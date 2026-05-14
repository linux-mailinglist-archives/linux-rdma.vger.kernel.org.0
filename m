Return-Path: <linux-rdma+bounces-20719-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNWrFkMCBmrFdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20719-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:11:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 144555451A2
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 838E2300A512
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05D387599;
	Thu, 14 May 2026 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D7Hwr1W0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166B388E6E
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778679; cv=none; b=DW8gj7VTWM3GDbv99/K1uFAFKSh/daTB+O8sPEqMRgEXUG/60Win2gfwlJq2BzcnesHaOmy0/+NzIpz42y9gxwvLnrJZ2ledq6gn/DorSGVbZAPybBSwry7FX3qCv+lAD0YECPshRP5y6KpLmWUMqOA4qpiGJMNfcQ1BGmJD+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778679; c=relaxed/simple;
	bh=UTOCUb1JGcBzNtQsa1tkPJAZSavZR/PofmdtDw7xtu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfeNetmfCHcAfBVlakwgns2MpyEeBNckLLE0V3bdyO2qXJS4aX4B6Iidz7u0HoCje9xm+C+ZXgyg6krkVmtWd2YEP92EhcwNz1uk22/aLomH0GE8XQfCZe/xEAI0w1Q7abaJ6PurV1RrqldC5Y0m60MkmrOQLoLesH6944ymgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D7Hwr1W0; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fcbc4f0c-7dfb-4e8f-9788-f8d6daa37149@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778778665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIcxyhXXo3yO/t/QiYN8PIIui2W6H7mKs63dyxdO5Ro=;
	b=D7Hwr1W08zRyrwvhM+UAqyQFxS5QIbLzFt2HWOniA41JvwGKpARP0HNg4odcOGjp/D+5Rc
	STUsLzjD1c749cnyaJahrlC2KkJ95KFazOGMNEYCVmX8OgmKOd9JPAz/a/FbBqo0vv197u
	aNt3AupwNRTaMOM9jKWpaSKILNejlds=
Date: Thu, 14 May 2026 19:10:54 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] RDMA/siw: reject MPA FPDU length underflow before
 signed receive math
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260513175325.2042630-1-michael.bommarito@gmail.com>
 <20260513175325.2042630-2-michael.bommarito@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260513175325.2042630-2-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 144555451A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20719-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On 13.05.2026 19:53, Michael Bommarito wrote:
> A malicious connected siw peer can send an iWARP FPDU whose MPA length
> field (c_hdr->mpa_len, 16 bit big-endian, peer-controlled) is smaller
> than the fixed DDP/RDMAP header for the announced opcode. Soft-iWARP
> parses the full header in siw_get_hdr() based on iwarp_pktinfo[opcode]
> .hdr_len, but never compares mpa_len against that header length.
> 
> siw_tcp_rx_data() then derives
> 
>      srx->fpdu_part_rem = be16_to_cpu(mpa_len) - fpdu_part_rcvd
>                           + MPA_HDR_SIZE;
> 
> where fpdu_part_rcvd equals iwarp_pktinfo[opcode].hdr_len at this
> point. For a tagged WRITE (hdr_len 16, MPA_HDR_SIZE 2) the smallest
> on-wire mpa_len of 0 yields fpdu_part_rem = -14, and any mpa_len below
> hdr_len - MPA_HDR_SIZE underflows to a negative int.
> 
> The signed value then flows into siw_proc_write()/siw_proc_rresp() as
> 
>      bytes = min(srx->fpdu_part_rem, srx->skb_new);
> 
> is handed to siw_check_mem() as an int len (whose interval check
> addr + len > mem->va + mem->len is satisfied for a valid base when
> len is negative), and reaches siw_rx_data() -> siw_rx_kva() /
> siw_rx_umem() -> skb_copy_bits() as a signed copy length. The header
> copy branch in skb_copy_bits() promotes that to size_t, producing a
> multi-gigabyte read.
> 
> KASAN under a KUnit harness that drives the real kernel TCP receive
> path -- a loopback AF_INET socketpair, the malformed FPDU written via
> kernel_sendmsg, sk_data_ready firing in softirq, tcp_read_sock
> dispatching to siw_tcp_rx_data -- reports:
> 
>      BUG: KASAN: use-after-free in skb_copy_bits+0x284/0x480
>      Read of size 4294967295 at addr ffff888...
>      Call Trace:
>       skb_copy_bits
>       siw_rx_kva
>       siw_rx_data
>       siw_check_mem
>       siw_proc_write
>       siw_tcp_rx_data
>       __tcp_read_sock
>       siw_qp_llp_data_ready
>       tcp_data_ready
>       tcp_data_queue
> 
> Add the missing invariant at the earliest point where the peer header
> is fully assembled. iwarp_pktinfo[*].hdr_len - MPA_HDR_SIZE is exactly
> the value the siw transmitter uses as the minimum mpa_len for each
> opcode (drivers/infiniband/sw/siw/siw_qp.c:33), so this matches the
> protocol contract. Out-of-range FPDUs terminate the connection with
> TERM_ERROR_LAYER_LLP / LLP_ETYPE_MPA / LLP_ECODE_FPDU_START -- which
> is RFC 5044 Section 8 error code 3 ("Marker and ULPDU Length fields
> do not agree on the start of an FPDU"), the correct framing-error
> class for this inconsistency.
> 
> Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> See cover letter for full root cause, series rationale, and test
> summary.  [2/2] adds the KUnit regression harness used to validate
> this fix.
> 
>   drivers/infiniband/sw/siw/siw_qp_rx.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
> index e8a88b378d51..34d03584160c 100644
> --- a/drivers/infiniband/sw/siw/siw_qp_rx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
> @@ -1081,6 +1081,21 @@ static int siw_get_hdr(struct siw_rx_stream *srx)
>   			return -EAGAIN;
>   	}
>   
> +	/*
> +	 * Peer-controlled mpa_len must not underflow srx->fpdu_part_rem
> +	 * in siw_tcp_rx_data(); a negative value flows as a signed copy
> +	 * length into siw_check_mem() and skb_copy_bits().
> +	 */

Excellent finding. This was an open gateway for all evil.


> +	if (unlikely(be16_to_cpu(c_hdr->mpa_len) + MPA_HDR_SIZE <
> +		     iwarp_pktinfo[opcode].hdr_len)) {
> +		pr_warn_ratelimited("siw: short mpa_len %u for opcode %u (hdr_len %u)\n",

I think we shall stay with 80 chars per line. So let's
wrap the above line.

Otherwise
Acked-by: Bernard Metzler <bernard.metzler@linux.dev>


> +				    be16_to_cpu(c_hdr->mpa_len), opcode,
> +				    iwarp_pktinfo[opcode].hdr_len);
> +		siw_init_terminate(rx_qp(srx), TERM_ERROR_LAYER_LLP,
> +				   LLP_ETYPE_MPA, LLP_ECODE_FPDU_START, 0);
> +		return -EINVAL;
> +	}
> +
>   	/*
>   	 * DDP/RDMAP header receive completed. Check if the current
>   	 * DDP segment starts a new RDMAP message or continues a previously


