Return-Path: <linux-rdma+bounces-13503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4DBB86533
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 19:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BCB1C232DD
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09CE2820DA;
	Thu, 18 Sep 2025 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMLS+Z1l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737B14B06C;
	Thu, 18 Sep 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218031; cv=none; b=An0u96tnBg2qAbIX3UdmzWEcYVC1WI/Qoy9HcYB3Id4lATvM9SxQ/sWbpOZxJczymnQ0RyYF/oClrtWQe8LYN0tSLqBmWQNFHczGkARQFsGWG4YXtt5XEP2RUy24PcNUFF2+eUTuuBhod/97nzZ2cTCjq91qRN7CJIpumjA+fk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218031; c=relaxed/simple;
	bh=91nh9TRE12tSJRLN7urBCG83/f0V9SdpoC+jOm544KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7CtzHOKWKVLLDFOertMEqatELNT7yTzU6BLVrhcA45ZbR+3tCkFS4/qRPWl5z+2CK17Srv+88zQ3PO3A9e12tAlOzOnPMioj8MCRDy3rk3RFgzSy+mT3wilQymDik9SNq+koBIR28QhpUqxAzVFOB9CapOziqxwuNIy6RmQoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMLS+Z1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3348C4CEE7;
	Thu, 18 Sep 2025 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758218030;
	bh=91nh9TRE12tSJRLN7urBCG83/f0V9SdpoC+jOm544KI=;
	h=From:To:Cc:Subject:Date:From;
	b=VMLS+Z1liYS9E25s1XGwZJ+B2KsWYLOohQPd8nAT4bMIunnwdWkMkLo6GuxydJPhq
	 dGwxibbKbngy80lBJUQ8Wg3SW8K3RVDy6k0aU8twPn1DXiKc6owyAs2euJxWp5+tEq
	 vfUvUqs1wglFhvudPoP+hIF09S430ZNndobJBFOp9Cx5phBhZhiCBJcJFl1JQpn35z
	 v0zqIDJz+9NtYvNwsxNB9f6zelVGJZ+2sE6Eq22ojPRs1abq476pr1+qZz+SXVYVdc
	 YklnA1ghyQdRtokbHWfFVyW4aWMxgKQKK6xvK+FU9Wtz0hW24FaFysCSZQ/P6/KL/o
	 jtvPIaYV73UfQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	target-devel@vger.kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next] RDMA: Use %pe format specifier for error pointers
Date: Thu, 18 Sep 2025 20:53:41 +0300
Message-ID: <e81ec02df1e474be20417fb62e779776e3f47a50.1758217936.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Convert error logging throughout the RDMA subsystem to use
the %pe format specifier instead of PTR_ERR() with integer
format specifiers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/agent.c           |  3 +--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 ++--
 drivers/infiniband/hw/bnxt_re/main.c      |  3 +--
 drivers/infiniband/hw/cxgb4/device.c      |  5 ++---
 drivers/infiniband/hw/efa/efa_com.c       |  4 ++--
 drivers/infiniband/hw/efa/efa_verbs.c     |  6 ++++--
 drivers/infiniband/hw/hfi1/device.c       |  4 ++--
 drivers/infiniband/hw/hfi1/user_sdma.c    |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_mr.c   |  8 ++++----
 drivers/infiniband/hw/ionic/ionic_admin.c | 18 +++++++++---------
 drivers/infiniband/hw/irdma/verbs.c       |  6 +++---
 drivers/infiniband/hw/mana/main.c         |  5 ++---
 drivers/infiniband/hw/mana/mr.c           |  6 ++++--
 drivers/infiniband/hw/mlx4/mad.c          |  8 ++++----
 drivers/infiniband/hw/mlx4/qp.c           |  3 ++-
 drivers/infiniband/hw/mlx5/data_direct.c  |  2 +-
 drivers/infiniband/hw/mlx5/gsi.c          | 15 +++++++++------
 drivers/infiniband/hw/mlx5/main.c         | 14 ++++++++++----
 drivers/infiniband/hw/mlx5/mr.c           |  3 +--
 drivers/infiniband/ulp/srpt/ib_srpt.c     | 16 +++++++---------
 20 files changed, 72 insertions(+), 65 deletions(-)

