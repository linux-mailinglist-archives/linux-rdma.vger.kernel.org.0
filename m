Return-Path: <linux-rdma+bounces-6417-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CEB9EC3DB
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 05:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C78283CC3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 04:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BCE1AA782;
	Wed, 11 Dec 2024 04:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DRJFP0fi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10712451C0
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890005; cv=none; b=lHMF4z5TsRyDwwtYdWeA+aBZZW7J1UKBq5I2txg0OKV1KdLsWAJYXeTAy+WQxpv0lsCMVLSfS6OQj6ULTbzCsIfyFt/Gu5Nv3pt2fxf4HMR28SHWFblq2fc4SHNeFzfMzVyHc/8TpAEh6I5MPv0Ds3Qj6NqwZQZqpN/6DWEP9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890005; c=relaxed/simple;
	bh=fO8EeUXrc2/TBt3vLeD81sdSxeYxP70yTRZeRTjeYMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ItkkC2QN84rOrX+eFZVINvdM6Sy2njuvqm61lztYOzzKS6CU2S9t4Xali6T9v6G8DAvUwnOP2sszhxQgUKHSAw+JyTIrxY4n5kd05ywiKvz9DemrbW2TF1LFG7ATE71Dv/a7fYDuo3cANspB+glywCVX599THDIK11Djb7rGKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DRJFP0fi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2efb17478adso2349568a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 20:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733890003; x=1734494803; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTNRZXKqk1Z8hQ0CaF0SoqYPfI6bk4nicfkzpP6gq3M=;
        b=DRJFP0fikRBtkQ4GiHg9sQLqejRlbskY+q7fLAQcJ8GJaYaiG/hfplsF/cCrga6Lws
         IyyK6iQx4CZAGabkveVYRTIx/2YbyLlxH2r6QXWdqDVYZPMfNktYwdL3eYC1HB3Z1xEy
         Qewn0X7ohd7N8ebK3Y/p5egH/z+DlncKtzSiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733890003; x=1734494803;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTNRZXKqk1Z8hQ0CaF0SoqYPfI6bk4nicfkzpP6gq3M=;
        b=vohVJDkIB/B99j6vyCXXXyBdxdT/Z/1wUgnh3WnQt4jZr+WwroGazq5ipssAcEe9mc
         ZkScGJuwBqBVjBSym9Eo072LiRnBl6do2FvaiBwAERG1YDyeqd2rPWYf45EPRphff0Yr
         XlvMr6TMDExOOdv92YlmSBhs9ZVIGDAHIlG8NgfOvKQZbmWOFv8mP+ut4kfJoNouSV64
         Y78eqaM61yPrU1GOKzhjKrIXfw0blYpCO3g0i2XviKmeFHx6BpNzKtOy2OFkFPx7MYs6
         Q7/+VecM87s9WNtiBAkKEVuwJeUdJXdG3MGjU6pTF6kdV7CSvW+sAzuBP4/tDoLeOcdC
         hUdQ==
X-Gm-Message-State: AOJu0YycuJPgpGe2neqjhwUPoL7prnZsgEp6DJVBpFSkRzHz3TbUxxbw
	TBkwKZkNLAlUG/UUbAliAL5LKxEP164ai1sgydMXIR42m94Z+YsjNTrjAKRFIw==
X-Gm-Gg: ASbGncsO+h8CyHNruss0OMVLUlEXVsnMio6PxNQWIhjZTl9RvE4Thj+mlhzE9OFrhKC
	k9GXlQJFuvDf7RdHtva3Kyd8iOCTSr1RKxLkgoG8aTkeqgeknqVTh/PqCY5+2+XG/1LaCTaUOut
	HeMaLnLgUD1iG4Ix8FylqZ5GLvsc13apWoOQwWoBWxDV5x9aTNUqq9YKMpkhZsE5QjDhFIEmeXU
	cOaglGFYfyHUBYgC4SLUq1/Ur3CsxBdZmSJm0jBjmRxyWLmkAbLPQQxc+aNOiIqM4LStPJGbykI
	mv5cGFn4OdkGRJB+/pmW/WC9/Y6OewvA/5eN
