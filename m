Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492184DE973
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 18:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbiCSRFn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiCSRFm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 13:05:42 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 241FA192362
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 10:04:20 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AlTEkfKqVMkZypdaSWiAF1ciUG1NeBmInZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjRLCzyPM6neZGqkKdhyad+/pk4GucKEyNZlSAdv/iswQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlpJW2R?=
 =?us-ascii?q?hdvPLzklvkfUgVDDmd1OqguFLrveCLl4ZXLnxefG5fr67A0ZK0sBqUc9+FxKWJ?=
 =?us-ascii?q?D7/oVLHYKdB/rr+C5z5q9VOhgh81lJ87uVKsbu3d93XTDAfMvaY7MTr+M5tJC2?=
 =?us-ascii?q?jo0wMdUEp7ji2AxAdZ0RE2YJUQRZRFMU9Rj9NpET0LXK1VwwG95b4Jui4QL8DF?=
 =?us-ascii?q?M7Q=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A3Nje2aoJKSbMRM0u0VSQTSwaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122810821"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Mar 2022 01:04:16 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5BCAC4D16FCD;
        Sun, 20 Mar 2022 01:04:14 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 20 Mar 2022 01:04:15 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 20 Mar 2022 01:03:53 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 1/2] IB/uverbs: Move enum ib_raw_packet_caps to uapi
Date:   Sun, 20 Mar 2022 01:03:50 +0800
Message-ID: <20220319170351.336731-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5BCAC4D16FCD.AA8ED
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

This enum are used by ibv_query_device_ex(3) so it should be defined
in include/uapi/rdma/ib_user_verbs.h.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 include/rdma/ib_verbs.h           | 22 +++++++++++++++-------
 include/uapi/rdma/ib_user_verbs.h |  7 +++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 69d883f7fb41..e5455f6e0d82 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1620,20 +1620,28 @@ struct ib_srq {
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
+	IB_RAW_PACKET_CAP_CVLAN_STRIPPING	=
+		IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING,
+	/*
+	 * Scatter FCS field of an incoming packet to host memory is supported.
 	 */
-	IB_RAW_PACKET_CAP_SCATTER_FCS		= (1 << 1),
+	IB_RAW_PACKET_CAP_SCATTER_FCS		=
+		IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS,
 	/* Checksum offloads are supported (for both send and receive). */
-	IB_RAW_PACKET_CAP_IP_CSUM		= (1 << 2),
-	/* When a packet is received for an RQ with no receive WQEs, the
+	IB_RAW_PACKET_CAP_IP_CSUM		=
+		IB_UVERBS_RAW_PACKET_CAP_IP_CSUM,
+	/*
+	 * When a packet is received for an RQ with no receive WQEs, the
 	 * packet processing is delayed.
 	 */
-	IB_RAW_PACKET_CAP_DELAY_DROP		= (1 << 3),
+	IB_RAW_PACKET_CAP_DELAY_DROP		=
+		IB_UVERBS_RAW_PACKET_CAP_DELAY_DROP,
 };
 
 enum ib_wq_type {
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 7ee73a0652f1..0660405ca2cb 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1298,4 +1298,11 @@ struct ib_uverbs_ex_modify_cq {
 
 #define IB_DEVICE_NAME_MAX 64
 
+enum ib_uverbs_raw_packet_caps {
+	IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING	= (1 << 0),
+	IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS		= (1 << 1),
+	IB_UVERBS_RAW_PACKET_CAP_IP_CSUM		= (1 << 2),
+	IB_UVERBS_RAW_PACKET_CAP_DELAY_DROP		= (1 << 3),
+};
+
 #endif /* IB_USER_VERBS_H */
-- 
2.23.0



