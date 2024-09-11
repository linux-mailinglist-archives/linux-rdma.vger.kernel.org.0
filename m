Return-Path: <linux-rdma+bounces-4875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3766997491D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 06:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6163F1C2433C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 04:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCA43FB30;
	Wed, 11 Sep 2024 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FexQO3C9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FEC144
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028984; cv=none; b=CFHLr+bjLNNhPr1hRigxDwXIW0QKD7rE2Ep/wsCJeCGyYHz79m3vC9SfyXEHFkC2vdc46XGD5BLqyKzBQhkSyFN9ClWdP/s47bB3b/HGPJX6Bsxyv7FNZtIowxI+OBf4wczDkC6Zus4ukKg2xRG9W/PYb/9hHmLCvINjO6z5PuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028984; c=relaxed/simple;
	bh=YPvIcX2EZsZ9Jx2QA9o4RSACQ+xRLTs6IWnFEX1aX2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RmAF9PYD5LQJwmicsQpUxMD5dbPMZXzWK6sceHGonUUrSFuKCsYJ29YRSHBJ8ia5r4QwhPNfLB8lyr23S7NDCLsU7xNZYLb5u21Ktp4o9bX0oPbc8FqU4M/cvEclHMZZjeTX6qO6/UYTshgnubpwSQcPInPRfR5940feVeESt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FexQO3C9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so1468886b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 21:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726028982; x=1726633782; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQ2nrpdpUtq/LFuizqLWUBVnskmrs44so0Ymt7LDKME=;
        b=FexQO3C9CvXpqZ32+7eNV1uVjHm86uKZ+XhxpUjEkIiP3iV5nxImeFzdWWLKpA3VUq
         GJU1gFPK67BJoEdzVtjtgy6422ApqsVqp26rpPF82XNOtHTOx4k0JUs83EWfpP6cUJuM
         elALmEMyyNbDyJQC+3Ftn9paIy8YqIgcEwQqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726028982; x=1726633782;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ2nrpdpUtq/LFuizqLWUBVnskmrs44so0Ymt7LDKME=;
        b=gof9yXURrLzeINNVr4knSwMy6hfUCUOPOvscl5Vde9R4LMuT0owrCW+hNEhQM0nkBU
         0dCz7P80ATCDKmALNZu0ySe+8HcZ8evu2eALr1tUaZoUPwwrjKmovYnD6Bg4rL2wg2ZH
         06pFyHaT0mSDqfzS1FWZdmqvVCsvU8QCD2UJoZng4pJG7GJgmOoDApOMt2IlQdgPjmns
         hsXhvJ4gNIgOZITNHv8UX19Ki+G1K9RUpswW19x7Iii0dLOqlLDNw2hXtlcsM75iEo3o
         BlIS01NM8wBLN3bAlzLmNWcFDuLb5DKQjGZ8v5lQFE9WSS/vE1bbq+qejGywKq47vwV+
         FzOQ==
X-Gm-Message-State: AOJu0YwXPWBOnpgJYMgRZykDT5SXkThdBQGpv2FXhK5vBRzd93/WZFfB
	VsBaQBTlvL8RHOTtR4XyJDdQqt1+iVtJOYEqHlkXV4JHHBucel6/KWAWxG5IeQ==
X-Google-Smtp-Source: AGHT+IH4ZoUStFjdOF3Hwm4RqsQWKIFUvrHaP80wCTPGO0ufKKyZqxc7eN+6cPhzLpuupDJxY9L7IA==
X-Received: by 2002:a05:6a00:9a1:b0:713:f127:ad5f with SMTP id d2e1a72fcca58-71916e98be4mr2993771b3a.22.1726028981321;
        Tue, 10 Sep 2024 21:29:41 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095184sm2123562b3a.106.2024.09.10.21.29.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 21:29:38 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chandramohan Akula <chandramohan.akula@broadcom.com>
Subject: [PATCH for-next v2 4/4] RDMA/bnxt_re: Recover the device when FW error is detected
Date: Tue, 10 Sep 2024 21:08:30 -0700
Message-Id: <1726027710-2292-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

If the FW crashes, L2 driver gets notified and it notifies
the RoCE driver. Currently driver doesn't re-initialize the
device. Add support for re-initialize the RoCE device.

RoCE device is removed and re-attached in the ulp_stop and
ulp_start respectively. The recovery logic expects the RoCE
driver to be registered with L2 driver while its being removed.
So the driver avoids unregistering with L2 driver in the
recovery path.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   | 15 +++++++
 drivers/infiniband/hw/bnxt_re/main.c      | 70 +++++++++++++++++--------------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
 3 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 5df3ce1..e94518b 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -91,6 +91,15 @@ struct bnxt_re_ring_attr {
 	u8		mode;
 };
 
