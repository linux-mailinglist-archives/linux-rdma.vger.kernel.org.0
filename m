Return-Path: <linux-rdma+bounces-14151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC90C2161D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 18:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761591894B2A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42963678BA;
	Thu, 30 Oct 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CuaoEXYc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C983678C9
	for <linux-rdma@vger.kernel.org>; Thu, 30 Oct 2025 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844143; cv=none; b=iUZ0FcA80IUiMgqOb3MlOHUc7fq97tOWURCydLpABtbyyc45oMpPH7y1786tMkP/3yvCZkcNpTksoL73p0yIXiRFV2yasyJn8+4CZpZjo1BBJvhg1ktWNaHL4dqVRbs6Zt0NybJX5GyygzjVrga9e23L8pDxmWVbz2fiZncsQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844143; c=relaxed/simple;
	bh=xvBqZ8bHoWK98DBSnPW3LpZuxZ/G3yrI84jbUZ5zqxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxo2wtXwQ+Pmf/V9UFMnCnwiS8DgO3EItuDBmWyLy4/rd2qw66kRpikypbjNmXZuspn3/76gbtjtxk0pzzn1dj9j4mdDQN0qnPi7VUGDKxjkB4SEx6OzujgOVdR7eCkJKHeEAGBUdYeOdloN57QS67zgFR6fPjRHmYBMLw0w7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CuaoEXYc; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-87c11268b97so16086616d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 Oct 2025 10:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844139; x=1762448939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt1KjKw7KfwT8Y8RT53bGluyXX0yrSYFgvJsTxERKFw=;
        b=RcY2pmW3s31+JQqqbmJ9fwCSv+7JEC0zeypLmfM2d1hzdn2moRW3hFai8pQOn85MSZ
         Fz1bfzztmbrdx5FItOtq15iZyZQSm8CHC1RvTBo3HfwcWEWZ/Wkq3suw1Nz7hNP4OBpK
         LLQhUnxV59g7JFJvbW0Lv7kg5S/NaHOHCh867emXsMzIQM3AvnK5MDm1vuY2gmm4Ve1m
         Zjn3tLtIMOd701a6icjAEtTWnSzoJMMlb+CjyPYxCfQUri8e4oJgaKo4guN35Nfgfiw5
         LG9WDUEko/NGf6F2s+QNDsw9pyL9hxLH178oy/MspXj+4kSoe0HJD6N2tIj1nzvRKZ7z
         Nb5Q==
X-Gm-Message-State: AOJu0Yx/Rud2pKAqMHHKOobKelzRLlYYJGsQJBm6o47hUPJjh2OxNGTM
	Md+/eDQxwPNsrudV2sChqJc/wI2nrx0PKWq8yjlQTh2cKyJ7QbkNZ3YPrOyKwO5gC51BS89pcp8
	LXPJrFqnRLPy3TcCn2BEA5e/748EJE9/8bzGabNfhcOaijKwx8hezBRIkJi0BuTCnficz8KSL+X
	xoLxFlgLMz5kDMTDGdRjkOVKHjBGrSOW6I2NqOl5q+YYDjg94Q0rgbfh9rqI5pOhuFFxg17IakU
	2ye0Ac53lbXI453CDln3U4Yk2qo5w==
X-Gm-Gg: ASbGncvLIuUFy68TJenb+0yaMrecOQQG4lGLFFw64gKOmFB/rZ9ZgZFNivmcz+6gRhO
	Ewve071iPB+SKcQVhQtX2OkEbFd4+ePoDHDdF4ZatwKkRvvX+jsNV77PpuR+IS2XNwYNKoWuT72
	wikKZlvOronl+lrxM08J0DMMO8g27RK0yeAdD7Wf7MJSgCM2BT8RH/nnJsSbk3JmMMTCpksDwoR
	So8GX3jxwCOnEgDs2W7dvLr+0rbMGdMv8ZC1KJmOWBSu9pBYHqhtbq1z9SEyINYqMeK6hweK5eQ
	dIF7IGYwBu7LLP76PuKDKSUVR5okxMRneBooS2Lta2gfeJr+FxTowPOMagwKPWarcpm8FR72IZ/
	yePSYk5DN18qRUEk1MymtsL53AwAggGbn5UZ3q7hgNpCXsGbadZmacOqX/hdz1SSs2Wb6OCitW9
	NrDZ2o6m8qC8IhNJg3szy5VEiLm/29Mm9GxlEEbR7ioDtoK4ESQA==
X-Google-Smtp-Source: AGHT+IFR1rubFGkspTOv6M9Kf+XZSFvTD7ArgSv1dZ+lj+9HmUXtArhlqzy2OKsh5huINmK389S2vE/8NT6o
X-Received: by 2002:a05:6214:2522:b0:7ef:d35f:e1e3 with SMTP id 6a1803df08f44-8802f4d10f8mr3487266d6.57.1761844139131;
        Thu, 30 Oct 2025 10:08:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87fc49b90d8sm16513216d6.28.2025.10.30.10.08.58
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2025 10:08:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630753cc38so2209388a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 30 Oct 2025 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761844138; x=1762448938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lt1KjKw7KfwT8Y8RT53bGluyXX0yrSYFgvJsTxERKFw=;
        b=CuaoEXYcFCJNrpTEKA65rsubNRJCZE1Jmn9DxPSVBPOi9N4YfZ18HXvCYPDYf7ao1c
         Hjjv67XpFPIdPCvJCjenqDWjXAZo6w8GDroi9YHXLX6jqoNGjamv15CvkJ8cktA9HF3J
         7RujbIFBMiMGP2l+jUiTO8t7W8S8mwQCIziac=
X-Received: by 2002:a05:6a20:430d:b0:343:55a9:3ebf with SMTP id adf61e73a8af0-348ca763736mr474228637.16.1761844137666;
        Thu, 30 Oct 2025 10:08:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:430d:b0:343:55a9:3ebf with SMTP id adf61e73a8af0-348ca763736mr474179637.16.1761844137051;
        Thu, 30 Oct 2025 10:08:57 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d20d76dsm18023208a12.28.2025.10.30.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:08:56 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Add a debugfs entry for CQE coalescing tuning
Date: Thu, 30 Oct 2025 22:45:40 +0530
Message-ID: <20251030171540.12656-1-kalesh-anakkur.purayil@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   2 +
 drivers/infiniband/hw/bnxt_re/debugfs.c  | 120 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/debugfs.h  |  28 ++++++
 drivers/infiniband/hw/bnxt_re/main.c     |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |   3 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |   1 +
 6 files changed, 154 insertions(+), 1 deletion(-)

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
index be5e9b5ca2f0..2b6cbd38ef54 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -349,6 +349,123 @@ static void bnxt_re_debugfs_add_info(struct bnxt_re_dev *rdev)
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
@@ -374,10 +491,13 @@ void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
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
index 8f101df4e838..4b3c86ceb68d 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.h
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.h
@@ -33,4 +33,32 @@ struct bnxt_re_cc_param {
 struct bnxt_re_dbg_cc_config_params {
 	struct bnxt_re_cc_param	gen0_parms[BNXT_RE_CC_PARAM_GEN0];
 };
+
+static const char * const bnxt_re_cq_coal_str[] = {
+	"buf_maxtime",
+	"normal_maxbuf",
+	"during_maxbuf",
+	"en_ring_idle_mode",
+	"enable",
+};
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
+	struct dentry			*root;
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


