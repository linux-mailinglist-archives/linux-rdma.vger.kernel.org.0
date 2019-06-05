Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A868F362DB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbfFERjb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:39:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37209 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFERjb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:39:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so18978519qtk.4
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74YVvlD5d4IieWhTmVZzfEpLlK056IiN7dZC+UzPl2c=;
        b=CDbdScKlfKdk6prE4cGIcO1q5wLUd8WQWWj5RGmTl0JxhPxsrDcBoULFr+/effr5gM
         x7sr580WwCIPXoc8/DhmXWpLXplXqXwuzTm6ik+InkAaNT2FiXVxHpyTRP2z/xJJ1spK
         3GpvIYhp1yAE0Eu9xoaLftbcb2yJxuNBHQvcG/31cs4BdVI/pWGAPcxAlFFZ4ZiDNFAr
         8XMNEbmDfSgd1zPR46NRrHm0KWgN3K99rE9DON+9gTGRWE93x31CWZhAfhsxDIjhjUtM
         /HoDSLORTVG27xoa0DU83V5zlCACDLlJK0gjavqVWEO6Nsg42mHyqVTbIaTrsddLTrhF
         +BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74YVvlD5d4IieWhTmVZzfEpLlK056IiN7dZC+UzPl2c=;
        b=JbYVnkA9FrjHEko26FuFWTMWhEL7h1/3kyN8S1LqyDte7S8E8zL7q6tly5UbVLUoEW
         DFA3od/7wmjKvuLD9gVsH4eK6aFh/UXj07w5AFegkrZorE8KL/GVgCj7ZaKXxVzM/wVm
         UQsjcCVSIc4As6zh/XjLnegG5rbcWsHueMJad0tAZhfXxSn1OV8RzwxxvjpWX35RgEQt
         aANv2S6PhWfZwgSaomwopx/rgQrin1nKO3gakz23RjUpGufvvVsQNUenTacVoeRkQZwq
         54QS54C7dJNvFjOo+didPG2RQyY+fG5xaF3AuESxpj9+h0tMZjNq2X0mqR8z49+ZGx4y
         cNzA==
X-Gm-Message-State: APjAAAWHWHN2FLV7be0AqBX2ag7nqDA+yrTpaRsoGbMlA1QkKyTfZUjk
        VQkDzp/0jtjcsvgWgAIRKpWrqaoxtZNFiQ==
X-Google-Smtp-Source: APXvYqzyNDDRyTi/st9XOTFbWF0dceY75rvf1EMPpC2YNlaIUX9eaa2AjV8O6UnAjx823K2BpSx/7Q==
X-Received: by 2002:ac8:2998:: with SMTP id 24mr34526208qts.31.1559756369145;
        Wed, 05 Jun 2019 10:39:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p4sm11876928qkb.84.2019.06.05.10.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 10:39:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYZsl-0004gM-Lp; Wed, 05 Jun 2019 14:39:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 1/3] RDMA: Move driver_id into struct ib_device_ops
Date:   Wed,  5 Jun 2019 14:39:24 -0300
Message-Id: <20190605173926.16995-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605173926.16995-1-jgg@ziepe.ca>
References: <20190605173926.16995-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

