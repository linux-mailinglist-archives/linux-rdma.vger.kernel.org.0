Return-Path: <linux-rdma+bounces-2569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B826D8CBCDF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 10:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B389280D99
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 08:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF07FBB6;
	Wed, 22 May 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qwIHcxjD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FCA8061D;
	Wed, 22 May 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366249; cv=none; b=XDN3TDHpjm+tjass79Kehf1S2IuIdGughsNem3saZXySQ7Fy/WBz6PR0zBGdgt2NSK8fKzQWLRFvSjVhUUXaTJ+VCpRIkOyPHBbPcl/9Ex29IXywinh5TwpyR+VAzUy2xmjUwZ0ez6Ji9ruVIUeyzIgkkafYjOUHcaRXzFiv+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366249; c=relaxed/simple;
	bh=97mNS073dQajsSPI6QcQZr9OEU0aslu26axwdq3uQ6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f7t4mPiR83aIuE6uth4rms42Pc7qoLXZvJS0eOmKexiJ503qfZyvPAD7Gp1uneZdXQr5pnANtatUvGmYmrvodvcLmXUjVMe+rePcQXGdICKzOE+U7qbiBBOl7TmIyAl5BUEPTcbXJaGneSDq7KwYKm/mjIlXX0SUadOPq/cJpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qwIHcxjD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D9D220B9263;
	Wed, 22 May 2024 01:24:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D9D220B9263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716366247;
	bh=HyrbYDwCHC5gGfc/wxRrSSovKmYqFVYq+6T2+TwbUN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwIHcxjD3vNEjdlRLOwy1NZkmO5D9QN6GDMftyrYWF409V5/SC6JsDd36NyFJGZ2a
	 nZaoudVK/W24ZRVFsq2PDr8Vj6hm/tIV/vbqirJYvnpLhG4kahj1EHGGIedDimgvAP
	 avcq+3MyaoWUiSwaY/bfzI6T00OVOt12tpcEv82w=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 3/3] RDMA/mana_ib: Modify QP state
Date: Wed, 22 May 2024 01:24:02 -0700
Message-Id: <1716366242-558-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com>
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
index 7dbeba41b..34a93729d 100644
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


