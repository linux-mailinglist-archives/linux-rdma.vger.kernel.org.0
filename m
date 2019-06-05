Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63275362DA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfFERjb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:39:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42559 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfFERjb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:39:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id b18so5673421qkc.9
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=roOl2Usy0w6+997U+yRf4AcFZUd7SJKqSBksvliQMZs=;
        b=lZkKE+pDR4cDFwOYlOiuId+Uw5QsOo4fhLOm2auUBYI7/uxBjkEZALTnbXPvnTBqaN
         tvwwNh9PEm1DMTxUs8PuAfPqsdeBX0bYjxWPv38Pt00LPVHGNvb8GPRmJv9tbRTyWUXp
         HtFY2C/KodK/Dv/TqQk8zNgZExdozIg/znN7nuqHawp0KTfVQSVffdOpXfB/sFaXaweC
         fLS9y2sat1OkUaU3aT2XoDrSZ2QjjEAUWGrVWdXZfS9GRC/t+u9ejgN/Afsvw5J6/Y/z
         FT6Tlm9k+0kmK/KvugN7wH+ndbMYSnhw+PMZIC1ZUINuvImAWWgQkYcMs6isZnhcSk+1
         /ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=roOl2Usy0w6+997U+yRf4AcFZUd7SJKqSBksvliQMZs=;
        b=iQdvjbutF8y/5HEtuXJi1VtsnRVoxp/C7+xW8eHDYE9tvRDI3x/+6X7gM1yzAGi46x
         D57lNSsnErhfVuLrUS6QnvxaYJ4f6kKOF+nQR3K3zxgJ9SUCMaz13wknOUJPRXEnqgQL
         J8T3LAjzMfjSx1sI4hXCf6w0kQETF8I56Ruq559BM4DZ8uuy6SE3RfH2cbn2rg9oBnws
         DiRsGK7FuRMKIYeGtzL33771ahmQtklwxIZAclYDENbrFCMzVc2XIjVHlnWa44vHbFRs
         abKFdRKRpUlHJI9EJwuWuBfywAqbkIjxAYgfF2i8TxTMW+u7ppH6drRciFyN0SoDhm3S
         /ARA==
X-Gm-Message-State: APjAAAX5H+myiFIAmLsShUqrYQvbuJZFPJuq962qaRO9xeK50fu1fFNf
        8GmelHWjeJ3ipB3Q3eZVOZHoQGLuqvQ0WA==
X-Google-Smtp-Source: APXvYqyOJtUV3qh8DaVqJktLVRQve/VXnbBiSYiM00hd2Idt3kE3JAvo4ZyAHDNjjm5aau/CltIuaQ==
X-Received: by 2002:a37:b7c6:: with SMTP id h189mr34192107qkf.347.1559756369431;
        Wed, 05 Jun 2019 10:39:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i37sm13006556qtb.31.2019.06.05.10.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 10:39:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYZsl-0004gY-QI; Wed, 05 Jun 2019 14:39:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 3/3] RDMA: Move owner into struct ib_device_ops
Date:   Wed,  5 Jun 2019 14:39:26 -0300
Message-Id: <20190605173926.16995-4-jgg@ziepe.ca>
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

This more closely follows how other subsytems work, with owner being a
member of the structure containing the function pointers.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/device.c               | 4 ++++
 drivers/infiniband/core/uverbs_main.c          | 6 +++---
 drivers/infiniband/hw/bnxt_re/main.c           | 2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c    | 2 +-
 drivers/infiniband/hw/cxgb4/provider.c         | 2 +-
 drivers/infiniband/hw/efa/efa_main.c           | 2 +-
 drivers/infiniband/hw/hfi1/verbs.c             | 2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c      | 2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c      | 2 +-
 drivers/infiniband/hw/mlx4/main.c              | 2 +-
 drivers/infiniband/hw/mlx5/main.c              | 2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c   | 3 +--
 drivers/infiniband/hw/nes/nes_verbs.c          | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c     | 2 +-
 drivers/infiniband/hw/qedr/main.c              | 2 +-
 drivers/infiniband/hw/qib/qib_verbs.c          | 2 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c    | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c          | 2 +-
 include/rdma/ib_verbs.h                        | 2 +-
 20 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index fa5100dbb277e1..49e5ea3a530f53 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2349,6 +2349,10 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 			dev_ops->driver_id != ops->driver_id);
 		dev_ops->driver_id = ops->driver_id;
 	}
