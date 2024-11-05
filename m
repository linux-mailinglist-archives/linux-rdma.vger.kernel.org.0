Return-Path: <linux-rdma+bounces-5759-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA89BCA3C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 11:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F091C21D21
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9821D2B17;
	Tue,  5 Nov 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CZjpcGjr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A771D1E92
	for <linux-rdma@vger.kernel.org>; Tue,  5 Nov 2024 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802023; cv=none; b=nloo/Cs2dv2kGoidp9Bi0IqJ6wS2s4fJAM7dHAcp7OemuZAw2NVms1jBUqHqDfrbuhpiAUredA2l3i7HCa5/VOBHcCO+4t3YDJUR6PaAoQibbE4tLp7Y8rnTeZnOwQWcLdveZ4edUNyKAQ43Sb/To1G8JlQ2msElmm8e7X+uyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802023; c=relaxed/simple;
	bh=jD+cShbR5j46hyMs5F6R7f7NqxdyrvSwGdYQL8CPPGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WUyuLtcKIAkNUUqkunuTx7PbNOAqVs6WRf7BhKosFP3zUCMEDRWqojvbM0QB40F1R4JxwIaZLDMXd1FI3ofT9/G1VrO7FwAkkDS3UD4mrgN8yAsN3cPd2w4SrXATvYEUg8opJ58LudUXebMccQW3xNNnoouzIyMCO/lB01FwW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CZjpcGjr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20caccadbeeso56862215ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2024 02:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730802021; x=1731406821; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eA1PTP98RNcNMUiOZVXtR51oHg/PYJgYgWSQcEEreX4=;
        b=CZjpcGjrkFpsjuNmONu3FHcoTn7lNodgG0l4ivYhwMRt0ojPsVd4lZQVm4/DVCWJ2n
         6R+TkYghEHafsGXcmxGqBFomz0HzuL8BpTG30eB2++2iQiXqCc8TBY3umac9TLmbsfLq
         P+KUlNBAGFAMXv1B+dkVumFij9M/kINaZOEmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802021; x=1731406821;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eA1PTP98RNcNMUiOZVXtR51oHg/PYJgYgWSQcEEreX4=;
        b=rcxnr4fzCZmoGsnJ2Zj4gmRfmxZ2SRhjunYIQ9j9f9yVmwr8HjU3DJWF1iyql1Po5c
         FizI9crlsz4nxW9sGqPNFIKNEBSPpxZsGYYNB+rcS+9MmYNYUvf0udD5SaEQnrkay/ZL
         ZbNhxV5dXM1/I+dAbC0DsmbpkgR39cJnLDZ0aosmZbFpX+s4CEZpKl13Y56fFRKittCM
         XaxKqK1SOclHiokFbShb7MQayv/0liddXPzhRiQe3HLEFKCSSP9NB+uOStgjIQmUjIBr
         KxjIigH5blTsC4Ae3zkRqGLwMtmujLkMxuNW/rC8Nq+egzeLSQhUru2aD4AC7b0+eQSx
         jsew==
X-Gm-Message-State: AOJu0YzjkbMMDNFzax4k5RxIRjKyyEWRvRc7X9zUMPzReCZkmtsubXTa
	73EqhZN64L+6hcM62Sna9Hx3gkgbz9YRjUZSEla4OsooAYhUqVBBmwHUkMAjAQ==
X-Google-Smtp-Source: AGHT+IH/qYvaT3PtDuynTauf946bI2v1ZRqjjcXNnLbXg5rvgZwtO/0ou4y05CeYgyDM9mVzFv4A0g==
X-Received: by 2002:a17:902:ea12:b0:20c:dd71:c94f with SMTP id d9443c01a7336-21103c5c8a1mr263584455ad.41.1730802020740;
        Tue, 05 Nov 2024 02:20:20 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105707132sm75306615ad.96.2024.11.05.02.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:20:20 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 2/3] RDMA/bnxt_re: Enhance RoCE SRIOV resource configuration design
Date: Tue,  5 Nov 2024 01:59:11 -0800
Message-Id: <1730800752-29925-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1730800752-29925-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730800752-29925-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>

Refine RoCE SRIOV resource configuration design,
using the INITIALIZE_FW's flag as an indication
for the new design to the firmware. RoCE driver does not
have to provision resources to VF when firmware
advertises support for RoCE resource management by NIC driver.

