Return-Path: <linux-rdma+bounces-4874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B397491C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 06:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6BB1F2695D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 04:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7A487BF;
	Wed, 11 Sep 2024 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W1vF6+hI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C33C144
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 04:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028978; cv=none; b=M+oRHkQ6r2Dh6wNMinyMIORrrpIYfMlgyO5TMec4aOpZEaYWDng8igV/qgC6Jhhdqu5P9AwMhjRh+gYxr3mL6XO6//hTKIeVxVUob2DC/5Hr++t86BxNioo/7DX9rj1N1B+RKjewpmeOq4BV6hT6PLC0UtF281nsvKF6bzjhYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028978; c=relaxed/simple;
	bh=5LxvtAbuEc9ZYXKjugmj/JehWdjeJaSPW5xgXl5XuS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=su0o6fjmLVS9JT81X3d/iLM4WO0HkIvFpR+SW1ELx3v8Yohol5xR5mpp2c4wZncPS5vBDzBsglY8fiALdtyTyDi1zkCCjA6pqoKi98NQuKiIYY9V/OI1jl4LsUhHvI/cxA6M9lqw8RScViOHp8ouXtazUQIOg2xKuWxeUxPE9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W1vF6+hI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71911585ac4so1092704b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 21:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726028976; x=1726633776; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRe8rJNyl95P8tZdEPQ0yoe4cOHwkuQlLU1cuTL5PJM=;
        b=W1vF6+hIl8uzM42WhPfVvrSfGAHOR1HUo8NueNm+82tIV8Om6NMabsJUJa2Cwfm0YI
         6pmbFyv1KUTZ40ZtZHpB5XIk9JCzHTHmHPIsvA3j53TqjfmT6Kx6ouNBpb48mDaIrjLM
         LlrwXvSQJYBePCr6mvUdD/cfdxst6yNbgM2zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726028976; x=1726633776;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRe8rJNyl95P8tZdEPQ0yoe4cOHwkuQlLU1cuTL5PJM=;
        b=cQ0TivlBoPQfhksHw6NlvwY8aGibvp4gDDlFS2i8LMKZvRsrGTlKODLHsu2U6V3DhI
         XjjI9vDZ/OexI+cuT9ii8q1JOawQ6jiVbOU3cga77l40fVmaRbxSHF+IjGIyo605qbD7
         lO2kqkdEG/0p6nOJzNomiWK3iSyXf2U8PNKQw0pDPseA8OcfAcoef1rhul5Crfa9TYmz
         grtv7wkTVdO8cQqsxoRbY0GpwCZVsPFnpwblPB27GXPkQqNiC0nvhPJxqn9FzFTq28R5
         iKMx1oz2G8ZiKxc0YCrks7//UbOwu6CtLmDRZza6ptNfOr51qPKRKAEgazh2OvmyMKIs
         3nKQ==
X-Gm-Message-State: AOJu0YxKgaAKPd6GFklOu3bTWbHZNuSKqvVNLzOUDGzgD4DK3+UgRKPq
	dVbku4kQ3ajy82aKaUsebp6JuwxdG0Wcm0A4t+REaT7v6UNWRJ0gBO4LF4hqng==
X-Google-Smtp-Source: AGHT+IGzBtUt5U1trOUOCpQquHw1RkMmg/ktmOklb1SDWWQykH00Edpg1EYFd0OthQIpXGlrLRjIxw==
X-Received: by 2002:a05:6a00:987:b0:717:8e49:37ce with SMTP id d2e1a72fcca58-718d5f3293cmr23400113b3a.21.1726028975830;
        Tue, 10 Sep 2024 21:29:35 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095184sm2123562b3a.106.2024.09.10.21.29.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 21:29:33 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chandramohan Akula <chandramohan.akula@broadcom.com>
Subject: [PATCH for-next v2 3/4] RDMA/bnxt_re: Group all operations under add_device and remove_device
Date: Tue, 10 Sep 2024 21:08:29 -0700
Message-Id: <1726027710-2292-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Adding and removing device need to be handled from multiple contexts
when Firmware error recovery is supported. So group all the add and remove
operations to add_device and remove_device function.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 65 ++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 2a91699..dc63ad0 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -88,6 +88,7 @@ static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
 
 static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 			     u32 *offset);
