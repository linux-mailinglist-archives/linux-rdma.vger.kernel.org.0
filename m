Return-Path: <linux-rdma+bounces-12586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E28B1B1AE
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 12:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1937A05C6
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4F260575;
	Tue,  5 Aug 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F5HIr8Wb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A461E9B2A
	for <linux-rdma@vger.kernel.org>; Tue,  5 Aug 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388243; cv=none; b=kzH/wBVaniM6UzwCHIKcATuS7EXXI+ySKJA/D/LOFoiCad5J8kWBtRMKiLprXHHdPUmwi1rgmmep7YUFQzFN+RpRBVp4kXh4OC11F3FXeJr7XD5XbOVzpZE30AUPjhLoMbo9h5NGXgEdmC3iOcyucz0AWdW853psAWoL1+Jmldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388243; c=relaxed/simple;
	bh=GDecfUoccvpdTRGAJ8G8E6+/5uXTS9mbY+DLJDO8Bt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyjOs3xliMQQGVUte7Hu2fnmUG784ejvSQqSphvTQY9qoH+/UrVYjdkGlpBvhyzZ28XtwxMMTh1IBWKSZoH7ASaAnTnIm0XBkowmFoVYsJSGoAuPElNv8kqB/5NZmpwVommmYgDbejFmdGrDrOMlKqCLxNsATHYt+U4SCpUWzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F5HIr8Wb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5856412b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 05 Aug 2025 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754388242; x=1754993042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjgUa9IA6uipcwpsDFsD9IAv0bBNmTwcUfIphKR7r5k=;
        b=F5HIr8WbWjgVTUY4jbhwoqxSjCyN8cv3ni7T4/S1PhJFUdH2IhzvWlTgGM6/6DPws3
         ckHk0sf7Y6vk0codo91Ddfp4AD5E4sgSN2LFdbR8cdA8luTh51zysSm48D5XBT9r8tug
         pkrsht77eCHjAn2BAMnM6caBXtTb3t0OSD9rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388242; x=1754993042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjgUa9IA6uipcwpsDFsD9IAv0bBNmTwcUfIphKR7r5k=;
        b=L7MX6ZINrkXsAh4hpPxKP1XKYs8MmGJbuvRZaofTzMSMYQ0Vo0E5m89NkaRhU6IJXb
         +8E8wfSMrwxyKBMm6nxJxofOljkUGbva+1CGgcxEHjzEo5Ga/+cIkWWz27UGi7caNK94
         1y6DGEMc54PAr+dgSRCWW5IR4JeXW/potk1PI8jBZ3Rjq9zLXC9efI2h8A6nhA32VlU4
         QAzMgvfEaArRdeKlRdn5Meibf4Bi6xioBNzPk1M1nul2Bv98PqRbh9mcFDZKeZU0o5kI
         IncEaTr+IQSMz7Kb2nfIbws7vBS8Z6d5/9ccuzENBTF0X8ErDPvkmP9yZEQ0WGg2lBnA
         t7VQ==
X-Gm-Message-State: AOJu0YwoeIX9z49EkXnAv6qxUUFluBIejC/lTs2SwSOC9cVtijch44JX
	YtKs5+JaZ74hN7MpX3fvjukY2TqniunHmDd0mIgzrc5evlsWeuCHLzpGhvt22uYv6Q==
X-Gm-Gg: ASbGncu5TSBl5wY54Yw/4qziUekQ+YV6ARMashOqAHjL6MGCUaTMsSp3ptgCYAF9XWC
	6M6FZeV6lj80jRKGd1Df/2RbL0Vn/sp0F+5eTCv2ZzcD5t8rIiBhbdwrAqcZvROPuVL9xU1mTXZ
	lI5bzilLmox6/xXBmByTF7K/DWDxsLYcV0fP6BsJtlSneBd6PvpXBrwOVHtQ3dxZcOqwxfh8LaP
	F2FR4vG5vdsclHsiS0jbG+EQIrXnDDdYO6Lek/lqPsNY7dNJBBGYNng1LRCY6pped7l/v9CEQcQ
	xEy09OPzYk4VKV+xLmVQiR7BX2mQFWuRzraBRtYPxkfsfamCUO/32oshJ1+IvnVSPMQNGm+YPcb
	RPSYCeYD7aQAjm8GXl4VM5jHzhQoMIZ46MdS8XB4dP3HfJaq7Pcf2GWGLm8gOecDy5K6we/++Vn
	ex3D65uyRLlhqLEO9hY+PLI80afQ==
