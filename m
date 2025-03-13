Return-Path: <linux-rdma+bounces-8645-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F78A5EEE9
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 10:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC5516C1F8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029832620F3;
	Thu, 13 Mar 2025 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PFp60ebS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2911FA14E
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856714; cv=none; b=monI6DdoqGVlUufgSMzUHaHCov9ZiOUDDqpOFoMI6NcSZheuL3vAf/Yoye5vEuEnV82k93LJnVYdw1KpKrtFov50q2xi7Umb67Yc0Hvb1J8jKfpzO9zdDNHRcVWUNf/bbZpCbeFKYX7jhjsDjN/W1VahOacPCdbkAiaQor1M6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856714; c=relaxed/simple;
	bh=rW0qP/nmY/ZNQoDfDaH3egBsb6pW+Ho5IiTZtdDhAlo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YuT3wFEuWZNx+uYgSDMQdfDPD3gozok+JRQUJtCv09sP31Bc8oRxfZqW3EHQhfgm2ih+w3dRf80vETAfTVautIj3eepA7xmbrgJMAcwlxV8WU2LjB/JD0geakukmzQ44LJS6KGyLM8EPTeNxKkqAYV5v+vBQ1nYki1SJKAJIUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PFp60ebS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22438c356c8so12466155ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741856712; x=1742461512; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajHwrxVcRpLNjC15IKI8XoA1NYDoNW2FKk71i/qLiSY=;
        b=PFp60ebS9P4QsyMgReJmbycyrBMMvWy+j96/XL0W4ief/2fNgdQLZuO6VDS7tQKYcD
         AtE8+AIDVpjx9yjHwo0i/rwYBi1hl53MqtirRKakXahUd2Pu/rKbRQLeZHDtwu26y5CT
         9zMDSp92WEFCkuASlMamcwHcfXPIkBy1FEUdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856712; x=1742461512;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajHwrxVcRpLNjC15IKI8XoA1NYDoNW2FKk71i/qLiSY=;
        b=lhQyO2Xq1aRgloiF/ximGY/pNdMCHRl2r6Dz/TBYKP0zxxWCeVsDVVSoadVZhpgttE
         01zg8Tcm1UhPiXOo/qt1aINUqPtEkKq1MJVTWxTmQB3Phs6JGPVGES9VsbiZPE2om6HM
         yEVYLsSO4h/4XyMJ5tTLFQzhBSKqXwgOmFgVV2ilbT47T0H2iMECG24oY/ce/g3yX+9I
         IO4ab9SWdxBJSBuvhqQ9/O3xSBtY2ru56cmiBBUHum7POm6Dc0O04I5irtM2xoNwmtIV
         LCSLJHlhiBA7U3QhCcDbvunbjiihHpoOsmrK01CdN+6kaf21yzZrMwEZ4XRgjOKpaYlQ
         Zgpw==
X-Gm-Message-State: AOJu0YxHU4+cOGJwOB71Udk8DJf2qvwBwhUMwlK4YgxF9F34cdvxqilw
	XpzTbxlGPBnckTTh48PtBLhXrdEKgqwFZusXJ2OUYaftiVM36ZQv1XQN1doGzw==
X-Gm-Gg: ASbGncv4AVmVQV3dk1Rc0kROJkaAIRQGvt8DfeKI8UBPl+ov01Hc/K5+zywbNnTP1p2
	Y8+k5MDEATwrXyGmX2UE07NxgdfrbBFpvELNMPebXcBPuXSfiH2ZaFWtx35fBDLImD5dqQrV2SI
	sNNeoO2KRlSu+Iyi2vHQpbjoqi5j84utECzE/QvLmVuaoyRJ/2H8K8ycqCI30Zc48l+L9JCZdqm
	OgbJGcb4ByaL3hxoeyCNlofPmDnZbPOEDAtKphKjsluGoR20ocFZM0XYPq2TQPCfiTUp19/aSQ7
	W6YRcTnaHajEREuyATT/W8WIkt4fZPSfVuKCSKGBkebPHP1Wy9tnMKP89Syd45Wlc+HQe2ZndOr
	BpYu4FqND6HSaRlI2rsvp9FSrWQO1pbmvUKo=
X-Google-Smtp-Source: AGHT+IGCnT9SHGiGkfXnaw1XTnkYVTAIyfJlgLx+kdUp6ytgmVXMEXV0PtK2ryUZK1Ui1FJoj0N+MQ==
X-Received: by 2002:a05:6a21:3947:b0:1f5:5b77:3818 with SMTP id adf61e73a8af0-1f55b775bb6mr30147686637.27.1741856711646;
        Thu, 13 Mar 2025 02:05:11 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115293d0sm858681b3a.6.2025.03.13.02.05.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Mar 2025 02:05:11 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next v3] RDMA/bnxt_re: Support Perf management counters
Date: Thu, 13 Mar 2025 01:44:24 -0700
Message-Id: <1741855464-27921-1-git-send-email-selvin.xavier@broadcom.com>
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
v2->v3:
	Addressed Leon's comment. If FW command fails, return immediately.
v1->v2:
        Fix the warning reported by kernel test robot by returning rc
 drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  4 ++
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 92 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 36 +++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h    |  6 ++
 drivers/infiniband/hw/bnxt_re/main.c        |  1 +
 5 files changed, 139 insertions(+)

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
index 3ac47f4..6955796 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -39,6 +39,8 @@
 
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <rdma/ib_mad.h>
+#include <rdma/ib_pma.h>
 
 #include "roce_hsi.h"
 #include "qplib_res.h"
@@ -285,6 +287,96 @@ static void bnxt_re_copy_db_pacing_stats(struct bnxt_re_dev *rdev,
 		readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
 }
 
+int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad)
+{
+	struct ib_pma_portcounters_ext *pma_cnt_ext;
+	struct bnxt_qplib_ext_stat *estat = &rdev->stats.rstat.ext_stat;
+	struct ctx_hw_stats *hw_stats = NULL;
+	int rc = 0;
+
+	hw_stats = rdev->qplib_ctx.stats.dma;
+
+	pma_cnt_ext = (void *)(out_mad->data + 40);
+	if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags)) {
+		u32 fid = PCI_FUNC(rdev->en_dev->pdev->devfn);
+
+		rc = bnxt_qplib_qext_stat(&rdev->rcfw, fid, estat);
+		if (rc)
+			return rc;
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
+	return rc;
+}
+
+int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad)
+{
+	struct bnxt_qplib_ext_stat *estat = &rdev->stats.rstat.ext_stat;
+	struct ib_pma_portcounters *pma_cnt;
+	struct ctx_hw_stats *hw_stats = NULL;
+	int rc = 0;
+
+	hw_stats = rdev->qplib_ctx.stats.dma;
+
+	pma_cnt = (void *)(out_mad->data + 40);
+	if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags)) {
+		u32 fid = PCI_FUNC(rdev->en_dev->pdev->devfn);
+
+		rc = bnxt_qplib_qext_stat(&rdev->rcfw, fid, estat);
+		if (rc)
+			return rc;
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
+	return rc;
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