+/*
+ * Data structure and defines to handle
+ * recovery
+ */
+#define BNXT_RE_PRE_RECOVERY_REMOVE 0x1
+#define BNXT_RE_COMPLETE_REMOVE 0x2
+#define BNXT_RE_POST_RECOVERY_INIT 0x4
+#define BNXT_RE_COMPLETE_INIT 0x8
+
 struct bnxt_re_sqp_entries {
 	struct bnxt_qplib_sge sge;
 	u64 wrid;
@@ -224,4 +233,10 @@ static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
 }
 
 extern const struct uapi_definition bnxt_re_uapi_defs[];
+
+static inline void bnxt_re_set_pacing_dev_state(struct bnxt_re_dev *rdev)
+{
+	rdev->qplib_res.pacing_data->dev_err_state =
+		test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags);
+}
 #endif
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index dc63ad0..adff9e4 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -83,7 +83,7 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev);
 static int bnxt_re_netdev_event(struct notifier_block *notifier,
 				unsigned long event, void *ptr);
 static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev);
-static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev);
+static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type);
 static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
 
 static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
@@ -169,6 +169,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 
 	en_dev = rdev->en_dev;
 
+	rdev->qplib_res.pdev = en_dev->pdev;
 	chip_ctx = kzalloc(sizeof(*chip_ctx), GFP_KERNEL);
 	if (!chip_ctx)
 		return -ENOMEM;
@@ -301,7 +302,7 @@ static void bnxt_re_shutdown(struct auxiliary_device *adev)
 
 	rdev = en_info->rdev;
 	ib_unregister_device(&rdev->ibdev);
-	bnxt_re_dev_uninit(rdev);
+	bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
 }
 
 static void bnxt_re_stop_irq(void *handle)
