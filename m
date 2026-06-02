Return-Path: <linux-rdma+bounces-21640-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id suOHHckzH2qnigAAu9opvQ
	(envelope-from <linux-rdma+bounces-21640-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:49:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C26631877
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:49:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KfL8p2Gn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21640-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21640-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 219A03048594
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 19:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56079263C7F;
	Tue,  2 Jun 2026 19:47:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595F183CC3
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 19:47:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429632; cv=none; b=UxKLwQ9Pm3j/dOr/nT3lNf3yphD5YuQjNXKvA7PtJM75bF4wf/X+2R9cOsJ+M0uKW+TurnPWXm0RVp0XAZB9mQPtFDLBEzcAC+gvFIhRYHFQhSVBc0eq74+HdsBvoFF/p1AaDfM2MKP9VoEgjZbRdm9nwamW5o1PWGcnxzkuv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429632; c=relaxed/simple;
	bh=5AgpAAnS8cDR3zedlpI0Z2zKJHna6jr8Y/0zpoo9Qfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UB3CU+sS2XjLNUa/luRpyfGIsDjGSZ6ZU4kwLziBO658T/N8f3DPmEPl0Sz2irNL+xZ91ihqlCeUAzpmHfi+VkqhJ+G709ST2Q7eItlTVvgZXZa3VgEa5zQHLm2iJNDvjPQrQRmafwvdcCC8KLp9xGkAUTMbZRC6+l5KapqbERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfL8p2Gn; arc=none smtp.client-ip=209.85.222.182
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91587626ae1so59500985a.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429630; x=1781034430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rL91njhnIv1gQ98/IXo5V10Wtcv77BWj1gHeGmHN2C4=;
        b=KfL8p2GndcpqnIfB3IjClH/oo2I3GbWFL4ki28L3GLuatwsEktYo3aPekudp09tBip
         13oZJ2iaaqnQNrkhPtpNPNds/AfoVDF2F7aeEOQT6Wid5ewGyqJ7FIKS1XiKbBsZ9PQQ
         Q5OELQMVT3HVxfvgisdCNEqSWd9rpaliztzLvUuuHWLPY9UzFDytOBQS+AMGIbQ66XbG
         sa3SQoGBBCZsk2xq1Lt9LZtekLb/7NxF35xdbQH0CVE2iO6qHazZa3JOte2mz0RQBnj7
         CM2BHU336uJevg1fvTIcshMRoTLXAyPDKxgCUqrOqzNnXOXJuTTtSFSfxAERYjA2BPGC
         tSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429630; x=1781034430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL91njhnIv1gQ98/IXo5V10Wtcv77BWj1gHeGmHN2C4=;
        b=lT20i0yUYRNcP+6PgFxmBYHCd8hCFQdNfWRKmX4F1mkRuD6U0RaurMkBvrZgwc4yRc
         9GIkZCXWCtr3QGx3sim5tXDLgh/4SStolpvvPteIs9I47NUv1Dp6sGvebRc9WxJ9Ftpo
         tlL+E+fQ+Z/aizfWq9XSOHew/WbWgzp/qQ4wId1ggGrptUweowkLPmKW2mQdSOolaYli
         hydgZOmfvU8ibxr3gzRB9qa9vXzDATEuF2EX4aL+/iXdp7hAPlYaPzmMjHhBAiaMMjxm
         F/H4EFnPZzkYxFwKIX5MJ1T0Dkyb/X29v6QjtVY1U/iQqiuZjHH9UdVx/VXpQRZ8nv7C
         +lqA==
X-Gm-Message-State: AOJu0YxI2Ug0MKzKmubuBWP4XjEca9ZAqdglgxRV/I/gP/vkNMpc13LT
	e4sdP+SndnHT76PnCwPBS9JLDeOjwWM5S8xJg1H5sHyWTtLz+bNlapiC
X-Gm-Gg: Acq92OEjh+JGDjrjcZligTpxYYLzvXKDbnD+e+CLu8WTs7pMwdzoo0IQTmF99lgKQyI
	q5Q1XsoBU0jHmYf5V4lhkPisqM1uG8rFcKfHt5+mV8vLw7HLwZtUfX33ZOWtCxA9Q0GGKi4NiOp
	dpYUVKkiJv+skandCXn1Hy5G9OZDP0mGgCmvY0pn65J66VouCJGGoG2nIlkPvYd5UV7DSTInHEU
	9Ok0xS/xkcxTBZ80opDfdE0D1VNiiH8SAqOneDfazl6sc9U5FsR17njX/aKRVriG0xrwz9pEh2M
	P3ScD+Z30eYu5Ytctdn+7uKcfkxuftmTGs4yiV+IURFTpBE6B0sUjTV8/eVFNI1xkm2WHF85RZR
	HyMCBhQz0VXmEICWFw2vbFy2BH8yLbVTsm4oQVpsOjrwf5IvNhZsy23hvlU8VPwDnjpxpCwtCh1
	4PZIG7R1Sarp9BlSPB9L2rlxqHDEMYWomt3ARq/G+21djp6U9VZcs4pL0wGypdnUE9zgKgwREay
	uyblewLkY7W4Lqjg4EmoVs7FQkqjF4=
X-Received: by 2002:a05:622a:d03:b0:516:e047:2f30 with SMTP id d75a77b69052e-517786c877dmr6334561cf.38.1780429629575;
        Tue, 02 Jun 2026 12:47:09 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06b701sm741816d6.34.2026.06.02.12.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:47:09 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/siw: bound Read Response placement to the RREAD length
Date: Tue,  2 Jun 2026 15:47:00 -0400
Message-ID: <20260602194700.2273758-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21640-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bernard.metzler@linux.dev,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10C26631877

In drivers/infiniband/sw/siw/siw_qp_rx.c, siw_proc_rresp() places each
inbound Read Response DDP segment at sge->laddr + wqe->processed and then
accumulates wqe->processed, but it never checks the running total against
the sink buffer length on continuation segments. siw_check_sge() resolves
and validates the sink memory only on the first fragment (the if (!*mem)
branch), and siw_rresp_check_ntoh() compares the cumulative length against
wqe->bytes only on the final segment (the !frx->more_ddp_segs guard).

A connected siw peer that answers an outstanding RREAD with Read Response
segments that keep the DDP Last flag clear, carrying more total payload
than the RREAD requested, drives wqe->processed past the validated sink
buffer; the next siw_rx_data() call writes out of bounds at
sge->laddr + wqe->processed. siw runs iWARP over ordinary routable TCP,
so the peer is the remote end of an established RDMA connection and needs
no local privilege.

Bound every segment before placement, exactly as siw_proc_send() and
siw_proc_write() already do for their tagged and untagged paths, and
terminate the connection with a base-or-bounds DDP error when the
Read Response would overrun the sink buffer.

This is the second receive-path length fix for this file. A separate
change rejects an MPA FPDU length that underflows the per-fragment
remainder in the header decode; that guard does not cover this case,
because here each individual segment length is self-consistent and only
the accumulated placement offset overruns the buffer.

Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

Impact: the remote peer of an established Soft-iWARP connection can write
out of bounds past the RREAD sink (global DMA MR sink) or force a
connection-terminating fault (default FRWR sink) by streaming Read
Response segments whose cumulative length exceeds the requested length
with the DDP Last flag clear.

Relationship to the in-flight siw receive-path fix

This is the second receive-path length fix I have for this file. The
first, currently under review on this list, rejects an MPA FPDU length
that underflows the per-fragment remainder during header decode in
siw_get_hdr(). That guard sits in the header-length path and does not
cover the case here: in this report every individual segment length is
self-consistent and non-negative, and only the accumulated placement
offset (wqe->processed across continuation segments) overruns the sink
buffer. The two fixes touch different functions and are independent;
either can be applied without the other. I am sending this as a fresh
top-level thread rather than threading it under the earlier series to
keep the two changes separable for review and for stable selection.

Analysis

Verified by reading siw_qp_rx.c at v7.1-rc4 (a1f173eb51db):

  - siw_proc_rresp() resolves and range-checks the sink memory region
    once, on the first fragment only (the if (!*mem) branch calling
    siw_check_sge() with the full requested length).
  - The cumulative-length consistency check in siw_rresp_check_ntoh()
    is gated on !more_ddp_segs, so it fires only on the segment that
    carries the DDP Last flag, and siw_rresp_check_ntoh() itself runs
    only on the first DDP segment.
  - Each segment is then placed at sge->laddr + wqe->processed and
    wqe->processed is accumulated, with no per-segment bound against
    wqe->bytes.

A peer that keeps the DDP Last flag clear across continuation segments
and streams more total payload than the outstanding RREAD requested
therefore drives wqe->processed past the validated sink region; the
next placement writes peer-supplied bytes out of bounds. For a sink
backed by a global DMA / kernel-virtual MR (mem_obj NULL, the
siw_rx_kva() path) this is a direct kernel-heap out-of-bounds write.
For a user-memory or fast-registration/PBL MR (siw_rx_umem() /
siw_rx_pbl(), the mode kernel ULPs use by default) the over-walk is
caught when the page or PBL index runs out and is converted to a
connection-terminating fault. The missing per-segment bound should be
added regardless of sink type.

siw_proc_send() and siw_proc_write() already bound every segment with
the equivalent wqe->bytes < wqe->processed + srx->fpdu_part_rem check;
this patch brings siw_proc_rresp() in line with them.

Conditions: CONFIG_RDMA_SIW=m or =y, siw loaded and a link configured
(modprobe siw; rdma link add ... type siw), and a local ULP with an
outstanding RDMA READ to the peer. The out-of-bounds write requires the
READ sink to be a global DMA / kernel-virtual MR; ULPs using the default
fast-registration (FRWR) sink instead see a connection-terminating
fault. No special sysctls or local privilege on the victim are required
beyond the configured fabric.

Mitigations: until the patch is applied, do not configure Soft-iWARP
toward untrusted peers, or restrict the RDMA-CM listener to trusted
peers at the network layer. Removing the module (rmmod siw) is
sufficient when no application is using it.

A function-level reproducer that drives siw_proc_rresp() over the real
kernel TCP receive path with a primed ORQ and a two-segment malformed
Read Response reproduces a KASAN slab-out-of-bounds write on a global
DMA MR sink; it can be shared off-list on request.

Fixes: 8b6a361b8c48 ("rdma/siw: receive path"), reachable from v5.10
and all later releases; all stable branches carrying siw are affected.

 drivers/infiniband/sw/siw/siw_qp_rx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index e8a88b378d51d..ec4aadef3dfe2 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -844,6 +844,25 @@ int siw_proc_rresp(struct siw_qp *qp)
 	}
 	mem_p = *mem;
 
