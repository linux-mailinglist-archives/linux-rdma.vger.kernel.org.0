Return-Path: <linux-rdma+bounces-19334-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN3qLl0i3mk1ngkAu9opvQ
	(envelope-from <linux-rdma+bounces-19334-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 13:17:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123B3F93C8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 13:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6357730674CE
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77C3D9DD2;
	Tue, 14 Apr 2026 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOAikDc+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478413C7DF5
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165403; cv=none; b=efMB+2Bo57zwCuBYeVnENhNzJGxbKl1/KrVf/IQZncP54xmTQSyU/aYvsBx93oirz5CKd1FtPgasHSEbIvV3wPKQ3a6gjNsW2z8zZuAlC9CbIwsrPy+3nNr881kCTZYOfKeCw8TtiegVpxiGDnA2uzgMxYQZYJ3krnbBTy9FL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165403; c=relaxed/simple;
	bh=PxcMkxKwR0QjBXMQ7BoJDuxGHFoSakkgwUWJVqBw0ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1P3Gw1TSvp6F5+uoqk/mvkQ+wLEXgQeODadjpOlUF0WGSAoMXIgI3cbtQoqQRsooI1FYlnwnPbl2bUowoDCNlAohEKylWPPhimy7Uhg9KVEcUrvIqANhK/SqamOStD2H/nE83n03IOWj9HGERRGBGXjSDZ/EKUFQoI9V1Z6T3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOAikDc+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d583bfc415so851735085a.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776165401; x=1776770201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1esxknwxAu1HK9DsqSzVwMwdkh7HafK/RQh7O/qJj8=;
        b=WOAikDc+KtVNbrtn80jUqGlPfURXkyn650Yeo5942oxLg22+NBO2SJYoZbPtCrX97e
         Y4QvLEmbxjIQevBv6yEGMthxrbvkuffO8GhWFHHjiT8mYR2u3nPe7vw+tzRO1Xqzi/61
         4hy/V/WMa2zZr9E/311bx7Nm/56PT/tX4nUjbopY/HqICLIrSmZe4CrHg29/1/MXSrSj
         cdHbWxeoMBCKqk5kT2Fak2xjZDLCcbaTK/KafDaKvdLJsUscJtWpwHZn9WLqxvysSfv4
         wB3nPjKeUBQxadBj08Et4Zetp5Hce77aw3Eurg7vtXA7bhXjaEDmp+nxtlop1T+UB4Cv
         yCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776165401; x=1776770201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1esxknwxAu1HK9DsqSzVwMwdkh7HafK/RQh7O/qJj8=;
        b=UqbmBp6IqjUjktvqwkeaucSWK74+gT0Z+7CQbXws7QuV8DJfzJ93YSpKZ68L2NFbk2
         ZRR0Es0YTOdbVMSLfhWICckSwTrukcyfB72c6agNBHGw7ucfOpOV8YwPPJdAVbkLH6Gr
         wfIlw3iJOWB4TM2DTCdEzYkqKuAsiS0PugiaA52YQTotqKihLeggcYWIMBk5z+4GVGoy
         Fro4/Ac7d3NF0UcIsyaGFFTfAxBTa2Kgb7nchVf3giRD1CWDNI67IsRRqi8ya04Dm3m7
         ZJCyR3/scSpkvJ/hcYcJULeqIdHwmfae+kOIHr8/UjICkkKsM6pbShIYhNnwVWWvD1fn
         Y8Jw==
X-Forwarded-Encrypted: i=1; AFNElJ+rVESkxC887YMw7BnX8ri5Hih3EeKujwBNQrb9kaNTIoy5rCt7RXPWsevwXUjLM7rCQC1BbzGwuIaY@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHbcaN2Lk4hvjd8nt5Gzq2n47D2wE4RVjKIkZNHAvdkOoNZag
	10TWdabHLnS2+E7+drZdZheemgUbM+OesX2HaxZ5243DIrzxgWqwZb43
X-Gm-Gg: AeBDiesEZkDb4njJv/7G8SjGcxpe1udLb/LtlQSzWvslkJrziIpMyPUhGeLbnTfpm0c
	dfnybCQgPoiTTGiu1qDVsu5/ZHQw2yZtynItPYuP+7cp6kaA5eG4aCT/xFLT3U/CRwnSeVTlwg7
	UFlXWQ5MWsQ0xsvLqHuUUpODBpXUF+5SGTVONQOPP1Yuk7e1b5f6W9akdxXWRsxEhJlyJ+Srt/S
	ZrBH5AbG24c93SHFQJWc5vxiOZP0KFFlUKQD5LlY88RTrO6UhxkQCYDmXatW88fcM7GGBqU7+v4
	GwLgin+/kvb2FS6mKlmsT0cmcWqToBWy4p99AME7gXKyIpXL8vLqyuFSApWO+whBMHxtKe4hmE7
	pc0MFTghA6FOwIp2qqiodKNSpkwh5WKs/DKZWlJL9a8oNa8PGoP/iJBCrVEgxXtz7QU06AG0EbE
	q6HSZMWYIF1YXJdTw2f3VIwSWTeB8QoAhiae8inBcrfUQEpHnYtr6i5UTRu4NsazVE5JjmcnPxt
	fEnAFKHnYy4usWDk03x
X-Received: by 2002:a05:620a:2949:b0:8cf:d3a9:60ea with SMTP id af79cd13be357-8ddce2c9fbcmr2505935285a.26.1776165401195;
        Tue, 14 Apr 2026 04:16:41 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cb0474sm120225296d6.40.2026.04.14.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:16:40 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Jason Gunthorpe" <jgg@ziepe.ca>,
	"Leon Romanovsky" <leon@kernel.org>
Cc: "Zhu Yanjun" <yanjun.zhu@linux.dev>,
	"hkbinbin" <hkbinbinbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH v2] RDMA/rxe: Reject unknown opcodes before ICRC processing
