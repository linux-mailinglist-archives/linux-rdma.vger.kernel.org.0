Return-Path: <linux-rdma+bounces-5304-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3099421F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6A21F27281
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD301EB9FD;
	Tue,  8 Oct 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dWgoc9iJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4021EB9F3
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374588; cv=none; b=gJWcX9Ufe7tg5MfHRaG66SD9MiJtgraloI9choRUvkBsHavoBGmBk7yqvjlnCaDaC9AihBMsnWsZ62N2XhVIVRRdcObEMd9sIVoLYj87hVywPfyVGe08Z3e/jzjEpgCU5j1vcEWPFJVEGTqiD7w2vk3s6ZyCYKbA4Yv7csjKPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374588; c=relaxed/simple;
	bh=WoFetQ+lEoo/WI6x9FdJLhKjxC/mjPpRlTC7nP9HVfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TIQUfKAC3qg+u7WZC5IqYyPxkRq7gxN1JowSpk3h9BaOuP+RAPk34G40NDTeby1gU/lsL1bXmRsODkCsvVlx07xKEGBjmZ5Jr7yorSL5LKcpKTxLAMaNFh5NijTxMUa1baWhXfwjmMEBphJWIpMyMpsThzvVj5OevZ8eYCwmE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dWgoc9iJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20bc506347dso42789065ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374586; x=1728979386; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j46mP+TQ56aaAI0fNI6NQCzOnDlbfpbZeOA/S4sURz0=;
        b=dWgoc9iJXg1zDGi4t3pRtwZq4sQipQhhPGtTzB5dw+Au/K3RKOnQv6ahBK++DPZn5C
         fFiMMqLYxTW0xky0X9CXqNbxdL24/qc8FkFJ4niPDOB7vmkvYaPnVBURtnGhSPHkuSn0
         lyG4HMsph+SrvcFFiy+YMOAxENnOZ19kzAPXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374586; x=1728979386;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j46mP+TQ56aaAI0fNI6NQCzOnDlbfpbZeOA/S4sURz0=;
        b=ZTl3p6rDDAHqxcX8o4GbtXBVAYbX//0FwqW69nHR//mtGditVB8vwC9QeFQNtsqw4w
         pNI1x7GrQmXNXT5TN6uH1/Gl+8jqgYcW+at4N0rRhbseges+KAVDGohuX5yRs4icxf1B
         xMVb19IfEjC7+Vwzk8QyS6VREPx6gi00gKO/kwcfBMPEg7JxEcA91ARQQrZ1oHWNE1xJ
         2TX4azoNxhZZbZIDEbRpADl3fRUP3JdG8Cvx4youYmhwNDVXI76MvefAORBELzWzzsyz
         6WSwDIo9Wx5pcsfJk7F46d33lI0G3YFW9ntzDcgRJ4v1CxNLiOtJA21uXJyHRFdcceEu
         tNGg==
X-Gm-Message-State: AOJu0YwRB6QFbph9lk07/dYvHZB1fG/5hta5JcWI/LB0H+n5YCgPERce
	gx/7eRz+YzuwXKHHl3tRsHbFv1s3M32cY6qW2r3+ZXNOo40MZJaVoM2Y4/E3uA==
X-Google-Smtp-Source: AGHT+IHN/dnVeRcHFQ1RvOdPLm9n3WRIRo6iZef5JlcoAYoJ/AZBwmEYDe4EPTBzhJ37C6dIW4Pbyg==
X-Received: by 2002:a17:903:41ce:b0:20b:b39d:9735 with SMTP id d9443c01a7336-20bff1b044cmr197352665ad.54.1728374586283;
        Tue, 08 Oct 2024 01:03:06 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.03.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:03:05 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 10/10] RDMA/bnxt_re: Fix the GID table length
Date: Tue,  8 Oct 2024 00:41:42 -0700
Message-Id: <1728373302-19530-11-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

GID table length is reported by FW. The gid index
which is passed to the driver during modify_qp/create_ah
is restricted by the sgid_index field of struct ib_global_route.
sgid_index is u8 and the max sgid possible is 256.

Each GID entry in HW will have 2 GID entries in the kernel gid table.
So we can support twice the gid table size reported by FW. Also, restrict
the max GID to 256 also.

Fixes: 847b97887ed4 ("RDMA/bnxt_re: Restrict the max_gids to 256")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 32c1cc7..e29fbbd 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -159,7 +159,14 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	if (!bnxt_qplib_is_chip_gen_p7(rcfw->res->cctx))
 		attr->l2_db_size = (sb->l2_db_space_size + 1) *
 				    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
-	attr->max_sgid = BNXT_QPLIB_NUM_GIDS_SUPPORTED;
+	/*
+	 * Read the max gid supported by HW.
+	 * For each entry in HW  GID in HW table, we consume 2
+	 * GID entries in the kernel GID table.  So max_gid reported
+	 * to stack can be up to twice the value reported by the HW, up to 256 gids.
+	 */
+	attr->max_sgid = le32_to_cpu(sb->max_gid);
+	attr->max_sgid = min_t(u32, BNXT_QPLIB_NUM_GIDS_SUPPORTED, 2 * attr->max_sgid);
 	attr->dev_cap_flags = le16_to_cpu(sb->dev_cap_flags);
 	attr->dev_cap_flags2 = le16_to_cpu(sb->dev_cap_ext_flags_2);
 
-- 
2.5.5


