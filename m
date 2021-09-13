Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E1540860D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 10:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhIMIGC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 04:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237722AbhIMIGC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 04:06:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F62603E9;
        Mon, 13 Sep 2021 08:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631520287;
        bh=rVe4HDHK9cNVDerCC4itOhS17WRTvIQ0r26T5esxSKY=;
        h=From:To:Cc:Subject:Date:From;
        b=aIkQLgHsRAfGKQkkRSQv8Zy5Ot5hazUW91/FuxUVwnUUvbgSnrc9w/mHLJTUEBtaa
         HyMyo9o3TXGXg/aUcpQyZz1cWYSgq96AvoiQH6oZMUTXAXa9rNKMvcP62AEpC9WXC4
         mzYUNMo03v3yr1yTMX0EKtV6vi0zd8wP5MyZviypfoKTVRZwBwIVw+ElY6T78g/xOX
         UoEMQte3+1MYyX136pknNjK9UAWvmt+QCMcwMtsVzttVz5Jva/7LpfVAYjMlray0ZA
         SzcyjnZVv5dy2uJk4K102UY1GQvpSy0i4VLdaJaagIj0ZBiFZZOPT5bZqPF1rHCToH
         AvxQN0MQk/4GA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH rdma-rc] RDMA/usnic: Lock VF with mutex instead of spinlock
Date:   Mon, 13 Sep 2021 11:04:42 +0300
Message-Id: <2a0e295786c127e518ebee8bb7cafcb819a625f6.1631520231.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Usnic VF doesn't need lock in atomic context to create QPs, so it is safe
to use mutex instead of spinlock. Such change fixes the following smatch
error.

Smatch static checker warning:

   lib/kobject.c:289 kobject_set_name_vargs()
    warn: sleeping in atomic context

Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/usnic/usnic_ib.h       |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c  |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib.h b/drivers/infiniband/hw/usnic/usnic_ib.h
index 84dd682d2334..b350081aeb5a 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib.h
@@ -90,7 +90,7 @@ struct usnic_ib_dev {
 
 struct usnic_ib_vf {
 	struct usnic_ib_dev		*pf;
-	spinlock_t			lock;
+	struct mutex			lock;
 	struct usnic_vnic		*vnic;
 	unsigned int			qp_grp_ref_cnt;
 	struct usnic_ib_pd		*pd;
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 228e9a36dad0..d346dd48e731 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -572,7 +572,7 @@ static int usnic_ib_pci_probe(struct pci_dev *pdev,
 	}
 
 	vf->pf = pf;
-	spin_lock_init(&vf->lock);
+	mutex_init(&vf->lock);
 	mutex_lock(&pf->usdev_lock);
 	list_add_tail(&vf->link, &pf->vf_dev_list);
 	/*
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 06a4e9d4545d..756a83bcff58 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -196,7 +196,7 @@ find_free_vf_and_create_qp_grp(struct ib_qp *qp,
 		for (i = 0; dev_list[i]; i++) {
 			dev = dev_list[i];
 			vf = dev_get_drvdata(dev);
-			spin_lock(&vf->lock);
+			mutex_lock(&vf->lock);
 			vnic = vf->vnic;
 			if (!usnic_vnic_check_room(vnic, res_spec)) {
 				usnic_dbg("Found used vnic %s from %s\n",
@@ -208,10 +208,10 @@ find_free_vf_and_create_qp_grp(struct ib_qp *qp,
 							     vf, pd, res_spec,
 							     trans_spec);
 
-				spin_unlock(&vf->lock);
+				mutex_unlock(&vf->lock);
 				goto qp_grp_check;
 			}
-			spin_unlock(&vf->lock);
+			mutex_unlock(&vf->lock);
 
 		}
 		usnic_uiom_free_dev_list(dev_list);
@@ -220,7 +220,7 @@ find_free_vf_and_create_qp_grp(struct ib_qp *qp,
 
 	/* Try to find resources on an unused vf */
 	list_for_each_entry(vf, &us_ibdev->vf_dev_list, link) {
-		spin_lock(&vf->lock);
+		mutex_lock(&vf->lock);
 		vnic = vf->vnic;
 		if (vf->qp_grp_ref_cnt == 0 &&
 		    usnic_vnic_check_room(vnic, res_spec) == 0) {
@@ -228,10 +228,10 @@ find_free_vf_and_create_qp_grp(struct ib_qp *qp,
 						     vf, pd, res_spec,
 						     trans_spec);
 
-			spin_unlock(&vf->lock);
+			mutex_unlock(&vf->lock);
 			goto qp_grp_check;
 		}
-		spin_unlock(&vf->lock);
+		mutex_unlock(&vf->lock);
 	}
 
 	usnic_info("No free qp grp found on %s\n",
@@ -253,9 +253,9 @@ static void qp_grp_destroy(struct usnic_ib_qp_grp *qp_grp)
 
 	WARN_ON(qp_grp->state != IB_QPS_RESET);
 
-	spin_lock(&vf->lock);
+	mutex_lock(&vf->lock);
 	usnic_ib_qp_grp_destroy(qp_grp);
-	spin_unlock(&vf->lock);
+	mutex_unlock(&vf->lock);
 }
 
 static int create_qp_validate_user_data(struct usnic_ib_create_qp_cmd cmd)
-- 
2.31.1

