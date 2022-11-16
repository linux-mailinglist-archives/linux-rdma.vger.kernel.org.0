Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83AD62B4F2
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 09:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiKPIUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 03:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiKPIU0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 03:20:26 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CEBBBA;
        Wed, 16 Nov 2022 00:20:23 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="75610042"
X-IronPort-AV: E=Sophos;i="5.96,167,1665414000"; 
   d="scan'208";a="75610042"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Nov 2022 17:20:21 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 050DDD66A0;
        Wed, 16 Nov 2022 17:20:20 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4252913831;
        Wed, 16 Nov 2022 17:20:19 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 15F0323401D1;
        Wed, 16 Nov 2022 17:20:18 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v6 02/10] RDMA: Extend RDMA kernel verbs ABI to support flush
Date:   Wed, 16 Nov 2022 16:19:43 +0800
Message-Id: <20221116081951.32750-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116081951.32750-1-lizhijian@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27266.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27266.006
X-TMASE-Result: 10--10.970200-10.000000
X-TMASE-MatchedRID: p0yCgO9DtmM3i8FXueJ7nqzGfgakLdja4Tk+Ydnj9Rsv82KK+I057uEO
        iHvBs/Z/m+UTNeyODYnz1oCTj9zInhmNqsUuotRsJTyMiqml0inVBDonH99+VjoUdFbHYUawvwU
        evDt+uW5/XjpbSJS7a2e9j2HEH29zBhg5qTA0S18wYApm54/SZlcoFMSHqXOcwszB/83OsgdzFn
        5q/FBFPMNN2eR4SoF7Z3XFK4bdN4aGN4c/hNvzQ6qHmm/V4M/PCIFiJP1XZ1KOVdQAiMmbZ9E08
        LKMDwXNnIqnRXCrHED+8jNl7Al3/PCpvtQpW4FpngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIfiAq
        rjYtFiQKD8q8GM7tZX+yHyfq/qgKuVn+KK4vqg5DRqdOyDTX0H7cGd19dSFd
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
backwards compatible with the existing RDMA kernel verbs ABI.

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
V5: new names and new patch split scheme, suggested by Bob
---
 include/rdma/ib_pack.h  |  3 +++
 include/rdma/ib_verbs.h | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index a9162f25beaf..56211d1cc9f9 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -84,6 +84,7 @@ enum {
 	/* opcode 0x15 is reserved */
 	IB_OPCODE_SEND_LAST_WITH_INVALIDATE         = 0x16,
 	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE         = 0x17,
+	IB_OPCODE_FLUSH                             = 0x1C,
 
 	/* real constants follow -- see comment about above IB_OPCODE()
 	   macro for more details */
@@ -112,6 +113,7 @@ enum {
 	IB_OPCODE(RC, FETCH_ADD),
 	IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
 	IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
+	IB_OPCODE(RC, FLUSH),
 
 	/* UC */
 	IB_OPCODE(UC, SEND_FIRST),
@@ -149,6 +151,7 @@ enum {
 	IB_OPCODE(RD, ATOMIC_ACKNOWLEDGE),
 	IB_OPCODE(RD, COMPARE_SWAP),
 	IB_OPCODE(RD, FETCH_ADD),
+	IB_OPCODE(RD, FLUSH),
 
 	/* UD */
 	IB_OPCODE(UD, SEND_ONLY),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a1f4d53a4bb6..bd436e0135ba 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -270,6 +270,9 @@ enum ib_device_cap_flags {
 	/* The device supports padding incoming writes to cacheline. */
 	IB_DEVICE_PCI_WRITE_END_PADDING =
 		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING,
+	/* Placement type attributes */
+	IB_DEVICE_FLUSH_GLOBAL = IB_UVERBS_DEVICE_FLUSH_GLOBAL,
+	IB_DEVICE_FLUSH_PERSISTENT = IB_UVERBS_DEVICE_FLUSH_PERSISTENT,
 };
 
 enum ib_kernel_cap_flags {
@@ -985,6 +988,7 @@ enum ib_wc_opcode {
 	IB_WC_REG_MR,
 	IB_WC_MASKED_COMP_SWAP,
 	IB_WC_MASKED_FETCH_ADD,
+	IB_WC_FLUSH = IB_UVERBS_WC_FLUSH,
 /*
  * Set value of IB_WC_RECV so consumers can test if a completion is a
  * receive by testing (opcode & IB_WC_RECV).
@@ -1325,6 +1329,7 @@ enum ib_wr_opcode {
 		IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP,
 	IB_WR_MASKED_ATOMIC_FETCH_AND_ADD =
 		IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD,
+	IB_WR_FLUSH = IB_UVERBS_WR_FLUSH,
 
 	/* These are kernel only and can not be issued by userspace */
 	IB_WR_REG_MR = 0x20,
@@ -1458,10 +1463,14 @@ enum ib_access_flags {
 	IB_ACCESS_ON_DEMAND = IB_UVERBS_ACCESS_ON_DEMAND,
 	IB_ACCESS_HUGETLB = IB_UVERBS_ACCESS_HUGETLB,
 	IB_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_RELAXED_ORDERING,
+	IB_ACCESS_FLUSH_GLOBAL = IB_UVERBS_ACCESS_FLUSH_GLOBAL,
+	IB_ACCESS_FLUSH_PERSISTENT = IB_UVERBS_ACCESS_FLUSH_PERSISTENT,
+	IB_ACCESS_FLUSHABLE = IB_ACCESS_FLUSH_GLOBAL |
+			      IB_ACCESS_FLUSH_PERSISTENT,
 
 	IB_ACCESS_OPTIONAL = IB_UVERBS_ACCESS_OPTIONAL_RANGE,
 	IB_ACCESS_SUPPORTED =
-		((IB_ACCESS_HUGETLB << 1) - 1) | IB_ACCESS_OPTIONAL,
+		((IB_ACCESS_FLUSH_PERSISTENT << 1) - 1) | IB_ACCESS_OPTIONAL,
 };
 
 /*
@@ -4321,6 +4330,8 @@ int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
 static inline int ib_check_mr_access(struct ib_device *ib_dev,
 				     unsigned int flags)
 {
+	u64 device_cap = ib_dev->attrs.device_cap_flags;
+
 	/*
 	 * Local write permission is required if remote write or
 	 * remote atomic permission is also requested.
@@ -4335,6 +4346,13 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
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

