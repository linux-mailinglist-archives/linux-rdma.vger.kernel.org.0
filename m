Return-Path: <linux-rdma+bounces-14186-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6FC2A06D
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 05:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EBB1886962
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 04:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC5B262FDD;
	Mon,  3 Nov 2025 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LWjqIh9V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6011CA0
	for <linux-rdma@vger.kernel.org>; Mon,  3 Nov 2025 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762144089; cv=none; b=S6YwCiBaPxYkUWaTl7OpOdBP9lc+3hu8Ttfj35cAvvJNRGzCQsietWLSRmL9NbYJFSkeNVGZL3Hix/vLexwC24MzWloodSE36Y3drIeZKTz2QlKGUGJBkeyCGqn0HbftPInmCrez1ekOlusjwbQ3ChRm7w1PK0RS2TIHvveDn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762144089; c=relaxed/simple;
	bh=KFehElOOfsi1z6PEfMVY+fJmMMa0kMEXINPjM3B9xos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1K88sC82mef10G9ziAaTLhnWMCgbE2ganWGj76FDRendRVJizyAZ27fUBzFyO8xluhHpcsPFPFc1M5//hZrOS6+md9fU6drqESzbnWPlbw3pjhTOysz34zfvU2gwY3u7d+5IMkrIAl5LJnlFm9WqAm3Ky0NpmJe9ivD+23MYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LWjqIh9V; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-9482ba6fc24so217236839f.2
        for <linux-rdma@vger.kernel.org>; Sun, 02 Nov 2025 20:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762144086; x=1762748886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2/KyBV32WbvOAaYCKvhCDToZx5k7ePfP5bvqwgDfKk=;
        b=szAqs23qs9SrXml2WZd2v3Zy7atL6LTtJ7SugyHgRNOrV8dwZM+Bh5w0CEzLJwunQ1
         sgoRX0QfBIaU4MTY0e6pt/AmHHQZvuwCvvAXzjiLNl8BUqxPx6DoJHPr/Us/013dg8m2
         Zuo5LpObgYI4tyaN3wgekujgoT/9Q2GFrKmDTF39suqHNN4WmvDyiDi1dBFYI+8qz4G4
         XrHf0GlHbrmNY52tsOiSKXX1IKxwi2cf7sLe/w7vVnHNSV7m7KV7EMTE37S3c7lOoLd4
         cjU45n0vrOGJR1xwg/zw55/5GMEKith/2fdFIz6cNBxPRKBe5+HB6BBDbbfvFu49Uzgt
         hY4Q==
X-Gm-Message-State: AOJu0YwMdpdP+23env5opnRA2g1O7Ff7WysCkYWkb5zOTjq1pKh54WGR
	ZEpEKNDaX3x5Wf9LeT11DeNwzeifGUuJ+8JoJ3mkoVl2Df876+VpnIgcoZd7hm14I87wXMBWblI
	idSm52Ffx7tT1Nn1QRzXlGo2ew+0ZbsHcL4LksZ06A4Ul6bgYB8H2OqfSy8YMeeCS32KA/YuK5q
	CH2nzzQrfM/lRHK+0t8o6WA0CTNjnhKaEkrnVboeCKagx+vFJ7hEV16WzctIrwOXrQ48lvKfkRc
	iar84sScZpupqxzZ5FVpDzJhEqjqw==
X-Gm-Gg: ASbGncvnYpixwjdqBZg8zAtNr+ybWD2/OrsmUMV4VD7L7ST2KXdPoB07Jf49dEzlV7D
	M8mmhhHSb9jgiHZf/6oyQ8LnKtgjjg/gO9zsLq16q2pGd06TffwZ0Y0Gxdz8clHMOFLwUQ80YJ4
	3c/qPHU5GgLE6k0SzGOcby8meZlefVZz5/loLF4jhD9AqmxbYaXkuQKUIo61sHJ+1FZ3GV2f3NJ
	60h9JwbEFJwUOOMDXS3ScMX7DQP5qjez91GfxaWQGPn4C/4+cGEeH/5EZUzCZ9Qen75jFxeu4qT
	rcsvts11rRbsYdRf/AOikLft5PXgpIZjjmfddzBsaYCRgBMoitaezsoGH/zSNwLMW8pki7zKvBm
	KwIULIqKYXcbT+YUn66DmRf4GYbX+YwZGJNYULR0xkSJY9apHa1t7KPXdN4BSd4x6uMdeOmShLE
	qWCMsa9hozf9LxlAdh+px7Fl0GxTn8jImV/c+G9UnxHdgCbm8EBg==
