Return-Path: <linux-rdma+bounces-8561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761D2A5B958
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 07:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C66F3ABDCC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C201F12F2;
	Tue, 11 Mar 2025 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KcmW5fUG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA3211C
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675356; cv=none; b=FU/DUhZFUwp+wpWEB6hMCndN3sAoahGfBSWclPEHVRAKgMkIXbz90BC2SUQMGQtzgoitq9E/yyOybY9fFVeGrFwwKhKdsEQ65zJQVq9zSJtF2xcdSGDWzLcogwptrMm/vahLtBsKfyQtYj+DIZIgJgSg+Q1YJJapZx9rHr9knxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675356; c=relaxed/simple;
	bh=nrdJ0JzlvdlinSs9P0aRAiiERUhhbIrSL48hEa8TYBo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TnCiuNSCDj2T+Jsg8IF+QQ8k98/zRJFBH0ah1z/id5Itsa7Z4fx6V7X3+ec6xyYrhGaQDBWAvv0EOVRHssAZjkxg1y+cLOWX/hqw0ZHFIeDNoW46IendRLpUG87jH+YPSjym80xsh98/mN5b/v6JQOz0QGyb9unFSqVDLeuBK/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KcmW5fUG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso7549614a91.2
        for <linux-rdma@vger.kernel.org>; Mon, 10 Mar 2025 23:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741675354; x=1742280154; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFZdBHrkDFxay/qFxAdoMTRHsEzJphfSkidTmTXoxms=;
        b=KcmW5fUGFEz1rrNPepK0OTZWJ+27+lWTFdewQAXGfsJIXCic5lkNRPLpEp7lv8J2I4
         z38R0aiRaGCb8Ao/WCj1OPnho4DWuQyP/DYjl0RO/Cl/zTFlbKdG2QBUyT38DVPYaHbO
         LMWS9VD0fM1UkO+vY6pxwNH+nxNo6wi0MFa9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741675354; x=1742280154;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFZdBHrkDFxay/qFxAdoMTRHsEzJphfSkidTmTXoxms=;
        b=Q/blpcgOXMNo94Trj99U/fB2RdnGRKQNPVqXpftD8dlC0edMM3PM7X+Xt6dJppJtj5
         mUpzxUowu/xxe6hlNcwzSFJ6WuD6QUjIHMRVnpkBAdEQrG4TmuG+j/gIEHhwMxbs5PJ3
         1U3kdRxOz+t5vM92e89byvetaQhPg7En0vi4HbFE8q5NRCx9SFoARa2aq09G8wo9TJ7r
         QolJ5GFk18ljL7H66YqFZ4UyhlGgIZeLF1T7BmaUnCm6Rb0QwZG6QeUu4Myo19zoXWV1
         vCJBI1WxsIZONLNYxWwtxjNtuU3dcfgl1XYsMslmZbZvtTc2fVDBgHd9dZL5f2tNLtML
         JkEw==
X-Gm-Message-State: AOJu0YzibF3C/jM86iKZ7DXsnL+/cMKyp5SRFAy/7vlmn1YtiF0NXeie
	zbh4uKI7/rX+CjrrQ4AR0NTvYsUrYOqhgXrSki9CzHiUE+h1hHiji2fRuwpPQA==
X-Gm-Gg: ASbGncsMmo7cw2IuItMWwRIJhR/leNq73vHEy11NCaiZluIZs08UjwpMDbx15sWwKoU
	HZzCEiwsnSKYNxRljPHc2mHZJWxYRoxiqnRkeaUqZ3UrkofvyEV6WXJCLkcTNKdgQ00mF+Y57fl
	u9uwUm7oILflAuNn7tTeJERfo70Na6mwhauo1J10fVh1eors+39k4gYlDuoG21T2/r5pM/fi0Bu
	5LUAwoF4gVrTJHWws/J2P3zdSXJr3DWv61F8lGAVeU7K31ekLlxnLcYC1+kH1Ff/1CwK7SW8Dyh
	GDhdhycZ+Q7ZApPdeDgfnMmMXoRlSxzzIaId6jMMSCFI9sZ+NK9h4nqF9oHfq5kHhPShFq3L2mw
	iJzTt6g9YtGuRsNwcVyqfg0vd
X-Google-Smtp-Source: AGHT+IE3Ent1U0uRVj66y6ChklCnbwO4gLI9sTW59/4FxW1EEdRPhsBjKpqyJh2AKX0dwvT88EjjSg==
X-Received: by 2002:a17:90b:2e8f:b0:2ee:90a1:5d42 with SMTP id 98e67ed59e1d1-300fefb1a2cmr4361078a91.0.1741675353747;
        Mon, 10 Mar 2025 23:42:33 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff6933b029sm9132730a91.6.2025.03.10.23.42.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2025 23:42:33 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Support Perf management counters
