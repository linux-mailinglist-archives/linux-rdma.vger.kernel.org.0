Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B034048072F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhL1IC0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:26 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47591 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235464AbhL1ICW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:22 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A/yqbtaoh+6phOnsktzIlST90qlFeBmJGZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjYZWzuHMvnfMGv9c4oia4nn8xxUvZ+DnNNhQVA5/C9nQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUbe?=
 =?us-ascii?q?eYHApHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlsZ2iS?=
 =?us-ascii?q?QYrP6TKsOoAURhECDw4NqpDkFPCCSHm4JLOkBGfKRMAxN0rVinaJ7Yw4P56CHt?=
 =?us-ascii?q?V8voYMD0lYRWKhubwy7W+IsF+l8YxPcuxZNtHkn5lxDDdS/0hRPjrR6TD49BH0?=
 =?us-ascii?q?TEoi8ZBNfbDbtUUaHxkaxGoSxlOJVoWCJs4k8+om3Dgfjweo1WQzYIz7m/V5A9?=
 =?us-ascii?q?8yr7gNJzSYNPibcxVl1yfoGbu+Xr4DhATcteYzFKt93iogeTPtSXlWY4THfuz8?=
 =?us-ascii?q?fsCqFmSwHEDTR4bT122pdGnhUOkHdFSMUoZ/mwpt6da3EiqSMTtGge0pXesoBE?=
 =?us-ascii?q?RQZxTHvc85QXLzbDbiy6bCWcsXD9McNFgv8ZeeNCA/jdlhPuwXXo27uLTEinbq?=
 =?us-ascii?q?9+pQfqJEXB9BQc/ieUsFFdtDwHfnbwO?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AJ1d0dKCLHqZc767lHelI55DYdb4zR+YMi2TC?=
 =?us-ascii?q?1yhKJyC9Ffbo8fxG/c5rrCMc5wxwZJhNo7y90ey7MBbhHP1OkO4s1NWZLWrbUQ?=
 =?us-ascii?q?KTRekIh+bfKn/baknDH4VmtJuIHZIQNDSJNykZsS/l2njEL/8QhMmA7LuzhfrT?=
 =?us-ascii?q?i1NkTQRRYalm6AtjYzzraXFedU1XA4YjDpqA6o5irzqkQ34eacO2HT0rRO7Gzu?=
 =?us-ascii?q?e77q7OUFoXAQI98gmSgXeN4L7+KRKR2RATSHdu7N4ZgBD4rzA=3D?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657412"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B95204D15A23;
        Tue, 28 Dec 2021 16:01:48 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:48 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:46 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 03/10] RDMA/rxe: Allow registering FLUSH flags for supported device only
Date:   Tue, 28 Dec 2021 16:07:10 +0800
Message-ID: <20211228080717.10666-4-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B95204D15A23.AE83B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Device should enable IB_DEVICE_RDMA_FLUSH capability if it want to
support RDMA FLUSH.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 include/rdma/ib_verbs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index f04d66539879..51d58b641201 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -291,6 +291,7 @@ enum ib_device_cap_flags {
 	/* The device supports padding incoming writes to cacheline. */
 	IB_DEVICE_PCI_WRITE_END_PADDING		= (1ULL << 36),
 	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
+	IB_DEVICE_RDMA_FLUSH			= (1ULL << 38),
 };
 
 enum ib_atomic_cap {
@@ -4319,6 +4320,10 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
 	if (flags & IB_ACCESS_ON_DEMAND &&
 	    !(ib_dev->attrs.device_cap_flags & IB_DEVICE_ON_DEMAND_PAGING))
 		return -EINVAL;
+
+	if (flags & IB_ACCESS_FLUSH &&
+	    !(ib_dev->attrs.device_cap_flags & IB_DEVICE_RDMA_FLUSH))
+		return -EINVAL;
 	return 0;
 }
 
-- 
2.31.1