X-Google-Smtp-Source: AGHT+IEBH3kzsoQ4Ry87t+JrLXO29fx2gEAsRj/WkbOJpbEsTdGiYvdxK9ueLRAC+l7Sbm20fuy/FCszKhJA
X-Received: by 2002:a05:6602:1644:b0:93e:8c1e:cc5d with SMTP id ca18e2360f4ac-948229564ffmr2092107839f.5.1762144086124;
        Sun, 02 Nov 2025 20:28:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b6a5b8f350sm671514173.29.2025.11.02.20.28.05
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Nov 2025 20:28:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso817347a12.2
        for <linux-rdma@vger.kernel.org>; Sun, 02 Nov 2025 20:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762144084; x=1762748884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A2/KyBV32WbvOAaYCKvhCDToZx5k7ePfP5bvqwgDfKk=;
        b=LWjqIh9Vq/29jJjfDXeLUmFJq3RdGJbOFREwBsatGUt3/Kv1cPvb1zrQUDSzz7aute
         gvF4TSWsqB78+wHrdagmcdCY52x38AT6ol9gfJOqQ9xPwWZcSBJSibKHVG64U6wK6/GQ
         Tm394lRBcDHse6diTUl8Nr4SFot0BtZ2YDtCg=
X-Received: by 2002:a17:90b:1a87:b0:340:b501:7b84 with SMTP id 98e67ed59e1d1-340b5017d5cmr9939198a91.9.1762144084164;
        Sun, 02 Nov 2025 20:28:04 -0800 (PST)
X-Received: by 2002:a17:90b:1a87:b0:340:b501:7b84 with SMTP id 98e67ed59e1d1-340b5017d5cmr9939183a91.9.1762144083745;
        Sun, 02 Nov 2025 20:28:03 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34091b48934sm9285677a91.0.2025.11.02.20.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 20:28:03 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH rdma-next V2] RDMA/bnxt_re: Add a debugfs entry for CQE coalescing tuning
Date: Mon,  3 Nov 2025 10:04:25 +0530
Message-ID: <20251103043425.234846-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch adds debugfs interfaces that allows the user to
enable/disable the RoCE CQ coalescing and fine tune certain
CQ coalescing parameters which would be helpful during debug.

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---

