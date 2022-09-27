Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2F5EBA1C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiI0FyH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiI0FyG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:54:06 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0135797500;
        Mon, 26 Sep 2022 22:54:04 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="69512577"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="69512577"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:54:03 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8CFBEE756C;
        Tue, 27 Sep 2022 14:54:01 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id A2CC2D995A;
        Tue, 27 Sep 2022 14:54:00 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 78CB011403D7;
        Tue, 27 Sep 2022 14:53:59 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v5 02/11] RDMA: Extend RDMA user ABI to support flush
Date:   Tue, 27 Sep 2022 13:53:28 +0800
Message-Id: <20220927055337.22630-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10--7.877900-10.000000
X-TMASE-MatchedRID: DVl2cimgKao3i8FXueJ7nioiRKlBVkYI4Tk+Ydnj9Rsv82KK+I057r/E
        Sxz77lNODCNnb8CrvNq12HagvbwDji/7QU2czuUNA9lly13c/gFzq96Ia33704pLyz8UyqY4B4c
        sVfC2ODTckbaA+VOyo5fwx8YL6OA6IWERHkBDPUlBDn6Fjq77jpULM5ZpFgIpnhD4vcFcha4fJg
        2kkQhA79l7+hrY7FlcVfvWvmVRqVkfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPDut4Vvp8ZKp0rl8
        UwqZvKb8FW04FsKkQ7HPI+7Kko/4xoVg1riyt42
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This commit extends the RDMA user ABI to support the flush
operation defined in IBA A19.4.1. These changes are
backwards compatible with the existing RDMA user ABI.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V5: new names and new patch split scheme, suggested by Bob
---
 include/uapi/rdma/ib_user_ioctl_verbs.h |  2 ++
 include/uapi/rdma/ib_user_verbs.h       | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 7dd56210226f..07b105e22f6f 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -57,6 +57,8 @@ enum ib_uverbs_access_flags {
 	IB_UVERBS_ACCESS_ZERO_BASED = 1 << 5,
 	IB_UVERBS_ACCESS_ON_DEMAND = 1 << 6,
 	IB_UVERBS_ACCESS_HUGETLB = 1 << 7,
+	IB_UVERBS_ACCESS_FLUSH_GLOBAL = 1 << 8,
+	IB_UVERBS_ACCESS_FLUSH_PERSISTENT = 1 << 9,
 
 	IB_UVERBS_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_OPTIONAL_FIRST,
 	IB_UVERBS_ACCESS_OPTIONAL_RANGE =
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 43672cb1fd57..2d5f32d9d0d9 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -105,6 +105,18 @@ enum {
 	IB_USER_VERBS_EX_CMD_MODIFY_CQ
 };
 
+/* see IBA A19.4.1.1 Placement Types */
+enum ib_placement_type {
+	IB_FLUSH_GLOBAL = 1U << 0,
+	IB_FLUSH_PERSISTENT = 1U << 1,
+};
+
+/* see IBA A19.4.1.2 Selectivity Level */
+enum ib_selectivity_level {
+	IB_FLUSH_RANGE = 0,
+	IB_FLUSH_MR,
+};
+
 /*
  * Make sure that all structs defined in this file remain laid out so
  * that they pack the same way on 32-bit and 64-bit architectures (to
@@ -466,6 +478,7 @@ enum ib_uverbs_wc_opcode {
 	IB_UVERBS_WC_BIND_MW = 5,
 	IB_UVERBS_WC_LOCAL_INV = 6,
 	IB_UVERBS_WC_TSO = 7,
+	IB_UVERBS_WC_FLUSH = 8,
 };
 
 struct ib_uverbs_wc {
@@ -784,6 +797,7 @@ enum ib_uverbs_wr_opcode {
 	IB_UVERBS_WR_RDMA_READ_WITH_INV = 11,
 	IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP = 12,
 	IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD = 13,
+	IB_UVERBS_WR_FLUSH = 14,
 	/* Review enum ib_wr_opcode before modifying this */
 };
 
@@ -1331,6 +1345,8 @@ enum ib_uverbs_device_cap_flags {
 	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS. */
 	IB_UVERBS_DEVICE_RAW_SCATTER_FCS = 1ULL << 34,
 	IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING = 1ULL << 36,
+	IB_UVERBS_DEVICE_FLUSH_GLOBAL = 1ULL << 38,
+	IB_UVERBS_DEVICE_FLUSH_PERSISTENT = 1ULL << 39,
 };
 
 enum ib_uverbs_raw_packet_caps {
-- 
2.31.1

