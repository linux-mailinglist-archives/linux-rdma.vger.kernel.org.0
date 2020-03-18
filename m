Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998C8189C2C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 13:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCRMnl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 08:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgCRMnl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 08:43:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E248120768;
        Wed, 18 Mar 2020 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584535420;
        bh=vASXrDvoBFpmoQSL6/mstCHhAm3Ufn+ewWf5WFgg8YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQXWZkA2E9SQBWk6eWUQ/ngY8uJF0UtsALqy6R+bBQaY1N4ID8zfzAtjjQA9/aXMQ
         rVxQgRDaIMLErWef5cYH65lKra+9zM2FWNEe2BETXdSGsoFgbLT3mxNwZ73FvqhrCr
         zweoUDJnef3+Sqiy/mLuQPNDd85jl66jNE5Djkd4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: [PATCH rdma-next 1/4] IB/mlx5: Expose UAR object and its alloc/destroy commands
Date:   Wed, 18 Mar 2020 14:43:26 +0200
Message-Id: <20200318124329.52111-2-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318124329.52111-1-leon@kernel.org>
References: <20200318124329.52111-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Expose UAR object and its alloc/destroy commands to be used over the
ioctl interface by user space applications.

This API supports both BF & NC modes and enables a dynamic allocation of
UARs once really needed.

As the number of driver objects were limited by the core ones when the
merged tree is prepared, had to decrease the number of core objects to
enable the new UAR object usage.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c         | 172 ++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h      |   2 +
 include/rdma/uverbs_ioctl.h               |   2 +-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h  |  18 +++
 include/uapi/rdma/mlx5_user_ioctl_verbs.h |   5 +
 5 files changed, 189 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 05804e4ba292..e8787af2d74d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2022,6 +2022,17 @@ static phys_addr_t uar_index2pfn(struct mlx5_ib_dev *dev,
 	return (dev->mdev->bar_addr >> PAGE_SHIFT) + uar_idx / fw_uars_per_page;
 }
 
+static u64 uar_index2paddress(struct mlx5_ib_dev *dev,
+				 int uar_idx)
+{
+	unsigned int fw_uars_per_page;
+
+	fw_uars_per_page = MLX5_CAP_GEN(dev->mdev, uar_4k) ?
+				MLX5_UARS_IN_PAGE : 1;
+
+	return (dev->mdev->bar_addr + (uar_idx / fw_uars_per_page) * PAGE_SIZE);
+}
+
 static int get_command(unsigned long offset)
 {
 	return (offset >> MLX5_IB_MMAP_CMD_SHIFT) & MLX5_IB_MMAP_CMD_MASK;
@@ -2106,6 +2117,11 @@ static void mlx5_ib_mmap_free(struct rdma_user_mmap_entry *entry)
 		mutex_unlock(&var_table->bitmap_lock);
 		kfree(mentry);
 		break;
+	case MLX5_IB_MMAP_TYPE_UAR_WC:
+	case MLX5_IB_MMAP_TYPE_UAR_NC:
+		mlx5_cmd_free_uar(dev->mdev, mentry->page_idx);
+		kfree(mentry);
+		break;
 	default:
 		WARN_ON(true);
 	}
@@ -2257,7 +2273,8 @@ static int mlx5_ib_mmap_offset(struct mlx5_ib_dev *dev,
 
 	mentry = to_mmmap(entry);
 	pfn = (mentry->address >> PAGE_SHIFT);
-	if (mentry->mmap_flag == MLX5_IB_MMAP_TYPE_VAR)
+	if (mentry->mmap_flag == MLX5_IB_MMAP_TYPE_VAR ||
+	    mentry->mmap_flag == MLX5_IB_MMAP_TYPE_UAR_NC)
 		prot = pgprot_noncached(vma->vm_page_prot);
 	else
 		prot = pgprot_writecombine(vma->vm_page_prot);
@@ -6079,9 +6096,9 @@ static void mlx5_ib_cleanup_multiport_master(struct mlx5_ib_dev *dev)
 	mlx5_nic_vport_disable_roce(dev->mdev);
 }
 
