Return-Path: <linux-rdma+bounces-1449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CFF87CAD3
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 10:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4D52840D5
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A6E17C69;
	Fri, 15 Mar 2024 09:40:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BB17C66;
	Fri, 15 Mar 2024 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495618; cv=none; b=QUqmTV/rsG4IXrGV4S5zT4I8z/wmsbhHdoe+EKeP6Q+5tLfAGDCQvROZ1Y6rfeqKL2AH+3iUwGCFgwkqh4eJXVfBk2SIaK5axQ0uY0qzpHFnSXtEsVglVHNzw6wGQloKPF2Yidp/6xBVs6yHD5Vt9DLbTNmb7wMKHeW6xmSTjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495618; c=relaxed/simple;
	bh=ZHbeVLAfHZiTs4/exux7+KBrM0d/3hISjFMRW/i22Q8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SCh2kSNNdKX2WzbmPq9hJBE4aTyh+erG1kWrQzFNl68uNHeAVrTrDpCoe/V8bm0Ev9ZjomFBZZLEEoclkSdnRSzuHREjaZPon4PEgIMefMF2dWyq4EyLdcmC89s4R7h5lwyIRhbNEfT1sXnNKr8u2GcwsZ4IwTa7YJiz/p7kl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TwzgR2Wszz1h2TD;
	Fri, 15 Mar 2024 17:37:39 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 236C4180062;
	Fri, 15 Mar 2024 17:40:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 17:40:07 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next] RDMA/hns: Support DSCP
Date: Fri, 15 Mar 2024 17:35:51 +0800
Message-ID: <20240315093551.1650088-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)

Add support for DSCP configuration. For DSCP, get dscp-prio mapping
via hns3 nic driver api .get_dscp_prio() and fill the SL (in WQE for
UD or in QPC for RC) with the priority value. The prio-tc mapping is
configured to HW by hns3 nic driver. HW will select a corresponding
TC according to SL and the prio-tc mapping.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c     | 32 +++++---
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 86 ++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 13 ++++
 include/uapi/rdma/hns-abi.h                 |  9 ++-
 5 files changed, 117 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index b4209b6aed8d..91f7fe0f3235 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -59,8 +59,11 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibah->device);
 	struct hns_roce_ib_create_ah_resp resp = {};
 	struct hns_roce_ah *ah = to_hr_ah(ibah);
-	int ret = 0;
+	u8 tclass = get_tclass(grh);
+	u8 priority = 0;
+	u8 tc_mode = 0;
 	u32 max_sl;
+	int ret;
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata)
 		return -EOPNOTSUPP;
@@ -74,16 +77,23 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	ah->av.hop_limit = grh->hop_limit;
 	ah->av.flowlabel = grh->flow_label;
 	ah->av.udp_sport = get_ah_udp_sport(ah_attr);
-	ah->av.tclass = get_tclass(grh);
-
-	ah->av.sl = rdma_ah_get_sl(ah_attr);
-	max_sl = min_t(u32, MAX_SERVICE_LEVEL, hr_dev->caps.sl_num - 1);
-	if (unlikely(ah->av.sl > max_sl)) {
-		ibdev_err_ratelimited(&hr_dev->ib_dev,
-				      "failed to set sl, sl (%u) shouldn't be larger than %u.\n",
-				      ah->av.sl, max_sl);
+	ah->av.tclass = tclass;
+
+	ret = hr_dev->hw->get_dscp(hr_dev, tclass, &tc_mode, &priority);
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+
+	if (ret && grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
+		return ret;
+
+	if (tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
+	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
+		ah->av.sl = priority;
+	else
+		ah->av.sl = rdma_ah_get_sl(ah_attr);
+
+	if (!check_sl_valid(hr_dev, ah->av.sl))
 		return -EINVAL;
-	}
 
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
@@ -99,6 +109,8 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	}
 
 	if (udata) {
+		resp.priority = ah->av.sl;
+		resp.tc_mode = tc_mode;
 		memcpy(resp.dmac, ah_attr->roce.dmac, ETH_ALEN);
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c3cbd0a494bf..78b4d19ff848 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -645,6 +645,8 @@ struct hns_roce_qp {
 	struct hns_user_mmap_entry *dwqe_mmap_entry;
 	u32			config;
 	enum hns_roce_cong_type	cong_type;
+	u8			tc_mode;
+	u8			priority;
 };
 
 struct hns_roce_ib_iboe {
@@ -950,6 +952,8 @@ struct hns_roce_hw {
 	int (*query_sccc)(struct hns_roce_dev *hr_dev, u32 qpn, void *buffer);
 	int (*query_hw_counter)(struct hns_roce_dev *hr_dev,
 				u64 *stats, u32 port, int *hw_counters);
+	int (*get_dscp)(struct hns_roce_dev *hr_dev, u8 dscp,
+			u8 *tc_mode, u8 *priority);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
@@ -1292,4 +1296,6 @@ struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
 				enum hns_roce_mmap_type mmap_type);
+bool check_sl_valid(struct hns_roce_dev *hr_dev, u8 sl);
+
 #endif /* _HNS_ROCE_DEVICE_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ba7ae792d279..4de463e787d4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -443,10 +443,6 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_HOPLIMIT, ah->av.hop_limit);
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_TCLASS, ah->av.tclass);
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_FLOW_LABEL, ah->av.flowlabel);
-
-	if (WARN_ON(ah->av.sl > MAX_SERVICE_LEVEL))
-		return -EINVAL;
-
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_SL, ah->av.sl);
 
 	ud_sq_wqe->sgid_index = ah->av.gid_index;
@@ -4828,6 +4824,70 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	return 0;
 }
 
