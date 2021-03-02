Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B914032A81E
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579810AbhCBRKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:10:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12665 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344564AbhCBMxx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Mar 2021 07:53:53 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DqcRt2rDLzlRxW;
        Tue,  2 Mar 2021 20:50:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 20:52:39 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH rdma-core 4/5] libhns: Avoid accessing NULL pointer when locking/unlocking CQ
Date:   Tue, 2 Mar 2021 20:50:23 +0800
Message-ID: <1614689424-27154-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614689424-27154-1-git-send-email-liweihang@huawei.com>
References: <1614689424-27154-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some types of QP may have no associated send CQ or recv CQ or neither,
for example, XRC QP have neither of them. So there should be a check when
locking/unlocking CQs to avoid accessind NULL pointer.

Fixes: c24583975044 ("libhns: Add verbs of qp support")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u_hw_v2.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 0b2e31e..4d990dd 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -1425,14 +1425,20 @@ static void hns_roce_lock_cqs(struct ibv_qp *qp)
 	struct hns_roce_cq *send_cq = to_hr_cq(qp->send_cq);
 	struct hns_roce_cq *recv_cq = to_hr_cq(qp->recv_cq);
 
-	if (send_cq == recv_cq) {
-		pthread_spin_lock(&send_cq->lock);
-	} else if (send_cq->cqn < recv_cq->cqn) {
+	if (send_cq && recv_cq) {
+		if (send_cq == recv_cq) {
+			pthread_spin_lock(&send_cq->lock);
+		} else if (send_cq->cqn < recv_cq->cqn) {
+			pthread_spin_lock(&send_cq->lock);
+			pthread_spin_lock(&recv_cq->lock);
+		} else {
+			pthread_spin_lock(&recv_cq->lock);
+			pthread_spin_lock(&send_cq->lock);
+		}
+	} else if (send_cq) {
 		pthread_spin_lock(&send_cq->lock);
+	} else if (recv_cq) {
 		pthread_spin_lock(&recv_cq->lock);
-	} else {
-		pthread_spin_lock(&recv_cq->lock);
-		pthread_spin_lock(&send_cq->lock);
 	}
 }
 
@@ -1441,13 +1447,19 @@ static void hns_roce_unlock_cqs(struct ibv_qp *qp)
 	struct hns_roce_cq *send_cq = to_hr_cq(qp->send_cq);
 	struct hns_roce_cq *recv_cq = to_hr_cq(qp->recv_cq);
 
-	if (send_cq == recv_cq) {
-		pthread_spin_unlock(&send_cq->lock);
-	} else if (send_cq->cqn < recv_cq->cqn) {
-		pthread_spin_unlock(&recv_cq->lock);
-		pthread_spin_unlock(&send_cq->lock);
-	} else {
+	if (send_cq && recv_cq) {
+		if (send_cq == recv_cq) {
+			pthread_spin_unlock(&send_cq->lock);
+		} else if (send_cq->cqn < recv_cq->cqn) {
+			pthread_spin_unlock(&recv_cq->lock);
+			pthread_spin_unlock(&send_cq->lock);
+		} else {
+			pthread_spin_unlock(&send_cq->lock);
+			pthread_spin_unlock(&recv_cq->lock);
+		}
+	} else if (send_cq) {
 		pthread_spin_unlock(&send_cq->lock);
+	} else if (recv_cq) {
 		pthread_spin_unlock(&recv_cq->lock);
 	}
 }
-- 
2.8.1

