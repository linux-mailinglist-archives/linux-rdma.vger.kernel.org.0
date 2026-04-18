Return-Path: <linux-rdma+bounces-19425-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TnAHIJgK5GltPgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19425-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 00:50:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB22A42285C
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 00:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7333F3014424
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 22:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6761D3537E6;
	Sat, 18 Apr 2026 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I2jd6fwv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944C282F05
	for <linux-rdma@vger.kernel.org>; Sat, 18 Apr 2026 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776552592; cv=none; b=K/LS4D3M0RrdiGZ1pfqVLzfuZUlWBLQ2/5RvqQJtrwxuDi8L996Iah3hVyeRXvMIhi5+KK9WCpxEOGXeuWDXohEX37sGpvmUMo+x7xuRVDrgai6/ReuHzQaMN76ynPRW2T3g6VZLH63Y38FyaEAjFnkbYDxHnR8G0F3tWTNRego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776552592; c=relaxed/simple;
	bh=GbDOvsRKRPz6bGgRUUTKY0Kppo7o7jj67YzaKB43cYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC5GGABoZ1XmdfqJN4Kgx/b3LpApFqVpst8RjxM9I9Ded88+y6is7uB6eoDfzr9PChgbTv8isffGmF6BIaCwQVrATBb3QC4armgXsHCxIm9QT/fdqolzWYA+HP6eUVlVsAKfXEAnE0WNDa0jqYuwzD1+dett+Ci63uRK7zqhaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I2jd6fwv; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06470bbf-ee39-4094-8c01-5860935af0f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776552587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqTHoYKg9e44/A2RyIXSwTwGu6SgWI4M3WA04juqKIA=;
	b=I2jd6fwvxANUS/DLWHRdOXQBuB/RfOouz19aB1+QgmOSnSPB6aokCNSjDXI8CJ9c3+sVIS
	sF3X2jy/ljENg9UA6ZbxZCn5N3vtib1uoDQz9KH/S7mbCPTPyWaYAqVE+NyryF9C+/fL0h
	+ZSCKiqKZthu8PuW9V0/Vgm7uwOjRZ0=
Date: Sat, 18 Apr 2026 15:49:29 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: reject non-8-byte ATOMIC_WRITE payloads
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260418162141.3610201-1-michael.bommarito@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260418162141.3610201-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19425-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB22A42285C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/4/18 9:21, Michael Bommarito 写道:
> atomic_write_reply() at drivers/infiniband/sw/rxe/rxe_resp.c
> unconditionally dereferences 8 bytes at payload_addr(pkt):
> 
>      value = *(u64 *)payload_addr(pkt);
> 
> check_rkey() previously accepted an ATOMIC_WRITE request with
> pktlen == resid == 0 because the length validation only compared
> pktlen against resid. A remote initiator that sets the RETH
> length to 0 therefore reaches atomic_write_reply() with a
> zero-byte logical payload, and the responder reads sizeof(u64)
> bytes from past the logical end of the packet into skb->head
> tailroom, then writes those 8 bytes into the attacker's MR via
> rxe_mr_do_atomic_write(). That is a remote disclosure of 4 bytes
> of kernel tailroom per probe (the other 4 bytes are the packet's
> own trailing ICRC).
> 
> IBA oA19-28 defines ATOMIC_WRITE as exactly 8 bytes. Anything
> else is protocol-invalid. Hoist a strict length check into
> check_rkey() so the responder never reaches the unchecked
> dereference, and keep the existing WRITE-family length logic for
> the normal RDMA WRITE path.
> 
> Reproduced on mainline with an unmodified rxe driver: a
> sustained zero-length ATOMIC_WRITE probe repeatedly leaks
> adjacent skb head-buffer bytes into the attacker's MR,
> including recognisable kernel strings and partial
> kernel-direct-map pointer words.  With this patch applied the
> responder rejects the PDU and the MR stays all-zero.
> 
> Fixes: 034e285f8b99 ("RDMA/rxe: Make responder support atomic write on RC service")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Previously reported to security@ (2026-04-18); reposting
> publicly at the maintainer's request.
> 
> Per-probe evidence from a 100K-packet run on the clean
> unpatched tree at 9ca18fc915c6 (single attacker QP against a
> hairpin target QP over a veth pair; each probe one crafted
> zero-length ATOMIC_WRITE PDU):
> 
>      transmitted packets:          100,000
>      observed MR writes:            48,575
>      non-zero leaked tails:         33,297  (68.55% of observed writes)
>      mostly-printable tails:         3,796  (7.81%)
>      fully-printable tails:          2,241  (4.61%)
>      unique non-zero tails:         22,220
> 
> Each probe is a fresh skb head-buffer allocation, so the 4
> attacker-visible bytes after the ICRC are an independent
> sample of slab-adjacent memory.  Content distribution across
> the 48,575 observed writes: 31.45% zero, 4.61% fully
> printable, 3.20% mostly printable, 12.06% header/sentinel-
> looking (08004500, 08004508, ffffffff, ...), 48.68% other
> binary.  80.9% of unique non-zero tails were singletons, so
> the leak is not dominated by one repeated value.
> 
> Representative printable fragments observed on the attacker
> side:
> 
>      74 6f 70 2e   "top."
>      66 72 65 65   "free"
>      45 78 65 63   "Exec"
>      2f 73 79 73   "/sys"
>      72 6f 6f 74   "root"
>      45 56 50 41   "EVPA"
>      43 4f 44 45   "CODE"
> 
> Partial pointer-like recoveries (4-byte words ending in the
> kernel-direct-map prefix 0xffff....):
> 
>      3,361 observations ending in ffff
>      1,364 unique ....ffff tails
>      most common:
>        81 88 ff ff   LE 0xffff8881   1.68% of observed writes
>        80 88 ff ff   LE 0xffff8880   0.22%
> 
> The run did not recover full 64-bit kernel virtual addresses
> (only 4 bytes per probe are attacker-observable), but the
> partial pointer material is consistent with a KASLR-weakening
> primitive under sustained probing.  With the fix applied, the
> same harness leaves the attacker MR all-zero.

Thanks a lot. It would be great to have a corresponding negative test in 
tools/testing/selftests/rdma that sends malformed ATOMIC_WRITE requests 
(e.g., zero-length) and verifies that they are rejected and do not 
modify the target MR.

It is up to you. To this commit, I am fine with it.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 711f73e0bbb1..09ba21d0f3c4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -526,7 +526,19 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>   	}
>   
>   skip_check_range:
> -	if (pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
> +	if (pkt->mask & RXE_ATOMIC_WRITE_MASK) {
> +		/* IBA oA19-28: ATOMIC_WRITE payload is exactly 8 bytes.
> +		 * Reject any other length before the responder reads
> +		 * sizeof(u64) bytes from payload_addr(pkt); a shorter
> +		 * payload would read past the logical end of the packet
> +		 * into skb->head tailroom.
> +		 */
> +		if (resid != sizeof(u64) || pktlen != sizeof(u64) ||
> +		    bth_pad(pkt)) {
> +			state = RESPST_ERR_LENGTH;
> +			goto err;
> +		}
> +	} else if (pkt->mask & RXE_WRITE_MASK) {
>   		if (resid > mtu) {
>   			if (pktlen != mtu || bth_pad(pkt)) {
>   				state = RESPST_ERR_LENGTH;


