Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDB96C6306
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 10:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjCWJNZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCWJNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 05:13:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312F61E9F1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 02:13:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id dw14so7342676pfb.6
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 02:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1679562791;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hfUY3HU5rkyxMSY3RJQ+TA0FLs+oJZs0Ba7dCtEUyZg=;
        b=AJUM31X3Bcnl0UruI4NA2QXo3BRC/XzvLYOTrmhkvypODtNucd7rNqmcREl8WdSP5Y
         xrGYzKEZEMjO34ozZ4j+MJUupeT/27sfQFQmzwQCe8HgkYClk4vr8WUE+KKcMIZnedni
         x5lGLVckWUYnwC0QeI0Fbdag5ywQ+AhbG3GB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562791;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfUY3HU5rkyxMSY3RJQ+TA0FLs+oJZs0Ba7dCtEUyZg=;
        b=rGlxNJ0B5Vd/+BUIH59+6C1pZrjHCZZqjEmZ3uMP32inuy4KJhPKX/NoS90Fj+Pb82
         vocYtcfPzHJDBkmMIRLBFL1r3J9zAXU9T+MevAKXQ/nsSLxG6EvNYXMXwRu516w2jVLQ
         MOvw9bsGVQwrDZMfTJKgaty4LporlEC53EBU46tPCWr7ekxtMY4+4GBoOWb9i7eSPxmg
         hDOuX1owaWx+75nvYY9eRdndBW7B/u6WXRnY1M7etFM4n4nkGzZrFGQpvsIIsKYngpeD
         kZztBfhnwnPWVl0Dud8mKYve0xm92yWqkjqz3RQhMCDS2sWPB0O2h16jTO81Y2VkNvtc
         HIAA==
X-Gm-Message-State: AO0yUKXTj87PwMx78KF5T7tT2jHBV07vv2AwNu2bjDbaTh08+UUpFG5G
        ZyC7F/CnH05VioHgEfwgEPOSSQX6993dd3Cgmss=
X-Google-Smtp-Source: AK7set8GEVaBMmodWy2DxdjXPR3zKfc5kvuAKVbeifpoX51Hhv2aZMHsfqvFhUmUcSSSKGgfeNL6UA==
X-Received: by 2002:a62:2581:0:b0:626:6a3:6b81 with SMTP id l123-20020a622581000000b0062606a36b81mr5046811pfl.15.1679562791598;
        Thu, 23 Mar 2023 02:13:11 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l20-20020a62be14000000b00627e9ab34b3sm9055114pff.91.2023.03.23.02.13.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2023 02:13:10 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 7/7] RDMA/bnxt_re: Enable congestion control by default
Date:   Thu, 23 Mar 2023 02:12:19 -0700
Message-Id: <1679562739-24472-8-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1679562739-24472-1-git-send-email-selvin.xavier@broadcom.com>
References: <1679562739-24472-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009795c205f78daf4b"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_HEADER_CTYPE_ONLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_TVD_MIME_NO_HEADERS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000009795c205f78daf4b

Enable Congesion control by default. Issue FW command
enable the CC during driver load and disable it during
unload.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c       |  24 ++++++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  15 ++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  20 ++++--
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 109 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h   |  67 ++++++++++++++++++
 5 files changed, 222 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4aa3442..b9e2f89 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1332,6 +1332,27 @@ static int bnxt_re_add_device(struct auxiliary_device *adev, u8 wqe_mode)
 	return rc;
 }
 
+static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable)
+{
+	struct bnxt_qplib_cc_param cc_param = {};
+
+	/* Currently enabling only for GenP5 adapters */
+	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))
+		return;
+
+	if (enable) {
+		cc_param.enable  = 1;
+		cc_param.cc_mode = CMDQ_MODIFY_ROCE_CC_CC_MODE_PROBABILISTIC_CC_MODE;
+	}
+
+	cc_param.mask = (CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_CC_MODE |
+			 CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC |
+			 CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN);
+
+	if (bnxt_qplib_modify_cc(&rdev->qplib_res, &cc_param))
+		ibdev_err(&rdev->ibdev, "Failed to setup CC enable = %d\n", enable);
+}
+
 /*
  * "Notifier chain callback can be invoked for the same chain from
  * different CPUs at the same time".
@@ -1400,7 +1421,7 @@ static void bnxt_re_remove(struct auxiliary_device *adev)
 		 */
 		goto skip_remove;
 	}
