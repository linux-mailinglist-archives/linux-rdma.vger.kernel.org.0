Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5CA4CBF25
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Mar 2022 14:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiCCNvX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 08:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiCCNvW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 08:51:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70E61795DC;
        Thu,  3 Mar 2022 05:50:36 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223C3x86003862;
        Thu, 3 Mar 2022 13:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=y3MYf+TlKweiceJX2qa+tIefBWioJbkZcjleCduyki0=;
 b=cmCM3igxBxvjQ1Fv52MwdPy1xyv114vh/3/HL+uTryxk4fGPQFD3z9nIHcjXuLsieBwd
 NUp3j8QWEOru7NVZwcNg9lVfe3qGSDKfjgphUkg/aJ3ewFbJGOaLL7iNrQgaTrAturTl
 6oM0gasS17AsobzI9DVpJhywKzBEx5eNSaTeh+0TFTbx7zYEc4bIoy2lldvuUe100phU
 c4bjZQ5e5FVWK7ZmhyWpidkG+j9USEg+wAA0/XxTGCHTqecgYS/w0qZZ6cLsKxlZV9Yq
 haujepxx45Hlo3j3R0rq/3+VdFi+7OYjDNRKGAmI2u7IQlDN8VKk/wghRs3JctsFJmo8 tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2eps5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 13:50:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223DjNr0175981;
        Thu, 3 Mar 2022 13:50:26 GMT
Received: from lab02.no.oracle.com (lab02.no.oracle.com [10.172.144.56])
        by aserp3030.oracle.com with ESMTP id 3efa8j5bas-1;
        Thu, 03 Mar 2022 13:50:25 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next] Revert "IB/mlx5: Don't return errors from poll_cq"
Date:   Thu,  3 Mar 2022 14:50:17 +0100
Message-Id: <1646315417-25549-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030065
X-Proofpoint-ORIG-GUID: EIQo8G5Un8scw1KmUnh94TbFJZgqIG9y
X-Proofpoint-GUID: EIQo8G5Un8scw1KmUnh94TbFJZgqIG9y
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This reverts commit dbdf7d4e7f911f79ceb08365a756bbf6eecac81c.

Commit dbdf7d4e7f91 ("IB/mlx5: Don't return errors from poll_cq") is
needed, when driver/fw communication gets wedged.

With a large fleet of systems equipped with CX-5, we have observed the
following mlx5 error message:

wait_func:945:(pid xxx): ACCESS_REG(0x805) timeout. Will cause a
leak of a command resource

Followed by:

destroy_qp_common:2109:(pid xxx): mlx5_ib: modify QP
0x007264 to RESET failed

However, the QP is removed from the device drivers perspective, in
particular, the QP number is removed from the radix tree. We may
further assume that the HCA has not been informed about the intent of
destroying the QP and setting its state to RESET.

We may then poll CQEs from the HCA for this QP. Then we may end up in
mlx5_poll_one() doing:

    mqp = radix_tree_lookup(&dev->qp_table.tree, qpn);
    *cur_qp = to_mibqp(mqp);

which, in the event no QP is found, leads to the following NULL
pointer deref:

BUG: unable to handle kernel paging request at fffffffffffffff8
IP: mlx5_poll_one+0xd0/0xbb0 [mlx5_ib]

Note that the above is based on a 4.14.35 kernel, but my take is that
this analysis is also applicable to latest upstream.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

Conflicts:
	drivers/infiniband/hw/mlx5/cq.c
---
 drivers/infiniband/hw/mlx5/cq.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 08371a8..2bb9aa0 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -490,6 +490,12 @@ static int mlx5_poll_one(struct mlx5_ib_cq *cq,
 		 * from the table.
 		 */
 		mqp = radix_tree_lookup(&dev->qp_table.tree, qpn);
+		if (unlikely(!mqp)) {
+			mlx5_ib_warn(dev, "CQE@CQ %06x for unknown QPN %6x\n",
+				     cq->mcq.cqn, qpn);
+			return -EINVAL;
+		}
+
 		*cur_qp = to_mibqp(mqp);
 	}
 
@@ -552,6 +558,13 @@ static int mlx5_poll_one(struct mlx5_ib_cq *cq,
 		xa_lock(&dev->sig_mrs);
 		sig = xa_load(&dev->sig_mrs,
 				mlx5_base_mkey(be32_to_cpu(sig_err_cqe->mkey)));
+		if (unlikely(!sig)) {
+			xa_unlock(&dev->sig_mrs);
+			mlx5_ib_warn(dev, "Unable to retrieve sig_mr for mkey %6x\n",
+				     be32_to_cpu(sig_err_cqe->mkey));
+			return -EINVAL;
+		}
+
 		get_sig_err_item(sig_err_cqe, &sig->err_item);
 		sig->sig_err_exists = true;
 		sig->sigerr_count++;
@@ -606,6 +619,7 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	unsigned long flags;
 	int soft_polled = 0;
 	int npolled;
+	int err = 0;
 
 	spin_lock_irqsave(&cq->lock, flags);
 	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
@@ -622,7 +636,8 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 		soft_polled = poll_soft_wc(cq, num_entries, wc, false);
 
 	for (npolled = 0; npolled < num_entries - soft_polled; npolled++) {
-		if (mlx5_poll_one(cq, &cur_qp, wc + soft_polled + npolled))
+		err = mlx5_poll_one(cq, &cur_qp, wc + soft_polled + npolled);
+		if (err)
 			break;
 	}
 
@@ -631,7 +646,10 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 out:
 	spin_unlock_irqrestore(&cq->lock, flags);
 
-	return soft_polled + npolled;
+	if (err == 0 || err == -EAGAIN)
+		return soft_polled + npolled;
+	else
+		return err;
 }
 
 int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
-- 
1.8.3.1

