Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C64E3784
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Mar 2022 04:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiCVDbn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 23:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiCVDbm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 23:31:42 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B5D2403C2D
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 20:30:11 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Aq25oKKlBYI9spoCwt1Bq2ZPo5gy+JERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzFRx2ZMUW+OPK2IamT1edlwaIzgphlT756En9dmHlE++CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ2dxLuoz2S?=
 =?us-ascii?q?xYBMLDOmfgGTl9TFCQW0ahuoeWdcSbl75PJp6HBWz62qxl0N2kyMIoe0uV6G2d?=
 =?us-ascii?q?D8bofMj9lRhKMiMqw3rO3S+AqjcMmROHvPYUCqjR6wTTQJegpTIqFQKjQ49Jcm?=
 =?us-ascii?q?jAqiahz8Vz2DyYCQWM3Kk2ePFsUYRFKYK/SVdyA3hHXGwC0YnrJzUbv31Xu8Q?=
 =?us-ascii?q?=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A5G+s+andAx2ZS0xYrL8/t04kPKrpDfLE3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fxl6iV8sjzsiWE7Ar5OUtQ/uxoV5PhfZqxz/JICOoqTNKftWvdyQ?=
 =?us-ascii?q?iVxehZhOOIqVDd8kbFl9K1u50OT0EHMqyTMbFlt7eA3CCIV8Yn3MKc8L2lwcPX?=
 =?us-ascii?q?z3JWRwlsbK16hj0JczqzIwlnQhVcH5olGN657spDnTCpfnMadYCVHX8ANtKz3+?=
 =?us-ascii?q?Hjpdb3ZwIcHR475E2rhTOs0rTzFB+VxVM/flp0sNEfzVQ=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122862672"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Mar 2022 11:30:11 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 526F64D17160;
        Tue, 22 Mar 2022 11:30:06 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 22 Mar 2022 11:30:06 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 22 Mar 2022 11:30:06 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 1/2] IB/uverbs: Move enum ib_raw_packet_caps to uapi
Date:   Tue, 22 Mar 2022 11:30:01 +0800
Message-ID: <20220322033002.496195-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 526F64D17160.A6926
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

This enum is used by ibv_query_device_ex(3) so it should be defined
in include/uapi/rdma/ib_user_verbs.h.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 include/rdma/ib_verbs.h           | 19 ++++++++++++-------
 include/uapi/rdma/ib_user_verbs.h |  7 +++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 69d883f7fb41..e3ed65920558 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1620,20 +1620,25 @@ struct ib_srq {
 	struct rdma_restrack_entry res;
 };
 
+/* This enum is shared with userspace */
 enum ib_raw_packet_caps {
-	/* Strip cvlan from incoming packet and report it in the matching work
+	/*
+	 * Strip cvlan from incoming packet and report it in the matching work
 	 * completion is supported.
 	 */
-	IB_RAW_PACKET_CAP_CVLAN_STRIPPING	= (1 << 0),
-	/* Scatter FCS field of an incoming packet to host memory is supported.
+	IB_RAW_PACKET_CAP_CVLAN_STRIPPING =
+		IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING,
+	/*
+	 * Scatter FCS field of an incoming packet to host memory is supported.
 	 */
-	IB_RAW_PACKET_CAP_SCATTER_FCS		= (1 << 1),
+	IB_RAW_PACKET_CAP_SCATTER_FCS = IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS,
 	/* Checksum offloads are supported (for both send and receive). */
-	IB_RAW_PACKET_CAP_IP_CSUM		= (1 << 2),
-	/* When a packet is received for an RQ with no receive WQEs, the
+	IB_RAW_PACKET_CAP_IP_CSUM = IB_UVERBS_RAW_PACKET_CAP_IP_CSUM,
+	/*
+	 * When a packet is received for an RQ with no receive WQEs, the
 	 * packet processing is delayed.
 	 */
-	IB_RAW_PACKET_CAP_DELAY_DROP		= (1 << 3),
+	IB_RAW_PACKET_CAP_DELAY_DROP = IB_UVERBS_RAW_PACKET_CAP_DELAY_DROP,
 };
 
 enum ib_wq_type {
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 7ee73a0652f1..ff549695f1ba 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1298,4 +1298,11 @@ struct ib_uverbs_ex_modify_cq {
 
 #define IB_DEVICE_NAME_MAX 64
 
+enum ib_uverbs_raw_packet_caps {
+	IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING = 1 << 0,
+	IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS = 1 << 1,
+	IB_UVERBS_RAW_PACKET_CAP_IP_CSUM = 1 << 2,
+	IB_UVERBS_RAW_PACKET_CAP_DELAY_DROP = 1 << 3,
+};
+
 #endif /* IB_USER_VERBS_H */
-- 
2.23.0



