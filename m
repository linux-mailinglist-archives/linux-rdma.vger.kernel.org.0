Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8986443DD
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Dec 2022 14:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiLFNC6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Dec 2022 08:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiLFNCU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Dec 2022 08:02:20 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0E42BF5;
        Tue,  6 Dec 2022 05:02:17 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="98835142"
X-IronPort-AV: E=Sophos;i="5.96,222,1665414000"; 
   d="scan'208";a="98835142"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Dec 2022 22:02:15 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2870AD3EB2;
        Tue,  6 Dec 2022 22:02:14 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 500FD16E44;
        Tue,  6 Dec 2022 22:02:13 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 37272234090F;
        Tue,  6 Dec 2022 22:02:12 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, tom@talpey.com,
        tomasz.gromadzki@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 02/10] RDMA: Extend RDMA kernel verbs ABI to support flush
Date:   Tue,  6 Dec 2022 21:01:53 +0800
Message-Id: <20221206130201.30986-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206130201.30986-1-lizhijian@fujitsu.com>
References: <20221206130201.30986-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27306.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27306.007
X-TMASE-Result: 10--12.981600-10.000000
X-TMASE-MatchedRID: p0yCgO9DtmM3i8FXueJ7nqzGfgakLdja4Tk+Ydnj9Rsv82KK+I057uEO
        iHvBs/Z/m+UTNeyODYnz1oCTj9zInhmNqsUuotRsJTyMiqml0ikxXH/dlhvLv1cZNuxCoduS6Ch
        K9oqyX+Qi+t+0AiFaYvL3NxFKQpq19obWCLuMiXip3Btb1bH20BtXMWL63O8vmelO0IZKkZ4mIm
        l+ywrqvow1TMOkyb7hLq9xY3fnkEpQlWiVrbYgTqqHmm/V4M/PCIFiJP1XZ1KOVdQAiMmbZ9E08
        LKMDwXNnIqnRXCrHED+8jNl7Al3/PCpvtQpW4FpngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIfiAq
        rjYtFiT3HNWeGDwE4ucCnpU6KG7yEK1dBoX9ZBKbqWGzywGStn7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This commit extends the RDMA kernel verbs ABI to support the flush
operation defined in IBA A19.4.1. These changes are
backward compatible with the existing RDMA kernel verbs ABI.

It makes device/HCA support new FLUSH attributes/capabilities, and it
also makes memory region support new FLUSH access flags.

Users can use ibv_reg_mr(3) to register flush access flags. Only the
access flags also supported by device's capabilities can be registered
successfully.

