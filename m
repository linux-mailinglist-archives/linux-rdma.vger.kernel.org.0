Return-Path: <linux-rdma+bounces-6426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA299EC790
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2472188C6AD
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBB41DE3C3;
	Wed, 11 Dec 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZYuC8lYb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C01DE4DD
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906658; cv=none; b=AOIrhfAmyYMKDOnI2PrLyJcfVNKtJGi7vQLBgcdOS7c/2PnFUGouNAcGYm7EWh9mH3MCXCZirrjSxhMbMQHgRCC3khRhbWc6glMIXfbLh9t505itLQAxO3+Gtg4j2jdUW2ad5dJBtLsEy+Vhg4d1gNW+065war/tfDlVZi5bxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906658; c=relaxed/simple;
	bh=Ryy+XDb4+QBAxdNg+YTrQaIrLJTqHYQ+ec6iOPWqOoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCL3HNnBZmbU9PShN/R5FAEKdBF3L7saWhJ5oWBrzMQKObQiuCOSvUrtBKi71P3XyYt3bvaU6HKAhzBDX0dXAeUNPga+3+CpJkg4P986FE8igAu72SlD+ioGzPMwD/iolY3rPBgRZ+XY+ilJgeiQraDt9IRoPiYxrf4N7LE1T+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZYuC8lYb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725abf74334so5341768b3a.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 00:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733906656; x=1734511456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOYZYdU3JWuoiavyQRrUsypvOvLtXEF8XXAnKXeMFSk=;
        b=ZYuC8lYbJ8nOM9SEN8zIb/2brp3ZBGh7r6GYtu9V3bIBAyd9/93ig6xbrzUUApBNir
         97fm7EEta8TMFpumDlMz+7ROdxTyHVct4B/rac9ceUrIptbsGoSBAIjzGJLJS19fm9Q/
         D8obAvQNc8WeQO5WC1i7E23tOaPpDcLYfRq38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906656; x=1734511456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOYZYdU3JWuoiavyQRrUsypvOvLtXEF8XXAnKXeMFSk=;
        b=bzfyz0BqZGVywontl5QKzq9F0iNdz9uODhSB/1PEyyzKuI2ttSzooQWnbLBKibAKB+
         5wf+LU8VfzFhwGLTGqQcw+3o+KTm/E0R4VU7YhBTnty7qwNBPuGkfnPMIztCgfkrPBgD
         xqZzOn43mCXdiBkkYAvREZ4+cMKT5ruSyAPh5YONPUrCiWes6whCo3nhb96P54ALz3CG
         a+GzjJY0xUjw1GN8jGqnwPZgUv4F1ogTf6dYNR+IixkTwxl0DE3rEahIK8r7FuewPVNX
         LMb6BLs897+ZL4VysuC9+j0/lHH620DpaVKwydHM/JiHkbKAjRJZmFMsxlnFVAr9MZZc
         f5UQ==
X-Gm-Message-State: AOJu0YzzcKA7JM4KwqRqP+AV0epEVGTpj161Q4cUWC2fSKElrAnMTjEy
	JkXvaiVB2vOcThNio0IaXID5zHb/qM/eDTDUoBo4/AyZtgYEpJL8bextUdGVtw==
X-Gm-Gg: ASbGnctdylI/6n2QKCZFo6pADHhgYoB6EEhZTdG04zN+hoCkAgsnMfKC72Vpo53pyks
	5eSn5eGlIckqGtXrQcVSBP6LT7wiKqZfBfT+gdWyFIBDFIAs63iHzj/87W7Cm07PjICOLxhQVZd
	Ak+aGIxBNtfUJYrYQ+XIkFMWgOIRuIjtYkREzgiL8b6N+1XZ2CdBkTfPiE+ddZjRhD12zmzYhmT
	AjIkmh461I4WS6Y5oR41CTGgITP/Kq2Vu9/yOKhLKFUe958Ebqh//ukMsOz0eGSMIcuHw6gTMMq
	Iu276/nuygwOSdusz51/plmLHbIAG98qEV0LRd36+88KX1nOSZ4gh9Vt
X-Google-Smtp-Source: AGHT+IGRUbfLlDOnYmlfofgJGtYyR27Yk6k4nkntVf3cWG0h3zyIA4Mtq6Y/DnN5k3NFqYSK+WbUrA==
X-Received: by 2002:a05:6a00:4645:b0:71d:eb7d:20d5 with SMTP id d2e1a72fcca58-728ed3cbe04mr4043354b3a.8.1733906655896;
        Wed, 11 Dec 2024 00:44:15 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273b69ce95sm3653678b3a.66.2024.12.11.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:44:15 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
Subject: [PATCH for-rc 5/5] RDMA/bnxt_re: Fix reporting hw_ver in query_device
Date: Wed, 11 Dec 2024 14:09:31 +0530
Message-ID: <20241211083931.968831-6-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver currently populates subsystem_device id in the
"hw_ver" field of ib_attr structure in query_device.

Updated to populate PCI revision ID.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Reviewed-by: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index bcb7cfc63d09..e3d26bd6de05 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -199,7 +199,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 
 	ib_attr->vendor_id = rdev->en_dev->pdev->vendor;
 	ib_attr->vendor_part_id = rdev->en_dev->pdev->device;
-	ib_attr->hw_ver = rdev->en_dev->pdev->subsystem_device;
+	ib_attr->hw_ver = rdev->en_dev->pdev->revision;
 	ib_attr->max_qp = dev_attr->max_qp;
 	ib_attr->max_qp_wr = dev_attr->max_qp_wqes;
 	ib_attr->device_cap_flags =
-- 
2.43.5


