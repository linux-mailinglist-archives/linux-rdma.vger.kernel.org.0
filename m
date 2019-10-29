Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9024E805B
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbfJ2G2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732535AbfJ2G2r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:47 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 165BA21721;
        Tue, 29 Oct 2019 06:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330525;
        bh=dZMgyLvFx3x+AdU9Jqhnz9cwLS8RRDB5jMVFFcgJJmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fx2URNXk+mXRtjy9140OKgdQOMYPqrf5clbzjkYUxJfAKw5gfBeSJAV7cpb7cRAtM
         CMttvLa+yUa+lWrR8WutBTcN4i5z1lwHB/T9dyPgXMUap66FZXMl9ONGqU22CDzr78
         j0EVVK2Aos5kiCy1hQWAhSKBA6cxrN3C/9lHjArk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 16/16] RDMA: Change MAD processing function to remove extra casting and parameter
Date:   Tue, 29 Oct 2019 08:27:45 +0200
Message-Id: <20191029062745.7932-17-leon@kernel.org>
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

All users of process_mad() converts input pointers from ib_mad_hdr
to be ib_mad, update the function declaration to use ib_mad directly.

Also remove not used input MAD size parameter.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/mad.c            | 12 ++--
 drivers/infiniband/core/sysfs.c          |  6 +-
 drivers/infiniband/hw/hfi1/mad.c         | 13 ++---
 drivers/infiniband/hw/hfi1/verbs.h       |  5 +-
 drivers/infiniband/hw/mlx4/mad.c         | 25 ++++-----
 drivers/infiniband/hw/mlx4/mlx4_ib.h     |  7 +--
 drivers/infiniband/hw/mlx5/mad.c         | 24 ++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  5 +-
 drivers/infiniband/hw/mthca/mthca_dev.h  | 12 ++--
 drivers/infiniband/hw/mthca/mthca_mad.c  | 70 +++++++++++-------------
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c | 17 ++----
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h | 11 ++--
 drivers/infiniband/hw/qedr/verbs.c       | 17 ++----
 drivers/infiniband/hw/qedr/verbs.h       |  7 +--
 drivers/infiniband/hw/qib/qib_mad.c      | 15 ++---
 drivers/infiniband/hw/qib/qib_verbs.h    |  5 +-
 include/rdma/ib_verbs.h                  |  7 +--
 17 files changed, 104 insertions(+), 154 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 8adb487eb314..c54db13fa9b0 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -913,9 +913,9 @@ static int handle_outgoing_dr_smp(struct ib_mad_agent_private *mad_agent_priv,
 
 	/* No GRH for DR SMP */
 	ret = device->ops.process_mad(device, 0, port_num, &mad_wc, NULL,
-				      (const struct ib_mad_hdr *)smp, mad_size,
-				      (struct ib_mad_hdr *)mad_priv->mad,
-				      &mad_size, &out_mad_pkey_index);
+				      (const struct ib_mad *)smp,
+				      (struct ib_mad *)mad_priv->mad, &mad_size,
+				      &out_mad_pkey_index);
 	switch (ret)
 	{
 	case IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY:
@@ -2321,9 +2321,9 @@ static void ib_mad_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (port_priv->device->ops.process_mad) {
 		ret = port_priv->device->ops.process_mad(
 			port_priv->device, 0, port_priv->port_num, wc,
-			&recv->grh, (const struct ib_mad_hdr *)recv->mad,
-			recv->mad_size, (struct ib_mad_hdr *)response->mad,
-			&mad_size, &resp_mad_pkey_index);
+			&recv->grh, (const struct ib_mad *)recv->mad,
+			(struct ib_mad *)response->mad, &mad_size,
+			&resp_mad_pkey_index);
 
 		if (opa)
 			wc->pkey_index = resp_mad_pkey_index;
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 62c756ea5668..087682e6969e 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -497,10 +497,8 @@ static int get_perf_mad(struct ib_device *dev, int port_num, __be16 attr,
 	if (attr != IB_PMA_CLASS_PORT_INFO)
 		in_mad->data[41] = port_num;	/* PortSelect field */
 
-	if ((dev->ops.process_mad(dev, IB_MAD_IGNORE_MKEY,
-				  port_num, NULL, NULL,
-				  (const struct ib_mad_hdr *)in_mad, mad_size,
-				  (struct ib_mad_hdr *)out_mad, &mad_size,
+	if ((dev->ops.process_mad(dev, IB_MAD_IGNORE_MKEY, port_num, NULL, NULL,
+				  in_mad, out_mad, &mad_size,
 				  &out_mad_pkey_index) &
 	     (IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY)) !=
 	    (IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY)) {
diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index a54746f4a0ae..a51bcd2b4391 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -4915,11 +4915,10 @@ static int hfi1_process_ib_mad(struct ib_device *ibdev, int mad_flags, u8 port,
  */
 int hfi1_process_mad(struct ib_device *ibdev, int mad_flags, u8 port,
 		     const struct ib_wc *in_wc, const struct ib_grh *in_grh,
-		     const struct ib_mad_hdr *in_mad, size_t in_mad_size,
-		     struct ib_mad_hdr *out_mad, size_t *out_mad_size,
-		     u16 *out_mad_pkey_index)
+		     const struct ib_mad *in_mad, struct ib_mad *out_mad,
+		     size_t *out_mad_size, u16 *out_mad_pkey_index)
 {
-	switch (in_mad->base_version) {
+	switch (in_mad->mad_hdr.base_version) {
 	case OPA_MGMT_BASE_VERSION:
 		return hfi1_process_opa_mad(ibdev, mad_flags, port,
 					    in_wc, in_grh,
@@ -4928,10 +4927,8 @@ int hfi1_process_mad(struct ib_device *ibdev, int mad_flags, u8 port,
 					    out_mad_size,
 					    out_mad_pkey_index);
 	case IB_MGMT_BASE_VERSION:
-		return hfi1_process_ib_mad(ibdev, mad_flags, port,
-					  in_wc, in_grh,
-					  (const struct ib_mad *)in_mad,
-					  (struct ib_mad *)out_mad);
+		return hfi1_process_ib_mad(ibdev, mad_flags, port, in_wc,
+					   in_grh, in_mad, out_mad);
 	default:
 		break;
 	}
diff --git a/drivers/infiniband/hw/hfi1/verbs.h b/drivers/infiniband/hw/hfi1/verbs.h
index ae9582ddbc8f..b0e9bf7cd150 100644
--- a/drivers/infiniband/hw/hfi1/verbs.h
+++ b/drivers/infiniband/hw/hfi1/verbs.h
@@ -330,9 +330,8 @@ void hfi1_sys_guid_chg(struct hfi1_ibport *ibp);
 void hfi1_node_desc_chg(struct hfi1_ibport *ibp);
 int hfi1_process_mad(struct ib_device *ibdev, int mad_flags, u8 port,
 		     const struct ib_wc *in_wc, const struct ib_grh *in_grh,
-		     const struct ib_mad_hdr *in_mad, size_t in_mad_size,
-		     struct ib_mad_hdr *out_mad, size_t *out_mad_size,
-		     u16 *out_mad_pkey_index);
+		     const struct ib_mad *in_mad, struct ib_mad *out_mad,
+		     size_t *out_mad_size, u16 *out_mad_pkey_index);
 
 /*
  * The PSN_MASK and PSN_SHIFT allow for
diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index c6ea4c50da1e..abe68708d6d6 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -983,13 +983,10 @@ static int iboe_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 
 int mlx4_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			const struct ib_wc *in_wc, const struct ib_grh *in_grh,
-			const struct ib_mad_hdr *in, size_t in_mad_size,
-			struct ib_mad_hdr *out, size_t *out_mad_size,
-			u16 *out_mad_pkey_index)
+			const struct ib_mad *in, struct ib_mad *out,
+			size_t *out_mad_size, u16 *out_mad_pkey_index)
 {
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
-	const struct ib_mad *in_mad = (const struct ib_mad *)in;
-	struct ib_mad *out_mad = (struct ib_mad *)out;
 	enum rdma_link_layer link = rdma_port_get_link_layer(ibdev, port_num);
 
 	/* iboe_process_mad() which uses the HCA flow-counters to implement IB PMA
@@ -997,20 +994,20 @@ int mlx4_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 	 */
 	if (link == IB_LINK_LAYER_INFINIBAND) {
 		if (mlx4_is_slave(dev->dev) &&
-		    (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT &&
-		     (in_mad->mad_hdr.attr_id == IB_PMA_PORT_COUNTERS ||
-		      in_mad->mad_hdr.attr_id == IB_PMA_PORT_COUNTERS_EXT ||
-		      in_mad->mad_hdr.attr_id == IB_PMA_CLASS_PORT_INFO)))
-			return iboe_process_mad(ibdev, mad_flags, port_num, in_wc,
-						in_grh, in_mad, out_mad);
+		    (in->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT &&
+		     (in->mad_hdr.attr_id == IB_PMA_PORT_COUNTERS ||
+		      in->mad_hdr.attr_id == IB_PMA_PORT_COUNTERS_EXT ||
+		      in->mad_hdr.attr_id == IB_PMA_CLASS_PORT_INFO)))
+			return iboe_process_mad(ibdev, mad_flags, port_num,
+						in_wc, in_grh, in, out);
 
-		return ib_process_mad(ibdev, mad_flags, port_num, in_wc,
-				      in_grh, in_mad, out_mad);
+		return ib_process_mad(ibdev, mad_flags, port_num, in_wc, in_grh,
+				      in, out);
 	}
 
 	if (link == IB_LINK_LAYER_ETHERNET)
 		return iboe_process_mad(ibdev, mad_flags, port_num, in_wc,
-					in_grh, in_mad, out_mad);
+					in_grh, in, out);
 
 	return -EINVAL;
 }
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index eb53bb4c0c91..0d846fea8fdc 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -786,11 +786,10 @@ int mlx4_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 int mlx4_MAD_IFC(struct mlx4_ib_dev *dev, int mad_ifc_flags,
 		 int port, const struct ib_wc *in_wc, const struct ib_grh *in_grh,
 		 const void *in_mad, void *response_mad);
-int mlx4_ib_process_mad(struct ib_device *ibdev, int mad_flags,	u8 port_num,
+int mlx4_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			const struct ib_wc *in_wc, const struct ib_grh *in_grh,
-			const struct ib_mad_hdr *in, size_t in_mad_size,
-			struct ib_mad_hdr *out, size_t *out_mad_size,
-			u16 *out_mad_pkey_index);
+			const struct ib_mad *in, struct ib_mad *out,
+			size_t *out_mad_size, u16 *out_mad_pkey_index);
 int mlx4_ib_mad_init(struct mlx4_ib_dev *dev);
 void mlx4_ib_mad_cleanup(struct mlx4_ib_dev *dev);
 
diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 1c87412a162f..14e0c17de6a9 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -219,15 +219,12 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u8 port_num,
 
 int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			const struct ib_wc *in_wc, const struct ib_grh *in_grh,
-			const struct ib_mad_hdr *in, size_t in_mad_size,
-			struct ib_mad_hdr *out, size_t *out_mad_size,
-			u16 *out_mad_pkey_index)
+			const struct ib_mad *in, struct ib_mad *out,
+			size_t *out_mad_size, u16 *out_mad_pkey_index)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	const struct ib_mad *in_mad = (const struct ib_mad *)in;
-	struct ib_mad *out_mad = (struct ib_mad *)out;
-	u8 mgmt_class = in_mad->mad_hdr.mgmt_class;
-	u8 method = in_mad->mad_hdr.method;
+	u8 mgmt_class = in->mad_hdr.mgmt_class;
+	u8 method = in->mad_hdr.method;
 	u16 slid;
 	int err;
 
@@ -247,13 +244,13 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 
 		/* Don't process SMInfo queries -- the SMA can't handle them.
 		 */
-		if (in_mad->mad_hdr.attr_id == IB_SMP_ATTR_SM_INFO)
+		if (in->mad_hdr.attr_id == IB_SMP_ATTR_SM_INFO)
 			return IB_MAD_RESULT_SUCCESS;
 	} break;
 	case IB_MGMT_CLASS_PERF_MGMT:
 		if (MLX5_CAP_GEN(dev->mdev, vport_counters) &&
 		    method == IB_MGMT_METHOD_GET)
-			return process_pma_cmd(dev, port_num, in_mad, out_mad);
+			return process_pma_cmd(dev, port_num, in, out);
 		/* fallthrough */
 	case MLX5_IB_VENDOR_CLASS1:
 		/* fallthrough */
@@ -267,16 +264,15 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 		return IB_MAD_RESULT_SUCCESS;
 	}
 
