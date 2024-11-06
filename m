Return-Path: <linux-rdma+bounces-5786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C19BE1DE
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 10:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5628BB21640
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973A1DD872;
	Wed,  6 Nov 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SeJjxQ+P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452561D79B1
	for <linux-rdma@vger.kernel.org>; Wed,  6 Nov 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883939; cv=none; b=bFFgPkv++zi3dqKDQcj5fFm4tkO8vOkMRXuMn7Iqlv+1Nlf2sbR5g9Z8e4bBFRy0zrMkHYRayhVs3YMgg3VrqPtxsPHR+aNzlzdfjaOPEU5w09ChE4jHo38s0JU5GKu7uDBptQle2pZmEmCr8ZtAfHuA0ASp7rqU/gV0x5hj5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883939; c=relaxed/simple;
	bh=jD+cShbR5j46hyMs5F6R7f7NqxdyrvSwGdYQL8CPPGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MucLyV68hOG3VFCaBEdX82lVzNCZ0IkZW3tjkfbG+VAU3jWxhZDv/tc2X8RTJWu5G7EqyCoP1PydEYIzEbS39HCwRgkLYSIrhLLrkIUO5mPIeSXiEr/C15HBONWmvh/T4y8MFEzzIiWSCQ1baSH8s3kRmlsDSNoxHCsY9mjyGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SeJjxQ+P; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso61526975ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2024 01:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730883938; x=1731488738; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eA1PTP98RNcNMUiOZVXtR51oHg/PYJgYgWSQcEEreX4=;
        b=SeJjxQ+PS1L2XtmN5yISaAtjGPRF4I3sA5wF8BWZbEH58BQKyrfwa69u9TEBDbfvHy
         jQfiHDcfn9jRTzPsbXIzxSsR343WboVdQc3mVeD6LQiCm8IwvU4hYjJJxXG9vuuBnKoQ
         kQ9D1mfzAoMcQXWIuKo7k2c38+eHzBmmNxXmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883938; x=1731488738;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eA1PTP98RNcNMUiOZVXtR51oHg/PYJgYgWSQcEEreX4=;
        b=CzKyvzD67u2zYYjiwGZTJwE2WRXGbTSAwIprUyhMjNPUgSWgGrLCIch6NvybZlsQRD
         hXTxLct4EjYJhEHY3jxw1psKb5t4ugj34DvfUkwfUpkdNDR/0jJYJAYGm4JX8mOX0fKr
         MiacEID8LrM2XfpaPqodk1r+G1on7ZWUTM+JXr0HeUK1OcZ9gffMtKP2kVdmnFnMaWkq
         tfy0XrYgIdqtRQQkKCUDNqV/YMSg5pxqKz+BDvaY5ae1Mn+8weDyBLxfWdLBTfwVnQZM
         wjrf5KK2erKDiH196EiE72K2OfOLl+liD2rcctHhOJdKpickIX66k/7ilH0rL03Cn5Fg
         efrA==
X-Gm-Message-State: AOJu0Yx79jiLkyyUbZapOhBlS6Fiax6mLUzFhtSUdX75Dax3DQ+eIDt0
	94vF+MFB/UHAINJaSGLFRVO6Z9maKcg6MK9ypIXHkrLC/FVGF0SBwwB4gFbu1g==
X-Google-Smtp-Source: AGHT+IFhSjGTXVWMwpfzA852xVj2q0jvhY8dnkm99UfTnrlbksQ23xkyb29wBxVqbOhNNEjlPIE0oQ==
X-Received: by 2002:a17:902:f542:b0:20b:8bf5:cd72 with SMTP id d9443c01a7336-210c6c6f727mr517113365ad.49.1730883937535;
        Wed, 06 Nov 2024 01:05:37 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057084casm91715395ad.92.2024.11.06.01.05.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2024 01:05:36 -0800 (PST)
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
Subject: [PATCH rdma-next v2 2/3] RDMA/bnxt_re: Enhance RoCE SRIOV resource configuration design
Date: Wed,  6 Nov 2024 00:44:35 -0800
Message-Id: <1730882676-24434-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1730882676-24434-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730882676-24434-1-git-send-email-selvin.xavier@broadcom.com>
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


