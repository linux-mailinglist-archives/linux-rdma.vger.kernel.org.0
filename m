Return-Path: <linux-rdma+bounces-6682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B929F8FEC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 11:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D247418844DE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4D11BBBE5;
	Fri, 20 Dec 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="P8GIODH1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6561AAA3D;
	Fri, 20 Dec 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689477; cv=none; b=KQkyndbKTt9TvN1mwjd3d6SqPHEOQRqhx79O2ZK4TVCFY6gtbmo/d19BMaPGC/FRlFucOaEh9wlFwQqgYNm2qQEHKCbtBquzoAtF7OXP25LSQRGWnjxWSiTIX+h/vmvj17yH4Qz7GBzIW+lGzObgPljvPfHT9DF2djBnV8CJd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689477; c=relaxed/simple;
	bh=zx4hPGYCwbGuhynaTIxyB0Gari4320Pi0Yjoc5W3lHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9p/4WP91+/KThpQpogfkcgXlsX/g/9/L+sBBnf1jSBjGvwWlG2tMLpqh1ukiTOwRQTe1L5r+WgvFbLISys6O9NG+QnASI5WkdkMsMqt1ZPzAiVJwifDzTUOeHmN82SZAZ0WqEucorDBzfW54CxbDqKn+7AckivtSZolppOu//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=P8GIODH1; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734689475; x=1766225475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zx4hPGYCwbGuhynaTIxyB0Gari4320Pi0Yjoc5W3lHE=;
  b=P8GIODH1r1ffkb3Etl/dXnZjAbYH7ijlLxCPQqe5XnuPNP1t9BGYD3bq
   yeKIvdYhD6IXgWejg2zc/WQKxHSMofuz3tsZQVcUjgLTWkgZvwD8B82c8
   xja8cEh9Jv44o7aHHxZmmkNYHqCkOB45uHZ2m6SByyXJ3JwpcmSoDThrA
   oh7BHh7r0fDpLaZWcSWTyVUH9AojgTxewkFGWpFBQHckkc8hqJchv/6VQ
   58HyEL2tLG1Y4RzwWvnd7yB482816qAAOwWkQu16iIyt481fvaLT/N6X+
   7zuLUU70EX7mUBO7oXM5NkQmGQpF+HiEgs75X2REQXJSzfQUOPqWsCpRO
   w==;
X-CSE-ConnectionGUID: Z3oWk6dhR2C4J5JkeJ4Q4w==
X-CSE-MsgGUID: lYMkWzprSA6NSQH284s3Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="172794847"
X-IronPort-AV: E=Sophos;i="6.12,250,1728918000"; 
   d="scan'208";a="172794847"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 19:10:03 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id F07CDD6EA5;
	Fri, 20 Dec 2024 19:10:00 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id CA0D6D5070;
	Fri, 20 Dec 2024 19:10:00 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 9C9AB200597B;
	Fri, 20 Dec 2024 19:10:00 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v9 1/5] RDMA/rxe: Move some code to rxe_loc.h in preparation for ODP
Date: Fri, 20 Dec 2024 19:09:32 +0900
Message-Id: <20241220100936.2193541-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxe_mr_init() and resp_states are going to be used in rxe_odp.c, which is
to be created in the subsequent patch.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.h       | 37 ---------------------------
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h | 37 +++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index d8fb2c7af30a..193f7caffaf2 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -100,43 +100,6 @@
 #define rxe_info_mw(mw, fmt, ...) ibdev_info_ratelimited((mw)->ibmw.device, \
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
-/* responder states */
-enum resp_states {
-	RESPST_NONE,
-	RESPST_GET_REQ,
-	RESPST_CHK_PSN,
-	RESPST_CHK_OP_SEQ,
-	RESPST_CHK_OP_VALID,
-	RESPST_CHK_RESOURCE,
-	RESPST_CHK_LENGTH,
-	RESPST_CHK_RKEY,
-	RESPST_EXECUTE,
-	RESPST_READ_REPLY,
-	RESPST_ATOMIC_REPLY,
-	RESPST_ATOMIC_WRITE_REPLY,
-	RESPST_PROCESS_FLUSH,
-	RESPST_COMPLETE,
-	RESPST_ACKNOWLEDGE,
-	RESPST_CLEANUP,
-	RESPST_DUPLICATE_REQUEST,
-	RESPST_ERR_MALFORMED_WQE,
-	RESPST_ERR_UNSUPPORTED_OPCODE,
-	RESPST_ERR_MISALIGNED_ATOMIC,
-	RESPST_ERR_PSN_OUT_OF_SEQ,
-	RESPST_ERR_MISSING_OPCODE_FIRST,
-	RESPST_ERR_MISSING_OPCODE_LAST_C,
-	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
-	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
-	RESPST_ERR_RNR,
-	RESPST_ERR_RKEY_VIOLATION,
-	RESPST_ERR_INVALIDATE_RKEY,
-	RESPST_ERR_LENGTH,
-	RESPST_ERR_CQ_OVERFLOW,
-	RESPST_ERROR,
-	RESPST_DONE,
-	RESPST_EXIT,
-};
-
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index ded46119151b..1c78b9d36da4 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -58,6 +58,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
 u8 rxe_get_next_key(u32 last_key);
+void rxe_mr_init(int access, struct rxe_mr *mr);
 void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 		     int access, struct rxe_mr *mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index da3dee520876..12cacc4f60f2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -45,7 +45,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 	}
 }
 
-static void rxe_mr_init(int access, struct rxe_mr *mr)
+void rxe_mr_init(int access, struct rxe_mr *mr)
 {
 	u32 key = mr->elem.index << 8 | rxe_get_next_key(-1);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 3c1354f82283..e4656c7640f0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -126,6 +126,43 @@ struct rxe_comp_info {
 	u32			rnr_retry;
 };
 
+/* responder states */
+enum resp_states {
+	RESPST_NONE,
+	RESPST_GET_REQ,
+	RESPST_CHK_PSN,
+	RESPST_CHK_OP_SEQ,
+	RESPST_CHK_OP_VALID,
+	RESPST_CHK_RESOURCE,
+	RESPST_CHK_LENGTH,
+	RESPST_CHK_RKEY,
+	RESPST_EXECUTE,
+	RESPST_READ_REPLY,
+	RESPST_ATOMIC_REPLY,
+	RESPST_ATOMIC_WRITE_REPLY,
+	RESPST_PROCESS_FLUSH,
+	RESPST_COMPLETE,
+	RESPST_ACKNOWLEDGE,
+	RESPST_CLEANUP,
+	RESPST_DUPLICATE_REQUEST,
+	RESPST_ERR_MALFORMED_WQE,
+	RESPST_ERR_UNSUPPORTED_OPCODE,
+	RESPST_ERR_MISALIGNED_ATOMIC,
+	RESPST_ERR_PSN_OUT_OF_SEQ,
+	RESPST_ERR_MISSING_OPCODE_FIRST,
+	RESPST_ERR_MISSING_OPCODE_LAST_C,
+	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
+	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
+	RESPST_ERR_RNR,
+	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_INVALIDATE_RKEY,
+	RESPST_ERR_LENGTH,
+	RESPST_ERR_CQ_OVERFLOW,
+	RESPST_ERROR,
+	RESPST_DONE,
+	RESPST_EXIT,
+};
+
 enum rdatm_res_state {
 	rdatm_res_state_next,
 	rdatm_res_state_new,
-- 
2.43.0