-	err = mlx5_MAD_IFC(to_mdev(ibdev),
-			   mad_flags & IB_MAD_IGNORE_MKEY,
-			   mad_flags & IB_MAD_IGNORE_BKEY,
-			   port_num, in_wc, in_grh, in_mad, out_mad);
+	err = mlx5_MAD_IFC(to_mdev(ibdev), mad_flags & IB_MAD_IGNORE_MKEY,
+			   mad_flags & IB_MAD_IGNORE_BKEY, port_num, in_wc,
+			   in_grh, in, out);
 	if (err)
 		return IB_MAD_RESULT_FAILURE;
 
 	/* set return bit in status of directed route responses */
 	if (mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
-		out_mad->mad_hdr.status |= cpu_to_be16(1 << 15);
+		out->mad_hdr.status |= cpu_to_be16(1 << 15);
 
 	if (method == IB_MGMT_METHOD_TRAP_REPRESS)
 		/* no response for trap repress */
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 0fb58ecccb7e..cc5568637857 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1192,9 +1192,8 @@ int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
 			 unsigned int *meta_sg_offset);
 int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			const struct ib_wc *in_wc, const struct ib_grh *in_grh,
-			const struct ib_mad_hdr *in, size_t in_mad_size,
-			struct ib_mad_hdr *out, size_t *out_mad_size,
-			u16 *out_mad_pkey_index);
+			const struct ib_mad *in, struct ib_mad *out,
+			size_t *out_mad_size, u16 *out_mad_pkey_index);
 struct ib_xrcd *mlx5_ib_alloc_xrcd(struct ib_device *ibdev,
 				   struct ib_udata *udata);
 int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index bfd4eebc1182..599794c5a78f 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -576,14 +576,10 @@ enum ib_rate mthca_rate_to_ib(struct mthca_dev *dev, u8 mthca_rate, u8 port);
 int mthca_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid);
 int mthca_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid);
 