No reason for every driver to emit code to set this, just make it part of
the driver's existing static const ops structure.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/device.c               | 12 +++++++++---
 drivers/infiniband/core/uverbs_uapi.c          |  2 +-
 drivers/infiniband/hw/bnxt_re/main.c           |  3 ++-
 drivers/infiniband/hw/cxgb3/iwch_provider.c    |  3 ++-
 drivers/infiniband/hw/cxgb4/provider.c         |  3 ++-
 drivers/infiniband/hw/efa/efa_main.c           |  3 ++-
 drivers/infiniband/hw/hfi1/verbs.c             |  4 +++-
 drivers/infiniband/hw/hns/hns_roce_main.c      |  3 ++-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  3 ++-
 drivers/infiniband/hw/mlx4/main.c              |  3 ++-
 drivers/infiniband/hw/mlx5/main.c              |  3 ++-
 drivers/infiniband/hw/mthca/mthca_provider.c   |  3 ++-
 drivers/infiniband/hw/nes/nes_verbs.c          |  3 ++-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  3 ++-
 drivers/infiniband/hw/qedr/main.c              |  3 ++-
 drivers/infiniband/hw/qib/qib_verbs.c          |  4 +++-
 drivers/infiniband/hw/usnic/usnic_ib_main.c    |  3 ++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  3 ++-
 drivers/infiniband/sw/rdmavt/vt.c              |  3 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c          |  3 ++-
 include/rdma/ib_verbs.h                        |  3 ++-
 include/rdma/rdma_vt.h                         |  2 +-
 22 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 29f7b15c81d946..021eb68230270e 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -375,7 +375,7 @@ struct ib_device *ib_device_get_by_name(const char *name,
 	down_read(&devices_rwsem);
 	device = __ib_device_get_by_name(name);
 	if (device && driver_id != RDMA_DRIVER_UNKNOWN &&
-	    device->driver_id != driver_id)
+	    device->ops.driver_id != driver_id)
 		device = NULL;
 
 	if (device) {
@@ -1479,7 +1479,7 @@ void ib_unregister_driver(enum rdma_driver_id driver_id)
 
 	down_read(&devices_rwsem);
 	xa_for_each (&devices, index, ib_dev) {
-		if (ib_dev->driver_id != driver_id)
+		if (ib_dev->ops.driver_id != driver_id)
 			continue;
 
 		get_device(&ib_dev->dev);
@@ -2039,7 +2039,7 @@ struct ib_device *ib_device_get_by_netdev(struct net_device *ndev,
 				    (uintptr_t)ndev) {
 		if (rcu_access_pointer(cur->netdev) == ndev &&
 		    (driver_id == RDMA_DRIVER_UNKNOWN ||
-		     cur->ib_dev->driver_id == driver_id) &&
+		     cur->ib_dev->ops.driver_id == driver_id) &&
 		    ib_device_try_get(cur->ib_dev)) {
 			res = cur->ib_dev;
 			break;
@@ -2344,6 +2344,12 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 
 #define SET_OBJ_SIZE(ptr, name) SET_DEVICE_OP(ptr, size_##name)
 
+	if (ops->driver_id != RDMA_DRIVER_UNKNOWN) {
+		WARN_ON(dev_ops->driver_id != RDMA_DRIVER_UNKNOWN &&
+			dev_ops->driver_id != ops->driver_id);
+		dev_ops->driver_id = ops->driver_id;
+	}
+
 	SET_DEVICE_OP(dev_ops, add_gid);
 	SET_DEVICE_OP(dev_ops, advise_mr);
 	SET_DEVICE_OP(dev_ops, alloc_dm);
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 7a987acf0c0bbd..e2f13b753e9c9a 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -645,7 +645,7 @@ struct uverbs_api *uverbs_alloc_api(struct ib_device *ibdev)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_RADIX_TREE(&uapi->radix, GFP_KERNEL);
-	uapi->driver_id = ibdev->driver_id;
+	uapi->driver_id = ibdev->ops.driver_id;
 
 	rc = uapi_merge_def(uapi, ibdev, uverbs_core_api, false);
 	if (rc)
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 814f959c7db965..1ef5f83ec914fe 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -596,6 +596,8 @@ static void bnxt_re_unregister_ib(struct bnxt_re_dev *rdev)
 }
 
 static const struct ib_device_ops bnxt_re_dev_ops = {
+	.driver_id = RDMA_DRIVER_BNXT_RE,
+
 	.add_gid = bnxt_re_add_gid,
 	.alloc_hw_stats = bnxt_re_ib_alloc_hw_stats,
 	.alloc_mr = bnxt_re_alloc_mr,
@@ -691,7 +693,6 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 
 
 	rdma_set_device_sysfs_group(ibdev, &bnxt_re_dev_attr_group);
-	ibdev->driver_id = RDMA_DRIVER_BNXT_RE;
 	ib_set_device_ops(ibdev, &bnxt_re_dev_ops);
 	ret = ib_device_set_netdev(&rdev->ibdev, rdev->netdev, 1);
 	if (ret)
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 3a481dfb1607a2..6cd103221c4a52 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -1304,6 +1304,8 @@ static void get_dev_fw_ver_str(struct ib_device *ibdev, char *str)
 }
 
 static const struct ib_device_ops iwch_dev_ops = {
+	.driver_id = RDMA_DRIVER_CXGB3,
+
 	.alloc_hw_stats	= iwch_alloc_stats,
 	.alloc_mr = iwch_alloc_mr,
 	.alloc_mw = iwch_alloc_mw,
@@ -1388,7 +1390,6 @@ int iwch_register_device(struct iwch_dev *dev)
 	memcpy(dev->ibdev.iw_ifname, dev->rdev.t3cdev_p->lldev->name,
 	       sizeof(dev->ibdev.iw_ifname));
 
-	dev->ibdev.driver_id = RDMA_DRIVER_CXGB3;
 	rdma_set_device_sysfs_group(&dev->ibdev, &iwch_attr_group);
 	ib_set_device_ops(&dev->ibdev, &iwch_dev_ops);
 	return ib_register_device(&dev->ibdev, "cxgb3_%d");
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 74b795642fca22..edd1115ee0f9ae 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -490,6 +490,8 @@ static int fill_res_entry(struct sk_buff *msg, struct rdma_restrack_entry *res)
 }
 
 static const struct ib_device_ops c4iw_dev_ops = {
+	.driver_id = RDMA_DRIVER_CXGB4,
+
 	.alloc_hw_stats = c4iw_alloc_stats,
 	.alloc_mr = c4iw_alloc_mr,
 	.alloc_mw = c4iw_alloc_mw,
@@ -600,7 +602,6 @@ void c4iw_register_device(struct work_struct *work)
 	       sizeof(dev->ibdev.iw_ifname));
 
 	rdma_set_device_sysfs_group(&dev->ibdev, &c4iw_attr_group);
-	dev->ibdev.driver_id = RDMA_DRIVER_CXGB4;
 	ib_set_device_ops(&dev->ibdev, &c4iw_dev_ops);
 	ret = set_netdevs(&dev->ibdev, &dev->rdev);
 	if (ret)
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index db974caf1eb1a5..3803dd4526b508 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -197,6 +197,8 @@ static void efa_stats_init(struct efa_dev *dev)
 }
 
 static const struct ib_device_ops efa_dev_ops = {
+	.driver_id = RDMA_DRIVER_EFA,
+
 	.alloc_pd = efa_alloc_pd,
 	.alloc_ucontext = efa_alloc_ucontext,
 	.create_ah = efa_create_ah,
@@ -287,7 +289,6 @@ static int efa_ib_device_add(struct efa_dev *dev)
 	dev->ibdev.uverbs_ex_cmd_mask =
 		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE);
 
-	dev->ibdev.driver_id = RDMA_DRIVER_EFA;
 	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
 
 	err = ib_register_device(&dev->ibdev, "efa_%d");
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index a2b26a635bafe6..563f0946516001 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1777,6 +1777,8 @@ static int get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 }
 
 static const struct ib_device_ops hfi1_dev_ops = {
+	.driver_id = RDMA_DRIVER_HFI1,
+
 	.alloc_hw_stats = alloc_hw_stats,
 	.alloc_rdma_netdev = hfi1_vnic_alloc_rn,
 	.get_dev_fw_str = hfi1_get_dev_fw_str,
@@ -1921,7 +1923,7 @@ int hfi1_register_ib_device(struct hfi1_devdata *dd)
 	rdma_set_device_sysfs_group(&dd->verbs_dev.rdi.ibdev,
 				    &ib_hfi1_attr_group);
 
-	ret = rvt_register_device(&dd->verbs_dev.rdi, RDMA_DRIVER_HFI1);
+	ret = rvt_register_device(&dd->verbs_dev.rdi);
 	if (ret)
 		goto err_verbs_txreq;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8da5f18bf820be..bf7cdeb2de9788 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -423,6 +423,8 @@ static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev)
 }
 
 static const struct ib_device_ops hns_roce_dev_ops = {
+	.driver_id = RDMA_DRIVER_HNS,
+
 	.add_gid = hns_roce_add_gid,
 	.alloc_pd = hns_roce_alloc_pd,
 	.alloc_ucontext = hns_roce_alloc_ucontext,
@@ -545,7 +547,6 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_srq_ops);
 	}
 
