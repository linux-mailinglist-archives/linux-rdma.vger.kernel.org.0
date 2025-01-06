Return-Path: <linux-rdma+bounces-6832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5BAA02260
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 11:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C533A3113
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEDE1D90AD;
	Mon,  6 Jan 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U+8tTwfH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB51DA313
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157683; cv=none; b=XSFeJaduLakxBZR2I+1AIL8MqjS02C4L8/BTAd4cGVwJGRp0FsWiZr7uvwqGDWYZkvZd6vd9Bfan7aO5sMgKLue+fnwrDdA5mo+tt1irKwR9HEWA9F2RzElIEHJtAWcxk2v2+frsr83a3Z/F/cV6P+EwK+eDEFOpDjWuqbLqBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157683; c=relaxed/simple;
	bh=9Et+OTL51PQqtzERuMR71pZCuvpO0dF7doaSmf2iD3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx7T1wjBXySSQ7NmQWxgclRLJst23cKq59OH2QY8muvE2wDJ3yXgUM+XNZI5T98P8xD2MOKfOg02QZ9tYoK2HWx7ouRInMA21HBM/EPirFNjq8TYRyIZ4FgM50Cbbt3eduJVyY+V4eQr5E2Vn4ypQ2fmOg8M5N/pLy/ZIz6M0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U+8tTwfH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21619108a6bso187836615ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 02:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736157681; x=1736762481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcVwvAn82oDbL4UZKDanDj9GdX7S4bHhDPNmufyqUqc=;
        b=U+8tTwfHOYPfzqvvzSz9PQPMdhf2tbRyTfzNPV5h114P+Me3yz8Z/QKJlTUEEpLo+h
         CunA+wnkJqnISG/jzs8sYRfzMzvaxRDQEOnVL2Gdhe8t+9xIRRQljr8q7cXvgGjAUUsS
         RhJrG4uY0BenjaYh+Tg+dbDVLRgWfRc6ooTM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157681; x=1736762481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcVwvAn82oDbL4UZKDanDj9GdX7S4bHhDPNmufyqUqc=;
        b=XSEwp0iqhb1ObT9abTRraWHdpbWYBfgH0GaIPMjdkVx/saMaut+JO4rMSA50jAWc2P
         dphM/hIryO56pKSTA1mnqpG4ozTnFI9xAzgR2eZrMmifNO1Zm0GGvjT79B6xc7J2P7EP
         1XQ/C3H6CtZ0CBzZP5EEXJEmmS4Oer0pK2qynVKXjJhPOWlzq4NRAoUgHhy9eXInMY7f
         TIdosKDbn2OEZzv73PpO3ocQBaYrq6Fv1zF+PLfLqZzD9pZ5BQW+LOZkWRGZC7OMg3IN
         2BbUs8VvhxlVthK/nDqd0JHPE7XH6jLQkvxUHsCAxc7P/zn5fiiUEEn+riIAi1pc8CMk
         6eTw==
X-Gm-Message-State: AOJu0YzyzFoVsvvwqeKhtYidUMycZSvLYwmyA8PVMdkj+6+iaNkvuX5n
	YDqpCiXyOia0kOrxIw/aymGs9YpcyhmNKxpZUhJyLgKdyAND2l3lfVkiIh3TVA==
X-Gm-Gg: ASbGncshrXLZpK1D8Slq3GTrfivwGXDonai8ftgGs5M7pnZTRk+pBzaci7pBSz1c+xn
	TEtVItVDqUMHz3T8ELIG/TGLsn79lCMQ4mBSGEzOYRvCMXMg2QJRUqXQBqKxZ7azEgK5gjhJfWa
	3Hjhf2J7RbrI5u596LuWtkvxJCdLJ8wFBmlWkAvdysREr/sPbkd4tMf5mEBx0y4dI1aqGdH3kTP
	V8jM7SgnQYNhFaEqm7q3XcwfHfwdVrfyzM+Uqb+bxtVXOO3KgsM2B1AszMfZ2ulnqUsRC2giEKp
	ap0CGc93tN6A8rJLJ1pl5BmK+pW36IAWBXr7h4hbrV67sBl1URxNOw+JTko=
X-Google-Smtp-Source: AGHT+IFEM2Yft26PqwBK7sooH38b4RZQ7ZbqoyfkaK+mXOttvYtSiM/P9nk5/577qZa3wRAsgwGuqg==
X-Received: by 2002:a17:903:228d:b0:215:a2f2:cfbf with SMTP id d9443c01a7336-219e6e9ded8mr711275375ad.18.1736157681076;
        Mon, 06 Jan 2025 02:01:21 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4c89sm282325265ad.124.2025.01.06.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:01:20 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-next v2 3/4] RDMA/bnxt_re: Query firmware defaults of CC params during probe
Date: Mon,  6 Jan 2025 15:23:48 +0530
Message-ID: <20250106095349.2880446-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added function to query firmware default values of CC parameters
during driver init. These values will be stored in driver local
structure and used in subsequent patch.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   1 +
 drivers/infiniband/hw/bnxt_re/main.c     |   5 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 113 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |   2 +
 4 files changed, 121 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 018386295bcd..f40aca550328 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -230,6 +230,7 @@ struct bnxt_re_dev {
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
+	struct bnxt_qplib_cc_param	cc_param;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 1dc305689d7b..aa08eb5bbb68 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2104,6 +2104,11 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
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
index 7e20ae3d2c4f..d56cc3330d1b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -1016,3 +1016,116 @@ int bnxt_qplib_read_context(struct bnxt_qplib_rcfw *rcfw, u8 res_type,
 	dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
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
index e6beeb514b7d..debb26080143 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -355,6 +355,8 @@ int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_cc_param *cc_param);
 int bnxt_qplib_read_context(struct bnxt_qplib_rcfw *rcfw, u8 type, u32 xid,
 			    u32 resp_size, void *resp_va);
+int bnxt_qplib_query_cc_param(struct bnxt_qplib_res *res,
+			      struct bnxt_qplib_cc_param *cc_param);
 
 #define BNXT_VAR_MAX_WQE       4352
 #define BNXT_VAR_MAX_SLOT_ALIGN 256
-- 
2.43.5