+static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable);
 static void bnxt_re_set_db_offset(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *cctx;
@@ -1860,6 +1861,16 @@ static int bnxt_re_add_device(struct auxiliary_device *adev)
 		goto re_dev_uninit;
 	}
 
+	rdev->nb.notifier_call = bnxt_re_netdev_event;
+	rc = register_netdevice_notifier(&rdev->nb);
+	if (rc) {
+		rdev->nb.notifier_call = NULL;
+		pr_err("%s: Cannot register to netdevice_notifier",
+		       ROCE_DRV_MODULE_NAME);
+		return rc;
+	}
+	bnxt_re_setup_cc(rdev, true);
+
 	return 0;
 
 re_dev_uninit:
@@ -1947,20 +1958,9 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 
 #define BNXT_ADEV_NAME "bnxt_en"
 
-static void bnxt_re_remove(struct auxiliary_device *adev)
+static void bnxt_re_remove_device(struct bnxt_re_dev *rdev,
+				  struct auxiliary_device *aux_dev)
 {
-	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
-	struct bnxt_re_dev *rdev;
-
-	mutex_lock(&bnxt_re_mutex);
-	if (!en_info) {
-		mutex_unlock(&bnxt_re_mutex);
-		return;
-	}
-	rdev = en_info->rdev;
-	if (!rdev)
-		goto skip_remove;
-
 	if (rdev->nb.notifier_call) {
 		unregister_netdevice_notifier(&rdev->nb);
 		rdev->nb.notifier_call = NULL;
@@ -1968,13 +1968,30 @@ static void bnxt_re_remove(struct auxiliary_device *adev)
 		/* If notifier is null, we should have already done a
 		 * clean up before coming here.
 		 */
-		goto skip_remove;
+		return;
 	}
 	bnxt_re_setup_cc(rdev, false);
 	ib_unregister_device(&rdev->ibdev);
 	bnxt_re_dev_uninit(rdev);
 	ib_dealloc_device(&rdev->ibdev);
-skip_remove:
+}
+
+static void bnxt_re_remove(struct auxiliary_device *adev)
+{
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
+	struct bnxt_en_dev *en_dev;
+	struct bnxt_re_dev *rdev;
+
+	mutex_lock(&bnxt_re_mutex);
+	if (!en_info) {
+		mutex_unlock(&bnxt_re_mutex);
+		return;
+	}
+	en_dev = en_info->en_dev;
+	rdev = en_info->rdev;
+
+	if (rdev)
+		bnxt_re_remove_device(rdev, adev);
 	kfree(en_info);
 	mutex_unlock(&bnxt_re_mutex);
 }
@@ -1986,7 +2003,6 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 		container_of(adev, struct bnxt_aux_priv, aux_dev);
 	struct bnxt_re_en_dev_info *en_info;
 	struct bnxt_en_dev *en_dev;
-	struct bnxt_re_dev *rdev;
 	int rc;
 
 	en_dev = aux_priv->edev;
@@ -2002,23 +2018,8 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 	auxiliary_set_drvdata(adev, en_info);
 
 	rc = bnxt_re_add_device(adev);
-	if (rc) {
-		mutex_unlock(&bnxt_re_mutex);
-		return rc;
-	}
-
-	rdev = en_info->rdev;
-
-	rdev->nb.notifier_call = bnxt_re_netdev_event;
-	rc = register_netdevice_notifier(&rdev->nb);
-	if (rc) {
-		rdev->nb.notifier_call = NULL;
-		pr_err("%s: Cannot register to netdevice_notifier",
-		       ROCE_DRV_MODULE_NAME);
+	if (rc)
 		goto err;
-	}
-
-	bnxt_re_setup_cc(rdev, true);
 	mutex_unlock(&bnxt_re_mutex);
 	return 0;
 
-- 
2.5.5


