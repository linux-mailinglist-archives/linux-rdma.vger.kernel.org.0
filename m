Return-Path: <linux-rdma+bounces-5325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C6995D8F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA8284F47
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3646F307;
	Wed,  9 Oct 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CL5XCxuZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786844C76;
	Wed,  9 Oct 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439230; cv=none; b=OZJ4fJMI+NNGAuECXqs2rImXL+7Yy5rdXDdE43VSJMS4FYoTN9WnluEQvBlRaTxpi1YUWNl4YAwWbeCdpjf1E3FCU56buvxTj3zoGXS+AQTaIGxj5Cz4a4iJX8pUZ0KmzYuzB6vJ4q07nw449AOXnYMWpAQDiXwoUJCF/ErFosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439230; c=relaxed/simple;
	bh=DCN06ZCZ0OXI4HvhqoRJXSb6/HyodGvvvDu/w3aueTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ly3yuDmtbu1IaPdB7oDQHm6x63EKfzpm1Wa8oV1PLSrsNGOneyN1IlQPnX60MV5erWJR95o3TORP9RDKbyOSw1N1J2PPdDVzEuBdTvWlcAJJjsIV/qISPaGhUwj/k5NugSdFAQOqBc1RwCG/SOY9qpGT3r9Od1FWb39yVo0VcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CL5XCxuZ; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728439228; x=1759975228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DCN06ZCZ0OXI4HvhqoRJXSb6/HyodGvvvDu/w3aueTk=;
  b=CL5XCxuZVT9tmEfOn8gBIZEoIPwmtkOLk/+My3Y4gTNkGCfGzZM1WvyE
   /2LJCpBt58u+9ODf3jl3WRu7m0NMlCHHJXQaG8K5ETYOS2df8udGVwRIl
   m/XIc5dQII/L1i2OxMhd0usAUeydQXlb6ZpDJ4hAyD4EoWTAkBbiWQgy1
   nONmp5eMbakhnqGPDA/zm2YvdHUrGfDpV6IolIG/2RMx226g9NU+5ldsU
   NPJkYRf4H99APcSan7RsCD4/Dht5no1i4RfNKR1br+OjH800BYxjekHTD
   GC7jjcbW8lmGl7jdE9fp2PkPP19rPw6hKgUz1c8791QG1miJ69/2ysUpE
   Q==;
X-CSE-ConnectionGUID: Zr8jA1exRCKCtCAFLc71fw==
X-CSE-MsgGUID: rlJm++mIQ7uI210WAhbV5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="164552987"
X-IronPort-AV: E=Sophos;i="6.11,188,1725289200"; 
   d="scan'208";a="164552987"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 10:59:22 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 19ADFC68E2;
	Wed,  9 Oct 2024 10:59:20 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 64BA6F75C;
	Wed,  9 Oct 2024 10:59:19 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 398802005356;
	Wed,  9 Oct 2024 10:59:19 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v8 1/6] RDMA/rxe: Make MR functions accessible from other rxe source code
Date: Wed,  9 Oct 2024 10:58:58 +0900
Message-Id: <20241009015903.801987-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Some functions in rxe_mr.c are going to be used in rxe_odp.c, which is to
be created in the subsequent patch. List the declarations of the functions
in rxe_loc.h.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  8 ++++++++
 drivers/infiniband/sw/rxe/rxe_mr.c  | 11 +++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index ded46119151b..866c36533b53 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -58,6 +58,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
 u8 rxe_get_next_key(u32 last_key);
+void rxe_mr_init(int access, struct rxe_mr *mr);
 void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 		     int access, struct rxe_mr *mr);
@@ -69,6 +70,8 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
+int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
+		       unsigned int length, enum rxe_mr_copy_dir dir);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
 int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
@@ -80,6 +83,11 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 void rxe_mr_cleanup(struct rxe_pool_elem *elem);
 
+static inline unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
+{
+	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
+}
+
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index da3dee520876..1f7b8cf93adc 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -45,7 +45,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 	}
 }
 
-static void rxe_mr_init(int access, struct rxe_mr *mr)
+void rxe_mr_init(int access, struct rxe_mr *mr)
 {
 	u32 key = mr->elem.index << 8 | rxe_get_next_key(-1);
 
@@ -72,11 +72,6 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 	mr->ibmr.type = IB_MR_TYPE_DMA;
 }
 
-static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
-{
-	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
-}
-
 static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
 {
 	return iova & (mr_page_size(mr) - 1);
@@ -242,8 +237,8 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
 }
 
-static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
-			      unsigned int length, enum rxe_mr_copy_dir dir)
+int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
+		       unsigned int length, enum rxe_mr_copy_dir dir)
 {
 	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
 	unsigned long index = rxe_mr_iova_to_index(mr, iova);
-- 
2.43.0


