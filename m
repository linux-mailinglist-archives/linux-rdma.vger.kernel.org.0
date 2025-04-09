Return-Path: <linux-rdma+bounces-9285-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F63A82210
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E838A1F1F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673C25D551;
	Wed,  9 Apr 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KQAaueOq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187F25D906
	for <linux-rdma@vger.kernel.org>; Wed,  9 Apr 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194526; cv=none; b=e6sVU22gw/K9+GlcDJEaskKen89G2eHZQf8axxEGdXtaJidFaGuEgoa2yojcszgnlw4ywIBUfj8el4+k0elp4aaOdYDUCzRhRpEVslf6gMOCaxn6M4jtyrmIyuVJ8GHYMv12Vntpk60na2yQ0bsJTSQ6y9r2HC2yBf08F22TH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194526; c=relaxed/simple;
	bh=T3TOwGysfwLamzq6GLKiFAG9RIey81SKSm75tTpJJR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T3SfD6eCcy3rYkoFC9Q3lrRU9yhaYI7SmUUhE4mkWJ3MKNvW+qwvKCW5yS3Bl3C7iFPat1VIFoRCXVgdJtuzMwFiJSEutnKfwXL50y9nzHSDm/n9sOMjTuf5iFZ6rOanSaD30jHrRQw2R+lb3JiimQr0SHMtK6DnHRjZqazjZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KQAaueOq; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1744194523; x=1775730523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T3TOwGysfwLamzq6GLKiFAG9RIey81SKSm75tTpJJR8=;
  b=KQAaueOqpCwUmIBDbcgXShBY368TnOqwLoptU+u6lUKnz7stLeQjrVhs
   BijX2d4lR6Jqz8BlpcDtVdYqtC4S09aaX2nVM2PUrSt48n+Y7oBJYZOZr
   rt2aGH6eYVsgOVO7qWyp07DYkHk4Q2JTOqJzjUaoSjDRPYwkFmX/0ArTB
   zr1b5b/qcq0jf+C8JCVSmy+5BRuH/c9Q/TwVGzLnWy5mH3mn+bK5a4coh
   Heaz6LWF1oCaayZOl0/ryAKoiuRfB4jth+B+37jIL9a0D3rHgkaQ0Wycb
   oaw+mOjPyuxyJZDK04IX3Ic2W7xFvwMp+hmI9lfGnjEeeaCDHQxB78M7E
   Q==;
X-CSE-ConnectionGUID: e/fKjTWQRT6aZ2E1IhWdHg==
X-CSE-MsgGUID: EFQBWrCdSuOts8jI/DxyqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="174800377"
X-IronPort-AV: E=Sophos;i="6.15,200,1739804400"; 
   d="scan'208";a="174800377"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 19:27:33 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id DB8CAD6EA5
	for <linux-rdma@vger.kernel.org>; Wed,  9 Apr 2025 19:27:31 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id ACE99D50EC
	for <linux-rdma@vger.kernel.org>; Wed,  9 Apr 2025 19:27:31 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 6E28D2005364;
	Wed,  9 Apr 2025 19:27:31 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next] RDMA/rxe: Fix mismatched type declarations
Date: Wed,  9 Apr 2025 19:27:01 +0900
Message-Id: <20250409102701.1275265-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions return int values while they are defined as enum resp_states
variables. This patch resolve the mismatches in rxe.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h | 14 +++++++-------
 drivers/infiniband/sw/rxe/rxe_mr.c  | 12 ++++++------
 drivers/infiniband/sw/rxe/rxe_odp.c | 11 ++++++-----
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index d27bd05ed21f..a3ce64249357 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -70,9 +70,9 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
-int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
-			u64 compare, u64 swap_add, u64 *orig_val);
-int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
+enum resp_states rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+				     u64 compare, u64 swap_add, u64 *orig_val);
+enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
@@ -192,8 +192,8 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
 int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		    enum rxe_mr_copy_dir dir);
-int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
-			 u64 compare, u64 swap_add, u64 *orig_val);
+enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+				   u64 compare, u64 swap_add, u64 *orig_val);
 int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 			    unsigned int length);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
@@ -208,9 +208,9 @@ static inline int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 {
 	return -EOPNOTSUPP;
 }
-static inline int
+static inline enum resp_states
 rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
-		     u64 compare, u64 swap_add, u64 *orig_val)
+		  u64 compare, u64 swap_add, u64 *orig_val)
 {
 	return RESPST_ERR_UNSUPPORTED_OPCODE;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index d40fbe10633f..1a74013a14ab 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -483,8 +483,8 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 start, unsigned int length)
 /* Guarantee atomicity of atomic operations at the machine level. */
 DEFINE_SPINLOCK(atomic_ops_lock);
 
-int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
-			u64 compare, u64 swap_add, u64 *orig_val)
+enum resp_states rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+				     u64 compare, u64 swap_add, u64 *orig_val)
 {
 	unsigned int page_offset;
 	struct page *page;
@@ -536,12 +536,12 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 
 	kunmap_local(va);
 
-	return 0;
+	return RESPST_NONE;
 }
 
 #if defined CONFIG_64BIT
 /* only implemented or called for 64 bit architectures */
-int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
+enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 {
 	unsigned int page_offset;
 	struct page *page;
@@ -578,10 +578,10 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	smp_store_release(&va[page_offset >> 3], value);
 	kunmap_local(va);
 
-	return 0;
+	return RESPST_NONE;
 }
 #else
-int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
+enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 {
 	return RESPST_ERR_UNSUPPORTED_OPCODE;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 02de05d759c6..fa5e8f5017cc 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -266,8 +266,9 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	return err;
 }
 
-static int rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
-				u64 compare, u64 swap_add, u64 *orig_val)
+static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
+					     int opcode, u64 compare,
+					     u64 swap_add, u64 *orig_val)
 {
 	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
 	unsigned int page_offset;
@@ -315,11 +316,11 @@ static int rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 
 	kunmap_local(va);
 
-	return 0;
+	return RESPST_NONE;
 }
 
-int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
-			 u64 compare, u64 swap_add, u64 *orig_val)
+enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+				   u64 compare, u64 swap_add, u64 *orig_val)
 {
 	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
 	int err;
-- 
2.43.0