-	ib_dev->driver_id = RDMA_DRIVER_HNS;
 	ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
 	for (i = 0; i < hr_dev->caps.num_ports; i++) {
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 5689d742bafb8c..39610d91317b9e 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2655,6 +2655,8 @@ static int i40iw_query_pkey(struct ib_device *ibdev,
 }
 
 static const struct ib_device_ops i40iw_dev_ops = {
+	.driver_id = RDMA_DRIVER_I40IW,
+
 	.alloc_hw_stats = i40iw_alloc_hw_stats,
 	.alloc_mr = i40iw_alloc_mr,
 	.alloc_pd = i40iw_alloc_pd,
@@ -2795,7 +2797,6 @@ int i40iw_register_rdma_device(struct i40iw_device *iwdev)
 		return -ENOMEM;
 	iwibdev = iwdev->iwibdev;
 	rdma_set_device_sysfs_group(&iwibdev->ibdev, &i40iw_attr_group);
-	iwibdev->ibdev.driver_id = RDMA_DRIVER_I40IW;
 	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d");
 	if (ret)
 		goto error;
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 25d09d53b51c42..03847e2f7835a3 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2509,6 +2509,8 @@ static void get_fw_ver_str(struct ib_device *device, char *str)
 }
 
 static const struct ib_device_ops mlx4_ib_dev_ops = {
+	.driver_id = RDMA_DRIVER_MLX4,
+
 	.add_gid = mlx4_ib_add_gid,
 	.alloc_mr = mlx4_ib_alloc_mr,
 	.alloc_pd = mlx4_ib_alloc_pd,
@@ -2839,7 +2841,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		goto err_steer_free_bitmap;
 
 	rdma_set_device_sysfs_group(&ibdev->ib_dev, &mlx4_attr_group);
-	ibdev->ib_dev.driver_id = RDMA_DRIVER_MLX4;
 	if (ib_register_device(&ibdev->ib_dev, "mlx4_%d"))
 		goto err_diag_counters;
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 340290b883fe9f..c6eecddb4285a3 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6124,6 +6124,8 @@ static void mlx5_ib_stage_flow_db_cleanup(struct mlx5_ib_dev *dev)
 }
 
 static const struct ib_device_ops mlx5_ib_dev_ops = {
+	.driver_id = RDMA_DRIVER_MLX5,
+
 	.add_gid = mlx5_ib_add_gid,
 	.alloc_mr = mlx5_ib_alloc_mr,
 	.alloc_pd = mlx5_ib_alloc_pd,
@@ -6290,7 +6292,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	if (mlx5_accel_ipsec_device_caps(dev->mdev) &
 	    MLX5_ACCEL_IPSEC_CAP_DEVICE)
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_flow_ipsec_ops);
-	dev->ib_dev.driver_id = RDMA_DRIVER_MLX5;
 	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_ops);
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 4f40dfedf92081..d6467da39aab55 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1153,6 +1153,8 @@ static void get_dev_fw_str(struct ib_device *device, char *str)
 }
 
 static const struct ib_device_ops mthca_dev_ops = {
+	.driver_id = RDMA_DRIVER_MTHCA,
+
 	.alloc_pd = mthca_alloc_pd,
 	.alloc_ucontext = mthca_alloc_ucontext,
 	.attach_mcast = mthca_multicast_attach,
@@ -1303,7 +1305,6 @@ int mthca_register_device(struct mthca_dev *dev)
 	mutex_init(&dev->cap_mask_mutex);
 
 	rdma_set_device_sysfs_group(&dev->ib_dev, &mthca_attr_group);
-	dev->ib_dev.driver_id = RDMA_DRIVER_MTHCA;
 	ret = ib_register_device(&dev->ib_dev, "mthca%d");
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index 49024326a5180a..fc28a0a24df075 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -3560,6 +3560,8 @@ static void get_dev_fw_str(struct ib_device *dev, char *str)
 }
 
 static const struct ib_device_ops nes_dev_ops = {
+	.driver_id = RDMA_DRIVER_NES,
+
 	.alloc_mr = nes_alloc_mr,
 	.alloc_mw = nes_alloc_mw,
 	.alloc_pd = nes_alloc_pd,
@@ -3727,7 +3729,6 @@ int nes_register_ofa_device(struct nes_ib_device *nesibdev)
 	int ret;
 
 	rdma_set_device_sysfs_group(&nesvnic->nesibdev->ibdev, &nes_attr_group);
-	nesvnic->nesibdev->ibdev.driver_id = RDMA_DRIVER_NES;
 	ret = ib_register_device(&nesvnic->nesibdev->ibdev, "nes%d");
 	if (ret) {
 		return ret;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index fc6c0962dea987..a9da4b857566cc 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -144,6 +144,8 @@ static const struct attribute_group ocrdma_attr_group = {
 };
 
 static const struct ib_device_ops ocrdma_dev_ops = {
+	.driver_id = RDMA_DRIVER_OCRDMA,
+
 	.alloc_mr = ocrdma_alloc_mr,
 	.alloc_pd = ocrdma_alloc_pd,
 	.alloc_ucontext = ocrdma_alloc_ucontext,
@@ -249,7 +251,6 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 		ib_set_device_ops(&dev->ibdev, &ocrdma_dev_srq_ops);
 	}
 	rdma_set_device_sysfs_group(&dev->ibdev, &ocrdma_attr_group);
-	dev->ibdev.driver_id = RDMA_DRIVER_OCRDMA;
 	ret = ib_device_set_netdev(&dev->ibdev, dev->nic_info.netdev, 1);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 083c2c00a8e917..737745231f8ffe 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -183,6 +183,8 @@ static void qedr_roce_register_device(struct qedr_dev *dev)
 }
 
 static const struct ib_device_ops qedr_dev_ops = {
+	.driver_id = RDMA_DRIVER_QEDR,
+
 	.alloc_mr = qedr_alloc_mr,
 	.alloc_pd = qedr_alloc_pd,
 	.alloc_ucontext = qedr_alloc_ucontext,
@@ -274,7 +276,6 @@ static int qedr_register_device(struct qedr_dev *dev)
 	rdma_set_device_sysfs_group(&dev->ibdev, &qedr_attr_group);
 	ib_set_device_ops(&dev->ibdev, &qedr_dev_ops);
 
-	dev->ibdev.driver_id = RDMA_DRIVER_QEDR;
 	rc = ib_device_set_netdev(&dev->ibdev, dev->ndev, 1);
 	if (rc)
 		return rc;
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 2c4e569ce43810..2e8e309f221805 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1480,6 +1480,8 @@ static void qib_fill_device_attr(struct qib_devdata *dd)
 }
 
 static const struct ib_device_ops qib_dev_ops = {
+	.driver_id = RDMA_DRIVER_QIB,
+
 	.init_port = qib_create_port_files,
 	.modify_device = qib_modify_device,
 	.process_mad = qib_process_mad,
@@ -1614,7 +1616,7 @@ int qib_register_ib_device(struct qib_devdata *dd)
 	rdma_set_device_sysfs_group(&dd->verbs_dev.rdi.ibdev, &qib_attr_group);
 
 	ib_set_device_ops(ibdev, &qib_dev_ops);
-	ret = rvt_register_device(&dd->verbs_dev.rdi, RDMA_DRIVER_QIB);
+	ret = rvt_register_device(&dd->verbs_dev.rdi);
 	if (ret)
 		goto err_tx;
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index d88d9f8a7f9a31..47830334cb555d 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -329,6 +329,8 @@ static void usnic_get_dev_fw_str(struct ib_device *device, char *str)
 }
 
 static const struct ib_device_ops usnic_dev_ops = {
+	.driver_id = RDMA_DRIVER_USNIC,
+
 	.alloc_pd = usnic_ib_alloc_pd,
 	.alloc_ucontext = usnic_ib_alloc_ucontext,
 	.create_cq = usnic_ib_create_cq,
@@ -412,7 +414,6 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 
 	ib_set_device_ops(&us_ibdev->ib_dev, &usnic_dev_ops);
 
-	us_ibdev->ib_dev.driver_id = RDMA_DRIVER_USNIC;
 	rdma_set_device_sysfs_group(&us_ibdev->ib_dev, &usnic_attr_group);
 
 	ret = ib_device_set_netdev(&us_ibdev->ib_dev, us_ibdev->netdev, 1);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 40182297f87fd5..54a0b63726295f 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -144,6 +144,8 @@ static int pvrdma_port_immutable(struct ib_device *ibdev, u8 port_num,
 }
 
 static const struct ib_device_ops pvrdma_dev_ops = {
+	.driver_id = RDMA_DRIVER_VMW_PVRDMA,
+
 	.add_gid = pvrdma_add_gid,
 	.alloc_mr = pvrdma_alloc_mr,
 	.alloc_pd = pvrdma_alloc_pd,
@@ -261,7 +263,6 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 		if (!dev->srq_tbl)
 			goto err_qp_free;
 	}
-	dev->ib_dev.driver_id = RDMA_DRIVER_VMW_PVRDMA;
 	ret = ib_device_set_netdev(&dev->ib_dev, dev->netdev, 1);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 9546a837a8ac41..60700e197e6c79 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -530,7 +530,7 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
  *
  * Return: 0 on success otherwise an errno.
  */
-int rvt_register_device(struct rvt_dev_info *rdi, u32 driver_id)
+int rvt_register_device(struct rvt_dev_info *rdi)
 {
 	int ret = 0, i;
 
@@ -636,7 +636,6 @@ int rvt_register_device(struct rvt_dev_info *rdi, u32 driver_id)
 	if (!rdi->ibdev.num_comp_vectors)
 		rdi->ibdev.num_comp_vectors = 1;
 
-	rdi->ibdev.driver_id = driver_id;
 	/* We are now good to announce we exist */
 	ret = ib_register_device(&rdi->ibdev, dev_name(&rdi->ibdev.dev));
 	if (ret) {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8c3e2a18cfe407..3d3130dc6380bd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1111,6 +1111,8 @@ static int rxe_enable_driver(struct ib_device *ib_dev)
 }
 
 static const struct ib_device_ops rxe_dev_ops = {
+	.driver_id = RDMA_DRIVER_RXE,
+
 	.alloc_hw_stats = rxe_ib_alloc_hw_stats,
 	.alloc_mr = rxe_alloc_mr,
 	.alloc_pd = rxe_alloc_pd,
@@ -1230,7 +1232,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	rxe->tfm = tfm;
 
 	rdma_set_device_sysfs_group(dev, &rxe_attr_group);
-	dev->driver_id = RDMA_DRIVER_RXE;
 	err = ib_register_device(dev, ibdev_name);
 	if (err)
 		pr_warn("%s failed with error %d\n", __func__, err);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 54873085f2dab2..49fcb42647e33d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2329,6 +2329,8 @@ struct iw_cm_conn_param;
  * need to define the supported operations, otherwise they will be set to null.
  */
 struct ib_device_ops {
+	enum rdma_driver_id driver_id;
+
 	int (*post_send)(struct ib_qp *qp, const struct ib_send_wr *send_wr,
 			 const struct ib_send_wr **bad_send_wr);
 	int (*post_recv)(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
@@ -2672,7 +2674,6 @@ struct ib_device {
 	struct rdma_restrack_root *res;
 
 	const struct uapi_definition   *driver_def;
-	enum rdma_driver_id		driver_id;
 
 	/*
 	 * Positive refcount indicates that the device is currently
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index b9cd06db1a71e6..997f42678806c8 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -555,7 +555,7 @@ static inline u16 rvt_get_pkey(struct rvt_dev_info *rdi,
 
 struct rvt_dev_info *rvt_alloc_device(size_t size, int nports);
 void rvt_dealloc_device(struct rvt_dev_info *rdi);
-int rvt_register_device(struct rvt_dev_info *rvd, u32 driver_id);
+int rvt_register_device(struct rvt_dev_info *rvd);
 void rvt_unregister_device(struct rvt_dev_info *rvd);
 int rvt_check_ah(struct ib_device *ibdev, struct rdma_ah_attr *ah_attr);
 int rvt_init_port(struct rvt_dev_info *rdi, struct rvt_ibport *port,
-- 
2.21.0

