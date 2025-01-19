Return-Path: <linux-rdma+bounces-7096-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F35A162D6
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14803A2DA4
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C01DF735;
	Sun, 19 Jan 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qs2jdjbG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630E1DF73A
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737302783; cv=none; b=YPjVJH+6WduDMYqDvNm+vWUrTdbS70U4kfd6TA5dmojpS7HfO83zpS+Trv+oh33Y6Cvz4pEPDEIn0mmBa5hKfrEQrXthnFhTQ80+vsLIElbjWy3xF8aKqYuqPnFkwovP2t5E/M+mIjCHV/l1LNnYOGZUWTjtsCK6nHhYlOWLMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737302783; c=relaxed/simple;
	bh=swDKLNDQ2b5If4WlDq3JQljZ9aMF17TkMh5fmOCTAjs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tv0wjENnQne8soIaP/d/kZvV9UFeehnwHE8WMqQCBzjQcNdyc/iT00n51wFT/YEcGG+vse14/yFJZ/B3UKYQhCcUCcPC40XeprasSjBpsptZkH22o7GVTjZ7QBaryEMzsRl9DMKdQ+UDj11JCpVpxOwinxVqn7nrrczXAGrO4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qs2jdjbG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21634338cfdso90032455ad.2
        for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 08:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737302781; x=1737907581; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPfvhPVzyk8YPH/YOM/Tsh4S69lVr7u6dR6b/ns1G4U=;
        b=Qs2jdjbGX9wf86FR6jn6mRstOpNJJ0viB+E1ra6dRk84Z6RiBJyNU2Em84gmYJKn+v
         zg0hR5Cgf+yqbrcHQN4GnvDlP6vBh5sLiNiao9AleGrU0z2mwh4VoqukXpxuYs+ucpyZ
         6Mghs8qSwNYryHqVfDje+G+efQN6gnffTNLBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737302781; x=1737907581;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPfvhPVzyk8YPH/YOM/Tsh4S69lVr7u6dR6b/ns1G4U=;
        b=d270RiMp6s28YyI1rVpJseMGFM+3KZp5Y1B/bLKrxnk/1ZwRiZnGAQy5p5SRDCQAvD
         1zI1Cn9yJqXDEuWAq7NNoMr5rXg+oCpAPyvd2Gl/d83JnCPjkOHvnoOdHyRDC2ZnPddv
         kepQvV/YHrC637UDEBTJ/z+AbISEUGUMxRGBHfT8/8qv0vFLi0ACj0jq52SWCW24vatv
         jAjgVK1LL24FOpmsd74FiupXHozMN9nTzunj1LB+qDEV6DXoNHlBvNklh+/AJQ2fC1sm
         D9rwDfYtfCamOGdnld5eZtoqBZyLeYE/qwZ4daXS2fzlM+aN4a5hgBK4INE06GRCSGuD
         8WvA==
X-Gm-Message-State: AOJu0Yz9w7kFl8+QUGWtxwJ0fiijrLUUS4+OW3gQ7/HOyFCeohRhTuDa
	7q+ES8B0lMiK5nygj0CsHIeumF2NOxxVb4YNiDAJhLTe4bHV4Mr3AjuyItiKaw==
X-Gm-Gg: ASbGncsy4OVBtbeioWQmvuPFx/uxs6OcUJGw16fF0L0u5PH4ZzkrnTLgpEw/OWetpaz
	gQx5aO8Xcd0mRiMn+qXdlxjzERgzW0D96jWX3yQ85mygnEqjM51PNzgpr0KhrdgwYbU/VciTLSq
	CYxMWHAVNQfunIQYfTk6a6ohQUutiejlj9m8VYhaX+82CBwnidujrFjTHAcBmnwzE2VCuhNhBXk
	J0dQRbnR0aYOB4i3Tm11Kvkg3hXBe9aqYpx6XoQ6qXmZIvNm1smMh/3e1n3OD5CVQD0pCzuveKP
	4uD2rajfQ5YsJmiz4ddhxlvceuirrADQfx7OFSd1urJrQx3ZoQ==
X-Google-Smtp-Source: AGHT+IGkdLTPP0sCHj4PhfczAA8U3jAV3fQ9bGP8ZSZIc2JSQut/Vm7TGgC2b4GtPmWX72bl9tPAgw==
X-Received: by 2002:a05:6a00:ad8a:b0:72d:9b11:1ebb with SMTP id d2e1a72fcca58-72dafa06ddemr16916044b3a.8.1737302780866;
        Sun, 19 Jan 2025 08:06:20 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab81336esm5369294b3a.38.2025.01.19.08.06.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2025 08:06:20 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings using debugfs hook
