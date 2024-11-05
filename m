Return-Path: <linux-rdma+bounces-5758-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E39BCA3A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 11:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5991C220D6
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 10:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A91D27A6;
	Tue,  5 Nov 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aYbLsemr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296F1D26F6
	for <linux-rdma@vger.kernel.org>; Tue,  5 Nov 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802019; cv=none; b=R/OealiWp4uU9ONGO8iYaX5YpNZX87/mGDeVE1zvIZ17Et4R/VJ70tFSnK+FsRRegeqmBfCvihCBwaxDyJlfu4NqkiMJXeROvNqO1Ekqg3RRwMuE6mS+zBcQ+VVqJay0sAI1pNIWmUHf/2ke6UaUIrRT/gk9huHPe5uroRC/nJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802019; c=relaxed/simple;
	bh=yxkLjsadHPREpDRm/+wXaWXNQwMM8hEsZuHOPGHYO1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DFgosJ/TRhbIFFz+gto9ov2iXGXg8pl6xArqEk7hbsontxmdSardAbFDujguMkcGfw7iTldZEqxqGI1uCnN2izc3NV1Olp88UIpxVZ3QbWCHFmv9y/lbuDom5udAnUoTposEWi42x/xqwMuhgcpNgZWG5JGzFvp9ajdh6krxg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aYbLsemr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bb39d97d1so49794305ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2024 02:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730802017; x=1731406817; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybEBiux5Vv094dow5Dgd8OUinGfy5EcIFBDeKW/z2xM=;
        b=aYbLsemrlF4d09ZEvmHirDJnneEzrh/+Lws6CfcZOHtcssGyVOEShZREPpMPvf/OxW
         BogGj+Fgc1PtUnK/VWkWw90yWBkWdCH+QIXLxmUxlrIan3OjbgBF5vbieKE7mWCMQNmG
         kCaRmUbRB6EhtGtLrvmOaQ5wAWvX9jtlYNCbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802017; x=1731406817;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybEBiux5Vv094dow5Dgd8OUinGfy5EcIFBDeKW/z2xM=;
        b=g6+M4gfVLJVmUN8y4BIn++9C8T7CoQniSWdYt6f83mXTghMCgIJ01FfG5nJheaJ+32
         ZI5FOeD9OTSiVNSz6TRww/Awk/kAgycZSJdGM1hVtxEkciNDuvMjPo2pmRLJYK2AVT60
         uh/Mfk4vNCyCEE+76aoZ9Zb+Pleg2depsWVHUcXDBqsGT/THz6J07su2Q0wgfVn69saR
         pA2Z8JscYs4I2oEAj6Sl1ha/gbX/yGfIJRiXZLjXyLryE9GyOQCOhFqfFO/ZWWdRUKrS
         YVkUO2DWCmlt8VMF7OAAhCJlbn+JJx5//lKd4xY1LsEW2E3xUXsoBiKiaJpqIruY+iHM
         CJXg==
X-Gm-Message-State: AOJu0YxlzrCrVI/RwHSPEKWTGpeDtSLIGGGIcRle89YSFKth/24WcBg4
	mqOEwpBHphS+i0GBQnRgZgKSmIBFIlnl9m4s6P+ytWtfbpXHaB0FsqrSsK3ubg==
X-Google-Smtp-Source: AGHT+IEZuF405u/BIKY2Rz3IY3Chwlo8hZQsK1zAoTaAHaTfH2ThjwFUR2H2ehO99L97YcxOv21KLw==
X-Received: by 2002:a17:902:f546:b0:211:18bf:e91d with SMTP id d9443c01a7336-21118bfe962mr243862045ad.27.1730802016735;
        Tue, 05 Nov 2024 02:20:16 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105707132sm75306615ad.96.2024.11.05.02.20.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:20:16 -0800 (PST)
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
Subject: [PATCH rdma-next 1/3] bnxt_en: Add support for RoCE sriov configuration
Date: Tue,  5 Nov 2024 01:59:10 -0800
Message-Id: <1730800752-29925-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1730800752-29925-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730800752-29925-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Vikas Gupta <vikas.gupta@broadcom.com>

On firmwares which support RoCE VF resource management by the
NIC driver, configure RoCE sriov resources while resources for
the VFs are allotted.

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