X-Google-Smtp-Source: AGHT+IFFD3rdZUV3lFN8+dfgRi6Ttr1XXJeGWuWYC2dCLxbM0BJd0Q/zsiyS9RqeA81eMAL+FAvNdw==
X-Received: by 2002:a17:902:d482:b0:235:e9fe:83c0 with SMTP id d9443c01a7336-24246fefe69mr173302045ad.27.1754388241587;
        Tue, 05 Aug 2025 03:04:01 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2423783a84bsm96838595ad.51.2025.08.05.03.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:04:01 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-rc 3/4] RDMA/bnxt_re: Fix a possible memory leak in the driver
Date: Tue,  5 Aug 2025 15:39:59 +0530
Message-ID: <20250805101000.233310-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GID context reuse logic requires the context memory to be
not freed if and when DEL_GID firmware command fails. But, if
there's no subsequent ADD_GID to reuse it, the context memory
must be freed when the driver is unloaded. Otherwise it leads
to a memory leak.

Below is the kmemleak trace reported:

unreferenced object 0xffff88817a4f34d0 (size 8):
  comm "insmod", pid 1072504, jiffies 4402561550
  hex dump (first 8 bytes):
  01 00 00 00 00 00 00 00                          ........
  backtrace (crc ccaa009e):
  __kmalloc_cache_noprof+0x33e/0x400
  0xffffffffc2db9d48
  add_modify_gid+0x5e0/0xb60 [ib_core]
  __ib_cache_gid_add+0x213/0x350 [ib_core]
  update_gid+0xf2/0x180 [ib_core]
  enum_netdev_ipv4_ips+0x3f3/0x690 [ib_core]
  enum_all_gids_of_dev_cb+0x125/0x1b0 [ib_core]
  ib_enum_roce_netdev+0x14b/0x250 [ib_core]
  ib_cache_setup_one+0x2e5/0x540 [ib_core]
  ib_register_device+0x82c/0xf10 [ib_core]
  0xffffffffc2df5ad9
  0xffffffffc2da8b07
  0xffffffffc2db174d
  auxiliary_bus_probe+0xa5/0x120
  really_probe+0x1e4/0x850
  __driver_probe_device+0x18f/0x3d0

Fixes: 4a62c5e9e2e1 ("RDMA/bnxt_re: Do not free the ctx_tbl entry if delete GID fails")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 293b0a96c8e3..df7cf8d68e27 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2017,6 +2017,28 @@ static void bnxt_re_free_nqr_mem(struct bnxt_re_dev *rdev)
 	rdev->nqr = NULL;
 }
 
+/* When DEL_GID fails, driver is not freeing GID ctx memory.
+ * To avoid the memory leak, free the memory during unload
+ */
+static void bnxt_re_free_gid_ctx(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_sgid_tbl *sgid_tbl = &rdev->qplib_res.sgid_tbl;
+	struct bnxt_re_gid_ctx *ctx, **ctx_tbl;
+	int i;
+
+	if (!sgid_tbl->active)
+		return;
+
+	ctx_tbl = sgid_tbl->ctx;
+	for (i = 0; i < sgid_tbl->max; i++) {
+		if (sgid_tbl->hw_id[i] == 0xFFFF)
+			continue;
+
+		ctx = ctx_tbl[i];
+		kfree(ctx);
+	}
+}
+
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	u8 type;
@@ -2030,6 +2052,7 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
+	bnxt_re_free_gid_ctx(rdev);
 	if (test_and_clear_bit(BNXT_RE_FLAG_RESOURCES_INITIALIZED,
 			       &rdev->flags))
 		bnxt_re_cleanup_res(rdev);
-- 
2.43.5


