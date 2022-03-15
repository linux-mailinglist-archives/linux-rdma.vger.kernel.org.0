Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B321F4D987E
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 11:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346990AbiCOKOW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346982AbiCOKOU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 06:14:20 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 841FDDEB5;
        Tue, 15 Mar 2022 03:13:07 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AyJl5uKnK5gJs5YV0Fvppxmvo5gyOJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2MFnTMbUGCFOK6PYTH8e9EgOY+x/ElTsJfVzd8xG1Fq+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZzNRftZ2yS?=
 =?us-ascii?q?A4vFqPRmuUBSAQeGCZ7VUFD0Oadeybj4ZXLkiUqdFOpmZ2CFnoeJ5UV8/xsBmd?=
 =?us-ascii?q?O7fEwJzUEbxTFjOWzqJqpW+t+l8Z5dJGzFIwas3BkizreCJ4ORZHKRarV6NlA0?=
 =?us-ascii?q?TE/rsBTFOnTZowSbj8HRBjJZVtNfEgWDJY/leKzrnj5bzBc7lmSoMIf/2/WxRd?=
 =?us-ascii?q?jlrf3N9/cds6JRO1UmFqVoiTN+GGRKhUXM9q3yjef9H+owOjVkkvTUYIbDrq+8?=
 =?us-ascii?q?tZsnlyfx2VVAxoTPXO+q/2+gU6WXcxeJ00dvCEpqMAa6EuuZsX0WwW1sTiPuRt?=
 =?us-ascii?q?0c95RFfAqrQKA0KzZ5y6HCWUeCD1MctorsIkxXzNC/luImc75QCZjtbS9V32Q7?=
 =?us-ascii?q?PGXoCm0NCxTKnUNDQcGQgQt8djuuIx1hRunczrJOMZZlfWsQXepnW/M93N42t0?=
 =?us-ascii?q?uYQcw//3T1Tj6b/iE+vAlljII2zg=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2lyfR6gNEIseUICnXhi/sQL+O3BQXrQji2hC?=
 =?us-ascii?q?6mlwRA09TyX4raGTdZsguSMc5Ax7ZJhCo7690cu7Lk80nKQdibX5Vo3OYOCJgg?=
 =?us-ascii?q?GVEL0=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122648105"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Mar 2022 18:13:03 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8B6464D16FD7;
        Tue, 15 Mar 2022 18:13:01 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 15 Mar 2022 18:13:03 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Mar 2022 18:12:59 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH v3 1/7] RDMA: Allow registering MR with flush access flags
Date:   Tue, 15 Mar 2022 18:18:39 +0800
Message-ID: <20220315101845.4166983-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220315101845.4166983-1-lizhijian@fujitsu.com>
References: <20220315101845.4166983-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8B6464D16FD7.A06AE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It introduces new attributes/capabilities for device.

Users can use ibv_reg_mr(3) to register flush access flags. Only the
access flags also supported by device can be registered successfully.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: combine [03/10] RDMA/rxe: Allow registering FLUSH flags for supported device only to this patch # Jason
    split RDMA_FLUSH to 2 capabilities
    Fix typo
---
 include/rdma/ib_verbs.h                 | 18 ++++++++++++++++--
 include/uapi/rdma/ib_user_ioctl_verbs.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 69d883f7fb41..465de3bab1e9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -291,6 +291,9 @@ enum ib_device_cap_flags {
 	/* The device supports padding incoming writes to cacheline. */
 	IB_DEVICE_PCI_WRITE_END_PADDING		= (1ULL << 36),
 	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
+	/* Placement type attributes */
+	IB_DEVICE_PLT_GLOBAL_VISIBILITY		= (1ULL << 38),
+	IB_DEVICE_PLT_PERSISTENT		= (1ULL << 39),
 };
 
 enum ib_atomic_cap {
@@ -1444,10 +1447,14 @@ enum ib_access_flags {
 	IB_ACCESS_ON_DEMAND = IB_UVERBS_ACCESS_ON_DEMAND,
 	IB_ACCESS_HUGETLB = IB_UVERBS_ACCESS_HUGETLB,
 	IB_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_RELAXED_ORDERING,
+	IB_ACCESS_FLUSH_GLOBAL_VISIBILITY = IB_UVERBS_ACCESS_FLUSH_GLOBAL_VISIBILITY,
+	IB_ACCESS_FLUSH_PERSISTENT = IB_UVERBS_ACCESS_FLUSH_PERSISTENT,
 
+	IB_ACCESS_FLUSHABLE = IB_ACCESS_FLUSH_GLOBAL_VISIBILITY |
+			      IB_ACCESS_FLUSH_PERSISTENT,
 	IB_ACCESS_OPTIONAL = IB_UVERBS_ACCESS_OPTIONAL_RANGE,
 	IB_ACCESS_SUPPORTED =
-		((IB_ACCESS_HUGETLB << 1) - 1) | IB_ACCESS_OPTIONAL,
+		((IB_ACCESS_FLUSH_PERSISTENT << 1) - 1) | IB_ACCESS_OPTIONAL,
 };
 
 /*
@@ -4300,6 +4307,7 @@ int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
 static inline int ib_check_mr_access(struct ib_device *ib_dev,
 				     unsigned int flags)
 {
+	u64 device_cap = ib_dev->attrs.device_cap_flags;
 	/*
 	 * Local write permission is required if remote write or
 	 * remote atomic permission is also requested.
@@ -4312,7 +4320,13 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
 		return -EINVAL;
 
 	if (flags & IB_ACCESS_ON_DEMAND &&
-	    !(ib_dev->attrs.device_cap_flags & IB_DEVICE_ON_DEMAND_PAGING))
+	    !(device_cap & IB_DEVICE_ON_DEMAND_PAGING))
+		return -EINVAL;
+
+	if ((flags & IB_ACCESS_FLUSH_GLOBAL_VISIBILITY &&
+	    !(device_cap & IB_DEVICE_PLT_GLOBAL_VISIBILITY)) ||
+	    (flags & IB_ACCESS_FLUSH_PERSISTENT &&
+	    !(device_cap & IB_DEVICE_PLT_PERSISTENT)))
 		return -EINVAL;
 	return 0;
 }
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 3072e5d6b692..2c28f90ec54c 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -57,6 +57,8 @@ enum ib_uverbs_access_flags {
 	IB_UVERBS_ACCESS_ZERO_BASED = 1 << 5,
 	IB_UVERBS_ACCESS_ON_DEMAND = 1 << 6,
 	IB_UVERBS_ACCESS_HUGETLB = 1 << 7,
+	IB_UVERBS_ACCESS_FLUSH_GLOBAL_VISIBILITY = 1 << 8,
+	IB_UVERBS_ACCESS_FLUSH_PERSISTENT = 1 << 9,
 
 	IB_UVERBS_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_OPTIONAL_FIRST,
 	IB_UVERBS_ACCESS_OPTIONAL_RANGE =
-- 
2.31.1