+	if (ops->owner) {
+		WARN_ON(dev_ops->owner && dev_ops->owner != ops->owner);
+		dev_ops->owner = ops->owner;
+	}
 	if (ops->uverbs_abi_ver)
 		dev_ops->uverbs_abi_ver = ops->uverbs_abi_ver;
 
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 0f8a286a92d3de..870b3dd35aac63 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -198,7 +198,7 @@ void ib_uverbs_release_file(struct kref *ref)
 	ib_dev = srcu_dereference(file->device->ib_dev,
 				  &file->device->disassociate_srcu);
 	if (ib_dev && !ib_dev->ops.disassociate_ucontext)
-		module_put(ib_dev->owner);
+		module_put(ib_dev->ops.owner);
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 
 	if (atomic_dec_and_test(&file->device->refcount))
@@ -1065,7 +1065,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	module_dependent = !(ib_dev->ops.disassociate_ucontext);
 
 	if (module_dependent) {
-		if (!try_module_get(ib_dev->owner)) {
+		if (!try_module_get(ib_dev->ops.owner)) {
 			ret = -ENODEV;
 			goto err;
 		}
@@ -1100,7 +1100,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	return stream_open(inode, filp);
 
 err_module:
-	module_put(ib_dev->owner);
+	module_put(ib_dev->ops.owner);
 
 err:
 	mutex_unlock(&dev->lists_mutex);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a45cb9ee51abf9..351c420248a0cc 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -596,6 +596,7 @@ static void bnxt_re_unregister_ib(struct bnxt_re_dev *rdev)
 }
 
 static const struct ib_device_ops bnxt_re_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_BNXT_RE,
 	.uverbs_abi_ver = BNXT_RE_ABI_VERSION,
 
@@ -651,7 +652,6 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 	int ret;
 
 	/* ib device init */
-	ibdev->owner = THIS_MODULE;
 	ibdev->node_type = RDMA_NODE_IB_CA;
 	strlcpy(ibdev->node_desc, BNXT_RE_DESC " HCA",
 		strlen(BNXT_RE_DESC) + 5);
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index be3756c1f3f655..6a3e2e5c3efcca 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -1304,6 +1304,7 @@ static void get_dev_fw_ver_str(struct ib_device *ibdev, char *str)
 }
 
 static const struct ib_device_ops iwch_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_CXGB3,
 	.uverbs_abi_ver = IWCH_UVERBS_ABI_VERSION,
 
@@ -1354,7 +1355,6 @@ int iwch_register_device(struct iwch_dev *dev)
 	pr_debug("%s iwch_dev %p\n", __func__, dev);
 	memset(&dev->ibdev.node_guid, 0, sizeof(dev->ibdev.node_guid));
 	memcpy(&dev->ibdev.node_guid, dev->rdev.t3cdev_p->lldev->dev_addr, 6);
-	dev->ibdev.owner = THIS_MODULE;
 	dev->device_cap_flags = IB_DEVICE_LOCAL_DMA_LKEY |
 				IB_DEVICE_MEM_WINDOW |
 				IB_DEVICE_MEM_MGT_EXTENSIONS;
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 2968d5c58f8774..bcc3533a857fab 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -490,6 +490,7 @@ static int fill_res_entry(struct sk_buff *msg, struct rdma_restrack_entry *res)
 }
 
 static const struct ib_device_ops c4iw_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_CXGB4,
 	.uverbs_abi_ver = C4IW_UVERBS_ABI_VERSION,
 
