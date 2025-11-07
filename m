Return-Path: <linux-rdma+bounces-14292-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AD9C3E44E
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 03:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBC3188AADA
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 02:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0852EF655;
	Fri,  7 Nov 2025 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qyqeRAc9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837B2836A6;
	Fri,  7 Nov 2025 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483254; cv=none; b=JmJnMDPkukrYOfnwhdaqn2UrUKq0bF7geJ11VDWjjYTmabiNaRToQW3wi75kVlbT7LBl1rTtQ0AnGQoJE1E4nj0HqvNSbQlnIKyDQwEr1+fDYJZtaNe4RrejaFiQbz3D6m4M9bR1/v0DIFexWjAtEarXGkJCj3n6XmkV1zyfa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483254; c=relaxed/simple;
	bh=dwpSkmElkGh1LRS0ks7/oopM5dv/Jp8g48HnjeBLQBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=udW1DoH90U1CuAiDyef07eh/UqhOlHn7kzuBhfcS01YmbCKTMBYESdW/rfAzJtWFqCEl1hwFa4BwJ6JNw3sKqCwGwxjfpV8jvNoyNd4gyUMc2tSJJ74cJHY5zkOSioHx6Ul1lrtdC7AdOiHocOlWWafgqv0Ck/Bp9cvM8A1fOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qyqeRAc9; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762483242; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=pTI5DBc3UKRNR1hP9tZKLFk12OxqbgOId5wrcE9LFdg=;
	b=qyqeRAc9jcO709A8lpOTZ190Q7zb4AS7jOiGq2ehbGAO1Armukj+AyiR6g82OknLJruyULKtjLRZG6RWd91bQSls22oFobDcJiv799H5gquzB6UkBrmpS9onVna1h8XLQPgtIXKIvgBU+zaAy0rUmcfn9Pu59Gd3SnIlLkTpNR4=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrrLdKG_1762483229 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 10:40:42 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: [PATCH net v2] net/smc: fix mismatch between CLC header and proposal
Date: Fri,  7 Nov 2025 10:40:29 +0800
Message-ID: <20251107024029.88753-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current CLC proposal message construction uses a mix of
`ini->smc_type_v1/v2` and `pclc_base->hdr.typev1/v2` to decide whether
to include optional extensions (IPv6 prefix extension for v1, and v2
extension). This leads to a critical inconsistency: when
`smc_clc_prfx_set()` fails - for example, in IPv6-only environments with
only link-local addresses, or when the local IP address and the outgoing
interface’s network address are not in the same subnet.

As a result, the proposal message is assembled using the stale
`ini->smc_type_v1` value—causing the IPv6 prefix extension to be
included even though the header indicates v1 is not supported.
The peer then receives a malformed CLC proposal where the header type
does not match the payload, and immediately resets the connection.

The fix ensures consistency between the CLC header flags and the actual
payload by synchronizing `ini->smc_type_v1` with `pclc_base->hdr.typev1`
when prefix setup fails.

Fixes: 8c3dca341aea ("net/smc: build and send V2 CLC proposal")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
v2: Update ini->smc_type_v1 on prefix setup failure to avoid stale values,
    as suggested by Alexandra Winter.

 net/smc/smc_clc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 157aace169d4..87c87edadde7 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -890,6 +890,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 				return SMC_CLC_DECL_CNFERR;
 			}
 			pclc_base->hdr.typev1 = SMC_TYPE_N;
+			ini->smc_type_v1 = SMC_TYPE_N;
 		} else {
 			pclc_base->iparea_offset = htons(sizeof(*pclc_smcd));
 			plen += sizeof(*pclc_prfx) +
-- 
2.45.0


