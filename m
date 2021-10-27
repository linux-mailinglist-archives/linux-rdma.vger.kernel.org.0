Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106E643C753
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbhJ0KGt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 06:06:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:15712 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235840AbhJ0KGt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 06:06:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="293588109"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="293588109"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 03:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="537471253"
Received: from unknown (HELO intel-100.bj.intel.com) ([10.238.154.100])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2021 03:04:21 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCH 1/1] RDMA/irdma: remove the unused variable local_qp
Date:   Wed, 27 Oct 2021 13:54:57 -0400
Message-Id: <20211027175457.201822-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Since the member variable local_qp is not used, remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/type.h  | 1 -
 drivers/infiniband/hw/irdma/verbs.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 874bc25a938b..bca7bbe5c451 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -852,7 +852,6 @@ struct irdma_roce_offload_info {
 	u16 err_rq_idx;
 	u32 qkey;
 	u32 dest_qp;
-	u32 local_qp;
 	u8 roce_tver;
 	u8 ack_credits;
 	u8 err_rq_idx_valid;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 02ca1f80968e..754e873129a0 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1197,7 +1197,6 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		av->attrs = attr->ah_attr;
 		rdma_gid2ip((struct sockaddr *)&av->sgid_addr, &sgid_attr->gid);
 		rdma_gid2ip((struct sockaddr *)&av->dgid_addr, &attr->ah_attr.grh.dgid);
-		roce_info->local_qp = ibqp->qp_num;
 		if (av->sgid_addr.saddr.sa_family == AF_INET6) {
 			__be32 *daddr =
 				av->dgid_addr.saddr_in6.sin6_addr.in6_u.u6_addr32;
-- 
2.27.0