Date: Mon, 10 Mar 2025 23:21:44 -0700
Message-Id: <1741674104-5477-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>

Add support for process_mad hook to retrieve the perf management counters.
Supports IB_PMA_PORT_COUNTERS and IB_PMA_PORT_COUNTERS_EXT counters.
Query the data from HW contexts and FW commands.

Signed-off-by: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  4 ++
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 88 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 36 ++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h    |  6 ++
 drivers/infiniband/hw/bnxt_re/main.c        |  1 +
 5 files changed, 135 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b33b04e..8bc0237 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -246,6 +246,10 @@ struct bnxt_re_dev {
 #define BNXT_RE_CHECK_RC(x) ((x) && ((x) != -ETIMEDOUT))
 void bnxt_re_pacing_alert(struct bnxt_re_dev *rdev);
 
+int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad);
+int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev,
+					 struct ib_mad *out_mad);
+
 static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
 {
 	if (rdev)
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 3ac47f4..b186964 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -39,6 +39,8 @@
 
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <rdma/ib_mad.h>
+#include <rdma/ib_pma.h>
 
 #include "roce_hsi.h"
 #include "qplib_res.h"
@@ -285,6 +287,92 @@ static void bnxt_re_copy_db_pacing_stats(struct bnxt_re_dev *rdev,
 		readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
 }
 
+int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad)
+{
+	struct ib_pma_portcounters_ext *pma_cnt_ext;
+	struct bnxt_qplib_ext_stat *estat = &rdev->stats.rstat.ext_stat;
+	struct ctx_hw_stats *hw_stats = NULL;
+	int rc;
+
+	hw_stats = rdev->qplib_ctx.stats.dma;
+
+	pma_cnt_ext = (void *)(out_mad->data + 40);
+	if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags)) {
+		u32 fid = PCI_FUNC(rdev->en_dev->pdev->devfn);
+
+		rc = bnxt_qplib_qext_stat(&rdev->rcfw, fid, estat);
+	}
+
+	pma_cnt_ext = (void *)(out_mad->data + 40);
+	if ((bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) && rdev->is_virtfn) ||
+	    !bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+		pma_cnt_ext->port_xmit_data =
+			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_bytes) / 4);
+		pma_cnt_ext->port_rcv_data =
+			cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_bytes) / 4);
+		pma_cnt_ext->port_xmit_packets =
+			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts));
+		pma_cnt_ext->port_rcv_packets =
+			cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts));
+		pma_cnt_ext->port_unicast_rcv_packets =
+			cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts));
+		pma_cnt_ext->port_unicast_xmit_packets =
+			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts));
+
+	} else {
+		pma_cnt_ext->port_rcv_packets = cpu_to_be64(estat->rx_roce_good_pkts);
+		pma_cnt_ext->port_rcv_data = cpu_to_be64(estat->rx_roce_good_bytes / 4);
+		pma_cnt_ext->port_xmit_packets = cpu_to_be64(estat->tx_roce_pkts);
+		pma_cnt_ext->port_xmit_data = cpu_to_be64(estat->tx_roce_bytes / 4);
+		pma_cnt_ext->port_unicast_rcv_packets = cpu_to_be64(estat->rx_roce_good_pkts);
+		pma_cnt_ext->port_unicast_xmit_packets = cpu_to_be64(estat->tx_roce_pkts);
+	}
+	return 0;
+}
+
+int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad)
+{
+	struct bnxt_qplib_ext_stat *estat = &rdev->stats.rstat.ext_stat;
+	struct ib_pma_portcounters *pma_cnt;
+	struct ctx_hw_stats *hw_stats = NULL;
+	int rc;
+
+	hw_stats = rdev->qplib_ctx.stats.dma;
+
+	pma_cnt = (void *)(out_mad->data + 40);
+	if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags)) {
+		u32 fid = PCI_FUNC(rdev->en_dev->pdev->devfn);
+
+		rc = bnxt_qplib_qext_stat(&rdev->rcfw, fid, estat);
+	}
+	if ((bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) && rdev->is_virtfn) ||
+	    !bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+		pma_cnt->port_rcv_packets =
+			cpu_to_be32((u32)(le64_to_cpu(hw_stats->rx_ucast_pkts)) & 0xFFFFFFFF);
+		pma_cnt->port_rcv_data =
+			cpu_to_be32((u32)((le64_to_cpu(hw_stats->rx_ucast_bytes) &
+					   0xFFFFFFFF) / 4));
+		pma_cnt->port_xmit_packets =
+			cpu_to_be32((u32)(le64_to_cpu(hw_stats->tx_ucast_pkts)) & 0xFFFFFFFF);
+		pma_cnt->port_xmit_data =
+			cpu_to_be32((u32)((le64_to_cpu(hw_stats->tx_ucast_bytes)
+					   & 0xFFFFFFFF) / 4));
+	} else {
+		pma_cnt->port_rcv_packets = cpu_to_be32(estat->rx_roce_good_pkts);
+		pma_cnt->port_rcv_data = cpu_to_be32((estat->rx_roce_good_bytes / 4));
+		pma_cnt->port_xmit_packets = cpu_to_be32(estat->tx_roce_pkts);
+		pma_cnt->port_xmit_data = cpu_to_be32((estat->tx_roce_bytes / 4));
+	}
+	pma_cnt->port_rcv_constraint_errors = (u8)(le64_to_cpu(hw_stats->rx_discard_pkts) & 0xFF);
+	pma_cnt->port_rcv_errors = cpu_to_be16((u16)(le64_to_cpu(hw_stats->rx_error_pkts)
+						     & 0xFFFF));
+	pma_cnt->port_xmit_constraint_errors = (u8)(le64_to_cpu(hw_stats->tx_error_pkts) & 0xFF);
+	pma_cnt->port_xmit_discards = cpu_to_be16((u16)(le64_to_cpu(hw_stats->tx_discard_pkts)
+							& 0xFFFF));
+
+	return 0;
+}
+
 int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			    struct rdma_hw_stats *stats,
 			    u32 port, int index)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2de101d..dc31973 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -49,6 +49,7 @@
 #include <rdma/ib_addr.h>
 #include <rdma/ib_mad.h>
 #include <rdma/ib_cache.h>
