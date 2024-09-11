Return-Path: <linux-rdma+bounces-4872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DAC97491A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 06:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9FDB25456
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 04:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A44594C;
	Wed, 11 Sep 2024 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L6AHa1Eg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3DBC144
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028968; cv=none; b=EdNpPWTY7ohRaq5aTpLbWTR6iCEH6odGSu+eFdSgJj1W2Lqfxu1WUQK9Yb1/8f0C55tYwjel6mPUBzEN5gzq5YyHOsXJ97cylrNgQcaRjIXlvstGQ1tdOvqXg35FWCnTWVad7qgjfIO2w9od6mYxiPLBxHkFpxYxwBdu8sivXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028968; c=relaxed/simple;
	bh=TVu4ranskAbNFxfmLNliVBfZtsJxLRVxQXpuObN/QSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ifAxaPfQfbPCm7WOWv3+sIZ1NPdv9Bbp+8W+jzxSVpeDNifjAViTljfkw1dwfkx9S6rXIUN/tjKwUyVLuLUoXuhgaMfkfOIxhjR0U0DHo6He7a/s3/WGx9IrOtECahsACkHbjU9GHOFg9PkRrIBtQib6yXWSx7NIsc8W1fUomj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L6AHa1Eg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7179802b91fso3993284b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 21:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726028966; x=1726633766; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TW3Ul13S7ZGDx8wPnj3gwFimrABuOrRGEyLFve7q/VA=;
        b=L6AHa1EgYH8/VzSgjcFA4AiHa8FtrPLPp4Av8Z0ZP4inOmdl8ZVYvGvgQf1mLUCevm
         uHn0j1vts5s26lbziIyKOe+CMyyQRKF/GfhZUusw5ZdgzeMSTw//LyxWbsFpjhvViM7b
         NTw8n6IvoGIun1o7Efy22TEpSVdT3ZSCvYCa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726028966; x=1726633766;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TW3Ul13S7ZGDx8wPnj3gwFimrABuOrRGEyLFve7q/VA=;
        b=cb0Y3LPmD7NcePSJbbvEKPSRTTSlNhdKc9tkJBvcg3ZteAXbSnQh82T5CrGtUJV3w5
         9+M1Itmj7mxm/f/5fDqv1/rI10RgCP0MuEhEu8B3fl4O1FhoBI2yesiyyvjRcWms3dgh
         HwInBN/MCPYBDzBgeFqOi/EH3jYIIPp/g0Vz4qd3wPkyHj+NVmeGNPbN7ntmNsP1vqEe
         4RqwtlOInoRQ7a3yAIz0cQWv+9zIDF+5s/Prn9j4qKoy/SzG0OT9IRHXBgq3OahxyJig
         hKJ9h2zfaV/SdcdCk3UTDbV/nYp/5YbYztGBVjA7kTtUff9Z9DEUAhLdhCMWzvkZb4vd
         +KCA==
X-Gm-Message-State: AOJu0YxwTVdDnBo1RXyugz7SZTWcDgovLOSkKQYSXEVQzoMSp8Bv2xAE
	nZGZa1ViB0wxyOXqcs2WEjQ8mfaiTZuReVNWIQqC7kCbGZiLB6QmuF7nOa+cIQ==
X-Google-Smtp-Source: AGHT+IH4/hLo8mytflkglXMCXnV05a9fe+TwqcLA4oAYef9iaUI+NhJjDYg3riuP/l+TMM/YUZC9Yg==
X-Received: by 2002:a05:6a20:cd0e:b0:1cf:50e6:fee4 with SMTP id adf61e73a8af0-1cf5e19f82fmr4486124637.49.1726028966196;
        Tue, 10 Sep 2024 21:29:26 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095184sm2123562b3a.106.2024.09.10.21.29.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 21:29:23 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 1/4] RDMA/bnxt_re: Change aux driver data to en_info to hold more information
Date: Tue, 10 Sep 2024 21:08:27 -0700
Message-Id: <1726027710-2292-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

rdev will be destroyed and recreated during the FW error
recovery scenarios. So to keep the state, if any, use an
en_info structure which gets created/freed based on auxiliary
device initialization/de-initialization.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  6 +++
 drivers/infiniband/hw/bnxt_re/main.c    | 71 ++++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 2be9a62..5df3ce1 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -107,6 +107,11 @@ struct bnxt_re_gsi_context {
 	struct	bnxt_re_sqp_entries *sqp_tbl;
 };
 
+struct bnxt_re_en_dev_info {
+	struct bnxt_en_dev *en_dev;
+	struct bnxt_re_dev *rdev;
+};
+
 #define BNXT_RE_AEQ_IDX			0
 #define BNXT_RE_NQ_IDX			1
 #define BNXT_RE_GEN_P5_MAX_VF		64
