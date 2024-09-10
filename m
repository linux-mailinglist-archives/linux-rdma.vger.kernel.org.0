Return-Path: <linux-rdma+bounces-4846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED3972844
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 06:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2931C223BA
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 04:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D242139D12;
	Tue, 10 Sep 2024 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z7Wf0u/6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADF566A
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942118; cv=none; b=sc15yPqSdvKQSkFaYpkQFnzOrC5sC2kFbM3NcLOnjPqY1c/grqzZt/ONP2AAfysPVFMPM5Zn5ROnS+WMz9sF8Gkf+3cYmhLzUXdc0M+SRdeuW66jaq3zBHaNo7TArW1nM2JErFneAdcOmYKbLH9o6ittREZFtBQuVDLPR42Uv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942118; c=relaxed/simple;
	bh=0PFnPgSxqG5u0BBHqtoS9t39I/sk30jeWgaqbZxr6eM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NfV4ESQ+QIE2tCOF7J+O77NweH+73+ZJRuCZWJpGgXmfxHjgTo8e2va8cNDnczeq3xUyAo4M7XVKSnz1JL/k5kVbTGWB1zGXvGE5MlfGY8bkhrypzNKg/85S0VqhVwsUglcLFIjOX0jmMVRyDLifrWMsKJwUNmnRyw0v8yz81gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z7Wf0u/6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2059204f448so41829995ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2024 21:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725942115; x=1726546915; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gGVjO5z4U4tggQR+t92T7pJf+b801DB4Tm4cwwsC8a4=;
        b=Z7Wf0u/68jsAslLvBld4CwrkWFmZR8AwKAjeMUADbMreROfYVmvvQfZTkGozbza5ls
         8MYyCYldIjHBMtB89EuMMqjlmhCUNy8cAkYmTDbDD3528OysS4hJJ7TLFYBFnE0rFxMH
         j7VEA50BIygBjZLRMPkANbXHdrndjEeViA1Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725942116; x=1726546916;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGVjO5z4U4tggQR+t92T7pJf+b801DB4Tm4cwwsC8a4=;
        b=wDFp7dIyr/6vtQLPiRddEnNz6ILONmsyxlQgh6Z+gpPKQLt3xjBeR/RfG9frcw/wwk
         peNkdQGb5jZiPCUD42qbudPOKdTaI0NnKuVehPzT+ikQihfvjMoWT9S+RjVKm2NFbbgn
         FK7K7WtWZkyoJjUyBSqAZ8F9Tm/8oTC42cmowLVcp5THsKDRkOwj0x+E9V5V79sTiEKf
         qVSidf4KjUhMijIbZ4lmWytyNQ3zIF8o2/ydFGJM4qCu4mHgPcqCGVUcAYLzkkJd3IFi
         FYxPf+96Y4vX+NqqQ0M1eqZxe/2Rlvzbh7LzLgu/1MK6UFnQkD8KmzHNjKMLbIiHtaIK
         RXoA==
X-Gm-Message-State: AOJu0YzmPM6z17akyvpSJ4PTBC2njUS8SwnXbnfXx/+pYDRXfaAuoASJ
	dIYZZn2bqDHZM0nckWkeXOdqrnwShVAFGs7Mj9MJQecziaXVbhuY8KWASXpZqA==
X-Google-Smtp-Source: AGHT+IEmBluOvf53rJIr8fxZEp0R6R15xCNjeiCQL2pChZm/Jp1DU+10qXcOQoKefMzJd1jBwVKETg==
X-Received: by 2002:a17:903:189:b0:206:c75a:29d4 with SMTP id d9443c01a7336-206f0654f85mr179810715ad.50.1725942115239;
        Mon, 09 Sep 2024 21:21:55 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e328aasm40703005ad.91.2024.09.09.21.21.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 21:21:54 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/4] RDMA/bnxt_re: Change aux driver data to en_info to hold more information
Date: Mon,  9 Sep 2024 21:00:59 -0700
Message-Id: <1725940862-4821-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725940862-4821-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725940862-4821-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/main.c    | 73 ++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 11 deletions(-)

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
index 16a84ca..8679459 100644
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
@@ -1911,12 +1935,20 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 
 static void bnxt_re_remove(struct auxiliary_device *adev)
 {
-	struct bnxt_re_dev *rdev = auxiliary_get_drvdata(adev);
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
+	struct bnxt_en_dev *en_dev;
+	struct bnxt_re_dev *rdev;
 
-	if (!rdev)
+	mutex_lock(&bnxt_re_mutex);
+	if (!en_info) {
+		mutex_unlock(&bnxt_re_mutex);
 		return;
+	}
+	en_dev = en_info->en_dev;
+	rdev = en_info->rdev;
+	if (!rdev)
+		goto skip_remove;
 
-	mutex_lock(&bnxt_re_mutex);
 	if (rdev->nb.notifier_call) {
 		unregister_netdevice_notifier(&rdev->nb);
 		rdev->nb.notifier_call = NULL;
@@ -1931,16 +1963,31 @@ static void bnxt_re_remove(struct auxiliary_device *adev)
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
@@ -1948,7 +1995,7 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 		return rc;
 	}
 
-	rdev = auxiliary_get_drvdata(adev);
+	rdev = en_info->rdev;
 
 	rdev->nb.notifier_call = bnxt_re_netdev_event;
 	rc = register_netdevice_notifier(&rdev->nb);
@@ -1972,11 +2019,13 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 
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
@@ -2009,11 +2058,13 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 
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


