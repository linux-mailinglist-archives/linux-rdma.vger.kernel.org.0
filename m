Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821825BDFFF
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiITI3G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 04:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiITI1m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 04:27:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431E696E7
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 01:25:45 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K8Gq6c015177;
        Tue, 20 Sep 2022 08:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=CD8lPBU8+Fwy36vYdGIvy7Ssr4hr/VtD5u+Ga9j1rEs=;
 b=KaYmC6zgjQX37X6uGq+ghoQ4bpWwhIZ9CcXUY52tijTsCbz3Nqjot3q24iHgVn4xk2da
 L88pIDW9yejrAvhoWXuJCod7EZ7O3ImealxaGD1gCjJUA6ylJ0tQQeJuRUCtId0Mc5eT
 m/DdCuNFSlg0f4u9GwRXTZtTuMAMJR2HM8DHZMKdvf84KsajzMdSosw8Axah33tnircB
 NTDZW95cG0XvN5EvpbZSZgMwOyyOqcRMsPtBDHDjD082xI/f6J2vpm1qZ6DdiFoR5WCq
 1wczz70wgIIE3FNuac9fQsmOBzg53KT67MGQ3PtPiwg+i2MSyF+iPnHjq0vXzUmuhvZQ 6Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jq9vb876h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 08:25:43 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28K8L0mP023149;
        Tue, 20 Sep 2022 08:25:41 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3jn5v8kjj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 08:25:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28K8PcNG48365908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 08:25:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1E9C4C04E;
        Tue, 20 Sep 2022 08:25:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AA594C046;
        Tue, 20 Sep 2022 08:25:38 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.56])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Sep 2022 08:25:38 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: [PATCH] RDMA/siw: Fix QP destroy to wait for all references dropped.
Date:   Tue, 20 Sep 2022 10:25:03 +0200
Message-Id: <20220920082503.224189-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cvWGPTziPJcSF3w3Qr4zykzbRcwu9F3G
X-Proofpoint-ORIG-GUID: cvWGPTziPJcSF3w3Qr4zykzbRcwu9F3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=984 bulkscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delay QP destroy completion until all siw references to QP are
dropped. The calling RDMA core will free QP structure after
successful return from siw_qp_destroy() call, so siw must not
hold any remaining reference to the QP upon return.
A use-after-free was encountered in xfstest generic/460, while
testing NFSoRDMA. Here, after a TCP connection drop by peer,
the triggered siw_cm_work_handler got delayed until after
QP destroy call, referencing a QP which has already freed.

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       | 1 +
 drivers/infiniband/sw/siw/siw_qp.c    | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.c | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index df03d84c6868..2f3a9cda3850 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -418,6 +418,7 @@ struct siw_qp {
 	struct ib_qp base_qp;
 	struct siw_device *sdev;
 	struct kref ref;
+	struct completion qp_free;
 	struct list_head devq;
 	int tx_cpu;
 	struct siw_qp_attrs attrs;
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 7e01f2438afc..e6f634971228 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1342,6 +1342,6 @@ void siw_free_qp(struct kref *ref)
 	vfree(qp->orq);
 
 	siw_put_tx_cpu(qp->tx_cpu);
-
+	complete(&qp->qp_free);
 	atomic_dec(&sdev->num_qp);
 }
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 8dedae7ae79e..3e814cfb298c 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -480,6 +480,8 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	list_add_tail(&qp->devq, &sdev->qp_list);
 	spin_unlock_irqrestore(&sdev->lock, flags);
 
+	init_completion(&qp->qp_free);
+
 	return 0;
 
 err_out_xa:
@@ -624,6 +626,7 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 	qp->scq = qp->rcq = NULL;
 
 	siw_qp_put(qp);
+	wait_for_completion(&qp->qp_free);
 
 	return 0;
 }
-- 
2.32.0