-
+	bnxt_re_setup_cc(rdev, false);
 	ib_unregister_device(&rdev->ibdev);
 	ib_dealloc_device(&rdev->ibdev);
 	bnxt_re_dev_uninit(rdev);
@@ -1432,6 +1453,7 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 		goto err;
 	}
 
+	bnxt_re_setup_cc(rdev, true);
 	mutex_unlock(&bnxt_re_mutex);
 	return 0;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 06979f7..73f936c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -96,7 +96,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	u32 sw_prod, cmdq_prod;
 	struct pci_dev *pdev;
 	unsigned long flags;
-	u32 size, opcode;
+	u32 bsize, opcode;
 	u16 cookie, cbit;
 	u8 *preq;
 
@@ -145,15 +145,14 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 		return -EBUSY;
 	}
 
-	size = msg->req->cmd_size;
 	/* change the cmd_size to the number of 16byte cmdq unit.
 	 * req->cmd_size is modified here
 	 */
-	bnxt_qplib_set_cmd_slots(msg->req);
+	bsize = bnxt_qplib_set_cmd_slots(msg->req);
 
 	memset(msg->resp, 0, sizeof(*msg->resp));
 	crsqe->resp = (struct creq_qp_event *)msg->resp;
-	crsqe->resp->cookie = msg->req->cookie;
+	crsqe->resp->cookie = cookie;
 	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
 	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
 		struct bnxt_qplib_rcfw_sbuf *sbuf = msg->sb;
@@ -174,11 +173,11 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 		}
 		/* Copy a segment of the req cmd to the cmdq */
 		memset(cmdqe, 0, sizeof(*cmdqe));
-		memcpy(cmdqe, preq, min_t(u32, size, sizeof(*cmdqe)));
-		preq += min_t(u32, size, sizeof(*cmdqe));
-		size -= min_t(u32, size, sizeof(*cmdqe));
+		memcpy(cmdqe, preq, min_t(u32, bsize, sizeof(*cmdqe)));
+		preq += min_t(u32, bsize, sizeof(*cmdqe));
+		bsize -= min_t(u32, bsize, sizeof(*cmdqe));
 		hwq->prod++;
-	} while (size > 0);
+	} while (bsize > 0);
 	cmdq->seq_num++;
 
 	cmdq_prod = hwq->prod;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 5d619ce..dd56514 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -39,6 +39,8 @@
 #ifndef __BNXT_QPLIB_RCFW_H__
 #define __BNXT_QPLIB_RCFW_H__
 
+#include "qplib_tlv.h"
+
 #define RCFW_CMDQ_TRIG_VAL		1
 #define RCFW_COMM_PCI_BAR_REGION	0
 #define RCFW_COMM_CONS_PCI_BAR_REGION	2
@@ -87,11 +89,21 @@ static inline u32 bnxt_qplib_cmdqe_page_size(u32 depth)
 	return (bnxt_qplib_cmdqe_npages(depth) * PAGE_SIZE);
 }
 
-/* Set the cmd_size to a factor of CMDQE unit */
-static inline void bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
+static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 {
-	req->cmd_size = (req->cmd_size + BNXT_QPLIB_CMDQE_UNITS - 1) /
-			 BNXT_QPLIB_CMDQE_UNITS;
+	u32 cmd_byte = 0;
+
+	if (HAS_TLV_HEADER(req)) {
+		struct roce_tlv *tlv_req = (struct roce_tlv *)req;
+
+		cmd_byte = tlv_req->total_size * BNXT_QPLIB_CMDQE_UNITS;
+	} else {
+		cmd_byte = req->cmd_size;
+		req->cmd_size = (req->cmd_size + BNXT_QPLIB_CMDQE_UNITS - 1) /
+				 BNXT_QPLIB_CMDQE_UNITS;
+	}
+
+	return cmd_byte;
 }
 
 #define RCFW_MAX_COOKIE_VALUE		0x7FFF
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 54c26c5..b7331d4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -48,6 +48,7 @@
 #include "qplib_res.h"
 #include "qplib_rcfw.h"
 #include "qplib_sp.h"
