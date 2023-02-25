Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F096A28B7
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Feb 2023 11:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjBYKEZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Feb 2023 05:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBYKEX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Feb 2023 05:04:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9AD11678
        for <linux-rdma@vger.kernel.org>; Sat, 25 Feb 2023 02:04:21 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PP2NC64wbzRs6F;
        Sat, 25 Feb 2023 18:01:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 25 Feb 2023 18:04:19 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [RFC PATCH for-next 3/3] libhns: Add support for SVE Direct WQE function
Date:   Sat, 25 Feb 2023 18:02:53 +0800
Message-ID: <20230225100253.3993383-4-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
References: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The newly added SVE Direct WQE function only supports sve ldr and str
instructions, this patch adds ldr and str assembly to achieve this function.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
---
 CMakeLists.txt                   |  2 ++
 buildlib/RDMA_EnableCStd.cmake   |  7 +++++++
 providers/hns/CMakeLists.txt     |  2 ++
 providers/hns/hns_roce_u_hw_v2.c | 10 +++++++++-
 util/mmio.h                      | 11 +++++++++++
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 0cb68264..ee1024d5 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -417,6 +417,8 @@ endif()
 
 RDMA_Check_SSE(HAVE_TARGET_SSE)
 
+RDMA_Check_SVE(HAVE_TARGET_SVE)
+
 # Enable development support features
 # Prune unneeded shared libraries during linking
 RDMA_AddOptLDFlag(CMAKE_EXE_LINKER_FLAGS SUPPORTS_AS_NEEDED "-Wl,--as-needed")
diff --git a/buildlib/RDMA_EnableCStd.cmake b/buildlib/RDMA_EnableCStd.cmake
index 3c42824f..c6bd6603 100644
--- a/buildlib/RDMA_EnableCStd.cmake
+++ b/buildlib/RDMA_EnableCStd.cmake
@@ -127,3 +127,10 @@ int main(int argc, char *argv[])
   endif()
   set(${TO_VAR} "${HAVE_TARGET_SSE}" PARENT_SCOPE)
 endFunction()
+
+function(RDMA_Check_SVE TO_VAR)
+  RDMA_Check_C_Compiles(HAVE_TARGET_SVE "${SVE_CHECK_PROGRAM}")
+
+  set(SVE_FLAGS "-march=armv8.2-a+sve" PARENT_SCOPE)
+  set(${TO_VAR} "${HAVE_TARGET_SVE}" PARENT_SCOPE)
+endFunction()
diff --git a/providers/hns/CMakeLists.txt b/providers/hns/CMakeLists.txt
index 7aaca757..5c2bcf3b 100644
--- a/providers/hns/CMakeLists.txt
+++ b/providers/hns/CMakeLists.txt
@@ -5,3 +5,5 @@ rdma_provider(hns
   hns_roce_u_hw_v2.c
   hns_roce_u_verbs.c
 )
+
+set_source_files_properties(hns_roce_u_hw_v2.c PROPERTIES COMPILE_FLAGS "${SVE_FLAGS}")
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 3a294968..bd457217 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -299,6 +299,11 @@ static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
 	hns_roce_write64(qp->sq.db_reg, (__le32 *)&sq_db);
 }
 
+static void hns_roce_sve_write512(uint64_t *dest, uint64_t *val)
+{
+	mmio_memcpy_x64_sve(dest, val);
+}
+
 static void hns_roce_write512(uint64_t *dest, uint64_t *val)
 {
 	mmio_memcpy_x64(dest, val, sizeof(struct hns_roce_rc_sq_wqe));
@@ -314,7 +319,10 @@ static void hns_roce_write_dwqe(struct hns_roce_qp *qp, void *wqe)
 	hr_reg_write(rc_sq_wqe, RCWQE_DB_SL_H, qp->sl >> HNS_ROCE_SL_SHIFT);
 	hr_reg_write(rc_sq_wqe, RCWQE_WQE_IDX, qp->sq.head);
 
-	hns_roce_write512(qp->sq.db_reg, wqe);
+	if (qp->flags & HNS_ROCE_QP_CAP_SVE_DIRECT_WQE)
+		hns_roce_sve_write512(qp->sq.db_reg, wqe);
+	else
+		hns_roce_write512(qp->sq.db_reg, wqe);
 }
 
 static void update_cq_db(struct hns_roce_context *ctx, struct hns_roce_cq *cq)
diff --git a/util/mmio.h b/util/mmio.h
index b60935c4..13fd2654 100644
--- a/util/mmio.h
+++ b/util/mmio.h
@@ -207,6 +207,17 @@ __le64 mmio_read64_le(const void *addr);
 /* This strictly guarantees the order of TLP generation for the memory copy to
    be in ascending address order.
 */
+#if defined(__aarch64__) || defined(__arm__)
+static inline void mmio_memcpy_x64_sve(void *dest, const void *src)
+{
+	asm volatile(
+		"ldr z0, [%0]\n"
+		"str z0, [%1]\n"
+		::"r" (val), "r"(dest):"cc", "memory"
+	);
+}
+#endif
+
 #if defined(__aarch64__) || defined(__arm__)
 #include <arm_neon.h>
 
-- 
2.30.0