-static int var_obj_cleanup(struct ib_uobject *uobject,
-			   enum rdma_remove_reason why,
-			   struct uverbs_attr_bundle *attrs)
+static int mmap_obj_cleanup(struct ib_uobject *uobject,
+			    enum rdma_remove_reason why,
+			    struct uverbs_attr_bundle *attrs)
 {
 	struct mlx5_user_mmap_entry *obj = uobject->object;
 
@@ -6089,6 +6106,16 @@ static int var_obj_cleanup(struct ib_uobject *uobject,
 	return 0;
 }
 
+static int mlx5_rdma_user_mmap_entry_insert(struct mlx5_ib_ucontext *c,
+					    struct mlx5_user_mmap_entry *entry,
+					    size_t length)
+{
+	return rdma_user_mmap_entry_insert_range(
+		&c->ibucontext, &entry->rdma_entry, length,
+		(MLX5_IB_MMAP_OFFSET_START << 16),
+		((MLX5_IB_MMAP_OFFSET_END << 16) + (1UL << 16) - 1));
+}
+
 static struct mlx5_user_mmap_entry *
 alloc_var_entry(struct mlx5_ib_ucontext *c)
 {
@@ -6119,10 +6146,8 @@ alloc_var_entry(struct mlx5_ib_ucontext *c)
 	entry->page_idx = page_idx;
 	entry->mmap_flag = MLX5_IB_MMAP_TYPE_VAR;
 
-	err = rdma_user_mmap_entry_insert_range(
-		&c->ibucontext, &entry->rdma_entry, var_table->stride_size,
-		MLX5_IB_MMAP_OFFSET_START << 16,
-		(MLX5_IB_MMAP_OFFSET_END << 16) + (1UL << 16) - 1);
+	err = mlx5_rdma_user_mmap_entry_insert(c, entry,
+					       var_table->stride_size);
 	if (err)
 		goto err_insert;
 
@@ -6206,7 +6231,7 @@ DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 			UA_MANDATORY));
 
 DECLARE_UVERBS_NAMED_OBJECT(MLX5_IB_OBJECT_VAR,
-			    UVERBS_TYPE_ALLOC_IDR(var_obj_cleanup),
+			    UVERBS_TYPE_ALLOC_IDR(mmap_obj_cleanup),
 			    &UVERBS_METHOD(MLX5_IB_METHOD_VAR_OBJ_ALLOC),
 			    &UVERBS_METHOD(MLX5_IB_METHOD_VAR_OBJ_DESTROY));
 
@@ -6218,6 +6243,134 @@ static bool var_is_supported(struct ib_device *device)
 			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q);
 }
 
