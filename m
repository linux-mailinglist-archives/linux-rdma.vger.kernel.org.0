Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109C4E9B5E
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 17:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbiC1Prg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiC1Pr3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 11:47:29 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B2F3633B2
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 08:45:20 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A6RmbCKszVb28AAvwuZ6+ioawHufnVGlcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3nGRMCG7XaKnYMWv8f4gjbNjg8hwHu8XXyNNjGwFopCpgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1cvJq/W?=
 =?us-ascii?q?UErL4XCheYcTwJFVSp5OMWq/ZeeeyPn6pHPlhaun3zEhq8G4FsNFYkV/eBfAmx?=
 =?us-ascii?q?U8/EcbjcXYXirhe256LSlS+Vtj4IoK8yDFIcevGxwiCvVCP8OX5/OWePJ6MVe0?=
 =?us-ascii?q?TN2gdpBdcsyzeJxhSFHNUyGOkMQfAxMTs9WoQthvVGnGxUwlb5fjfZfD7Dv8TF?=
 =?us-ascii?q?M?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyNLCDaw/bvcDe8X+xPDsKrPwxL1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SKKlfqeV7ZAmPH7P+VEssR4b+exoVJPtfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBR+sO0WKI+Vzd8kPFmdK1rZ0QEZSWFueAdmRSvILr5hWiCdY8zJ2i+KCsv+3X?=
 =?us-ascii?q?yHBgVmhRGthdxjY8GgCGCVd3WQUDIZI4EaCX7s1BqyHlVm8Qaq2AdwE4dtmGt9?=
 =?us-ascii?q?vWj4jnfBJDIxYm7TOFhTSu5KW/MzXw5GZ5bw9y?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123035413"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Mar 2022 23:45:13 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1F6194D16FF0;
        Mon, 28 Mar 2022 23:45:13 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 28 Mar 2022 23:45:11 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 28 Mar 2022 23:45:14 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <leon@kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v3 1/2] IB/uverbs: Move enum ib_raw_packet_caps to uapi
Date:   Mon, 28 Mar 2022 23:45:10 +0800
Message-ID: <20220328154511.305319-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1F6194D16FF0.A7AFD
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
2.34.1



