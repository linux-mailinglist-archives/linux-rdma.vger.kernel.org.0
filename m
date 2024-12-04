Return-Path: <linux-rdma+bounces-6226-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACCC9E34DA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 09:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07A7168EAC
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E453D1AB6D8;
	Wed,  4 Dec 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XHr9cZAM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459A1AB507
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299106; cv=none; b=h/cAuz+AegtG3j7tWkU1mzGS2FBI+QvkDHyHDmKLZZ1nAV4M1vAM8RPR3OUCySnJ93y05DxcLP+FFc1D40AXJULpPs1HwYEZvr4n25CatAF2Exr8gwazhMGHZXUi9u8pKr81UGGVGK/pZICDx6wyRnqKgB12AOqUUSAZ3D6gAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299106; c=relaxed/simple;
	bh=0AUgE1XLpNSRrWqknjC6w8a9mTjMITV/m04kpyO7nUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4pf/CDJ+GfTi774i2RhZhU030C88C/ON/WsJWlcNgQKceUusxVVaKDeDstkGtp11XLs5s1QysDQpMB6bDFEzayovbr9vZj16y3P8I7tOezblmG2yE+SXXHFSeCM+hp87HgXpgdmh8FI7vkWsr2B3nVMnJzyMrottwE13hlAboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XHr9cZAM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fcc8533607so2502795a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 23:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733299104; x=1733903904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y28z4x12nd1yE+fAapxIoTKDGpVRUmQlIwTCyRc3HSc=;
        b=XHr9cZAM9K2z3Yq6texLLRrjRn5E/VcyCsPCracG1es1sq6gKbNaTRs154tXqFD5/A
         /Ujd3SOr+PYW52LtGH9yP1Bqd8dpDKvTP6iv4Mt6MsGzdbE418wtz92keGNzVU0PX8SO
         LOduA2YdlhXmQ0tOQaBwYWyB688sKZ3WL0IpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299104; x=1733903904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y28z4x12nd1yE+fAapxIoTKDGpVRUmQlIwTCyRc3HSc=;
        b=Q0By+k5karq6KGt+GEYuHVNLoP/kT8kDJSGDyVjEyjSPqzU5DNcaM28Oavs75G0Kc9
         n7FltlecWBgnJWRB6ua2O59ZQUb2dXZsEkrSPjtnJWH0WrmX8Gdk4GKRN6h3mhAJbPnx
         gz43x/7Epv3Bd/y9OHJRZIfRhFliagfiU4ttsL1HEDF8S1ImEJW5P4m30vKegJ4lmDKF
         irYEKa1QK2ezW4B5lsXezH+fsJpCnpgcaBQH54g/SpdTIsFq9UPLEOr+XgNhMfGeBqVS
         zW/71XetVn+AxLo5TCLlg0+4J9wP45y+HHv95cbV4A7vhDnrOq0J77L98wiMz6T7Wnfs
         k08Q==
X-Gm-Message-State: AOJu0Yy5P89wzbU8HhZkFjzxTzIJoMQvIkJHNVNs3wmyltPRJHNkkdR9
	xMDHl1eogIra4VPRTeLhf9QoZgfQj28pF1FFTht3JElnt43b41GlhD5wu/h1yg==
X-Gm-Gg: ASbGncufeHcnJRH7DZGs+vsTzq9Vg+mZF2ROvppYIAta6zPxgSbyIhhW4fRVvyg9F9T
	krQElTinGsHyJ3SWTJWm6xNnq0wdaqioKhlQA3LgRlV9nGON2rJuGaPfqsCn6nVe5wf5ykhHDgr
	eqt/CO0BEmJPQbogA9WSzScO4hM71vc/1wHYyVAK6BTglQb7fYnnLEtChgBUtOup7LD1ZKzkmZD
	9BgkibIP+q9oXYFD/SSdx1vlbKyseFPQw4gA7CpZ0oBAdK3qc2uo/KbJ8fce9SrVrJAOr0P19XO
	mK12rqw7RzEFynSZ8nlvLLK2B1qAKttd8qK/TPKR6gCnXnHUQ9WO
X-Google-Smtp-Source: AGHT+IHnjob4t2N5tj4QPhw9+p76RUrHIwZtktWajJ9bi/2FI1t6qVv8bMrbdAMUVRtyR/xrmUVrLQ==
X-Received: by 2002:a05:6a20:8421:b0:1e0:d618:1fba with SMTP id adf61e73a8af0-1e165337768mr6932356637.0.1733299104405;
        Tue, 03 Dec 2024 23:58:24 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21536d67e95sm95462235ad.76.2024.12.03.23.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:58:23 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
Date: Wed,  4 Dec 2024 13:24:15 +0530
Message-ID: <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
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

Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
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
2.31.1