@@ -385,14 +386,9 @@ static struct bnxt_ulp_ops bnxt_re_ulp_ops = {
 static int bnxt_re_register_netdev(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_en_dev *en_dev;
-	int rc;
 
 	en_dev = rdev->en_dev;
-
-	rc = bnxt_register_dev(en_dev, &bnxt_re_ulp_ops, rdev->adev);
-	if (!rc)
-		rdev->qplib_res.pdev = rdev->en_dev->pdev;
-	return rc;
+	return bnxt_register_dev(en_dev, &bnxt_re_ulp_ops, rdev->adev);
 }
 
 static void bnxt_re_init_hwrm_hdr(struct input *hdr, u16 opcd)
@@ -1593,7 +1589,7 @@ static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
-static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
+static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	u8 type;
 	int rc;
@@ -1626,8 +1622,10 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 		bnxt_re_deinitialize_dbr_pacing(rdev);
 
 	bnxt_re_destroy_chip_ctx(rdev);
-	if (test_and_clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
-		bnxt_unregister_dev(rdev->en_dev);
+	if (op_type == BNXT_RE_COMPLETE_REMOVE) {
+		if (test_and_clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
+			bnxt_unregister_dev(rdev->en_dev);
+	}
 }
 
 /* worker thread for polling periodic events. Now used for QoS programming*/
@@ -1640,7 +1638,7 @@ static void bnxt_re_worker(struct work_struct *work)
 	schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 }
 
-static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
+static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	struct bnxt_re_ring_attr rattr = {};
 	struct bnxt_qplib_creq_ctx *creq;
@@ -1649,12 +1647,14 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 	u8 type;
 	int rc;
 
-	/* Registered a new RoCE device instance to netdev */
-	rc = bnxt_re_register_netdev(rdev);
-	if (rc) {
-		ibdev_err(&rdev->ibdev,
-			  "Failed to register with netedev: %#x\n", rc);
-		return -EINVAL;
+	if (op_type == BNXT_RE_COMPLETE_INIT) {
+		/* Registered a new RoCE device instance to netdev */
+		rc = bnxt_re_register_netdev(rdev);
+		if (rc) {
+			ibdev_err(&rdev->ibdev,
+				  "Failed to register with netedev: %#x\n", rc);
+			return -EINVAL;
+		}
 	}
 	set_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 
@@ -1807,7 +1807,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 free_rcfw:
 	bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 fail:
-	bnxt_re_dev_uninit(rdev);
+	bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
 
 	return rc;
 }
@@ -1827,7 +1827,7 @@ static void bnxt_re_update_en_info_rdev(struct bnxt_re_dev *rdev,
 	rtnl_unlock();
 }
 
-static int bnxt_re_add_device(struct auxiliary_device *adev)
+static int bnxt_re_add_device(struct auxiliary_device *adev, u8 op_type)
 {
 	struct bnxt_aux_priv *aux_priv =
 		container_of(adev, struct bnxt_aux_priv, aux_dev);
@@ -1839,8 +1839,6 @@ static int bnxt_re_add_device(struct auxiliary_device *adev)
 	en_info = auxiliary_get_drvdata(adev);
 	en_dev = en_info->en_dev;
 
-	/* en_dev should never be NULL as long as adev and aux_dev are valid. */
-	en_dev = aux_priv->edev;
 
 	rdev = bnxt_re_dev_add(aux_priv, en_dev);
 	if (!rdev || !rdev_to_dev(rdev)) {
@@ -1850,7 +1848,7 @@ static int bnxt_re_add_device(struct auxiliary_device *adev)
 
 	bnxt_re_update_en_info_rdev(rdev, en_info, adev);
 
-	rc = bnxt_re_dev_init(rdev);
+	rc = bnxt_re_dev_init(rdev, op_type);
 	if (rc)
 		goto re_dev_dealloc;
 
@@ -1875,7 +1873,7 @@ static int bnxt_re_add_device(struct auxiliary_device *adev)
 
 re_dev_uninit:
 	bnxt_re_update_en_info_rdev(NULL, en_info, adev);
-	bnxt_re_dev_uninit(rdev);
+	bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
 re_dev_dealloc:
 	ib_dealloc_device(&rdev->ibdev);
 exit:
@@ -1958,7 +1956,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 
 #define BNXT_ADEV_NAME "bnxt_en"
 
-static void bnxt_re_remove_device(struct bnxt_re_dev *rdev,
+static void bnxt_re_remove_device(struct bnxt_re_dev *rdev, u8 op_type,
 				  struct auxiliary_device *aux_dev)
 {
 	if (rdev->nb.notifier_call) {
@@ -1972,7 +1970,7 @@ static void bnxt_re_remove_device(struct bnxt_re_dev *rdev,
 	}
 	bnxt_re_setup_cc(rdev, false);
 	ib_unregister_device(&rdev->ibdev);
-	bnxt_re_dev_uninit(rdev);
+	bnxt_re_dev_uninit(rdev, op_type);
 	ib_dealloc_device(&rdev->ibdev);
 }
 
@@ -1991,7 +1989,7 @@ static void bnxt_re_remove(struct auxiliary_device *adev)
 	rdev = en_info->rdev;
 
 	if (rdev)
-		bnxt_re_remove_device(rdev, adev);
+		bnxt_re_remove_device(rdev, BNXT_RE_COMPLETE_REMOVE, adev);
 	kfree(en_info);
 	mutex_unlock(&bnxt_re_mutex);
 }
@@ -2017,7 +2015,7 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 
 	auxiliary_set_drvdata(adev, en_info);
 
-	rc = bnxt_re_add_device(adev);
+	rc = bnxt_re_add_device(adev, BNXT_RE_COMPLETE_INIT);
 	if (rc)
 		goto err;
 	mutex_unlock(&bnxt_re_mutex);
@@ -2033,12 +2031,14 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 {
 	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
+	struct bnxt_en_dev *en_dev;
 	struct bnxt_re_dev *rdev;
 
 	if (!en_info)
 		return 0;
 
 	rdev = en_info->rdev;
+	en_dev = en_info->en_dev;
 	mutex_lock(&bnxt_re_mutex);
 	/* L2 driver may invoke this callback during device error/crash or device
 	 * reset. Current RoCE driver doesn't recover the device in case of
@@ -2057,13 +2057,20 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 		set_bit(ERR_DEVICE_DETACHED, &rdev->rcfw.cmdq.flags);
 
 	bnxt_re_dev_stop(rdev);
-	bnxt_re_stop_irq(rdev);
+	bnxt_re_stop_irq(adev);
 	/* Move the device states to detached and  avoid sending any more
 	 * commands to HW
 	 */
 	set_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags);
 	set_bit(ERR_DEVICE_DETACHED, &rdev->rcfw.cmdq.flags);
 	wake_up_all(&rdev->rcfw.cmdq.waitq);
+
+	if (rdev->pacing.dbr_pacing)
+		bnxt_re_set_pacing_dev_state(rdev);
+
+	ibdev_info(&rdev->ibdev, "%s: L2 driver notified to stop en_state 0x%lx",
+		   __func__, en_dev->en_state);
+	bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_REMOVE, adev);
 	mutex_unlock(&bnxt_re_mutex);
 
 	return 0;
@@ -2077,7 +2084,6 @@ static int bnxt_re_resume(struct auxiliary_device *adev)
 	if (!en_info)
 		return 0;
 
-	rdev = en_info->rdev;
 	mutex_lock(&bnxt_re_mutex);
 	/* L2 driver may invoke this callback during device recovery, resume.
 	 * reset. Current RoCE driver doesn't recover the device in case of
@@ -2086,7 +2092,9 @@ static int bnxt_re_resume(struct auxiliary_device *adev)
 	 * L2 driver want to modify the MSIx table.
 	 */
 
-	ibdev_info(&rdev->ibdev, "Handle device resume call");
+	bnxt_re_add_device(adev, BNXT_RE_POST_RECOVERY_INIT);
+	rdev = en_info->rdev;
+	ibdev_info(&rdev->ibdev, "Device resume completed");
 	mutex_unlock(&bnxt_re_mutex);
 
 	return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 049805a..c2f7103 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -82,6 +82,7 @@ struct bnxt_qplib_db_pacing_data {
 	u32 fifo_room_mask;
 	u32 fifo_room_shift;
 	u32 grc_reg_offset;
+	u32 dev_err_state;
 };
 
 #define BNXT_QPLIB_DBR_PF_DB_OFFSET     0x10000
-- 
2.5.5