+	/*
+	 * siw_rresp_check_ntoh() validates the cumulative length only on
+	 * the last DDP segment (!more_ddp_segs), and siw_check_sge() above
+	 * resolves the sink memory only on the first fragment. A peer that
+	 * keeps DDP_FLAG_LAST clear and streams more payload than the
+	 * outstanding RREAD requested therefore drives wqe->processed past
+	 * the validated sink buffer, writing out of bounds. Bound every
+	 * segment as siw_proc_send()/siw_proc_write() already do.
+	 */
+	if (unlikely(wqe->processed + srx->fpdu_part_rem > wqe->bytes)) {
+		siw_dbg_qp(qp, "rresp len: %d + %d > %d\n",
+			   wqe->processed, srx->fpdu_part_rem, wqe->bytes);
+		wqe->wc_status = SIW_WC_LOC_LEN_ERR;
+		siw_init_terminate(qp, TERM_ERROR_LAYER_DDP,
+				   DDP_ETYPE_TAGGED_BUF,
+				   DDP_ECODE_T_BASE_BOUNDS, 0);
+		return -EINVAL;
+	}
+
 	bytes = min(srx->fpdu_part_rem, srx->skb_new);
 	rv = siw_rx_data(mem_p, srx, &frx->pbl_idx,
 			 sge->laddr + wqe->processed, bytes);
-- 
2.53.0