diff --git a/drivers/infiniband/core/agent.c b/drivers/infiniband/core/agent.c
index 3bb46696731ee..25a060a283019 100644
--- a/drivers/infiniband/core/agent.c
+++ b/drivers/infiniband/core/agent.c
@@ -110,8 +110,7 @@ void agent_send_response(const struct ib_mad_hdr *mad_hdr, const struct ib_grh *
 	agent = port_priv->agent[qpn];
 	ah = ib_create_ah_from_wc(agent->qp->pd, wc, grh, port_num);
 	if (IS_ERR(ah)) {
-		dev_err(&device->dev, "ib_create_ah_from_wc error %ld\n",
-			PTR_ERR(ah));
+		dev_err(&device->dev, "ib_create_ah_from_wc error %pe\n", ah);
 		return;
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f12d6cd3ae931..2639ca21a0271 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3307,9 +3307,9 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 				      IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(cq->resize_umem)) {
 		rc = PTR_ERR(cq->resize_umem);
+		ibdev_err(&rdev->ibdev, "%s: ib_umem_get failed! rc = %pe\n",
+			  __func__, cq->resize_umem);
 		cq->resize_umem = NULL;
-		ibdev_err(&rdev->ibdev, "%s: ib_umem_get failed! rc = %d\n",
-			  __func__, rc);
 		goto fail;
 	}
 	cq->resize_cqe = entries;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index d8d3999d329e8..d822cdc82e659 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1956,8 +1956,7 @@ static void bnxt_re_read_vpd_info(struct bnxt_re_dev *rdev)
 
 	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
 	if (IS_ERR(vpd_data)) {
-		pci_warn(pdev, "Unable to read VPD, err=%ld\n",
-			 PTR_ERR(vpd_data));
+		pci_warn(pdev, "Unable to read VPD, err=%pe\n", vpd_data);
 		return;
 	}
 
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index b67747ae6a688..d892f55febe24 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -1228,9 +1228,8 @@ static int c4iw_uld_state_change(void *handle, enum cxgb4_state new_state)
 		if (!ctx->dev) {
 			ctx->dev = c4iw_alloc(&ctx->lldi);
 			if (IS_ERR(ctx->dev)) {
-				pr_err("%s: initialization failed: %ld\n",
-				       pci_name(ctx->lldi.pdev),
-				       PTR_ERR(ctx->dev));
+				pr_err("%s: initialization failed: %pe\n",
+				       pci_name(ctx->lldi.pdev), ctx->dev);
 				ctx->dev = NULL;
 				break;
 			}
diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index e6377602a9c41..0e979ca10d240 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -635,9 +635,9 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 	if (IS_ERR(comp_ctx)) {
 		ibdev_err_ratelimited(
 			aq->efa_dev,
-			"Failed to submit command %s (opcode %u) err %ld\n",
+			"Failed to submit command %s (opcode %u) err %pe\n",
 			efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
-			cmd->aq_common_descriptor.opcode, PTR_ERR(comp_ctx));
+			cmd->aq_common_descriptor.opcode, comp_ctx);
 
 		up(&aq->avail_cmds);
 		atomic64_inc(&aq->stats.cmd_err);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 886923d5fe506..d9a12681f8434 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1788,7 +1788,8 @@ struct ib_mr *efa_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
 						access_flags);
 	if (IS_ERR(umem_dmabuf)) {
 		err = PTR_ERR(umem_dmabuf);
-		ibdev_dbg(&dev->ibdev, "Failed to get dmabuf umem[%d]\n", err);
+		ibdev_dbg(&dev->ibdev, "Failed to get dmabuf umem[%pe]\n",
+			  umem_dmabuf);
 		goto err_free;
 	}
 
@@ -1832,7 +1833,8 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		ibdev_dbg(&dev->ibdev,
-			  "Failed to pin and map user space memory[%d]\n", err);
+			  "Failed to pin and map user space memory[%pe]\n",
+			  mr->umem);
 		goto err_free;
 	}
 
