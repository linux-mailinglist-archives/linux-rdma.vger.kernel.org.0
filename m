Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C4C4AE791
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 04:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242749AbiBIDD2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 22:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350947AbiBICyU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 21:54:20 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 18:54:18 PST
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6CEBC0613CC
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 18:54:18 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AASJTYaMq1BgazSnvrR2KlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQS/028igzUAzTNKCm7TO6zZYTT9fowgaoq2px5Q68DVm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yEmjfjQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/mjyPkMA3ysRlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSnsnZvUWou+eSZS4mYnJp6HcSFPozvJoJEI7J4sV/qBwG24?=
 =?us-ascii?q?m3fgZLi0dKwqPguue3r22UK9vi94lIc2tO5kQ0kyMZxmx4e0OGMiFGvuVo4QDm?=
 =?us-ascii?q?mpYuyyHJt6GD+JxVNalRE2oj8VzB2oq?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ax11Sq6oRvCdzxGYLMPf+ufsaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="121308281"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Feb 2022 10:53:14 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 64A1A4D169D1;
        Wed,  9 Feb 2022 10:53:10 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 9 Feb 2022 10:53:10 +0800
Received: from fedora35.g08.fujitsu.local (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 9 Feb 2022 10:53:11 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH rdma-core] libibverbs/examples: Add missing device attributes
Date:   Wed, 9 Feb 2022 10:53:08 +0800
Message-ID: <20220209025308.20743-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 64A1A4D169D1.A6CF0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

make ibv_devinfo command show more device attributes.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 libibverbs/examples/devinfo.c | 29 +++++++++++++++++++++++++----
 libibverbs/verbs.h            | 13 ++++++++++---
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index cef6e2ea..8e889842 100644
--- a/libibverbs/examples/devinfo.c
+++ b/libibverbs/examples/devinfo.c
@@ -267,7 +267,9 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
 				   IBV_DEVICE_MEM_WINDOW_TYPE_2B |
 				   IBV_DEVICE_RC_IP_CSUM |
 				   IBV_DEVICE_RAW_IP_CSUM |
-				   IBV_DEVICE_MANAGED_FLOW_STEERING);
+				   IBV_DEVICE_CROSS_CHANNEL |
+				   IBV_DEVICE_MANAGED_FLOW_STEERING |
+				   IBV_DEVICE_INTEGRITY_HANDOVER);
 
 	if (dev_cap_flags & IBV_DEVICE_RESIZE_MAX_WR)
 		printf("\t\t\t\t\tRESIZE_MAX_WR\n");
@@ -315,8 +317,12 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
 		printf("\t\t\t\t\tRC_IP_CSUM\n");
 	if (dev_cap_flags & IBV_DEVICE_RAW_IP_CSUM)
 		printf("\t\t\t\t\tRAW_IP_CSUM\n");
+	if (dev_cap_flags & IBV_DEVICE_CROSS_CHANNEL)
+		printf("\t\t\t\t\tCROSS_CHANNEL\n");
 	if (dev_cap_flags & IBV_DEVICE_MANAGED_FLOW_STEERING)
 		printf("\t\t\t\t\tMANAGED_FLOW_STEERING\n");
+	if (dev_cap_flags & IBV_DEVICE_INTEGRITY_HANDOVER)
+		printf("\t\t\t\t\tINTEGRITY_HANDOVER\n");
 	if (dev_cap_flags & unknown_flags)
 		printf("\t\t\t\t\tUnknown flags: 0x%" PRIX32 "\n",
 		       dev_cap_flags & unknown_flags);
