Return-Path: <linux-rdma+bounces-12879-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF14B30D3D
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FBBA08919
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E500A28C878;
	Fri, 22 Aug 2025 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PjzQ3sGj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16611245019
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835397; cv=none; b=VOpqMg33BeENRifzatuhjo8ZrIvOsd4Kz7wgA22hmKyEfcBkLoovNp2JnV7wvN647MtiZmoMeG3GKmpRlrJsZ70d6jIOwuSUs9inDRUZanvWdnWdraLgNcZdVe6NnjmR1Dx+O0fAzQeJjAAnN2vHfY8GzV8hPvVIAZKpiNoZKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835397; c=relaxed/simple;
	bh=Cg9f4qbtnLiKGCb8IAHrXciUEFDi5ch7WoJlXdSbRf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3gHGAfRxYtjFbWow8kTK3P4aBIn/3fYolqsi2eGkt26908fu8/EVmlHznrzABaR5BP97ZtFMUDjRDbwUJeA7LsYXaaXspIbr40peUngzZcTI+GLECzmxKrzgr9scISPCREtHzKKWmbF+uCiCB/MarQmWgDUuqEbrH75p15njTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PjzQ3sGj; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-245f2a8fa81so19264975ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835394; x=1756440194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC+7q7NodIH0hjI+zyTrTYXj61OEWS4pX8bCO/8fuzk=;
        b=L8CNuvVh3bLw8+7LKi54zjYbSHto57gr8N4izazaXPl98WV/fg/lMwqqqXHwP4TW+A
         R0I61akrlCHoNDRYqt2t+YMNVa49tXyZPQc7o3ngYaid1C/4TzPbqJ3YTT0c8Kx9fgos
         LBvAtjFcuhV8UqxgUciWAiDHpeV0+3m4UB0gWthJEOanWS8ta0mBRzvhbKuggGLKb3W/
         2UzWAKjWR99069zyVpgX7J1gY+x5WncDDGhZvaRpi/qditrEuHkb0fhUrX99VC8eDSzP
         b/HVWeLb9Xcnz55Z9HW9Sf8q5UTIhncGjShNV7Vsr3EPrW6jrAsEG+zfN8WaQZ3YJoab
         qbDw==
X-Gm-Message-State: AOJu0YwaxWKspL1xJujkwKV6ENS9a+tkPjl0s6z4Cf7UIyCS9dHhj4VZ
	7wVy6R+SlupdvLwtmRjTE7gbivbCR92Rs9at1n1CqW7ySAtVb9uVE3709vx1fhifZvx7aKdCKRi
	S5poP1BvHA5D4n0iTR0vuI05Re5GPNmCrPLWSKLBfY8X6Tw7HxGlNimfqJSQrfSA/Jtj98xHYys
	9ehBqxEVGyrAhmXJn8a6b8BoyP9rNxgXyUIXuGn8JSuYtqwYCXOWsw3jgkoliQjYxLyWMMsYYN4
	f2MoXMZOT9bRnLGRUIHHouBwf0GVA==
X-Gm-Gg: ASbGnctWBWuukZn8q+UkH3gmcufjxInpk/J7MiFI6wfoQQxtTdVl5q3nnYF6XCHts2N
	ydlebJlAeAQfGPTfCj4SHT+aoxHM5ZgEVKstaUa2T/3fHF3gVIKDU6Pk74gPw3KVk92ElNr9989
	HzsQRk0md/8dss+aUMQ2kP1LTLyyrIfAfx/wPWXN0ILUtXEJFPbzBoU/sDG4rC4PJ5g9vme83lH
	iHGC+ULqrTWTL5t97le6T/QWFPTYsDpFxuhRv9q0J+FZdqng9ESYiaUPIgMxJm72TKXM6azqVYx
	wPHNpWomgWzH3bbbugRDDYhUknLLN/xvh+W+6F7oB7dv3fmGlJ0eJtLjfFn0egh5XtdpCH1iLKI
	djSq+KOJRx2zxBpHKDQ6bYxmAe3QS7dNcSQM+VJ9doeBpYn4cKu+va53uP1Hl4VXY2rRCaQAuAC
	4Q8o+0SiA4SGN6
X-Google-Smtp-Source: AGHT+IEIAriDcu2Ulh2+tjFBAJn3KoLqICAJOtDz3VX9d/UarVTS9l8zJ67T1rzvig1FIXqB7FHVKZgAqe+e
X-Received: by 2002:a17:903:2441:b0:234:9fe1:8fc6 with SMTP id d9443c01a7336-2460245b12cmr66366645ad.18.1755835394192;
        Thu, 21 Aug 2025 21:03:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2461879b281sm2589755ad.11.2025.08.21.21.03.13
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:03:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47158d6efbso1328795a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835392; x=1756440192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC+7q7NodIH0hjI+zyTrTYXj61OEWS4pX8bCO/8fuzk=;
        b=PjzQ3sGjgzizBbriQO8/r5O5f/DaSvdPx2PvkuqbaXCkIrjhjHD975/1yPDa9TT9pS
         h8L73GZ146xTcpbJVxt36KoFUtvJl3rKAjEDWTlNquzQeFqPILKy6E5hWYMQ97/c+2dT
         aW7JZUIh3PIJoSFLuEx37XpS6+TF03nhFyd5Q=
X-Received: by 2002:a05:6a20:3d86:b0:243:78a:82d0 with SMTP id adf61e73a8af0-24340e280b1mr2214610637.29.1755835392296;
        Thu, 21 Aug 2025 21:03:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d86:b0:243:78a:82d0 with SMTP id adf61e73a8af0-24340e280b1mr2214572637.29.1755835391832;
        Thu, 21 Aug 2025 21:03:11 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:03:11 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 09/10] RDMA/bnxt_re: Use firmware provided message timeout value
