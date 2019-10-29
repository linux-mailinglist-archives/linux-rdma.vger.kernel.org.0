Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8996E8053
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfJ2G2f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfJ2G2f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:35 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1AF20862;
        Tue, 29 Oct 2019 06:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330514;
        bh=CsC7F5bgEYwjfmKxzAGKQ+wKlarRlunyV5nlGmE8xro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9ESrT+MMPKQh/9fj0OqiuJr9UwLQCOxB/A+0zVqmeZd8wgl3vtxeS4nrE8uuDYRN
         2mBO67J1cWtZztjPH0dpqzQefMTZO8qNKBW1wL6rxEj+UtX/lZj3fxFI2tAxy+fe8m
         D2HzGgIveY7vTpMYSamwUYKs3+nK5DxOeo0yliq4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 13/16] RDMA/mlx5: Rewrite MAD processing logic to be readable
Date:   Tue, 29 Oct 2019 08:27:42 +0200
Message-Id: <20191029062745.7932-14-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029062745.7932-1-leon@kernel.org>
References: <20191029062745.7932-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Multiple "if"s and "||" make extension of process_mad() function
as a tedious task, rewrite that function to be more readable.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mad.c | 116 +++++++++++++++----------------
 1 file changed, 55 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index f49d9c70246e..1c87412a162f 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -74,58 +74,6 @@ static int mlx5_MAD_IFC(struct mlx5_ib_dev *dev, int ignore_mkey,
 				port);
 }
 
-static int process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
-		       const struct ib_wc *in_wc, const struct ib_grh *in_grh,
-		       const struct ib_mad *in_mad, struct ib_mad *out_mad)
-{
-	u16 slid;
-	int err;
-
-	slid = in_wc ? ib_lid_cpu16(in_wc->slid) : be16_to_cpu(IB_LID_PERMISSIVE);
-
-	if (in_mad->mad_hdr.method == IB_MGMT_METHOD_TRAP && slid == 0)
-		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
-
-	if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_LID_ROUTED ||
-	    in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) {
-		if (in_mad->mad_hdr.method   != IB_MGMT_METHOD_GET &&
-		    in_mad->mad_hdr.method   != IB_MGMT_METHOD_SET &&
-		    in_mad->mad_hdr.method   != IB_MGMT_METHOD_TRAP_REPRESS)
-			return IB_MAD_RESULT_SUCCESS;
-
-		/* Don't process SMInfo queries -- the SMA can't handle them.
-		 */
-		if (in_mad->mad_hdr.attr_id == IB_SMP_ATTR_SM_INFO)
-			return IB_MAD_RESULT_SUCCESS;
-	} else if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT ||
-		   in_mad->mad_hdr.mgmt_class == MLX5_IB_VENDOR_CLASS1   ||
-		   in_mad->mad_hdr.mgmt_class == MLX5_IB_VENDOR_CLASS2   ||
-		   in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_CONG_MGMT) {
-		if (in_mad->mad_hdr.method  != IB_MGMT_METHOD_GET &&
-		    in_mad->mad_hdr.method  != IB_MGMT_METHOD_SET)
-			return IB_MAD_RESULT_SUCCESS;
-	} else {
-		return IB_MAD_RESULT_SUCCESS;
-	}
-
-	err = mlx5_MAD_IFC(to_mdev(ibdev),
-			   mad_flags & IB_MAD_IGNORE_MKEY,
-			   mad_flags & IB_MAD_IGNORE_BKEY,
-			   port_num, in_wc, in_grh, in_mad, out_mad);
-	if (err)
-		return IB_MAD_RESULT_FAILURE;
-
-	/* set return bit in status of directed route responses */
-	if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
-		out_mad->mad_hdr.status |= cpu_to_be16(1 << 15);
-
-	if (in_mad->mad_hdr.method == IB_MGMT_METHOD_TRAP_REPRESS)
-		/* no response for trap repress */
-		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
-
-	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
-}
-
 static void pma_cnt_ext_assign(struct ib_pma_portcounters_ext *pma_cnt_ext,
 			       void *out)
 {
@@ -278,17 +226,63 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
 	const struct ib_mad *in_mad = (const struct ib_mad *)in;
 	struct ib_mad *out_mad = (struct ib_mad *)out;
-	int ret;
+	u8 mgmt_class = in_mad->mad_hdr.mgmt_class;
+	u8 method = in_mad->mad_hdr.method;
+	u16 slid;
+	int err;
 
-	if (MLX5_CAP_GEN(dev->mdev, vport_counters) &&
-	    in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT &&
-	    in_mad->mad_hdr.method == IB_MGMT_METHOD_GET) {
-		ret = process_pma_cmd(dev, port_num, in_mad, out_mad);
-	} else {
-		ret =  process_mad(ibdev, mad_flags, port_num, in_wc, in_grh,
-				   in_mad, out_mad);
+	slid = in_wc ? ib_lid_cpu16(in_wc->slid) :
+		       be16_to_cpu(IB_LID_PERMISSIVE);
+
+	if (method == IB_MGMT_METHOD_TRAP && !slid)
+		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
+
+	switch (mgmt_class) {
+	case IB_MGMT_CLASS_SUBN_LID_ROUTED:
+	case IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE: {
+		if (method != IB_MGMT_METHOD_GET &&
+		    method != IB_MGMT_METHOD_SET &&
+		    method != IB_MGMT_METHOD_TRAP_REPRESS)
+			return IB_MAD_RESULT_SUCCESS;
+
+		/* Don't process SMInfo queries -- the SMA can't handle them.
+		 */
+		if (in_mad->mad_hdr.attr_id == IB_SMP_ATTR_SM_INFO)
+			return IB_MAD_RESULT_SUCCESS;
+	} break;
+	case IB_MGMT_CLASS_PERF_MGMT:
+		if (MLX5_CAP_GEN(dev->mdev, vport_counters) &&
+		    method == IB_MGMT_METHOD_GET)
+			return process_pma_cmd(dev, port_num, in_mad, out_mad);
+		/* fallthrough */
+	case MLX5_IB_VENDOR_CLASS1:
+		/* fallthrough */
+	case MLX5_IB_VENDOR_CLASS2:
+	case IB_MGMT_CLASS_CONG_MGMT: {
+		if (method != IB_MGMT_METHOD_GET &&
+		    method != IB_MGMT_METHOD_SET)
+			return IB_MAD_RESULT_SUCCESS;
+	} break;
+	default:
+		return IB_MAD_RESULT_SUCCESS;
 	}
-	return ret;
+
+	err = mlx5_MAD_IFC(to_mdev(ibdev),
+			   mad_flags & IB_MAD_IGNORE_MKEY,
+			   mad_flags & IB_MAD_IGNORE_BKEY,
+			   port_num, in_wc, in_grh, in_mad, out_mad);
+	if (err)
+		return IB_MAD_RESULT_FAILURE;
+
+	/* set return bit in status of directed route responses */
+	if (mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
+		out_mad->mad_hdr.status |= cpu_to_be16(1 << 15);
+
+	if (method == IB_MGMT_METHOD_TRAP_REPRESS)
+		/* no response for trap repress */
+		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
+
+	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
 }
 
 int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, u8 port)
-- 
2.20.1

