Return-Path: <linux-rdma+bounces-6102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648DA9D9212
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 08:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8509B246BF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B3178372;
	Tue, 26 Nov 2024 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bST5JVZk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA9191461
	for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2024 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604647; cv=none; b=Ro1w7lpmq1czVIJ5NEd2LS89Ko5vOOzp7ZpzHxprdBCl4EDgTwvl90aE5thZHqfaOZisF05lOx7g1DD8xyPxPT2LcPtUulMc7qxyKrEOnqagbq2FXAOj2seg0Tdv3hOZvErjz7g1+brA7QDftorZE71NJbYr9nYe2TFNGWM6hRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604647; c=relaxed/simple;
	bh=2VIIZ6FszJIOebTQJH49y1Y36zYRrB970b3N8933cQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZR+N2VXseibXzh5HsMM6pL32dlsyyhxtNAcIF9cp29qbaswqG75w3Z7OsU2+988HvAUVdr/jPDjdDlT08Fka/lRe69Ex6RNIuncCxRQpVMIl3BSWprpVtGfFU8pQqOmQS69RJpXCUWlJ0KS50o+5uznXUoiciiN9sFrkFghTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bST5JVZk; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732604636; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dOME/cTYOvczcTFVrAhvNbj0/igm+5ZtMQBeSEkeonc=;
	b=bST5JVZkyp7aajVgGfUZflO2Kt8MJRwbTqm+tbO3dOlNav4+a4Xl7fcKzK7D031LiN3ythRaHAV1gewQciqXWeBaWnXFXg944O/LFzAkx0KPJjXqraUMf41bc6u/V+Kpd6U6OsgzOR3w108mswdTiZ5AXFgFLy0l2aFU5BPefXw=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WKHPI07_1732604635 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 15:03:56 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 4/8] RDMA/erdma: Add address handle implementation
Date: Tue, 26 Nov 2024 14:59:10 +0800
Message-ID: <20241126070351.92787-5-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The address handle contains the necessary information to transmit
messages to a remote peer in the RoCEv2 protocol. This commit
implements the erdma_create_ah(), erdma_destroy_ah(), and
erdma_query_ah() interfaces, which are used to create, destroy,
and query an address handle, respectively.

Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h       |   4 +-
 drivers/infiniband/hw/erdma/erdma_hw.h    |  34 ++++++
 drivers/infiniband/hw/erdma/erdma_main.c  |   4 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 135 +++++++++++++++++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.h |  28 +++++
 5 files changed, 203 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index 42dabf674f5d..4f840d8e3beb 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -149,6 +149,7 @@ struct erdma_devattr {
 	u32 max_pd;
 	u32 max_mw;
 	u32 max_gid;
+	u32 max_ah;
 	u32 local_dma_key;
 };
 
