Return-Path: <linux-rdma+bounces-22735-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Jk7LeU/R2o4UwAAu9opvQ
	(envelope-from <linux-rdma+bounces-22735-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 06:51:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674D6FE7E3
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 06:51:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z6h6enFZ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22735-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22735-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAE753021740
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 04:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C82B32B9A1;
	Fri,  3 Jul 2026 04:51:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165632B102
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2026 04:51:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054301; cv=none; b=ktGUW6OINoCgvAoNDHbiZ7d/rr1qaBG3kWv4e7ginz1+F5wWnAuXhaDUnQ/MWIsiuL4XDmP8OWT8yzrQNUFtV0LpDjSV1PBL/BY6CSX0BC8bc2JCQj7EWzG5dYMAU+43gcak9puz4wouk4hutrRh+E1y8XxEAkqTJ6gfQ4nv+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054301; c=relaxed/simple;
	bh=2iRP72x2mSftqmGmXZJMv5jLBQGTfZOb65AvOqE3su4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTY1MilkUCRFkCQQh5uJ3mEmsEhy7c2SkiOb+lpSF8MA/PGPYoHyvLwXj6qsvsyvTMaCunkWRPVuGVrAvwtvmjSel2UXmb94RDDOgV8nz/2tXRtwtMZa/h2JMtrSZysWLGprFJPDqzxJ2aYKRbKMuIUbjLJ8LRFUxa/8l7F4+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6h6enFZ; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9a20f70263so116872a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054289; x=1783659089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs4q6Awdw+1WsQdVj2MS9r8yavqNppIDcymWk9Cxfpo=;
        b=Z6h6enFZmqHr0ZmViqJdt+4UakR0mQRimcs1vSpgubMo6t5JR+yyKo2LOAhf0+mBq8
         32JdwpshDKNL3cGcZMiJfzHk5Gyv9KrVexB/zMc8wWuRCa0cbCXBHd+2Oc53UXxqw3w+
         vFA3O9zcmXBOeTYizB+hfw8eIWNrF+79D92KMqaY5ZN3kHSv7rCGg+m+Jaa1I2bSgUey
         FtjFsbI1SWtZPewyElQAovcUnrR7+TK3FUJoa3WHihOs6r9NRxZhid95jqgmAc9Do429
         GiEseq5QI9PdT7Jl7HW2h5EDqqnOH7RYKcuTVw/TFmCgGJDT59e+0goAgAmmZBSnqfxh
         R6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054289; x=1783659089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xs4q6Awdw+1WsQdVj2MS9r8yavqNppIDcymWk9Cxfpo=;
        b=tLOA0pJHsFTjY8EeX988tu1AUM0VjkcKLJdkogWwglnrZQXGoBOTxj/ieOnMhhmczg
         lfVX9k9N+JF/W8631atybEYAuJ3FcZ78rjT6K+dBLph89jgbrvHM428Lu2TONv9JR3x8
         ErUXHqQEgyCsv3pC2GiHizEAT+6trHaJgSTUtbkBaKxYuLLVdjg0bI+U1IhIt4isWEJ1
         MoLuMRGdbSHFWo8bX4XU9qCbSuT+KADmy+pE2DJJW9xo1mkPdwKoN7nxrYhYC0myMSJP
         DNRLjKOall7qtmBFFZzUZukCRbHRXtQzsI7LpjEU9LGHflSq5OoE8LHmTqxshkHrHqjH
         JcBA==
X-Forwarded-Encrypted: i=1; AFNElJ/PygY2vo5Un59JTKV2w2AK0t4sQYvTX3vZfQv9C9JfXRBQC8Kda7BO7jEOq9JVUHOgwFLFBtnaB/ij@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kr8ObZmDRqGWCN2Q9wvJG8O6ECmHFvF8gwsAbp2Vi79B4cHn
	pqvZHke7jADha3vXkmMg8lTGR6g+6cF8mZTY3cl6ImGulZv+9LWroner
X-Gm-Gg: AfdE7cn1fHuJAe1gzW5zW2dG9P5LDjD8xUTsR4UeiO9aQ0oLiLNU/oCzl/2oxztlOly
	clSqCJcHMd1UgixnTK51yKD9sxo4FMCxYr/u5YNYJQSZoOm3OKiOPDDggXvaRgFwwetNB6RBepf
	VaZzR7aiLzYm2LpHmWGanrPI9Typ310TxdsEbGcLNwJNW1ZWFn43XXAnFSP0LlSIg+lkACYTHkQ
	mGZQyrdlNzGahu7OJZ931CVkhLh7fekCuluxUgDBp0QsLgqvBPO+687vhOiiMGzu9X2yWVc9a/9
	b2LkQ7/X/WvvMNDdrQbKBUAsdJ5TsZ8r8ohcfbRko1p6h24GfyJEsmDwlHnD1q3i1AV7euv+JwP
	awPqwg3kSJgt8eiizSb3jg87PloQrt/Bmfffv89TFaZ69242B9ZyfO6ZUYVFPZamg9z6T3SoTBB
	S7hDs6fFnYXQZEqGSUzYml7Yv9SiOS
X-Received: by 2002:a05:6a20:3ca1:b0:3bf:6c27:387 with SMTP id adf61e73a8af0-3c01ca9b18dmr2890221637.25.1783054289352;
        Thu, 02 Jul 2026 21:51:29 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e920d7ffasm2027837a12.22.2026.07.02.21.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 21:51:28 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Cc: achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andy.grover@oracle.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	dstsmallbird@foxmail.com,
	bronzed_45_vested@icloud.com,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net: rds: reject oversized TCP receive messages
Date: Fri,  3 Jul 2026 12:51:09 +0800
Message-ID: <c83365078ea649d7ab2d9c198a445469bffb2550.1782850818.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782850818.git.bronzed_45_vested@icloud.com>
References: <cover.1782850818.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andy.grover@oracle.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:dstsmallbird@foxmail.com,m:bronzed_45_vested@icloud.com,m:enjou1224z@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22735-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[enjou1224z@gmail.com,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,oracle.com,gmail.com,foxmail.com,icloud.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enjou1224z@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,icloud.com:mid,icloud.com:email,foxmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5674D6FE7E3

From: Wyatt Feng <bronzed_45_vested@icloud.com>

RDS/TCP trusts the wire h_len value once the 48-byte RDS header has
been assembled. A peer can advertise a length larger than
RDS_MAX_MSG_SIZE and force unbounded receive-side reassembly growth by
streaming payload into ti_skb_list until memory is exhausted.

Validate h_len against the existing RDS_MAX_MSG_SIZE limit before any
payload is queued. If the header is oversized, tear down the partial
incoming message, stop tcp_read_sock() immediately, and drop the
connection as a protocol error.

This keeps the sender-side and receiver-side message size contract
consistent and fixes the resource exhaustion bug in the TCP receive
path.

Fixes: 70041088e3b9 ("RDS: Add TCP transport to RDS")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/rds/tcp_recv.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index ffe843ca219c..2044b8551b4f 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -205,9 +205,26 @@ static int rds_tcp_data_recv(read_descriptor_t *desc, struct sk_buff *skb,
 			offset += to_copy;
 
 			if (tc->t_tinc_hdr_rem == 0) {
+				u32 h_len;
+
+				h_len = be32_to_cpu(tinc->ti_inc.i_hdr.h_len);
+				if (h_len > RDS_MAX_MSG_SIZE) {
+					tc->t_tinc_hdr_rem = sizeof(struct rds_header);
+					tc->t_tinc_data_rem = 0;
+					tc->t_tinc = NULL;
+					rds_inc_put(&tinc->ti_inc);
+					tinc = NULL;
+					desc->count = 0;
+					desc->error = -EMSGSIZE;
+					rds_conn_path_error(cp,
+						"incoming message too large: %u bytes\n",
+						h_len);
+					left = 0;
+					goto out;
+				}
+
 				/* could be 0 for a 0 len message */
-				tc->t_tinc_data_rem =
-					be32_to_cpu(tinc->ti_inc.i_hdr.h_len);
+				tc->t_tinc_data_rem = h_len;
 				tinc->ti_inc.i_rx_lat_trace[RDS_MSG_RX_START] =
 					local_clock();
 			}
-- 
2.47.3

