Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8CC9808
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 07:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJCFsw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 01:48:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36729 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbfJCFsv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 01:48:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id j11so963157plk.3
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=n+7zRedXERX/L0koBAbltU72y2uVvnN7jZ44NVg5Z4Q=;
        b=dabdr/zIrUC9maHps61kXDkfeqKXh/zdqmcV9emVaNvN8Z57SIEgPXVk4v6JUZiJhY
         r+/Zss3PN9jfLaAxY8mk2xW6SJB8gkQV3t1swAxN3qcwQft3XUlCM1NUfZsFY8SVoDRD
         gRlRARqEPATFZEOVgL3pqTfzMDQdyqyEnm5gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n+7zRedXERX/L0koBAbltU72y2uVvnN7jZ44NVg5Z4Q=;
        b=GO8769+HOjkHDLkjZ2yycmTS9ZAPy3F+ETor0YR0Dk/bqL/Exz18BCAi2N3t4ADTxy
         2BHAHg6wsYULSIjyuwLc+Ij5Et2zSe5oGb/m+Yp2bNmvAGIKGFa2UtdJaJd4+bXNJ6U/
         I3jNZAr6TMKEkhpFcV0Ik7QydaCavb+FTpgMgDL7WpLN+KXczlutw9al2o/p4UtRbj8Y
         Q0KDqV9aeUVtHfC9oURqLGHZzC29vrHthsm5ly+6m5NQbh7QuC9T4wvMkQSvTxF49H4f
         VAvgtM2s+qgXtgkUrSRncx93Ti+i/8VCW53rM+p//h6V3+06MAZzDze9HWc82IhOz417
         1YCQ==
X-Gm-Message-State: APjAAAUZ56LO67DaG/HnRUJcoyLuBLcAIw+dDLvJW+NSfAwD2ZBoWAzY
        sYFjAfa4wIDyJb4FjI2JMe6d1xL0A5o=
X-Google-Smtp-Source: APXvYqyRwtjClby63v4q6kREH7PZSl/5XmfX7VECnrxnKIag1CehxcQHhSCmDTqjYv7Bn5odDbIUiQ==
X-Received: by 2002:a17:902:848e:: with SMTP id c14mr7803602plo.217.1570081729275;
        Wed, 02 Oct 2019 22:48:49 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x18sm1195740pge.76.2019.10.02.22.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 22:48:48 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Enable SRIOV VF support on Broadcom's 57500 adapter series
Date:   Thu,  3 Oct 2019 01:48:35 -0400
Message-Id: <1570081715-14301-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Broadcom's 575xx adapter series has support for SRIOV VFs.
Making changes to enable SRIOV VF support. There are two
major area where changes are done:
 -- Added new DB location for control-path and data-path DB ring
 -- New devices do not need to issue sriov-config slow-path command
    thus, skipping to call that firmware command.
