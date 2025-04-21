Return-Path: <linux-rdma+bounces-9622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD6A94B31
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 04:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7D43B17DB
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 02:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278BD18A92D;
	Mon, 21 Apr 2025 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KhwhsAf0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97766184;
	Mon, 21 Apr 2025 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745203945; cv=none; b=lf2Qpbj7N6gM9tUfwR2iJ/EQSso9mZrwnAnv6n44qYp3t6vzCKff1CmbaaLUe8VhLo8w3CwGXnSHH9ZG9npPdfbSKMvH34WKkkmqj4dCoM2XT7p8YxKLiC8c5PoSat9f2d95c68Jzxk8arqNbXK5P8koY/Z+wJ5PPtIgJbD6shE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745203945; c=relaxed/simple;
	bh=YBgTtw3/lIlfbTQBHcf3qYAkL4cxTN7AoK8utuCRMdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cfuKMiniqF1q4cIrI1PxzaYBqI50T5Z9gXSoprfYnU5U3UjUYTIOKIZX3FfXAmjcRohRniQ9ujcFmYd38gaTtiRhl4xFWZIVpCBFMr/00W2+ojas7IAK3XWyI7Cwv+oVXg4FYfPzFmiDoWC8QtvB3hYnc107ZQjlZb7CcCvub/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KhwhsAf0; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1745203943; x=1776739943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YBgTtw3/lIlfbTQBHcf3qYAkL4cxTN7AoK8utuCRMdQ=;
  b=KhwhsAf0Iicx9iA6BeQ+eb3kyA3MV3TyeKiH8MBQvjMoscPcIcNOjgov
   IcPpWggc/YwmwZl1Y/lPL8u9BPBzLLwZ2AYWaeoH3ziuEm2MYLPw2u/Y0
   mO+5/wkioelUM31mcZJ+PFSBQvZ6oMkRkixtNZMGx1ND2+IPQuHNKQ4ke
   uibExKt120oSTdHBlzj+At+TgmWVmG6f4f/XikNLayMFtRd2o4FuS/P1F
   0vRK1xjqRbs6ob9WUcTfTjiYiN14M/LiZ4QKHlmFq+Yfw+A+yYlfMp0jz
   ba8Sg5ac6rPQRqu5sVUBGP09SxtKf4gOGVbFUJ6Tj1BoxGwtE9r3+37OH
   Q==;
X-CSE-ConnectionGUID: wzGIF3pLRiS5YbKV61wv5w==
X-CSE-MsgGUID: XFr7jYBLSoWvcvm9BbBuxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="185091490"
X-IronPort-AV: E=Sophos;i="6.15,227,1739804400"; 
   d="scan'208";a="185091490"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 11:51:11 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 51D46D4C4A;
	Mon, 21 Apr 2025 11:51:09 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 160FDD7480;
	Mon, 21 Apr 2025 11:51:09 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id ADA172025C18;
	Mon, 21 Apr 2025 11:51:08 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next] RDMA/rxe: Remove 32-bit architecture support
Date: Mon, 21 Apr 2025 11:51:01 +0900
Message-Id: <20250421025101.3588139-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Major linux distibutions have phased out support for 32-bit machines. Since
rxe is primarily used for development and testing, the benefit of
maintaining 32-bit support is minimal. This change simplifies ATOMIC WRITE
implementations and improves maintainability of the driver.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/Kconfig     | 2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   | 6 +-----
 drivers/infiniband/sw/rxe/rxe_mr.c    | 8 --------
 drivers/infiniband/sw/rxe/rxe_odp.c   | 1 -
 drivers/infiniband/sw/rxe/rxe_param.h | 5 +----
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
index c180e7ebcfc5..1ed5b63f8afc 100644
--- a/drivers/infiniband/sw/rxe/Kconfig
+++ b/drivers/infiniband/sw/rxe/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config RDMA_RXE
 	tristate "Software RDMA over Ethernet (RoCE) driver"
-	depends on INET && PCI && INFINIBAND
+	depends on INET && PCI && INFINIBAND && 64BIT
 	depends on INFINIBAND_VIRT_DMA
 	select NET_UDP_TUNNEL
 	select CRC32
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 30fa83c9c846..f7dbb9cddd12 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -196,6 +196,7 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 				   u64 compare, u64 swap_add, u64 *orig_val);
 int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 			    unsigned int length);
+enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -219,11 +220,6 @@ static inline int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 {
 	return -EOPNOTSUPP;
 }
-#endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
-
-#ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
-enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
-#else
 static inline enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr,
 						       u64 iova, u64 value)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 1a74013a14ab..c4936d63e26a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -539,8 +539,6 @@ enum resp_states rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	return RESPST_NONE;
 }
 
-#if defined CONFIG_64BIT
-/* only implemented or called for 64 bit architectures */
 enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 {
 	unsigned int page_offset;
@@ -580,12 +578,6 @@ enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 
 	return RESPST_NONE;
 }
-#else
-enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
-{
-	return RESPST_ERR_UNSUPPORTED_OPCODE;
-}
-#endif
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index fa5e8f5017cc..6149d9ffe7f7 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -380,7 +380,6 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 	return 0;
 }
 
-/* CONFIG_64BIT=y */
 enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 {
 	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 003f681e5dc0..767870568372 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -53,12 +53,9 @@ enum rxe_device_param {
 					| IB_DEVICE_MEM_WINDOW
 					| IB_DEVICE_FLUSH_GLOBAL
 					| IB_DEVICE_FLUSH_PERSISTENT
-#ifdef CONFIG_64BIT
 					| IB_DEVICE_MEM_WINDOW_TYPE_2B
 					| IB_DEVICE_ATOMIC_WRITE,
-#else
-					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
-#endif /* CONFIG_64BIT */
+
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
 					  sizeof(struct ib_sge) * RXE_MAX_SGE,
-- 
2.43.0


