Return-Path: <linux-rdma+bounces-5425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7EE9A03F9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E261C2A9D7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8721D2708;
	Wed, 16 Oct 2024 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q2I55nI8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C41D222F
	for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066611; cv=none; b=PbKAiDlpJqS8uYdkTICuGgdSbiyCKyGWSHGl3K0WaYjzRnFgtOjSjaQEVnjHR6eHaPdNxDPHaIDUBKj5txgAP6KdV/BN18eF5kknSmuK7GJLn5OBIRuAxmgrSjwRJGSjS+zkQWbg2wyfHuNqMN5Oi1C1A8f5zlq/LhwbGy7N5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066611; c=relaxed/simple;
	bh=kY+k4sDPACzGH+8nS06euudSr6Q9xC8tNyOf2R4okGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IJAXHAyesuqfWeTEMtRtZuwv3ADK+/v0JlBVhhAVICPnhuowegCJB8yvO8/q/FaoUP7vpS0368C12kiA18ZEpe2ll9K8mW3nH83wQGsomDVOFiipL/fGZAKXFFqfnbpJiNors5ZfoPW2Wu5mEWY0EyT9gb45iDSsoUw1fQiXOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q2I55nI8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso4718777a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729066609; x=1729671409; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N1pIXYFYjicnxAJcgtoMJcMNKVVED7cjquULU/++1wY=;
        b=Q2I55nI8Pvaxak2vBa4um7Df6n5dR6/VAxLVCNK+tE0lUh68QH+bJPBqiqkB8l1AOg
         xiMJZz6MmhZEkJ9CEHPzRuHVPoMcGwVgx9EuzL1aO6zI/fmVUSlct3lraozcAPXDCfCE
         x1bUtcy4dkQdhHr4DBrPlJqP9wCkGKir78g00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066609; x=1729671409;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1pIXYFYjicnxAJcgtoMJcMNKVVED7cjquULU/++1wY=;
        b=m/vsHcdqBA/GMXSVGnk7B1y40uBbzslZ7sFgJAWHndgt8xpLkN7FSeH4ta+1bfVMZv
         4aF0Bwjs9XXhhGaJFAKOdC4bUX5v7TyikQctoXRb/my1Td1mrdRy3rgMTcn3G0E8FvQJ
         mQ0DpRDyU6KTjk6dmTCLHCSP5zF0eFHhO0DDBlgfihMcqcMlGqs3Vrks37xLqb2NCm7c
         0vjk8eQKE0TrY03G1O0zl6BWCuKQQzTS3rszLcVqHYxOss/PAMXc1jo6N7N2kcmHOZAt
         n3g6Tr9x7u2rtABJvCwAPJ/QHAfO0z7ZOixVF/J6if7/efY0NDVo7vE1uPjPCySvSdcz
         elaQ==
X-Gm-Message-State: AOJu0YxzNj5zUriPE+WyaTsNSk14pbZQ9FLlWywEpml9duldkp9AZu7k
	2UDz/koKfDGyVtDVYUwcecTy+5kByRTEkbwUhnpOb4lNgWftO9ZJYDhaaZgsBA==
X-Google-Smtp-Source: AGHT+IFppDTO/lV0c4eS/1NNmwHe+idsmm8L8QKF7rj5wXCRdlZJHjCdh1R3SBelJ4fOt4cVIccpZQ==
X-Received: by 2002:a05:6a21:4d8b:b0:1cf:4ad8:83b9 with SMTP id adf61e73a8af0-1d905f7601emr3940071637.43.1729066609099;
        Wed, 16 Oct 2024 01:16:49 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77371099sm2632667b3a.15.2024.10.16.01.16.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:16:48 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 3/4] RDMA/bnxt_re: Add support for modify_device hook
Date: Wed, 16 Oct 2024 00:55:45 -0700
Message-Id: <1729065346-1364-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com>
References: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Adds support for modify_device in the driver
for node desc changes.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 16 ++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  3 +++
 drivers/infiniband/hw/bnxt_re/main.c     |  1 +
 3 files changed, 20 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 55a3cc8..2a21a90 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -211,6 +211,22 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	return 0;
 }
 
+int bnxt_re_modify_device(struct ib_device *ibdev,
+			  int device_modify_mask,
+			  struct ib_device_modify *device_modify)
+{
+	ibdev_dbg(ibdev, "Modify device with mask 0x%x", device_modify_mask);
+
+	if (device_modify_mask & ~IB_DEVICE_MODIFY_NODE_DESC)
+		return -EOPNOTSUPP;
+
+	if (!(device_modify_mask & IB_DEVICE_MODIFY_NODE_DESC))
+		return 0;
+
+	memcpy(ibdev->node_desc, device_modify->node_desc, IB_DEVICE_NODE_DESC_MAX);
+	return 0;
+}
+
 /* Port */
 int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 		       struct ib_port_attr *port_attr)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index b789e47..83a584e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -196,6 +196,9 @@ static inline bool bnxt_re_is_var_size_supported(struct bnxt_re_dev *rdev,
 int bnxt_re_query_device(struct ib_device *ibdev,
 			 struct ib_device_attr *ib_attr,
 			 struct ib_udata *udata);
+int bnxt_re_modify_device(struct ib_device *ibdev,
+			  int device_modify_mask,
+			  struct ib_device_modify *device_modify);
 int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 		       struct ib_port_attr *port_attr);
 int bnxt_re_get_port_immutable(struct ib_device *ibdev, u32 port_num,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 3a01818..d825eda 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -911,6 +911,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.post_srq_recv = bnxt_re_post_srq_recv,
 	.query_ah = bnxt_re_query_ah,
 	.query_device = bnxt_re_query_device,
+	.modify_device = bnxt_re_modify_device,
 	.query_pkey = bnxt_re_query_pkey,
 	.query_port = bnxt_re_query_port,
 	.query_qp = bnxt_re_query_qp,
-- 
2.5.5


