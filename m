Return-Path: <linux-rdma+bounces-6676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF19F8D91
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 09:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD611887634
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ED919F11B;
	Fri, 20 Dec 2024 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hHlcEqoR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AA13AA35
	for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734681891; cv=none; b=du7RkvWenN5iEHPVP/S+ai7ZvE3zrLcvUkZgekBow5LgcicFEv42jXT7/Yr8R7bEN10f97ePvRhmizFNxE9XOD9IqQEC7Fygw8pbjuEEQ/QVwDos/p3jhRPPnq/BrzBMYv2tYlqEt0sEcAHVnoEbFbisZjQXfe+oCMuoIWNzgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734681891; c=relaxed/simple;
	bh=iqP+AKHncRRW1v7pSIjDi+2QGioEzbR3jF09S+T1n9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1H1qU+0KMI2Nz8nmQX9BhAeBkVZJxJRfQtePR/o9XcQmNuKZYVDYOLRuW8kRZgEtIJLIFvEcpe+GtZ81/4GG2kqDv7pSWj4ZE9KIK5pXYzt78Rr+JVMFYZidMx7+rm0Zj/xkwoWKbWQbKdQ32WlFMrvhXL32j+KuGxGVykCM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hHlcEqoR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21619108a6bso13462655ad.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 00:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734681889; x=1735286689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMJQwnl2sCYPdIeEKUIqIstOtYIfE+X6wNghWVXIcdU=;
        b=hHlcEqoREBfHz+8BBkYqCFAUyihSUPW+o5ZbkbP7sXV+KFZoElAwYNGpNjIP8THqA8
         mSWkGkYtB0xeSIuKvNYPX0FaKtfqLUTgjjoES/GE2E0hfJAFnvtmrNzY2SRw6N3yeods
         SY2mT4GdzIaKBhTWXhMcdHb1VH5bsY1fAEucY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734681889; x=1735286689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMJQwnl2sCYPdIeEKUIqIstOtYIfE+X6wNghWVXIcdU=;
        b=Roz+gGc7PSvm0AyPtcC1ODQFDFYtiuJJ0zcR53K4AcSkGe0umob4Ki8ZmV0o5pJ1ge
         NsTiL3A7OYs5Qg7GqUp03wud7eMhHG2x9WsTTh2BdS/RqP6+DQineLvxo2BYzOegdqdK
         MeJaMGIcocInxR8tn0ApBDXyvHADXsDgWGaw6TYJiHsFcQ4E1O3jYn1TRkiwe7XezSgR
         HTw7SWX3Hpl9IX9pGzjHrVTu082c+GOhc+EJlaI7Ty5fG01DcVKlpT2SgmYFP89o/yTV
         vzTs6Bz3GYrH6ZqlAFjRXvWtBaPyfcZojkvmtBv4qYTg0Tdjurf0RX5os9qYSiX2VFWt
         fQoQ==
X-Gm-Message-State: AOJu0Yw/CHEvdQNrd65vHrF1ODAMDH9ItkaMpEjfCyNffglP0ICAuO/o
	fY6pkNX1YP2IPT1WZGy8vG987wnpkAmsOg5jaJuBSbMvf3AXE+JDzWwnT4Jw5A==
X-Gm-Gg: ASbGncvXW86XR8pHEMj/oR4MXCNdV2nzx+bWxI7uU5KXvPIRXw7Q68qV5kGAN/FUU5+
	CDTRQsV6SE26R6y8Pa5slGXbWxbeawzNbVwm5K46fgdn5KfRYTlOMubaP2Y1oQL8wcOtfh7mvtb
	6tMs5UOzJ7+F5E5d/JrdYlZa0/TTpa8rjqscbuJ1V6a27vQ0VKX95gJRqUFkrGhhjXLGagbEPFd
	NqFKfahvYHBGNeu5Co1QNcvOuZOUUjpWfoWLacOnSpNjtKstkQuWAnXQKXpxBNFMQTjeq2sRjGn
	TR7IoITR/aXt8Y2ekhb10UxewmsJLJ/qwLLAgIVE0MKZQaB14v2cmqFv0p8=
X-Google-Smtp-Source: AGHT+IGi70dvgUf8vlGdsV9bDEEU9k8ouvnS2cVO3E2GvLz2PKcm5AxhC2ZRV9hXp9pFU7XWuLs9HQ==
X-Received: by 2002:a17:903:230c:b0:216:1543:195d with SMTP id d9443c01a7336-219e6eb3a5dmr25275175ad.25.1734681889185;
        Fri, 20 Dec 2024 00:04:49 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde66sm23663065ad.145.2024.12.20.00.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:04:48 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-rc v2] RDMA/bnxt_re: Fix error recovery sequence
Date: Fri, 20 Dec 2024 13:29:20 +0530
Message-ID: <20241220075920.1566165-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed to return ENXIO from __send_message_basic_sanity()
to indicate that device is in error state. In the case of
ERR_DEVICE_DETACHED state, the driver should not post the
commands to the firmware as it will time out eventually.

Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
as it is a no-op.

Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
V2: No changes since v1 and is just a resend.
V1: https://patchwork.kernel.org/project/linux-rdma/patch/20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com/
---
 drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b7af0d5ff3b6..c143f273b759 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(struct bnxt_re_dev *rdev,
 
 static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
 {
-	int mask = IB_QP_STATE;
-	struct ib_qp_attr qp_attr;
 	struct bnxt_re_qp *qp;
 
-	qp_attr.qp_state = IB_QPS_ERR;
 	mutex_lock(&rdev->qp_lock);
 	list_for_each_entry(qp, &rdev->qp_list, list) {
 		/* Modify the state of all QPs except QP1/Shadow QP */
@@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
 			if (qp->qplib_qp.state !=
 			    CMDQ_MODIFY_QP_NEW_STATE_RESET &&
 			    qp->qplib_qp.state !=
-			    CMDQ_MODIFY_QP_NEW_STATE_ERR) {
+			    CMDQ_MODIFY_QP_NEW_STATE_ERR)
 				bnxt_re_dispatch_event(&rdev->ibdev, &qp->ib_qp,
 						       1, IB_EVENT_QP_FATAL);
-				bnxt_re_modify_qp(&qp->ib_qp, &qp_attr, mask,
-						  NULL);
-			}
 		}
 	}
 	mutex_unlock(&rdev->qp_lock);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 5e90ea232de8..c8e65169f58a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
 	cmdq = &rcfw->cmdq;
 
 	/* Prevent posting if f/w is not in a state to process */
-	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
-		return bnxt_qplib_map_rc(opcode);
+	if (RCFW_NO_FW_ACCESS(rcfw))
+		return -ENXIO;
+
 	if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
 		return -ETIMEDOUT;
 
@@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	rc = __send_message_basic_sanity(rcfw, msg, opcode);
 	if (rc)
-		return rc;
+		return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
 
 	rc = __send_message(rcfw, msg, opcode);
 	if (rc)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 88814cb3aa74..4f7d800e35c3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 
 #define RCFW_MAX_COOKIE_VALUE		(BNXT_QPLIB_CMDQE_MAX_CNT - 1)
 #define RCFW_CMD_IS_BLOCKING		0x8000
+#define RCFW_NO_FW_ACCESS(rcfw)						\
+	(test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||		\
+	 pci_channel_offline((rcfw)->pdev))
 
 #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
 /* HWRM version 1.10.3.18 */
-- 
2.43.5


