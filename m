Return-Path: <linux-rdma+bounces-18907-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM5dIoBYzWk5cAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18907-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 19:40:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D980C37EBEF
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 19:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E21B9300B869
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DA146AF3C;
	Wed,  1 Apr 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F+ZzMdg1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55B47DD4A
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065129; cv=none; b=B9eZac3+j5F+NkRnjF6uW2E6mzYuhvWINtBFJ9pFdruJHGECJgaAVlP8g407IqbvBD6HhkuwhhiqxhoVtXqnnK5bmsnjPDe3ZBZfvroxmtdb9/g5//9/Gh70xq+PbbVdY11UFhmGPQ71B1LeJagY5pcV2BG+moocBnXOmyx88WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065129; c=relaxed/simple;
	bh=gwHZfO/mOvP7CRg/an4tySknB3M2HrxrDkytjcnQyK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHq1Gp0PLjQ4EH4mJH0lCFfk+rg92kZZQce0qzQNRpkxvgbKI/vSuEGHYEIkah5zoKvZ7zbdGRouzXIJuPxDA20HcKiP2BacPQEfEvG2CeM7pfYrKZiOuZO4FfMVZL0vS1BtG7NJNxGV8HkGcYDEyVaheO6shYeN4b02cOG5ahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F+ZzMdg1; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b67422cb-044a-478d-acac-28f99067548b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775065114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaFEEmrvuWW+Qadi8BzniX8RQWYAN2oyCf3v0h969Xw=;
	b=F+ZzMdg1e4DxdZbJNGQLtQnI9Ea/toFX0m0IsdsGwj2K1oAA/WCDD+DxIHsnmLzUPnBZuh
	nZJN852OMbKf91SrVWspWOsRmxpG7tFd23yHtuVISoqkJEZgdbBTjkbYpOv1F0G+yt0PET
	5xwdYX2Jq0S/7eLDuIHNP8LLBm/LJZY=
Date: Wed, 1 Apr 2026 10:38:21 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA: rxe: validate pad and ICRC before payload_size() in
 rxe_rcv
To: hkbinbin <hkbinbinbin@gmail.com>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org, w@1wt.eu, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260401121907.1468366-1-hkbinbinbin@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260401121907.1468366-1-hkbinbinbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18907-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,1wt.eu,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D980C37EBEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/4/1 5:19, hkbinbin 写道:
> rxe_rcv() currently checks only that the incoming packet is at least
> header_size(pkt) bytes long before payload_size() is used.
> 
> However, payload_size() subtracts both the attacker-controlled BTH pad
> field and RXE_ICRC_SIZE from pkt->paylen:
> 
>    payload_size = pkt->paylen - offset[RXE_PAYLOAD] - bth_pad(pkt)
>                   - RXE_ICRC_SIZE
> 
> This means a short packet can still make payload_size() underflow even
> if it includes enough bytes for the fixed headers. Simply requiring
> header_size(pkt) + RXE_ICRC_SIZE is not sufficient either, because a
> packet with a forged non-zero BTH pad can still leave payload_size()
> negative and pass an underflowed value to later receive-path users.
> 
> Fix this by validating pkt->paylen against the full minimum length
> required by payload_size(): header_size(pkt) + bth_pad(pkt) +
> RXE_ICRC_SIZE.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>

Thanks a lot.
If the following analysis can be added into commit logs, it is better.

"
========================================================================
Analysis
========================================================================

In drivers/infiniband/sw/rxe/rxe_hdr.h:

------------------------------------------------------------------------
static inline size_t payload_size(struct rxe_pkt_info *pkt)
{
     return pkt->paylen - rxe_opcode[pkt->opcode].offset[RXE_PAYLOAD]
         - bth_pad(pkt) - RXE_ICRC_SIZE;
}
------------------------------------------------------------------------

The relevant receive path is:

   1. rxe_udp_encap_recv() sets pkt->paylen from the incoming UDP packet.

   2. rxe_rcv() validates only:

------------------------------------------------------------------------
if (unlikely(skb->len < header_size(pkt)))
     goto drop;
------------------------------------------------------------------------

   3. This allows packets where paylen == header_size(pkt), i.e. packets
      with only headers and no ICRC trailer.

   4. For a UD SEND_ONLY packet (opcode 0x64), the minimum valid header is
      BTH + DETH = 12 + 8 = 20 bytes, and offset[RXE_PAYLOAD] is also 20.

   5. Therefore a 20-byte packet with pad=0 computes:

------------------------------------------------------------------------
payload_size = 20 - 20 - 0 - 4 = -4
------------------------------------------------------------------------

Because payload_size() returns size_t, this wraps to SIZE_MAX - 3.

In drivers/infiniband/sw/rxe/rxe_recv.c, rxe_icrc_check() then uses that
value in the CRC calculation:

------------------------------------------------------------------------
icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
                  payload_size(pkt) + bth_pad(pkt));
------------------------------------------------------------------------

This causes crc32_le() to read from payload_addr(pkt) for essentially the
entire address space, immediately faulting on unmapped memory.

The bug is remotely reachable because the RXE GSI QP (QPN=1) is always
present once an RXE device is configured, and UD/GSI traffic passes the
address validation path. A single crafted UDP packet to port 4791 with
valid BTH/DETH fields is sufficient.

Trigger packet fields used in testing:

   - Opcode: 0x64 (UD SEND_ONLY)
   - Transport version: 0
   - P_Key: 0xffff
   - QPN: 1 (GSI QP)
   - Pad: 0
   - Q_Key: 0x80010000 (GSI_QKEY)
   - No payload
   - No ICRC trailer
"
But no the above analysis, I still think it is good.

Thanks,

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_recv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 5861e4244049..f79214738c2b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -330,7 +330,8 @@ void rxe_rcv(struct sk_buff *skb)
>   	pkt->qp = NULL;
>   	pkt->mask |= rxe_opcode[pkt->opcode].mask;
>   
> -	if (unlikely(skb->len < header_size(pkt)))
> +	if (unlikely(pkt->paylen < header_size(pkt) + bth_pad(pkt) +
> +		       RXE_ICRC_SIZE))
>   		goto drop;
>   
>   	err = hdr_check(pkt);


