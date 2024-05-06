Return-Path: <linux-rdma+bounces-2301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D548BD171
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B39281C0B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491C1552FE;
	Mon,  6 May 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IeXkQTkz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67411154C15
	for <linux-rdma@vger.kernel.org>; Mon,  6 May 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008715; cv=none; b=LoAExyYYMeG59bBjmlT1312fUJDTpzH38xn7PCC6BajhpcPhsl3Y18MFalCDzZDfSP5CeKJVIB1kcqbgBK3+lt9OBSewJsLE/IJSIlTiMglsGoOEmTG/hB4cVvYyG8mp2uhA/fLLh8pXED/bQxlncJq6EJDXw3Oe6g5tv4eI9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008715; c=relaxed/simple;
	bh=ajlsIZ2MqixybIipRlm720Il788i8AI/Sowng9tgC/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=swhZsXjVYovqNS8s+0UdyqcubhWF67z3mHyc2gqbP4gDiPIWE09jFf82XaoyWuyNEsnmhKCkwxO5zgG0dKqXq5HXEQ3XK6vYpKJFSZFJZu677pl3ZMJ3Ac675hyDpNrLFGCcZG+JSDfe0veK/eitNYeUWAylvALv1NjPEAkTy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IeXkQTkz; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715008714; x=1746544714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v+f4VzgaGPGZmgy5e596RoAsJa5stfKtD4Z7d8Lklrc=;
  b=IeXkQTkzbagzXssN1lJdmOVRiR7lldiKS1JL2TjJzbMQF6aGA88XZ4Im
   vGwdoE8DTCppPwEjVMfVS7MyRd6jnxHPYjpRza2HahnwW+aEkAr3Le83f
   uNZlnpocgPClJMYs7Z6cbSPUthqyahD/qElphqhGmJC3yYFcUTwMJs+AA
   g=;
X-IronPort-AV: E=Sophos;i="6.07,258,1708387200"; 
   d="scan'208";a="87308984"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 15:18:32 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:57738]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.220:2525] with esmtp (Farcaster)
 id 570a6df3-a80e-4270-9f3d-1d12a6ce03a3; Mon, 6 May 2024 15:18:31 +0000 (UTC)