@@ -564,7 +565,6 @@ void c4iw_register_device(struct work_struct *work)
 	pr_debug("c4iw_dev %p\n", dev);
 	memset(&dev->ibdev.node_guid, 0, sizeof(dev->ibdev.node_guid));
 	memcpy(&dev->ibdev.node_guid, dev->rdev.lldi.ports[0]->dev_addr, 6);
-	dev->ibdev.owner = THIS_MODULE;
 	dev->device_cap_flags = IB_DEVICE_LOCAL_DMA_LKEY | IB_DEVICE_MEM_WINDOW;
 	if (fastreg_support)
 		dev->device_cap_flags |= IB_DEVICE_MEM_MGT_EXTENSIONS;
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index b05c5a0b9bc0be..b891ee239a6755 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -197,6 +197,7 @@ static void efa_stats_init(struct efa_dev *dev)
 }
 
 static const struct ib_device_ops efa_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_EFA,
 	.uverbs_abi_ver = EFA_UVERBS_ABI_VERSION,
 
@@ -262,7 +263,6 @@ static int efa_ib_device_add(struct efa_dev *dev)
 	if (err)
 		goto err_release_doorbell_bar;
 
-	dev->ibdev.owner = THIS_MODULE;
 	dev->ibdev.node_type = RDMA_NODE_UNSPECIFIED;
 	dev->ibdev.phys_port_cnt = 1;
 	dev->ibdev.num_comp_vectors = 1;
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 563f0946516001..de6fdd6a2b7e10 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1777,6 +1777,7 @@ static int get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 }
 
 static const struct ib_device_ops hfi1_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_HFI1,
 
 	.alloc_hw_stats = alloc_hw_stats,
@@ -1829,7 +1830,6 @@ int hfi1_register_ib_device(struct hfi1_devdata *dd)
 	 */
 	if (!ib_hfi1_sys_image_guid)
 		ib_hfi1_sys_image_guid = ibdev->node_guid;
-	ibdev->owner = THIS_MODULE;
 	ibdev->phys_port_cnt = dd->num_pports;
 	ibdev->dev.parent = &dd->pcidev->dev;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 70420193a53f93..58bb64560d4a88 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -423,6 +423,7 @@ static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev)
 }
 
 static const struct ib_device_ops hns_roce_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_HNS,
 	.uverbs_abi_ver = 1,
 
@@ -492,7 +493,6 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 
 	ib_dev = &hr_dev->ib_dev;
 
-	ib_dev->owner			= THIS_MODULE;
 	ib_dev->node_type		= RDMA_NODE_IB_CA;
 	ib_dev->dev.parent		= dev;
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index bf1d232f94c83e..6463eec0c1a8bf 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2655,6 +2655,7 @@ static int i40iw_query_pkey(struct ib_device *ibdev,
 }
 
 static const struct ib_device_ops i40iw_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_I40IW,
 	/* NOTE: Older kernels wrongly use 0 for the uverbs_abi_ver */
 	.uverbs_abi_ver = I40IW_ABI_VER,
@@ -2716,7 +2717,6 @@ static struct i40iw_ib_device *i40iw_init_rdma_device(struct i40iw_device *iwdev
 		i40iw_pr_err("iwdev == NULL\n");
 		return NULL;
 	}
-	iwibdev->ibdev.owner = THIS_MODULE;
 	iwdev->iwibdev = iwibdev;
 	iwibdev->iwdev = iwdev;
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 1f87221acbb056..5d7a87842291d5 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2510,6 +2510,7 @@ static void get_fw_ver_str(struct ib_device *device, char *str)
 }
 
 static const struct ib_device_ops mlx4_ib_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MLX4,
 	.uverbs_abi_ver = MLX4_IB_UVERBS_ABI_VERSION,
 
@@ -2646,7 +2647,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	ibdev->dev = dev;
 	ibdev->bond_next_port	= 0;
 
