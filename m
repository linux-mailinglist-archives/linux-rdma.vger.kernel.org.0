Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC79504C7B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Apr 2022 08:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiDRGPe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Apr 2022 02:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiDRGPd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Apr 2022 02:15:33 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EBC917AB7
        for <linux-rdma@vger.kernel.org>; Sun, 17 Apr 2022 23:12:55 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AGCr3gqlmPltEVJ5is276u0ro5gwDJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2FVzmYeDTzSbv6OYmOjeN53Pom2/BxUup+HyINmSAdt+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ2dxLuoz2S?=
 =?us-ascii?q?xYBMLDOmfgGTl9TFCQW0ahuoeWcfyTj65zDp6HBWz62qxl0N2ksJYAR4P1wB2F?=
 =?us-ascii?q?W+NQXLTkMalaIgOfe6LOhQ69zi8UlPeHqOp8SvjdryjSxJeohRJnYUePF/9hd1?=
 =?us-ascii?q?TsihcFmHPDCas5fYj1qBDzRahtNJ1FRGpIjtOOpgGTvNTFVtjq9p6U4y27NzQB?=
 =?us-ascii?q?w2f7mN9+9UtiLQ9hF21yUo2vu4Wv0GFcZOcaZxD7D9Wij7tIjNwuTtJk6TeX+r?=
 =?us-ascii?q?6A1xgbIgDF7NfHfbnPjydHRt6J0c4s3x5QoxxcT?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Axt6Gn6pNSWMsQCJwX6TQAXEaV5rNeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj9vxG+85rrCMc6QxhIE3I9urwW5VoLUmyyXcx2/h0AV7AZniBhI?=
 =?us-ascii?q?LLFvAB0WKK+VSJcEeSmtK1l50QFJSWY+eRMbEVt6jHCXGDYrMdKce8gdyVrNab?=
 =?us-ascii?q?33FwVhtrdq0lyw94DzyQGkpwSBIuP+tCKLOsotpAuyG7eWkaKuCyBnw+VeDFoN?=
 =?us-ascii?q?HR0L38ZxpuPW9b1CC+ySOv9KXhEwWVmjMXUzZ0y78k9mTf1yzVj5/TyM2G9g?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123644288"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Apr 2022 14:12:54 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 531694D16FDF;
        Mon, 18 Apr 2022 14:12:49 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Apr 2022 14:12:47 +0800
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Apr 2022 14:12:50 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 18 Apr 2022 14:12:50 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v4 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe device
Date:   Mon, 18 Apr 2022 14:12:44 +0800
Message-ID: <20220418061244.89025-4-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220418061244.89025-1-yangx.jy@fujitsu.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 531694D16FDF.A7523
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
 drivers/infiniband/sw/rxe/rxe_param.h | 5 +++++
 include/rdma/ib_verbs.h               | 1 +
 include/uapi/rdma/ib_user_verbs.h     | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 568a7cbd13d4..05796f4007cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -51,7 +51,12 @@ enum rxe_device_param {
 					| IB_DEVICE_SRQ_RESIZE
 					| IB_DEVICE_MEM_MGT_EXTENSIONS
 					| IB_DEVICE_MEM_WINDOW
+#ifdef CONFIG_64BIT
+					| IB_DEVICE_MEM_WINDOW_TYPE_2B
+					| IB_DEVICE_ATOMIC_WRITE,
+#else
 					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
+#endif /* CONFIG_64BIT */
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
 					  sizeof(struct ib_sge) * RXE_MAX_SGE,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 18d706892e97..f5f81e5d1179 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -270,6 +270,7 @@ enum ib_device_cap_flags {
 	/* The device supports padding incoming writes to cacheline. */
 	IB_DEVICE_PCI_WRITE_END_PADDING =
 		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING,
+	IB_DEVICE_ATOMIC_WRITE = IB_UVERBS_DEVICE_ATOMIC_WRITE,
 };
 
 enum ib_kernel_cap_flags {
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 175ade79e358..4a7dbabf1792 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1333,6 +1333,8 @@ enum ib_uverbs_device_cap_flags {
 	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS. */
 	IB_UVERBS_DEVICE_RAW_SCATTER_FCS = 1ULL << 34,
 	IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING = 1ULL << 36,
+	/* Atomic write attributes */
+	IB_UVERBS_DEVICE_ATOMIC_WRITE = 1ULL << 40,
 };
 
 enum ib_uverbs_raw_packet_caps {
-- 
2.34.1