+#include <rdma/ib_pma.h>
 #include <rdma/uverbs_ioctl.h>
 #include <linux/hashtable.h>
 
@@ -4489,6 +4490,41 @@ void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 	kfree(bnxt_entry);
 }
 
+int bnxt_re_process_mad(struct ib_device *ibdev, int mad_flags,
+			u32 port_num, const struct ib_wc *in_wc,
+			const struct ib_grh *in_grh,
+			const struct ib_mad *in_mad, struct ib_mad *out_mad,
+			size_t *out_mad_size, u16 *out_mad_pkey_index)
+{
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
+	struct ib_class_port_info cpi = {};
+	int ret = IB_MAD_RESULT_SUCCESS;
+	int rc = 0;
+
+	if (in_mad->mad_hdr.mgmt_class  != IB_MGMT_CLASS_PERF_MGMT)
+		return ret;
+
+	switch (in_mad->mad_hdr.attr_id) {
+	case IB_PMA_CLASS_PORT_INFO:
+		cpi.capability_mask = IB_PMA_CLASS_CAP_EXT_WIDTH;
+		memcpy((out_mad->data + 40), &cpi, sizeof(cpi));
+		break;
+	case IB_PMA_PORT_COUNTERS_EXT:
+		rc = bnxt_re_assign_pma_port_ext_counters(rdev, out_mad);
+		break;
+	case IB_PMA_PORT_COUNTERS:
+		rc = bnxt_re_assign_pma_port_counters(rdev, out_mad);
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+	if (rc)
+		return IB_MAD_RESULT_FAILURE;
+	ret |= IB_MAD_RESULT_REPLY;
+	return ret;
+}
+
 static int UVERBS_HANDLER(BNXT_RE_METHOD_NOTIFY_DRV)(struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_ucontext *uctx;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index fbb16a4..22c9eb8 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -268,6 +268,12 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
 int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 
+int bnxt_re_process_mad(struct ib_device *device, int process_mad_flags,
+			u32 port_num, const struct ib_wc *in_wc,
+			const struct ib_grh *in_grh,
+			const struct ib_mad *in_mad, struct ib_mad *out_mad,
+			size_t *out_mad_size, u16 *out_mad_pkey_index);
+
 static inline u32 __to_ib_port_num(u16 port_id)
 {
 	return (u32)port_id + 1;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index e9e4da4..59ddb36 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1276,6 +1276,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.post_recv = bnxt_re_post_recv,
 	.post_send = bnxt_re_post_send,
 	.post_srq_recv = bnxt_re_post_srq_recv,
+	.process_mad = bnxt_re_process_mad,
 	.query_ah = bnxt_re_query_ah,
 	.query_device = bnxt_re_query_device,
 	.modify_device = bnxt_re_modify_device,
-- 
2.5.5