For now enabling support for 64 RoCE VFs.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |   1 +
 drivers/infiniband/hw/bnxt_re/main.c       | 133 +++++++++++++++++------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |   5 +-
 3 files changed, 82 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index e55a166..725b235 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -108,6 +108,7 @@ struct bnxt_re_sqp_entries {
 #define BNXT_RE_MAX_MSIX		9
 #define BNXT_RE_AEQ_IDX			0
 #define BNXT_RE_NQ_IDX			1
+#define BNXT_RE_GEN_P5_MAX_VF		64
 
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 7b914bd..d6785b8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -119,61 +119,76 @@ static void bnxt_re_get_sriov_func_type(struct bnxt_re_dev *rdev)
  * reserved for the function. The driver may choose to allocate fewer
  * resources than the firmware maximum.
  */
-static void bnxt_re_set_resource_limits(struct bnxt_re_dev *rdev)
+static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 {
-	u32 vf_qps = 0, vf_srqs = 0, vf_cqs = 0, vf_mrws = 0, vf_gids = 0;
-	u32 i;
-	u32 vf_pct;
-	u32 num_vfs;
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *attr;
+	struct bnxt_qplib_ctx *ctx;
+	int i;
 
-	rdev->qplib_ctx.qpc_count = min_t(u32, BNXT_RE_MAX_QPC_COUNT,
-					  dev_attr->max_qp);
+	attr = &rdev->dev_attr;
+	ctx = &rdev->qplib_ctx;
 
-	rdev->qplib_ctx.mrw_count = BNXT_RE_MAX_MRW_COUNT_256K;
+	ctx->qpc_count = min_t(u32, BNXT_RE_MAX_QPC_COUNT,
+			       attr->max_qp);
+	ctx->mrw_count = BNXT_RE_MAX_MRW_COUNT_256K;
 	/* Use max_mr from fw since max_mrw does not get set */
-	rdev->qplib_ctx.mrw_count = min_t(u32, rdev->qplib_ctx.mrw_count,
-					  dev_attr->max_mr);
-	rdev->qplib_ctx.srqc_count = min_t(u32, BNXT_RE_MAX_SRQC_COUNT,
-					   dev_attr->max_srq);
-	rdev->qplib_ctx.cq_count = min_t(u32, BNXT_RE_MAX_CQ_COUNT,
-					 dev_attr->max_cq);
-
-	for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
-		rdev->qplib_ctx.tqm_count[i] =
-		rdev->dev_attr.tqm_alloc_reqs[i];
-
-	if (rdev->num_vfs) {
-		/*
-		 * Reserve a set of resources for the PF. Divide the remaining
-		 * resources among the VFs
-		 */
-		vf_pct = 100 - BNXT_RE_PCT_RSVD_FOR_PF;
-		num_vfs = 100 * rdev->num_vfs;
-		vf_qps = (rdev->qplib_ctx.qpc_count * vf_pct) / num_vfs;
-		vf_srqs = (rdev->qplib_ctx.srqc_count * vf_pct) / num_vfs;
-		vf_cqs = (rdev->qplib_ctx.cq_count * vf_pct) / num_vfs;
-		/*
-		 * The driver allows many more MRs than other resources. If the
-		 * firmware does also, then reserve a fixed amount for the PF
-		 * and divide the rest among VFs. VFs may use many MRs for NFS
-		 * mounts, ISER, NVME applications, etc. If the firmware
-		 * severely restricts the number of MRs, then let PF have
-		 * half and divide the rest among VFs, as for the other
-		 * resource types.
-		 */
-		if (rdev->qplib_ctx.mrw_count < BNXT_RE_MAX_MRW_COUNT_64K)
-			vf_mrws = rdev->qplib_ctx.mrw_count * vf_pct / num_vfs;
-		else
-			vf_mrws = (rdev->qplib_ctx.mrw_count -
-				   BNXT_RE_RESVD_MR_FOR_PF) / rdev->num_vfs;
-		vf_gids = BNXT_RE_MAX_GID_PER_VF;
+	ctx->mrw_count = min_t(u32, ctx->mrw_count, attr->max_mr);
+	ctx->srqc_count = min_t(u32, BNXT_RE_MAX_SRQC_COUNT,
+				attr->max_srq);
+	ctx->cq_count = min_t(u32, BNXT_RE_MAX_CQ_COUNT, attr->max_cq);
+	if (!bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx))
+		for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
+			rdev->qplib_ctx.tqm_count[i] =
+			rdev->dev_attr.tqm_alloc_reqs[i];
+}
+
+static void bnxt_re_limit_vf_res(struct bnxt_qplib_ctx *qplib_ctx, u32 num_vf)
+{
+	struct bnxt_qplib_vf_res *vf_res;
+	u32 mrws = 0;
+	u32 vf_pct;
+	u32 nvfs;
+
+	vf_res = &qplib_ctx->vf_res;
+	/*
+	 * Reserve a set of resources for the PF. Divide the remaining
+	 * resources among the VFs
+	 */
+	vf_pct = 100 - BNXT_RE_PCT_RSVD_FOR_PF;
+	nvfs = num_vf;
+	num_vf = 100 * num_vf;
+	vf_res->max_qp_per_vf = (qplib_ctx->qpc_count * vf_pct) / num_vf;
+	vf_res->max_srq_per_vf = (qplib_ctx->srqc_count * vf_pct) / num_vf;
+	vf_res->max_cq_per_vf = (qplib_ctx->cq_count * vf_pct) / num_vf;
+	/*
+	 * The driver allows many more MRs than other resources. If the
+	 * firmware does also, then reserve a fixed amount for the PF and
+	 * divide the rest among VFs. VFs may use many MRs for NFS
+	 * mounts, ISER, NVME applications, etc. If the firmware severely
+	 * restricts the number of MRs, then let PF have half and divide
+	 * the rest among VFs, as for the other resource types.
+	 */
+	if (qplib_ctx->mrw_count < BNXT_RE_MAX_MRW_COUNT_64K) {
+		mrws = qplib_ctx->mrw_count * vf_pct;
+		nvfs = num_vf;
+	} else {
+		mrws = qplib_ctx->mrw_count - BNXT_RE_RESVD_MR_FOR_PF;
 	}
-	rdev->qplib_ctx.vf_res.max_mrw_per_vf = vf_mrws;
-	rdev->qplib_ctx.vf_res.max_gid_per_vf = vf_gids;
-	rdev->qplib_ctx.vf_res.max_qp_per_vf = vf_qps;
-	rdev->qplib_ctx.vf_res.max_srq_per_vf = vf_srqs;
-	rdev->qplib_ctx.vf_res.max_cq_per_vf = vf_cqs;
+	vf_res->max_mrw_per_vf = (mrws / nvfs);
+	vf_res->max_gid_per_vf = BNXT_RE_MAX_GID_PER_VF;
+}
+
+static void bnxt_re_set_resource_limits(struct bnxt_re_dev *rdev)
+{
+	u32 num_vfs;
+
+	memset(&rdev->qplib_ctx.vf_res, 0, sizeof(struct bnxt_qplib_vf_res));
+	bnxt_re_limit_pf_res(rdev);
+
+	num_vfs =  bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx) ?
+			BNXT_RE_GEN_P5_MAX_VF : rdev->num_vfs;
+	if (num_vfs)
+		bnxt_re_limit_vf_res(&rdev->qplib_ctx, num_vfs);
 }
 
 /* for handling bnxt_en callbacks later */