Date: Sun, 19 Jan 2025 07:45:35 -0800
Message-Id: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Implements routines to set and get different settings  of
the congestion control. This will enable the users to modify
the settings according to their network.

Currently supporting only GEN 0 version of the parameters.
Reading these files queries the firmware and report the values
currently programmed. Writing to the files sends commands that
update the congestion control settings

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
v1 -> v2:
  Addressed Leon's comments
     - rename debugfs file "g" to "run_avg_weight_g"
     - Fix the indentation errors
     - Remove the unnecessary error message during the read entry point
     - Fix the return value

 drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
 drivers/infiniband/hw/bnxt_re/debugfs.c | 212 +++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/debugfs.h |  15 +++
 3 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b91a85a..b33b04e 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -232,6 +232,8 @@ struct bnxt_re_dev {
 	unsigned long			event_bitmap;
 	struct bnxt_qplib_cc_param	cc_param;
 	struct workqueue_struct		*dcb_wq;
+	struct dentry                   *cc_config;
+	struct bnxt_re_dbg_cc_config_params *cc_config_params;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index 7c47039..f4dd2fb 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -22,6 +22,23 @@
 
 static struct dentry *bnxt_re_debugfs_root;
 
+static const char * const bnxt_re_cc_gen0_name[] = {
+	"enable_cc",
+	"run_avg_weight_g",
+	"num_phase_per_state",
+	"init_cr",
+	"init_tr",
+	"tos_ecn",
+	"tos_dscp",
+	"alt_vlan_pcp",
+	"alt_vlan_dscp",
+	"rtt",
+	"cc_mode",
+	"tcp_cp",
+	"tx_queue",
+	"inactivity_cp",
+};
+
 static inline const char *bnxt_re_qp_state_str(u8 state)
 {
 	switch (state) {
@@ -110,19 +127,212 @@ void bnxt_re_debug_rem_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp)
 	debugfs_remove(qp->dentry);
 }
 
+static int map_cc_config_offset_gen0_ext0(u32 offset, struct bnxt_qplib_cc_param *ccparam, u32 *val)
+{
+	u64 map_offset;
+
+	map_offset = BIT(offset);
+
+	switch (map_offset) {
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC:
+		*val = ccparam->enable;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_G:
+		*val = ccparam->g;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_NUMPHASEPERSTATE:
+		*val = ccparam->nph_per_state;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_CR:
+		*val = ccparam->init_cr;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_TR:
+		*val = ccparam->init_tr;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN:
+		*val = ccparam->tos_ecn;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_DSCP:
+		*val =  ccparam->tos_dscp;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_VLAN_PCP:
+		*val = ccparam->alt_vlan_pcp;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_TOS_DSCP:
+		*val = ccparam->alt_tos_dscp;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_RTT:
+	       *val = ccparam->rtt;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_CC_MODE:
+		*val = ccparam->cc_mode;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TCP_CP:
+		*val =  ccparam->tcp_cp;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t bnxt_re_cc_config_get(struct file *filp, char __user *buffer,
+				     size_t usr_buf_len, loff_t *ppos)
+{
+	struct bnxt_re_cc_param *dbg_cc_param = filp->private_data;
+	struct bnxt_re_dev *rdev = dbg_cc_param->rdev;
+	struct bnxt_qplib_cc_param ccparam = {};
+	u32 offset = dbg_cc_param->offset;
+	char buf[16];
+	u32 val;
+	int rc;
+
+	rc = bnxt_qplib_query_cc_param(&rdev->qplib_res, &ccparam);
+	if (rc)
+		return rc;
+
+	rc = map_cc_config_offset_gen0_ext0(offset, &ccparam, &val);
+	if (rc)
+		return rc;
+
+	rc = snprintf(buf, sizeof(buf), "%d\n", val);
+	if (rc < 0)
+		return rc;
+
+	return simple_read_from_buffer(buffer, usr_buf_len, ppos, (u8 *)(buf), rc);
+}
+
+static void bnxt_re_fill_gen0_ext0(struct bnxt_qplib_cc_param *ccparam, u32 offset, u32 val)
+{
+	u32 modify_mask;
+
+	modify_mask = BIT(offset);
+
+	switch (modify_mask) {
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC:
+		ccparam->enable = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_G:
+		ccparam->g = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_NUMPHASEPERSTATE:
+		ccparam->nph_per_state = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_CR:
+		ccparam->init_cr = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INIT_TR:
+		ccparam->init_tr = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN:
+		ccparam->tos_ecn = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_DSCP:
+		ccparam->tos_dscp = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_VLAN_PCP:
+		ccparam->alt_vlan_pcp = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ALT_TOS_DSCP:
+		ccparam->alt_tos_dscp = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_RTT:
+		ccparam->rtt = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_CC_MODE:
+		ccparam->cc_mode = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TCP_CP:
+		ccparam->tcp_cp = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TX_QUEUE:
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INACTIVITY_CP:
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TIME_PER_PHASE:
+		ccparam->time_pph = val;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_PKTS_PER_PHASE:
+		ccparam->pkts_pph = val;
+		break;
+	}
+
+	ccparam->mask = modify_mask;
+}
+
+static int bnxt_re_configure_cc(struct bnxt_re_dev *rdev, u32 gen_ext, u32 offset, u32 val)
+{
+	struct bnxt_qplib_cc_param ccparam = { };
+
+	/* Supporting only Gen 0 now */
+	if (gen_ext != CC_CONFIG_GEN0_EXT0)
+		bnxt_re_fill_gen0_ext0(&ccparam, offset, val);
+	else
+		return -EINVAL;
+
+	bnxt_qplib_modify_cc(&rdev->qplib_res, &ccparam);
+	return 0;
+}
+
+static ssize_t bnxt_re_cc_config_set(struct file *filp, const char __user *buffer,
+				     size_t count, loff_t *ppos)
+{
+	struct bnxt_re_cc_param *dbg_cc_param = filp->private_data;
+	struct bnxt_re_dev *rdev = dbg_cc_param->rdev;
+	u32 offset = dbg_cc_param->offset;
+	u8 cc_gen = dbg_cc_param->cc_gen;
+	char buf[16];
+	u32 val;
+	int rc;
+
+	if (copy_from_user(buf, buffer, count))
+		return -EFAULT;
+
+	buf[count] = '\0';
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+
+	rc = bnxt_re_configure_cc(rdev, cc_gen, offset, val);
+	return rc ? rc : count;
+}
+
+static const struct file_operations bnxt_re_cc_config_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = bnxt_re_cc_config_get,
+	.write = bnxt_re_cc_config_set,
+};
+
 void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
 {
 	struct pci_dev *pdev = rdev->en_dev->pdev;
+	struct bnxt_re_dbg_cc_config_params *cc_params;
+	int i;
 
 	rdev->dbg_root = debugfs_create_dir(dev_name(&pdev->dev), bnxt_re_debugfs_root);
 
 	rdev->qp_debugfs = debugfs_create_dir("QPs", rdev->dbg_root);
+	rdev->cc_config = debugfs_create_dir("cc_config", rdev->dbg_root);
+
+	rdev->cc_config_params = kzalloc(sizeof(*cc_params), GFP_KERNEL);
+
+	for (i = 0; i < BNXT_RE_CC_PARAM_GEN0; i++) {
+		struct bnxt_re_cc_param *tmp_params = &rdev->cc_config_params->gen0_parms[i];
+
+		tmp_params->rdev = rdev;
+		tmp_params->offset = i;
+		tmp_params->cc_gen = CC_CONFIG_GEN0_EXT0;
+		tmp_params->dentry = debugfs_create_file(bnxt_re_cc_gen0_name[i], 0400,
+							 rdev->cc_config, tmp_params,
+							 &bnxt_re_cc_config_ops);
+	}
 }
 
 void bnxt_re_debugfs_rem_pdev(struct bnxt_re_dev *rdev)
 {
 	debugfs_remove_recursive(rdev->qp_debugfs);
-
+	debugfs_remove_recursive(rdev->cc_config);
+	kfree(rdev->cc_config_params);
 	debugfs_remove_recursive(rdev->dbg_root);
 	rdev->dbg_root = NULL;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.h b/drivers/infiniband/hw/bnxt_re/debugfs.h
index cd3be0a9..3374097 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.h
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.h
@@ -18,4 +18,19 @@ void bnxt_re_debugfs_rem_pdev(struct bnxt_re_dev *rdev);
 void bnxt_re_register_debugfs(void);
 void bnxt_re_unregister_debugfs(void);
 
+#define CC_CONFIG_GEN_EXT(x, y)	(((x) << 16) | (y))
+#define CC_CONFIG_GEN0_EXT0  CC_CONFIG_GEN_EXT(0, 0)
+
+#define BNXT_RE_CC_PARAM_GEN0	__ffs(CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INACTIVITY_CP)
+
+struct bnxt_re_cc_param {
+	struct bnxt_re_dev *rdev;
+	struct dentry *dentry;
+	u32 offset;
+	u8 cc_gen;
+};
+
+struct bnxt_re_dbg_cc_config_params {
+	struct bnxt_re_cc_param        gen0_parms[BNXT_RE_CC_PARAM_GEN0];
+};
 #endif
-- 
2.5.5