+#include "qplib_tlv.h"
 
 const struct bnxt_qplib_gid bnxt_qplib_gid_zero = {{ 0, 0, 0, 0, 0, 0, 0, 0,
 						     0, 0, 0, 0, 0, 0, 0, 0 } };
@@ -849,3 +850,111 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
 	return rc;
 }
+
+void bnxt_qplib_fill_cc_gen1(struct cmdq_modify_roce_cc_gen1_tlv *ext_req,
+			     struct bnxt_qplib_cc_param_ext *cc_ext)
+{
+	ext_req->modify_mask = cpu_to_le64(cc_ext->ext_mask);
+	cc_ext->ext_mask = 0;
+	ext_req->inactivity_th_hi = cpu_to_le16(cc_ext->inact_th_hi);
+	ext_req->min_time_between_cnps = cpu_to_le16(cc_ext->min_delta_cnp);
+	ext_req->init_cp = cpu_to_le16(cc_ext->init_cp);
+	ext_req->tr_update_mode = cc_ext->tr_update_mode;
+	ext_req->tr_update_cycles = cc_ext->tr_update_cyls;
+	ext_req->fr_num_rtts = cc_ext->fr_rtt;
+	ext_req->ai_rate_increase = cc_ext->ai_rate_incr;
+	ext_req->reduction_relax_rtts_th = cpu_to_le16(cc_ext->rr_rtt_th);
+	ext_req->additional_relax_cr_th = cpu_to_le16(cc_ext->ar_cr_th);
+	ext_req->cr_min_th = cpu_to_le16(cc_ext->cr_min_th);
+	ext_req->bw_avg_weight = cc_ext->bw_avg_weight;
+	ext_req->actual_cr_factor = cc_ext->cr_factor;
+	ext_req->max_cp_cr_th = cpu_to_le16(cc_ext->cr_th_max_cp);
+	ext_req->cp_bias_en = cc_ext->cp_bias_en;
+	ext_req->cp_bias = cc_ext->cp_bias;
+	ext_req->cnp_ecn = cc_ext->cnp_ecn;
+	ext_req->rtt_jitter_en = cc_ext->rtt_jitter_en;
+	ext_req->link_bytes_per_usec = cpu_to_le16(cc_ext->bytes_per_usec);
+	ext_req->reset_cc_cr_th = cpu_to_le16(cc_ext->cc_cr_reset_th);
+	ext_req->cr_width = cc_ext->cr_width;
+	ext_req->quota_period_min = cc_ext->min_quota;
+	ext_req->quota_period_max = cc_ext->max_quota;
+	ext_req->quota_period_abs_max = cc_ext->abs_max_quota;
+	ext_req->tr_lower_bound = cpu_to_le16(cc_ext->tr_lb);
+	ext_req->cr_prob_factor = cc_ext->cr_prob_fac;
+	ext_req->tr_prob_factor = cc_ext->tr_prob_fac;
+	ext_req->fairness_cr_th = cpu_to_le16(cc_ext->fair_cr_th);
+	ext_req->red_div = cc_ext->red_div;
+	ext_req->cnp_ratio_th = cc_ext->cnp_ratio_th;
+	ext_req->exp_ai_rtts = cpu_to_le16(cc_ext->ai_ext_rtt);
+	ext_req->exp_ai_cr_cp_ratio = cc_ext->exp_crcp_ratio;
+	ext_req->use_rate_table = cc_ext->low_rate_en;
+	ext_req->cp_exp_update_th = cpu_to_le16(cc_ext->cpcr_update_th);
+	ext_req->high_exp_ai_rtts_th1 = cpu_to_le16(cc_ext->ai_rtt_th1);
+	ext_req->high_exp_ai_rtts_th2 = cpu_to_le16(cc_ext->ai_rtt_th2);
+	ext_req->actual_cr_cong_free_rtts_th = cpu_to_le16(cc_ext->cf_rtt_th);
+	ext_req->severe_cong_cr_th1 = cpu_to_le16(cc_ext->sc_cr_th1);
+	ext_req->severe_cong_cr_th2 = cpu_to_le16(cc_ext->sc_cr_th2);
+	ext_req->link64B_per_rtt = cpu_to_le32(cc_ext->l64B_per_rtt);
+	ext_req->cc_ack_bytes = cc_ext->cc_ack_bytes;
+}
+
+int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
+			 struct bnxt_qplib_cc_param *cc_param)
+{
+	struct bnxt_qplib_tlv_modify_cc_req tlv_req = {};
+	struct creq_modify_roce_cc_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_modify_roce_cc *req;
+	int req_size;
+	void *cmd;
+	int rc;
+
+	/* Prepare the older base command */
+	req = &tlv_req.base_req;
+	cmd = req;
+	req_size = sizeof(*req);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)req, CMDQ_BASE_OPCODE_MODIFY_ROCE_CC,
+				 sizeof(*req));
+	req->modify_mask = cpu_to_le32(cc_param->mask);
+	req->enable_cc = cc_param->enable;
+	req->g = cc_param->g;
+	req->num_phases_per_state = cc_param->nph_per_state;
+	req->time_per_phase = cc_param->time_pph;
+	req->pkts_per_phase = cc_param->pkts_pph;
+	req->init_cr = cpu_to_le16(cc_param->init_cr);
+	req->init_tr = cpu_to_le16(cc_param->init_tr);
+	req->tos_dscp_tos_ecn = (cc_param->tos_dscp << CMDQ_MODIFY_ROCE_CC_TOS_DSCP_SFT) |
+				(cc_param->tos_ecn & CMDQ_MODIFY_ROCE_CC_TOS_ECN_MASK);
+	req->alt_vlan_pcp = cc_param->alt_vlan_pcp;
+	req->alt_tos_dscp = cpu_to_le16(cc_param->alt_tos_dscp);
+	req->rtt = cpu_to_le16(cc_param->rtt);
+	req->tcp_cp = cpu_to_le16(cc_param->tcp_cp);
+	req->cc_mode = cc_param->cc_mode;
+	req->inactivity_th = cpu_to_le16(cc_param->inact_th);
+
+	/* For chip gen P5 onwards fill extended cmd and header */
+	if (bnxt_qplib_is_chip_gen_p5(res->cctx)) {
+		struct roce_tlv *hdr;
+		u32 payload;
+		u32 chunks;
+
+		cmd = &tlv_req;
+		req_size = sizeof(tlv_req);
+		/* Prepare primary tlv header */
+		hdr = &tlv_req.tlv_hdr;
+		chunks = CHUNKS(sizeof(struct bnxt_qplib_tlv_modify_cc_req));
+		payload = sizeof(struct cmdq_modify_roce_cc);
+		__roce_1st_tlv_prep(hdr, chunks, payload, true);
+		/* Prepare secondary tlv header */
+		hdr = (struct roce_tlv *)&tlv_req.ext_req;
+		payload = sizeof(struct cmdq_modify_roce_cc_gen1_tlv) -
+			  sizeof(struct roce_tlv);
+		__roce_ext_tlv_prep(hdr, TLV_TYPE_MODIFY_ROCE_CC_GEN1, payload, false, true);
+		bnxt_qplib_fill_cc_gen1(&tlv_req.ext_req, &cc_param->cc_ext);
+	}
+
+	bnxt_qplib_fill_cmdqmsg(&msg, cmd, &resp, NULL, req_size,
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(res->rcfw, &msg);
+	return rc;
+}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 96e61db..5de87465 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -244,6 +244,71 @@ struct bnxt_qplib_ext_stat {
 	u64  rx_ecn_marked;
 };
 
