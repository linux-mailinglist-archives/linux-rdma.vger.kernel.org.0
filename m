Return-Path: <linux-rdma+bounces-5785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 000F89BE1DC
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 10:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D261F25220
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B0A1DD545;
	Wed,  6 Nov 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dnqMeUsE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460B1DD537
	for <linux-rdma@vger.kernel.org>; Wed,  6 Nov 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883934; cv=none; b=UigsCns7XrcMGfB0JW3+ASwxnNrzRVE19lPYfae0Lr5UTf7CG5v8XN5sdmDCDJCHTRE30fbc0RAphudC70lDGwHNIZIl23pmj31z7SgQMTcZg8D/pdrMq33tfv0vk7upcnLqnIt/+wuF1YMgIhB8IO66MOfSkOlxOmDDWNzxRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883934; c=relaxed/simple;
	bh=MxDFVykjeASFttygGlVFETzBcH7gqvDqyuqwVQvN+wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X8+VQfYtAL3ss65y7XNMIFAvhUFcFKJUCmLs9xSHLZBuM9umq4cV/P8cSjoXCWUTgQIV36LNjOWXwHgzet0LxHq8FOXGYHSpf9Yvde+EmEXehK3nWy8HWlkarcjQ3xHMzBMgMnsEGRSWUVlD2pNVeukfNqGGG7wK1QQS+k3xGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dnqMeUsE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdb889222so61771455ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2024 01:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730883932; x=1731488732; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ojUfmXZSzyIQau3R+jJmvfUsS9SSCZ+gkgKPe64SPcE=;
        b=dnqMeUsEmi/fesTOpciCKdgiO+I0c4reLAnFWIpss6wZV6KjaAO3OOfHJ08uMtxECQ
         TSkDi+f6nQva/eL98l6lkfHMyTjnH7IFRIhaw4LTAb98JtwIGsdTPTBBRLI/JibfO0Nk
         OU0TOJsQNHaPgBCFrDwJd4/XsXrEfSkrqsX0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883932; x=1731488732;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojUfmXZSzyIQau3R+jJmvfUsS9SSCZ+gkgKPe64SPcE=;
        b=mWGM1HiWQcWZEs+PmWdwEylBEiOyah1o+7Q6le1lxlrRMZJDynQuFaci5jbWvwzkAI
         bStuPDCOEZL55TZVuSYh45XrBmVp7KijzV9jxVyQNU8ElwMMdK97pC3xUb1HPHE1XW1i
         PtMFapeowZ7CJE0d6r2S5DJ0/aUqwFVeCcLRPCI9iCkN6LwiZ5IeFwI3fz1gvj7SOlWx
         fWyysN4elaboDzmAfUF8VWWe36ur1i18PHXGFCsgFgjSiRM9W3J5T+SWpdTfPC6h/fGM
         Bjf7Xz8nsJloBJDE9OA9ch8LqJ0ipC2pUy7Tc9ufslNqdEBq6lMZoa++EjBt9r/pQeF+
         wCjg==
X-Gm-Message-State: AOJu0YwnbAkyM4S/5qMlEHDJsBJtrmG2w4K2nyw6v+QC4+uW4Kp0a0zT
	0EwwZbHxlXcVQty3Wsc7E0Y6XzBA3KG17Ygi/wzSW16hW2u668n1Rv7NWhG1aw==
X-Google-Smtp-Source: AGHT+IE4ZaLYh3wQeBnRAPKoJPKr/cbn1fwHu8TzegfnNFk6B+kXJBzu0nwlPpEFAXFbVj9t+b2MpQ==
X-Received: by 2002:a17:902:cf4c:b0:20b:7be8:8eb9 with SMTP id d9443c01a7336-21103c971c0mr271733425ad.54.1730883932544;
        Wed, 06 Nov 2024 01:05:32 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057084casm91715395ad.92.2024.11.06.01.05.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2024 01:05:31 -0800 (PST)
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
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next v2 1/3] bnxt_en: Add support for RoCE sriov configuration
Date: Wed,  6 Nov 2024 00:44:34 -0800
Message-Id: <1730882676-24434-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1730882676-24434-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730882676-24434-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Vikas Gupta <vikas.gupta@broadcom.com>

During driver load, PF RDMA driver provisions resources
to the RDMA VFs. This logic takes into consideration of
the total number of VFs supported on the PF while
allocating resources. Firmware now advertises a capability
where NIC driver can allocate resources for RDMA VFs when
the user actually creates a VF. So this resource
distribution can be based on the number of active VFs.

This patch adds the support to check for the firmware
capability and follow the new RDMA VF resource allocation
strategy. The current logic in the RDMA driver will be
removed for the newer Firmware versions in a subsequent
patch in this series.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |  6 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h       |  6 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 53 +++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e2..70230c5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8151,6 +8151,9 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 	if (flags & FUNC_QCFG_RESP_FLAGS_RING_MONITOR_ENABLED)
 		bp->fw_cap |= BNXT_FW_CAP_RING_MONITOR;
 
