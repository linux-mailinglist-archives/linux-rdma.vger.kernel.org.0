Return-Path: <linux-rdma+bounces-21673-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GjaQOqj3H2qGtQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21673-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 11:45:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B6663645B
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 11:45:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=taq9wPPe;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21673-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21673-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7F3C302C82F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAAE40F8D3;
	Wed,  3 Jun 2026 09:44:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4F3A1D07
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 09:44:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479898; cv=none; b=SOG9Z0QY4uO4ocIi2MS4mV/LQ8ja/uBnv4iJ2RdEAP0DeE4WP9Kd/rdYaW95yQIkTQCjsRJ6ROdzXAILvMquZ0Su3F8ixqWX9xx25GglzNl8F3BsgCQlJQpKYvLz9eOsJvCi3XjSI+q0VM3XAZ5qQoYOotOPXH1yXtgilgtzxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479898; c=relaxed/simple;
	bh=VrWKDlUvJe8z6UrdbOYkDylgnsV7ejbhvYkZ9YtqOeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4+0hkl/VL3d13cJAV5xsukdNz9aqiu8zjPPCL1c7GpccT49Sm1I5u0bnRaiYBv5qIflbIo8WbBNTiOiWo7TfcxBdGA/nJHMoyk4O1FW/Br3v7XdLKK+7nkSvi0eFT2DlcFndH1VE1KDoolW1Ks6RlEL6AQSKTgZTgTb8kCW+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=taq9wPPe; arc=none smtp.client-ip=95.215.58.170
Message-ID: <e73d3c05-d3b0-4da8-b063-1a8175748621@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780479893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkG7Wog+e/ksqpp874C+k3jNOpU7ekj1cZoFAoxRVew=;
	b=taq9wPPekFwNf7X6qXbi/wZznx8wF1PB6L2TvBH4xU1RF3vQ7fklIbNU6Ydyh8tJbcqP6j
	EWEo8K96kxtlNVGOj/iBY2tI3vApowfHMKcf15mw2O+dVY6qobWgu3SY/sPJ8l+g0BDFAL
	M11LcMFUWfx/VXLDZ3d2dYKqUCz7ukY=
