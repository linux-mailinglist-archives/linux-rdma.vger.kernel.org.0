Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D090BC13F6
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2019 10:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfI2Icw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Sep 2019 04:32:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfI2Icw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Sep 2019 04:32:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48D1B7EF17A1EF404FF2;
        Sun, 29 Sep 2019 16:32:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sun, 29 Sep 2019 16:32:38 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 rdma-core 4/4] libhns: Add UD support for hip08 in user mode
Date:   Sun, 29 Sep 2019 16:29:14 +0800
Message-ID: <1569745754-45346-5-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569745754-45346-1-git-send-email-liweihang@hisilicon.com>
References: <1569745754-45346-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

User Application can use Unreliable Datagram on hip08 now.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u_hw_v2.c | 106 ++++++++++++++++++++++++++++++++++++++-
 providers/hns/hns_roce_u_hw_v2.h |  91 +++++++++++++++++++++++++++++++++
 providers/hns/hns_roce_u_verbs.c |   6 +++
 3 files changed, 202 insertions(+), 1 deletion(-)

diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 50057e3..3b7367f 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -637,6 +637,109 @@ static void set_sge(struct hns_roce_v2_wqe_data_seg *dseg,
 		}
 }
 
+static void set_ud_wqe(void *wqe, struct hns_roce_qp *qp,
+		       struct ibv_send_wr *wr, int nreq,
+		       struct hns_roce_sge_info *sge_info)
+{
+	struct hns_roce_ah *ah = to_hr_ah(wr->wr.ud.ah);
+	struct hns_roce_ud_sq_wqe *ud_sq_wqe = wqe;
+	struct hns_roce_v2_wqe_data_seg *dseg;
+	unsigned int hr_op;
+
+	memset(ud_sq_wqe, 0, sizeof(*ud_sq_wqe));
+
+	roce_set_bit(ud_sq_wqe->rsv_opcode, UD_SQ_WQE_CQE_S,
+		     (wr->send_flags & IBV_SEND_SIGNALED) ? 1 : 0);
+	roce_set_bit(ud_sq_wqe->rsv_opcode, UD_SQ_WQE_SE_S,
+		     (wr->send_flags & IBV_SEND_SOLICITED) ? 1 : 0);
+	roce_set_bit(ud_sq_wqe->rsv_opcode, UD_SQ_WQE_OWNER_S,
+		     ~(((qp->sq.head + nreq) >> qp->sq.shift) & 0x1));
+
+	switch (wr->opcode) {
+	case IBV_WR_SEND:
+		hr_op = HNS_ROCE_WQE_OP_SEND;
+		ud_sq_wqe->immtdata = 0;
+		break;
+	case IBV_WR_SEND_WITH_IMM:
+		hr_op = HNS_ROCE_WQE_OP_SEND_WITH_IMM;
+		ud_sq_wqe->immtdata =
+				htole32(be32toh(wr->imm_data));
+		break;
+	default:
+		hr_op = HNS_ROCE_WQE_OP_MASK;
+		break;
+	}
+
+	roce_set_field(ud_sq_wqe->rsv_opcode, UD_SQ_WQE_OPCODE_M,
+		       UD_SQ_WQE_OPCODE_S, hr_op);
+
+	roce_set_field(ud_sq_wqe->sge_num_pd, UD_SQ_WQE_PD_M,
+		       UD_SQ_WQE_PD_S, to_hr_pd(qp->ibv_qp.pd)->pdn);
+
+	roce_set_field(ud_sq_wqe->rsv_msg_start_sge_idx,
+		       UD_SQ_WQE_MSG_START_SGE_IDX_M,
+		       UD_SQ_WQE_MSG_START_SGE_IDX_S,
+		       sge_info->start_idx & (qp->sge.sge_cnt - 1));
+
+	roce_set_field(ud_sq_wqe->udpspn_rsv, UD_SQ_WQE_UDP_SPN_M,
+		       UD_SQ_WQE_UDP_SPN_S, 0);
+
+	ud_sq_wqe->qkey = htole32(wr->wr.ud.remote_qkey);
+
+	roce_set_field(ud_sq_wqe->rsv_dqpn, UD_SQ_WQE_DQPN_M,
+		       UD_SQ_WQE_DQPN_S, wr->wr.ud.remote_qpn);
+
+	roce_set_field(ud_sq_wqe->tclass_vlan, UD_SQ_WQE_VLAN_M,
+		       UD_SQ_WQE_VLAN_S, ah->av.vlan_id);
+
+	roce_set_field(ud_sq_wqe->tclass_vlan, UD_SQ_WQE_TCLASS_M,
+		       UD_SQ_WQE_TCLASS_S, ah->av.tclass);
+
+	roce_set_field(ud_sq_wqe->tclass_vlan, UD_SQ_WQE_HOPLIMIT_M,
+		       UD_SQ_WQE_HOPLIMIT_S, ah->av.hop_limit);
+
+	roce_set_field(ud_sq_wqe->lbi_flow_label, UD_SQ_WQE_FLOW_LABEL_M,
+		       UD_SQ_WQE_FLOW_LABEL_S, ah->av.flowlabel);
+
+	roce_set_bit(ud_sq_wqe->lbi_flow_label, UD_SQ_WQE_VLAN_EN_S,
+		     ah->av.vlan_en ? 1 : 0);
+
+	roce_set_bit(ud_sq_wqe->lbi_flow_label, UD_SQ_WQE_LBI_S, 0);
+
+	roce_set_field(ud_sq_wqe->lbi_flow_label, UD_SQ_WQE_SL_M,
+		       UD_SQ_WQE_SL_S, ah->av.sl);
+
+	roce_set_field(ud_sq_wqe->lbi_flow_label, UD_SQ_WQE_PORTN_M,
+		       UD_SQ_WQE_PORTN_S, qp->ibv_qp.qp_num);
+
+	roce_set_field(ud_sq_wqe->dmac, UD_SQ_WQE_DMAC_0_M,
+		       UD_SQ_WQE_DMAC_0_S, ah->av.mac[0]);
+	roce_set_field(ud_sq_wqe->dmac, UD_SQ_WQE_DMAC_1_M,
+		       UD_SQ_WQE_DMAC_1_S, ah->av.mac[1]);
+	roce_set_field(ud_sq_wqe->dmac, UD_SQ_WQE_DMAC_2_M,
+		       UD_SQ_WQE_DMAC_2_S, ah->av.mac[2]);
+	roce_set_field(ud_sq_wqe->dmac, UD_SQ_WQE_DMAC_3_M,
+		       UD_SQ_WQE_DMAC_3_S, ah->av.mac[3]);
+	roce_set_field(ud_sq_wqe->smac_index_dmac,
+		       UD_SQ_WQE_DMAC_4_M, UD_SQ_WQE_DMAC_4_S,
+		       to_hr_ah(wr->wr.ud.ah)->av.mac[4]);
+	roce_set_field(ud_sq_wqe->smac_index_dmac,
+		       UD_SQ_WQE_DMAC_5_M, UD_SQ_WQE_DMAC_5_S,
+		       to_hr_ah(wr->wr.ud.ah)->av.mac[5]);
+	roce_set_field(ud_sq_wqe->smac_index_dmac, UD_SQ_WQE_SGID_IDX_M,
+		       UD_SQ_WQE_SGID_IDX_S, ah->av.gid_index);
+
+	memcpy(ud_sq_wqe->dgid, ah->av.dgid, HNS_ROCE_GID_SIZE);
+
+	dseg = wqe;
+	set_sge(dseg, qp, wr, sge_info);
+
+	ud_sq_wqe->msg_len = htole32(sge_info->total_len);
+
+	roce_set_field(ud_sq_wqe->sge_num_pd, UD_SQ_WQE_SGE_NUM_M,
+		       UD_SQ_WQE_SGE_NUM_S, sge_info->valid_num);
+}
+
 static int set_rc_wqe(void *wqe, struct hns_roce_qp *qp, struct ibv_send_wr *wr,
 		      int nreq, struct hns_roce_sge_info *sge_info)
 {
@@ -833,8 +936,9 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 				goto out;
 			}
 			break;
