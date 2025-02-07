Return-Path: <linux-rdma+bounces-7547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC886A2CD2F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FEB1889D19
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5DB1C6FE6;
	Fri,  7 Feb 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYCsrlkA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03951B424A;
	Fri,  7 Feb 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957838; cv=none; b=KYpaDxcyyCxIkDlFhpFIWk5xIMzEfUP1lkX/HfeaVMPKi4hj1UZKfC9fwjelvW1NWYmA9EvRCUR1rYlOgoWRFIS5g3q+UC+1yizVlBY2lNyGRYiXizCzKzQlDVCZxVtchPZLY0W6kgjzhMvSKI9U5wB19a+DJqbsPdnRyYwP9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957838; c=relaxed/simple;
	bh=KwoeyrBd3M+if/I/OXF/oGLVw7pifl//ENGztpjgiVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcjObU6Nm+TkjWuyB9DRp85zepse4DLAER9WNcJ5gIpIjFk4x6OlcPJ2l9JG8XLh6lj28vuKhD+35mXB3efjEitG+DWfKhFrS/gnVzmowmIAzsRnFLn4C93b5t106qSZo9WhLkPo91Qpr/diafFo+/TZ3Aiodt4Mb16ol0927C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYCsrlkA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957837; x=1770493837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KwoeyrBd3M+if/I/OXF/oGLVw7pifl//ENGztpjgiVw=;
  b=mYCsrlkAjSl4ADddqhc2knQsONPuDPTCyv5b0voOhciDpqXnxpFy9Ejr
   pyEKMGzcY4QeWsu3rxsKt48akVpOZHvB8c098hyCDDWXGWICXNVEXQDxF
   taO+tyj8QgGYrk65mPb+moCtT68KyBwEE4S9NT6Z1TSqHLMoY3UiQx4L1
   j7zV26+0a0xc3YftnDG/9B7zZ2VoqWDr5wfItyQtrlJUmVkDngGjM4QaR
   RD5HltZpvC1mEjao9mPJqd++cdJ1WZANyMJzmpo5Dh6M2ir4FL82+CCCA
   /eTrjgv+B9rejvrNb4dnOr0AAC7v5cBLoqYdvLTfhMeYC/rg+xOag9eYx
   Q==;
X-CSE-ConnectionGUID: juyuoXY9Rma8QM6G6z8OJw==
X-CSE-MsgGUID: MiPnF5nLRW6KhQpQa47V+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451826"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451826"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:31 -0800
X-CSE-ConnectionGUID: JT5Rj1awRyq3ck/XzQRftg==
X-CSE-MsgGUID: sAI8CH5VQlWg4o46Tlv3Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238218"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:30 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [rdma v3 16/24] RDMA/irdma: Extend QP context programming for GEN3
Date: Fri,  7 Feb 2025 13:49:23 -0600
Message-Id: <20250207194931.1569-17-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiraz Saleem <shiraz.saleem@intel.com>

Extend the QP context structure with support for new fields
specific to GEN3 hardware capabilities.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c  | 184 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/irdma/defs.h  |  24 +++-
 drivers/infiniband/hw/irdma/type.h  |   4 +
 drivers/infiniband/hw/irdma/uda_d.h |   5 +-
 drivers/infiniband/hw/irdma/verbs.c |   5 +
 5 files changed, 215 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 7d2ae701b8f5..52bb87f4b2c5 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -637,13 +637,14 @@ static u8 irdma_sc_get_encoded_ird_size(u16 ird_size)
 }
 
 /**
- * irdma_sc_qp_setctx_roce - set qp's context
+ * irdma_sc_qp_setctx_roce_gen_2 - set qp's context
  * @qp: sc qp
  * @qp_ctx: context ptr
  * @info: ctx info
  */
-void irdma_sc_qp_setctx_roce(struct irdma_sc_qp *qp, __le64 *qp_ctx,
-			     struct irdma_qp_host_ctx_info *info)
+static void irdma_sc_qp_setctx_roce_gen_2(struct irdma_sc_qp *qp,
+					  __le64 *qp_ctx,
+					  struct irdma_qp_host_ctx_info *info)
 {
 	struct irdma_roce_offload_info *roce_info;
 	struct irdma_udp_offload_info *udp;
@@ -761,6 +762,183 @@ void irdma_sc_qp_setctx_roce(struct irdma_sc_qp *qp, __le64 *qp_ctx,
 			     8, qp_ctx, IRDMA_QP_CTX_SIZE, false);
 }
 