X-Farcaster-Flow-ID: 570a6df3-a80e-4270-9f3d-1d12a6ce03a3
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 15:18:30 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D022EUA002.ant.amazon.com (10.252.50.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 15:18:30 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 6 May 2024 15:18:29 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: [PATCH for-next v2] RDMA/efa: Support QP with unsolicited write w/ imm. receive
Date: Mon, 6 May 2024 15:18:29 +0000
Message-ID: <20240506151829.6475-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a new EFA flags attribute for QP creation, and support unsolicited
write with immediate flag. QPs created with this flag set will not
consume receive work requests for incoming RDMA write with immediate.
Expose device capability bit for this feature support.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas Jahjah <firasj@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 11 +++++++++--
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  3 +++
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c         | 19 ++++++++++++++++++-
 include/uapi/rdma/efa-abi.h                   |  7 +++++++
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 7377c8a9f4d5..4296662e59c3 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -110,7 +110,10 @@ struct efa_admin_create_qp_cmd {
 	 *    virtual (IOVA returned by MR registration)
 	 * 1 : rq_virt - If set, RQ ring base address is
 	 *    virtual (IOVA returned by MR registration)
-	 * 7:2 : reserved - MBZ
+	 * 2 : unsolicited_write_recv - If set, work requests
+	 *    will not be consumed for incoming RDMA write with
+	 *    immediate
+	 * 7:3 : reserved - MBZ
 	 */
 	u8 flags;
 
@@ -663,7 +666,9 @@ struct efa_admin_feature_device_attr_desc {
 	 *    polling is supported
 	 * 3 : rdma_write - If set, RDMA Write is supported
 	 *    on TX queues
-	 * 31:4 : reserved - MBZ
+	 * 4 : unsolicited_write_recv - If set, unsolicited
+	 *    write with imm. receive is supported
+	 * 31:5 : reserved - MBZ
 	 */
 	u32 device_caps;
 
@@ -1009,6 +1014,7 @@ struct efa_admin_host_info {
 /* create_qp_cmd */
 #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
 #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
+#define EFA_ADMIN_CREATE_QP_CMD_UNSOLICITED_WRITE_RECV_MASK BIT(2)
 
 /* modify_qp_cmd */
 #define EFA_ADMIN_MODIFY_QP_CMD_QP_STATE_MASK               BIT(0)
@@ -1044,6 +1050,7 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RNR_RETRY_MASK   BIT(1)
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_DATA_POLLING_128_MASK BIT(2)
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_WRITE_MASK  BIT(3)
+#define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_UNSOLICITED_WRITE_RECV_MASK BIT(4)
 
 /* create_eq_cmd */
 #define EFA_ADMIN_CREATE_EQ_CMD_ENTRY_SIZE_WORDS_MASK       GENMASK(4, 0)
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index d3398c7b0bd0..5b9c2b16df0e 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -32,6 +32,9 @@ int efa_com_create_qp(struct efa_com_dev *edev,
 			params->rq_depth;
 	create_qp_cmd.uar = params->uarn;
 
+	if (params->unsolicited_write_recv)
+		EFA_SET(&create_qp_cmd.flags, EFA_ADMIN_CREATE_QP_CMD_UNSOLICITED_WRITE_RECV, 1);
+
 	err = efa_com_cmd_exec(aq,
 			       (struct efa_admin_aq_entry *)&create_qp_cmd,
 			       sizeof(create_qp_cmd),
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 720a99ba0f7d..9714105fcf7e 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -27,6 +27,7 @@ struct efa_com_create_qp_params {
 	u16 pd;
 	u16 uarn;
 	u8 qp_type;
+	u8 unsolicited_write_recv : 1;
 };
 
 struct efa_com_create_qp_result {
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 2f412db2edcd..8f7a13b79cdc 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -263,6 +263,9 @@ int efa_query_device(struct ib_device *ibdev,
 		if (EFA_DEV_CAP(dev, RDMA_WRITE))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RDMA_WRITE;
 
+		if (EFA_DEV_CAP(dev, UNSOLICITED_WRITE_RECV))
+			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV;
+
 		if (dev->neqs)
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS;
 
@@ -639,6 +642,7 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	struct efa_ibv_create_qp cmd = {};
 	struct efa_qp *qp = to_eqp(ibqp);
 	struct efa_ucontext *ucontext;
+	u16 supported_efa_flags = 0;
 	int err;
 
 	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
@@ -676,13 +680,23 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		goto err_out;
 	}
 
-	if (cmd.comp_mask) {
+	if (cmd.comp_mask || !is_reserved_cleared(cmd.reserved_90)) {
 		ibdev_dbg(&dev->ibdev,
 			  "Incompatible ABI params, unknown fields in udata\n");
 		err = -EINVAL;
 		goto err_out;
 	}
 
+	if (EFA_DEV_CAP(dev, UNSOLICITED_WRITE_RECV))
+		supported_efa_flags |= EFA_CREATE_QP_WITH_UNSOLICITED_WRITE_RECV;
+
+	if (cmd.flags & ~supported_efa_flags) {
+		ibdev_dbg(&dev->ibdev, "Unsupported EFA QP create flags[%#x], supported[%#x]\n",
+			  cmd.flags, supported_efa_flags);
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+
 	create_qp_params.uarn = ucontext->uarn;
 	create_qp_params.pd = to_epd(ibqp->pd)->pdn;
 
@@ -722,6 +736,9 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		create_qp_params.rq_base_addr = qp->rq_dma_addr;
 	}
 
+	if (cmd.flags & EFA_CREATE_QP_WITH_UNSOLICITED_WRITE_RECV)
+		create_qp_params.unsolicited_write_recv = true;
+
 	err = efa_com_create_qp(&dev->edev, &create_qp_params,
 				&create_qp_resp);
 	if (err)
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 701e2d567e41..d689b8b34189 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -85,11 +85,17 @@ enum {
 	EFA_QP_DRIVER_TYPE_SRD = 0,
 };
 
+enum {
+	EFA_CREATE_QP_WITH_UNSOLICITED_WRITE_RECV = 1 << 0,
+};
+
 struct efa_ibv_create_qp {
 	__u32 comp_mask;
 	__u32 rq_ring_size; /* bytes */
 	__u32 sq_ring_size; /* bytes */
 	__u32 driver_qp_type;
+	__u16 flags;
+	__u8 reserved_90[6];
 };
 
 struct efa_ibv_create_qp_resp {
@@ -123,6 +129,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
 	EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
 	EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
+	EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV = 1 << 6,
 };
 
 struct efa_ibv_ex_query_device_resp {
-- 
2.40.1


