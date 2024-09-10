Return-Path: <linux-rdma+bounces-4848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C5972846
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 06:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641F52812C9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 04:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8E4F218;
	Tue, 10 Sep 2024 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GitKCZZJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A4566A
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942123; cv=none; b=f3KcEY/G7xevQMfI93dJ7lhwfF+MESoj01cPvSEeBsOMqmjL48OvapMfjm3hT9K7Dpbl370N8WYZvI2ngT0fMS+xC7jGe9uLDzTo+yxPJl2nXpJt2xWsM15XY918CAK0yib1N220sg47y5B5sHYn98oqiIQSuZkvcyLBk7P50D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942123; c=relaxed/simple;
	bh=J1H+yF9KD3p8LK6Z8FjB+ZneZIVBUof/RE3OrwtSPrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=A8WmoKEwndlfWGzhjq8AmIsOFmLA+S3TSsAnfulIK7/4+7awJ8e0H7CDJpJN3E9LwYPgrDTSWbRLIT7CWuIr6oBjbB2xwizS0AxFCQslk7u84T9lnesZZx7gf7/flFUwrLAS5HRqcYpLSlq95l/TLBMZ9Vpoql+7Z+U68oRJT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GitKCZZJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-205909afad3so3817695ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2024 21:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725942121; x=1726546921; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yx4kcs1+mVLOCN87O7qUZZiZFVBAYEuAqNx53/tmMtc=;
        b=GitKCZZJLZWjuSy5jQ3ZQcHB7H0AQuaVuPgNXQszvdNkfwiEIimdlhfx2kFzCT06EK
         ChY37KqtyLPveVBbTyotE8q9TeYxFj3WtPxuvYCry/bo221sFj2Ky06q3l+IIwIkc2FC
         i3b91AUJ1oVoOozfd8GVWMVO+2gK+EjcZg//8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725942121; x=1726546921;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yx4kcs1+mVLOCN87O7qUZZiZFVBAYEuAqNx53/tmMtc=;
        b=JH1+LZ+ednFoxvMg352yw3InM8byGzwassB0uqGnrbu6GLW6nWzVuwqB1yFRTud8YQ
         sC8FhKz8O61KeIksoG5nHbGeFKNRQVz1s1qgKjBFfGv1MwHMqIxXdzgRw/KAgUCjLwIH
         yBl0XnSrT9KV3gDaOqdidzhXG+teKaFYMJl2IFzgIpz4d+YOkcmsQ3BC0tm2rMGrcySb
         Xk82gP+5sVUbfMjon2yLuh8RckQ+25WsXjK241T8OmOAVt3BRBETUW0sTZg9JjrGu+3F
         ALJ7/sBRoBPg9IEpFohaVxzmh3j9ydlIqrEAM/EwZDaCntv555TzAZC/GKZyccwP+PJQ
         SyeQ==
X-Gm-Message-State: AOJu0YxjQCZypA3t3+IHV3MS48mYkPpAe+SNZ0Km6vEFj6RGv8dovqBN
	jKaz+nkGvCqk03idfAduPbQME5B3u5SMTKFqqtnc2w9x5g+DgWFYwcD1PQxIUcpDMyEmErSJr7A
	=
X-Google-Smtp-Source: AGHT+IHBGZIUx/8GXyNJi63oNK7LKgQnNzAdeqatLOb6JXi2y9/fx33ioIILzBr8GxEuSCyoAmAqyg==
X-Received: by 2002:a17:902:e54d:b0:207:15f4:2637 with SMTP id d9443c01a7336-20715f4264dmr114154365ad.12.1725942121136;
        Mon, 09 Sep 2024 21:22:01 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e328aasm40703005ad.91.2024.09.09.21.21.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 21:22:00 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chandramohan Akula <chandramohan.akula@broadcom.com>
Subject: [PATCH for-next 3/4] RDMA/bnxt_re: Group all operations under add_device and remove_device
Date: Mon,  9 Sep 2024 21:01:01 -0700
Message-Id: <1725940862-4821-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725940862-4821-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725940862-4821-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/main.c | 64 +++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a5e0c21..1793a0c 100644
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
@@ -1947,21 +1958,13 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 
 #define BNXT_ADEV_NAME "bnxt_en"
 
-static void bnxt_re_remove(struct auxiliary_device *adev)
+static void bnxt_re_remove_device(struct bnxt_re_dev *rdev,
+				  struct auxiliary_device *aux_dev)
 {
-	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(aux_dev);
 	struct bnxt_en_dev *en_dev;
-	struct bnxt_re_dev *rdev;
 
-	mutex_lock(&bnxt_re_mutex);
-	if (!en_info) {
-		mutex_unlock(&bnxt_re_mutex);
-		return;
-	}
 	en_dev = en_info->en_dev;
-	rdev = en_info->rdev;
-	if (!rdev)
-		goto skip_remove;
 
 	if (rdev->nb.notifier_call) {
 		unregister_netdevice_notifier(&rdev->nb);
@@ -1970,13 +1973,30 @@ static void bnxt_re_remove(struct auxiliary_device *adev)
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
@@ -1988,7 +2008,6 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 		container_of(adev, struct bnxt_aux_priv, aux_dev);
 	struct bnxt_re_en_dev_info *en_info;
 	struct bnxt_en_dev *en_dev;
-	struct bnxt_re_dev *rdev;
 	int rc;
 
 	en_dev = aux_priv->edev;
@@ -2004,23 +2023,8 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
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