+struct bnxt_qplib_cc_param_ext {
+	u64 ext_mask;
+	u16 inact_th_hi;
+	u16 min_delta_cnp;
+	u16 init_cp;
+	u8 tr_update_mode;
+	u8 tr_update_cyls;
+	u8 fr_rtt;
+	u8 ai_rate_incr;
+	u16 rr_rtt_th;
+	u16 ar_cr_th;
+	u16 cr_min_th;
+	u8 bw_avg_weight;
+	u8 cr_factor;
+	u16 cr_th_max_cp;
+	u8 cp_bias_en;
+	u8 cp_bias;
+	u8 cnp_ecn;
+	u8 rtt_jitter_en;
+	u16 bytes_per_usec;
+	u16 cc_cr_reset_th;
+	u8 cr_width;
+	u8 min_quota;
+	u8 max_quota;
+	u8 abs_max_quota;
+	u16 tr_lb;
+	u8 cr_prob_fac;
+	u8 tr_prob_fac;
+	u16 fair_cr_th;
+	u8 red_div;
+	u8 cnp_ratio_th;
+	u16 ai_ext_rtt;
+	u8 exp_crcp_ratio;
+	u8 low_rate_en;
+	u16 cpcr_update_th;
+	u16 ai_rtt_th1;
+	u16 ai_rtt_th2;
+	u16 cf_rtt_th;
+	u16 sc_cr_th1; /* severe congestion cr threshold 1 */
+	u16 sc_cr_th2; /* severe congestion cr threshold 2 */
+	u32 l64B_per_rtt;
+	u8 cc_ack_bytes;
+	u16 reduce_cf_rtt_th;
+};
+
+struct bnxt_qplib_cc_param {
+	u8 alt_vlan_pcp;
+	u16 alt_tos_dscp;
+	u8 cc_mode;
+	u8 enable;
+	u16 inact_th;
+	u16 init_cr;
+	u16 init_tr;
+	u16 rtt;
+	u8 g;
+	u8 nph_per_state;
+	u8 time_pph;
+	u8 pkts_pph;
+	u8 tos_ecn;
+	u8 tos_dscp;
+	u16 tcp_cp;
+	struct bnxt_qplib_cc_param_ext cc_ext;
+	u32 mask;
+};
+
 int bnxt_qplib_get_sgid(struct bnxt_qplib_res *res,
 			struct bnxt_qplib_sgid_tbl *sgid_tbl, int index,
 			struct bnxt_qplib_gid *gid);
