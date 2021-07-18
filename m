Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC15B3CC8EE
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 14:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhGRMEI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 08:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233188AbhGRMEG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 08:04:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C714610D1;
        Sun, 18 Jul 2021 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626609668;
        bh=+0os3ryL31iZeQ6MByhLX4F/Nn2Iz8unL7CcJXDsMCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCIN+0A01K63F/5hikTPqx+dOqT+t9g3BPgTHLu7OtmpRziYdmeMlcBzO1YU2W0Pl
         /8EDE793UEhepc8YqhGx/BqNwACmISRpUUT2Bgu8JdU4FwLFzUAcxPCWaXtNcvGefF
         ndCQwPOaEdyyqWJzu9vKeVW22IC4Saqsa7wXt1SiF3xEKFnoaW7m3uSYQeMU1dQrQ8
         5byKe/PE6BAXGmz9raFiNUtjwT1ajQe/nIeNhqcDefjV+QX+QMZNOxOx+lHY8DfobG
         EoDjEDPwlrri3kCnRNlLWD0+V8f1disNlNDL9TzRVCuy9ozwcbe19t3BeLsOj7zPqS
         UgYTXy12w6GvQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 1/9] RDMA/hns: Don't skip IB creation flow for regular RC QP
Date:   Sun, 18 Jul 2021 15:00:51 +0300
Message-Id: <463b6d3ae17dc400d9eecc22441f6480cb2b3705.1626609283.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626609283.git.leonro@nvidia.com>
References: <cover.1626609283.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The call to internal QP creation function skips QP creation checks
and misses the addition of such device QPs to the restrack DB.

As a preparation to general allocation scheme, convert hns to use
proper API.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index a3305d196675..e0f59b8d7d5d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -758,7 +758,7 @@ static struct hns_roce_qp *hns_roce_v1_create_lp_qp(struct hns_roce_dev *hr_dev,
 	init_attr.cap.max_recv_wr	= HNS_ROCE_MIN_WQE_NUM;
 	init_attr.cap.max_send_wr	= HNS_ROCE_MIN_WQE_NUM;
 
-	qp = hns_roce_create_qp(pd, &init_attr, NULL);
+	qp = ib_create_qp(pd, &init_attr);
 	if (IS_ERR(qp)) {
 		dev_err(dev, "Create loop qp for mr free failed!");
 		return NULL;
@@ -923,7 +923,7 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 create_lp_qp_failed:
 	for (i -= 1; i >= 0; i--) {
 		hr_qp = free_mr->mr_free_qp[i];
-		if (hns_roce_v1_destroy_qp(&hr_qp->ibqp, NULL))
+		if (ib_destroy_qp(&hr_qp->ibqp))
 			dev_err(dev, "Destroy qp %d for mr free failed!\n", i);
 	}
 
@@ -953,7 +953,7 @@ static void hns_roce_v1_release_lp_qp(struct hns_roce_dev *hr_dev)
 		if (!hr_qp)
 			continue;
 
-		ret = hns_roce_v1_destroy_qp(&hr_qp->ibqp, NULL);
+		ret = ib_destroy_qp(&hr_qp->ibqp);
 		if (ret)
 			dev_err(dev, "Destroy qp %d for mr free failed(%d)!\n",
 				i, ret);
-- 
2.31.1

