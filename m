Return-Path: <linux-rdma+bounces-20598-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPtzLp66BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20598-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:53:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A0C53860B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77561300D1C2
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7804DD6C0;
	Wed, 13 May 2026 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MudqVIS4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0554C9542
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694811; cv=none; b=Emr9gM3Ax+3YsVxf+BKyYo/OkyQmMYlBx9cAVLttra2TrBLu5GQ8d4f6EFTAYbQ2RzJ6ImLXZyV86qroS7gMTumyrcBKBfKaLQo4U/1w1TlI7vYLOqkRsA8elD/Jw9FtuTsb4OxM1SUHIOY7cSgoSCfUhzuM/MZOwy5IzTKS3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694811; c=relaxed/simple;
	bh=EQ4MYxskE0lYtC8XPV/NocVxlYCWxw9+uUFSKNZhNpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHAGJQ7e3pgAsV5nWj8oTkuF9hhzUV8IHq/raNzr6A7WDRBs6tloWi2XHsg/f8P3EixUz6UFR2j4rQGan6J/BuLr+EEEk3kFzrL1/xwVfncObpI64LrYzS/NL8DnCjVQzJ2NJakEUlgei6J5G2qdY9/JSq9Z+WE+OjwSWGvx+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MudqVIS4; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so107306016d6.2
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778694809; x=1779299609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ayiddnyLyvk5j8vikm+y7Z1odGVhjZ1CBk7OhZOJKg=;
        b=MudqVIS4/mF7LlQ/QH1Zw0rLQ8X4SLJ3djO/+ryidarHfdiNuuRSlJ5TeMmiY1Y7qa
         T+libQKQ+ApHnrM/KCRb8bkVeb271DV1eCup3DtLnHmqmtqeDeLU42EGS7B8YjABIkKD
         FxgOLe2mHevjXaLaabOXp0BtuatAF3jkffzoJE83OLq7CKvVU5gxZX+tXoty8Zdlyf/y
         XGDdg8Rb4OxCq5tI3gfZlZ6tjfPZ6LuztsdHqgwf33MItmyKW7kenhBEYfO8yDRNP6TJ
         qrATCDxhtCuxi+tMg7TocEUO/BgpmjNaJ6tfBIqjc8TsSgcC2QPFbujxOhgOLpC/Q7ui
         w0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694809; x=1779299609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ayiddnyLyvk5j8vikm+y7Z1odGVhjZ1CBk7OhZOJKg=;
        b=F6fucHig8i7JcOO58WUysjy2McR5Wvqgmd5kUnHQkSLgfNkwCkvPZOAZMtZeMXAqol
         2YpHQLbCV4QZPEPvOS/xmSu2nZxvNdoCBNNy1Bly66FGvA73gWwEPAyKogO5JVSHtX2E
         +Ond+GO7r9jVmCJaCOzE/znbIsqmnvPXSIGsmSQZzIPYhCTpQ9/8YjytLZHbljzrFH3g
         bUazz8O0n3VW76t0UoUZeywr33Z4sj0oMG0DdEpKngcDsdGY97pxNE07xNTxhp2OOAt6
         Inuvb9L4BqdzctVKxD2gF/cXOeuE0vmrxTR+J+QycVjPl0MDAPy92Bo7YtoZkD8Ch2V0
         lzlg==
X-Forwarded-Encrypted: i=1; AFNElJ+u9Hz+rcFhq1TFaJPiWwNKwyw+uWd8/WgjVRVuUSIBSlQAxZxqefHxdxz+U/q3uP0P073ROvrHs9Ln@vger.kernel.org
X-Gm-Message-State: AOJu0YwnR+j/rfsdX1gnQ5yjj3hom2bdLkrHSla/DAm06RpESLM6PxDn
	PeS7LxhXEdGE8g7kBtPs3aE9JANvNeDOaJcz22gya2oV3x2qD4By6EFGa9lsJ012
X-Gm-Gg: Acq92OG4JkmmR7T//bbMHcbBqTuGq44USDvu0bQrm4qk9Fw/++A59BDxueHj+Kr6Dgb
	qWf6XxCQFfa1PTZ2qEy7QWYtIp3CURft+XYOxKSAwDgl1xPK0iNIgH1RyaiK7goT5XtWz40aKqf
	qMwQ/iFUfYIR2wxMWq3YIbsFzf3qbC8tWB+ywzDNRq4PfdarFfmflWlAWXKx7+g8PcRwYqq0Z4U
	z1iXXuALAsuOSpqouagevlJoZL9ugsAgz+ecOLTMFEaNnYJ7XWGqO4dlDFOOadXvH1RR5L1nW5R
	ZZyP0A3VKekdvYT72Qh9hMt7OPqm66hTC+MuUJ/nw1NWy5DCGOSQMrGtQrdE1b1SsiiIpipIUoe
	ghye7Z50mq4yZCVsfQiZuV0oKtS0YOEKg0UVMvCXWKxnFjtK0L9XC8JXCBpqe10JR6aCxOANfpD
	3CHiOWc5HfqW7D6kdwCUKOA2Tl9C7c8zErlXrkKQDNf90cb5Tg7jrVn/nU2Tocc2ilhwLR/Kw/J
	Q7ZlPlXg92k/JNe9vtwkgX8DoslLGQDP7CSnjkrOoU9sTAFwKUjCw==