Date: Tue, 14 Apr 2026 07:15:55 -0400
Message-ID: <20260414111555.3386793-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19334-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 6123B3F93C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Even after applying commit 7244491dab34 ("RDMA/rxe: Validate pad and ICRC
before payload_size() in rxe_rcv"), a single unauthenticated UDP packet
can still trigger panic.  That patch handled payload_size() underflow
only for valid opcodes with short packets, not for packets carrying an
unknown opcode.  The unknown-opcode OOB read described below
predates that commit and reaches back to the initial Soft RoCE driver.

The check added there reads

    pkt->paylen < header_size(pkt) + bth_pad(pkt) + RXE_ICRC_SIZE

where header_size(pkt) expands to rxe_opcode[pkt->opcode].length.  The
rxe_opcode[] array has 256 entries but is only populated for defined IB
opcodes; any other entry (for example opcode 0xff) is zero-initialized,
so length == 0 and the check degenerates to

    pkt->paylen < 0 + bth_pad(pkt) + RXE_ICRC_SIZE

which does not constrain pkt->paylen enough.  rxe_icrc_hdr() then
computes

    rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES

which underflows when length == 0 and passes a huge value to
rxe_crc32(), causing an out-of-bounds read of the skb payload.

Reproduced on v7.0-rc7 with that fix applied, QEMU/KVM with
CONFIG_RDMA_RXE=y and CONFIG_KASAN=y, after

    rdma link add rxe0 type rxe netdev eth0

A single 48-byte UDP packet to port 4791 with BTH opcode=0xff and
QPN=IB_MULTICAST_QPN triggers:

    BUG: KASAN: slab-out-of-bounds in crc32_le+0x115/0x170
    Read of size 1 at addr ...
    The buggy address is located 0 bytes to the right of
     allocated 704-byte region
    Call Trace:
     crc32_le+0x115/0x170
     rxe_icrc_hdr.isra.0+0x226/0x300
     rxe_icrc_check+0x13f/0x3a0
     rxe_rcv+0x6e1/0x16e0
     rxe_udp_encap_recv+0x20a/0x320
     udp_queue_rcv_one_skb+0x7ed/0x12c0

Subsequent packets with the same shape fault on unmapped memory and
panic the kernel.  The trigger requires only module load and
"rdma link add"; no QP, no connection, and no authentication.

Fix this by rejecting packets whose opcode has no rxe_opcode[] entry,
detected via the zero mask or zero length, before any length
arithmetic runs.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
v2: also check rxe_opcode[].length per Zhu Yanjun; "||" rather than
    "&&" so the guard tracks the actual underflow in rxe_icrc_hdr().

v1 was sent privately to security@kernel.org.

 drivers/infiniband/sw/rxe/rxe_recv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index f79214738c2b..2d5e701ff961 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -330,6 +330,17 @@ void rxe_rcv(struct sk_buff *skb)
 	pkt->qp = NULL;
 	pkt->mask |= rxe_opcode[pkt->opcode].mask;
 
+	/*
+	 * Unknown opcodes have a zero-initialized rxe_opcode[] entry, so
+	 * both mask and length are 0.  Reject them before any length math:
+	 * rxe_icrc_hdr() would otherwise compute length - RXE_BTH_BYTES
+	 * and pass the underflowed value to rxe_crc32(), producing an
+	 * out-of-bounds read.
+	 */
+	if (unlikely(!rxe_opcode[pkt->opcode].mask ||
+		     !rxe_opcode[pkt->opcode].length))
+		goto drop;
+
 	if (unlikely(pkt->paylen < header_size(pkt) + bth_pad(pkt) +
 		       RXE_ICRC_SIZE))
 		goto drop;
-- 
2.53.0


