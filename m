Return-Path: <linux-rdma+bounces-2549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88D8CAA0F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 10:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F94F1C20DBA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3556B9C;
	Tue, 21 May 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wu/AUE6X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440EF53E31;
	Tue, 21 May 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280469; cv=none; b=jXi05GwmvrUCIGEZQCGlKSwjdSM5kCVB18HKN66cKWfwjn5T7aPKFKH6LCVTzaQwR2Tiv1QBhvd922rJmy9YBALFfV9iehVwIuuGI16nrFfqF4/qv/wargH8wu6krGV3INWHZ+0BkJvehJGgalbxG+wXTonMWgv1l99pNb3x5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280469; c=relaxed/simple;
	bh=DENCQP8TJl9PIc2F0ZwssNGqHC1kfLP83YJHCdTLQPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HEC24dETLsxQyPTpsK9dZNR+opi5t3rP5Iv0pdxmJoEgmnJmp2UbpWiEqDD8kau10WgaIPc0zoKCmP0vF1hg6PIJB/yWWtC19kH7Vo1mJsLHssp50vpSacECl4FCwI7gMHRZ2NXFm6/F6kVjmcrE2Hk03N+TDrl0OQCWZ5btCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wu/AUE6X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 88E3920B9263;
	Tue, 21 May 2024 01:34:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88E3920B9263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716280461;
	bh=Jjj+51gRjJB6M9hdMSmLZID8g8FgmY11qYRNTbZL1uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wu/AUE6XRJjX3pwClU9K494Z/x3+iR3o3BnOUFhz9U0p6Mdt1qHGzR9T4hpdHxTr5
	 sjtWSN753iN6Dr9qqtlXwQXTGYBPILpszqLjjk0Tr0QScSJ3eCSDD881cLZp0pOupn
	 33InMc7RwySa+ouF698crsnSwk0GOslZCy9APsGE=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 3/3] RDMA/mana_ib: Modify QP state
Date: Tue, 21 May 2024 01:34:13 -0700
Message-Id: <1716280453-24387-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716280453-24387-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1716280453-24387-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement modify QP state for RC QPs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/mana_ib.h | 37 ++++++++++++++
 drivers/infiniband/hw/mana/qp.c      | 72 +++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 5cccbe397..d29dee7b5 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -140,6 +140,7 @@ enum mana_ib_command_code {
 	MANA_IB_DESTROY_CQ      = 0x30009,
 	MANA_IB_CREATE_RC_QP    = 0x3000a,
 	MANA_IB_DESTROY_RC_QP   = 0x3000b,
+	MANA_IB_SET_QP_STATE	= 0x3000d,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -286,6 +287,42 @@ struct mana_rnic_destroy_rc_qp_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+struct mana_ib_ah_attr {
+	u8 src_addr[16];
+	u8 dest_addr[16];
+	u8 src_mac[ETH_ALEN];
+	u8 dest_mac[ETH_ALEN];
+	u8 src_addr_type;
+	u8 dest_addr_type;
+	u8 hop_limit;
+	u8 traffic_class;
+	u16 src_port;
+	u16 dest_port;
+	u32 reserved;
+};
+
+struct mana_rnic_set_qp_state_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	mana_handle_t qp_handle;
+	u64 attr_mask;
+	u32 qp_state;
+	u32 path_mtu;
+	u32 rq_psn;
+	u32 sq_psn;
+	u32 dest_qpn;
+	u32 max_dest_rd_atomic;
+	u32 retry_cnt;
+	u32 rnr_retry;
+	u32 min_rnr_timer;
+	u32 reserved;
+	struct mana_ib_ah_attr ah_attr;
+}; /* HW Data */
+
+struct mana_rnic_set_qp_state_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index e04e5e778..99ba8c080 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -491,11 +491,79 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	return -EINVAL;
 }
 
+static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+				int attr_mask, struct ib_udata *udata)
+{
+	struct mana_ib_dev *mdev = container_of(ibqp->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
+	struct mana_rnic_set_qp_state_resp resp = {};
+	struct mana_rnic_set_qp_state_req req = {};
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_port_context *mpc;
+	struct net_device *ndev;
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_SET_QP_STATE, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.qp_handle = qp->qp_handle;
+	req.qp_state = attr->qp_state;
+	req.attr_mask = attr_mask;
+	req.path_mtu = attr->path_mtu;
+	req.rq_psn = attr->rq_psn;
+	req.sq_psn = attr->sq_psn;
+	req.dest_qpn = attr->dest_qp_num;
+	req.max_dest_rd_atomic = attr->max_dest_rd_atomic;
+	req.retry_cnt = attr->retry_cnt;
+	req.rnr_retry = attr->rnr_retry;
+	req.min_rnr_timer = attr->min_rnr_timer;
+	if (attr_mask & IB_QP_AV) {
+		ndev = mana_ib_get_netdev(&mdev->ib_dev, ibqp->port);
+		if (!ndev) {
+			ibdev_dbg(&mdev->ib_dev, "Invalid port %u in QP %u\n",
+				  ibqp->port, ibqp->qp_num);
+			return -EINVAL;
+		}
+		mpc = netdev_priv(ndev);
+		copy_in_reverse(req.ah_attr.src_mac, mpc->mac_addr, ETH_ALEN);
+		copy_in_reverse(req.ah_attr.dest_mac, attr->ah_attr.roce.dmac, ETH_ALEN);
+		copy_in_reverse(req.ah_attr.src_addr, attr->ah_attr.grh.sgid_attr->gid.raw,
+				sizeof(union ib_gid));
+		copy_in_reverse(req.ah_attr.dest_addr, attr->ah_attr.grh.dgid.raw,
+				sizeof(union ib_gid));
+		if (rdma_gid_attr_network_type(attr->ah_attr.grh.sgid_attr) == RDMA_NETWORK_IPV4) {
+			req.ah_attr.src_addr_type = SGID_TYPE_IPV4;
+			req.ah_attr.dest_addr_type = SGID_TYPE_IPV4;
+		} else {
+			req.ah_attr.src_addr_type = SGID_TYPE_IPV6;
+			req.ah_attr.dest_addr_type = SGID_TYPE_IPV6;
+		}
+		req.ah_attr.dest_port = ROCE_V2_UDP_DPORT;
+		req.ah_attr.src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
+							  ibqp->qp_num, attr->dest_qp_num);
+		req.ah_attr.traffic_class = attr->ah_attr.grh.traffic_class;
+		req.ah_attr.hop_limit = attr->ah_attr.grh.hop_limit;
+	}
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed modify qp err %d", err);
+		return err;
+	}
+
+	return 0;
+}
+
 int mana_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		      int attr_mask, struct ib_udata *udata)
 {
-	/* modify_qp is not supported by this version of the driver */
-	return -EOPNOTSUPP;
+	switch (ibqp->qp_type) {
+	case IB_QPT_RC:
+		return mana_ib_gd_modify_qp(ibqp, attr, attr_mask, udata);
+	default:
+		ibdev_dbg(ibqp->device, "Modify QP type %u not supported", ibqp->qp_type);
+		return -EOPNOTSUPP;
+	}
 }
 
 static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
-- 
2.43.0