X-Received: by 2002:a0c:f119:0:b0:8ac:a689:34ce with SMTP id 6a1803df08f44-8c7bdc83746mr54170006d6.45.1778694809391;
        Wed, 13 May 2026 10:53:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bf6720asm2036946d6.39.2026.05.13.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:53:28 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] RDMA/siw: reject MPA FPDU length underflow before signed receive math
Date: Wed, 13 May 2026 13:53:24 -0400
Message-ID: <20260513175325.2042630-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513175325.2042630-1-michael.bommarito@gmail.com>
References: <20260513175325.2042630-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62A0C53860B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20598-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A malicious connected siw peer can send an iWARP FPDU whose MPA length
field (c_hdr->mpa_len, 16 bit big-endian, peer-controlled) is smaller
than the fixed DDP/RDMAP header for the announced opcode. Soft-iWARP
parses the full header in siw_get_hdr() based on iwarp_pktinfo[opcode]
.hdr_len, but never compares mpa_len against that header length.

siw_tcp_rx_data() then derives

    srx->fpdu_part_rem = be16_to_cpu(mpa_len) - fpdu_part_rcvd
                         + MPA_HDR_SIZE;

where fpdu_part_rcvd equals iwarp_pktinfo[opcode].hdr_len at this
point. For a tagged WRITE (hdr_len 16, MPA_HDR_SIZE 2) the smallest
on-wire mpa_len of 0 yields fpdu_part_rem = -14, and any mpa_len below
hdr_len - MPA_HDR_SIZE underflows to a negative int.

The signed value then flows into siw_proc_write()/siw_proc_rresp() as

    bytes = min(srx->fpdu_part_rem, srx->skb_new);

is handed to siw_check_mem() as an int len (whose interval check
addr + len > mem->va + mem->len is satisfied for a valid base when
len is negative), and reaches siw_rx_data() -> siw_rx_kva() /
siw_rx_umem() -> skb_copy_bits() as a signed copy length. The header
copy branch in skb_copy_bits() promotes that to size_t, producing a
multi-gigabyte read.

KASAN under a KUnit harness that drives the real kernel TCP receive
path -- a loopback AF_INET socketpair, the malformed FPDU written via
kernel_sendmsg, sk_data_ready firing in softirq, tcp_read_sock
dispatching to siw_tcp_rx_data -- reports:

    BUG: KASAN: use-after-free in skb_copy_bits+0x284/0x480
    Read of size 4294967295 at addr ffff888...
    Call Trace:
     skb_copy_bits
     siw_rx_kva
     siw_rx_data
     siw_check_mem
     siw_proc_write
     siw_tcp_rx_data
     __tcp_read_sock
     siw_qp_llp_data_ready
     tcp_data_ready
     tcp_data_queue

Add the missing invariant at the earliest point where the peer header
is fully assembled. iwarp_pktinfo[*].hdr_len - MPA_HDR_SIZE is exactly
the value the siw transmitter uses as the minimum mpa_len for each
opcode (drivers/infiniband/sw/siw/siw_qp.c:33), so this matches the
protocol contract. Out-of-range FPDUs terminate the connection with
TERM_ERROR_LAYER_LLP / LLP_ETYPE_MPA / LLP_ECODE_FPDU_START -- which
is RFC 5044 Section 8 error code 3 ("Marker and ULPDU Length fields
do not agree on the start of an FPDU"), the correct framing-error
class for this inconsistency.

Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
See cover letter for full root cause, series rationale, and test
summary.  [2/2] adds the KUnit regression harness used to validate
this fix.

 drivers/infiniband/sw/siw/siw_qp_rx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index e8a88b378d51..34d03584160c 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -1081,6 +1081,21 @@ static int siw_get_hdr(struct siw_rx_stream *srx)
 			return -EAGAIN;
 	}
 
+	/*
+	 * Peer-controlled mpa_len must not underflow srx->fpdu_part_rem
+	 * in siw_tcp_rx_data(); a negative value flows as a signed copy
+	 * length into siw_check_mem() and skb_copy_bits().
+	 */
+	if (unlikely(be16_to_cpu(c_hdr->mpa_len) + MPA_HDR_SIZE <
+		     iwarp_pktinfo[opcode].hdr_len)) {
+		pr_warn_ratelimited("siw: short mpa_len %u for opcode %u (hdr_len %u)\n",
+				    be16_to_cpu(c_hdr->mpa_len), opcode,
+				    iwarp_pktinfo[opcode].hdr_len);
+		siw_init_terminate(rx_qp(srx), TERM_ERROR_LAYER_LLP,
+				   LLP_ETYPE_MPA, LLP_ECODE_FPDU_START, 0);
+		return -EINVAL;
+	}
+
 	/*
 	 * DDP/RDMAP header receive completed. Check if the current
 	 * DDP segment starts a new RDMAP message or continues a previously
-- 
2.53.0


