Return-Path: <linux-rdma+bounces-12757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A0B2641A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B621897549
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEC1318156;
	Thu, 14 Aug 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MaTapeQr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517581EF39E
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170407; cv=none; b=GhuKy3PDGa2o2v3Zo0MU51jtHdr2x6CLk48MWqJp6G+iRKiJZTMVVcFdJzTVzOIgeA991NDhdP75hQn0vV4y7672oSaw8tbfbSJ0+02p5YVtQMDRWGJceS27qO3KDPsbk6u5aTU65cv2/LO6U/Vwl6c53e1OkW3CL+2vfG2C4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170407; c=relaxed/simple;
	bh=08q+AcR75uIxsyQ4mPiVdJGvSDE16zcM2fZPP6N7z2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNavhRVHksFweXMVQ2iPDP0Das/Dr9NdseLvsBWEoYVZNZ10wuUi5hOH0m9RhW0JTE6M/qTan8E2NQ4F1ETgOuOQBmE/Md6L5jZ7G76x18PnEpin48W2gV3scyWFJKziykTlBjJEZp4fd0YHdCygmDY4P7UXiHVHWdZpyCp1kJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MaTapeQr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4716f46a2eso518481a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170405; x=1755775205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNmMnaIXsCk2Pjj55YxHNpeiIQ1EmgVMwNMoh6yFOKg=;
        b=MaTapeQrRYSiKGSzIwqUzZ6TkkA2UUAxPF7wrtXObRejT6GXqVf9nQaT2QI68XJsZD
         8XMQerJdf+RZ9u43hmPjcsMFO0kA6j7hSoZPjQKySm4xhuZHweZrbFKqKV0qK78A5eHw
         V/seI+CXr+EhjyRZZP6vqOmzjnEM8T3BkYnsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170405; x=1755775205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNmMnaIXsCk2Pjj55YxHNpeiIQ1EmgVMwNMoh6yFOKg=;
        b=ckGyI0pqgFc+nmhib/o3Dxa66y+/sd2Rtm/PRQj13qxu0ME3Dpi2/AuWNbpPayo08k
         boSoN+TikTO4PEOFDMUpIcR+azceGQu+RUvq2X/7afiEbcJIPgg5hZE4E1EHoCYVBDy1
         RUfcbswvusguyQ2ynKnDsT78K2oRZ9078BjnHGccGvJ4cF6DSa2iZyC/W/8KdpMYGVr0
         +x4JLe06zsMjhE0Zzf31JKp36DbGsZesdwsYA5l1R1xd984HfjHEUNN0Ae0ZqxC0Pm0U
         l3g06CkKWrtsodU0x3vlAZJwoYLMvdz1UTK93NfSI9eXSOP5WIhtp5NhwwaSrt0n7+vq
         Efyg==
X-Gm-Message-State: AOJu0YzNF4qKGjcgBFeYaNL8sepvjL1hW4d7wSorkI9COgDjgLooK+1d
	LQbeTYX7GNbFS4Wk5Pjmb1nTWZOiHXNH/BeSgwehV/cdDAEztqCARCPt/qHHS4nafQ==
X-Gm-Gg: ASbGncvKwzSdtgk5pURuCHJPhvadHLEkGPXNFdkWMN3vVqg9LVW4pNL91o2tmS+JKw/
	QebH8ozvBKNuhtyf1+sTDIlVjZPQ/5REXgx7dRxWOhe7Cp1kyU3QtqlE3U3cUAwZEzP7NyDIK0W
	5Q8Dn8oiAH4Vf1LTMkoQTiP9zchgj1HsSxZdWlkSUEiGLsDc1vFnwepe+zXXsuj3ydo3xF4eM2B
	8nRa5mFoMPDYa0JHt5NOj+33dHrjj/+uOHylqFcczep7FCR0x2ImocEMq3BIvXDlvF6OOgQDYvR
	7yKEGRwJPSHlWEHDJ4UpUwKPE7bKE4qt21v05ORyH58Xc0ov05/wp2iCXc4X2NrrfV9KHU/KFkp
	GJ/dGKYjIVLOht0UwsiRWBuGSESfeJgUDQVEjbHSxdFfh3rkusVp07tK4Xo9Fih0jSCSd8UcRkx
	RF/5Rk7fHJFHLYDr5VDa1TgrZQyrdPGw==