Changes in v2:
- Moved bnxt_re_cq_coal_str structure definition to debugfs.c.
- Removed an unused element from struct bnxt_re_dbg_cq_coal_params
v1:
https://lore.kernel.org/linux-rdma/20251030171540.12656-1-kalesh-anakkur.purayil@broadcom.com/

 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   2 +
 drivers/infiniband/hw/bnxt_re/debugfs.c  | 128 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/debugfs.h  |  19 ++++
 drivers/infiniband/hw/bnxt_re/main.c     |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |   3 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |   1 +
 6 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3485e495ac6a..3a7ce4729fcf 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -224,6 +224,8 @@ struct bnxt_re_dev {
 	struct workqueue_struct		*dcb_wq;
 	struct dentry                   *cc_config;
 	struct bnxt_re_dbg_cc_config_params *cc_config_params;
+	struct dentry			*cq_coal_cfg;
+	struct bnxt_re_dbg_cq_coal_params *cq_coal_cfg_params;
 #define BNXT_VPD_FLD_LEN		32
 	char board_partno[BNXT_VPD_FLD_LEN];
 	/* RoCE mirror */
diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index be5e9b5ca2f0..d03f5bb0d890 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -23,6 +23,14 @@
 
 static struct dentry *bnxt_re_debugfs_root;
 
+static const char * const bnxt_re_cq_coal_str[] = {
+	"buf_maxtime",
+	"normal_maxbuf",
+	"during_maxbuf",
+	"en_ring_idle_mode",
+	"enable",
+};
+
 static const char * const bnxt_re_cc_gen0_name[] = {
 	"enable_cc",
 	"run_avg_weight_g",
@@ -349,6 +357,123 @@ static void bnxt_re_debugfs_add_info(struct bnxt_re_dev *rdev)
 	debugfs_create_file("info", 0400, rdev->dbg_root, rdev, &info_fops);
 }
 
+static ssize_t cq_coal_cfg_write(struct file *file,
+				 const char __user *buf,
+				 size_t count, loff_t *pos)
+{
+	struct seq_file *s = file->private_data;
+	struct bnxt_re_cq_coal_param *param = s->private;
+	struct bnxt_re_dev *rdev = param->rdev;
+	int offset = param->offset;
+	char lbuf[16] = { };
+	u32 val;
+
+	if (count > sizeof(lbuf))
+		return -EINVAL;
+
+	if (copy_from_user(lbuf, buf, count))
+		return -EFAULT;
+
+	lbuf[sizeof(lbuf) - 1] = '\0';
+
+	if (kstrtou32(lbuf, 0, &val))
+		return -EINVAL;
+
+	switch (offset) {
+	case BNXT_RE_COAL_CQ_BUF_MAXTIME:
+		if (val < 1 || val > BNXT_QPLIB_CQ_COAL_MAX_BUF_MAXTIME)
+			return -EINVAL;
+		rdev->cq_coalescing.buf_maxtime = val;
+		break;
+	case BNXT_RE_COAL_CQ_NORMAL_MAXBUF:
+		if (val < 1 || val > BNXT_QPLIB_CQ_COAL_MAX_NORMAL_MAXBUF)
+			return -EINVAL;
+		rdev->cq_coalescing.normal_maxbuf = val;
+		break;
+	case BNXT_RE_COAL_CQ_DURING_MAXBUF:
+		if (val < 1 || val > BNXT_QPLIB_CQ_COAL_MAX_DURING_MAXBUF)
+			return -EINVAL;
+		rdev->cq_coalescing.during_maxbuf = val;
+		break;
+	case BNXT_RE_COAL_CQ_EN_RING_IDLE_MODE:
+		if (val > BNXT_QPLIB_CQ_COAL_MAX_EN_RING_IDLE_MODE)
+			return -EINVAL;
+		rdev->cq_coalescing.en_ring_idle_mode = val;
+		break;
+	case BNXT_RE_COAL_CQ_ENABLE:
+		if (val > 1)
+			return -EINVAL;
+		rdev->cq_coalescing.enable = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return  count;
+}
+
+static int cq_coal_cfg_show(struct seq_file *s, void *unused)
+{
+	struct bnxt_re_cq_coal_param *param = s->private;
+	struct bnxt_re_dev *rdev = param->rdev;
+	int offset = param->offset;
+	u32 val = 0;
+
+	switch (offset) {
+	case BNXT_RE_COAL_CQ_BUF_MAXTIME:
+		val = rdev->cq_coalescing.buf_maxtime;
+		break;
+	case BNXT_RE_COAL_CQ_NORMAL_MAXBUF:
+		val = rdev->cq_coalescing.normal_maxbuf;
+		break;
+	case BNXT_RE_COAL_CQ_DURING_MAXBUF:
+		val = rdev->cq_coalescing.during_maxbuf;
+		break;
+	case BNXT_RE_COAL_CQ_EN_RING_IDLE_MODE:
+		val = rdev->cq_coalescing.en_ring_idle_mode;
+		break;
+	case BNXT_RE_COAL_CQ_ENABLE:
+		val = rdev->cq_coalescing.enable;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	seq_printf(s, "%u\n", val);
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(cq_coal_cfg);
+
+static void bnxt_re_cleanup_cq_coal_debugfs(struct bnxt_re_dev *rdev)
+{
+	debugfs_remove_recursive(rdev->cq_coal_cfg);
+	kfree(rdev->cq_coal_cfg_params);
+}
+
+static void bnxt_re_init_cq_coal_debugfs(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_re_dbg_cq_coal_params *dbg_cq_coal_params;
+	int i;
+
+	if (_is_cq_coalescing_supported(rdev->dev_attr->dev_cap_flags2))
+		return;
+
+	dbg_cq_coal_params = kzalloc(sizeof(*dbg_cq_coal_params), GFP_KERNEL);
+	if (!dbg_cq_coal_params)
+		return;
+
+	rdev->cq_coal_cfg = debugfs_create_dir("cq_coal_cfg", rdev->dbg_root);
+	rdev->cq_coal_cfg_params = dbg_cq_coal_params;
+
+	for (i = 0; i < BNXT_RE_COAL_CQ_MAX; i++) {
+		dbg_cq_coal_params->params[i].offset = i;
+		dbg_cq_coal_params->params[i].rdev = rdev;
+		debugfs_create_file(bnxt_re_cq_coal_str[i],
+				    0600, rdev->cq_coal_cfg,
+				    &dbg_cq_coal_params->params[i],
+				    &cq_coal_cfg_fops);
+	}
+}
+
 void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
 {
 	struct pci_dev *pdev = rdev->en_dev->pdev;
@@ -374,10 +499,13 @@ void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
 							 rdev->cc_config, tmp_params,
 							 &bnxt_re_cc_config_ops);
 	}
+
+	bnxt_re_init_cq_coal_debugfs(rdev);
 }
 
 void bnxt_re_debugfs_rem_pdev(struct bnxt_re_dev *rdev)
 {
+	bnxt_re_cleanup_cq_coal_debugfs(rdev);
 	debugfs_remove_recursive(rdev->qp_debugfs);
 	debugfs_remove_recursive(rdev->cc_config);
 	kfree(rdev->cc_config_params);
diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.h b/drivers/infiniband/hw/bnxt_re/debugfs.h
index 8f101df4e838..98f4620ef245 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.h
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.h
@@ -33,4 +33,23 @@ struct bnxt_re_cc_param {
 struct bnxt_re_dbg_cc_config_params {
 	struct bnxt_re_cc_param	gen0_parms[BNXT_RE_CC_PARAM_GEN0];
 };
+
+struct bnxt_re_cq_coal_param {
+	struct bnxt_re_dev	*rdev;
+	u32			offset;
+};
+
+enum bnxt_re_cq_coal_types {
+	BNXT_RE_COAL_CQ_BUF_MAXTIME,
+	BNXT_RE_COAL_CQ_NORMAL_MAXBUF,
+	BNXT_RE_COAL_CQ_DURING_MAXBUF,
+	BNXT_RE_COAL_CQ_EN_RING_IDLE_MODE,
+	BNXT_RE_COAL_CQ_ENABLE,
+	BNXT_RE_COAL_CQ_MAX
+
+};
+
+struct bnxt_re_dbg_cq_coal_params {
+	struct bnxt_re_cq_coal_param	params[BNXT_RE_COAL_CQ_MAX];
+};
 #endif
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b13810572c2e..73003ad25ee8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1453,6 +1453,7 @@ static struct bnxt_re_dev *bnxt_re_dev_add(struct auxiliary_device *adev,
 	atomic_set(&rdev->stats.res.pd_count, 0);
 	rdev->cosq[0] = 0xFFFF;
 	rdev->cosq[1] = 0xFFFF;
+	rdev->cq_coalescing.enable = 1;
 	rdev->cq_coalescing.buf_maxtime = BNXT_QPLIB_CQ_COAL_DEF_BUF_MAXTIME;
 	if (bnxt_re_chip_gen_p7(en_dev->chip_num)) {
 		rdev->cq_coalescing.normal_maxbuf = BNXT_QPLIB_CQ_COAL_DEF_NORMAL_MAXBUF_P7;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index ce90d3d834d4..c88f049136fc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2226,7 +2226,8 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	req.cq_handle = cpu_to_le64(cq->cq_handle);
 	req.cq_size = cpu_to_le32(cq->max_wqe);
 
-	if (_is_cq_coalescing_supported(res->dattr->dev_cap_flags2)) {
+	if (_is_cq_coalescing_supported(res->dattr->dev_cap_flags2) &&
+	    cq->coalescing->enable) {
 		req.flags |= cpu_to_le16(CMDQ_CREATE_CQ_FLAGS_COALESCING_VALID);
 		coalescing |= ((cq->coalescing->buf_maxtime <<
 				CMDQ_CREATE_CQ_BUF_MAXTIME_SFT) &
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index b990d0c0ce1a..1b414a73b46d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -395,6 +395,7 @@ struct bnxt_qplib_cq_coal_param {
 	u8 normal_maxbuf;
 	u8 during_maxbuf;
 	u8 en_ring_idle_mode;
+	u8 enable;
 };
 
 #define BNXT_QPLIB_CQ_COAL_DEF_BUF_MAXTIME		0x1
-- 
2.43.5


