Return-Path: <linux-rdma+bounces-4873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD397491B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 06:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B02DB2216C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 04:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7643FB30;
	Wed, 11 Sep 2024 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QQEr0APA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B25C144
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028973; cv=none; b=VXjYi3R2dMcGKoaDT2RlIvIdxyhO9gDM35k8tWVBO5u8hWWVpz0qCqqKem1xGn9m5sjpJ9ym4J6oXrtYYeY4ws/yN1j8Vr/CZhR0vnl9MbokO9VwkXkbriI1Mn6YkKl0l4u/SMbvgHtsomsCgoC4Bml7rAmcb2VKrC8OTF6h2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028973; c=relaxed/simple;
	bh=GbRpg1h0UWw1sY8RVEVPG8k18EfZQJuKsBwJRdJBQT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X09CpyeA5bYqQ+zJMbqavgCawKEU6jkK4PBslct5B6Te6pZLOJQdUydaUknzQmJO4AiopHM9u8DSGLSgwnGRxRyrjVZEGRXJiiGmK6jYHtLeqZcgM8l+PwTlavam7WYIEF5qvB8fKMWr2tdn36s0MJKwd8s3KajgxhEdB5zObQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QQEr0APA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so192385a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 21:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726028971; x=1726633771; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r2eul6sBj4rHlzswzbS767ryuCxywOlCbgVkH5S8zQs=;
        b=QQEr0APAWOk6FDCWe+oCU3/vumpc4g9B9fpzYezHdY9dRdkKFdq3aqJi/SUDNfiROW
         hqYg9ttP0QHKyUNxSDNwoyEMMjYSPkwKfyjtngQOToCBnohe5G229u238kM4NEH1jDxl
         +LFbYgn3kDGWgtsSCyfxRwsl+vMltxXcR5wzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726028971; x=1726633771;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2eul6sBj4rHlzswzbS767ryuCxywOlCbgVkH5S8zQs=;
        b=dxf/HmN3hWZ4/7dr1nQxGam5hHT+Tsal6+r4phxCPjM3GxkVktNV1C+efBsBtGr4a3
         gF9lC3nQEnyOfUOKSRrddH9jH08hBbP5MF+BrlZpg6tUWZLkV1eZP9kBbPqrECNEn3ik
         vORsi8SZGs/A+6BDy6NfCP0y8piiWrWbpybdSPR+D8hclt5mK/DfH+Bo06x20wNeITff
         6z5EBmjZM+AFEH00L3Eud1/4YxzYwpuQ7pPLLxz7vP5bWQm8J8mGTz9WMMdNKzrBiT+s
         b44fnsHb09ZumgHhx3MK4sPN6VTu4EffnT22MiOC/kqOSgQagG+aLvR+RfrNcBhLfXI6
         nMBA==
X-Gm-Message-State: AOJu0YyNCAotEFua2X61wbPOjdeUvtZyFN0wxNXqyQSF/tcYJIwD2EYF
	PlVnvMULR9QB49WbOI1VZ/1q/zLfsOxYZx4n8xjUNllA4h5htpc9Lnva3RLB1Q==
X-Google-Smtp-Source: AGHT+IFhy8Iq3WejVOjuLSiqYzK1v6Js4HGnjClVX+dioJV8MMw/4Bb4KuepzRicngA+pUWS6SejRg==
X-Received: by 2002:a05:6a20:d528:b0:1cf:32d1:489 with SMTP id adf61e73a8af0-1cf5e03f737mr4890729637.1.1726028971209;
        Tue, 10 Sep 2024 21:29:31 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095184sm2123562b3a.106.2024.09.10.21.29.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 21:29:28 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 2/4] RDMA/bnxt_re: Use the aux device for L2 ULP callbacks
Date: Tue, 10 Sep 2024 21:08:28 -0700
Message-Id: <1726027710-2292-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
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
index 085a03c..2a91699 100644
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


