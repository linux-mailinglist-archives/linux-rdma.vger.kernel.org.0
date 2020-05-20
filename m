Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2E1DB5AD
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgETNxv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:53:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4827 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbgETNxv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 09:53:51 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6F73916BE78E33B1C249;
        Wed, 20 May 2020 21:53:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 21:53:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 7/9] RDMA/hns: Change variables representing quantity to unsigned
Date:   Wed, 20 May 2020 21:53:17 +0800
Message-ID: <1589982799-28728-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Number of sge/eqe is always non-negative, they should be defined in type
of unsigned.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 17 +++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index e7622bf..e6eb85c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -404,7 +404,7 @@ struct hns_roce_wq {
 };
 
 struct hns_roce_sge {
-	int		sge_cnt;	/* SGE num */
+	unsigned int	sge_cnt;	/* SGE num */
 	int		offset;
 	int		sge_shift;	/* SGE size */
 };
@@ -730,7 +730,7 @@ struct hns_roce_eq {
 	int				arm_st;
 	int				hop_num;
 	struct hns_roce_mtr		mtr;
-	int				eq_max_cnt;
+	u16				eq_max_cnt;
 	int				eq_period;
 	int				shift;
 	int				event_type;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1d5fdf6..3d5ba9a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -130,7 +130,7 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 
 static void set_atomic_seg(const struct ib_send_wr *wr, void *wqe,
 			   struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
-			   int valid_num_sge)
+			   unsigned int valid_num_sge)
 {
 	struct hns_roce_wqe_atomic_seg *aseg;
 
@@ -151,12 +151,12 @@ static void set_atomic_seg(const struct ib_send_wr *wr, void *wqe,
 }
 
 static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
-			   unsigned int *sge_ind, int valid_num_sge)
+			   unsigned int *sge_ind, unsigned int valid_num_sge)
 {
 	struct hns_roce_v2_wqe_data_seg *dseg;
+	unsigned int cnt = valid_num_sge;
 	struct ib_sge *sge = wr->sg_list;
 	unsigned int idx = *sge_ind;
-	int cnt = valid_num_sge;
 
 	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC) {
 		cnt -= HNS_ROCE_SGE_IN_WQE;
@@ -177,7 +177,7 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			     struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 			     void *wqe, unsigned int *sge_ind,
-			     int valid_num_sge)
+			     unsigned int valid_num_sge)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_v2_wqe_data_seg *dseg = wqe;
@@ -269,10 +269,11 @@ static int check_send_valid(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
-static inline int calc_wr_sge_num(const struct ib_send_wr *wr, u32 *sge_len)
+static unsigned int calc_wr_sge_num(const struct ib_send_wr *wr,
+				    unsigned int *sge_len)
 {
-	int valid_num = 0;
-	u32 len = 0;
+	unsigned int valid_num = 0;
+	unsigned int len = 0;
 	int i;
 
 	for (i = 0; i < wr->num_sge; i++) {
@@ -403,7 +404,7 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 {
 	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe = wqe;
 	unsigned int curr_idx = *sge_idx;
-	int valid_num_sge;
+	unsigned int valid_num_sge;
 	u32 msg_len = 0;
 	int ret = 0;
 
-- 
2.8.1

