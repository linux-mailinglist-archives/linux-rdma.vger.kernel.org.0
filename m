Return-Path: <linux-rdma+bounces-5375-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD04999C17
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 07:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6571F22959
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 05:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B907B1F7062;
	Fri, 11 Oct 2024 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HrFyATTn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4941F4FB7
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624296; cv=none; b=SZ+4wdB1L6JVpycp3aUVjbeqgto8bVLS43+wgD2rF8tcQQoe61ITRnXHmVTn28ZNfMEH+9oMSGClFCsvLDVUoBAeFyhmV3kRpUCT+bu8HIdziui9yC0gDZ+HZxvGl8+FfeeIX8rpODngtKNhMlxNhjYAIJbp+i4l88B0ck8VWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624296; c=relaxed/simple;
	bh=kY+k4sDPACzGH+8nS06euudSr6Q9xC8tNyOf2R4okGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VQD+QoJgfc7kY/B0Rcctxga2gUjC6znX4dYju0ye65eku2ZiWUXwt+lz/xWsJkanzXjdt4MsCZ6ZQotwQ1zsPR/2fpxV7YPyOzm7Wl91w4ZwudTF8YrYFKPtEPbEdTaCwa8n+S5hpR91dz7wW9o/ylsgkapVm4HR8VHMcOHmELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HrFyATTn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so640056a91.3
        for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 22:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728624294; x=1729229094; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N1pIXYFYjicnxAJcgtoMJcMNKVVED7cjquULU/++1wY=;
        b=HrFyATTnrY3Om1Pfi0RO/YhOfLCy9FXzF4CVNe3UyOqwEPLAq68j+l2ubJvKAjKlFZ
         1m45RbR7gzLSCToNlcQ9yBoaGJFac64xqfgUrtn8slr3DAv/9WcytAbjl/NIXd0hPtv3
         kBHCkQDIgTP/KB+j6Ha0E0w1UUUc51o5I1+WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728624294; x=1729229094;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1pIXYFYjicnxAJcgtoMJcMNKVVED7cjquULU/++1wY=;
        b=pBIA0dWe0FINnuZxsfMPTpWp+gVf+ac4pf4FbhwbEcNIRWeyT2NCtpgSlSqlcZq4Th
         B1M80st73Nf3DjErUzddiL3GDBf5HNFZLUVL2CWXe/zXcL55QOQPR99FtkUwV/1CuXEB
         kLMUlAfLelaoMGvA0bUOY+lNM/B80c9eaAZo29C6uh3A11szGwd9LuMgRPt2am/tIiGo
         VZ6o2x7JAQEuxgKDNUx7/JhsJ5F+KH3kXzPI51m8xk95xC/z2t6HGFwH281KqOAMV9cR
         VRyzMTifv5HgkByKwsfZXk5Ymh0dPPUOmO8ENCn9F4dQzeJ5GAgowamHKIDrbpTZeeQ7
         15HQ==
X-Gm-Message-State: AOJu0YxGJ0nEMjIEGpJaD9AG42bQV3PcXUD5KwGYp9cPcrOaQDXn5Lwq
	wuEBYKcq3c2bkdHNUCdoRi4eGJSZ6yowxVTO+tGE3fF80F1lDcOiqyEHQwnbUw==
X-Google-Smtp-Source: AGHT+IFQtlE0OxXyRuorWZLz6bdIz3yHaG9SY9iQQlU4YOBjp9Mf1LhWGCBAcFkKOvv+baZsPuB3JA==
X-Received: by 2002:a17:90b:fd1:b0:2e1:ce7b:6069 with SMTP id 98e67ed59e1d1-2e2f0d833e6mr2128059a91.33.1728624294308;
        Thu, 10 Oct 2024 22:24:54 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f09ff1sm2377069a91.26.2024.10.10.22.24.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2024 22:24:53 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/4] RDMA/bnxt_re: Add support for modify_device hook
Date: Thu, 10 Oct 2024 22:03:54 -0700
Message-Id: <1728623035-30657-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728623035-30657-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728623035-30657-1-git-send-email-selvin.xavier@broadcom.com>
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