Signed-off-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
CC: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c          | 13 ++++++++-----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c    |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |  3 +++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h      |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  1 +
 6 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4127227..dd528dd 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -184,6 +184,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 	rdev->rcfw.res = &rdev->qplib_res;
 	rdev->qplib_res.dattr = &rdev->dev_attr;
 	rdev->qplib_res.is_vf = BNXT_EN_VF(en_dev);
+	rdev->qplib_res.en_dev = en_dev;
 
 	bnxt_re_set_drv_mode(rdev);
 
@@ -285,6 +286,10 @@ static void bnxt_re_set_resource_limits(struct bnxt_re_dev *rdev)
 
 static void bnxt_re_vf_res_config(struct bnxt_re_dev *rdev)
 {
+	/*
+	 * Use the total VF count since the actual VF count may not be
+	 * available at this point.
+	 */
 	rdev->num_vfs = pci_sriov_get_totalvfs(rdev->en_dev->pdev);
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		bnxt_re_set_resource_limits(rdev);
@@ -2056,11 +2061,9 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		INIT_DELAYED_WORK(&rdev->worker, bnxt_re_worker);
 		set_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags);
 		schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
-		/*
-		 * Use the total VF count since the actual VF count may not be
-		 * available at this point.
-		 */
-		bnxt_re_vf_res_config(rdev);
+
+		if (!(rdev->qplib_res.en_dev->flags & BNXT_EN_FLAG_ROCE_VF_RES_MGMT))
+			bnxt_re_vf_res_config(rdev);
 	}
 	hash_init(rdev->cq_hash);
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index f5713e3..005079b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -910,6 +910,8 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 		flags |= CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED;
 	if (_is_optimize_modify_qp_supported(rcfw->res->dattr->dev_cap_flags2))
 		flags |= CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED;
+	if (rcfw->res->en_dev->flags & BNXT_EN_FLAG_ROCE_VF_RES_MGMT)
+		flags |= CMDQ_INITIALIZE_FW_FLAGS_L2_VF_RESOURCE_MGMT;
 	req.flags |= cpu_to_le16(flags);
 	req.stat_ctx_id = cpu_to_le32(ctx->stats.fw_id);
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 115910c..21fb148 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -39,6 +39,8 @@
 #ifndef __BNXT_QPLIB_RES_H__
 #define __BNXT_QPLIB_RES_H__
 
+#include "bnxt_ulp.h"
+
 extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 
 #define CHIP_NUM_57508		0x1750
@@ -302,6 +304,7 @@ struct bnxt_qplib_res {
 	struct bnxt_qplib_chip_ctx	*cctx;
 	struct bnxt_qplib_dev_attr      *dattr;
 	struct net_device		*netdev;
+	struct bnxt_en_dev		*en_dev;
 	struct bnxt_qplib_rcfw		*rcfw;
 	struct bnxt_qplib_pd_tbl	pd_tbl;
 	/* To protect the pd table bit map */
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index d9c5373..a98fc9c 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -217,6 +217,7 @@ struct cmdq_initialize_fw {
 	#define CMDQ_INITIALIZE_FW_FLAGS_MRAV_RESERVATION_SPLIT          0x1UL
 	#define CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED     0x2UL
 	#define CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED    0x8UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_L2_VF_RESOURCE_MGMT		 0x10UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	reserved8;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index fdd6356..b771c84 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -414,6 +414,8 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 		edev->flags |= BNXT_EN_FLAG_ROCEV2_CAP;
 	if (bp->flags & BNXT_FLAG_VF)
 		edev->flags |= BNXT_EN_FLAG_VF;
+	if (BNXT_ROCE_VF_RESC_CAP(bp))
+		edev->flags |= BNXT_EN_FLAG_ROCE_VF_RES_MGMT;
 
 	edev->chip_num = bp->chip_num;
 	edev->hw_ring_stats_size = bp->hw_ring_stats_size;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 4f4914f5..5d6aac6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -64,6 +64,7 @@ struct bnxt_en_dev {
 	#define BNXT_EN_FLAG_ULP_STOPPED	0x8
 	#define BNXT_EN_FLAG_VF			0x10
 #define BNXT_EN_VF(edev)	((edev)->flags & BNXT_EN_FLAG_VF)
+	#define BNXT_EN_FLAG_ROCE_VF_RES_MGMT	0x20
 
 	struct bnxt_ulp			*ulp_tbl;
 	int				l2_db_size;	/* Doorbell BAR size in
-- 
2.5.5


