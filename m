Return-Path: <linux-rdma+bounces-4847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88851972845
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 06:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E913EB22FFA
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 04:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46CF13634E;
	Tue, 10 Sep 2024 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SdNJA8Pr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA6566A
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942120; cv=none; b=pA+w0jZErhlDJUyBsJbdtocjlGq+9GF7Ey5TvbQ4lY0+A/OTFIJGxRI26xHDx5XMziaQtVLhC1dOLfopMdng3urWqWWfA0EyxLG8hq7nRjTComlqFbXlfalQs9h44ezxEhz3niKroeQfPdcRTGmLQXGPt2IGqZSoUVlayPnao3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942120; c=relaxed/simple;
	bh=Y923EI3h4OQygaLG0vZWY1xvxiWP0kpunaFufPCk+Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vuedr9wse9nl8V5HIXowttP5iEIXQ8naG/LlO8dfc/q95L7oS0Ohf5CbCWXsHxqqQ1PVjWLhTTTnahRBKkBwFsQPCyLd/YagIt6retHVZh6K7OC9371v4+SsDLTlV6/ySM41NqrFxJ+eWVNvcnRQKJGcEoBVmy+WGUqIE0WXkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SdNJA8Pr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206bd1c6ccdso46153615ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2024 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725942118; x=1726546918; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PqD89u3DZwV6nqGb+nlqGHoYIIu+dJAQE+b2B/d3Oc=;
        b=SdNJA8PrIPXZh4kj9n1JJFD4NN4XmwUt5WJaV/f/kbXnB5N6LHP9ksNmw9OsWrQcRf
         oyz4cvMM6Ma9LbjlEFoeD7fGvzyDXNKk8E6Wksuj0ncg/UOOL+b7crBs9HTenAU2Bknf
         +jwNoJ8e2fa19AlZlNnuIv8ryf9p6cJdvKp88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725942118; x=1726546918;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PqD89u3DZwV6nqGb+nlqGHoYIIu+dJAQE+b2B/d3Oc=;
        b=LzqS0EQFY646YgG/RLevEXyqdGCLI7NbX92dRWRDgpghk5Mh4pNz6bZg2LmKLl1ErK
         1HGKZ5il1wBetu+QgQ/beHPhAyPrtWSVXkbnGv1v3q1V6NqGkJLUG0VI+GhGIlT5t3qY
         RHNO5dCRJxEHjpC33Fm9RgUGhAgs86aIr5jJTgB/3FaeRhsX5IHQt1X36JCjHEZERp5e
         5R5V3N/yDxXdu+v4nQk4bYhITvpleY2L/ui2VWvqz+wpK6wnFFfMOW3dg8gvFZgI+T/P
         6YoiwfgIDI+U0tkiUrJy29wtsvp/21wIVMjBP2IqaPs2ZY21OGe8Ic0NUp9fT4fYdNTx
         nE7A==
X-Gm-Message-State: AOJu0Yz74hTuE48iJheGrXACMiG+iM9/lFTmgyUyQ98QBfj9aMAJLjOQ
	apUhI+7gSG8sErSoa178bIuPSQXD/w3Iao78gXsRdCr9lGb+bbrJQNs/UmXQYw==
X-Google-Smtp-Source: AGHT+IGLEeRorqzXZG6T/0pQMwmbds0eD0zcQFJzB2X6Oqrw4lwqPEBqbSw2uUFO+MnGMRuNYK790A==
X-Received: by 2002:a17:902:ec87:b0:205:7b1f:cf6d with SMTP id d9443c01a7336-206f053113bmr150288705ad.30.1725942118222;
        Mon, 09 Sep 2024 21:21:58 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e328aasm40703005ad.91.2024.09.09.21.21.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 21:21:57 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/4] RDMA/bnxt_re: Use the aux device for L2 ULP callbacks
Date: Mon,  9 Sep 2024 21:01:00 -0700
Message-Id: <1725940862-4821-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725940862-4821-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725940862-4821-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

While registering with the L2 for ULP operations, use the
aux device pointer as the handle. Aux device has
the data bnxt_re_en_dev_info, which is used to
store required information for the bnxt_re_suspend
and bnxt_re_resume functions.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 8679459..a5e0c21 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -305,11 +305,18 @@ static void bnxt_re_shutdown(struct auxiliary_device *adev)
 
 static void bnxt_re_stop_irq(void *handle)
 {
-	struct bnxt_re_dev *rdev = (struct bnxt_re_dev *)handle;
-	struct bnxt_qplib_rcfw *rcfw = &rdev->rcfw;
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(handle);
+	struct bnxt_qplib_rcfw *rcfw;
+	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_nq *nq;
 	int indx;
 
+	if (!en_info)
+		return;
+
+	rdev = en_info->rdev;
+	rcfw = &rdev->rcfw;
+
 	for (indx = BNXT_RE_NQ_IDX; indx < rdev->num_msix; indx++) {
 		nq = &rdev->nq[indx - 1];
 		bnxt_qplib_nq_stop_irq(nq, false);
@@ -320,12 +327,19 @@ static void bnxt_re_stop_irq(void *handle)
 
 static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 {
-	struct bnxt_re_dev *rdev = (struct bnxt_re_dev *)handle;
-	struct bnxt_msix_entry *msix_ent = rdev->en_dev->msix_entries;
-	struct bnxt_qplib_rcfw *rcfw = &rdev->rcfw;
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(handle);
+	struct bnxt_msix_entry *msix_ent;
+	struct bnxt_qplib_rcfw *rcfw;
+	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_nq *nq;
 	int indx, rc;
 
+	if (!en_info)
+		return;
+
+	rdev = en_info->rdev;
+	msix_ent = rdev->en_dev->msix_entries;
+	rcfw = &rdev->rcfw;
 	if (!ent) {
 		/* Not setting the f/w timeout bit in rcfw.
 		 * During the driver unload the first command
@@ -374,7 +388,7 @@ static int bnxt_re_register_netdev(struct bnxt_re_dev *rdev)
 
 	en_dev = rdev->en_dev;
 
-	rc = bnxt_register_dev(en_dev, &bnxt_re_ulp_ops, rdev);
+	rc = bnxt_register_dev(en_dev, &bnxt_re_ulp_ops, rdev->adev);
 	if (!rc)
 		rdev->qplib_res.pdev = rdev->en_dev->pdev;
 	return rc;
-- 
2.5.5


