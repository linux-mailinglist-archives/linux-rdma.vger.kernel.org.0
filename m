Return-Path: <linux-rdma+bounces-19086-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DPjHBP81GmgzQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19086-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 14:44:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA73AE903
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 376F0300D9E9
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD9C3B47C1;
	Tue,  7 Apr 2026 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h+d7RXO1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5163947A9;
	Tue,  7 Apr 2026 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565836; cv=none; b=W/bkfn/coqpHAvkQQ9jfw8RUQ6mStHDzxU5idIyeXcvfPD+aLmrK9VaB1QwOlQ9/ZPCwvtBGp/iWRhHSr/DUKo1wVYekSKVLfpWaC59MP7K70tqJB4VJWdzauLqvQoKWI5c1dRQP/2eerWthXycWl0npUkdiGF5ICKm0suoC1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565836; c=relaxed/simple;
	bh=jK2MvLGx29j9EQQ0DP63tStfQnBg8ZPc1l9iRZmgfAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCDtf8YLDvExF/oePV8p7TBPBzYnff/DzIhcUrp4Aa1tqU03DCnHVlrrpn90zUwrfNWpjti3YyxKW2Q8yug6RUYXuJQfJsIxguW3XRJH0gUlXWzON9iAvGSqS4ow5QrAXCktUtOndxoAJOR8fLkQ4TnEym4WY3EtaVDpaO+v2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h+d7RXO1; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775565830; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zbxmp0ZDStE2fex5F62p/4oiNfr/O/bKD9728qyhF9s=;
	b=h+d7RXO1EHO1bmtXsZbHuQDeu+SFPnLvNO/92ck/w/6YoqToxO1y8ktpHlwwMklCuuEq6ZV0BliNq5roW1MBlYAiTf6cBN+OUNFTXMaSvrr9o55I9OevF7uyslAT1OyxYOwG0pWosEm16JoiBlfWE90FmFHvp35c5xz8lvhoZcg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X0boJT7_1775565817;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X0boJT7_1775565817 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 20:43:49 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: [PATCH net-next v2] net/smc: cap allocation order for SMC-R physically contiguous buffers
Date: Tue,  7 Apr 2026 20:43:37 +0800
Message-ID: <20260407124337.88128-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19086-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33EA73AE903
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The alloc_pages() cannot satisfy requests exceeding MAX_PAGE_ORDER,
and attempting such allocations will lead to guaranteed failures
and potential kernel warnings.

For SMCR_PHYS_CONT_BUFS, cap the allocation order to MAX_PAGE_ORDER.
This ensures the attempts to allocate the largest possible physically
contiguous chunk succeed, instead of failing with an invalid order.
This also avoids redundant "try-fail-degrade" cycles in
__smc_buf_create().

For SMCR_MIXED_BUFS, no cap is needed: if the order exceeds
MAX_PAGE_ORDER, alloc_pages() will silently fail (__GFP_NOWARN)
and automatically fall back to virtual memory.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
Changes v1 -> v2:
https://lore.kernel.org/netdev/20260312082154.36971-1-alibuda@linux.alibaba.com/

- Move the bufsize cap from smcr_new_buf_create() up to
  __smc_buf_create(), which is simpler and avoids touching
  the allocation logic itself.
---
 net/smc/smc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index e2d083daeb7e..cdd881746e21 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2440,6 +2440,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		/* use socket send buffer size (w/o overhead) as start value */
 		bufsize = smc->sk.sk_sndbuf / 2;
 
+	/* limit bufsize for physically contiguous buffers */
+	if (!is_smcd && lgr->buf_type == SMCR_PHYS_CONT_BUFS)
+		bufsize = min_t(int, bufsize, (PAGE_SIZE << MAX_PAGE_ORDER));
+
 	for (bufsize_comp = smc_compress_bufsize(bufsize, is_smcd, is_rmb);
 	     bufsize_comp >= 0; bufsize_comp--) {
 		if (is_rmb) {
-- 
2.45.0