-int mthca_process_mad(struct ib_device *ibdev,
-		      int mad_flags,
-		      u8 port_num,
-		      const struct ib_wc *in_wc,
-		      const struct ib_grh *in_grh,
-		      const struct ib_mad_hdr *in, size_t in_mad_size,
-		      struct ib_mad_hdr *out, size_t *out_mad_size,
-		      u16 *out_mad_pkey_index);
+int mthca_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
+		      const struct ib_wc *in_wc, const struct ib_grh *in_grh,
+		      const struct ib_mad *in, struct ib_mad *out,
+		      size_t *out_mad_size, u16 *out_mad_pkey_index);
 int mthca_create_agents(struct mthca_dev *dev);
 void mthca_free_agents(struct mthca_dev *dev);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_mad.c b/drivers/infiniband/hw/mthca/mthca_mad.c
index 0893604d2a62..99aa8183a7f2 100644
--- a/drivers/infiniband/hw/mthca/mthca_mad.c
+++ b/drivers/infiniband/hw/mthca/mthca_mad.c
@@ -196,26 +196,19 @@ static void forward_trap(struct mthca_dev *dev,
 	}
 }
 
-int mthca_process_mad(struct ib_device *ibdev,
-		      int mad_flags,
-		      u8 port_num,
-		      const struct ib_wc *in_wc,
-		      const struct ib_grh *in_grh,
-		      const struct ib_mad_hdr *in, size_t in_mad_size,
-		      struct ib_mad_hdr *out, size_t *out_mad_size,
-		      u16 *out_mad_pkey_index)
+int mthca_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
+		      const struct ib_wc *in_wc, const struct ib_grh *in_grh,
+		      const struct ib_mad *in, struct ib_mad *out,
+		      size_t *out_mad_size, u16 *out_mad_pkey_index)
 {
 	int err;
 	u16 slid = in_wc ? ib_lid_cpu16(in_wc->slid) : be16_to_cpu(IB_LID_PERMISSIVE);
 	u16 prev_lid = 0;
 	struct ib_port_attr pattr;
-	const struct ib_mad *in_mad = (const struct ib_mad *)in;
-	struct ib_mad *out_mad = (struct ib_mad *)out;
 
 	/* Forward locally generated traps to the SM */
-	if (in_mad->mad_hdr.method == IB_MGMT_METHOD_TRAP &&
-	    slid == 0) {
-		forward_trap(to_mdev(ibdev), port_num, in_mad);
+	if (in->mad_hdr.method == IB_MGMT_METHOD_TRAP && !slid) {
+		forward_trap(to_mdev(ibdev), port_num, in);
 		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
 	}
 
@@ -225,40 +218,39 @@ int mthca_process_mad(struct ib_device *ibdev,
 	 * Only handle PMA and Mellanox vendor-specific class gets and
 	 * sets for other classes.
 	 */
-	if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_LID_ROUTED ||
-	    in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) {
-		if (in_mad->mad_hdr.method   != IB_MGMT_METHOD_GET &&
-		    in_mad->mad_hdr.method   != IB_MGMT_METHOD_SET &&
-		    in_mad->mad_hdr.method   != IB_MGMT_METHOD_TRAP_REPRESS)
+	if (in->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_LID_ROUTED ||
+	    in->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) {
+		if (in->mad_hdr.method != IB_MGMT_METHOD_GET &&
+		    in->mad_hdr.method != IB_MGMT_METHOD_SET &&
+		    in->mad_hdr.method != IB_MGMT_METHOD_TRAP_REPRESS)
 			return IB_MAD_RESULT_SUCCESS;
 
 		/*
 		 * Don't process SMInfo queries or vendor-specific
 		 * MADs -- the SMA can't handle them.
 		 */
-		if (in_mad->mad_hdr.attr_id == IB_SMP_ATTR_SM_INFO ||
-		    ((in_mad->mad_hdr.attr_id & IB_SMP_ATTR_VENDOR_MASK) ==
+		if (in->mad_hdr.attr_id == IB_SMP_ATTR_SM_INFO ||
+		    ((in->mad_hdr.attr_id & IB_SMP_ATTR_VENDOR_MASK) ==
 		     IB_SMP_ATTR_VENDOR_MASK))
 			return IB_MAD_RESULT_SUCCESS;
-	} else if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT ||
-		   in_mad->mad_hdr.mgmt_class == MTHCA_VENDOR_CLASS1     ||
-		   in_mad->mad_hdr.mgmt_class == MTHCA_VENDOR_CLASS2) {
-		if (in_mad->mad_hdr.method  != IB_MGMT_METHOD_GET &&
-		    in_mad->mad_hdr.method  != IB_MGMT_METHOD_SET)
+	} else if (in->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT ||
+		   in->mad_hdr.mgmt_class == MTHCA_VENDOR_CLASS1     ||
+		   in->mad_hdr.mgmt_class == MTHCA_VENDOR_CLASS2) {
+		if (in->mad_hdr.method != IB_MGMT_METHOD_GET &&
+		    in->mad_hdr.method != IB_MGMT_METHOD_SET)
 			return IB_MAD_RESULT_SUCCESS;
 	} else
 		return IB_MAD_RESULT_SUCCESS;
-	if ((in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_LID_ROUTED ||
-	     in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) &&
-	    in_mad->mad_hdr.method == IB_MGMT_METHOD_SET &&
-	    in_mad->mad_hdr.attr_id == IB_SMP_ATTR_PORT_INFO &&
+	if ((in->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_LID_ROUTED ||
+	     in->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) &&
+	    in->mad_hdr.method == IB_MGMT_METHOD_SET &&
+	    in->mad_hdr.attr_id == IB_SMP_ATTR_PORT_INFO &&
 	    !ib_query_port(ibdev, port_num, &pattr))
 		prev_lid = ib_lid_cpu16(pattr.lid);
 
-	err = mthca_MAD_IFC(to_mdev(ibdev),
-			    mad_flags & IB_MAD_IGNORE_MKEY,
-			    mad_flags & IB_MAD_IGNORE_BKEY,
-			    port_num, in_wc, in_grh, in_mad, out_mad);
+	err = mthca_MAD_IFC(to_mdev(ibdev), mad_flags & IB_MAD_IGNORE_MKEY,
+			    mad_flags & IB_MAD_IGNORE_BKEY, port_num, in_wc,
+			    in_grh, in, out);
 	if (err == -EBADMSG)
 		return IB_MAD_RESULT_SUCCESS;
 	else if (err) {
@@ -266,16 +258,16 @@ int mthca_process_mad(struct ib_device *ibdev,
 		return IB_MAD_RESULT_FAILURE;
 	}
 
-	if (!out_mad->mad_hdr.status) {
-		smp_snoop(ibdev, port_num, in_mad, prev_lid);
-		node_desc_override(ibdev, out_mad);
+	if (!out->mad_hdr.status) {
+		smp_snoop(ibdev, port_num, in, prev_lid);
+		node_desc_override(ibdev, out);
 	}
 
 	/* set return bit in status of directed route responses */
-	if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
-		out_mad->mad_hdr.status |= cpu_to_be16(1 << 15);
+	if (in->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
+		out->mad_hdr.status |= cpu_to_be16(1 << 15);
 
-	if (in_mad->mad_hdr.method == IB_MGMT_METHOD_TRAP_REPRESS)
+	if (in->mad_hdr.method == IB_MGMT_METHOD_TRAP_REPRESS)
 		/* no response for trap repress */
 		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
index 4098508b9240..2b7f00ac41b0 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
@@ -247,23 +247,18 @@ int ocrdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 	return 0;
 }
 
-int ocrdma_process_mad(struct ib_device *ibdev,
-		       int process_mad_flags,
-		       u8 port_num,
-		       const struct ib_wc *in_wc,
-		       const struct ib_grh *in_grh,
-		       const struct ib_mad_hdr *in, size_t in_mad_size,
-		       struct ib_mad_hdr *out, size_t *out_mad_size,
+int ocrdma_process_mad(struct ib_device *ibdev, int process_mad_flags,
+		       u8 port_num, const struct ib_wc *in_wc,
+		       const struct ib_grh *in_grh, const struct ib_mad *in,
+		       struct ib_mad *out, size_t *out_mad_size,
 		       u16 *out_mad_pkey_index)
 {
 	int status = IB_MAD_RESULT_SUCCESS;
 	struct ocrdma_dev *dev;
-	const struct ib_mad *in_mad = (const struct ib_mad *)in;
-	struct ib_mad *out_mad = (struct ib_mad *)out;
 
-	if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT) {
+	if (in->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT) {
 		dev = get_ocrdma_dev(ibdev);
-		ocrdma_pma_counters(dev, out_mad);
+		ocrdma_pma_counters(dev, out);
 		status |= IB_MAD_RESULT_REPLY;
 	}
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_ah.h b/drivers/infiniband/hw/ocrdma/ocrdma_ah.h
index 64cb82c08664..9780afcde780 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_ah.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_ah.h
@@ -56,12 +56,9 @@ int ocrdma_create_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr, u32 flags,
 void ocrdma_destroy_ah(struct ib_ah *ah, u32 flags);
 int ocrdma_query_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 
-int ocrdma_process_mad(struct ib_device *,
-		       int process_mad_flags,
-		       u8 port_num,
-		       const struct ib_wc *in_wc,
-		       const struct ib_grh *in_grh,
-		       const struct ib_mad_hdr *in, size_t in_mad_size,
-		       struct ib_mad_hdr *out, size_t *out_mad_size,
+int ocrdma_process_mad(struct ib_device *dev, int process_mad_flags,
+		       u8 port_num, const struct ib_wc *in_wc,
+		       const struct ib_grh *in_grh, const struct ib_mad *in,
+		       struct ib_mad *out, size_t *out_mad_size,
 		       u16 *out_mad_pkey_index);
 #endif				/* __OCRDMA_AH_H__ */
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 8b4240c1cc76..0f82c86dfc6f 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -4130,19 +4130,10 @@ int qedr_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 }
 
 int qedr_process_mad(struct ib_device *ibdev, int process_mad_flags,
-		     u8 port_num,
-		     const struct ib_wc *in_wc,
-		     const struct ib_grh *in_grh,
-		     const struct ib_mad_hdr *mad_hdr,
-		     size_t in_mad_size, struct ib_mad_hdr *out_mad,
-		     size_t *out_mad_size, u16 *out_mad_pkey_index)
+		     u8 port_num, const struct ib_wc *in_wc,
+		     const struct ib_grh *in_grh, const struct ib_mad *in,
+		     struct ib_mad *out_mad, size_t *out_mad_size,
+		     u16 *out_mad_pkey_index)
 {
-	struct qedr_dev *dev = get_qedr_dev(ibdev);
-
-	DP_DEBUG(dev, QEDR_MSG_GSI,
-		 "QEDR_PROCESS_MAD in_mad %x %x %x %x %x %x %x %x\n",
-		 mad_hdr->attr_id, mad_hdr->base_version, mad_hdr->attr_mod,
-		 mad_hdr->class_specific, mad_hdr->class_version,
-		 mad_hdr->method, mad_hdr->mgmt_class, mad_hdr->status);
 	return IB_MAD_RESULT_SUCCESS;
 }
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 9aaa90283d6e..43bd84f98a0a 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -93,10 +93,9 @@ int qedr_post_recv(struct ib_qp *, const struct ib_recv_wr *,
 		   const struct ib_recv_wr **bad_wr);
 int qedr_process_mad(struct ib_device *ibdev, int process_mad_flags,
 		     u8 port_num, const struct ib_wc *in_wc,
-		     const struct ib_grh *in_grh,
-		     const struct ib_mad_hdr *in_mad,
-		     size_t in_mad_size, struct ib_mad_hdr *out_mad,
-		     size_t *out_mad_size, u16 *out_mad_pkey_index);
+		     const struct ib_grh *in_grh, const struct ib_mad *in_mad,
+		     struct ib_mad *out_mad, size_t *out_mad_size,
+		     u16 *out_mad_pkey_index);
 
 int qedr_port_immutable(struct ib_device *ibdev, u8 port_num,
 			struct ib_port_immutable *immutable);
diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index b259aaf85d4a..79bb83222e8d 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -2386,24 +2386,21 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
  */
 int qib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port,
 		    const struct ib_wc *in_wc, const struct ib_grh *in_grh,
-		    const struct ib_mad_hdr *in, size_t in_mad_size,
-		    struct ib_mad_hdr *out, size_t *out_mad_size,
-		    u16 *out_mad_pkey_index)
+		    const struct ib_mad *in, struct ib_mad *out,
+		    size_t *out_mad_size, u16 *out_mad_pkey_index)
 {
 	int ret;
 	struct qib_ibport *ibp = to_iport(ibdev, port);
 	struct qib_pportdata *ppd = ppd_from_ibp(ibp);
-	const struct ib_mad *in_mad = (const struct ib_mad *)in;
-	struct ib_mad *out_mad = (struct ib_mad *)out;
 
-	switch (in_mad->mad_hdr.mgmt_class) {
+	switch (in->mad_hdr.mgmt_class) {
 	case IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE:
 	case IB_MGMT_CLASS_SUBN_LID_ROUTED:
-		ret = process_subn(ibdev, mad_flags, port, in_mad, out_mad);
+		ret = process_subn(ibdev, mad_flags, port, in, out);
 		goto bail;
 
 	case IB_MGMT_CLASS_PERF_MGMT:
-		ret = process_perf(ibdev, port, in_mad, out_mad);
+		ret = process_perf(ibdev, port, in, out);
 		goto bail;
 
 	case IB_MGMT_CLASS_CONG_MGMT:
@@ -2412,7 +2409,7 @@ int qib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port,
 			ret = IB_MAD_RESULT_SUCCESS;
 			goto bail;
 		}
-		ret = process_cc(ibdev, mad_flags, port, in_mad, out_mad);
+		ret = process_cc(ibdev, mad_flags, port, in, out);
 		goto bail;
 
 	default:
diff --git a/drivers/infiniband/hw/qib/qib_verbs.h b/drivers/infiniband/hw/qib/qib_verbs.h
index 17bdf8acee2f..8bf414b47b96 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.h
+++ b/drivers/infiniband/hw/qib/qib_verbs.h
@@ -245,9 +245,8 @@ void qib_sys_guid_chg(struct qib_ibport *ibp);
 void qib_node_desc_chg(struct qib_ibport *ibp);
 int qib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 		    const struct ib_wc *in_wc, const struct ib_grh *in_grh,
-		    const struct ib_mad_hdr *in, size_t in_mad_size,
-		    struct ib_mad_hdr *out, size_t *out_mad_size,
-		    u16 *out_mad_pkey_index);
+		    const struct ib_mad *in, struct ib_mad *out,
+		    size_t *out_mad_size, u16 *out_mad_pkey_index);
 void qib_notify_create_mad_agent(struct rvt_dev_info *rdi, int port_idx);
 void qib_notify_free_mad_agent(struct rvt_dev_info *rdi, int port_idx);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index d78abb616096..8333fd70350c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2122,7 +2122,7 @@ struct ib_flow_action {
 	atomic_t			usecnt;
 };
 
-struct ib_mad_hdr;
+struct ib_mad;
 struct ib_grh;
 
 enum ib_process_mad_flags {
@@ -2280,9 +2280,8 @@ struct ib_device_ops {
 	int (*process_mad)(struct ib_device *device, int process_mad_flags,
 			   u8 port_num, const struct ib_wc *in_wc,
 			   const struct ib_grh *in_grh,
-			   const struct ib_mad_hdr *in_mad, size_t in_mad_size,
-			   struct ib_mad_hdr *out_mad, size_t *out_mad_size,
-			   u16 *out_mad_pkey_index);
+			   const struct ib_mad *in_mad, struct ib_mad *out_mad,
+			   size_t *out_mad_size, u16 *out_mad_pkey_index);
 	int (*query_device)(struct ib_device *device,
 			    struct ib_device_attr *device_attr,
 			    struct ib_udata *udata);
-- 
2.20.1

