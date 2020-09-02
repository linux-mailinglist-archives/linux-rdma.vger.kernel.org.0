Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41B825A6FE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 09:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIBHpX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 03:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgIBHpU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 03:45:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E95020826;
        Wed,  2 Sep 2020 07:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599032719;
        bh=aSlmsLBuB7GXTb2J1jYP4GYb1/ewriaVIJ4X/YNgC8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2aK3qpyg34hTNtHQcc7Oyl497j4lJsEri79clhKCbxkMqY5jjJCCRSjnPEHxF56z4
         +NlaAY0kfjKoPzfoNJx/QY7ZccE6/YPAOpVzfPvVfi0ZgxTu5vr2TxNcRU/Z+f8BNe
         T66OSfSodn+0q7n0LfP9oRx1TUhzaKYHczwJwyNM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: [PATCH rdma-next v1 3/3] RDMA: Fix link active_speed size
Date:   Wed,  2 Sep 2020 10:45:03 +0300
Message-Id: <20200902074503.743310-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902074503.743310-1-leon@kernel.org>
References: <20200902074503.743310-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@mellanox.com>

According to the IB spec active_speed size should be u16 and not u8 as
before. Changing it to allow further extensions in offered speeds.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Aharon Landau <aharonl@mellanox.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_device.c | 3 ++-
 drivers/infiniband/core/verbs.c                   | 2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h           | 2 +-
 drivers/infiniband/hw/hfi1/verbs.c                | 2 +-
 drivers/infiniband/hw/mlx5/main.c                 | 8 ++------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c       | 2 +-
 drivers/infiniband/hw/qedr/verbs.c                | 2 +-
 drivers/infiniband/hw/qib/qib.h                   | 6 +++---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   | 2 +-
 include/rdma/ib_verbs.h                           | 4 ++--
 10 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index 75df2094a010..7b03446b6936 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -165,7 +165,8 @@ void copy_port_attr_to_resp(struct ib_port_attr *attr,
 	resp->subnet_timeout = attr->subnet_timeout;
 	resp->init_type_reply = attr->init_type_reply;
 	resp->active_width = attr->active_width;
-	resp->active_speed = attr->active_speed;
+	WARN_ON(attr->active_speed & ~0xFF);
+	resp->active_speed = (u8)attr->active_speed;
 	resp->phys_state = attr->phys_state;
 	resp->link_layer = rdma_port_get_link_layer(ib_dev, port_num);
 }
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index c0b9bf0563bc..b9990297e4b0 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1802,7 +1802,7 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
 }
 EXPORT_SYMBOL(ib_modify_qp_with_udata);
 
-int ib_get_eth_speed(struct ib_device *dev, u8 port_num, u8 *speed, u8 *width)
+int ib_get_eth_speed(struct ib_device *dev, u8 port_num, u16 *speed, u8 *width)
 {
 	int rc;
 	u32 netdev_speed;
diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index a300588634c5..b930ea3dab7a 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -150,7 +150,7 @@ struct bnxt_re_dev {
 
 	struct delayed_work		worker;
 	u8				cur_prio_map;
-	u8				active_speed;
+	u16				active_speed;
 	u8				active_width;
 
 	/* FP Notification Queue (CQ & SRQ) */
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 30865635b449..3591923abebb 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1424,7 +1424,7 @@ static int query_port(struct rvt_dev_info *rdi, u8 port_num,
 	props->gid_tbl_len = HFI1_GUIDS_PER_PORT;
 	props->active_width = (u8)opa_width_to_ib(ppd->link_width_active);
 	/* see rate_show() in ib core/sysfs.c */
-	props->active_speed = (u8)opa_speed_to_ib(ppd->link_speed_active);
+	props->active_speed = opa_speed_to_ib(ppd->link_speed_active);
 	props->max_vl_num = ppd->vls_supported;
 
 	/* Once we are a "first class" citizen and have added the OPA MTUs to
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 545f23d27660..790b874fffe2 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -457,7 +457,6 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 	bool put_mdev = true;
 	u16 qkey_viol_cntr;
 	u32 eth_prot_oper;
-	u16 active_speed;
 	u8 mdev_port_num;
 	bool ext;
 	int err;
@@ -491,12 +490,9 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 	props->active_width     = IB_WIDTH_4X;
 	props->active_speed     = IB_SPEED_QDR;
 
-	translate_eth_proto_oper(eth_prot_oper, &active_speed,
+	translate_eth_proto_oper(eth_prot_oper, &props->active_speed,
 				 &props->active_width, ext);
 
-	WARN_ON_ONCE(active_speed & ~0xFF);
-	props->active_speed = (u8)active_speed;
-
 	props->port_cap_flags |= IB_PORT_CM_SUP;
 	props->ip_gids = true;
 
@@ -1307,7 +1303,7 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u8 port,
 		props->port_cap_flags2 = rep->cap_mask2;
 
 	err = mlx5_query_ib_port_oper(mdev, &ib_link_width_oper,
-				      (u16 *)&props->active_speed, port);
+				      &props->active_speed, port);
 	if (err)
 		goto out;
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index b24437619412..6ea3ceb1958d 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -112,7 +112,7 @@ int ocrdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 }
 
 static inline void get_link_speed_and_width(struct ocrdma_dev *dev,
-					    u8 *ib_speed, u8 *ib_width)
+					    u16 *ib_speed, u8 *ib_width)
 {
 	int status;
 	u8 speed;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 2f28d4ef3c05..fd0bbee24ce0 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -163,7 +163,7 @@ int qedr_query_device(struct ib_device *ibdev,
 	return 0;
 }
 
-static inline void get_link_speed_and_width(int speed, u8 *ib_speed,
+static inline void get_link_speed_and_width(int speed, u16 *ib_speed,
 					    u8 *ib_width)
 {
 	switch (speed) {
diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index 432d6d0fd7f4..ee211423058a 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -619,11 +619,11 @@ struct qib_pportdata {
 	/* LID mask control */
 	u8 lmc;
 	u8 link_width_supported;
-	u8 link_speed_supported;
+	u16 link_speed_supported;
 	u8 link_width_enabled;
-	u8 link_speed_enabled;
+	u16 link_speed_enabled;
 	u8 link_width_active;
-	u8 link_speed_active;
+	u16 link_speed_active;
 	u8 vls_supported;
 	u8 vls_operational;
 	/* Rx Polarity inversion (compensate for ~tx on partner) */
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 97ed8f952f6e..f0e5ffba2d51 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -176,7 +176,7 @@ struct pvrdma_port_attr {
 	u8			subnet_timeout;
 	u8			init_type_reply;
 	u8			active_width;
-	u8			active_speed;
+	u16			active_speed;
 	u8			phys_state;
 	u8			reserved[2];
 };
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 73fb9f2455d9..a596f1657c44 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -670,7 +670,7 @@ struct ib_port_attr {
 	u8			subnet_timeout;
 	u8			init_type_reply;
 	u8			active_width;
-	u8			active_speed;
+	u16			active_speed;
 	u8                      phys_state;
 	u16			port_cap_flags2;
 };
@@ -4359,7 +4359,7 @@ void ib_drain_rq(struct ib_qp *qp);
 void ib_drain_sq(struct ib_qp *qp);
 void ib_drain_qp(struct ib_qp *qp);
 
-int ib_get_eth_speed(struct ib_device *dev, u8 port_num, u8 *speed, u8 *width);
+int ib_get_eth_speed(struct ib_device *dev, u8 port_num, u16 *speed, u8 *width);
 
 static inline u8 *rdma_ah_retrieve_dmac(struct rdma_ah_attr *attr)
 {
-- 
2.26.2

