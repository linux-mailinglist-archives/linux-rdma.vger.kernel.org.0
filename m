Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8EDEE1B7
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfD2L7T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 07:59:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36995 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfD2L7S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 07:59:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id r6so15628889wrm.4
        for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2019 04:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skV6XpNCaib80nTGvre7VUPAab/J2mg04GkRqdip+sI=;
        b=Hkq5Ok+E632+G8GyzLDCH0jqxi1rpXr4KlS9fTlZuGc92M1+8IaRslLIyKq1KZTUBv
         zXhu2DKlzz1Up/MMRi6l94jjv1uvfWl/LWN4BnUy6qWs0xs6QQ4T9MkqdFIPYTjBNH4I
         2N5I9/o+pZZJOWfMZTSn9wwwR7JQVxFAzewYWp51ZskuolfV49CGigVP/qVnF+kr5Z9V
         bWVnFC3oU87WpRMZSdLEF8qbmwbJIB85zGnl+PYI7mW5SQF4ZKYac4RU15H5iAp8Ao3o
         XXhLh98lYbSls8JciIDez3nn0UOLYk02YXYosXZ1af26riB80n7KlDXymexkolgva/K2
         k3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skV6XpNCaib80nTGvre7VUPAab/J2mg04GkRqdip+sI=;
        b=uFZIU4PnF7jVqnW1nuCU/w0CJnmpmjEQVn/3pDCvsnGFcvfES9M68qMQqIYxhc0Pfw
         ZWMKwD48cj8j07wtScWh4ueWC1lfUvqCDw4ip3IXVr4RiGAxg4u+mBtmoBarLBYHIZwq
         2eJ3PF/qK7jl9zuMerQELm3zHu/pLo55KA9MDvoTNE02FxQ+Co75JUthuU9M5hP3rhW8
         m0cuMCgXM2E2lGC4I7wd5Agouoy9jeXltgaz85W+py/6ktXBU1ahMyQ3/UeCMmLIv+vE
         +d57A8grF+Ynu48m28CTIStodL9EM+39jWGTuUjY/x6yNacdT2UTJvHFekXA55i+bH0s
         8XJg==
X-Gm-Message-State: APjAAAXtvrid+USm7KUG6QuCpSdNd0j9CryonFroKseWWV9mRhIDup1O
        5VNiNw4yHB5+gMYlc3dsgK6oPFD4
X-Google-Smtp-Source: APXvYqwN0GUve/uuMALiSOQboTsgT+0ExqcaQ8uJcerruOMqBkYvV2SyMUPDiigA57+BIzotVhaIag==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr16682368wrw.41.1556539155901;
        Mon, 29 Apr 2019 04:59:15 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-67-4-126.red.bezeqint.net. [109.67.4.126])
        by smtp.gmail.com with ESMTPSA id s16sm5079289wrg.71.2019.04.29.04.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 04:59:15 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH V2 for-next] RDMA: Get rid of iw_cm_verbs
Date:   Mon, 29 Apr 2019 14:59:06 +0300
Message-Id: <20190429115906.13509-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Integrate iw_cm_verbs data members into ib_device_ops and ib_device
structs, this is done to achieve the following:

1- Avoid memory related bugs.
2- Make the code more cleaner.
3- Reduce code duplication.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c            |  8 +++++
 drivers/infiniband/core/iwcm.c              | 35 +++++++++++----------
 drivers/infiniband/hw/cxgb3/iwch_provider.c | 32 +++++++------------
 drivers/infiniband/hw/cxgb4/provider.c      | 33 +++++++------------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 30 ++++++------------
 drivers/infiniband/hw/nes/nes_verbs.c       | 27 ++++++----------
 drivers/infiniband/hw/qedr/main.c           | 25 ++++++---------
 include/rdma/ib_verbs.h                     | 23 +++++++++++---
 include/rdma/iw_cm.h                        | 25 ---------------
 9 files changed, 98 insertions(+), 140 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index fcbf2d4c865d..b1dc0454151c 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2310,6 +2310,14 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, get_vf_config);
 	SET_DEVICE_OP(dev_ops, get_vf_stats);
 	SET_DEVICE_OP(dev_ops, init_port);