@@ -382,13 +388,28 @@ static void print_odp_caps(const struct ibv_device_attr_ex *device_attr)
 static void print_device_cap_flags_ex(uint64_t device_cap_flags_ex)
 {
 	uint64_t ex_flags = device_cap_flags_ex & 0xffffffff00000000ULL;
-	uint64_t unknown_flags = ~(IBV_DEVICE_RAW_SCATTER_FCS |
-				   IBV_DEVICE_PCI_WRITE_END_PADDING);
-
+	uint64_t unknown_flags = ~(IBV_DEVICE_ON_DEMAND_PAGING |
+				   IBV_DEVICE_SG_GAPS_REG |
+				   IBV_DEVICE_VIRTUAL_FUNCTION |
+				   IBV_DEVICE_RAW_SCATTER_FCS |
+				   IBV_DEVICE_RDMA_NETDEV_OPA |
+				   IBV_DEVICE_PCI_WRITE_END_PADDING |
+				   IBV_DEVICE_ALLOW_USER_UNREG);
+
+	if (ex_flags & IBV_DEVICE_ON_DEMAND_PAGING)
+		printf("\t\t\t\t\tON_DEMAND_PAGING\n");
+	if (ex_flags & IBV_DEVICE_SG_GAPS_REG)
+		printf("\t\t\t\t\tSG_GAPS_REG\n");
+	if (ex_flags & IBV_DEVICE_VIRTUAL_FUNCTION)
+		printf("\t\t\t\t\tVIRTUAL_FUNCTION\n");
 	if (ex_flags & IBV_DEVICE_RAW_SCATTER_FCS)
 		printf("\t\t\t\t\tRAW_SCATTER_FCS\n");
+	if (ex_flags & IBV_DEVICE_RDMA_NETDEV_OPA)
+		printf("\t\t\t\t\tRDMA_NETDEV_OPA\n");
 	if (ex_flags & IBV_DEVICE_PCI_WRITE_END_PADDING)
 		printf("\t\t\t\t\tPCI_WRITE_END_PADDING\n");
+	if (ex_flags & IBV_DEVICE_ALLOW_USER_UNREG)
+		printf("\t\t\t\t\tALLOW_USER_UNREG\n");
 	if (ex_flags & unknown_flags)
 		printf("\t\t\t\t\tUnknown flags: 0x%" PRIX64 "\n",
 		       ex_flags & unknown_flags);
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index a9f182ff..68591c7b 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -136,7 +136,9 @@ enum ibv_device_cap_flags {
 	IBV_DEVICE_MEM_WINDOW_TYPE_2B	= 1 << 24,
 	IBV_DEVICE_RC_IP_CSUM		= 1 << 25,
 	IBV_DEVICE_RAW_IP_CSUM		= 1 << 26,
-	IBV_DEVICE_MANAGED_FLOW_STEERING = 1 << 29
+	IBV_DEVICE_CROSS_CHANNEL	= 1 << 27,
+	IBV_DEVICE_MANAGED_FLOW_STEERING = 1 << 29,
+	IBV_DEVICE_INTEGRITY_HANDOVER	= 1 << 30
 };
 
 enum ibv_fork_status {
@@ -149,8 +151,13 @@ enum ibv_fork_status {
  * Can't extended above ibv_device_cap_flags enum as in some systems/compilers
  * enum range is limited to 4 bytes.
  */
-#define IBV_DEVICE_RAW_SCATTER_FCS (1ULL << 34)
-#define IBV_DEVICE_PCI_WRITE_END_PADDING (1ULL << 36)
+#define IBV_DEVICE_ON_DEMAND_PAGING		(1ULL << 31)
+#define IBV_DEVICE_SG_GAPS_REG			(1ULL << 32)
+#define IBV_DEVICE_VIRTUAL_FUNCTION		(1ULL << 33)
+#define IBV_DEVICE_RAW_SCATTER_FCS		(1ULL << 34)
+#define IBV_DEVICE_RDMA_NETDEV_OPA		(1ULL << 35)
+#define IBV_DEVICE_PCI_WRITE_END_PADDING	(1ULL << 36)
+#define IBV_DEVICE_ALLOW_USER_UNREG		(1ULL << 37)
 
 enum ibv_atomic_cap {
 	IBV_ATOMIC_NONE,
-- 
2.34.1