X-Google-Smtp-Source: AGHT+IFFdyD/Kkkst0eR6fZVHJEoIhV/KAfUII4ohzU7J9DEoJFr5MTC+bsMcxPeVe3NfZ35kc4g8w==
X-Received: by 2002:a17:90b:4a41:b0:2ee:c9b6:c266 with SMTP id 98e67ed59e1d1-2f127fa5e74mr2374315a91.13.1733890003077;
        Tue, 10 Dec 2024 20:06:43 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffc948sm12477773a91.3.2024.12.10.20.06.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 20:06:42 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 4/5] RDMA/bnxt_re: Eliminate need for some forward declarations
Date: Tue, 10 Dec 2024 19:45:44 -0800
Message-Id: <1733888745-30939-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
References: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Move the function definition of bnxt_re_shutdown() to avoid
forward declarartion of bnxt_re_dev_uninit().

Move the function definition of bnxt_re_setup_cc() before
bnxt_re_add_device() to avoid it's forward declarations.

Also, forward declarartions of bnxt_re_stop_irq() and
bnxt_re_dev_stop() are unnecessary.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 73 +++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 75e1611..5e10b54 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -79,17 +79,12 @@ MODULE_LICENSE("Dual BSD/GPL");
 /* globals */
 static DEFINE_MUTEX(bnxt_re_mutex);
 
-static void bnxt_re_stop_irq(void *handle);
-static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev);
 static int bnxt_re_netdev_event(struct notifier_block *notifier,
 				unsigned long event, void *ptr);
-static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev);
-static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type);
 static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
 
 static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 			     u32 *offset);
-static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable);
 static void bnxt_re_set_db_offset(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *cctx;
@@ -302,16 +297,6 @@ static void bnxt_re_vf_res_config(struct bnxt_re_dev *rdev)
 				      &rdev->qplib_ctx);
 }
 
-static void bnxt_re_shutdown(struct auxiliary_device *adev)
-{
-	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
-	struct bnxt_re_dev *rdev;
-
-	rdev = en_info->rdev;
-	ib_unregister_device(&rdev->ibdev);
-	bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
-}
-
 static void bnxt_re_stop_irq(void *handle)
 {
 	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(handle);
@@ -2123,6 +2108,30 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	return rc;
 }
 
+static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable)
+{
+	struct bnxt_qplib_cc_param cc_param = {};
+
+	/* Do not enable congestion control on VFs */
+	if (rdev->is_virtfn)
+		return;
+
+	/* Currently enabling only for GenP5 adapters */
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
+		return;
+
+	if (enable) {
+		cc_param.enable  = 1;
+		cc_param.tos_ecn = 1;
+	}
+
+	cc_param.mask = (CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC |
+			 CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN);
+
+	if (bnxt_qplib_modify_cc(&rdev->qplib_res, &cc_param))
+		ibdev_err(&rdev->ibdev, "Failed to setup CC enable = %d\n", enable);
+}
+
 static void bnxt_re_update_en_info_rdev(struct bnxt_re_dev *rdev,
 					struct bnxt_re_en_dev_info *en_info,
 					struct auxiliary_device *adev)
@@ -2192,30 +2201,6 @@ static int bnxt_re_add_device(struct auxiliary_device *adev, u8 op_type)
 	return rc;
 }
 
-static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable)
-{
-	struct bnxt_qplib_cc_param cc_param = {};
-
-	/* Do not enable congestion control on VFs */
-	if (rdev->is_virtfn)
-		return;
-
-	/* Currently enabling only for GenP5 adapters */
-	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
-		return;
-
-	if (enable) {
-		cc_param.enable  = 1;
-		cc_param.tos_ecn = 1;
-	}
-
-	cc_param.mask = (CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC |
-			 CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN);
-
-	if (bnxt_qplib_modify_cc(&rdev->qplib_res, &cc_param))
-		ibdev_err(&rdev->ibdev, "Failed to setup CC enable = %d\n", enable);
-}
-
 /*
  * "Notifier chain callback can be invoked for the same chain from
  * different CPUs at the same time".
@@ -2376,6 +2361,16 @@ static int bnxt_re_resume(struct auxiliary_device *adev)
 	return 0;
 }
 
+static void bnxt_re_shutdown(struct auxiliary_device *adev)
+{
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
+	struct bnxt_re_dev *rdev;
+
+	rdev = en_info->rdev;
+	ib_unregister_device(&rdev->ibdev);
+	bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
+}
+
 static const struct auxiliary_device_id bnxt_re_id_table[] = {
 	{ .name = BNXT_ADEV_NAME ".rdma", },
 	{},
-- 
2.5.5


