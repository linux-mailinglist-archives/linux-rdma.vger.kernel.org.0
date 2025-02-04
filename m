Return-Path: <linux-rdma+bounces-7392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAA7A26D73
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 09:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F26C7A3ACA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959E206F37;
	Tue,  4 Feb 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KOWLejGF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4D206F36
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658541; cv=none; b=WdSMoMqiTz6fZGck9Fl4gLVZkbuf3Dr8KpNFykVtHHzC+Vw3lZNjLrZORND8HrLPFkAYJJfYY+sTXT8CFDjjU0vA1uDTSeJ67a6WUmaKc0R25AjtqplVzdL8WDq8J5O9Ib2nNFDpIJGAFK1ms8PMSddjZ6h3Of4ih/A8FcqQ5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658541; c=relaxed/simple;
	bh=T1/G1+8ieC/IsACs5hUQEQgK8gnjjgdKU7geSRT72AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f76z0jciGpIxu0o6sLCDr+8PePQoRYwVXG+HUIkSjj02wy7Vn9gHawwmYpyVojCa2p8me8jhy8zy9wD1xQgZyXVREBDWNfj0L1mZvNtdO6G6zGfwM13vY/qm2HfmuBPcLS7fMNuKkLoG4e+elxJdrXQc36GTzokr8V6QMHID6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KOWLejGF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216728b1836so89929405ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2025 00:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738658539; x=1739263339; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dATtZQmT/U8L8obXRQ30D/jYpSvuxkUY6C4KG9Vehtk=;
        b=KOWLejGFukeXJ0YS2vBbUxaef8CPPsKPFl8uIvZNmHQ5vuXXvHEBxCwP9F2PqAB9hT
         NMFF+Dc/7cPPt8dJAoIKZNVEaqJx/2Vja5nNfe0zPft2+m2SWQGE6RqItp+ZOV431xny
         l0bdW0/BKXriruMT8YCYLAwgqh0rNoEAJdKL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738658539; x=1739263339;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dATtZQmT/U8L8obXRQ30D/jYpSvuxkUY6C4KG9Vehtk=;
        b=lqVGh7EaGENcw0YKMCZBB5HL0l7eJftKcyYILGYZMB4YZPdkxugjg1WI/b5Uj3jTf4
         3mUOARBce+S4tuJuUE1izCzfegsHXx5D05siObbZxfgc/Xp/2/s+lO+26pMWWTvlY8J/
         vrZTLmeWs0zWbMxSlBbCoCHXR4Bzczj0tKQ7C/YBGlFlCtjnl/XQ+qhxGAhT8Lsq3QG0
         9ZBNzzJyzEmgEgq4crKiwxNXSVFmeA+Sb5cOsL5BDUt9qvkV4LAmnQbIwjiuNPKKe2V/
         jQL+SyMXTaIdhzrJhnHRfTL7VelvoLwZ4FQLHxAlVf2cbJaflsi4PLJgfDk3l8p6h6DO
         NyOg==
X-Gm-Message-State: AOJu0Yz+LpXHP62EYJPZmvbnEFVM7JU6JlEOeE6Y8x6NT2dp/sOYCoZw
	SJqTif06QYIDyLSvPbvZJJxL7Qa0SvgHch3XoiJ53vz0+L2V1qE7zqZaVF+lCw==
X-Gm-Gg: ASbGnctAmV9eMV3b7xvj/1lbo4iNwObIQYbZxfPay4w9DLEFRBQpgYkrQIHlcedeSKl
	on+f8A1u1oRGFhhK6JbIRD99HSxlf36yFSeCzeGxlFui+I5mlt6UHKhrWiHHc0BGId9qopFqOL8
	UxsZPqEms8ZMCime/Mo4rsDmwTMGooL8ze311NJztH+y20i9V0Sauf9Nuh4Vx3dFF/81RyIKaMz
	sEIXJ7p0zD2BMbxI9wcoFKoWeipN8Y1PAq5sEVbjp2FR+ZBNO9RjGqh6Zs7kjqNyIgtW+kf7T0h
	zwEW01ZJr8V3q444ocjiuw1f/BZIL3FnNFGPvcBatEjrSU7rg71YPg3ptehaxbPuPOL5No8=
X-Google-Smtp-Source: AGHT+IGUPFEAppsp+ee8m7V1y+Rcg+FUMiXPwAUO2DdBLj6WqJS4SSAfbwGkODOUXLYfkKzSoO7B9w==
X-Received: by 2002:a05:6a00:884:b0:72a:a7a4:9b21 with SMTP id d2e1a72fcca58-72fd0bc7cb9mr35884721b3a.5.1738658538962;
        Tue, 04 Feb 2025 00:42:18 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdce1sm9822069b3a.126.2025.02.04.00.42.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2025 00:42:18 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 3/4] RDMA/bnxt_re: Fix issue in the unload path
Date: Tue,  4 Feb 2025 00:21:24 -0800
Message-Id: <1738657285-23968-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The cited comment removed the netdev notifier register call
from the driver. But, it did not remove the cleanup code from
the unload path. As a result, driver unload is not clean and
resulted in undesired behaviour.

Fixes: d3b15fcc4201 ("RDMA/bnxt_re: Remove deliver net device event")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  1 -
 drivers/infiniband/hw/bnxt_re/main.c    | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b91a85a..3721446 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -187,7 +187,6 @@ struct bnxt_re_dev {
 #define BNXT_RE_FLAG_ISSUE_ROCE_STATS          29
 	struct net_device		*netdev;
 	struct auxiliary_device         *adev;
-	struct notifier_block		nb;
 	unsigned int			version, major, minor;
 	struct bnxt_qplib_chip_ctx	*chip_ctx;
 	struct bnxt_en_dev		*en_dev;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 89ac5c2..a94c8c5 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1359,7 +1359,6 @@ static struct bnxt_re_dev *bnxt_re_dev_add(struct auxiliary_device *adev,
 		return NULL;
 	}
 	/* Default values */
-	rdev->nb.notifier_call = NULL;
 	rdev->netdev = en_dev->net;
 	rdev->en_dev = en_dev;
 	rdev->adev = adev;
@@ -2354,15 +2353,6 @@ static int bnxt_re_add_device(struct auxiliary_device *adev, u8 op_type)
 static void bnxt_re_remove_device(struct bnxt_re_dev *rdev, u8 op_type,
 				  struct auxiliary_device *aux_dev)
 {
-	if (rdev->nb.notifier_call) {
-		unregister_netdevice_notifier(&rdev->nb);
-		rdev->nb.notifier_call = NULL;
-	} else {
-		/* If notifier is null, we should have already done a
-		 * clean up before coming here.
-		 */
-		return;
-	}
 	bnxt_re_setup_cc(rdev, false);
 	ib_unregister_device(&rdev->ibdev);
 	bnxt_re_dev_uninit(rdev, op_type);
-- 
2.5.5