Date: Wed, 3 Jun 2026 11:44:12 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: bound Read Response placement to the RREAD
 length
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602194700.2273758-1-michael.bommarito@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260602194700.2273758-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21673-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	FORGED_SENDER(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:from_mime,linux.dev:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45B6663645B

On 02.06.2026 21:47, Michael Bommarito wrote:
> In drivers/infiniband/sw/siw/siw_qp_rx.c, siw_proc_rresp() places each
> inbound Read Response DDP segment at sge->laddr + wqe->processed and then
> accumulates wqe->processed, but it never checks the running total against
> the sink buffer length on continuation segments. siw_check_sge() resolves
> and validates the sink memory only on the first fragment (the if (!*mem)
> branch), and siw_rresp_check_ntoh() compares the cumulative length against
> wqe->bytes only on the final segment (the !frx->more_ddp_segs guard).
> 
> A connected siw peer that answers an outstanding RREAD with Read Response
> segments that keep the DDP Last flag clear, carrying more total payload
> than the RREAD requested, drives wqe->processed past the validated sink
> buffer; the next siw_rx_data() call writes out of bounds at
> sge->laddr + wqe->processed. siw runs iWARP over ordinary routable TCP,
> so the peer is the remote end of an established RDMA connection and needs
> no local privilege.
> 
> Bound every segment before placement, exactly as siw_proc_send() and
> siw_proc_write() already do for their tagged and untagged paths, and
> terminate the connection with a base-or-bounds DDP error when the
> Read Response would overrun the sink buffer.
> 
> This is the second receive-path length fix for this file. A separate
> change rejects an MPA FPDU length that underflows the per-fragment
> remainder in the header decode; that guard does not cover this case,
> because here each individual segment length is self-consistent and only
> the accumulated placement offset overruns the buffer.
> 
> Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> 
> Impact: the remote peer of an established Soft-iWARP connection can write
> out of bounds past the RREAD sink (global DMA MR sink) or force a
> connection-terminating fault (default FRWR sink) by streaming Read
> Response segments whose cumulative length exceeds the requested length
> with the DDP Last flag clear.
> 
> Relationship to the in-flight siw receive-path fix
> 
> This is the second receive-path length fix I have for this file. The
> first, currently under review on this list, rejects an MPA FPDU length
> that underflows the per-fragment remainder during header decode in
> siw_get_hdr(). That guard sits in the header-length path and does not
> cover the case here: in this report every individual segment length is
> self-consistent and non-negative, and only the accumulated placement
> offset (wqe->processed across continuation segments) overruns the sink
> buffer. The two fixes touch different functions and are independent;
> either can be applied without the other. I am sending this as a fresh
> top-level thread rather than threading it under the earlier series to
> keep the two changes separable for review and for stable selection.
> 
> Analysis
> 
> Verified by reading siw_qp_rx.c at v7.1-rc4 (a1f173eb51db):
> 
>    - siw_proc_rresp() resolves and range-checks the sink memory region
>      once, on the first fragment only (the if (!*mem) branch calling
>      siw_check_sge() with the full requested length).
>    - The cumulative-length consistency check in siw_rresp_check_ntoh()
>      is gated on !more_ddp_segs, so it fires only on the segment that
>      carries the DDP Last flag, and siw_rresp_check_ntoh() itself runs
>      only on the first DDP segment.
>    - Each segment is then placed at sge->laddr + wqe->processed and
>      wqe->processed is accumulated, with no per-segment bound against
>      wqe->bytes.
> 
> A peer that keeps the DDP Last flag clear across continuation segments
> and streams more total payload than the outstanding RREAD requested
> therefore drives wqe->processed past the validated sink region; the
> next placement writes peer-supplied bytes out of bounds. For a sink
> backed by a global DMA / kernel-virtual MR (mem_obj NULL, the
> siw_rx_kva() path) this is a direct kernel-heap out-of-bounds write.
> For a user-memory or fast-registration/PBL MR (siw_rx_umem() /
> siw_rx_pbl(), the mode kernel ULPs use by default) the over-walk is
> caught when the page or PBL index runs out and is converted to a
> connection-terminating fault. The missing per-segment bound should be
> added regardless of sink type.
> 
> siw_proc_send() and siw_proc_write() already bound every segment with
> the equivalent wqe->bytes < wqe->processed + srx->fpdu_part_rem check;
> this patch brings siw_proc_rresp() in line with them.
> 
> Conditions: CONFIG_RDMA_SIW=m or =y, siw loaded and a link configured
> (modprobe siw; rdma link add ... type siw), and a local ULP with an
> outstanding RDMA READ to the peer. The out-of-bounds write requires the
> READ sink to be a global DMA / kernel-virtual MR; ULPs using the default
> fast-registration (FRWR) sink instead see a connection-terminating
> fault. No special sysctls or local privilege on the victim are required
> beyond the configured fabric.
> 
> Mitigations: until the patch is applied, do not configure Soft-iWARP
> toward untrusted peers, or restrict the RDMA-CM listener to trusted
> peers at the network layer. Removing the module (rmmod siw) is
> sufficient when no application is using it.
> 
> A function-level reproducer that drives siw_proc_rresp() over the real
> kernel TCP receive path with a primed ORQ and a two-segment malformed
> Read Response reproduces a KASAN slab-out-of-bounds write on a global
> DMA MR sink; it can be shared off-list on request.
> 
> Fixes: 8b6a361b8c48 ("rdma/siw: receive path"), reachable from v5.10
> and all later releases; all stable branches carrying siw are affected.
> 
>   drivers/infiniband/sw/siw/siw_qp_rx.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
> index e8a88b378d51d..ec4aadef3dfe2 100644
> --- a/drivers/infiniband/sw/siw/siw_qp_rx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
> @@ -844,6 +844,25 @@ int siw_proc_rresp(struct siw_qp *qp)
>   	}
>   	mem_p = *mem;
>   
> +	/*
> +	 * siw_rresp_check_ntoh() validates the cumulative length only on
> +	 * the last DDP segment (!more_ddp_segs), and siw_check_sge() above
> +	 * resolves the sink memory only on the first fragment. A peer that
> +	 * keeps DDP_FLAG_LAST clear and streams more payload than the
> +	 * outstanding RREAD requested therefore drives wqe->processed past
> +	 * the validated sink buffer, writing out of bounds. Bound every
> +	 * segment as siw_proc_send()/siw_proc_write() already do.
> +	 */
Excellent finding!
What we do for Send's and WRITE's, we have to do for RRESP's as
well.
Please make the commentary above much shorter, if at all.
As you are pointing out, we have that bounds check in place
for Send and WRITE already and it is clear why we need it
here as well. We are indeed excited we found a big and
ugly hole in the driver, but that should get reflected
in a (brief and concise) commit message and not the
code path.
> +	if (unlikely(wqe->processed + srx->fpdu_part_rem > wqe->bytes)) {
> +		siw_dbg_qp(qp, "rresp len: %d + %d > %d\n",
> +			   wqe->processed, srx->fpdu_part_rem, wqe->bytes);
> +		wqe->wc_status = SIW_WC_LOC_LEN_ERR;
> +		siw_init_terminate(qp, TERM_ERROR_LAYER_DDP,
> +				   DDP_ETYPE_TAGGED_BUF,
> +				   DDP_ECODE_T_BASE_BOUNDS, 0);
> +		return -EINVAL;
> +	}
> +
No extra newline here

>   	bytes = min(srx->fpdu_part_rem, srx->skb_new);
>   	rv = siw_rx_data(mem_p, srx, &frx->pbl_idx,
>   			 sge->laddr + wqe->processed, bytes);


