Return-Path: <linux-rdma+bounces-12878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF0B30D35
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7955E8B59
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B55291C1F;
	Fri, 22 Aug 2025 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hMC1zOky"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA72836A3
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835392; cv=none; b=E2aaEcFsVQucDOSmHwpqrw4JtZmJEvyx+gxH2CXk5FaGp8xNx3ihX6s8qnvYwE8UX2IkvSR4vqFlXNFOoHxJq5wDbwSk0ianzoV+ihde5oDwTGHWZMHUlpimyJPtz7wk6B4ndpqNOzZchwediW5bmkEfZm4kUmjlT8PBawldB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835392; c=relaxed/simple;
	bh=8eHMI1dJpNfGmRPMeGeM17UxD4c2koHw4cAWay6VUcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaPdEKegRElSjmXXegsnYWbMojLyPWkLXlM7Nj4BXJwWOU7XqyjsuUv37+ia6vUPkifYXk5JMYxFLFYqqNtZ/ge9m9nloH41sJCKTpiOqqKGv5zpKs9OSuGifL0ELyIWbS5JoK2hohDzCgPUu2+5D4soNQz3Eo5JwodH+NY78O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hMC1zOky; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-323266cdf64so1300698a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835391; x=1756440191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/LMB3vSl06WMEV8FB1/kl58VTo4A3MhmlzJXN+ClZA=;
        b=hwD08y0VXGmRQeL3Lg1eXMgMm3irZNriqiTUSgX+jF186iXxbhQ+tu1EFV/In851Yz
         O6sRn51vJih+BO6JKl/C5wt6gcjIO6b/y7taQm2b+2UUhb5rtfZMsEr+X5rCajoBITrE
         QmLS2SB8K5eUOLP+8Rabxpn0FOY8j749vuj7WH0MoQkw8jgdZ9iqSzflAgChBof6yRfL
         N0TghT/8+03E/0NOrg3CwNvdmch5Ghfwi4pGkVAyW1kGAUNRP2Obk+hD8hFot4NUx6Tf
         /z/t0gEtdiUUq7rlNEIRLxyJ0F6RR2SkuWaiz/k34kb1MQXC5OqIwyXN5Jsw5yNVD18C
         VPqA==
X-Gm-Message-State: AOJu0Yy6bN1xS87FlsG0UMKqzsGwvvUyoinZUl5cOc0f/iQC0KUH4ztd
	dsFaRpZ1lOrImYYVyRMgceib/+FoybPgN5AAoshLcpzDmVpeQu4l7h6gpfaCKLfNPiut2c2eTfZ
	VpgPC6K1y7ldOWJo+pxigAfdEzUOF1YAbZJUCVbX6mhP+SgkuiII+5eyj6FQHeg9EU2DUQ/O4/t
	G0wHlx4hrtQ/msioGRstBOGjAgQLR7ePMu1i9X2WFVggyPPHyINoNC1cchVt48T85hIZ4QzVWXW
	8NAxsjP2jc0RewuIiFWieJckgmc/w==
X-Gm-Gg: ASbGncs3Sb96Kd4KMieb0yomskolIuyZL263xf6lRFYVkYgnj70v3/u9hnFPmCRSdI5
	Yxu/VwZ2GNC95dIiUkBrIPoRR6fwVTOk4MbTROxTW4G7bWKcYchPzXZ2P5Pf0K7XdSET+Cc1aS3
	K2eBVW94BrrEqNYVgoMGIshbJD+2mkp7awYYsLNH7I3Vs5Vs4BPxkap5Ckgj+TFFeD06ul1sYIq
	31Or5jaWe99a1Ina4Sd0Gakdkm0/DEwwCfskeUNEHMOdX/1exTNk2exaXKI2b2gJxKd3dDIFo/u
	uC3QJccJoEAhFCzQEPYoAA0YFsHuXqbWcYLDfPADyRgKIUaoV8oRL9fU8O9DdY37KBpvxNn1xfn
	czyUSwXgr2VGxZlbCzN5FaLb0wULRK0csfKcu6H6zCTUZCBlQt5jN9voSsQWu3UvDe7ZXHEgqai
	Fav+mt+O/+/G3R