+	if (flags & FUNC_QCFG_RESP_FLAGS_ENABLE_RDMA_SRIOV)
+		bp->fw_cap |= BNXT_FW_CAP_ENABLE_RDMA_SRIOV;
+
 	switch (resp->port_partition_type) {
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_5:
@@ -9177,6 +9180,9 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->flags |= BNXT_FLAG_UDP_GSO_CAP;
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_TX_PKT_TS_CMPL_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_TX_TS_CMP;
+	if (BNXT_PF(bp) &&
+	    (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED))
+		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED;
 
 	bp->tx_push_thresh = 0;
 	if ((flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED) &&
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 69231e8..2da6c7b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2406,6 +2406,8 @@ struct bnxt {
 	#define BNXT_FW_CAP_DCBX_AGENT			BIT_ULL(2)
 	#define BNXT_FW_CAP_NEW_RM			BIT_ULL(3)
 	#define BNXT_FW_CAP_IF_CHANGE			BIT_ULL(4)
+	#define BNXT_FW_CAP_ENABLE_RDMA_SRIOV           BIT_ULL(5)
+	#define BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED	BIT_ULL(6)
 	#define BNXT_FW_CAP_KONG_MB_CHNL		BIT_ULL(7)
 	#define BNXT_FW_CAP_OVS_64BIT_HANDLE		BIT_ULL(10)
 	#define BNXT_FW_CAP_TRUSTED_VF			BIT_ULL(11)
@@ -2452,6 +2454,10 @@ struct bnxt {
 #define BNXT_SUPPORTS_QUEUE_API(bp)				\
 	(BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) &&	\
 	 ((bp)->fw_cap & BNXT_FW_CAP_VNIC_RE_FLUSH))
+#define BNXT_RDMA_SRIOV_EN(bp)		\
+	((bp)->fw_cap & BNXT_FW_CAP_ENABLE_RDMA_SRIOV)
+#define BNXT_ROCE_VF_RESC_CAP(bp)	\
+	((bp)->fw_cap & BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 7bb8a5d..12b6ed5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -520,6 +520,56 @@ static int __bnxt_set_vf_params(struct bnxt *bp, int vf_id)
 	return hwrm_req_send(bp, req);
 }
 
+static void bnxt_hwrm_roce_sriov_cfg(struct bnxt *bp, int num_vfs)
+{
+	struct hwrm_func_qcaps_output *resp;
+	struct hwrm_func_cfg_input *cfg_req;
+	struct hwrm_func_qcaps_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_FUNC_QCAPS);
+	if (rc)
+		return;
+
+	req->fid = cpu_to_le16(0xffff);
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send(bp, req);
+	if (rc)
+		goto err;
+
+	rc = hwrm_req_init(bp, cfg_req, HWRM_FUNC_CFG);
+	if (rc)
+		goto err;
+
+	cfg_req->fid = cpu_to_le16(0xffff);
+	cfg_req->enables2 =
+		cpu_to_le32(FUNC_CFG_REQ_ENABLES2_ROCE_MAX_AV_PER_VF |
+			    FUNC_CFG_REQ_ENABLES2_ROCE_MAX_CQ_PER_VF |
+			    FUNC_CFG_REQ_ENABLES2_ROCE_MAX_MRW_PER_VF |
+			    FUNC_CFG_REQ_ENABLES2_ROCE_MAX_QP_PER_VF |
+			    FUNC_CFG_REQ_ENABLES2_ROCE_MAX_SRQ_PER_VF |
+			    FUNC_CFG_REQ_ENABLES2_ROCE_MAX_GID_PER_VF);
+	cfg_req->roce_max_av_per_vf =
+		cpu_to_le32(le32_to_cpu(resp->roce_vf_max_av) / num_vfs);
+	cfg_req->roce_max_cq_per_vf =
+		cpu_to_le32(le32_to_cpu(resp->roce_vf_max_cq) / num_vfs);
+	cfg_req->roce_max_mrw_per_vf =
+		cpu_to_le32(le32_to_cpu(resp->roce_vf_max_mrw) / num_vfs);
+	cfg_req->roce_max_qp_per_vf =
+		cpu_to_le32(le32_to_cpu(resp->roce_vf_max_qp) / num_vfs);
+	cfg_req->roce_max_srq_per_vf =
+		cpu_to_le32(le32_to_cpu(resp->roce_vf_max_srq) / num_vfs);
+	cfg_req->roce_max_gid_per_vf =
+		cpu_to_le32(le32_to_cpu(resp->roce_vf_max_gid) / num_vfs);
+
+	rc = hwrm_req_send(bp, cfg_req);
+
+err:
+	hwrm_req_drop(bp, req);
+	if (rc)
+		netdev_err(bp->dev, "RoCE sriov configuration failed\n");
+}
+
 /* Only called by PF to reserve resources for VFs, returns actual number of
  * VFs configured, or < 0 on error.
  */
@@ -759,6 +809,9 @@ int bnxt_cfg_hw_sriov(struct bnxt *bp, int *num_vfs, bool reset)
 		*num_vfs = rc;
 	}
 
+	if (BNXT_RDMA_SRIOV_EN(bp) && BNXT_ROCE_VF_RESC_CAP(bp))
+		bnxt_hwrm_roce_sriov_cfg(bp, *num_vfs);
+
 	return 0;
 }
 
-- 
2.5.5