+/**
+ * irdma_sc_get_encoded_ird_size_gen_3 - get encoded IRD size for GEN 3
+ * @ird_size: IRD size
+ * The ird from the connection is rounded to a supported HW setting and then encoded
+ * for ird_size field of qp_ctx. Consumers are expected to provide valid ird size based
+ * on hardware attributes. IRD size defaults to a value of 4 in case of invalid input.
+ */
+static u8 irdma_sc_get_encoded_ird_size_gen_3(u16 ird_size)
+{
+	switch (ird_size ?
+		roundup_pow_of_two(2 * ird_size) : 4) {
+	case 4096:
+		return IRDMA_IRD_HW_SIZE_4096_GEN3;
+	case 2048:
+		return IRDMA_IRD_HW_SIZE_2048_GEN3;
+	case 1024:
+		return IRDMA_IRD_HW_SIZE_1024_GEN3;
+	case 512:
+		return IRDMA_IRD_HW_SIZE_512_GEN3;
+	case 256:
+		return IRDMA_IRD_HW_SIZE_256_GEN3;
+	case 128:
+		return IRDMA_IRD_HW_SIZE_128_GEN3;
+	case 64:
+		return IRDMA_IRD_HW_SIZE_64_GEN3;
+	case 32:
+		return IRDMA_IRD_HW_SIZE_32_GEN3;
+	case 16:
+		return IRDMA_IRD_HW_SIZE_16_GEN3;
+	case 8:
+		return IRDMA_IRD_HW_SIZE_8_GEN3;
+	case 4:
+	default:
+		break;
+	}
+
+	return IRDMA_IRD_HW_SIZE_4_GEN3;
+}
+
+/**
+ * irdma_sc_qp_setctx_roce_gen_3 - set qp's context
+ * @qp: sc qp
+ * @qp_ctx: context ptr
+ * @info: ctx info
+ */
+static void irdma_sc_qp_setctx_roce_gen_3(struct irdma_sc_qp *qp,
+					  __le64 *qp_ctx,
+					  struct irdma_qp_host_ctx_info *info)
+{
+	struct irdma_roce_offload_info *roce_info = info->roce_info;
+	struct irdma_udp_offload_info *udp = info->udp_info;
+	u64 qw0, qw3, qw7 = 0, qw8 = 0;
+	u8 push_mode_en;
+	u32 push_idx;
+
+	qp->user_pri = info->user_pri;
+	if (qp->push_idx == IRDMA_INVALID_PUSH_PAGE_INDEX) {
+		push_mode_en = 0;
+		push_idx = 0;
+	} else {
+		push_mode_en = 1;
+		push_idx = qp->push_idx;
+	}
+
+	qw0 = FIELD_PREP(IRDMAQPC_RQWQESIZE, qp->qp_uk.rq_wqe_size) |
+	      FIELD_PREP(IRDMAQPC_RCVTPHEN, qp->rcv_tph_en) |
+	      FIELD_PREP(IRDMAQPC_XMITTPHEN, qp->xmit_tph_en) |
+	      FIELD_PREP(IRDMAQPC_RQTPHEN, qp->rq_tph_en) |
+	      FIELD_PREP(IRDMAQPC_SQTPHEN, qp->sq_tph_en) |
+	      FIELD_PREP(IRDMAQPC_PPIDX, push_idx) |
+	      FIELD_PREP(IRDMAQPC_PMENA, push_mode_en) |
+	      FIELD_PREP(IRDMAQPC_DC_TCP_EN, roce_info->dctcp_en) |
+	      FIELD_PREP(IRDMAQPC_ISQP1, roce_info->is_qp1) |
+	      FIELD_PREP(IRDMAQPC_ROCE_TVER, roce_info->roce_tver) |
+	      FIELD_PREP(IRDMAQPC_IPV4, udp->ipv4) |
+	      FIELD_PREP(IRDMAQPC_INSERTVLANTAG, udp->insert_vlan_tag);
+	set_64bit_val(qp_ctx, 0, qw0);
+	set_64bit_val(qp_ctx, 8, qp->sq_pa);
+	set_64bit_val(qp_ctx, 16, qp->rq_pa);
+	qw3 = FIELD_PREP(IRDMAQPC_RQSIZE, qp->hw_rq_size) |
+	      FIELD_PREP(IRDMAQPC_SQSIZE, qp->hw_sq_size) |
+	      FIELD_PREP(IRDMAQPC_TTL, udp->ttl) |
+	      FIELD_PREP(IRDMAQPC_TOS, udp->tos) |
+	      FIELD_PREP(IRDMAQPC_SRCPORTNUM, udp->src_port) |
+	      FIELD_PREP(IRDMAQPC_DESTPORTNUM, udp->dst_port);
+	set_64bit_val(qp_ctx, 24, qw3);
+	set_64bit_val(qp_ctx, 32,
+		      FIELD_PREP(IRDMAQPC_DESTIPADDR2, udp->dest_ip_addr[2]) |
+		      FIELD_PREP(IRDMAQPC_DESTIPADDR3, udp->dest_ip_addr[3]));
+	set_64bit_val(qp_ctx, 40,
+		      FIELD_PREP(IRDMAQPC_DESTIPADDR0, udp->dest_ip_addr[0]) |
+		      FIELD_PREP(IRDMAQPC_DESTIPADDR1, udp->dest_ip_addr[1]));
+	set_64bit_val(qp_ctx, 48,
+		      FIELD_PREP(IRDMAQPC_SNDMSS, udp->snd_mss) |
+		      FIELD_PREP(IRDMAQPC_VLANTAG, udp->vlan_tag) |
+		      FIELD_PREP(IRDMAQPC_ARPIDX, udp->arp_idx));
+	qw7 =  FIELD_PREP(IRDMAQPC_PKEY, roce_info->p_key) |
+	       FIELD_PREP(IRDMAQPC_ACKCREDITS, roce_info->ack_credits) |
+	       FIELD_PREP(IRDMAQPC_FLOWLABEL, udp->flow_label);
+	set_64bit_val(qp_ctx, 56, qw7);
+	qw8 = FIELD_PREP(IRDMAQPC_QKEY, roce_info->qkey) |
+	      FIELD_PREP(IRDMAQPC_DESTQP, roce_info->dest_qp);
+	set_64bit_val(qp_ctx, 64, qw8);
+	set_64bit_val(qp_ctx, 80,
+		      FIELD_PREP(IRDMAQPC_PSNNXT, udp->psn_nxt) |
+		      FIELD_PREP(IRDMAQPC_LSN, udp->lsn));
+	set_64bit_val(qp_ctx, 88,
+		      FIELD_PREP(IRDMAQPC_EPSN, udp->epsn));
+	set_64bit_val(qp_ctx, 96,
+		      FIELD_PREP(IRDMAQPC_PSNMAX, udp->psn_max) |
+		      FIELD_PREP(IRDMAQPC_PSNUNA, udp->psn_una));
+	set_64bit_val(qp_ctx, 112,
+		      FIELD_PREP(IRDMAQPC_CWNDROCE, udp->cwnd));
+	set_64bit_val(qp_ctx, 128,
+		      FIELD_PREP(IRDMAQPC_MINRNR_TIMER, udp->min_rnr_timer) |
+		      FIELD_PREP(IRDMAQPC_RNRNAK_THRESH, udp->rnr_nak_thresh) |
+		      FIELD_PREP(IRDMAQPC_REXMIT_THRESH, udp->rexmit_thresh) |
+		      FIELD_PREP(IRDMAQPC_RNRNAK_TMR, udp->rnr_nak_tmr) |
+		      FIELD_PREP(IRDMAQPC_RTOMIN, roce_info->rtomin));
+	set_64bit_val(qp_ctx, 136,
+		      FIELD_PREP(IRDMAQPC_TXCQNUM, info->send_cq_num) |
+		      FIELD_PREP(IRDMAQPC_RXCQNUM, info->rcv_cq_num));
+	set_64bit_val(qp_ctx, 152,
+		      FIELD_PREP(IRDMAQPC_MACADDRESS,
+				 ether_addr_to_u64(roce_info->mac_addr)) |
+		      FIELD_PREP(IRDMAQPC_LOCALACKTIMEOUT,
+				 roce_info->local_ack_timeout));
+	set_64bit_val(qp_ctx, 160,
+		      FIELD_PREP(IRDMAQPC_ORDSIZE_GEN3, roce_info->ord_size) |
+		      FIELD_PREP(IRDMAQPC_IRDSIZE_GEN3,
+				 irdma_sc_get_encoded_ird_size_gen_3(roce_info->ird_size)) |
+		      FIELD_PREP(IRDMAQPC_WRRDRSPOK, roce_info->wr_rdresp_en) |
+		      FIELD_PREP(IRDMAQPC_RDOK, roce_info->rd_en) |
+		      FIELD_PREP(IRDMAQPC_USESTATSINSTANCE,
+				 info->stats_idx_valid) |
+		      FIELD_PREP(IRDMAQPC_BINDEN, roce_info->bind_en) |
+		      FIELD_PREP(IRDMAQPC_FASTREGEN, roce_info->fast_reg_en) |
+		      FIELD_PREP(IRDMAQPC_DCQCNENABLE, roce_info->dcqcn_en) |
+		      FIELD_PREP(IRDMAQPC_RCVNOICRC, roce_info->rcv_no_icrc) |
+		      FIELD_PREP(IRDMAQPC_FW_CC_ENABLE,
+				 roce_info->fw_cc_enable) |
+		      FIELD_PREP(IRDMAQPC_UDPRIVCQENABLE,
+				 roce_info->udprivcq_en) |
+		      FIELD_PREP(IRDMAQPC_PRIVEN, roce_info->priv_mode_en) |
+		      FIELD_PREP(IRDMAQPC_TIMELYENABLE, roce_info->timely_en));
+	set_64bit_val(qp_ctx, 168,
+		      FIELD_PREP(IRDMAQPC_QPCOMPCTX, info->qp_compl_ctx));
+	set_64bit_val(qp_ctx, 176,
+		      FIELD_PREP(IRDMAQPC_SQTPHVAL, qp->sq_tph_val) |
+		      FIELD_PREP(IRDMAQPC_RQTPHVAL, qp->rq_tph_val) |
+		      FIELD_PREP(IRDMAQPC_QSHANDLE, qp->qs_handle));
+	set_64bit_val(qp_ctx, 184,
+		      FIELD_PREP(IRDMAQPC_LOCAL_IPADDR3, udp->local_ipaddr[3]) |
+		      FIELD_PREP(IRDMAQPC_LOCAL_IPADDR2, udp->local_ipaddr[2]));
+	set_64bit_val(qp_ctx, 192,
+		      FIELD_PREP(IRDMAQPC_LOCAL_IPADDR1, udp->local_ipaddr[1]) |
+		      FIELD_PREP(IRDMAQPC_LOCAL_IPADDR0, udp->local_ipaddr[0]));
+	set_64bit_val(qp_ctx, 200,
+		      FIELD_PREP(IRDMAQPC_THIGH, roce_info->t_high) |
+		      FIELD_PREP(IRDMAQPC_TLOW, roce_info->t_low));
+	set_64bit_val(qp_ctx, 208, roce_info->pd_id |
+		      FIELD_PREP(IRDMAQPC_STAT_INDEX_GEN3, info->stats_idx) |
+		      FIELD_PREP(IRDMAQPC_PKT_LIMIT, qp->pkt_limit));
+
+	print_hex_dump_debug("WQE: QP_HOST ROCE CTX WQE", DUMP_PREFIX_OFFSET,
+			     16, 8, qp_ctx, IRDMA_QP_CTX_SIZE, false);
+}
+
+void irdma_sc_qp_setctx_roce(struct irdma_sc_qp *qp, __le64 *qp_ctx,
+			     struct irdma_qp_host_ctx_info *info)
+{
+	if (qp->dev->hw_attrs.uk_attrs.hw_rev == IRDMA_GEN_2)
+		irdma_sc_qp_setctx_roce_gen_2(qp, qp_ctx, info);
+	else
+		irdma_sc_qp_setctx_roce_gen_3(qp, qp_ctx, info);
+}
+
 /* irdma_sc_alloc_local_mac_entry - allocate a mac entry
  * @cqp: struct for cqp hw
  * @scratch: u64 saved to be used during cqp completion
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 2fc8e3cf4395..1eff7d8d8f15 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -14,6 +14,18 @@
 #define IRDMA_PE_DB_SIZE_4M	1
 #define IRDMA_PE_DB_SIZE_8M	2
 
+#define IRDMA_IRD_HW_SIZE_4_GEN3	0
+#define IRDMA_IRD_HW_SIZE_8_GEN3	1
+#define IRDMA_IRD_HW_SIZE_16_GEN3	2
+#define IRDMA_IRD_HW_SIZE_32_GEN3	3
+#define IRDMA_IRD_HW_SIZE_64_GEN3	4
+#define IRDMA_IRD_HW_SIZE_128_GEN3	5
+#define IRDMA_IRD_HW_SIZE_256_GEN3	6
+#define IRDMA_IRD_HW_SIZE_512_GEN3	7
+#define IRDMA_IRD_HW_SIZE_1024_GEN3	8
+#define IRDMA_IRD_HW_SIZE_2048_GEN3	9
+#define IRDMA_IRD_HW_SIZE_4096_GEN3	10
+
 #define IRDMA_IRD_HW_SIZE_4	0
 #define IRDMA_IRD_HW_SIZE_16	1
 #define IRDMA_IRD_HW_SIZE_64	2
@@ -836,7 +848,8 @@ enum irdma_cqp_op_type {
 #define IRDMAQPC_CWNDROCE GENMASK_ULL(55, 32)
 #define IRDMAQPC_SNDWL1 GENMASK_ULL(31, 0)
 #define IRDMAQPC_SNDWL2 GENMASK_ULL(63, 32)
-#define IRDMAQPC_ERR_RQ_IDX GENMASK_ULL(45, 32)
+#define IRDMAQPC_MINRNR_TIMER GENMASK_ULL(4, 0)
+#define IRDMAQPC_ERR_RQ_IDX GENMASK_ULL(46, 32)
 #define IRDMAQPC_RTOMIN GENMASK_ULL(63, 57)
 #define IRDMAQPC_MAXSNDWND GENMASK_ULL(31, 0)
 #define IRDMAQPC_REXMIT_THRESH GENMASK_ULL(53, 48)
@@ -849,8 +862,17 @@ enum irdma_cqp_op_type {
 #define IRDMAQPC_MACADDRESS GENMASK_ULL(63, 16)
 #define IRDMAQPC_ORDSIZE GENMASK_ULL(7, 0)
 
+#define IRDMAQPC_LOCALACKTIMEOUT GENMASK_ULL(12, 8)
+#define IRDMAQPC_RNRNAK_TMR GENMASK_ULL(4, 0)
+#define IRDMAQPC_ORDSIZE_GEN3 GENMASK_ULL(10, 0)
+#define IRDMAQPC_REMOTE_ATOMIC_EN BIT_ULL(18)
+#define IRDMAQPC_STAT_INDEX_GEN3 GENMASK_ULL(47, 32)
+#define IRDMAQPC_PKT_LIMIT GENMASK_ULL(55, 48)
+
 #define IRDMAQPC_IRDSIZE GENMASK_ULL(18, 16)
 
+#define IRDMAQPC_IRDSIZE_GEN3 GENMASK_ULL(17, 14)
+
 #define IRDMAQPC_UDPRIVCQENABLE BIT_ULL(19)
 #define IRDMAQPC_WRRDRSPOK BIT_ULL(20)
 #define IRDMAQPC_RDOK BIT_ULL(21)
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 1a038011200b..b258a7cb4dd9 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -574,6 +574,7 @@ struct irdma_sc_qp {
 	bool flush_rq:1;
 	bool sq_flush_code:1;
 	bool rq_flush_code:1;
+	u32 pkt_limit;
 	enum irdma_flush_opcode flush_code;
 	enum irdma_qp_event_type event_type;
 	u8 term_flags;
@@ -915,6 +916,8 @@ struct irdma_udp_offload_info {
 	u32 cwnd;
 	u8 rexmit_thresh;
 	u8 rnr_nak_thresh;
+	u8 rnr_nak_tmr;
+	u8 min_rnr_timer;
 };
 
 struct irdma_roce_offload_info {
@@ -941,6 +944,7 @@ struct irdma_roce_offload_info {
 	bool dctcp_en:1;
 	bool fw_cc_enable:1;
 	bool use_stats_inst:1;
+	u8 local_ack_timeout;
 	u16 t_high;
 	u16 t_low;
 	u8 last_byte_sent;
diff --git a/drivers/infiniband/hw/irdma/uda_d.h b/drivers/infiniband/hw/irdma/uda_d.h
index 5a9e6eabf032..4fb4daa20722 100644
--- a/drivers/infiniband/hw/irdma/uda_d.h
+++ b/drivers/infiniband/hw/irdma/uda_d.h
@@ -78,8 +78,7 @@
 #define IRDMA_UDAQPC_IPID GENMASK_ULL(47, 32)
 #define IRDMA_UDAQPC_SNDMSS GENMASK_ULL(29, 16)
 #define IRDMA_UDAQPC_VLANTAG GENMASK_ULL(15, 0)
-
-#define IRDMA_UDA_CQPSQ_MAV_PDINDEXHI GENMASK_ULL(21, 20)
+#define IRDMA_UDA_CQPSQ_MAV_PDINDEXHI GENMASK_ULL(27, 20)
 #define IRDMA_UDA_CQPSQ_MAV_PDINDEXLO GENMASK_ULL(63, 48)
 #define IRDMA_UDA_CQPSQ_MAV_SRCMACADDRINDEX GENMASK_ULL(29, 24)
 #define IRDMA_UDA_CQPSQ_MAV_ARPINDEX GENMASK_ULL(63, 48)
@@ -94,7 +93,7 @@
 #define IRDMA_UDA_CQPSQ_MAV_OPCODE GENMASK_ULL(37, 32)
 #define IRDMA_UDA_CQPSQ_MAV_DOLOOPBACKK BIT_ULL(62)
 #define IRDMA_UDA_CQPSQ_MAV_IPV4VALID BIT_ULL(59)
-#define IRDMA_UDA_CQPSQ_MAV_AVIDX GENMASK_ULL(16, 0)
+#define IRDMA_UDA_CQPSQ_MAV_AVIDX GENMASK_ULL(23, 0)
 #define IRDMA_UDA_CQPSQ_MAV_INSERTVLANTAG BIT_ULL(60)
 #define IRDMA_UDA_MGCTX_VFFLAG BIT_ULL(29)
 #define IRDMA_UDA_MGCTX_DESTPORT GENMASK_ULL(47, 32)
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index cf5a5d28fe53..b5fe5f2fa68b 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1162,6 +1162,7 @@ static int irdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		attr->pkey_index = iwqp->roce_info.p_key;
 		attr->retry_cnt = iwqp->udp_info.rexmit_thresh;
 		attr->rnr_retry = iwqp->udp_info.rnr_nak_thresh;
+		attr->min_rnr_timer = iwqp->udp_info.min_rnr_timer;
 		attr->max_rd_atomic = iwqp->roce_info.ord_size;
 		attr->max_dest_rd_atomic = iwqp->roce_info.ird_size;
 	}
@@ -1294,6 +1295,10 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (attr_mask & IB_QP_RNR_RETRY)
 		udp_info->rnr_nak_thresh = attr->rnr_retry;
 
+	if (attr_mask & IB_QP_MIN_RNR_TIMER &&
+	    dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+		udp_info->min_rnr_timer = attr->min_rnr_timer;
+
 	if (attr_mask & IB_QP_RETRY_CNT)
 		udp_info->rexmit_thresh = attr->retry_cnt;
 
-- 
2.37.3


