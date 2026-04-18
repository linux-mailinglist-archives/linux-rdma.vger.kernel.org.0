Return-Path: <linux-rdma+bounces-19423-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJlaJ52v42mOJwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19423-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 18:21:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B12842194B
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 18:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5C1E301B4E2
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846E2D060C;
	Sat, 18 Apr 2026 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1CBsnMW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657EDF6C
	for <linux-rdma@vger.kernel.org>; Sat, 18 Apr 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529306; cv=none; b=MlW5v1LztUfOcAJ9/rSolNplQ9j6KK3weFwZYR98Qx9JM4Wf5ikgytQVm3Wu+2FlIynNa9MTuv32S3s2HAuMR9ZmqzbiivwXL+4XAFZuMQFGLE/pll5upxURIdmEfP9THgiodZdOi1uV/Ws8U8K5NRiVcV8Ce+onZXgW+4hNAHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529306; c=relaxed/simple;
	bh=uQK1hSHEACXX9Ukiddf9UQfwH5u9C+YpxCL9o5jiWoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SY+ZqeT9rpNVqn7SgiitIYm+B7wnOxCy21eSWciW2O2srUIutBgpB1nPMYyA/fXvWxVT5B2sVe6Y+wNzm5eHPCr5GX8yfpAvtqOi24SpnWgmRC8le3/qrF0MbZXkSU6srPMUD1j6ljZjssPQLs4jaSmDlSqV5cgz+oI+7ETK0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1CBsnMW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d933da14f0so172423185a.2
        for <linux-rdma@vger.kernel.org>; Sat, 18 Apr 2026 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776529304; x=1777134104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MQF8HjFdl5twxarPi1Up2FEx6dhqLVh+giSKG6SUJU=;
        b=o1CBsnMWZ2FuuAoz1xa9wdO3RE/2L8gDOM4oZ732fhjpZXQr9DmFir9aKNDFEriYhd
         AY4lgF9+0NGaMq8U+K3cGkiCafxuOmOBNa39lVOF7SLkQPzrixXnwckbleqfodavCo62
         BYcQzBxxJZyYSEFxESo+tbyYRkHJISREHHrTLRTmRI6fT3Ct3Ro57d256RFkAt397S+5
         AYFqH+SUoHpk0L/bx2yWP46n8hthDWJW4fVQXKHEcH21tmsYf6KIKvB6CWKAzyTA1TZq
         AjBOrGH4JOxC3HcwB1BUeVgbWxyrKRAgyoEJteazAMctaQciLVa524hmNa0njs6UYE8s
         nNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529304; x=1777134104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MQF8HjFdl5twxarPi1Up2FEx6dhqLVh+giSKG6SUJU=;
        b=Pd1r/eqTVDaGIgPJi85lC5Oaw9kI0I/8j8NOx+vcmUOO00zJGaWz0G1JmRICzycOka
         jQ0cpDEyv6ciWEeUEtUIv8MC78v/p9B1/ZHMlDIOLwJwaOMYDcVdlV0NhOuCaJvfoIUG
         q5P/jGFr2YnGfojIzMbjVsJ3RA/435/ZTuX8uagG6S+BwsnWYFuP/hj0OjVBNC/42S0O
         6DOdcwBnpMr12lXt4GLaDUcLnb253O8w7VZkQVOPtWDaSww9JnUapfvt+Dg5k4klcBt+
         3rJkoXNLG0JDRm/umMHpLibo/LKqmIrkKSqpXHZ6SDuXLYlmZFCQl5ZKJ73mnjWq7IZX
         cNTw==
X-Forwarded-Encrypted: i=1; AFNElJ8Vzw42KLVmfA63REEWm/T5en0UTycV6K/NMg9+b35scF9jtfoQZllbA3fHlSAp44lec9S3fzKOCcMU@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHMKNtr5Km5gz35FvDfWKa9wn7FDDtyIWEhDloX+PPllZvQ5q
	yInCf9RUXNOOpGJmtVbY8fvJXuAoq+0N97ruf+lb8cdNOaMIxrjQjevW
X-Gm-Gg: AeBDiet18BBLzwawIw8rwtVMXSc0CA15sSUzA30yIw9f1njky0z0XDvIayNDdRnFID+
	vwM4ILHdl0vkF8U+aoykxRPmqtU5h/qxvoRHrx+JAkVx3fsa8Qqt4iS58lvQPxNbe/okwWZHNb2
	UDEUGWsOLOS+m6mfXEbBqPUusg4cW3K7iaz5PPpZ1Ww1sjMnAmveR5FklnwilFEUKvaq5NMff2P
	J53jeTzsE++1QrdnG5JRJ1aLqRR729aB6WeXf20FQ+j7EujJGhoMQDA8jEVkUUiSgw4WSD1uuVl
	Z08RufTnfMHE2i/OtSpRf/yHMdPS9m6HS8ZiZol3ZsV3j4+Zi99iitvK95IIq0maeMyxwyhpBxF
	/CVYf3P+eSG7vW9HLuBkISYVjNJ7Sz4iXv9mau5SdzgU54NWAA1ywL4gsvM8Ew8l//g+a5aeneD
	RcbJp/bhUih29kc/ML85decuxV3gWkkTqK2ViY8udeyXdTv8hMg5Tn36B2UrNFJMaErfsWKo1ad
	J9o2oPbyfj9EgtJiOmHy4PEfl2YamsPwk0VodQLDQ==