+static struct mlx5_user_mmap_entry *
+alloc_uar_entry(struct mlx5_ib_ucontext *c,
+		enum mlx5_ib_uapi_uar_alloc_type alloc_type)
+{
+	struct mlx5_user_mmap_entry *entry;
+	struct mlx5_ib_dev *dev;
+	u32 uar_index;
+	int err;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	dev = to_mdev(c->ibucontext.device);
+	err = mlx5_cmd_alloc_uar(dev->mdev, &uar_index);
+	if (err)
+		goto end;
+
+	entry->page_idx = uar_index;
+	entry->address = uar_index2paddress(dev, uar_index);
+	if (alloc_type == MLX5_IB_UAPI_UAR_ALLOC_TYPE_BF)
+		entry->mmap_flag = MLX5_IB_MMAP_TYPE_UAR_WC;
+	else
+		entry->mmap_flag = MLX5_IB_MMAP_TYPE_UAR_NC;
+
+	err = mlx5_rdma_user_mmap_entry_insert(c, entry, PAGE_SIZE);
+	if (err)
+		goto err_insert;
+
+	return entry;
+
+err_insert:
+	mlx5_cmd_free_uar(dev->mdev, uar_index);
+end:
+	kfree(entry);
+	return ERR_PTR(err);
+}
+
+static int UVERBS_HANDLER(MLX5_IB_METHOD_UAR_OBJ_ALLOC)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj = uverbs_attr_get_uobject(
+		attrs, MLX5_IB_ATTR_UAR_OBJ_ALLOC_HANDLE);
+	enum mlx5_ib_uapi_uar_alloc_type alloc_type;
+	struct mlx5_ib_ucontext *c;
+	struct mlx5_user_mmap_entry *entry;
+	u64 mmap_offset;
+	u32 length;
+	int err;
+
+	c = to_mucontext(ib_uverbs_get_ucontext(attrs));
+	if (IS_ERR(c))
+		return PTR_ERR(c);
+
+	err = uverbs_get_const(&alloc_type, attrs,
+			       MLX5_IB_ATTR_UAR_OBJ_ALLOC_TYPE);
+	if (err)
+		return err;
+
+	if (alloc_type != MLX5_IB_UAPI_UAR_ALLOC_TYPE_BF &&
+	    alloc_type != MLX5_IB_UAPI_UAR_ALLOC_TYPE_NC)
+		return -EOPNOTSUPP;
+
+	if (!to_mdev(c->ibucontext.device)->wc_support &&
+	    alloc_type == MLX5_IB_UAPI_UAR_ALLOC_TYPE_BF)
+		return -EOPNOTSUPP;
+
+	entry = alloc_uar_entry(c, alloc_type);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	mmap_offset = mlx5_entry_to_mmap_offset(entry);
+	length = entry->rdma_entry.npages * PAGE_SIZE;
+	uobj->object = entry;
+
+	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_UAR_OBJ_ALLOC_MMAP_OFFSET,
+			     &mmap_offset, sizeof(mmap_offset));
+	if (err)
+		goto err;
+
+	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_UAR_OBJ_ALLOC_PAGE_ID,
+			     &entry->page_idx, sizeof(entry->page_idx));
+	if (err)
+		goto err;
+
+	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_UAR_OBJ_ALLOC_MMAP_LENGTH,
+			     &length, sizeof(length));
+	if (err)
+		goto err;
+
+	return 0;
+
+err:
+	rdma_user_mmap_entry_remove(&entry->rdma_entry);
+	return err;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	MLX5_IB_METHOD_UAR_OBJ_ALLOC,
+	UVERBS_ATTR_IDR(MLX5_IB_ATTR_UAR_OBJ_ALLOC_HANDLE,
+			MLX5_IB_OBJECT_UAR,
+			UVERBS_ACCESS_NEW,
+			UA_MANDATORY),
+	UVERBS_ATTR_CONST_IN(MLX5_IB_ATTR_UAR_OBJ_ALLOC_TYPE,
+			     enum mlx5_ib_uapi_uar_alloc_type,
+			     UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_UAR_OBJ_ALLOC_PAGE_ID,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_UAR_OBJ_ALLOC_MMAP_LENGTH,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_UAR_OBJ_ALLOC_MMAP_OFFSET,
+			    UVERBS_ATTR_TYPE(u64),
+			    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(
+	MLX5_IB_METHOD_UAR_OBJ_DESTROY,
+	UVERBS_ATTR_IDR(MLX5_IB_ATTR_UAR_OBJ_DESTROY_HANDLE,
+			MLX5_IB_OBJECT_UAR,
+			UVERBS_ACCESS_DESTROY,
+			UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(MLX5_IB_OBJECT_UAR,
+			    UVERBS_TYPE_ALLOC_IDR(mmap_obj_cleanup),
+			    &UVERBS_METHOD(MLX5_IB_METHOD_UAR_OBJ_ALLOC),
+			    &UVERBS_METHOD(MLX5_IB_METHOD_UAR_OBJ_DESTROY));
+
 ADD_UVERBS_ATTRIBUTES_SIMPLE(
 	mlx5_ib_dm,
 	UVERBS_OBJECT_DM,
@@ -6249,6 +6402,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_DM, &mlx5_ib_dm),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(MLX5_IB_OBJECT_VAR,
 				UAPI_DEF_IS_OBJ_SUPPORTED(var_is_supported)),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(MLX5_IB_OBJECT_UAR),
 	{}
 };
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 85d4f3958e32..370b03db366b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -124,6 +124,8 @@ enum {
 enum mlx5_ib_mmap_type {
 	MLX5_IB_MMAP_TYPE_MEMIC = 1,
 	MLX5_IB_MMAP_TYPE_VAR = 2,
+	MLX5_IB_MMAP_TYPE_UAR_WC = 3,
+	MLX5_IB_MMAP_TYPE_UAR_NC = 4,
 };
 
 struct mlx5_ib_ucontext {
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 28570ac2b6a0..9f3b1e004046 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -173,7 +173,7 @@ enum uapi_radix_data {
 	UVERBS_API_OBJ_KEY_BITS = 5,
 	UVERBS_API_OBJ_KEY_SHIFT =
 		UVERBS_API_METHOD_KEY_BITS + UVERBS_API_METHOD_KEY_SHIFT,
-	UVERBS_API_OBJ_KEY_NUM_CORE = 24,
+	UVERBS_API_OBJ_KEY_NUM_CORE = 20,
 	UVERBS_API_OBJ_KEY_NUM_DRIVER =
 		(1 << UVERBS_API_OBJ_KEY_BITS) - UVERBS_API_OBJ_KEY_NUM_CORE,
 	UVERBS_API_OBJ_KEY_MASK = GENMASK(31, UVERBS_API_OBJ_KEY_SHIFT),
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 8f4a417fc70a..24f3388c3182 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -131,6 +131,23 @@ enum mlx5_ib_var_obj_methods {
 	MLX5_IB_METHOD_VAR_OBJ_DESTROY,
 };
 
+enum mlx5_ib_uar_alloc_attrs {
+	MLX5_IB_ATTR_UAR_OBJ_ALLOC_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	MLX5_IB_ATTR_UAR_OBJ_ALLOC_TYPE,
+	MLX5_IB_ATTR_UAR_OBJ_ALLOC_MMAP_OFFSET,
+	MLX5_IB_ATTR_UAR_OBJ_ALLOC_MMAP_LENGTH,
+	MLX5_IB_ATTR_UAR_OBJ_ALLOC_PAGE_ID,
+};
+
+enum mlx5_ib_uar_obj_destroy_attrs {
+	MLX5_IB_ATTR_UAR_OBJ_DESTROY_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum mlx5_ib_uar_obj_methods {
+	MLX5_IB_METHOD_UAR_OBJ_ALLOC = (1U << UVERBS_ID_NS_SHIFT),
+	MLX5_IB_METHOD_UAR_OBJ_DESTROY,
+};
+
 enum mlx5_ib_devx_umem_reg_attrs {
 	MLX5_IB_ATTR_DEVX_UMEM_REG_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
 	MLX5_IB_ATTR_DEVX_UMEM_REG_ADDR,
@@ -190,6 +207,7 @@ enum mlx5_ib_objects {
 	MLX5_IB_OBJECT_DEVX_ASYNC_EVENT_FD,
 	MLX5_IB_OBJECT_VAR,
 	MLX5_IB_OBJECT_PP,
+	MLX5_IB_OBJECT_UAR,
 };
 
 enum mlx5_ib_flow_matcher_create_attrs {
diff --git a/include/uapi/rdma/mlx5_user_ioctl_verbs.h b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
index b4641a7865f7..3f7a97c28045 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_verbs.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
@@ -77,5 +77,10 @@ enum mlx5_ib_uapi_pp_alloc_flags {
 	MLX5_IB_UAPI_PP_ALLOC_FLAGS_DEDICATED_INDEX = 1 << 0,
 };
 
+enum mlx5_ib_uapi_uar_alloc_type {
+	MLX5_IB_UAPI_UAR_ALLOC_TYPE_BF = 0x0,
+	MLX5_IB_UAPI_UAR_ALLOC_TYPE_NC = 0x1,
+};
+
 #endif
 
-- 
2.24.1

