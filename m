Return-Path: <linux-rdma+bounces-4722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6D4969C76
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406541C210C2
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126D81B9832;
	Tue,  3 Sep 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gkmlGRSD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272351A42B8
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364308; cv=none; b=OpWiFb80RAzzFr8moFMkdswjLPm6xpwFTsRzZjTZKREw1ZGpmV+wWOLbjyJcBRH5egelPE8uA0625v96nexotOdwwIvVNtjGd9vPezMpSg/cOlLCBUYhZbrFzydNpAFnV1m4KPYNY9xfbhT1jUUGjxAotxmmGnj5T/7ZUH5kUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364308; c=relaxed/simple;
	bh=eeFkvsWCFj9CulCMb250nTwQKssn4cLid1MdTs5VOEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dKSJuiKSwfXNXT8hcT6bnMtRlgTaHcGTAZDSZf+QNtT8V1TuhD92MLznWYdJ+wAnDwFRWi5b/wAIhO5sQgezaBbkclx//C8BrF4Bohs38wbxt20O79tBgP/E1rJ+vAS5vcP12gNDLjDU6LmoT60UeyE3f0PUGAiYVuZkXHbc3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gkmlGRSD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-715abede256so3852908b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2024 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725364306; x=1725969106; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gykbGxMwBTpqijbxKO0CH56Y9XcrkI4PmwREMGbvwwM=;
        b=gkmlGRSDFslChZGn7HCf278edjdbhcY27Y1eHO0VMGhreVx5G4A5ZMdLyKe84w497l
         b3l/lV6GenTBA+/8kvpfR/OOyRmjfYV1irMP8+XDP6LJrIp4746Mn9GLr/u7GfpKjVcy
         O98yeZM2QabVAxQI26E2gNjuFWWAJjZlOZELs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364306; x=1725969106;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gykbGxMwBTpqijbxKO0CH56Y9XcrkI4PmwREMGbvwwM=;
        b=QSYTcSh2dk1BvjLhshZXIGLSZupXmObQV1cFd55ohMYOFY17czErHxL7zUbDNwRWIZ
         tbAW6J+s61KFX77PVScIPBwabKHwN6WvVNIdbVXaAG6zeIV01l8x6tqG74fyy1898GzQ
         gpvoZwjAoPtGCIqRK2rSYcMx92ombefh+T/ZneI3zUupdbK6MUru7064HnSLtS4KEVhg
         NaH8srPOjDp5BRuHCidurXoLp8LJ+oqzN7Aq4zToVrE8A2aSlfxpheHtZ+rImOCDrePR
         /cmxVPyUi/cFkG+rnTnFJr2oUVbpEan+QlVG0leRhdq50mK4VUGdeIhz2ecur9XcBzG6
         vaxQ==
X-Gm-Message-State: AOJu0YxQ7BvBChH5f2aZDOZYLr7DyfR6BLYIfYkpZm8/8mVtigy2tTKK
	JjUliO9sGUHWioCfBOjZFSCYfknh47X/V2n4JIN+3hsvK99/bTJk1DvO2jZ6VA==
X-Google-Smtp-Source: AGHT+IFaWJctarjPQUZkttcPwNLEc/yuUR2tX15G1dBVlet7b+8+sTK1AH4qZHn2bPvCSmMnClCOIg==
X-Received: by 2002:a05:6a21:1798:b0:1c6:a777:4cfa with SMTP id adf61e73a8af0-1ced6087abcmr8819287637.13.1725364306209;
        Tue, 03 Sep 2024 04:51:46 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20532b81016sm62077335ad.226.2024.09.03.04.51.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:51:45 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/4] RDMA/bnxt_re: Query firmware defaults of CC params during probe