-		case IBV_QPT_UC:
 		case IBV_QPT_UD:
+			set_ud_wqe(wqe, qp, wr, nreq, &sge_info);
+			break;
 		default:
 			ret = -EINVAL;
 			*bad_wr = wr;
diff --git a/providers/hns/hns_roce_u_hw_v2.h b/providers/hns/hns_roce_u_hw_v2.h
index 3eca1fd..84cf6c4 100644
--- a/providers/hns/hns_roce_u_hw_v2.h
+++ b/providers/hns/hns_roce_u_hw_v2.h
@@ -291,4 +291,95 @@ struct hns_roce_wqe_atomic_seg {
 int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			    struct ibv_send_wr **bad_wr);
 
+struct hns_roce_ud_sq_wqe {
+	__le32		rsv_opcode;
+	__le32		msg_len;
+	__le32		immtdata;
+	__le32		sge_num_pd;
+	__le32		rsv_msg_start_sge_idx;
+	__le32		udpspn_rsv;
+	__le32		qkey;
+	__le32		rsv_dqpn;
+	__le32		tclass_vlan;
+	__le32		lbi_flow_label;
+	__le32		dmac;
+	__le32		smac_index_dmac;
+	uint8_t		dgid[HNS_ROCE_GID_SIZE];
+};
+
+#define UD_SQ_WQE_OPCODE_S 0
+#define UD_SQ_WQE_OPCODE_M  (((1UL << 5) - 1) << UD_SQ_WQE_OPCODE_S)
+
+#define UD_SQ_WQE_OWNER_S 7
+
+#define UD_SQ_WQE_CQE_S 8
+
+#define UD_SQ_WQE_SE_S 11
+
+#define UD_SQ_WQE_PD_S 0
+#define UD_SQ_WQE_PD_M  (((1UL << 24) - 1) << UD_SQ_WQE_PD_S)
+
+#define UD_SQ_WQE_SGE_NUM_S 24
+#define UD_SQ_WQE_SGE_NUM_M  (((1UL << 8) - 1) << UD_SQ_WQE_SGE_NUM_S)
+
+#define UD_SQ_WQE_MSG_START_SGE_IDX_S 0
+#define UD_SQ_WQE_MSG_START_SGE_IDX_M \
+	(((1UL << 24) - 1) << UD_SQ_WQE_MSG_START_SGE_IDX_S)
+
+#define UD_SQ_WQE_UDP_SPN_S 16
+#define UD_SQ_WQE_UDP_SPN_M \
+	(((1UL << 16) - 1) << UD_SQ_WQE_UDP_SPN_S)
+
+#define UD_SQ_WQE_DQPN_S 0
+#define UD_SQ_WQE_DQPN_M (((1UL << 24) - 1) << UD_SQ_WQE_DQPN_S)
+
+#define UD_SQ_WQE_VLAN_S 0
+#define UD_SQ_WQE_VLAN_M (((1UL << 16) - 1) << UD_SQ_WQE_VLAN_S)
+
+#define UD_SQ_WQE_HOPLIMIT_S 16
+#define UD_SQ_WQE_HOPLIMIT_M (((1UL << 8) - 1) << UD_SQ_WQE_HOPLIMIT_S)
+
+#define UD_SQ_WQE_TCLASS_S 24
+#define UD_SQ_WQE_TCLASS_M (((1UL << 8) - 1) << UD_SQ_WQE_TCLASS_S)
+
+#define UD_SQ_WQE_FLOW_LABEL_S 0
+#define UD_SQ_WQE_FLOW_LABEL_M (((1UL << 20) - 1) << UD_SQ_WQE_FLOW_LABEL_S)
+
+#define UD_SQ_WQE_SL_S 20
+#define UD_SQ_WQE_SL_M (((1UL << 4) - 1) << UD_SQ_WQE_SL_S)
+
+#define UD_SQ_WQE_PORTN_S 24
+#define UD_SQ_WQE_PORTN_M (((1UL << 3) - 1) << UD_SQ_WQE_PORTN_S)
+
+#define UD_SQ_WQE_VLAN_EN_S 30
+
+#define UD_SQ_WQE_LBI_S 31
+
+#define UD_SQ_WQE_PORTN_S 24
+#define UD_SQ_WQE_PORTN_M (((1UL << 3) - 1) << UD_SQ_WQE_PORTN_S)
+
+#define UD_SQ_WQE_DMAC_0_S 0
+#define UD_SQ_WQE_DMAC_0_M (((1UL << 8) - 1) << UD_SQ_WQE_DMAC_0_S)
+
+#define UD_SQ_WQE_DMAC_1_S 8
+#define UD_SQ_WQE_DMAC_1_M (((1UL << 8) - 1) << UD_SQ_WQE_DMAC_1_S)
+
+#define UD_SQ_WQE_DMAC_2_S 16
+#define UD_SQ_WQE_DMAC_2_M (((1UL << 8) - 1) << UD_SQ_WQE_DMAC_2_S)
+
+#define UD_SQ_WQE_DMAC_3_S 24
+#define UD_SQ_WQE_DMAC_3_M (((1UL << 8) - 1) << UD_SQ_WQE_DMAC_3_S)
+
+#define UD_SQ_WQE_DMAC_4_S 0
+#define UD_SQ_WQE_DMAC_4_M (((1UL << 8) - 1) << UD_SQ_WQE_DMAC_4_S)
+
+#define UD_SQ_WQE_DMAC_5_S 8
+#define UD_SQ_WQE_DMAC_5_M (((1UL << 8) - 1) << UD_SQ_WQE_DMAC_5_S)
+
+#define UD_SQ_WQE_SGID_IDX_S 16
+#define UD_SQ_WQE_SGID_IDX_M (((1UL << 8) - 1) << UD_SQ_WQE_SGID_IDX_S)
+
+#define UD_SQ_WQE_SMAC_IDX_S 24
+#define UD_SQ_WQE_SMAC_IDX_M (((1UL << 8) - 1) << UD_SQ_WQE_SMAC_IDX_S)
+
 #endif /* _HNS_ROCE_U_HW_V2_H */
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index ef4b9e0..e72df38 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -767,6 +767,12 @@ static void hns_roce_set_qp_params(struct ibv_pd *pd,
 		}
 	}
 
+	if (attr->qp_type == IBV_QPT_UD)
+		qp->sge.sge_cnt = roundup_pow_of_two(qp->sq.wqe_cnt *
+						     qp->sq.max_gs);
+
+	qp->ibv_qp.qp_type = attr->qp_type;
+
 	/* limit by the context queried during alloc context */
 	qp->rq.max_post = min(ctx->max_qp_wr, qp->rq.wqe_cnt);
 	qp->sq.max_post = min(ctx->max_qp_wr, qp->sq.wqe_cnt);
-- 
2.8.1