-	ibdev->ib_dev.owner		= THIS_MODULE;
 	ibdev->ib_dev.node_type		= RDMA_NODE_IB_CA;
 	ibdev->ib_dev.local_dma_lkey	= dev->caps.reserved_lkey;
 	ibdev->num_ports		= num_ports;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 8d12a55e95ec87..e48a61d4f4466a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6044,7 +6044,6 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (mlx5_use_mad_ifc(dev))
 		get_ext_port_caps(dev);
 
-	dev->ib_dev.owner		= THIS_MODULE;
 	dev->ib_dev.node_type		= RDMA_NODE_IB_CA;
 	dev->ib_dev.local_dma_lkey	= 0 /* not supported for now */;
 	dev->ib_dev.phys_port_cnt	= dev->num_ports;
@@ -6124,6 +6123,7 @@ static void mlx5_ib_stage_flow_db_cleanup(struct mlx5_ib_dev *dev)
 }
 
 static const struct ib_device_ops mlx5_ib_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MLX5,
 	.uverbs_abi_ver	= MLX5_IB_UVERBS_ABI_VERSION,
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 690c65accea4a9..b128ff76f70966 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1153,6 +1153,7 @@ static void get_dev_fw_str(struct ib_device *device, char *str)
 }
 
 static const struct ib_device_ops mthca_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MTHCA,
 	.uverbs_abi_ver = MTHCA_UVERBS_ABI_VERSION,
 
@@ -1246,8 +1247,6 @@ int mthca_register_device(struct mthca_dev *dev)
 	if (ret)
 		return ret;
 
-	dev->ib_dev.owner                = THIS_MODULE;
-
 	dev->ib_dev.uverbs_cmd_mask	 =
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
 		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index 1d9822695f8da6..f10686d320142a 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -3560,6 +3560,7 @@ static void get_dev_fw_str(struct ib_device *dev, char *str)
 }
 
 static const struct ib_device_ops nes_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_NES,
 	/* NOTE: Older kernels wrongly use 0 for the uverbs_abi_ver */
 	.uverbs_abi_ver = NES_ABI_USERSPACE_VER,
@@ -3619,7 +3620,6 @@ struct nes_ib_device *nes_init_ofa_device(struct net_device *netdev)
 	if (nesibdev == NULL) {
 		return NULL;
 	}
-	nesibdev->ibdev.owner = THIS_MODULE;
 
 	nesibdev->ibdev.node_type = RDMA_NODE_RNIC;
 	memset(&nesibdev->ibdev.node_guid, 0, sizeof(nesibdev->ibdev.node_guid));
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index ef823f1144b522..b326313d413f75 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -144,6 +144,7 @@ static const struct attribute_group ocrdma_attr_group = {
 };
 
 static const struct ib_device_ops ocrdma_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_OCRDMA,
 	.uverbs_abi_ver = OCRDMA_ABI_VERSION,
 
@@ -203,7 +204,6 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 	BUILD_BUG_ON(sizeof(OCRDMA_NODE_DESC) > IB_DEVICE_NODE_DESC_MAX);
 	memcpy(dev->ibdev.node_desc, OCRDMA_NODE_DESC,
 	       sizeof(OCRDMA_NODE_DESC));
-	dev->ibdev.owner = THIS_MODULE;
 	dev->ibdev.uverbs_cmd_mask =
 	    OCRDMA_UVERBS(GET_CONTEXT) |
 	    OCRDMA_UVERBS(QUERY_DEVICE) |
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 793e25776a7e24..a0bb07ba0f3c0a 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -183,6 +183,7 @@ static void qedr_roce_register_device(struct qedr_dev *dev)
 }
 
 static const struct ib_device_ops qedr_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_QEDR,
 	.uverbs_abi_ver = QEDR_ABI_VERSION,
 
@@ -234,7 +235,6 @@ static int qedr_register_device(struct qedr_dev *dev)
 
 	dev->ibdev.node_guid = dev->attr.node_guid;
 	memcpy(dev->ibdev.node_desc, QEDR_NODE_DESC, sizeof(QEDR_NODE_DESC));