Date: Tue,  3 Sep 2024 04:30:49 -0700
Message-Id: <1725363051-19268-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Added function to query firmware default values of CC parameters
during driver init. These values will be stored in driver local
structures and used in subsequent patches.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   1 +
 drivers/infiniband/hw/bnxt_re/main.c     |   5 ++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 113 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |   2 +
 4 files changed, 121 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b2ed557..7149bd0 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -199,6 +199,7 @@ struct bnxt_re_dev {
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
 	unsigned long			event_bitmap;
+	struct bnxt_qplib_cc_param	cc_param;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 0f86a34..541b8f9 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1803,6 +1803,11 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 	set_bit(BNXT_RE_FLAG_RESOURCES_INITIALIZED, &rdev->flags);
 
 	if (!rdev->is_virtfn) {
+		/* Query f/w defaults of CC params */
+		rc = bnxt_qplib_query_cc_param(&rdev->qplib_res, &rdev->cc_param);
+		if (rc)
+			ibdev_warn(&rdev->ibdev, "Failed to query CC defaults\n");
+
 		rc = bnxt_re_setup_qos(rdev);
 		if (rc)
 			ibdev_info(&rdev->ibdev,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 4f75e7e..388d889 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -972,3 +972,116 @@ int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 	rc = bnxt_qplib_rcfw_send_message(res->rcfw, &msg);
 	return rc;
 }
+
+static void bnxt_qplib_read_cc_gen1(struct bnxt_qplib_cc_param_ext *cc_ext,
+				    struct creq_query_roce_cc_gen1_resp_sb_tlv *sb)
+{
+	cc_ext->inact_th_hi = le16_to_cpu(sb->inactivity_th_hi);
+	cc_ext->min_delta_cnp = le16_to_cpu(sb->min_time_between_cnps);
+	cc_ext->init_cp = le16_to_cpu(sb->init_cp);
+	cc_ext->tr_update_mode = sb->tr_update_mode;
+	cc_ext->tr_update_cyls = sb->tr_update_cycles;
+	cc_ext->fr_rtt = sb->fr_num_rtts;
+	cc_ext->ai_rate_incr = sb->ai_rate_increase;
+	cc_ext->rr_rtt_th = le16_to_cpu(sb->reduction_relax_rtts_th);
+	cc_ext->ar_cr_th = le16_to_cpu(sb->additional_relax_cr_th);
+	cc_ext->cr_min_th = le16_to_cpu(sb->cr_min_th);
+	cc_ext->bw_avg_weight = sb->bw_avg_weight;
+	cc_ext->cr_factor = sb->actual_cr_factor;
+	cc_ext->cr_th_max_cp = le16_to_cpu(sb->max_cp_cr_th);
+	cc_ext->cp_bias_en = sb->cp_bias_en;
+	cc_ext->cp_bias = sb->cp_bias;
+	cc_ext->cnp_ecn = sb->cnp_ecn;
+	cc_ext->rtt_jitter_en = sb->rtt_jitter_en;
+	cc_ext->bytes_per_usec = le16_to_cpu(sb->link_bytes_per_usec);
+	cc_ext->cc_cr_reset_th = le16_to_cpu(sb->reset_cc_cr_th);
+	cc_ext->cr_width = sb->cr_width;
+	cc_ext->min_quota = sb->quota_period_min;
+	cc_ext->max_quota = sb->quota_period_max;
+	cc_ext->abs_max_quota = sb->quota_period_abs_max;
+	cc_ext->tr_lb = le16_to_cpu(sb->tr_lower_bound);
+	cc_ext->cr_prob_fac = sb->cr_prob_factor;
+	cc_ext->tr_prob_fac = sb->tr_prob_factor;
+	cc_ext->fair_cr_th = le16_to_cpu(sb->fairness_cr_th);
+	cc_ext->red_div = sb->red_div;
+	cc_ext->cnp_ratio_th = sb->cnp_ratio_th;
+	cc_ext->ai_ext_rtt = le16_to_cpu(sb->exp_ai_rtts);
+	cc_ext->exp_crcp_ratio = sb->exp_ai_cr_cp_ratio;
+	cc_ext->low_rate_en = sb->use_rate_table;
+	cc_ext->cpcr_update_th = le16_to_cpu(sb->cp_exp_update_th);
+	cc_ext->ai_rtt_th1 = le16_to_cpu(sb->high_exp_ai_rtts_th1);
+	cc_ext->ai_rtt_th2 = le16_to_cpu(sb->high_exp_ai_rtts_th2);
+	cc_ext->cf_rtt_th = le16_to_cpu(sb->actual_cr_cong_free_rtts_th);
+	cc_ext->sc_cr_th1 = le16_to_cpu(sb->severe_cong_cr_th1);
+	cc_ext->sc_cr_th2 = le16_to_cpu(sb->severe_cong_cr_th2);
+	cc_ext->l64B_per_rtt = le32_to_cpu(sb->link64B_per_rtt);
+	cc_ext->cc_ack_bytes = sb->cc_ack_bytes;
+	cc_ext->reduce_cf_rtt_th = le16_to_cpu(sb->reduce_init_cong_free_rtts_th);
+}
+
+int bnxt_qplib_query_cc_param(struct bnxt_qplib_res *res,
+			      struct bnxt_qplib_cc_param *cc_param)
+{
+	struct bnxt_qplib_tlv_query_rcc_sb *ext_sb;
+	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
+	struct creq_query_roce_cc_resp resp = {};
+	struct creq_query_roce_cc_resp_sb *sb;
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_query_roce_cc req = {};
+	struct bnxt_qplib_rcfw_sbuf sbuf;
+	size_t resp_size;
+	int rc;
+
+	/* Query the parameters from chip */
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req, CMDQ_BASE_OPCODE_QUERY_ROCE_CC,
+				 sizeof(req));
+	if (bnxt_qplib_is_chip_gen_p5_p7(res->cctx))
+		resp_size = sizeof(*ext_sb);
+	else
+		resp_size = sizeof(*sb);
+
+	sbuf.size = ALIGN(resp_size, BNXT_QPLIB_CMDQE_UNITS);
+	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+				     &sbuf.dma_addr, GFP_KERNEL);
+	if (!sbuf.sb)
+		return -ENOMEM;
+
+	req.resp_size = sbuf.size / BNXT_QPLIB_CMDQE_UNITS;
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(res->rcfw, &msg);
+	if (rc)
+		goto out;
+
+	ext_sb = sbuf.sb;
+	sb = bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ? &ext_sb->base_sb :
+		(struct creq_query_roce_cc_resp_sb *)ext_sb;
+
+	cc_param->enable = sb->enable_cc & CREQ_QUERY_ROCE_CC_RESP_SB_ENABLE_CC;
+	cc_param->tos_ecn = (sb->tos_dscp_tos_ecn &
+			     CREQ_QUERY_ROCE_CC_RESP_SB_TOS_ECN_MASK) >>
+			    CREQ_QUERY_ROCE_CC_RESP_SB_TOS_ECN_SFT;
+	cc_param->tos_dscp = (sb->tos_dscp_tos_ecn &
+			      CREQ_QUERY_ROCE_CC_RESP_SB_TOS_DSCP_MASK) >>
+			     CREQ_QUERY_ROCE_CC_RESP_SB_TOS_DSCP_SFT;
+	cc_param->alt_tos_dscp = sb->alt_tos_dscp;
+	cc_param->alt_vlan_pcp = sb->alt_vlan_pcp;
+
+	cc_param->g = sb->g;
+	cc_param->nph_per_state = sb->num_phases_per_state;
+	cc_param->init_cr = le16_to_cpu(sb->init_cr);
+	cc_param->init_tr = le16_to_cpu(sb->init_tr);
+	cc_param->cc_mode = sb->cc_mode;
+	cc_param->inact_th = le16_to_cpu(sb->inactivity_th);
+	cc_param->rtt = le16_to_cpu(sb->rtt);
+	cc_param->tcp_cp = le16_to_cpu(sb->tcp_cp);
+	cc_param->time_pph = sb->time_per_phase;
+	cc_param->pkts_pph = sb->pkts_per_phase;
+	if (bnxt_qplib_is_chip_gen_p5_p7(res->cctx)) {
+		bnxt_qplib_read_cc_gen1(&cc_param->cc_ext, &ext_sb->gen1_sb);
+		cc_param->inact_th |= (cc_param->cc_ext.inact_th_hi & 0x3F) << 16;
+	}
+out:
+	dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
+	return rc;
+}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 4ce44aa..8cbbbeb 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -352,6 +352,8 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 			 struct bnxt_qplib_ext_stat *estat);
 int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_cc_param *cc_param);
+int bnxt_qplib_query_cc_param(struct bnxt_qplib_res *res,
+			      struct bnxt_qplib_cc_param *cc_param);
 
 #define BNXT_VAR_MAX_WQE       4352
 #define BNXT_VAR_MAX_SLOT_ALIGN 256
-- 
2.5.5


