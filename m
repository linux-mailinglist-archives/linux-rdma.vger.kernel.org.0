Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12873D39A0
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhGWK71 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 06:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234501AbhGWK71 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 06:59:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E4F460E8C;
        Fri, 23 Jul 2021 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627040400;
        bh=+0os3ryL31iZeQ6MByhLX4F/Nn2Iz8unL7CcJXDsMCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snqLt4ppEO/fNc+QR12EBGttWyUVxfviMHQO8qdtrArnJQlzpwOMWwoFmzIOiI2OQ
         7fcTDAFfF8rG+wmh8KsIl2uE8Pnx/mXHvxcR136CDOVO4j1xFOJjNMuc8ObpQ0/PIm
         eI7IpTD/NHklghWoSSnGlCoqtHuu5aeeLhx052Us6eNir7hAnKV8bYso3/8jmIxAFa
         W1qmrq/Xf3fj/AGtnrWRJZRXAd4leujf/i4wKhkX8vBHoZ/Gxzkifq7gT977M3lrP8
         FXdMuXHC5gkdI+9zfG32DFPH4ggIszqhqVj3Z2hNsCrZ70uRL3Tmni94LAp8/uTDsb
         iLUFl5JrjLUUw==
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
Subject: [PATCH rdma-next v1 1/9] RDMA/hns: Don't skip IB creation flow for regular RC QP
Date:   Fri, 23 Jul 2021 14:39:43 +0300
Message-Id: <7b236c15f7d5abb368958297ac6962d8459cb824.1627040189.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627040189.git.leonro@nvidia.com>
References: <cover.1627040189.git.leonro@nvidia.com>
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