X-Received: by 2002:a05:620a:29c3:b0:8cd:942e:82dc with SMTP id af79cd13be357-8e7916b2195mr980784685a.41.1776529304281;
        Sat, 18 Apr 2026 09:21:44 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5febde5sm377801685a.4.2026.04.18.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:21:43 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Xiao Yang <yangx.jy@fujitsu.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/rxe: reject non-8-byte ATOMIC_WRITE payloads
Date: Sat, 18 Apr 2026 12:21:41 -0400
Message-ID: <20260418162141.3610201-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19423-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B12842194B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

atomic_write_reply() at drivers/infiniband/sw/rxe/rxe_resp.c
unconditionally dereferences 8 bytes at payload_addr(pkt):

    value = *(u64 *)payload_addr(pkt);

check_rkey() previously accepted an ATOMIC_WRITE request with
pktlen == resid == 0 because the length validation only compared
pktlen against resid. A remote initiator that sets the RETH
length to 0 therefore reaches atomic_write_reply() with a
zero-byte logical payload, and the responder reads sizeof(u64)
bytes from past the logical end of the packet into skb->head
tailroom, then writes those 8 bytes into the attacker's MR via
rxe_mr_do_atomic_write(). That is a remote disclosure of 4 bytes
of kernel tailroom per probe (the other 4 bytes are the packet's
own trailing ICRC).

IBA oA19-28 defines ATOMIC_WRITE as exactly 8 bytes. Anything
else is protocol-invalid. Hoist a strict length check into
check_rkey() so the responder never reaches the unchecked
dereference, and keep the existing WRITE-family length logic for
the normal RDMA WRITE path.

Reproduced on mainline with an unmodified rxe driver: a
sustained zero-length ATOMIC_WRITE probe repeatedly leaks
adjacent skb head-buffer bytes into the attacker's MR,
including recognisable kernel strings and partial
kernel-direct-map pointer words.  With this patch applied the
responder rejects the PDU and the MR stays all-zero.

Fixes: 034e285f8b99 ("RDMA/rxe: Make responder support atomic write on RC service")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Previously reported to security@ (2026-04-18); reposting
publicly at the maintainer's request.

Per-probe evidence from a 100K-packet run on the clean
unpatched tree at 9ca18fc915c6 (single attacker QP against a
hairpin target QP over a veth pair; each probe one crafted
zero-length ATOMIC_WRITE PDU):

    transmitted packets:          100,000
    observed MR writes:            48,575
    non-zero leaked tails:         33,297  (68.55% of observed writes)
    mostly-printable tails:         3,796  (7.81%)
    fully-printable tails:          2,241  (4.61%)
    unique non-zero tails:         22,220

Each probe is a fresh skb head-buffer allocation, so the 4
attacker-visible bytes after the ICRC are an independent
sample of slab-adjacent memory.  Content distribution across
the 48,575 observed writes: 31.45% zero, 4.61% fully
printable, 3.20% mostly printable, 12.06% header/sentinel-
looking (08004500, 08004508, ffffffff, ...), 48.68% other
binary.  80.9% of unique non-zero tails were singletons, so
the leak is not dominated by one repeated value.

Representative printable fragments observed on the attacker
side:

    74 6f 70 2e   "top."
    66 72 65 65   "free"
    45 78 65 63   "Exec"
    2f 73 79 73   "/sys"
    72 6f 6f 74   "root"
    45 56 50 41   "EVPA"
    43 4f 44 45   "CODE"

Partial pointer-like recoveries (4-byte words ending in the
kernel-direct-map prefix 0xffff....):

    3,361 observations ending in ffff
    1,364 unique ....ffff tails
    most common:
      81 88 ff ff   LE 0xffff8881   1.68% of observed writes
      80 88 ff ff   LE 0xffff8880   0.22%

The run did not recover full 64-bit kernel virtual addresses
(only 4 bytes per probe are attacker-observable), but the
partial pointer material is consistent with a KASLR-weakening
primitive under sustained probing.  With the fix applied, the
same harness leaves the attacker MR all-zero.
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 711f73e0bbb1..09ba21d0f3c4 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -526,7 +526,19 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	}
 
 skip_check_range:
-	if (pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
+	if (pkt->mask & RXE_ATOMIC_WRITE_MASK) {
+		/* IBA oA19-28: ATOMIC_WRITE payload is exactly 8 bytes.
+		 * Reject any other length before the responder reads
+		 * sizeof(u64) bytes from payload_addr(pkt); a shorter
+		 * payload would read past the logical end of the packet
+		 * into skb->head tailroom.
+		 */
+		if (resid != sizeof(u64) || pktlen != sizeof(u64) ||
+		    bth_pad(pkt)) {
+			state = RESPST_ERR_LENGTH;
+			goto err;
+		}
+	} else if (pkt->mask & RXE_WRITE_MASK) {
 		if (resid > mtu) {
 			if (pktlen != mtu || bth_pad(pkt)) {
 				state = RESPST_ERR_LENGTH;
-- 
2.53.0