@@ -155,6 +160,7 @@ struct bnxt_re_dev {
 #define BNXT_RE_FLAG_ERR_DEVICE_DETACHED       17
 #define BNXT_RE_FLAG_ISSUE_ROCE_STATS          29
 	struct net_device		*netdev;
+	struct auxiliary_device         *adev;
 	struct notifier_block		nb;
 	unsigned int			version, major, minor;
 	struct bnxt_qplib_chip_ctx	*chip_ctx;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 16a84ca..085a03c 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -292,10 +292,13 @@ static void bnxt_re_vf_res_config(struct bnxt_re_dev *rdev)
 
 static void bnxt_re_shutdown(struct auxiliary_device *adev)
 {
-	struct bnxt_re_dev *rdev = auxiliary_get_drvdata(adev);
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
+	struct bnxt_re_dev *rdev;
 
-	if (!rdev)
+	if (!en_info)
 		return;
+
+	rdev = en_info->rdev;
 	ib_unregister_device(&rdev->ibdev);
 	bnxt_re_dev_uninit(rdev);
 }
@@ -1794,14 +1797,33 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
+static void bnxt_re_update_en_info_rdev(struct bnxt_re_dev *rdev,
+					struct bnxt_re_en_dev_info *en_info,
+					struct auxiliary_device *adev)
+{
+	/* Before updating the rdev pointer in bnxt_re_en_dev_info structure,
+	 * take the rtnl lock to avoid accessing invalid rdev pointer from
+	 * L2 ULP callbacks. This is applicable in all the places where rdev
+	 * pointer is updated in bnxt_re_en_dev_info.
+	 */
+	rtnl_lock();
+	en_info->rdev = rdev;
+	rdev->adev = adev;
+	rtnl_unlock();
+}
+
 static int bnxt_re_add_device(struct auxiliary_device *adev)
 {
 	struct bnxt_aux_priv *aux_priv =
 		container_of(adev, struct bnxt_aux_priv, aux_dev);
+	struct bnxt_re_en_dev_info *en_info;
 	struct bnxt_en_dev *en_dev;
 	struct bnxt_re_dev *rdev;
 	int rc;
 
+	en_info = auxiliary_get_drvdata(adev);
+	en_dev = en_info->en_dev;
+
 	/* en_dev should never be NULL as long as adev and aux_dev are valid. */
 	en_dev = aux_priv->edev;
 
@@ -1811,6 +1833,8 @@ static int bnxt_re_add_device(struct auxiliary_device *adev)
 		goto exit;
 	}
 
+	bnxt_re_update_en_info_rdev(rdev, en_info, adev);
+
 	rc = bnxt_re_dev_init(rdev);
 	if (rc)
 		goto re_dev_dealloc;
@@ -1821,11 +1845,11 @@ static int bnxt_re_add_device(struct auxiliary_device *adev)
 			aux_priv->aux_dev.name);
 		goto re_dev_uninit;
 	}
-	auxiliary_set_drvdata(adev, rdev);
 
 	return 0;
 
 re_dev_uninit:
+	bnxt_re_update_en_info_rdev(NULL, en_info, adev);
 	bnxt_re_dev_uninit(rdev);
 re_dev_dealloc:
 	ib_dealloc_device(&rdev->ibdev);
@@ -1911,12 +1935,18 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 
 static void bnxt_re_remove(struct auxiliary_device *adev)
 {
-	struct bnxt_re_dev *rdev = auxiliary_get_drvdata(adev);
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
+	struct bnxt_re_dev *rdev;
 
-	if (!rdev)
+	mutex_lock(&bnxt_re_mutex);
+	if (!en_info) {
+		mutex_unlock(&bnxt_re_mutex);
 		return;
+	}
+	rdev = en_info->rdev;
+	if (!rdev)
+		goto skip_remove;
 
-	mutex_lock(&bnxt_re_mutex);
 	if (rdev->nb.notifier_call) {
 		unregister_netdevice_notifier(&rdev->nb);
 		rdev->nb.notifier_call = NULL;
@@ -1931,16 +1961,31 @@ static void bnxt_re_remove(struct auxiliary_device *adev)
 	bnxt_re_dev_uninit(rdev);
 	ib_dealloc_device(&rdev->ibdev);
 skip_remove:
+	kfree(en_info);
 	mutex_unlock(&bnxt_re_mutex);
 }
 
 static int bnxt_re_probe(struct auxiliary_device *adev,
 			 const struct auxiliary_device_id *id)
 {
+	struct bnxt_aux_priv *aux_priv =
+		container_of(adev, struct bnxt_aux_priv, aux_dev);
+	struct bnxt_re_en_dev_info *en_info;
+	struct bnxt_en_dev *en_dev;
 	struct bnxt_re_dev *rdev;
 	int rc;
 
+	en_dev = aux_priv->edev;
+
 	mutex_lock(&bnxt_re_mutex);
+	en_info = kzalloc(sizeof(*en_info), GFP_KERNEL);
+	if (!en_info) {
+		mutex_unlock(&bnxt_re_mutex);
+		return -ENOMEM;
+	}
+	en_info->en_dev = en_dev;
+
+	auxiliary_set_drvdata(adev, en_info);
 
 	rc = bnxt_re_add_device(adev);
 	if (rc) {
@@ -1948,7 +1993,7 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 		return rc;
 	}
 
-	rdev = auxiliary_get_drvdata(adev);
+	rdev = en_info->rdev;
 
 	rdev->nb.notifier_call = bnxt_re_netdev_event;
 	rc = register_netdevice_notifier(&rdev->nb);
@@ -1972,11 +2017,13 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 
 static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 {
-	struct bnxt_re_dev *rdev = auxiliary_get_drvdata(adev);
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
+	struct bnxt_re_dev *rdev;
 
-	if (!rdev)
+	if (!en_info)
 		return 0;
 
+	rdev = en_info->rdev;
 	mutex_lock(&bnxt_re_mutex);
 	/* L2 driver may invoke this callback during device error/crash or device
 	 * reset. Current RoCE driver doesn't recover the device in case of
@@ -2009,11 +2056,13 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 
 static int bnxt_re_resume(struct auxiliary_device *adev)
 {
-	struct bnxt_re_dev *rdev = auxiliary_get_drvdata(adev);
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
+	struct bnxt_re_dev *rdev;
 
-	if (!rdev)
+	if (!en_info)
 		return 0;
 
+	rdev = en_info->rdev;
 	mutex_lock(&bnxt_re_mutex);
 	/* L2 driver may invoke this callback during device recovery, resume.
 	 * reset. Current RoCE driver doesn't recover the device in case of
-- 
2.5.5