@@ -178,7 +179,8 @@ struct erdma_resource_cb {
 enum {
 	ERDMA_RES_TYPE_PD = 0,
 	ERDMA_RES_TYPE_STAG_IDX = 1,
-	ERDMA_RES_CNT = 2,
+	ERDMA_RES_TYPE_AH = 2,
+	ERDMA_RES_CNT = 3,
 };
 
 struct erdma_dev {
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index f7f9dcac3ab0..64d856494359 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/if_ether.h>
 
 /* PCIe device related definition. */
 #define ERDMA_PCI_WIDTH 64
@@ -150,6 +151,8 @@ enum CMDQ_RDMA_OPCODE {
 	CMDQ_OPCODE_REG_MR = 8,
 	CMDQ_OPCODE_DEREG_MR = 9,
 	CMDQ_OPCODE_SET_GID = 14,
+	CMDQ_OPCODE_CREATE_AH = 15,
+	CMDQ_OPCODE_DESTROY_AH = 16,
 };
 
 enum CMDQ_COMMON_OPCODE {
@@ -297,6 +300,36 @@ struct erdma_cmdq_dereg_mr_req {
 	u32 cfg;
 };
 
+/* create_av cfg0 */
+#define ERDMA_CMD_CREATE_AV_FL_MASK GENMASK(19, 0)
+#define ERDMA_CMD_CREATE_AV_NTYPE_MASK BIT(20)
+
+struct erdma_av_cfg {
+	u32 cfg0;
+	u8 traffic_class;
+	u8 hop_limit;
+	u8 sl;
+	u8 rsvd;
+	u16 udp_sport;
+	u16 sgid_index;
+	u8 dmac[ETH_ALEN];
+	u8 padding[2];
+	u8 dgid[ERDMA_ROCEV2_GID_SIZE];
+};
+
+struct erdma_cmdq_create_ah_req {
+	u64 hdr;
+	u32 pdn;
+	u32 ahn;
+	struct erdma_av_cfg av_cfg;
+};
+
+struct erdma_cmdq_destroy_ah_req {
+	u64 hdr;
+	u32 pdn;
+	u32 ahn;
+};
+
 /* modify qp cfg */
 #define ERDMA_CMD_MODIFY_QP_STATE_MASK GENMASK(31, 24)
 #define ERDMA_CMD_MODIFY_QP_CC_MASK GENMASK(23, 20)
@@ -433,6 +466,7 @@ struct erdma_cmdq_set_gid_req {
 #define ERDMA_CMD_DEV_CAP_MAX_CQE_MASK GENMASK_ULL(47, 40)
 #define ERDMA_CMD_DEV_CAP_FLAGS_MASK GENMASK_ULL(31, 24)
 #define ERDMA_CMD_DEV_CAP_MAX_RECV_WR_MASK GENMASK_ULL(23, 16)
+#define ERDMA_CMD_DEV_CAP_MAX_AH_MASK GENMASK_ULL(15, 8)
 #define ERDMA_CMD_DEV_CAP_MAX_MR_SIZE_MASK GENMASK_ULL(7, 0)
 
 /* cap qword 1 definition */
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index fca5bf7519dd..8d24b87cfce3 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -405,6 +405,7 @@ static int erdma_dev_attrs_init(struct erdma_dev *dev)
 	dev->attrs.max_mw = 1 << ERDMA_GET_CAP(MAX_MW, cap1);
 	dev->attrs.max_recv_wr = 1 << ERDMA_GET_CAP(MAX_RECV_WR, cap0);
 	dev->attrs.max_gid = 1 << ERDMA_GET_CAP(MAX_GID, cap0);
+	dev->attrs.max_ah = 1 << ERDMA_GET_CAP(MAX_AH, cap0);
 	dev->attrs.local_dma_key = ERDMA_GET_CAP(DMA_LOCAL_KEY, cap1);
 	dev->attrs.cc = ERDMA_GET_CAP(DEFAULT_CC, cap1);
 	dev->attrs.max_qp = ERDMA_NQP_PER_QBLOCK * ERDMA_GET_CAP(QBLOCK, cap1);
@@ -422,6 +423,7 @@ static int erdma_dev_attrs_init(struct erdma_dev *dev)
 
 	dev->res_cb[ERDMA_RES_TYPE_PD].max_cap = ERDMA_MAX_PD;
 	dev->res_cb[ERDMA_RES_TYPE_STAG_IDX].max_cap = dev->attrs.max_mr;
+	dev->res_cb[ERDMA_RES_TYPE_AH].max_cap = dev->attrs.max_ah;
 
 	erdma_cmdq_build_reqhdr(&req_hdr, CMDQ_SUBMOD_COMMON,
 				CMDQ_OPCODE_QUERY_FW_INFO);
@@ -486,6 +488,8 @@ static const struct ib_device_ops erdma_device_ops_rocev2 = {
 	.add_gid = erdma_add_gid,
 	.del_gid = erdma_del_gid,
 	.query_pkey = erdma_query_pkey,
+	.create_ah = erdma_create_ah,
+	.destroy_ah = erdma_destroy_ah,
 };
 
 static const struct ib_device_ops erdma_device_ops_iwarp = {
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 03ea52bb233e..1fdf38f65b05 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -336,8 +336,10 @@ int erdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 	attr->max_fast_reg_page_list_len = ERDMA_MAX_FRMR_PA;
 	attr->page_size_cap = ERDMA_PAGE_SIZE_SUPPORT;
 
-	if (erdma_device_rocev2(dev))
+	if (erdma_device_rocev2(dev)) {
 		attr->max_pkeys = ERDMA_MAX_PKEYS;
+		attr->max_ah = dev->attrs.max_ah;
+	}
 
 	if (dev->attrs.cap_flags & ERDMA_DEV_CAP_FLAGS_ATOMIC)
 		attr->atomic_cap = IB_ATOMIC_GLOB;
@@ -1917,3 +1919,134 @@ int erdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey)
 	*pkey = ERDMA_DEFAULT_PKEY;
 	return 0;
 }
+
+static void erdma_attr_to_av(const struct rdma_ah_attr *ah_attr,
+			     struct erdma_av *av, u16 sport)
+{
+	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
+
+	av->port = rdma_ah_get_port_num(ah_attr);
+	av->sgid_index = grh->sgid_index;
+	av->hop_limit = grh->hop_limit;
+	av->traffic_class = grh->traffic_class;
+	av->sl = rdma_ah_get_sl(ah_attr);
+
+	av->flow_label = grh->flow_label;
+	av->udp_sport = sport;
+
+	ether_addr_copy(av->dmac, ah_attr->roce.dmac);
+	memcpy(av->dgid, grh->dgid.raw, ERDMA_ROCEV2_GID_SIZE);
+
+	if (ipv6_addr_v4mapped((struct in6_addr *)&grh->dgid))
+		av->ntype = ERDMA_NETWORK_TYPE_IPV4;
+	else
+		av->ntype = ERDMA_NETWORK_TYPE_IPV6;
+}
+
+static void erdma_av_to_attr(struct erdma_av *av, struct rdma_ah_attr *attr)
+{
+	attr->type = RDMA_AH_ATTR_TYPE_ROCE;
+
+	rdma_ah_set_sl(attr, av->sl);
+	rdma_ah_set_port_num(attr, av->port);
+	rdma_ah_set_ah_flags(attr, IB_AH_GRH);
+
+	rdma_ah_set_grh(attr, NULL, av->flow_label, av->sgid_index,
+			av->hop_limit, av->traffic_class);
+	rdma_ah_set_dgid_raw(attr, av->dgid);
+}
+
+static void erdma_set_av_cfg(struct erdma_av_cfg *av_cfg, struct erdma_av *av)
+{
+	av_cfg->cfg0 = FIELD_PREP(ERDMA_CMD_CREATE_AV_FL_MASK, av->flow_label) |
+		       FIELD_PREP(ERDMA_CMD_CREATE_AV_NTYPE_MASK, av->ntype);
+
+	av_cfg->traffic_class = av->traffic_class;
+	av_cfg->hop_limit = av->hop_limit;
+	av_cfg->sl = av->sl;
+
+	av_cfg->udp_sport = av->udp_sport;
+	av_cfg->sgid_index = av->sgid_index;
+
+	ether_addr_copy(av_cfg->dmac, av->dmac);
+	memcpy(av_cfg->dgid, av->dgid, ERDMA_ROCEV2_GID_SIZE);
+}
+
+int erdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
+		    struct ib_udata *udata)
+{
+	const struct ib_global_route *grh =
+		rdma_ah_read_grh(init_attr->ah_attr);
+	struct erdma_dev *dev = to_edev(ibah->device);
+	struct erdma_pd *pd = to_epd(ibah->pd);
+	struct erdma_ah *ah = to_eah(ibah);
+	struct erdma_cmdq_create_ah_req req;
+	u32 udp_sport;
+	int ret;
+
+	ret = erdma_check_gid_attr(grh->sgid_attr);
+	if (ret)
+		return ret;
+
+	ret = erdma_alloc_idx(&dev->res_cb[ERDMA_RES_TYPE_AH]);
+	if (ret < 0)
+		return ret;
+
+	ah->ahn = ret;
+
+	if (grh->flow_label)
+		udp_sport = rdma_flow_label_to_udp_sport(grh->flow_label);
+	else
+		udp_sport =
+			IB_ROCE_UDP_ENCAP_VALID_PORT_MIN + (ah->ahn & 0x3FFF);
+
+	erdma_attr_to_av(init_attr->ah_attr, &ah->av, udp_sport);
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_CREATE_AH);
+
+	req.pdn = pd->pdn;
+	req.ahn = ah->ahn;
+	erdma_set_av_cfg(&req.av_cfg, &ah->av);
+
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	if (ret) {
+		erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_AH], ah->ahn);
+		return ret;
+	}
+
+	return 0;
+}
+
+int erdma_destroy_ah(struct ib_ah *ibah, u32 flags)
+{
+	struct erdma_dev *dev = to_edev(ibah->device);
+	struct erdma_pd *pd = to_epd(ibah->pd);
+	struct erdma_ah *ah = to_eah(ibah);
+	struct erdma_cmdq_destroy_ah_req req;
+	int ret;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_DESTROY_AH);
+
+	req.pdn = pd->pdn;
+	req.ahn = ah->ahn;
+
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	if (ret)
+		return ret;
+
+	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_AH], ah->ahn);
+
+	return 0;
+}
+
+int erdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
+{
+	struct erdma_ah *ah = to_eah(ibah);
+
+	memset(ah_attr, 0, sizeof(*ah_attr));
+	erdma_av_to_attr(&ah->av, ah_attr);
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 1ae6ba56f597..78a6c35cf1a5 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -136,6 +136,25 @@ struct erdma_user_dbrecords_page {
 	int refcnt;
 };
 
+struct erdma_av {
+	u8 port;
+	u8 hop_limit;
+	u8 traffic_class;
+	u8 sl;
+	u8 sgid_index;
+	u16 udp_sport;
+	u32 flow_label;
+	u8 dmac[ETH_ALEN];
+	u8 dgid[ERDMA_ROCEV2_GID_SIZE];
+	enum erdma_network_type ntype;
+};
+
+struct erdma_ah {
+	struct ib_ah ibah;
+	struct erdma_av av;
+	u32 ahn;
+};
+
 struct erdma_uqp {
 	struct erdma_mem sq_mem;
 	struct erdma_mem rq_mem;
@@ -326,6 +345,11 @@ static inline struct erdma_cq *to_ecq(struct ib_cq *ibcq)
 	return container_of(ibcq, struct erdma_cq, ibcq);
 }
 
+static inline struct erdma_ah *to_eah(struct ib_ah *ibah)
+{
+	return container_of(ibah, struct erdma_ah, ibah);
+}
+
 static inline int erdma_check_gid_attr(const struct ib_gid_attr *attr)
 {
 	u8 ntype = rdma_gid_attr_network_type(attr);
@@ -395,5 +419,9 @@ enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev,
 int erdma_add_gid(const struct ib_gid_attr *attr, void **context);
 int erdma_del_gid(const struct ib_gid_attr *attr, void **context);
 int erdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey);
+int erdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
+		    struct ib_udata *udata);
+int erdma_destroy_ah(struct ib_ah *ibah, u32 flags);
+int erdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
 
 #endif
-- 
2.43.5


