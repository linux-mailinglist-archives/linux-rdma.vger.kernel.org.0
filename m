Return-Path: <linux-rdma+bounces-18074-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD1yGD14sml/MwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18074-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:24:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFF26EDF0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B344630783AC
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823F346770;
	Thu, 12 Mar 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zvan+lBK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E340DFDC;
	Thu, 12 Mar 2026 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303724; cv=none; b=tV58ehJ+a006+PyB9E3LKNF48j79zaT7AC9notV5PBnd6O9WragEQg7BVBSgzFDQiqjp3xI34113C6QAp9a8bUHScgAyZJkdrrS0HdFn6xkbs5kaV4Xf2nSITCzz4TwYDqBLr5pP3RDL1vdnq+nDZ/+zhDRhjB5FV5y1syGlzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303724; c=relaxed/simple;
	bh=q/azlWKjAp4we7q6Qx+4F63Asl3fpuCKmfeBqyy8J90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gjo4QJMjaz/ORG4YzJwmdQesZs9PUi98Fap1l9tVMeY8n0oND1zDmo0dvSANmrbi0+JBvuabs++UMZQj/6JHUJi7rmSj1L6KEEXebYPmnz7+BGW10fI3aO1YSzZ21RCjw286L3xgYRPBB0ABVuoOvtA9+nxMr2owi8cua9IzqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zvan+lBK; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773303720; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QRs3heLeiIPoQjVY6D6mQ+vxJzYydmVXlCV3tRwqkKs=;
	b=Zvan+lBKqzsNTJCdRNpZK/4cSD7ToQgTi43Tq4xlOb7UmDJWBAHt7CmWpphhnkhQVCACoZrf9sbg26KrQuXzeHNSu1JZVlCioNr6Fv8rjbcv/qFoPvDpARBZrIvaLFrexUXmSQO2TPuAZbVQSOXWFgGpxqZBbeqcDDQE7PFAFbk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X-nrvgb_1773303715;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X-nrvgb_1773303715 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Mar 2026 16:21:59 +0800
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
Subject: [PATCH net-next] net/smc: cap allocation order for SMC-R physically contiguous buffers
Date: Thu, 12 Mar 2026 16:21:54 +0800
Message-ID: <20260312082154.36971-1-alibuda@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18074-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2DFF26EDF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The alloc_page() cannot satisfy requests exceeding MAX_PAGE_ORDER,
and attempting such allocations will lead to guaranteed failures
and potential kernel warnings.

For SMCR_PHYS_CONT_BUFS, cap the allocation order to MAX_PAGE_ORDER.
This ensures the attempts to allocate the largest possible physically
contiguous chunk succeed, instead of failing with an invalid order.
This also avoids redundant "try-fail-degrade" cycles in
__smc_buf_create().

For SMCR_MIXED_BUFS, if its order exceeds MAX_PAGE_ORDER, skip the
doomed physical allocation attempt and fallback to virtual memory
immediately.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/smc_core.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index e2d083daeb7e..a18730edb7e0 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2314,6 +2314,10 @@ int smcr_buf_reg_lgr(struct smc_link *lnk)
 	return rc;
 }
 
+/*
+ * smcr_new_buf_create may allocate a buffer smaller than the requested
+ * bufsize. Use buf_desc->len to determine the actual allocated size.
+ */
 static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
 						int bufsize)
 {
@@ -2326,18 +2330,22 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
 
 	switch (lgr->buf_type) {
 	case SMCR_PHYS_CONT_BUFS:
+		bufsize = min(bufsize, (int)PAGE_SIZE << MAX_PAGE_ORDER);
+		fallthrough;
 	case SMCR_MIXED_BUFS:
 		buf_desc->order = get_order(bufsize);
-		buf_desc->pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
-					      __GFP_NOMEMALLOC | __GFP_COMP |
-					      __GFP_NORETRY | __GFP_ZERO,
-					      buf_desc->order);
-		if (buf_desc->pages) {
-			buf_desc->cpu_addr =
-				(void *)page_address(buf_desc->pages);
-			buf_desc->len = bufsize;
-			buf_desc->is_vm = false;
-			break;
+		if (buf_desc->order <= MAX_PAGE_ORDER) {
+			buf_desc->pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
+						      __GFP_NOMEMALLOC | __GFP_COMP |
+						      __GFP_NORETRY | __GFP_ZERO,
+						      buf_desc->order);
+			if (buf_desc->pages) {
+				buf_desc->cpu_addr =
+					(void *)page_address(buf_desc->pages);
+				buf_desc->len = bufsize;
+				buf_desc->is_vm = false;
+				break;
+			}
 		}
 		if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
 			goto out;
@@ -2476,7 +2484,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		}
 
 		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
-		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
+		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, buf_desc->len);
 		buf_desc->used = 1;
 		down_write(lock);
 		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
-- 
2.45.0


