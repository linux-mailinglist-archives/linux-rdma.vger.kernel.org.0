Return-Path: <linux-rdma+bounces-7075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE1EA15B76
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Jan 2025 05:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5BC188AA70
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Jan 2025 04:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B911C5789D;
	Sat, 18 Jan 2025 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eLxMvcOD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0410F9
	for <linux-rdma@vger.kernel.org>; Sat, 18 Jan 2025 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737175796; cv=none; b=PXnjdBLnNmomlZA3lMhDW/UR9AnRbaCOYbK+skkV4JtQLYFqhJ95NQqA4Z+zSBefERHS0g/F1iijZ8CQvRFdw1hYS60jNuSpPucSxzcQsQ3LvdU4HDt+l+eQUW0o+6QL5H/npG8IkAOU9dHEKNYvHuMvjKzUVszb4affiXdns/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737175796; c=relaxed/simple;
	bh=u9dWmMkrfanqt3RGBgCDXtn5T5Wwh6NgjkRSnG6W5qM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=D5n66b58ND+AqV+wVaviTJLCz5TodWSnNZFrpZ12VfJEWlfBaOuSGjYYoHWWLpotChQHXXkLD227QyGdRDshJ++JVqh8hg54HQ/mex8fbhaT6hjuG3J7lvXd5OxuyUGm8ia2uR1rpwQyyEbiENLHSBfgP2KzrYrFFOlmwgpCWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eLxMvcOD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so4843142a91.3
        for <linux-rdma@vger.kernel.org>; Fri, 17 Jan 2025 20:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737175794; x=1737780594; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02Y6poFv8SAv/71dGAIh/BmKCZfQh4pQn9/gMzRphrQ=;
        b=eLxMvcODb3LDD1153xwLbZvSt0OgZLxv0JyJu1/v2Xi51v9nnbFkz0cQENhTgXtRp+
         Hdqej0KkpEOUxyEDOGQaMkW2U/fd86zwFVPamuq439n4AsIG9D7/0I1Gxnn2svWQp5gW
         sEfQN/Ti7EBglcYUu220YKJMqDywWjHBqS7pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737175794; x=1737780594;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02Y6poFv8SAv/71dGAIh/BmKCZfQh4pQn9/gMzRphrQ=;
        b=Ki/e0HbYUSjB//Ec2VwI0etROr7V68V+Lv0PF1TatNbXeON2HRxMF9XNpT9nulnyRn
         jqMJ+ZKDZ8sTSP1aYpSA3fUfNvooNO/wleXJubTtgEIXYSc300btF8kjgELHIgDDpFOi
         RUWfBSsoRamBzrswKPLxOEigZd4wudsvmIWe6d9BoLidM++yKaNG3np9brqzcHxL7laO
         xvoP5fNuWMJ9lS5Yv14y4+aiSMPd+VWE30GEzDx0z88aZGz5/ZLjT5CO6TVAy1ds5A6F
         AJLePuH6IkW9Ygkd7kzTWTJU50gDZ53fKsoEjc5+rmzhFn3cjTWGaWKPs2Hj3XuNHuHM
         qGPg==
X-Gm-Message-State: AOJu0Yxu9I6iR1XHUDxX6z1bJnGSNOYShzO0xz1AWCNRO8h+eHCajuRx
	i+BLRoTVdTiVloKjRAZpAFTcF/6RGWYxt9bZZSaO5yXalLciKepYg+30x1d69A==
X-Gm-Gg: ASbGncsq0xUEwsav1CxUJr13G4Fp5tK+sAejwqXSFFvOZSHzCXIqcnCFcEdBGS7rub4
	vL/Nda8IIFyfa9M47C/iTdXrGCyli17ksjqlMHp7AAHcOi+2N2+faskxPFplxDKUh9tqY16ALeg
	1ya/ZrmjzU04zGa0JvfDyuhdynph4Ed+EdvMMifBwK611+tjOJJF83yJm2lx4qV6ARlY8QFWcdN
	3jxCUqf3DpFoe5KsBZ3Qk9bq+pd1SaEOx5yjk3jQhwrImddIflnxC8RsmbRpfJQLh2SObJ/hwcw
	eqk1jsC5eF4jZRb4UqzTvpT5CAW1FakReOCFxenrn8GEn6wf9A==
X-Google-Smtp-Source: AGHT+IGNK8C+6NvMc/dqoWXw5rZwzgXuW0zqWkWq5rsqGPO5cyiMSMolS0EQ17FG6UJmDnivYzzw7g==
X-Received: by 2002:a17:90b:5211:b0:2ee:9902:18b4 with SMTP id 98e67ed59e1d1-2f782d4ef70mr7469072a91.27.1737175793893;
        Fri, 17 Jan 2025 20:49:53 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c2bb332sm6836363a91.36.2025.01.17.20.49.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2025 20:49:53 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Congestion control settings using debugfs hook
Date: Fri, 17 Jan 2025 20:29:04 -0800
Message-Id: <1737174544-2059-1-git-send-email-selvin.xavier@broadcom.com>
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
update the congestion control settings.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
 drivers/infiniband/hw/bnxt_re/debugfs.c | 215 +++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/debugfs.h |  15 +++
 3 files changed, 231 insertions(+), 1 deletion(-)

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
index 7c47039..66dc303 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -22,6 +22,23 @@
 
 static struct dentry *bnxt_re_debugfs_root;
 
+static const char * const bnxt_re_cc_gen0_name[] = {
+	"enable_cc",
+	"g",
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
@@ -110,19 +127,215 @@ void bnxt_re_debug_rem_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp)
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
+	       *val = ccparam->init_tr;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN:
+	       *val = ccparam->tos_ecn;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_DSCP:
+	       *val =  ccparam->tos_dscp;
+	break;
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
+	      *val = ccparam->cc_mode;
+		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TCP_CP:
+	     *val =  ccparam->tcp_cp;
+		break;
+	default:
+	     return -EINVAL;
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
+	if (rc) {
+		dev_err(rdev_to_dev(rdev),
+			"%s: Failed to query CC parameters\n", __func__);
+		return -EINVAL;
+	}
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