diff --git a/drivers/infiniband/hw/hfi1/device.c b/drivers/infiniband/hw/hfi1/device.c
index 4250d077b06fb..a98a4175e53bb 100644
--- a/drivers/infiniband/hw/hfi1/device.c
+++ b/drivers/infiniband/hw/hfi1/device.c
@@ -64,9 +64,9 @@ int hfi1_cdev_init(int minor, const char *name,
 
 	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
+		pr_err("Could not create device for minor %d, %s (err %pe)\n",
+		       minor, name, device);
 		device = NULL;
-		pr_err("Could not create device for minor %d, %s (err %d)\n",
-			minor, name, -ret);
 		cdev_del(cdev);
 	}
 done:
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index b72625283fcf8..9b1aece1b0800 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -498,8 +498,8 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 					ntids, sizeof(*req->tids));
 		if (IS_ERR(tmp)) {
 			ret = PTR_ERR(tmp);
-			SDMA_DBG(req, "Failed to copy %d TIDs (%d)",
-				 ntids, ret);
+			SDMA_DBG(req, "Failed to copy %d TIDs (%pe)", ntids,
+				 tmp);
 			goto free_req;
 		}
 		req->tids = tmp;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 0f037e5455205..31cb8699e1983 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -594,8 +594,8 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		mtr->umem = ib_umem_get(ibdev, user_addr, total_size,
 					buf_attr->user_access);
 		if (IS_ERR(mtr->umem)) {
-			ibdev_err(ibdev, "failed to get umem, ret = %ld.\n",
-				  PTR_ERR(mtr->umem));
+			ibdev_err(ibdev, "failed to get umem, ret = %pe.\n",
+				  mtr->umem);
 			return -ENOMEM;
 		}
 	} else {
@@ -605,8 +605,8 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 					       !mtr_has_mtt(buf_attr) ?
 					       HNS_ROCE_BUF_DIRECT : 0);
 		if (IS_ERR(mtr->kmem)) {
-			ibdev_err(ibdev, "failed to alloc kmem, ret = %ld.\n",
-				  PTR_ERR(mtr->kmem));
+			ibdev_err(ibdev, "failed to alloc kmem, ret = %pe.\n",
+				  mtr->kmem);
 			return PTR_ERR(mtr->kmem);
 		}
 	}
diff --git a/drivers/infiniband/hw/ionic/ionic_admin.c b/drivers/infiniband/hw/ionic/ionic_admin.c
index 1ba7a8ecc0733..6714f3a3adc1b 100644
--- a/drivers/infiniband/hw/ionic/ionic_admin.c
+++ b/drivers/infiniband/hw/ionic/ionic_admin.c
@@ -1108,13 +1108,13 @@ int ionic_create_rdma_admin(struct ionic_ibdev *dev)
 
 			if (eq_i < IONIC_EQ_COUNT_MIN) {
 				ibdev_err(&dev->ibdev,
-					  "fail create eq %d\n", rc);
+					  "fail create eq %pe\n", eq);
 				goto out;
 			}
 
 			/* ok, just fewer eq than device supports */
-			ibdev_dbg(&dev->ibdev, "eq count %d want %d rc %d\n",
-				  eq_i, dev->lif_cfg.eq_count, rc);
+			ibdev_dbg(&dev->ibdev, "eq count %d want %d rc %pe\n",
+				  eq_i, dev->lif_cfg.eq_count, eq);
 
 			rc = 0;
 			break;
@@ -1140,13 +1140,13 @@ int ionic_create_rdma_admin(struct ionic_ibdev *dev)
 
 			if (!aq_i) {
 				ibdev_err(&dev->ibdev,
-					  "failed to create acq %d\n", rc);
+					  "failed to create acq %pe\n", vcq);
 				goto out;
 			}
 
 			/* ok, just fewer adminq than device supports */
-			ibdev_dbg(&dev->ibdev, "acq count %d want %d rc %d\n",
-				  aq_i, dev->lif_cfg.aq_count, rc);
+			ibdev_dbg(&dev->ibdev, "acq count %d want %d rc %pe\n",
+				  aq_i, dev->lif_cfg.aq_count, vcq);
 			break;
 		}
 
@@ -1161,13 +1161,13 @@ int ionic_create_rdma_admin(struct ionic_ibdev *dev)
 
 			if (!aq_i) {
 				ibdev_err(&dev->ibdev,
-					  "failed to create aq %d\n", rc);
+					  "failed to create aq %pe\n", aq);
 				goto out;
 			}
 
 			/* ok, just fewer adminq than device supports */
