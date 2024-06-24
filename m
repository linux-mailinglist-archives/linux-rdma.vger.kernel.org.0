Return-Path: <linux-rdma+bounces-3445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D68915312
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428521C22778
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F019D8AE;
	Mon, 24 Jun 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf9x5nBt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DF19D094
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244824; cv=none; b=S5RMPRpporRzGAhKxOmk6G566lV2jAWfc9E353ICrXV3c631pXjV47qpjvf10n/t2tF/x5F8+3jvYH1pe/3YWQyf+s22eriGYhUzh9RAi+aiu4WyHqz0wEu0e4gl58G+3GEaY332o0EnJ0IkhWTAkEYheGXpDzb4+HC3RzHJo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244824; c=relaxed/simple;
	bh=Q6+t5wdwQmI3VpKPVMF7cMAUgsEBENBrxB9V7A6b6q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N310dxQw6oldTcuOBzFHka6ko8Ch46++6pRAP8b7mi3F2T4TRptBnBf0av7O3zTaX7CNPcMQMvcd+tAviGf7VORCKuIo3HPXXpPECR6gBV5FeUguuDZnTM6o61hDg7P90gQzAuSfq/3nIFdAoVxgTjmKPt1206Be1WufvpswiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf9x5nBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF32C32782;
	Mon, 24 Jun 2024 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719244824;
	bh=Q6+t5wdwQmI3VpKPVMF7cMAUgsEBENBrxB9V7A6b6q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sf9x5nBt7r1BTNvN2qw4+4XOl/DbIEEMU8znapDPpdy/la/j2JvfFMcs4GO27Ga8C
	 FMU2dvGPbdWHaQwcjBFCPgrtICi9hylvGqSVK4laXVSe+zexsSF+jtWVAtgqZo4sm2
	 d8WWLfVU5GEcOi5S3SeChxpC+WVy8Dy3HZEaxpKjaEYNRE4laUvc++iOxf7dmHh0Hf
	 8CVxWZ4s9Pi37y1K1r3luruUGBEBQEnzgosVV4Qgv1bha6fyPQGJsYC5g0hmddraQp
	 F2Vg7g4RZis5FNBupc9VJC6Xol64rWlxJnHUdHqluKlKkcr8YM//B42SH0gnAt9mrU
	 blG3Wh9xONg+g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v1 2/2] RDMA/mlx5: Send UAR page index as ioctl attribute
Date: Mon, 24 Jun 2024 19:00:11 +0300
Message-ID: <69115cae65dcd31897ff8589b29631c62350fdd2.1719244483.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719244483.git.leon@kernel.org>
References: <cover.1719244483.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akiva Goldberger <agoldberger@nvidia.com>

Add UAR page index as a driver ioctl attribute to increase the number of
supported indices, previously limited to 16 bits by mlx5_ib_create_cq
struct.

Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c          | 28 +++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/main.c        |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  4 ++++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 172f3987fc87..74fc78ee147a 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -38,6 +38,9 @@
 #include "srq.h"
 #include "qp.h"
 
+#define UVERBS_MODULE_NAME mlx5_ib
+#include <rdma/uverbs_named_ioctl.h>
+
 static void mlx5_ib_cq_comp(struct mlx5_core_cq *cq, struct mlx5_eqe *eqe)
 {
 	struct ib_cq *ibcq = &to_mibcq(cq)->ibcq;
@@ -714,7 +717,8 @@ static int mini_cqe_res_format_to_hw(struct mlx5_ib_dev *dev, u8 format)
 
 static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 			  struct mlx5_ib_cq *cq, int entries, u32 **cqb,
-			  int *cqe_size, int *index, int *inlen)
+			  int *cqe_size, int *index, int *inlen,
+			  struct uverbs_attr_bundle *attrs)
 {
 	struct mlx5_ib_create_cq ucmd = {};
 	unsigned long page_size;
@@ -788,7 +792,11 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		 order_base_2(page_size) - MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET(cqc, cqc, page_offset, page_offset_quantized);
 
-	if (ucmd.flags & MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX) {
+	if (uverbs_attr_is_valid(attrs, MLX5_IB_ATTR_CREATE_CQ_UAR_INDEX)) {
+		err = uverbs_copy_from(index, attrs, MLX5_IB_ATTR_CREATE_CQ_UAR_INDEX);
+		if (err)
+			goto err_cqb;
+	} else if (ucmd.flags & MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX) {
 		*index = ucmd.uar_page_index;
 	} else if (context->bfregi.lib_uar_dyn) {
 		err = -EINVAL;
@@ -981,7 +989,7 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	if (udata) {
 		err = create_cq_user(dev, udata, cq, entries, &cqb, &cqe_size,
-				     &index, &inlen);
+				     &index, &inlen, attrs);
 		if (err)
 			return err;
 	} else {
@@ -1443,3 +1451,17 @@ int mlx5_ib_generate_wc(struct ib_cq *ibcq, struct ib_wc *wc)
 
 	return 0;
 }
+
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	mlx5_ib_cq_create,
+	UVERBS_OBJECT_CQ,
+	UVERBS_METHOD_CQ_CREATE,
+	UVERBS_ATTR_PTR_IN(
+		MLX5_IB_ATTR_CREATE_CQ_UAR_INDEX,
+		UVERBS_ATTR_TYPE(u32),
+		UA_OPTIONAL));
+
+const struct uapi_definition mlx5_ib_create_cq_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_CQ, &mlx5_ib_cq_create),
+	{},
+};
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 4a0380e711ea..89083f454952 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3833,6 +3833,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 	UAPI_DEF_CHAIN(mlx5_ib_qos_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_std_types_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_dm_defs),
+	UAPI_DEF_CHAIN(mlx5_ib_create_cq_defs),
 
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_DEVICE, &mlx5_ib_query_context),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(MLX5_IB_OBJECT_VAR,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2b03e607561e..c718c2cfffb8 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1532,6 +1532,7 @@ extern const struct uapi_definition mlx5_ib_devx_defs[];
 extern const struct uapi_definition mlx5_ib_flow_defs[];
 extern const struct uapi_definition mlx5_ib_qos_defs[];
 extern const struct uapi_definition mlx5_ib_std_types_defs[];
+extern const struct uapi_definition mlx5_ib_create_cq_defs[];
 
 static inline int is_qp1(enum ib_qp_type qp_type)
 {
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 595edad03dfe..5b74d6534899 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -270,6 +270,10 @@ enum mlx5_ib_device_query_context_attrs {
 	MLX5_IB_ATTR_QUERY_CONTEXT_RESP_UCTX = (1U << UVERBS_ID_NS_SHIFT),
 };
 
+enum mlx5_ib_create_cq_attrs {
+	MLX5_IB_ATTR_CREATE_CQ_UAR_INDEX = UVERBS_ID_DRIVER_NS_WITH_UHW,
+};
+
 #define MLX5_IB_DW_MATCH_PARAM 0xA0
 
 struct mlx5_ib_match_params {
-- 
2.45.2


