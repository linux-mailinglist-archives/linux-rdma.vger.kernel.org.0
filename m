Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1F49AE5F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 09:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451988AbiAYIsX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:48:23 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27831 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1452107AbiAYIpb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:45:31 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ApMVpnKqjB3aaIc+bDMfEhnKhNKFeBmIXZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjdODGqFbPmJYTPzL4hwYN/n9U4O6sKDmIc2QAM9rCozQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?dYH0pHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlsZ2iS?=
 =?us-ascii?q?QYrP6TKsOoAURhECDw4NqpDkFPCCSHl6ZzInhaYLRMAxN0rVinaJ7Yw4P56CHt?=
 =?us-ascii?q?V8voYMD0lYRWKhubwy7W+IsF+l8YxPcuxZNtHkn5lxDDdS/0hRPjrR6TD49BH0?=
 =?us-ascii?q?TEoi8ZBNfbDbtUUaHxkaxGoSxFGPBEVTo0/mOOpj3zkWzxetF+R46Ew5gD70At?=
 =?us-ascii?q?02aP/dtXPfdmDSddWn26ZoH7L+yLyBRRyHNiSzjyt8X+2gOLL2yThV+o6Hb2x7?=
 =?us-ascii?q?PlshHWV2G0fCRRQXly+ydG8gEq5UNJ3LVIV9isn66M18SSDUt74dwGxpGaJr1g?=
 =?us-ascii?q?XXN84O+k77hydj6nZ+QCUAkAaQTNbLt8rrsk7QXotzFDht9foAyF/9aeZTHu16?=
 =?us-ascii?q?LiZt3WxNDITIGtEYjULJSMH7NbLsoA+lh+JRd8LLUIfprUZAhmpm3bT8nd43O5?=
 =?us-ascii?q?V0KY2O2yA1Qivq1qRSlLhF2bZPjnqY18=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALbW72Kpa5QjzQWIIdICxltoaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="120839366"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jan 2022 16:44:29 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 4041B4D15A5C;
        Tue, 25 Jan 2022 16:44:28 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:26 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:27 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 25 Jan 2022 16:44:25 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH v2 2/9] RDMA: Allow registering MR with flush access flags
Date:   Tue, 25 Jan 2022 16:50:34 +0800
Message-ID: <20220125085041.49175-3-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
References: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4041B4D15A5C.AC2A4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Users can use ibv_reg_mr(3) to register flush access flags.
NOTE that, we allow to register the access flags that are supported
by the HCA in both.

Device/HCA should enable IB_DEVICE_PLT_GLOBAL_VISIBILITY or
IB_DEVICE_PLT_PERSISTENT or both capabilities if it want to support
RDMA FLUSH.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2: combine [03/10] RDMA/rxe: Allow registering FLUSH flags for supported device only to this patch # Jason
    split RDMA_FLUSH to 2 capabilities
    Fix typo
---
 include/rdma/ib_verbs.h                 | 18 ++++++++++++++++--
 include/uapi/rdma/ib_user_ioctl_verbs.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4fa07b123c8d..7f5905180636 100644
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
@@ -4301,6 +4308,7 @@ int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
 static inline int ib_check_mr_access(struct ib_device *ib_dev,
 				     unsigned int flags)
 {
+	u64 device_cap = ib_dev->attrs.device_cap_flags;
 	/*
 	 * Local write permission is required if remote write or
 	 * remote atomic permission is also requested.
@@ -4313,7 +4321,13 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
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



