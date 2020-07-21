Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A720F2280E7
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgGUN3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 09:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgGUN3X (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Jul 2020 09:29:23 -0400
Received: from embeddedor (unknown [201.162.241.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4D8A206E9;
        Tue, 21 Jul 2020 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595338161;
        bh=B0iI9iQyyno3YPahqo325GVLnU4ASXnyG0FoNKp0hgs=;
        h=Date:From:To:Cc:Subject:From;
        b=fgUH2VZYppVbigZ0C+/LHEdKPvJjl6wmwtCHjappJwVUibosFW10N0NlKIIt67wT0
         CAg4noP3gfCjzl+7bYvWMeWcJT57c+LulKPwJ10Ua4ia1lmfM1P8Qxk7nv0IiKlIzc
         a4fijjFMu4mNX5wNIbLjBwaXyv0DKFwNe+YP8J9Q=
Date:   Tue, 21 Jul 2020 08:34:55 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v2][next] IB/hfi1: Use fallthrough pseudo-keyword
Message-ID: <20200721133455.GA14363@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/v5.7-rc7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Address fall-through markings in drivers/infiniband/hw/hfi1/chip.c
   in a separate patch[2].

   [2] https://lore.kernel.org/lkml/20200709235250.GA26678@embeddedor/

 drivers/infiniband/hw/hfi1/firmware.c | 16 ----------------
 drivers/infiniband/hw/hfi1/mad.c      |  9 ++++-----
 drivers/infiniband/hw/hfi1/pio.c      |  2 +-
 drivers/infiniband/hw/hfi1/pio_copy.c | 12 ++++++------
 drivers/infiniband/hw/hfi1/platform.c | 10 +++++-----
 drivers/infiniband/hw/hfi1/qp.c       |  2 +-
 drivers/infiniband/hw/hfi1/qsfp.c     |  4 ++--
 drivers/infiniband/hw/hfi1/rc.c       | 25 ++++++++++++-------------
 drivers/infiniband/hw/hfi1/sdma.c     |  9 ++++-----
 drivers/infiniband/hw/hfi1/tid_rdma.c |  4 ++--
 drivers/infiniband/hw/hfi1/uc.c       |  8 ++++----
 11 files changed, 41 insertions(+), 60 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/firmware.c b/drivers/infiniband/hw/hfi1/firmware.c
index 2b57ba70ddd6..0e83d4b61e46 100644
--- a/drivers/infiniband/hw/hfi1/firmware.c
+++ b/drivers/infiniband/hw/hfi1/firmware.c
@@ -1868,11 +1868,8 @@ int parse_platform_config(struct hfi1_devdata *dd)
 									2;
 				break;
 			case PLATFORM_CONFIG_RX_PRESET_TABLE:
-				/* fall through */
 			case PLATFORM_CONFIG_TX_PRESET_TABLE:
-				/* fall through */
 			case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
-				/* fall through */
 			case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
 				pcfgcache->config_tables[table_type].num_table =
 							table_length_dwords;
@@ -1890,15 +1887,10 @@ int parse_platform_config(struct hfi1_devdata *dd)
 			/* metadata table */
 			switch (table_type) {
 			case PLATFORM_CONFIG_SYSTEM_TABLE:
-				/* fall through */
 			case PLATFORM_CONFIG_PORT_TABLE:
-				/* fall through */
 			case PLATFORM_CONFIG_RX_PRESET_TABLE:
-				/* fall through */
 			case PLATFORM_CONFIG_TX_PRESET_TABLE:
-				/* fall through */
 			case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
-				/* fall through */
 			case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
 				break;
 			default:
@@ -2027,15 +2019,10 @@ static int get_platform_fw_field_metadata(struct hfi1_devdata *dd, int table,
 
 	switch (table) {
 	case PLATFORM_CONFIG_SYSTEM_TABLE:
-		/* fall through */
 	case PLATFORM_CONFIG_PORT_TABLE:
-		/* fall through */
 	case PLATFORM_CONFIG_RX_PRESET_TABLE:
-		/* fall through */
 	case PLATFORM_CONFIG_TX_PRESET_TABLE:
-		/* fall through */
 	case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
-		/* fall through */
 	case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
 		if (field && field < platform_config_table_limits[table])
 			src_ptr =
@@ -2138,11 +2125,8 @@ int get_platform_config_field(struct hfi1_devdata *dd,
 			pcfgcache->config_tables[table_type].table;
 		break;
 	case PLATFORM_CONFIG_RX_PRESET_TABLE:
-		/* fall through */
 	case PLATFORM_CONFIG_TX_PRESET_TABLE:
-		/* fall through */
 	case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
-		/* fall through */
 	case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
 		src_ptr = pcfgcache->config_tables[table_type].table;
 
diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index 7073f237a949..3222e3acb79c 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -721,7 +721,7 @@ static int check_mkey(struct hfi1_ibport *ibp, struct ib_mad_hdr *mad,
 			/* Bad mkey not a violation below level 2 */
 			if (ibp->rvp.mkeyprot < 2)
 				break;
-			/* fall through */
+			fallthrough;
 		case IB_MGMT_METHOD_SET:
 		case IB_MGMT_METHOD_TRAP_REPRESS:
 			if (ibp->rvp.mkey_violations != 0xFFFF)
@@ -1272,7 +1272,7 @@ static int set_port_states(struct hfi1_pportdata *ppd, struct opa_smp *smp,
 	case IB_PORT_NOP:
 		if (phys_state == IB_PORTPHYSSTATE_NOP)
 			break;
-		/* FALLTHROUGH */
+		fallthrough;
 	case IB_PORT_DOWN:
 		if (phys_state == IB_PORTPHYSSTATE_NOP) {
 			link_state = HLS_DN_DOWNDEF;
@@ -2300,7 +2300,6 @@ static int __subn_set_opa_vl_arb(struct opa_smp *smp, u32 am, u8 *data,
 	 * can be changed from the default values
 	 */
 	case OPA_VLARB_PREEMPT_ELEMENTS:
-		/* FALLTHROUGH */
 	case OPA_VLARB_PREEMPT_MATRIX:
 		smp->status |= IB_SMP_UNSUP_METH_ATTR;
 		break;
@@ -4170,7 +4169,7 @@ static int subn_get_opa_sma(__be16 attr_id, struct opa_smp *smp, u32 am,
 			return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
 		if (ibp->rvp.port_cap_flags & IB_PORT_SM)
 			return IB_MAD_RESULT_SUCCESS;
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		smp->status |= IB_SMP_UNSUP_METH_ATTR;
 		ret = reply((struct ib_mad_hdr *)smp);
@@ -4240,7 +4239,7 @@ static int subn_set_opa_sma(__be16 attr_id, struct opa_smp *smp, u32 am,
 			return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
 		if (ibp->rvp.port_cap_flags & IB_PORT_SM)
 			return IB_MAD_RESULT_SUCCESS;
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		smp->status |= IB_SMP_UNSUP_METH_ATTR;
 		ret = reply((struct ib_mad_hdr *)smp);
diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 79126b2b14ab..ff864f6f0266 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -86,7 +86,7 @@ void pio_send_control(struct hfi1_devdata *dd, int op)
 	switch (op) {
 	case PSC_GLOBAL_ENABLE:
 		reg |= SEND_CTRL_SEND_ENABLE_SMASK;
-	/* Fall through */
+		fallthrough;
 	case PSC_DATA_VL_ENABLE:
 		mask = 0;
 		for (i = 0; i < ARRAY_SIZE(dd->vld); i++)
diff --git a/drivers/infiniband/hw/hfi1/pio_copy.c b/drivers/infiniband/hw/hfi1/pio_copy.c
index 03024cec78dd..b12e4665c9ab 100644
--- a/drivers/infiniband/hw/hfi1/pio_copy.c
+++ b/drivers/infiniband/hw/hfi1/pio_copy.c
@@ -191,22 +191,22 @@ static inline void jcopy(u8 *dest, const u8 *src, u32 n)
 	switch (n) {
 	case 7:
 		*dest++ = *src++;
-		/* fall through */
+		fallthrough;
 	case 6:
 		*dest++ = *src++;
-		/* fall through */
+		fallthrough;
 	case 5:
 		*dest++ = *src++;
-		/* fall through */
+		fallthrough;
 	case 4:
 		*dest++ = *src++;
-		/* fall through */
+		fallthrough;
 	case 3:
 		*dest++ = *src++;
-		/* fall through */
+		fallthrough;
 	case 2:
 		*dest++ = *src++;
-		/* fall through */
+		fallthrough;
 	case 1:
 		*dest++ = *src++;
 		/* fall through */
diff --git a/drivers/infiniband/hw/hfi1/platform.c b/drivers/infiniband/hw/hfi1/platform.c
index 36593f2efe26..4642d6ceb890 100644
--- a/drivers/infiniband/hw/hfi1/platform.c
+++ b/drivers/infiniband/hw/hfi1/platform.c
@@ -668,8 +668,8 @@ static u8 aoc_low_power_setting(struct hfi1_pportdata *ppd)
 
 	/* active optical cables only */
 	switch ((cache[QSFP_MOD_TECH_OFFS] & 0xF0) >> 4) {
-	case 0x0 ... 0x9: /* fallthrough */
-	case 0xC: /* fallthrough */
+	case 0x0 ... 0x9: fallthrough;
+	case 0xC: fallthrough;
 	case 0xE:
 		/* active AOC */
 		power_class = get_qsfp_power_class(cache[QSFP_MOD_PWR_OFFS]);
@@ -899,8 +899,8 @@ static int tune_qsfp(struct hfi1_pportdata *ppd,
 
 		*ptr_tuning_method = OPA_PASSIVE_TUNING;
 		break;
-	case 0x0 ... 0x9: /* fallthrough */
-	case 0xC: /* fallthrough */
+	case 0x0 ... 0x9: fallthrough;
+	case 0xC: fallthrough;
 	case 0xE:
 		ret = tune_active_qsfp(ppd, ptr_tx_preset, ptr_rx_preset,
 				       ptr_total_atten);
@@ -909,7 +909,7 @@ static int tune_qsfp(struct hfi1_pportdata *ppd,
 
 		*ptr_tuning_method = OPA_ACTIVE_TUNING;
 		break;
-	case 0xD: /* fallthrough */
+	case 0xD: fallthrough;
 	case 0xF:
 	default:
 		dd_dev_warn(ppd->dd, "%s: Unknown/unsupported cable\n",
diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index be62284e42d9..356518e17fa6 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -312,7 +312,7 @@ int hfi1_setup_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe, bool *call_send)
 	switch (qp->ibqp.qp_type) {
 	case IB_QPT_RC:
 		hfi1_setup_tid_rdma_wqe(qp, wqe);
-		/* fall through */
+		fallthrough;
 	case IB_QPT_UC:
 		if (wqe->length > 0x80000000U)
 			return -EINVAL;
diff --git a/drivers/infiniband/hw/hfi1/qsfp.c b/drivers/infiniband/hw/hfi1/qsfp.c
index b5966991d647..8386c84c2d92 100644
--- a/drivers/infiniband/hw/hfi1/qsfp.c
+++ b/drivers/infiniband/hw/hfi1/qsfp.c
@@ -231,7 +231,7 @@ static int i2c_bus_write(struct hfi1_devdata *dd, struct hfi1_i2c_bus *i2c,
 		break;
 	case 2:
 		offset_bytes[1] = (offset >> 8) & 0xff;
-		/* fall through */
+		fallthrough;
 	case 1:
 		num_msgs = 2;
 		offset_bytes[0] = offset & 0xff;
@@ -279,7 +279,7 @@ static int i2c_bus_read(struct hfi1_devdata *dd, struct hfi1_i2c_bus *bus,
 		break;
 	case 2:
 		offset_bytes[1] = (offset >> 8) & 0xff;
-		/* fall through */
+		fallthrough;
 	case 1:
 		num_msgs = 2;
 		offset_bytes[0] = offset & 0xff;
diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index f1734e5e9ac4..1bb5f57152d3 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -141,7 +141,7 @@ static int make_rc_ack(struct hfi1_ibdev *dev, struct rvt_qp *qp,
 	case OP(RDMA_READ_RESPONSE_ONLY):
 		e = &qp->s_ack_queue[qp->s_tail_ack_queue];
 		release_rdma_sge_mr(e);
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(ATOMIC_ACKNOWLEDGE):
 		/*
 		 * We can increment the tail pointer now that the last
@@ -160,7 +160,7 @@ static int make_rc_ack(struct hfi1_ibdev *dev, struct rvt_qp *qp,
 			qp->s_acked_ack_queue = next;
 		qp->s_tail_ack_queue = next;
 		trace_hfi1_rsp_make_rc_ack(qp, e->psn);
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(SEND_ONLY):
 	case OP(ACKNOWLEDGE):
 		/* Check for no next entry in the queue. */
@@ -267,7 +267,7 @@ static int make_rc_ack(struct hfi1_ibdev *dev, struct rvt_qp *qp,
 
 	case OP(RDMA_READ_RESPONSE_FIRST):
 		qp->s_ack_state = OP(RDMA_READ_RESPONSE_MIDDLE);
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(RDMA_READ_RESPONSE_MIDDLE):
 		ps->s_txreq->ss = &qp->s_ack_rdma_sge;
 		ps->s_txreq->mr = qp->s_ack_rdma_sge.sge.mr;
@@ -881,8 +881,7 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 				goto bail;
 			}
 			qp->s_num_rd_atomic++;
-
-			/* FALLTHROUGH */
+			fallthrough;
 		case IB_WR_OPFN:
 			if (newreq && !(qp->s_flags & RVT_S_UNLIMITED_CREDIT))
 				qp->s_lsn++;
@@ -946,10 +945,10 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 		 * See restart_rc().
 		 */
 		qp->s_len = restart_sge(&qp->s_sge, wqe, qp->s_psn, pmtu);
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(SEND_FIRST):
 		qp->s_state = OP(SEND_MIDDLE);
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(SEND_MIDDLE):
 		bth2 = mask_psn(qp->s_psn++);
 		ss = &qp->s_sge;
@@ -991,10 +990,10 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 		 * See restart_rc().
 		 */
 		qp->s_len = restart_sge(&qp->s_sge, wqe, qp->s_psn, pmtu);
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(RDMA_WRITE_FIRST):
 		qp->s_state = OP(RDMA_WRITE_MIDDLE);
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(RDMA_WRITE_MIDDLE):
 		bth2 = mask_psn(qp->s_psn++);
 		ss = &qp->s_sge;
@@ -2901,7 +2900,7 @@ void hfi1_rc_rcv(struct hfi1_packet *packet)
 		if (!ret)
 			goto rnr_nak;
 		qp->r_rcv_len = 0;
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(SEND_MIDDLE):
 	case OP(RDMA_WRITE_MIDDLE):
 send_middle:
@@ -2941,7 +2940,7 @@ void hfi1_rc_rcv(struct hfi1_packet *packet)
 			goto no_immediate_data;
 		if (opcode == OP(SEND_ONLY_WITH_INVALIDATE))
 			goto send_last_inv;
-		/* FALLTHROUGH -- for SEND_ONLY_WITH_IMMEDIATE */
+		fallthrough;	/* for SEND_ONLY_WITH_IMMEDIATE */
 	case OP(SEND_LAST_WITH_IMMEDIATE):
 send_last_imm:
 		wc.ex.imm_data = ohdr->u.imm_data;
@@ -2957,7 +2956,7 @@ void hfi1_rc_rcv(struct hfi1_packet *packet)
 		goto send_last;
 	case OP(RDMA_WRITE_LAST):
 		copy_last = rvt_is_user_qp(qp);
-		/* fall through */
+		fallthrough;
 	case OP(SEND_LAST):
 no_immediate_data:
 		wc.wc_flags = 0;
@@ -3010,7 +3009,7 @@ void hfi1_rc_rcv(struct hfi1_packet *packet)
 
 	case OP(RDMA_WRITE_ONLY):
 		copy_last = rvt_is_user_qp(qp);
-		/* fall through */
+		fallthrough;
 	case OP(RDMA_WRITE_FIRST):
 	case OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE):
 		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_WRITE)))
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index c93ea021cf49..04575c9afd61 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -2584,7 +2584,7 @@ static void __sdma_process_event(struct sdma_engine *sde,
 			 * 7220, e.g.
 			 */
 			ss->go_s99_running = 1;
-			/* fall through -- and start dma engine */
+			fallthrough;	/* and start dma engine */
 		case sdma_event_e10_go_hw_start:
 			/* This reference means the state machine is started */
 			sdma_get(&sde->state);
@@ -2726,7 +2726,6 @@ static void __sdma_process_event(struct sdma_engine *sde,
 		case sdma_event_e70_go_idle:
 			break;
 		case sdma_event_e85_link_down:
-			/* fall through */
 		case sdma_event_e80_hw_freeze:
 			sdma_set_state(sde, sdma_state_s80_hw_freeze);
 			atomic_dec(&sde->dd->sdma_unfreeze_count);
@@ -3007,7 +3006,7 @@ static void __sdma_process_event(struct sdma_engine *sde,
 		case sdma_event_e60_hw_halted:
 			need_progress = 1;
 			sdma_err_progress_check_schedule(sde);
-			/* fall through */
+			fallthrough;
 		case sdma_event_e90_sw_halted:
 			/*
 			* SW initiated halt does not perform engines
@@ -3021,7 +3020,7 @@ static void __sdma_process_event(struct sdma_engine *sde,
 			break;
 		case sdma_event_e85_link_down:
 			ss->go_s99_running = 0;
-			/* fall through */
+			fallthrough;
 		case sdma_event_e80_hw_freeze:
 			sdma_set_state(sde, sdma_state_s80_hw_freeze);
 			atomic_dec(&sde->dd->sdma_unfreeze_count);
@@ -3252,7 +3251,7 @@ void _sdma_txreq_ahgadd(
 		tx->num_desc++;
 		tx->descs[2].qw[0] = 0;
 		tx->descs[2].qw[1] = 0;
-		/* FALLTHROUGH */
+		fallthrough;
 	case SDMA_AHG_APPLY_UPDATE2:
 		tx->num_desc++;
 		tx->descs[1].qw[0] = 0;
diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index facff133139a..9af82ff933d7 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -3227,7 +3227,7 @@ bool hfi1_tid_rdma_wqe_interlock(struct rvt_qp *qp, struct rvt_swqe *wqe)
 	case IB_WR_RDMA_READ:
 		if (prev->wr.opcode != IB_WR_TID_RDMA_WRITE)
 			break;
-		/* fall through */
+		fallthrough;
 	case IB_WR_TID_RDMA_READ:
 		switch (prev->wr.opcode) {
 		case IB_WR_RDMA_READ:
@@ -5067,7 +5067,7 @@ int hfi1_make_tid_rdma_pkt(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 		if (priv->s_state == TID_OP(WRITE_REQ))
 			hfi1_tid_rdma_restart_req(qp, wqe, &bth2);
 		priv->s_state = TID_OP(WRITE_DATA);
-		/* fall through */
+		fallthrough;
 
 	case TID_OP(WRITE_DATA):
 		/*
diff --git a/drivers/infiniband/hw/hfi1/uc.c b/drivers/infiniband/hw/hfi1/uc.c
index 0c77f18120ed..1fb918399da0 100644
--- a/drivers/infiniband/hw/hfi1/uc.c
+++ b/drivers/infiniband/hw/hfi1/uc.c
@@ -216,7 +216,7 @@ int hfi1_make_uc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 
 	case OP(SEND_FIRST):
 		qp->s_state = OP(SEND_MIDDLE);
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(SEND_MIDDLE):
 		len = qp->s_len;
 		if (len > pmtu) {
@@ -241,7 +241,7 @@ int hfi1_make_uc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 
 	case OP(RDMA_WRITE_FIRST):
 		qp->s_state = OP(RDMA_WRITE_MIDDLE);
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(RDMA_WRITE_MIDDLE):
 		len = qp->s_len;
 		if (len > pmtu) {
@@ -414,7 +414,7 @@ void hfi1_uc_rcv(struct hfi1_packet *packet)
 			goto no_immediate_data;
 		else if (opcode == OP(SEND_ONLY_WITH_IMMEDIATE))
 			goto send_last_imm;
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(SEND_MIDDLE):
 		/* Check for invalid length PMTU or posted rwqe len. */
 		/*
@@ -515,7 +515,7 @@ void hfi1_uc_rcv(struct hfi1_packet *packet)
 			wc.ex.imm_data = ohdr->u.rc.imm_data;
 			goto rdma_last_imm;
 		}
-		/* FALLTHROUGH */
+		fallthrough;
 	case OP(RDMA_WRITE_MIDDLE):
 		/* Check for invalid length PMTU or posted rwqe len. */
 		if (unlikely(tlen != (hdrsize + pmtu + 4)))
-- 
2.27.0

