Return-Path: <linux-rdma+bounces-12871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0617BB30D2A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C585AC55FF
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D656027780E;
	Fri, 22 Aug 2025 04:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P4GCaXm4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01261263C90
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835370; cv=none; b=ukACN3DX8+J6S/aKYyrNiwrTh/gTXFVE86/a2npej9HTgj7VyC8pNuCOit6sZFhimUbQkVwm9UcP84NyECT+OfKbCVoCRl8HlbQEEA6lO/faBxoB6P3dYai2s0yvIz6ZKGxjWjcG08GAiP6gJwHB39YqHcSO4nmuv6/NbQnM/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835370; c=relaxed/simple;
	bh=nxUOv8dfzm63SFp8Xyv5vlUs2tMwxn8JTvMr5g9MoJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auExdmT0dbFvylPV7uBmwcFRQm42k8g+lkuTB8jSR+nGEXxiywt+sWdsehoJPtmSwlHK/a+BfW7u3RdWMEhbDG8t1TJIFSbaJ5fwZZEQawvP6GMMLZm0ixr+fk7CfOeIOKaU27q7ZM9NWsCNmrD7PWxXkz1f6+UlCUlBJ2yd5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P4GCaXm4; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-71e6eb6494eso15488017b3.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835367; x=1756440167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RmzXB/mtoS5IGKjeLpL7wv74SB+zkqtf+L6pucSh1U=;
        b=kceJyrvoEv2d5xs3c8NvFei1UN4ivxM7GVau4Zms9/mY1/HNzkFj7aczcdml7TRKva
         6tqgGdkOoZiERlpNOMK35mP4k9gg2rbynCI9xNlNR6bdt4cQNIlsU23QlIaOyxKgxsnH
         vbk2P8LfiXcvmWn59DsDjWF5JtiBkIfuqnkW1punYnRh7NfWkEriD/I4wqslxMFSDjZC
         t+qdkDeNReojHbDuxWAe2fx/H7Db5u/TL9ywm4mwzFzAEyBZeL64/YjWrD91USXpxh5R
         FGs+pcLmAQHod0GcDsw1RaC483Jj02huZoktSUJO/UqI7jJwBlpFd+BEZ8SS47c1M9hd
         bjMQ==
X-Gm-Message-State: AOJu0YzGyq+I7BuTDmL1JIoDujpa8NRECINQ+gtxWxPgC9CBMZytAHh+
	yIFhbGLqVrokYoPbiduuJ+k5RLVbVm8CaprtMJHRQvETduLwKlFDqIkwEL6SEO8Gvvk2yl9tR98
	epYR7kNQgZuJElA09Vsa0hEyXr5IuP2ip2VredoJAgajFLEMcq9ikPovGvBtrZxzpIkmFSjv94d
	ECnv2swpuVY/ntaw2Ls/ChMDCAkR5jPWbtOZ+yS+BRASgiD3u5QGnDXGR72uNMHAp8bV8dk+s3p
	9z9gA0gP3dh1cfep97TBUuxN9Td0A==
X-Gm-Gg: ASbGncsQyRwv8HmPHbtEutK2AzuUAoiDWmQ/oclzn9zhUn0uKYWS7Imp8MfqPyib5gN
	sEdp3N7Kxe3xVtE1KY8LySsWPTmENppdiTPpUeuVmZ8IXooWai3pp6siPTe0Mt+33eUImH/gDla
	WhMACOCi+y74leyfAhJiAViTX9PkO/ItzPZ4E0IojThUDvdF9tXUJC9JzEU0jmuhjsvDgABMeDX
	63Uqt1hG7d1PBez/Dk/amBy6pP8q7tWeAAgB9Bu6VjVWahCsFPzMq+YoxAKHjeYRfM7GdSTHZyJ
	uHmbQtpg1sr8nxiptU4jzNUk+V/baisOdn/eNkvVIOTrtmsAhmqu9ZUweeVs2tEE7HTgtB5c5Sc
	LRlawu4bs3xEZhpQytJQCurvjJatncayvYt/2f9jROQFKJLtHHqi0MyiHQQOj6jwCiq7ZlbGwdb
	nn+xa98bi4dGNB