+static int hns_roce_hw_v2_get_dscp(struct hns_roce_dev *hr_dev, u8 dscp,
+				   u8 *tc_mode, u8 *priority)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hnae3_handle *handle = priv->handle;
+	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+
+	if (!ops->get_dscp_prio)
+		return -EOPNOTSUPP;
+
+	return ops->get_dscp_prio(handle, dscp, tc_mode, priority);
+}
+
+bool check_sl_valid(struct hns_roce_dev *hr_dev, u8 sl)
+{
+	u32 max_sl;
+
+	max_sl = min_t(u32, MAX_SERVICE_LEVEL, hr_dev->caps.sl_num - 1);
+	if (unlikely(sl > max_sl)) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to set SL(%u). Shouldn't be larger than %u.\n",
+				      sl, max_sl);
+		return false;
+	}
+
+	return true;
+}
+
+static int hns_roce_set_sl(struct ib_qp *ibqp,
+			   const struct ib_qp_attr *attr,
+			   struct hns_roce_v2_qp_context *context,
+			   struct hns_roce_v2_qp_context *qpc_mask)
+{
+	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u32 sl_num;
+	int ret;
+
+	ret = hns_roce_hw_v2_get_dscp(hr_dev, get_tclass(&attr->ah_attr.grh),
+				      &hr_qp->tc_mode, &hr_qp->priority);
+	if (ret && ret != -EOPNOTSUPP &&
+	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
+		ibdev_err_ratelimited(ibdev,
+				      "failed to get dscp, ret = %d.\n", ret);
+		return ret;
+	}
+
+	if (hr_qp->tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
+	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
+		hr_qp->sl = hr_qp->priority;
+	else
+		hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
+
+	if (!check_sl_valid(hr_dev, hr_qp->sl))
+		return -EINVAL;
+
+	hr_reg_write(context, QPC_SL, hr_qp->sl);
+	hr_reg_clear(qpc_mask, QPC_SL);
+
+	return 0;
+}
+
 static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 				const struct ib_qp_attr *attr,
 				int attr_mask,
@@ -4843,25 +4903,18 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	int is_roce_protocol;
 	u16 vlan_id = 0xffff;
 	bool is_udp = false;
-	u32 max_sl;
 	u8 ib_port;
 	u8 hr_port;
 	int ret;
 
-	max_sl = min_t(u32, MAX_SERVICE_LEVEL, hr_dev->caps.sl_num - 1);
-	if (unlikely(sl > max_sl)) {
-		ibdev_err_ratelimited(ibdev,
-				      "failed to fill QPC, sl (%u) shouldn't be larger than %u.\n",
-				      sl, max_sl);
-		return -EINVAL;
-	}
-
 	/*
 	 * If free_mr_en of qp is set, it means that this qp comes from
 	 * free mr. This qp will perform the loopback operation.
 	 * In the loopback scenario, only sl needs to be set.
 	 */
 	if (hr_qp->free_mr_en) {
+		if (!check_sl_valid(hr_dev, sl))
+			return -EINVAL;
 		hr_reg_write(context, QPC_SL, sl);
 		hr_reg_clear(qpc_mask, QPC_SL);
 		hr_qp->sl = sl;
@@ -4931,11 +4984,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	memcpy(context->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
 	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
 
-	hr_qp->sl = sl;
-	hr_reg_write(context, QPC_SL, hr_qp->sl);
-	hr_reg_clear(qpc_mask, QPC_SL);
-
-	return 0;
+	return  hns_roce_set_sl(ibqp, attr, context, qpc_mask);
 }
 
 static bool check_qp_state(enum ib_qp_state cur_state,
@@ -6735,6 +6784,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.query_srqc = hns_roce_v2_query_srqc,
 	.query_sccc = hns_roce_v2_query_sccc,
 	.query_hw_counter = hns_roce_hw_v2_query_counter,
+	.get_dscp = hns_roce_hw_v2_get_dscp,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index f35a66325d9a..697230f964b1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1386,6 +1386,7 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_ib_modify_qp_resp resp = {};
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	enum ib_qp_state cur_state, new_state;
 	int ret = -EINVAL;
@@ -1427,6 +1428,18 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	ret = hr_dev->hw->modify_qp(ibqp, attr, attr_mask, cur_state,
 				    new_state, udata);
+	if (ret)
+		goto out;
+
+	if (udata && udata->outlen) {
+		resp.tc_mode = hr_qp->tc_mode;
+		resp.priority = hr_qp->sl;
+		ret = ib_copy_to_udata(udata, &resp,
+				       min(udata->outlen, sizeof(resp)));
+		if (ret)
+			ibdev_err_ratelimited(&hr_dev->ib_dev,
+					      "failed to copy modify qp resp.\n");
+	}
 
 out:
 	mutex_unlock(&hr_qp->mutex);
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 158670da2b2a..94e861870e27 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -109,6 +109,12 @@ struct hns_roce_ib_create_qp_resp {
 	__aligned_u64 dwqe_mmap_key;
 };
 
+struct hns_roce_ib_modify_qp_resp {
+	__u8	tc_mode;
+	__u8	priority;
+	__u8	reserved[6];
+};
+
 enum {
 	HNS_ROCE_EXSGE_FLAGS = 1 << 0,
 	HNS_ROCE_RQ_INLINE_FLAGS = 1 << 1,
@@ -143,7 +149,8 @@ struct hns_roce_ib_alloc_pd_resp {
 
 struct hns_roce_ib_create_ah_resp {
 	__u8 dmac[6];
-	__u8 reserved[2];
+	__u8 priority;
+	__u8 tc_mode;
 };
 
 #endif /* HNS_ABI_USER_H */
-- 
2.30.0