-			ibdev_dbg(&dev->ibdev, "aq count %d want %d rc %d\n",
-				  aq_i, dev->lif_cfg.aq_count, rc);
+			ibdev_dbg(&dev->ibdev, "aq count %d want %d rc %pe\n",
+				  aq_i, dev->lif_cfg.aq_count, aq);
 			break;
 		}
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 24f9503f410f8..a47ccc86e485e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3600,9 +3600,9 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 
 	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd, access);
 	if (IS_ERR(umem_dmabuf)) {
-		err = PTR_ERR(umem_dmabuf);
-		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n", err);
-		return ERR_PTR(err);
+		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%pe]\n",
+			  umem_dmabuf);
+		return ERR_CAST(umem_dmabuf);
 	}
 
 	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt, IRDMA_MEMREG_TYPE_MEM);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 6a2471f2e8047..fac159f7128d9 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -273,9 +273,8 @@ int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
 
 	umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
-		err = PTR_ERR(umem);
-		ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %d\n", err);
-		return err;
+		ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %pe\n", umem);
+		return PTR_ERR(umem);
 	}
 
 	err = mana_ib_create_zero_offset_dma_region(mdev, umem, &queue->gdma_region);
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 55701046ffba1..3d0245a4c1edc 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -138,7 +138,8 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		ibdev_dbg(ibdev,
-			  "Failed to get umem for register user-mr, %d\n", err);
+			  "Failed to get umem for register user-mr, %pe\n",
+			  mr->umem);
 		goto err_free;
 	}
 
@@ -220,7 +221,8 @@ struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 leng
 	umem_dmabuf = ib_umem_dmabuf_get_pinned(ibdev, start, length, fd, access_flags);
 	if (IS_ERR(umem_dmabuf)) {
 		err = PTR_ERR(umem_dmabuf);
-		ibdev_dbg(ibdev, "Failed to get dmabuf umem, %d\n", err);
+		ibdev_dbg(ibdev, "Failed to get dmabuf umem, %pe\n",
+			  umem_dmabuf);
 		goto err_free;
 	}
 
diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index e6e132f106253..91c714f72099d 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1836,9 +1836,9 @@ static int create_pv_sqp(struct mlx4_ib_demux_pv_ctx *ctx,
 	tun_qp->qp = ib_create_qp(ctx->pd, &qp_init_attr.init_attr);
 	if (IS_ERR(tun_qp->qp)) {
 		ret = PTR_ERR(tun_qp->qp);
+		pr_err("Couldn't create %s QP (%pe)\n",
+		       create_tun ? "tunnel" : "special", tun_qp->qp);
 		tun_qp->qp = NULL;
-		pr_err("Couldn't create %s QP (%d)\n",
-		       create_tun ? "tunnel" : "special", ret);
 		return ret;
 	}
 
@@ -2017,14 +2017,14 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 			       NULL, ctx, &cq_attr);
 	if (IS_ERR(ctx->cq)) {
 		ret = PTR_ERR(ctx->cq);
-		pr_err("Couldn't create tunnel CQ (%d)\n", ret);
+		pr_err("Couldn't create tunnel CQ (%pe)\n", ctx->cq);
 		goto err_buf;
 	}
 
 	ctx->pd = ib_alloc_pd(ctx->ib_dev, 0);
 	if (IS_ERR(ctx->pd)) {
 		ret = PTR_ERR(ctx->pd);
-		pr_err("Couldn't create tunnel PD (%d)\n", ret);
+		pr_err("Couldn't create tunnel PD (%pe)\n", ctx->pd);
 		goto err_cq;
 	}
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 50fd407103c74..f2887ae6390eb 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1652,7 +1652,8 @@ int mlx4_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 			sqp->roce_v2_gsi = ib_create_qp(pd, init_attr);
 
 			if (IS_ERR(sqp->roce_v2_gsi)) {
-				pr_err("Failed to create GSI QP for RoCEv2 (%ld)\n", PTR_ERR(sqp->roce_v2_gsi));
+				pr_err("Failed to create GSI QP for RoCEv2 (%pe)\n",
+				       sqp->roce_v2_gsi);
 				sqp->roce_v2_gsi = NULL;
 			} else {
 				to_mqp(sqp->roce_v2_gsi)->flags |=
diff --git a/drivers/infiniband/hw/mlx5/data_direct.c b/drivers/infiniband/hw/mlx5/data_direct.c
index b9ba84afaae22..b81ac5709b56f 100644
--- a/drivers/infiniband/hw/mlx5/data_direct.c
+++ b/drivers/infiniband/hw/mlx5/data_direct.c
@@ -35,7 +35,7 @@ static int mlx5_data_direct_vpd_get_vuid(struct mlx5_data_direct_dev *dev)
 
 	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
 	if (IS_ERR(vpd_data)) {
-		pci_err(pdev, "Unable to read VPD, err=%ld\n", PTR_ERR(vpd_data));
+		pci_err(pdev, "Unable to read VPD, err=%pe\n", vpd_data);
 		return PTR_ERR(vpd_data);
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index b804f2dd56282..d5487834ed250 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -131,8 +131,9 @@ int mlx5_ib_create_gsi(struct ib_pd *pd, struct mlx5_ib_qp *mqp,
 	gsi->cq = ib_alloc_cq(pd->device, gsi, attr->cap.max_send_wr, 0,
 			      IB_POLL_SOFTIRQ);
 	if (IS_ERR(gsi->cq)) {
-		mlx5_ib_warn(dev, "unable to create send CQ for GSI QP. error %ld\n",
-			     PTR_ERR(gsi->cq));
+		mlx5_ib_warn(dev,
+			     "unable to create send CQ for GSI QP. error %pe\n",
+			     gsi->cq);
 		ret = PTR_ERR(gsi->cq);
 		goto err_free_wrs;
 	}
@@ -147,8 +148,9 @@ int mlx5_ib_create_gsi(struct ib_pd *pd, struct mlx5_ib_qp *mqp,
 
 	gsi->rx_qp = ib_create_qp(pd, &hw_init_attr);
 	if (IS_ERR(gsi->rx_qp)) {
-		mlx5_ib_warn(dev, "unable to create hardware GSI QP. error %ld\n",
-			     PTR_ERR(gsi->rx_qp));
+		mlx5_ib_warn(dev,
+			     "unable to create hardware GSI QP. error %pe\n",
+			     gsi->rx_qp);
 		ret = PTR_ERR(gsi->rx_qp);
 		goto err_destroy_cq;
 	}
@@ -294,8 +296,9 @@ static void setup_qp(struct mlx5_ib_gsi_qp *gsi, u16 qp_index)
 
 	qp = create_gsi_ud_qp(gsi);
 	if (IS_ERR(qp)) {
-		mlx5_ib_warn(dev, "unable to create hardware UD QP for GSI: %ld\n",
-			     PTR_ERR(qp));
+		mlx5_ib_warn(dev,
+			     "unable to create hardware UD QP for GSI: %pe\n",
+			     qp);
 		return;
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 1fbc0351063d7..fc1e86f6c4097 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3051,14 +3051,16 @@ int mlx5_ib_dev_res_cq_init(struct mlx5_ib_dev *dev)
 	pd = ib_alloc_pd(ibdev, 0);
 	if (IS_ERR(pd)) {
 		ret = PTR_ERR(pd);
-		mlx5_ib_err(dev, "Couldn't allocate PD for res init, err=%d\n", ret);
+		mlx5_ib_err(dev, "Couldn't allocate PD for res init, err=%pe\n",
+			    pd);
 		goto unlock;
 	}
 
 	cq = ib_create_cq(ibdev, NULL, NULL, NULL, &cq_attr);
 	if (IS_ERR(cq)) {
 		ret = PTR_ERR(cq);
-		mlx5_ib_err(dev, "Couldn't create CQ for res init, err=%d\n", ret);
+		mlx5_ib_err(dev, "Couldn't create CQ for res init, err=%pe\n",
+			    cq);
 		ib_dealloc_pd(pd);
 		goto unlock;
 	}
@@ -3102,7 +3104,9 @@ int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev)
 	s0 = ib_create_srq(devr->p0, &attr);
 	if (IS_ERR(s0)) {
 		ret = PTR_ERR(s0);
-		mlx5_ib_err(dev, "Couldn't create SRQ 0 for res init, err=%d\n", ret);
+		mlx5_ib_err(dev,
+			    "Couldn't create SRQ 0 for res init, err=%pe\n",
+			    s0);
 		goto unlock;
 	}
 
@@ -3114,7 +3118,9 @@ int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev)
 	s1 = ib_create_srq(devr->p0, &attr);
 	if (IS_ERR(s1)) {
 		ret = PTR_ERR(s1);
-		mlx5_ib_err(dev, "Couldn't create SRQ 1 for res init, err=%d\n", ret);
+		mlx5_ib_err(dev,
+			    "Couldn't create SRQ 1 for res init, err=%pe\n",
+			    s1);
 		ib_destroy_srq(s0);
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index aded210dc0a88..6b9ab7e59b007 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1707,8 +1707,7 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 				fd, access_flags);
 
 	if (IS_ERR(umem_dmabuf)) {
-		mlx5_ib_dbg(dev, "umem_dmabuf get failed (%ld)\n",
-			    PTR_ERR(umem_dmabuf));
+		mlx5_ib_dbg(dev, "umem_dmabuf get failed (%pe)\n", umem_dmabuf);
 		return ERR_CAST(umem_dmabuf);
 	}
 
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 5dfb4644446ba..71269446353db 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -667,9 +667,9 @@ static int srpt_refresh_port(struct srpt_port *sport)
 						  srpt_mad_recv_handler,
 						  sport, 0);
 		if (IS_ERR(mad_agent)) {
-			pr_err("%s-%d: MAD agent registration failed (%ld). Note: this is expected if SR-IOV is enabled.\n",
+			pr_err("%s-%d: MAD agent registration failed (%pe). Note: this is expected if SR-IOV is enabled.\n",
 			       dev_name(&sport->sdev->device->dev), sport->port,
-			       PTR_ERR(mad_agent));
+			       mad_agent);
 			sport->mad_agent = NULL;
 			memset(&port_modify, 0, sizeof(port_modify));
 			port_modify.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
@@ -1865,8 +1865,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 				 IB_POLL_WORKQUEUE);
 	if (IS_ERR(ch->cq)) {
 		ret = PTR_ERR(ch->cq);
-		pr_err("failed to create CQ cqe= %d ret= %d\n",
-		       ch->rq_size + sq_size, ret);
+		pr_err("failed to create CQ cqe= %d ret= %pe\n",
+		       ch->rq_size + sq_size, ch->cq);
 		goto out;
 	}
 	ch->cq_size = ch->rq_size + sq_size;
@@ -3132,7 +3132,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 	WARN_ON_ONCE(sdev->srq);
 	srq = ib_create_srq(sdev->pd, &srq_attr);
 	if (IS_ERR(srq)) {
-		pr_debug("ib_create_srq() failed: %ld\n", PTR_ERR(srq));
+		pr_debug("ib_create_srq() failed: %pe\n", srq);
 		return PTR_ERR(srq);
 	}
 
@@ -3236,8 +3236,7 @@ static int srpt_add_one(struct ib_device *device)
 	if (rdma_port_get_link_layer(device, 1) == IB_LINK_LAYER_INFINIBAND)
 		sdev->cm_id = ib_create_cm_id(device, srpt_cm_handler, sdev);
 	if (IS_ERR(sdev->cm_id)) {
-		pr_info("ib_create_cm_id() failed: %ld\n",
-			PTR_ERR(sdev->cm_id));
+		pr_info("ib_create_cm_id() failed: %pe\n", sdev->cm_id);
 		ret = PTR_ERR(sdev->cm_id);
 		sdev->cm_id = NULL;
 		if (!rdma_cm_id)
@@ -3687,8 +3686,7 @@ static struct rdma_cm_id *srpt_create_rdma_id(struct sockaddr *listen_addr)
 	rdma_cm_id = rdma_create_id(&init_net, srpt_rdma_cm_handler,
 				    NULL, RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(rdma_cm_id)) {
-		pr_err("RDMA/CM ID creation failed: %ld\n",
-		       PTR_ERR(rdma_cm_id));
+		pr_err("RDMA/CM ID creation failed: %pe\n", rdma_cm_id);
 		goto out;
 	}
 
-- 
2.51.0