X-Google-Smtp-Source: AGHT+IF4kZ1ibD6VIQH89JwmdhgJURjpUlLoBXelEkH3/PUg2xJNqf44m/ApA4dU6egfRx2BiL9svg==
X-Received: by 2002:a17:903:3c25:b0:240:99e6:6bc3 with SMTP id d9443c01a7336-244585190a7mr42039825ad.20.1755170405398;
        Thu, 14 Aug 2025 04:20:05 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:20:05 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 5/9] RDMA/bnxt_re: Optimize bnxt_qplib_get_dev_attr function
Date: Thu, 14 Aug 2025 16:55:51 +0530
Message-ID: <20250814112555.221665-6-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>

Optimize bnxt_qplib_get_dev_attr() by separating out query_version which
uses creq notification method to host. Due to serialization of cmdq by
firmware, expected latency in response to heavy multi-threaded rdma
applications might be observed.

This patch separates the version_query logic out of device attribute
query and called only during rdma driver init.

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c     |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 15 +++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a66da4892ad4..1c474b3707ce 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2135,6 +2135,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	if (rc)
 		goto disable_rcfw;
 
+	bnxt_qplib_query_version(&rdev->rcfw);
 	bnxt_re_set_resource_limits(rdev);
 
 	rc = bnxt_qplib_alloc_ctx(&rdev->qplib_res, &rdev->qplib_ctx, 0,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index ce6ec3412c11..79edff6bda95 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -66,14 +66,15 @@ static bool bnxt_qplib_is_atomic_cap(struct bnxt_qplib_rcfw *rcfw)
 	return (pcie_ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ);
 }
 
-static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
-				     char *fw_ver)
+void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw)
 {
 	struct creq_query_version_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_query_version req = {};
+	struct bnxt_qplib_dev_attr *attr;
 	int rc;
 
+	attr = rcfw->res->dattr;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_QUERY_VERSION,
 				 sizeof(req));
@@ -82,10 +83,10 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return;
-	fw_ver[0] = resp.fw_maj;
-	fw_ver[1] = resp.fw_minor;
-	fw_ver[2] = resp.fw_bld;
-	fw_ver[3] = resp.fw_rsvd;
+	attr->fw_ver[0] = resp.fw_maj;
+	attr->fw_ver[1] = resp.fw_minor;
+	attr->fw_ver[2] = resp.fw_bld;
+	attr->fw_ver[3] = resp.fw_rsvd;
 }
 
 int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw)
@@ -179,8 +180,6 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw)
 	if (_is_max_srq_ext_supported(attr->dev_cap_flags2))
 		attr->max_srq += le16_to_cpu(sb->max_srq_ext);
 
-	bnxt_qplib_query_version(rcfw, attr->fw_ver);
-
 	for (i = 0; i < MAX_TQM_ALLOC_REQ / 4; i++) {
 		temp = le32_to_cpu(sb->tqm_alloc_reqs[i]);
 		tqm_alloc = (u8 *)&temp;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 09faf4a1e849..e9834e7fc383 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -358,6 +358,7 @@ int bnxt_qplib_read_context(struct bnxt_qplib_rcfw *rcfw, u8 type, u32 xid,
 			    u32 resp_size, void *resp_va);
 int bnxt_qplib_query_cc_param(struct bnxt_qplib_res *res,
 			      struct bnxt_qplib_cc_param *cc_param);
+void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw);
 
 #define BNXT_VAR_MAX_WQE       4352
 #define BNXT_VAR_MAX_SLOT_ALIGN 256
-- 
2.43.5


