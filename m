Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD249AE6A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 09:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452475AbiAYItL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:49:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7819 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1379401AbiAYIq5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:46:57 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AEAVSWKxtiYQKq8RaqpJ6t+c4xyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApD4l1TwOnWcaX22HOqyLMGL3eNB2bIyw9B5XsZeBm4BjHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nRHOekUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhm9FjyNRPtJW2Y?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQcoO+ccCPh4aR/yGWDKRMA2c5GFlk7NJcD/eB3GWx?=
 =?us-ascii?q?m+vkRKTRLZReG78qk0bCpW+s23px7BMbuNYIb/HpnyFnxCfcvR5/cTqPS6NlX9?=
 =?us-ascii?q?Dctj99DHLDVYM9xQTZmalLCJQJOPlMWAZcltOaumnT7NTZfrTq9ua0y6nPBigN?=
 =?us-ascii?q?r173kPMjWe/SLQ9lYmgCToWeu12D0BRcyN9GFzzeBtHW2iYfnlCPyQoUUEJW+6?=
 =?us-ascii?q?P9mgVTVzWsWYDUTX1+8qvmRjFC/V9NWbUcT/0IGsa833FCiSsHwTluzp3vslho?=
 =?us-ascii?q?dXcdAVu438geAzoLK7AuDQGsJVDhMbJohrsBebTgr0EKZ2snlADVHrrKYUzSe+?=
 =?us-ascii?q?62SoDf0PjIaRUcAaiAsXwoI+9Slq4hbs/5lZr6PC4bs1pusR262mGvM8UADa3w?=
 =?us-ascii?q?opZZj/82GEZrv2FpAfqT0czM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGsMTuqwNnWWonhJYnjO2KrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="120839368"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jan 2022 16:44:29 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id D10854D169C7;
        Tue, 25 Jan 2022 16:44:28 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:29 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 25 Jan 2022 16:44:26 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH v2 3/9] RDMA/rxe: Allow registering persistent flag for pmem MR only
Date:   Tue, 25 Jan 2022 16:50:35 +0800
Message-ID: <20220125085041.49175-4-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
References: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D10854D169C7.ADA3F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Memory region should support 2 placement types: IB_ACCESS_FLUSH_PERSISTENT
and IB_ACCESS_FLUSH_GLOBAL_VISIBILITY, and only pmem/nvdimm has ability to
persist data(IB_ACCESS_FLUSH_PERSISTENT).

It prevents local user from registering a persistent access flag to
a non-pmem MR.

+------------------------+------------------+--------------+
| HCA attributes         |    register access flags        |
|        and             +-----------------+---------------+
| MR attribute(is_pmem)  |global visibility |  persistence |
|------------------------+------------------+--------------+
| global visibility(DRAM)|        O         |      X       |
|------------------------+------------------+--------------+
| global visibility(PMEM)|        O         |      X       |
|------------------------+------------------+--------------+
| persistence(DRAM)      |        X         |      X       |
|------------------------+------------------+--------------+
| persistence(PMEM)      |        X         |      O       |
+------------------------+------------------+--------------+
PMEM: is_pmem is true
DRAM: is_pmem is false
O: allow to register such access flag
X: otherwise

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2: update commit message, get rid of confusing ib_check_flush_access_flags() # Tom
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 0427baea8c06..89a3bb4e8b71 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -258,7 +258,15 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	set->offset = ib_umem_offset(umem);
 
 	// iova_in_pmem() must be called after set is updated
-	mr->ibmr.is_pmem = iova_in_pmem(mr, iova, length);
+	if (iova_in_pmem(mr, iova, length))
+		mr->ibmr.is_pmem = true;
+	else if (access & IB_ACCESS_FLUSH_PERSISTENT) {
+		pr_warn("Cannot register IB_ACCESS_FLUSH_PERSISTENT for non-pmem memory\n");
+		mr->state = RXE_MR_STATE_INVALID;
+		mr->umem = NULL;
+		err = -EINVAL;
+		goto err_release_umem;
+	}
 
 	return 0;
 
-- 
2.31.1



