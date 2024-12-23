Return-Path: <linux-rdma+bounces-6696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B389FA8B9
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 01:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9207A1B96
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8927B23D7;
	Mon, 23 Dec 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Rw0wKEVs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74C1FA4;
	Mon, 23 Dec 2024 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734912983; cv=none; b=VeMm1Ncm5sW6KJacL1UtrtfFMNjDmqJC/RzM6KhA/L+6GEV4v3rVmT2F0H5oymTPD8Q9JKt1BfxjP/9m3yNSPPCEUUCNKnbR+El60CZmzY58ilqsKzupoGltzFh3tkoXWaNPOEc6amHwENRsKezt19Sl0fW2WIIb0u6mUTaAnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734912983; c=relaxed/simple;
	bh=5Lip2ieF0Gy3GSKS7jVnnff8PBdM3raO1DNQhKi2MB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJNgwnGM1uy4bVkRQcJkIdi7MYVQl9uWVCDbUuRSU8aYYOoB35wVfmBoLs4PwEqxEffLdfcshPtqafQEBjbaRAe0Za7+OARJaLxdCaDtifeFUwy80PYN3VYL6cnaW4WvUIAy6W9U+W3wPhcxXQOFvXaU/3tKkmyi/o/UM128TDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Rw0wKEVs; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=8W6LHJyiQqyzr0TiDbRgJyzl27y2LsYlDz7cuqcEM5o=; b=Rw0wKEVsYLFTBaIj
	51VbV1NRwC5rGkXBd/XvHF7mplZw+BlJE15yrjfF8zynnS8gPP2i9I2QCXVRMXNe7hYgpWn8Y2/ZQ
	Fu5gmrjJ7CTPCxWW8wxTiOncKAq81na4bOum8HhJxz/ZB/q1R7wrj6gzXRvRGdAmAQsQ0NbQSmUy6
	6jgeRbUuH3OFAR56p4sdnywVeApIjqhVnVkgoiAoGm2rzF3+Pm7AV7dEJLkakPRUrdMPwr6y16FmR
	tMppSx4ERl4QJFEJ6n8TQiC5efYL3qd8AMdPGNhMjNK7vNTPwi5SaUWGaCNEipb7HZv4CRK+VVLqz
	XstLmgKg0XRX/eSZPQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPW7K-006nuE-1E;
	Mon, 23 Dec 2024 00:16:14 +0000
From: linux@treblig.org
To: mustafa.ismail@intel.com,
	tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] RDMA/irdma: Remove unused irdma_cqp_*_fpm_val_cmd functions
Date: Mon, 23 Dec 2024 00:16:13 +0000
Message-ID: <20241223001613.307138-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

irdma_cqp_commit_fpm_val_cmd() and irdma_cqp_query_fpm_val_cmd()
were added in 2021 by
commit 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
but haven't been used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/hw/irdma/osdep.h  |  4 --
 drivers/infiniband/hw/irdma/protos.h |  4 --
 drivers/infiniband/hw/irdma/utils.c  | 68 ----------------------------
 3 files changed, 76 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/osdep.h b/drivers/infiniband/hw/irdma/osdep.h