Date: Fri, 22 Aug 2025 09:38:00 +0530
Message-ID: <20250822040801.776196-10-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Before this patch, we used a hardcoded value of 500 msec as the default
value for L2 firmware message response timeout. With this commit,
the driver is using the firmware timeout value from the firmware.

As part of this change moved bnxt_re_query_hwrm_intf_version() to
bnxt_re_setup_chip_ctx() so that timeout value is queries before
sending first command.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Co-developed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  3 +++
 drivers/infiniband/hw/bnxt_re/main.c    | 33 ++++++++++++++-----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3a219d67746c..4ac6a312e053 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -288,4 +288,7 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
 #define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P7	192
 #define BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P7	192
 
+#define BNXT_RE_HWRM_CMD_TIMEOUT(rdev)		\
+		((rdev)->chip_ctx->hwrm_cmd_max_timeout * 1000)
+
 #endif
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 059a4963963a..3e1161721738 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -80,6 +80,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 static DEFINE_MUTEX(bnxt_re_mutex);
 
 static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
+static int bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev);
 
 static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 			     u32 *offset);
@@ -188,6 +189,10 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 	rdev->qplib_res.is_vf = BNXT_EN_VF(en_dev);
 	rdev->qplib_res.en_dev = en_dev;
 
+	rc = bnxt_re_query_hwrm_intf_version(rdev);
+	if (rc)
+		goto free_dev_attr;
+
 	bnxt_re_set_drv_mode(rdev);
 
 	bnxt_re_set_db_offset(rdev);
@@ -551,7 +556,7 @@ void bnxt_re_hwrm_free_vnic(struct bnxt_re_dev *rdev)
 
 	req.vnic_id = cpu_to_le32(rdev->mirror_vnic_id);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
-			    0, DFLT_HWRM_CMD_TIMEOUT);
+			    0, BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_dbg(&rdev->ibdev,
@@ -571,7 +576,7 @@ int bnxt_re_hwrm_alloc_vnic(struct bnxt_re_dev *rdev)
 	req.vnic_id = cpu_to_le16(rdev->mirror_vnic_id);
 	req.flags = cpu_to_le32(VNIC_ALLOC_REQ_FLAGS_VNIC_ID_VALID);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_dbg(&rdev->ibdev,
@@ -597,7 +602,7 @@ int bnxt_re_hwrm_cfg_vnic(struct bnxt_re_dev *rdev, u32 qp_id)
 	req.mru = cpu_to_le16(rdev->netdev->mtu + VLAN_ETH_HLEN);
 
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
-			    0, DFLT_HWRM_CMD_TIMEOUT);
+			    0, BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_dbg(&rdev->ibdev,
@@ -619,7 +624,7 @@ static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_FUNC_QCFG);
 	req.fid = cpu_to_le16(0xffff);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (!rc) {
 		*db_len = PAGE_ALIGN(le16_to_cpu(resp.l2_doorbell_bar_size_kb) * 1024);
@@ -644,7 +649,7 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_FUNC_QCAPS);
 	req.fid = cpu_to_le16(0xffff);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
@@ -672,7 +677,7 @@ static int bnxt_re_hwrm_dbr_pacing_qcfg(struct bnxt_re_dev *rdev)
 	cctx = rdev->chip_ctx;
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_FUNC_DBR_PACING_QCFG);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		return rc;
@@ -932,7 +937,7 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 	req.ring_type = type;
 	req.ring_id = cpu_to_le16(fw_ring_id);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to free HW ring:%d :%#x",
@@ -968,7 +973,7 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
 	req.ring_type = ring_attr->type;
 	req.int_mode = ring_attr->mode;
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (!rc)
 		*fw_ring_id = le16_to_cpu(resp.ring_id);
@@ -994,7 +999,7 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_FREE);
 	req.stat_ctx_id = cpu_to_le32(fw_stats_ctx_id);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to free HW stats context %#x",
@@ -1024,7 +1029,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 	req.stats_dma_length = cpu_to_le16(chip_ctx->hw_stats_size);
 	req.stat_ctx_flags = STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE;
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+			    sizeof(resp), BNXT_RE_HWRM_CMD_TIMEOUT(rdev));
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (!rc)
 		stats->fw_id = le32_to_cpu(resp.stat_ctx_id);
@@ -1984,7 +1989,7 @@ static void bnxt_re_read_vpd_info(struct bnxt_re_dev *rdev)
 	kfree(vpd_data);
 }
 
-static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
+static int bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
 	struct hwrm_ver_get_output resp = {};
@@ -2003,7 +2008,7 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to query HW version, rc = 0x%x",
 			  rc);
-		return;
+		return rc;
 	}
 
 	cctx = rdev->chip_ctx;
@@ -2017,6 +2022,8 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 
 	if (!cctx->hwrm_cmd_max_timeout)
 		cctx->hwrm_cmd_max_timeout = RCFW_FW_STALL_MAX_TIMEOUT;
+
+	return 0;
 }
 
 static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
@@ -2223,8 +2230,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	/* Check whether VF or PF */
 	bnxt_re_get_sriov_func_type(rdev);
 
-	bnxt_re_query_hwrm_intf_version(rdev);
-
 	/* Establish RCFW Communication Channel to initialize the context
 	 * memory for the function and all child VFs
 	 */
-- 
2.43.5