+	SET_DEVICE_OP(dev_ops, iw_accept);
+	SET_DEVICE_OP(dev_ops, iw_add_ref);
+	SET_DEVICE_OP(dev_ops, iw_connect);
+	SET_DEVICE_OP(dev_ops, iw_create_listen);
+	SET_DEVICE_OP(dev_ops, iw_destroy_listen);
+	SET_DEVICE_OP(dev_ops, iw_get_qp);
+	SET_DEVICE_OP(dev_ops, iw_reject);
+	SET_DEVICE_OP(dev_ops, iw_rem_ref);
 	SET_DEVICE_OP(dev_ops, map_mr_sg);
 	SET_DEVICE_OP(dev_ops, map_phys_fmr);
 	SET_DEVICE_OP(dev_ops, mmap);
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 732637c913d9..ac56762e7e93 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -394,7 +394,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		cm_id_priv->state = IW_CM_STATE_DESTROYING;
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 		/* destroy the listening endpoint */
-		cm_id->device->iwcm->destroy_listen(cm_id);
+		cm_id->device->ops.iw_destroy_listen(cm_id);
 		spin_lock_irqsave(&cm_id_priv->lock, flags);
 		break;
 	case IW_CM_STATE_ESTABLISHED:
@@ -417,7 +417,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		 */
 		cm_id_priv->state = IW_CM_STATE_DESTROYING;
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		cm_id->device->iwcm->reject(cm_id, NULL, 0);
+		cm_id->device->ops.iw_reject(cm_id, NULL, 0);
 		spin_lock_irqsave(&cm_id_priv->lock, flags);
 		break;
 	case IW_CM_STATE_CONN_SENT:
@@ -427,7 +427,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		break;
 	}
 	if (cm_id_priv->qp) {
-		cm_id_priv->id.device->iwcm->rem_ref(cm_id_priv->qp);
+		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
 		cm_id_priv->qp = NULL;
 	}
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -504,7 +504,7 @@ static void iw_cm_check_wildcard(struct sockaddr_storage *pm_addr,
 static int iw_cm_map(struct iw_cm_id *cm_id, bool active)
 {
 	const char *devname = dev_name(&cm_id->device->dev);
-	const char *ifname = cm_id->device->iwcm->ifname;
+	const char *ifname = cm_id->device->iw_ifname;
 	struct iwpm_dev_data pm_reg_msg = {};
 	struct iwpm_sa_data pm_msg;
 	int status;
@@ -526,7 +526,7 @@ static int iw_cm_map(struct iw_cm_id *cm_id, bool active)
 	cm_id->mapped = true;
 	pm_msg.loc_addr = cm_id->local_addr;
 	pm_msg.rem_addr = cm_id->remote_addr;
-	pm_msg.flags = (cm_id->device->iwcm->driver_flags & IW_F_NO_PORT_MAP) ?
+	pm_msg.flags = (cm_id->device->iw_driver_flags & IW_F_NO_PORT_MAP) ?
 		       IWPM_FLAGS_NO_PORT_MAP : 0;
 	if (active)
 		status = iwpm_add_and_query_mapping(&pm_msg,
@@ -577,7 +577,8 @@ int iw_cm_listen(struct iw_cm_id *cm_id, int backlog)
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 		ret = iw_cm_map(cm_id, false);
 		if (!ret)
-			ret = cm_id->device->iwcm->create_listen(cm_id, backlog);
+			ret = cm_id->device->ops.iw_create_listen(cm_id,
+								     backlog);
 		if (ret)
 			cm_id_priv->state = IW_CM_STATE_IDLE;
 		spin_lock_irqsave(&cm_id_priv->lock, flags);
@@ -617,7 +618,7 @@ int iw_cm_reject(struct iw_cm_id *cm_id,
 	cm_id_priv->state = IW_CM_STATE_IDLE;
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 
-	ret = cm_id->device->iwcm->reject(cm_id, private_data,
+	ret = cm_id->device->ops.iw_reject(cm_id, private_data,
 					  private_data_len);
 
 	clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
@@ -653,25 +654,25 @@ int iw_cm_accept(struct iw_cm_id *cm_id,
 		return -EINVAL;
 	}
 	/* Get the ib_qp given the QPN */
-	qp = cm_id->device->iwcm->get_qp(cm_id->device, iw_param->qpn);
+	qp = cm_id->device->ops.iw_get_qp(cm_id->device, iw_param->qpn);
 	if (!qp) {
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
 		wake_up_all(&cm_id_priv->connect_wait);
 		return -EINVAL;
 	}
-	cm_id->device->iwcm->add_ref(qp);
+	cm_id->device->ops.iw_add_ref(qp);
 	cm_id_priv->qp = qp;
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 
-	ret = cm_id->device->iwcm->accept(cm_id, iw_param);
+	ret = cm_id->device->ops.iw_accept(cm_id, iw_param);
 	if (ret) {
 		/* An error on accept precludes provider events */
 		BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_RECV);
 		cm_id_priv->state = IW_CM_STATE_IDLE;
 		spin_lock_irqsave(&cm_id_priv->lock, flags);
 		if (cm_id_priv->qp) {
-			cm_id->device->iwcm->rem_ref(qp);
+			cm_id->device->ops.iw_rem_ref(qp);
 			cm_id_priv->qp = NULL;
 		}
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -712,25 +713,25 @@ int iw_cm_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
 	}
 
 	/* Get the ib_qp given the QPN */
-	qp = cm_id->device->iwcm->get_qp(cm_id->device, iw_param->qpn);
+	qp = cm_id->device->ops.iw_get_qp(cm_id->device, iw_param->qpn);
 	if (!qp) {
 		ret = -EINVAL;
 		goto err;
 	}
-	cm_id->device->iwcm->add_ref(qp);
+	cm_id->device->ops.iw_add_ref(qp);
 	cm_id_priv->qp = qp;
 	cm_id_priv->state = IW_CM_STATE_CONN_SENT;
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 
 	ret = iw_cm_map(cm_id, true);
 	if (!ret)
-		ret = cm_id->device->iwcm->connect(cm_id, iw_param);
+		ret = cm_id->device->ops.iw_connect(cm_id, iw_param);
 	if (!ret)
 		return 0;	/* success */
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id_priv->qp) {
-		cm_id->device->iwcm->rem_ref(qp);
+		cm_id->device->ops.iw_rem_ref(qp);
 		cm_id_priv->qp = NULL;
 	}
 	cm_id_priv->state = IW_CM_STATE_IDLE;
@@ -895,7 +896,7 @@ static int cm_conn_rep_handler(struct iwcm_id_private *cm_id_priv,
 		cm_id_priv->state = IW_CM_STATE_ESTABLISHED;
 	} else {
 		/* REJECTED or RESET */
-		cm_id_priv->id.device->iwcm->rem_ref(cm_id_priv->qp);
+		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
 		cm_id_priv->qp = NULL;
 		cm_id_priv->state = IW_CM_STATE_IDLE;
 	}
@@ -946,7 +947,7 @@ static int cm_close_handler(struct iwcm_id_private *cm_id_priv,
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 
 	if (cm_id_priv->qp) {
-		cm_id_priv->id.device->iwcm->rem_ref(cm_id_priv->qp);
+		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
 		cm_id_priv->qp = NULL;
 	}
 	switch (cm_id_priv->state) {
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 62b99d26f0d3..3a481dfb1607 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -1321,6 +1321,14 @@ static const struct ib_device_ops iwch_dev_ops = {
 	.get_dma_mr = iwch_get_dma_mr,
 	.get_hw_stats = iwch_get_mib,
 	.get_port_immutable = iwch_port_immutable,
+	.iw_accept = iwch_accept_cr,
+	.iw_add_ref = iwch_qp_add_ref,
+	.iw_connect = iwch_connect,
+	.iw_create_listen = iwch_create_listen,
+	.iw_destroy_listen = iwch_destroy_listen,
+	.iw_get_qp = iwch_get_qp,
+	.iw_reject = iwch_reject_cr,
+	.iw_rem_ref = iwch_qp_rem_ref,
 	.map_mr_sg = iwch_map_mr_sg,
 	.mmap = iwch_mmap,
 	.modify_qp = iwch_ib_modify_qp,
@@ -1340,8 +1348,6 @@ static const struct ib_device_ops iwch_dev_ops = {
 
 int iwch_register_device(struct iwch_dev *dev)
 {
-	int ret;
-
 	pr_debug("%s iwch_dev %p\n", __func__, dev);
 	memset(&dev->ibdev.node_guid, 0, sizeof(dev->ibdev.node_guid));
 	memcpy(&dev->ibdev.node_guid, dev->rdev.t3cdev_p->lldev->dev_addr, 6);
@@ -1379,34 +1385,18 @@ int iwch_register_device(struct iwch_dev *dev)
 	dev->ibdev.dev.parent = &dev->rdev.rnic_info.pdev->dev;
 	dev->ibdev.uverbs_abi_ver = IWCH_UVERBS_ABI_VERSION;
 
-	dev->ibdev.iwcm = kzalloc(sizeof(struct iw_cm_verbs), GFP_KERNEL);
-	if (!dev->ibdev.iwcm)
-		return -ENOMEM;
-
-	dev->ibdev.iwcm->connect = iwch_connect;
-	dev->ibdev.iwcm->accept = iwch_accept_cr;
-	dev->ibdev.iwcm->reject = iwch_reject_cr;
-	dev->ibdev.iwcm->create_listen = iwch_create_listen;
-	dev->ibdev.iwcm->destroy_listen = iwch_destroy_listen;
-	dev->ibdev.iwcm->add_ref = iwch_qp_add_ref;
-	dev->ibdev.iwcm->rem_ref = iwch_qp_rem_ref;
-	dev->ibdev.iwcm->get_qp = iwch_get_qp;
-	memcpy(dev->ibdev.iwcm->ifname, dev->rdev.t3cdev_p->lldev->name,
-	       sizeof(dev->ibdev.iwcm->ifname));
+	memcpy(dev->ibdev.iw_ifname, dev->rdev.t3cdev_p->lldev->name,
+	       sizeof(dev->ibdev.iw_ifname));
 
 	dev->ibdev.driver_id = RDMA_DRIVER_CXGB3;
 	rdma_set_device_sysfs_group(&dev->ibdev, &iwch_attr_group);
 	ib_set_device_ops(&dev->ibdev, &iwch_dev_ops);
-	ret = ib_register_device(&dev->ibdev, "cxgb3_%d");
-	if (ret)
-		kfree(dev->ibdev.iwcm);
-	return ret;
+	return ib_register_device(&dev->ibdev, "cxgb3_%d");
 }
 
 void iwch_unregister_device(struct iwch_dev *dev)
 {
 	pr_debug("%s iwch_dev %p\n", __func__, dev);
 	ib_unregister_device(&dev->ibdev);
-	kfree(dev->ibdev.iwcm);
 	return;
 }
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 3c5197ee77f5..74b795642fca 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -510,6 +510,14 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.get_dma_mr = c4iw_get_dma_mr,
 	.get_hw_stats = c4iw_get_mib,
 	.get_port_immutable = c4iw_port_immutable,
+	.iw_accept = c4iw_accept_cr,
+	.iw_add_ref = c4iw_qp_add_ref,
+	.iw_connect = c4iw_connect,
+	.iw_create_listen = c4iw_create_listen,
+	.iw_destroy_listen = c4iw_destroy_listen,
+	.iw_get_qp = c4iw_get_qp,
+	.iw_reject = c4iw_reject_cr,
+	.iw_rem_ref = c4iw_qp_rem_ref,
 	.map_mr_sg = c4iw_map_mr_sg,
 	.mmap = c4iw_mmap,
 	.modify_qp = c4iw_ib_modify_qp,
@@ -588,36 +596,20 @@ void c4iw_register_device(struct work_struct *work)
 	dev->ibdev.dev.parent = &dev->rdev.lldi.pdev->dev;
 	dev->ibdev.uverbs_abi_ver = C4IW_UVERBS_ABI_VERSION;
 
-	dev->ibdev.iwcm = kzalloc(sizeof(struct iw_cm_verbs), GFP_KERNEL);
-	if (!dev->ibdev.iwcm) {
-		ret = -ENOMEM;
-		goto err_dealloc_ctx;
-	}
-
-	dev->ibdev.iwcm->connect = c4iw_connect;
-	dev->ibdev.iwcm->accept = c4iw_accept_cr;
-	dev->ibdev.iwcm->reject = c4iw_reject_cr;
-	dev->ibdev.iwcm->create_listen = c4iw_create_listen;
-	dev->ibdev.iwcm->destroy_listen = c4iw_destroy_listen;
-	dev->ibdev.iwcm->add_ref = c4iw_qp_add_ref;
-	dev->ibdev.iwcm->rem_ref = c4iw_qp_rem_ref;
-	dev->ibdev.iwcm->get_qp = c4iw_get_qp;
-	memcpy(dev->ibdev.iwcm->ifname, dev->rdev.lldi.ports[0]->name,
-	       sizeof(dev->ibdev.iwcm->ifname));
+	memcpy(dev->ibdev.iw_ifname, dev->rdev.lldi.ports[0]->name,
+	       sizeof(dev->ibdev.iw_ifname));
 
 	rdma_set_device_sysfs_group(&dev->ibdev, &c4iw_attr_group);
 	dev->ibdev.driver_id = RDMA_DRIVER_CXGB4;
 	ib_set_device_ops(&dev->ibdev, &c4iw_dev_ops);
 	ret = set_netdevs(&dev->ibdev, &dev->rdev);
 	if (ret)
-		goto err_kfree_iwcm;
+		goto err_dealloc_ctx;
 	ret = ib_register_device(&dev->ibdev, "cxgb4_%d");
 	if (ret)
-		goto err_kfree_iwcm;
+		goto err_dealloc_ctx;
 	return;
 
-err_kfree_iwcm:
-	kfree(dev->ibdev.iwcm);
 err_dealloc_ctx:
 	pr_err("%s - Failed registering iwarp device: %d\n",
 	       pci_name(ctx->lldi.pdev), ret);
@@ -629,6 +621,5 @@ void c4iw_unregister_device(struct c4iw_dev *dev)
 {
 	pr_debug("c4iw_dev %p\n", dev);
 	ib_unregister_device(&dev->ibdev);
-	kfree(dev->ibdev.iwcm);
 	return;
 }
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 7bf7fe854464..b8a1412253ae 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2704,6 +2704,14 @@ static const struct ib_device_ops i40iw_dev_ops = {
 	.get_dma_mr = i40iw_get_dma_mr,
 	.get_hw_stats = i40iw_get_hw_stats,
 	.get_port_immutable = i40iw_port_immutable,
+	.iw_accept = i40iw_accept,
+	.iw_add_ref = i40iw_add_ref,
+	.iw_connect = i40iw_connect,
+	.iw_create_listen = i40iw_create_listen,
+	.iw_destroy_listen = i40iw_destroy_listen,
+	.iw_get_qp = i40iw_get_qp,
+	.iw_reject = i40iw_reject,
+	.iw_rem_ref = i40iw_rem_ref,
 	.map_mr_sg = i40iw_map_mr_sg,
 	.mmap = i40iw_mmap,
 	.modify_qp = i40iw_modify_qp,
@@ -2767,22 +2775,8 @@ static struct i40iw_ib_device *i40iw_init_rdma_device(struct i40iw_device *iwdev
 	iwibdev->ibdev.phys_port_cnt = 1;
 	iwibdev->ibdev.num_comp_vectors = iwdev->ceqs_count;
 	iwibdev->ibdev.dev.parent = &pcidev->dev;
-	iwibdev->ibdev.iwcm = kzalloc(sizeof(*iwibdev->ibdev.iwcm), GFP_KERNEL);
-	if (!iwibdev->ibdev.iwcm) {
-		ib_dealloc_device(&iwibdev->ibdev);
-		return NULL;
-	}
-
-	iwibdev->ibdev.iwcm->add_ref = i40iw_add_ref;
-	iwibdev->ibdev.iwcm->rem_ref = i40iw_rem_ref;
-	iwibdev->ibdev.iwcm->get_qp = i40iw_get_qp;
-	iwibdev->ibdev.iwcm->connect = i40iw_connect;
-	iwibdev->ibdev.iwcm->accept = i40iw_accept;
-	iwibdev->ibdev.iwcm->reject = i40iw_reject;
-	iwibdev->ibdev.iwcm->create_listen = i40iw_create_listen;
-	iwibdev->ibdev.iwcm->destroy_listen = i40iw_destroy_listen;
-	memcpy(iwibdev->ibdev.iwcm->ifname, netdev->name,
-	       sizeof(iwibdev->ibdev.iwcm->ifname));
+	memcpy(iwibdev->ibdev.iw_ifname, netdev->name,
+	       sizeof(iwibdev->ibdev.iw_ifname));
 	ib_set_device_ops(&iwibdev->ibdev, &i40iw_dev_ops);
 
 	return iwibdev;
@@ -2813,8 +2807,6 @@ void i40iw_destroy_rdma_device(struct i40iw_ib_device *iwibdev)
 		return;
 
 	ib_unregister_device(&iwibdev->ibdev);
-	kfree(iwibdev->ibdev.iwcm);
-	iwibdev->ibdev.iwcm = NULL;
 	wait_event_timeout(iwibdev->iwdev->close_wq,
 			   !atomic64_read(&iwibdev->iwdev->use_count),
 			   I40IW_EVENT_TIMEOUT);
@@ -2842,8 +2834,6 @@ int i40iw_register_rdma_device(struct i40iw_device *iwdev)
 
 	return 0;
 error:
-	kfree(iwdev->iwibdev->ibdev.iwcm);
-	iwdev->iwibdev->ibdev.iwcm = NULL;
 	ib_dealloc_device(&iwdev->iwibdev->ibdev);
 	return ret;
 }
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index a3b5e8eecb98..49024326a518 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -3577,6 +3577,14 @@ static const struct ib_device_ops nes_dev_ops = {
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = nes_get_dma_mr,
 	.get_port_immutable = nes_port_immutable,
+	.iw_accept = nes_accept,
+	.iw_add_ref = nes_add_ref,
+	.iw_connect = nes_connect,
+	.iw_create_listen = nes_create_listen,
+	.iw_destroy_listen = nes_destroy_listen,
+	.iw_get_qp = nes_get_qp,
+	.iw_reject = nes_reject,
+	.iw_rem_ref = nes_rem_ref,
 	.map_mr_sg = nes_map_mr_sg,
 	.mmap = nes_mmap,
 	.modify_qp = nes_modify_qp,
@@ -3641,23 +3649,9 @@ struct nes_ib_device *nes_init_ofa_device(struct net_device *netdev)
 	nesibdev->ibdev.num_comp_vectors = 1;
 	nesibdev->ibdev.dev.parent = &nesdev->pcidev->dev;
 
-	nesibdev->ibdev.iwcm = kzalloc(sizeof(*nesibdev->ibdev.iwcm), GFP_KERNEL);
-	if (nesibdev->ibdev.iwcm == NULL) {
-		ib_dealloc_device(&nesibdev->ibdev);
-		return NULL;
-	}
-	nesibdev->ibdev.iwcm->add_ref = nes_add_ref;
-	nesibdev->ibdev.iwcm->rem_ref = nes_rem_ref;
-	nesibdev->ibdev.iwcm->get_qp = nes_get_qp;
-	nesibdev->ibdev.iwcm->connect = nes_connect;
-	nesibdev->ibdev.iwcm->accept = nes_accept;
-	nesibdev->ibdev.iwcm->reject = nes_reject;
-	nesibdev->ibdev.iwcm->create_listen = nes_create_listen;
-	nesibdev->ibdev.iwcm->destroy_listen = nes_destroy_listen;
-
 	ib_set_device_ops(&nesibdev->ibdev, &nes_dev_ops);
-	memcpy(nesibdev->ibdev.iwcm->ifname, netdev->name,
-	       sizeof(nesibdev->ibdev.iwcm->ifname));
+	memcpy(nesibdev->ibdev.iw_ifname, netdev->name,
+	       sizeof(nesibdev->ibdev.iw_ifname));
 
 	return nesibdev;
 }
@@ -3718,7 +3712,6 @@ void nes_destroy_ofa_device(struct nes_ib_device *nesibdev)
 
 	nes_unregister_ofa_device(nesibdev);
 
-	kfree(nesibdev->ibdev.iwcm);
 	ib_dealloc_device(&nesibdev->ibdev);
 }
 
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index a0a49ed26860..083c2c00a8e9 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -148,6 +148,14 @@ static const struct attribute_group qedr_attr_group = {
 
 static const struct ib_device_ops qedr_iw_dev_ops = {
 	.get_port_immutable = qedr_iw_port_immutable,
+	.iw_accept = qedr_iw_accept,
+	.iw_add_ref = qedr_iw_qp_add_ref,
+	.iw_connect = qedr_iw_connect,
+	.iw_create_listen = qedr_iw_create_listen,
+	.iw_destroy_listen = qedr_iw_destroy_listen,
+	.iw_get_qp = qedr_iw_get_qp,
+	.iw_reject = qedr_iw_reject,
+	.iw_rem_ref = qedr_iw_qp_rem_ref,
 	.query_gid = qedr_iw_query_gid,
 };
 
@@ -157,21 +165,8 @@ static int qedr_iw_register_device(struct qedr_dev *dev)
 
 	ib_set_device_ops(&dev->ibdev, &qedr_iw_dev_ops);
 
-	dev->ibdev.iwcm = kzalloc(sizeof(*dev->ibdev.iwcm), GFP_KERNEL);
-	if (!dev->ibdev.iwcm)
-		return -ENOMEM;
-
-	dev->ibdev.iwcm->connect = qedr_iw_connect;
-	dev->ibdev.iwcm->accept = qedr_iw_accept;
-	dev->ibdev.iwcm->reject = qedr_iw_reject;
-	dev->ibdev.iwcm->create_listen = qedr_iw_create_listen;
-	dev->ibdev.iwcm->destroy_listen = qedr_iw_destroy_listen;
-	dev->ibdev.iwcm->add_ref = qedr_iw_qp_add_ref;
-	dev->ibdev.iwcm->rem_ref = qedr_iw_qp_rem_ref;
-	dev->ibdev.iwcm->get_qp = qedr_iw_get_qp;
-
-	memcpy(dev->ibdev.iwcm->ifname,
-	       dev->ndev->name, sizeof(dev->ibdev.iwcm->ifname));
+	memcpy(dev->ibdev.iw_ifname,
+	       dev->ndev->name, sizeof(dev->ibdev.iw_ifname));
 
 	return 0;
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 43a75ab8ea8a..efaae57edccd 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2191,8 +2191,6 @@ struct ib_cache {
 	struct ib_event_handler event_handler;
 };
 
-struct iw_cm_verbs;
-
 struct ib_port_immutable {
 	int                           pkey_tbl_len;
 	int                           gid_tbl_len;
@@ -2274,6 +2272,8 @@ struct ib_counters_read_attr {
 };
 
 struct uverbs_attr_bundle;
+struct iw_cm_id;
+struct iw_cm_conn_param;
 
 #define INIT_RDMA_OBJ_SIZE(ib_struct, drv_struct, member)                      \
 	.size_##ib_struct =                                                    \
@@ -2551,6 +2551,19 @@ struct ib_device_ops {
 	 */
 	void (*dealloc_driver)(struct ib_device *dev);
 
+	/* iWarp CM callbacks */
+	void (*iw_add_ref)(struct ib_qp *qp);
+	void (*iw_rem_ref)(struct ib_qp *qp);
+	struct ib_qp *(*iw_get_qp)(struct ib_device *device, int qpn);
+	int (*iw_connect)(struct iw_cm_id *cm_id,
+			  struct iw_cm_conn_param *conn_param);
+	int (*iw_accept)(struct iw_cm_id *cm_id,
+			 struct iw_cm_conn_param *conn_param);
+	int (*iw_reject)(struct iw_cm_id *cm_id, const void *pdata,
+			 u8 pdata_len);
+	int (*iw_create_listen)(struct iw_cm_id *cm_id, int backlog);
+	int (*iw_destroy_listen)(struct iw_cm_id *cm_id);
+
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
@@ -2591,8 +2604,6 @@ struct ib_device {
 
 	int			      num_comp_vectors;
 
-	struct iw_cm_verbs	     *iwcm;
-
 	struct module               *owner;
 	union {
 		struct device		dev;
@@ -2645,6 +2656,10 @@ struct ib_device {
 	struct mutex compat_devs_mutex;
 	/* Maintains compat devices for each net namespace */
 	struct xarray compat_devs;
+
+	/* Used by iWarp CM */
+	char iw_ifname[IFNAMSIZ];
+	u32 iw_driver_flags;
 };
 
 struct ib_client {
diff --git a/include/rdma/iw_cm.h b/include/rdma/iw_cm.h
index 0e1f02815643..5aa8a9c76aa0 100644
--- a/include/rdma/iw_cm.h
+++ b/include/rdma/iw_cm.h
@@ -118,31 +118,6 @@ enum iw_flags {
 	IW_F_NO_PORT_MAP = (1 << 0),
 };
 
-struct iw_cm_verbs {
-	void		(*add_ref)(struct ib_qp *qp);
-
-	void		(*rem_ref)(struct ib_qp *qp);
-
-	struct ib_qp *	(*get_qp)(struct ib_device *device,
-				  int qpn);
-
-	int		(*connect)(struct iw_cm_id *cm_id,
-				   struct iw_cm_conn_param *conn_param);
-
-	int		(*accept)(struct iw_cm_id *cm_id,
-				  struct iw_cm_conn_param *conn_param);
-
-	int		(*reject)(struct iw_cm_id *cm_id,
-				  const void *pdata, u8 pdata_len);
-
-	int		(*create_listen)(struct iw_cm_id *cm_id,
-					 int backlog);
-
-	int		(*destroy_listen)(struct iw_cm_id *cm_id);
-	char		ifname[IFNAMSIZ];
-	enum iw_flags	driver_flags;
-};
-
 /**
  * iw_create_cm_id - Create an IW CM identifier.
  *
-- 
2.20.1

