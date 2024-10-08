Return-Path: <linux-rdma+bounces-5301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B2994219
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A45A1C23D66
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B731EB9E8;
	Tue,  8 Oct 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LY3AMfXw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A681EABD4
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374579; cv=none; b=SHQfFEOC/zqw1l82MQxOfjGWXf+cUILF+Z0SkKvtD2k3u+5RhdmM1iCu+qNgjCR0/K30aP8OYF6tG8v9I6moDyCmcf0NafQhnvrX9RduUEnp1Pd86cS7s/uGcf3eB5lvWeRepz+fZO0+W4EL8Yz2NbTUuH2k0kzETlyKo+HMImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374579; c=relaxed/simple;
	bh=PredhI3R7q/9wimarm3W3vXbI8eHkpQn4ybHKU96fnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WuHIMhzSN6VlvQk0IYS0w8JHFUlyLPY8t3eCNyPvVCoRg0yCxOsJFUbNsrX3pWxqEG6KzVtciXcbly/+LrTQRzeV3dVfqjsqu0UMlTUlucSN8VQjO2MXlw/3I+fK+Lng7AQ1YaCKZLJuj3yBEFN7dExT8xHeF5zcUrQyWfie79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LY3AMfXw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20bb92346caso33996875ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374578; x=1728979378; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ygqgqmx8IGcgoxKYW9t9H7WPwtcBHsaY7P02/Ei0OSo=;
        b=LY3AMfXwbPZpPAr4+0povlj0fmViDMtaD5gWPCb6s3q8v4e3uebrUKsuKI+nYp/6ek
         zLRlW/RyQTztnMmFNEo9QdcCTxKCs2n4w1eTyAfT+Z3ZUWWGuc7U3Cme6YvgjyPonh4G
         lIyHiy4wu3GlZHxs0UqV+6m010Q7T2swQ2rSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374578; x=1728979378;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygqgqmx8IGcgoxKYW9t9H7WPwtcBHsaY7P02/Ei0OSo=;
        b=Hk28326+Q6MvMZNFo9rLltPZxa92dScsIf1FpwBmKV0yHjP+asr4cqawK0RCA01iqW
         1npzJVFdytGVfslFf4NmQVWuj5G4J1FrhlzuhZwVG1Y3tjsVmHWS8Xhvum2Uis4NVZqy
         ZMicwpL1V1+JQlENrEmaV0uZNdN2tQZNv3+50qBdgQV0NM/WFps8UR6QnixxUy57cxt5
         RHVscZRTpmQiK8/lpC5+T6dqlRBLIbU4FPYRvEad50EU3ruNmqHaI0KW1Qwmh7mMaaSl
         xnjphfBeLwGLPK1Zywj3fhxIrAZ9roRURW2Cp4/hwsnVsZYjuFxGP3OM0lQl13HzoKe1
         q1jA==
X-Gm-Message-State: AOJu0YyB/Gi9MWeMij+z4VXEp9vYSxIdNiZEOAnJJbj8po0qTF3wlCXT
	0Z9D9RDXzjVYyPH30Pa5c1mPj1Czdpj8OrAITWZvnlDBxBVfisa7fAECHIh3vw==
X-Google-Smtp-Source: AGHT+IHoMyA79OTWtZx28MH9FsnZVJaJTVWOr8UbRqf7mcwtoNrLimM/Gl7L8miCt+I8j3tyXuueBg==
X-Received: by 2002:a17:902:c946:b0:20b:5c94:da0d with SMTP id d9443c01a7336-20c4e280041mr32267555ad.5.1728374577782;
        Tue, 08 Oct 2024 01:02:57 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.02.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:02:57 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 07/10] RDMA/bnxt_re: Fix an error path in bnxt_re_add_device
Date: Tue,  8 Oct 2024 00:41:39 -0700
Message-Id: <1728373302-19530-8-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

In bnxt_re_add_device(), when register netdev notifier fails, driver is
not unregistering the IB device in the error cleanup path.
Also, removed the duplicate cleanup in error path of bnxt_re_probe.

Fixes: 94a9dc6ac8f7 ("RDMA/bnxt_re: Group all operations under add_device and remove_device")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b1dcb6b..63ca600 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1880,12 +1880,14 @@ static int bnxt_re_add_device(struct auxiliary_device *adev, u8 op_type)
 		rdev->nb.notifier_call = NULL;
 		pr_err("%s: Cannot register to netdevice_notifier",
 		       ROCE_DRV_MODULE_NAME);
-		return rc;
+		goto re_dev_unreg;
 	}
 	bnxt_re_setup_cc(rdev, true);
 
 	return 0;
 
+re_dev_unreg:
+	ib_unregister_device(&rdev->ibdev);
 re_dev_uninit:
 	bnxt_re_update_en_info_rdev(NULL, en_info, adev);
 	bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
@@ -2029,15 +2031,7 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 	auxiliary_set_drvdata(adev, en_info);
 
 	rc = bnxt_re_add_device(adev, BNXT_RE_COMPLETE_INIT);
-	if (rc)
-		goto err;
 	mutex_unlock(&bnxt_re_mutex);
-	return 0;
-
-err:
-	mutex_unlock(&bnxt_re_mutex);
-	bnxt_re_remove(adev);
-
 	return rc;
 }
 
-- 
2.5.5


