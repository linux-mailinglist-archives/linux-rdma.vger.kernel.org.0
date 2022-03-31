Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C263A4ED2C0
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 06:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiCaEPH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 00:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiCaEOq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 00:14:46 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E982E291B9D
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 20:46:25 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Aex1eEq7KeVk612ftqXYjHwxRtAfFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1TZSnWAWC2GFa6uPNjfxet1zOd+zoR8Gu8ODn9RiSAs5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hgwdNCpdqyW?=
 =?us-ascii?q?C8nI6/NhP8AFRJfFkmSOIUfouSeeCXv7ZX7I0ruNiGEL+9VJEU7Oosw+ettB2x?=
 =?us-ascii?q?Ks/sCJ1glbB+Mr+Sowb66Q69ngcFLBM3qOp4P/2tsyDjxE/krW9bATr/M6Nse2?=
 =?us-ascii?q?y0/7v2it962i9ExMGIpNUqfJUYUfAp/NX73p8/w7lGXTtGSgAv9SXIL3lXu?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ARKOnhK6rZUl85qK2dwPXwCDXdLJyesId70hD?=
 =?us-ascii?q?6qhwISY6TiX+rbHLoB17726StN9/YhEdcLy7VJVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?DDQb2KhrGC/9SPIULDH5ZmpMVdmrZFeabNJGk/ncDn+xO5Dtpl5NGG9ZqjjeDY?=
 =?us-ascii?q?w2wFd3ASV4hQqxd+Fh2AElB7AC1PBZ8CHpKa4cZd4xW6f3B/VLXCOlA1G/jEu8?=
 =?us-ascii?q?bQlI/rJToPBxsc4gGIij+yrJ7WeiLouCsjbw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123115841"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Mar 2022 11:24:23 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id C22DC4D169E7;
        Thu, 31 Mar 2022 11:24:21 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 31 Mar 2022 11:24:21 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 31 Mar 2022 11:24:21 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <leon@kernel.org>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v4 1/2] IB/uverbs: Move enum ib_raw_packet_caps to uapi
Date:   Thu, 31 Mar 2022 11:24:18 +0800
Message-ID: <20220331032419.313904-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C22DC4D169E7.AA404
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
 include/rdma/ib_verbs.h           | 18 +++++++++++-------
 include/uapi/rdma/ib_user_verbs.h |  7 +++++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 69d883f7fb41..dfd467469622 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1621,19 +1621,23 @@ struct ib_srq {
 };
 
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
2.25.4