X-Google-Smtp-Source: AGHT+IEHUV0bPgE006YNnEo02cEy9iQ2JrXAi+zRIT25Gaj+djPdeuxzyqRgsrjJ3XZ0wie2EyNi4duZceef
X-Received: by 2002:a05:690c:680c:b0:71f:c5f0:339b with SMTP id 00721157ae682-71fdc2a8982mr16840947b3.3.1755835367431;
        Thu, 21 Aug 2025 21:02:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71fb7bff1adsm3856597b3.24.2025.08.21.21.02.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:02:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2ea91aa9so2948040b3a.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835366; x=1756440166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RmzXB/mtoS5IGKjeLpL7wv74SB+zkqtf+L6pucSh1U=;
        b=P4GCaXm4hOcqzcKcQ62J3aWF+4PG7kVrIffeBT5Q1AUcHdAf99zlg5rYtkjY3vZQb2
         /jChr7EU2fn4M6jMAhAOVR50NayY94NdJskYtubEn2WPBjrzJDJOkmUYKTIKPm3UQOxn
         dDLX7fTjIMXsMiRBzupn7UgHVpBvrqmhFDFSg=
X-Received: by 2002:a05:6a00:4fcf:b0:748:3385:a4a with SMTP id d2e1a72fcca58-7702fad48famr1849714b3a.23.1755835366197;
        Thu, 21 Aug 2025 21:02:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fcf:b0:748:3385:a4a with SMTP id d2e1a72fcca58-7702fad48famr1849690b3a.23.1755835365729;
        Thu, 21 Aug 2025 21:02:45 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:45 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 01/10] bnxt_en: Enhance stats context reservation logic
Date: Fri, 22 Aug 2025 09:37:52 +0530
Message-ID: <20250822040801.776196-2-kalesh-anakkur.purayil@broadcom.com>
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

When the firmware advertises that the device is capable of supporting
port mirroring on RoCE device, reserve one additional stat_ctx.
To support port mirroring feature, RDMA driver allocates one stat_ctx
for exclusive use in RawEth QP.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 8 ++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 3 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5578ddcb465d..751840fff0dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9601,10 +9601,10 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 
 static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 {
+	u32 flags, flags_ext, flags_ext2, flags_ext3;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	struct hwrm_func_qcaps_output *resp;
 	struct hwrm_func_qcaps_input *req;
-	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
-	u32 flags, flags_ext, flags_ext2;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_QCAPS);
@@ -9671,6 +9671,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	    (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED;
 
+	flags_ext3 = le32_to_cpu(resp->flags_ext3);
+	if (flags_ext3 & FUNC_QCAPS_RESP_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_MIRROR_ON_ROCE;
+
 	bp->tx_push_thresh = 0;
 	if ((flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED) &&
 	    BNXT_FW_MAJ(bp) > 217)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index fda0d3cc6227..fa2b39b55e68 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2507,6 +2507,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
+	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
 
 	u32			fw_dbg_cap;
 
@@ -2528,6 +2529,8 @@ struct bnxt {
 	((bp)->fw_cap & BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED)
 #define BNXT_SW_RES_LMT(bp)		\
 	((bp)->fw_cap & BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS)
+#define BNXT_MIRROR_ON_ROCE_CAP(bp)	\
+	((bp)->fw_cap & BNXT_FW_CAP_MIRROR_ON_ROCE)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 61cf201bb0dc..f8c2c72b382d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -100,6 +100,12 @@ void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp)
 		if (BNXT_PF(bp) && !bp->pf.port_id &&
 		    bp->port_count > 1)
 			bp->edev->ulp_num_ctxs++;
+
+		/* Reserve one additional stat_ctx when the device is capable
+		 * of supporting port mirroring on RDMA device.
+		 */
+		if (BNXT_MIRROR_ON_ROCE_CAP(bp))
+			bp->edev->ulp_num_ctxs++;
 	}
 }
 
-- 
2.43.5