@@ -193,9 +208,11 @@ static void bnxt_re_sriov_config(void *p, int num_vfs)
 		return;
 
 	rdev->num_vfs = num_vfs;
-	bnxt_re_set_resource_limits(rdev);
-	bnxt_qplib_set_func_resources(&rdev->qplib_res, &rdev->rcfw,
-				      &rdev->qplib_ctx);
+	if (!bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx)) {
+		bnxt_re_set_resource_limits(rdev);
+		bnxt_qplib_set_func_resources(&rdev->qplib_res, &rdev->rcfw,
+					      &rdev->qplib_ctx);
+	}
 }
 
 static void bnxt_re_shutdown(void *p)
@@ -894,10 +911,14 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 	return 0;
 }
 
+#define BNXT_RE_GEN_P5_PF_NQ_DB		0x10000
+#define BNXT_RE_GEN_P5_VF_NQ_DB		0x4000
 static u32 bnxt_re_get_nqdb_offset(struct bnxt_re_dev *rdev, u16 indx)
 {
 	return bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx) ?
-				0x10000 : rdev->msix_entries[indx].db_offset;
+		(rdev->is_virtfn ? BNXT_RE_GEN_P5_VF_NQ_DB :
+				   BNXT_RE_GEN_P5_PF_NQ_DB) :
+				   rdev->msix_entries[indx].db_offset;
 }
 
 static void bnxt_re_cleanup_res(struct bnxt_re_dev *rdev)
@@ -1407,8 +1428,8 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 				     rdev->is_virtfn);
 	if (rc)
 		goto disable_rcfw;
-	if (!rdev->is_virtfn)
-		bnxt_re_set_resource_limits(rdev);
+
+	bnxt_re_set_resource_limits(rdev);
 
 	rc = bnxt_qplib_alloc_ctx(rdev->en_dev->pdev, &rdev->qplib_ctx, 0,
 				  bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx));
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 60c8f76..5cdfa84 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -494,8 +494,10 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	 * shall setup this area for VF. Skipping the
 	 * HW programming
 	 */
-	if (is_virtfn || bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
+	if (is_virtfn)
 		goto skip_ctx_setup;
+	if (bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
+		goto config_vf_res;
 
 	level = ctx->qpc_tbl.level;
 	req.qpc_pg_size_qpc_lvl = (level << CMDQ_INITIALIZE_FW_QPC_LVL_SFT) |
@@ -540,6 +542,7 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	req.number_of_srq = cpu_to_le32(ctx->srqc_tbl.max_elements);
 	req.number_of_cq = cpu_to_le32(ctx->cq_tbl.max_elements);
 
+config_vf_res:
 	req.max_qp_per_vf = cpu_to_le32(ctx->vf_res.max_qp_per_vf);
 	req.max_mrw_per_vf = cpu_to_le32(ctx->vf_res.max_mrw_per_vf);
 	req.max_srq_per_vf = cpu_to_le32(ctx->vf_res.max_srq_per_vf);
-- 
1.8.3.1