Once registered successfully, it means the MR is flushable. Similarly,
A flushable MR should also have one or both of GLOBAL_VISIBILITY and
PERSISTENT attributes/capabilities like device/HCA.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V7: Remove FLUSHABLE wrapper
V5: new names and new patch split scheme, suggested by Bob
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 include/rdma/ib_pack.h  |  3 +++
 include/rdma/ib_verbs.h | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index f932d164af63..b8c56d7dc35d 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -84,6 +84,7 @@ enum {
 	/* opcode 0x15 is reserved */
 	IB_OPCODE_SEND_LAST_WITH_INVALIDATE         = 0x16,
 	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE         = 0x17,
+	IB_OPCODE_FLUSH                             = 0x1C,
 	IB_OPCODE_ATOMIC_WRITE                      = 0x1D,
 
 	/* real constants follow -- see comment about above IB_OPCODE()
@@ -113,6 +114,7 @@ enum {
 	IB_OPCODE(RC, FETCH_ADD),
 	IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
 	IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
+	IB_OPCODE(RC, FLUSH),
 	IB_OPCODE(RC, ATOMIC_WRITE),
 
 	/* UC */
@@ -151,6 +153,7 @@ enum {
 	IB_OPCODE(RD, ATOMIC_ACKNOWLEDGE),
 	IB_OPCODE(RD, COMPARE_SWAP),
 	IB_OPCODE(RD, FETCH_ADD),
+	IB_OPCODE(RD, FLUSH),
 
 	/* UD */
 	IB_OPCODE(UD, SEND_ONLY),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index df6bb26ba0be..a9a429172c0a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -270,6 +270,9 @@ enum ib_device_cap_flags {
 	/* The device supports padding incoming writes to cacheline. */
 	IB_DEVICE_PCI_WRITE_END_PADDING =
 		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING,
+	/* Placement type attributes */
+	IB_DEVICE_FLUSH_GLOBAL = IB_UVERBS_DEVICE_FLUSH_GLOBAL,
+	IB_DEVICE_FLUSH_PERSISTENT = IB_UVERBS_DEVICE_FLUSH_PERSISTENT,
 	IB_DEVICE_ATOMIC_WRITE = IB_UVERBS_DEVICE_ATOMIC_WRITE,
 };
 
@@ -987,6 +990,7 @@ enum ib_wc_opcode {
 	IB_WC_REG_MR,
 	IB_WC_MASKED_COMP_SWAP,
 	IB_WC_MASKED_FETCH_ADD,
+	IB_WC_FLUSH = IB_UVERBS_WC_FLUSH,
 /*
  * Set value of IB_WC_RECV so consumers can test if a completion is a
  * receive by testing (opcode & IB_WC_RECV).
@@ -1327,6 +1331,7 @@ enum ib_wr_opcode {
 		IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP,
 	IB_WR_MASKED_ATOMIC_FETCH_AND_ADD =
 		IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD,
+	IB_WR_FLUSH = IB_UVERBS_WR_FLUSH,
 	IB_WR_ATOMIC_WRITE = IB_UVERBS_WR_ATOMIC_WRITE,
 
 	/* These are kernel only and can not be issued by userspace */
@@ -1461,10 +1466,12 @@ enum ib_access_flags {
 	IB_ACCESS_ON_DEMAND = IB_UVERBS_ACCESS_ON_DEMAND,
 	IB_ACCESS_HUGETLB = IB_UVERBS_ACCESS_HUGETLB,
 	IB_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_RELAXED_ORDERING,
+	IB_ACCESS_FLUSH_GLOBAL = IB_UVERBS_ACCESS_FLUSH_GLOBAL,
+	IB_ACCESS_FLUSH_PERSISTENT = IB_UVERBS_ACCESS_FLUSH_PERSISTENT,
 
 	IB_ACCESS_OPTIONAL = IB_UVERBS_ACCESS_OPTIONAL_RANGE,
 	IB_ACCESS_SUPPORTED =
-		((IB_ACCESS_HUGETLB << 1) - 1) | IB_ACCESS_OPTIONAL,
+		((IB_ACCESS_FLUSH_PERSISTENT << 1) - 1) | IB_ACCESS_OPTIONAL,
 };
 
 /*
@@ -4325,6 +4332,8 @@ int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
 static inline int ib_check_mr_access(struct ib_device *ib_dev,
 				     unsigned int flags)
 {
+	u64 device_cap = ib_dev->attrs.device_cap_flags;
+
 	/*
 	 * Local write permission is required if remote write or
 	 * remote atomic permission is also requested.
@@ -4339,6 +4348,13 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
 	if (flags & IB_ACCESS_ON_DEMAND &&
 	    !(ib_dev->attrs.kernel_cap_flags & IBK_ON_DEMAND_PAGING))
 		return -EOPNOTSUPP;
+
+	if ((flags & IB_ACCESS_FLUSH_GLOBAL &&
+	    !(device_cap & IB_DEVICE_FLUSH_GLOBAL)) ||
+	    (flags & IB_ACCESS_FLUSH_PERSISTENT &&
+	    !(device_cap & IB_DEVICE_FLUSH_PERSISTENT)))
+		return -EOPNOTSUPP;
+
 	return 0;
 }
 
-- 
2.31.1