-	dev->ibdev.owner = THIS_MODULE;
 
 	dev->ibdev.uverbs_cmd_mask = QEDR_UVERBS(GET_CONTEXT) |
 				     QEDR_UVERBS(QUERY_DEVICE) |
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 2e8e309f221805..33778d451b827f 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1480,6 +1480,7 @@ static void qib_fill_device_attr(struct qib_devdata *dd)
 }
 
 static const struct ib_device_ops qib_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_QIB,
 
 	.init_port = qib_create_port_files,
@@ -1545,7 +1546,6 @@ int qib_register_ib_device(struct qib_devdata *dd)
 	if (!ib_qib_sys_image_guid)
 		ib_qib_sys_image_guid = ppd->guid;
 
-	ibdev->owner = THIS_MODULE;
 	ibdev->node_guid = ppd->guid;
 	ibdev->phys_port_cnt = dd->num_pports;
 	ibdev->dev.parent = &dd->pcidev->dev;
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index f6169081609580..e701322dc7401b 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -329,6 +329,7 @@ static void usnic_get_dev_fw_str(struct ib_device *device, char *str)
 }
 
 static const struct ib_device_ops usnic_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_USNIC,
 	.uverbs_abi_ver = USNIC_UVERBS_ABI_VERSION,
 
@@ -387,7 +388,6 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 
 	us_ibdev->pdev = dev;
 	us_ibdev->netdev = pci_get_drvdata(dev);
-	us_ibdev->ib_dev.owner = THIS_MODULE;
 	us_ibdev->ib_dev.node_type = RDMA_NODE_USNIC_UDP;
 	us_ibdev->ib_dev.phys_port_cnt = USNIC_IB_PORT_CNT;
 	us_ibdev->ib_dev.num_comp_vectors = USNIC_IB_NUM_COMP_VECTORS;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 2a7eb2838453d4..0c48464ffff1b7 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -144,6 +144,7 @@ static int pvrdma_port_immutable(struct ib_device *ibdev, u8 port_num,
 }
 
 static const struct ib_device_ops pvrdma_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_VMW_PVRDMA,
 	.uverbs_abi_ver = PVRDMA_UVERBS_ABI_VERSION,
 
@@ -201,7 +202,6 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 	dev->ib_dev.node_guid = dev->dsr->caps.node_guid;
 	dev->sys_image_guid = dev->dsr->caps.sys_image_guid;
 	dev->flags = 0;
-	dev->ib_dev.owner = THIS_MODULE;
 	dev->ib_dev.num_comp_vectors = 1;
 	dev->ib_dev.dev.parent = &dev->pdev->dev;
 	dev->ib_dev.uverbs_cmd_mask =
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9e87cdb82becaa..046129393215da 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1111,6 +1111,7 @@ static int rxe_enable_driver(struct ib_device *ib_dev)
 }
 
 static const struct ib_device_ops rxe_dev_ops = {
+	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_RXE,
 	.uverbs_abi_ver = RXE_UVERBS_ABI_VERSION,
 
@@ -1173,7 +1174,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	strlcpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
 
-	dev->owner = THIS_MODULE;
 	dev->node_type = RDMA_NODE_IB_CA;
 	dev->phys_port_cnt = 1;
 	dev->num_comp_vectors = num_possible_cpus();
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9e0d5ec35f4192..cdfeeda1db7f31 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2329,6 +2329,7 @@ struct iw_cm_conn_param;
  * need to define the supported operations, otherwise they will be set to null.
  */
 struct ib_device_ops {
+	struct module *owner;
 	enum rdma_driver_id driver_id;
 	u32 uverbs_abi_ver;
 
@@ -2639,7 +2640,6 @@ struct ib_device {
 
 	int			      num_comp_vectors;
 
-	struct module               *owner;
 	union {
 		struct device		dev;
 		struct ib_core_device	coredev;
-- 
2.21.0