X-Google-Smtp-Source: AGHT+IEtr8f7kgcFUTCWFvkvF0vZEjWwISZFSoGNMcif7/YHHtLIuD26UoLCAQlsedL/sdQpig29nScj3/MK
X-Received: by 2002:a17:902:c105:b0:245:f5b2:6cbb with SMTP id d9443c01a7336-2462efa6fe1mr16804895ad.52.1755835390708;
        Thu, 21 Aug 2025 21:03:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245ed32f978sm6806505ad.2.2025.08.21.21.03.10
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:03:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326e2506aso1685994a91.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835389; x=1756440189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/LMB3vSl06WMEV8FB1/kl58VTo4A3MhmlzJXN+ClZA=;
        b=hMC1zOkyqn5yOIdHB8bHUUNgOZTPpMi6vEcxKJxoiC9u/VR2nyGlSZuCsvBTMLcpTm
         uyi6I3gUmwpWoLnq6lArQZV3rgOk1yLye8BM03kWSZCoooTMy3TSZNQ9rwADIuy8MkeC
         3P6sAC7WUoUfS0FEJsgLHszFwd0+wh5lfpS9M=
X-Received: by 2002:a17:90b:4f8e:b0:321:38a:229a with SMTP id 98e67ed59e1d1-32515ee4be2mr2464110a91.7.1755835388866;
        Thu, 21 Aug 2025 21:03:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4f8e:b0:321:38a:229a with SMTP id 98e67ed59e1d1-32515ee4be2mr2464057a91.7.1755835388267;
        Thu, 21 Aug 2025 21:03:08 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:03:07 -0700 (PDT)
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
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support
Date: Fri, 22 Aug 2025 09:37:59 +0530
Message-ID: <20250822040801.776196-9-kalesh-anakkur.purayil@broadcom.com>
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

- Check FW capability for roce_mirror support.
- Initialize FW with roce_mirror support.
- When modifying QP, use unique GID for sgid incase of RawEth QP.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  2 ++
 drivers/infiniband/hw/bnxt_re/main.c       |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 12 +++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  4 ++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  1 +
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 90c23d0ee262..f12d6cd3ae93 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1037,6 +1037,8 @@ static u8 __from_ib_qp_type(enum ib_qp_type type)
 		return CMDQ_CREATE_QP_TYPE_RC;
 	case IB_QPT_UD:
 		return CMDQ_CREATE_QP_TYPE_UD;
+	case IB_QPT_RAW_PACKET:
+		return CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE;
 	default:
 		return IB_QPT_MAX;
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index fe1be036f8f2..059a4963963a 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -654,6 +654,8 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 	flags_ext2 = le32_to_cpu(resp.flags_ext2);
 	cctx->modes.dbr_pacing = flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_EXT_SUPPORTED ||
 				 flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_V0_SUPPORTED;
+	cctx->modes.roce_mirror = !!(le32_to_cpu(resp.flags_ext3) &
+				     FUNC_QCAPS_RESP_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 092310571dcc..43a4ef76272d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1335,6 +1335,7 @@ static bool is_optimized_state_transition(struct bnxt_qplib_qp *qp)
 
 int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
+	struct bnxt_qplib_sgid_tbl *sgid_tbl = &res->sgid_tbl;
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_modify_qp_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
@@ -1386,9 +1387,14 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_FLOW_LABEL)
 		req.flow_label = cpu_to_le32(qp->ah.flow_label);
 
-	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_SGID_INDEX)
-		req.sgid_index = cpu_to_le16(res->sgid_tbl.hw_id
-					     [qp->ah.sgid_index]);
+	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_SGID_INDEX) {
+		if (qp->type == CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE)
+			req.sgid_index =
+				cpu_to_le16(sgid_tbl->hw_id[qp->ugid_index]);
+		else
+			req.sgid_index =
+				cpu_to_le16(sgid_tbl->hw_id[qp->ah.sgid_index]);
+	}
 
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_HOP_LIMIT)
 		req.hop_limit = qp->ah.hop_limit;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index b97e75404139..5e34395472c5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -905,6 +905,10 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 		flags |= CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED;
 	if (rcfw->res->en_dev->flags & BNXT_EN_FLAG_ROCE_VF_RES_MGMT)
 		flags |= CMDQ_INITIALIZE_FW_FLAGS_L2_VF_RESOURCE_MGMT;
+	if (bnxt_qplib_roce_mirror_supported(rcfw->res->cctx)) {
+		flags |= CMDQ_INITIALIZE_FW_FLAGS_MIRROR_ON_ROCE_SUPPORTED;
+		rcfw->roce_mirror = true;
+	}
 	req.flags |= cpu_to_le16(flags);
 	req.stat_ctx_id = cpu_to_le32(ctx->stats.fw_id);
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index cfdf69a3fe9a..99ecd72e72e2 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -219,6 +219,7 @@ struct cmdq_initialize_fw {
 	#define CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED     0x2UL
 	#define CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED    0x8UL
 	#define CMDQ_INITIALIZE_FW_FLAGS_L2_VF_RESOURCE_MGMT		 0x10UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_MIRROR_ON_ROCE_SUPPORTED        0x80UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	reserved8;
-- 
2.43.5