@@ -281,5 +346,7 @@ int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 			      struct bnxt_qplib_roce_stats *stats);
 int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 			 struct bnxt_qplib_ext_stat *estat);
+int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
+			 struct bnxt_qplib_cc_param *cc_param);
 
 #endif /* __BNXT_QPLIB_SP_H__*/
-- 
2.5.5


--0000000000009795c205f78daf4b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIJR5EH98Xn2
UX/UrhsxAxzwuK8xG9vZ3ekR4E81ehXdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDMyMzA5MTMxMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB4Y57Qj3ijEDs7jTQb8MfRXelJr97Q
lIfjWiKZqZqx89dx7Bbg8vAyNddR1Ogx5jnYOn1f0qFBJXN4zTDgtZcIVLNbBwEYS5dKWlhNMFL/
P5tC5g1biQGz2/aObvyibW8mjrpfuYJL5X59DhiM0FCZ9qrWpk2+UBbWh1IN19mGzLCz94F3cMse
xQg34hszKV/4FcVSlKMBmK9JDnu/Ogywu4vXwQEKD7bM/UeVWCYPtD62Qh8WjoAPq7Snpl5kNtGE
pOQeu+nUVEpcv0zTYoDzcKj1qUjl2znlpkfJARlWZKnz9dhVCdaU5+AA2t/FjSZrcaxWy7VnH5zO
k6Ixib0D
--0000000000009795c205f78daf4b--