index e1e3d3ae72b7..ddf02a462efa 100644
--- a/drivers/infiniband/hw/irdma/osdep.h
+++ b/drivers/infiniband/hw/irdma/osdep.h
@@ -59,10 +59,6 @@ int irdma_cqp_sds_cmd(struct irdma_sc_dev *dev,
 int irdma_cqp_manage_hmc_fcn_cmd(struct irdma_sc_dev *dev,
 				 struct irdma_hmc_fcn_info *hmcfcninfo,
 				 u16 *pmf_idx);
-int irdma_cqp_query_fpm_val_cmd(struct irdma_sc_dev *dev,
-				struct irdma_dma_mem *val_mem, u8 hmc_fn_id);
-int irdma_cqp_commit_fpm_val_cmd(struct irdma_sc_dev *dev,
-				 struct irdma_dma_mem *val_mem, u8 hmc_fn_id);
 int irdma_alloc_query_fpm_buf(struct irdma_sc_dev *dev,
 			      struct irdma_dma_mem *mem);
 void *irdma_remove_cqp_head(struct irdma_sc_dev *dev);
diff --git a/drivers/infiniband/hw/irdma/protos.h b/drivers/infiniband/hw/irdma/protos.h
index d7c8ea948bcd..c0c9441885d3 100644
--- a/drivers/infiniband/hw/irdma/protos.h
+++ b/drivers/infiniband/hw/irdma/protos.h
@@ -85,10 +85,6 @@ int irdma_process_cqp_cmd(struct irdma_sc_dev *dev,
 int irdma_process_bh(struct irdma_sc_dev *dev);
 int irdma_cqp_sds_cmd(struct irdma_sc_dev *dev,
 		      struct irdma_update_sds_info *info);
-int irdma_cqp_query_fpm_val_cmd(struct irdma_sc_dev *dev,
-				struct irdma_dma_mem *val_mem, u8 hmc_fn_id);
-int irdma_cqp_commit_fpm_val_cmd(struct irdma_sc_dev *dev,
-				 struct irdma_dma_mem *val_mem, u8 hmc_fn_id);
 int irdma_alloc_query_fpm_buf(struct irdma_sc_dev *dev,
 			      struct irdma_dma_mem *mem);
 int irdma_cqp_manage_hmc_fcn_cmd(struct irdma_sc_dev *dev,
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 0422787592d8..1ea29994ace3 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -971,74 +971,6 @@ void irdma_terminate_del_timer(struct irdma_sc_qp *qp)
 		irdma_qp_rem_ref(&iwqp->ibqp);
 }
 
-/**
- * irdma_cqp_query_fpm_val_cmd - send cqp command for fpm
- * @dev: function device struct
- * @val_mem: buffer for fpm
- * @hmc_fn_id: function id for fpm
- */
-int irdma_cqp_query_fpm_val_cmd(struct irdma_sc_dev *dev,
-				struct irdma_dma_mem *val_mem, u8 hmc_fn_id)
-{
-	struct irdma_cqp_request *cqp_request;
-	struct cqp_cmds_info *cqp_info;
-	struct irdma_pci_f *rf = dev_to_rf(dev);
-	int status;
-
-	cqp_request = irdma_alloc_and_get_cqp_request(&rf->cqp, true);
-	if (!cqp_request)
-		return -ENOMEM;
-
-	cqp_info = &cqp_request->info;
-	cqp_request->param = NULL;
-	cqp_info->in.u.query_fpm_val.cqp = dev->cqp;
-	cqp_info->in.u.query_fpm_val.fpm_val_pa = val_mem->pa;
-	cqp_info->in.u.query_fpm_val.fpm_val_va = val_mem->va;
-	cqp_info->in.u.query_fpm_val.hmc_fn_id = hmc_fn_id;
-	cqp_info->cqp_cmd = IRDMA_OP_QUERY_FPM_VAL;
-	cqp_info->post_sq = 1;
-	cqp_info->in.u.query_fpm_val.scratch = (uintptr_t)cqp_request;
-
-	status = irdma_handle_cqp_op(rf, cqp_request);
-	irdma_put_cqp_request(&rf->cqp, cqp_request);
-
-	return status;
-}
-
-/**
- * irdma_cqp_commit_fpm_val_cmd - commit fpm values in hw
- * @dev: hardware control device structure
- * @val_mem: buffer with fpm values
- * @hmc_fn_id: function id for fpm
- */
-int irdma_cqp_commit_fpm_val_cmd(struct irdma_sc_dev *dev,
-				 struct irdma_dma_mem *val_mem, u8 hmc_fn_id)
-{
-	struct irdma_cqp_request *cqp_request;
-	struct cqp_cmds_info *cqp_info;
-	struct irdma_pci_f *rf = dev_to_rf(dev);
-	int status;
-
-	cqp_request = irdma_alloc_and_get_cqp_request(&rf->cqp, true);
-	if (!cqp_request)
-		return -ENOMEM;
-
-	cqp_info = &cqp_request->info;
-	cqp_request->param = NULL;
-	cqp_info->in.u.commit_fpm_val.cqp = dev->cqp;
-	cqp_info->in.u.commit_fpm_val.fpm_val_pa = val_mem->pa;
-	cqp_info->in.u.commit_fpm_val.fpm_val_va = val_mem->va;
-	cqp_info->in.u.commit_fpm_val.hmc_fn_id = hmc_fn_id;
-	cqp_info->cqp_cmd = IRDMA_OP_COMMIT_FPM_VAL;
-	cqp_info->post_sq = 1;
-	cqp_info->in.u.commit_fpm_val.scratch = (uintptr_t)cqp_request;
-
-	status = irdma_handle_cqp_op(rf, cqp_request);
-	irdma_put_cqp_request(&rf->cqp, cqp_request);
-
-	return status;
-}
-
 /**
  * irdma_cqp_cq_create_cmd - create a cq for the cqp
  * @dev: device pointer
-- 
2.47.1


