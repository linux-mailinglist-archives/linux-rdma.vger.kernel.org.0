Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405D44D6104
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Mar 2022 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbiCKLyV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Mar 2022 06:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiCKLyU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Mar 2022 06:54:20 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E1BB1C1ACD
        for <linux-rdma@vger.kernel.org>; Fri, 11 Mar 2022 03:53:16 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AdGY8L6BkzYcovRVW/7vhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fVgHogm930GMAyWofCGrQOf3cYTCgc9BwYNnl9BsDv8WAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9GgjOGj5Zz2f1DqJ6xV?=
 =?us-ascii?q?Rw0eKbLnYzxVjEBSXsjYfwfpuevzX+X9Jb7I1f9W2H0zvx0F0YwPZUV0ulyCGB?=
 =?us-ascii?q?Ks/cfLVglbwqKwf27wbSqYuhqmsknasLsOes3pnZlxCrLS/k8RpXKT7fJ5PdZ2?=
 =?us-ascii?q?is9goZFGvO2T9sQbzhyalLSYwBnPlYRFYJ4kOq27lH9fDJwrkyUqas+pWPUyWR?=
 =?us-ascii?q?ZzL/oGMbcfsSHVINemUPwjmbH+XnpRwsWMdW31zWI6DSvi/XJkCe9X5gdfIBUX?=
 =?us-ascii?q?NYCbEa7nzRVUUNJEwDg56TRt6J3YPoHQ2R8x8bkhfVaGJSXc+TA?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ARmzio6PaXmSbp8BcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122549160"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Mar 2022 19:53:16 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 0AA5E4D16FD1;
        Fri, 11 Mar 2022 19:53:12 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 11 Mar 2022 19:53:11 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 11 Mar 2022 19:53:12 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, <tom@talpey.com>,
        <ira.weiny@intel.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe device
Date:   Fri, 11 Mar 2022 19:52:47 +0800
Message-ID: <20220311115247.23521-4-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311115247.23521-1-yangx.jy@fujitsu.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0AA5E4D16FD1.ABFCF
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

The attribute shows that rxe device supports RDMA Atomic Write operation.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 3 ++-
 include/rdma/ib_verbs.h               | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 918270e34a35..6ae6c4079639 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -53,7 +53,8 @@ enum rxe_device_param {
 					| IB_DEVICE_ALLOW_USER_UNREG
 					| IB_DEVICE_MEM_WINDOW
 					| IB_DEVICE_MEM_WINDOW_TYPE_2A
-					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
+					| IB_DEVICE_MEM_WINDOW_TYPE_2B
+					| IB_DEVICE_ATOMIC_WRITE,
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
 					  sizeof(struct ib_sge) * RXE_MAX_SGE,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index abd1c5d3dc66..580b5cacec09 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -291,6 +291,8 @@ enum ib_device_cap_flags {
 	/* The device supports padding incoming writes to cacheline. */
 	IB_DEVICE_PCI_WRITE_END_PADDING		= (1ULL << 36),
 	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
+	/* Atomic write attributes */
+	IB_DEVICE_ATOMIC_WRITE			= (1ULL << 40),
 };
 
 enum ib_atomic_cap {
-- 
2.34.1



