Return-Path: <linux-rdma+bounces-5403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E909499D644
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 20:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125C91C22266
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18D1C831A;
	Mon, 14 Oct 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SglTaY2o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7E1FAA
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929823; cv=none; b=QqC3CIth+6I4hy235rnUND6x6nXiI034LCN9M38IBU4jvGOeSCSHyijSC+BGFJkJqPPKw9tC/YgQHAQKuA5BE4Pcw2aP2BGCjOLihpy7YYOqzRR3KrCaesE4+h/Bb57GdDP9zp1QYMcX5z6R2OV9xbwIPUKbvClmcuNH/oINmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929823; c=relaxed/simple;
	bh=kY+k4sDPACzGH+8nS06euudSr6Q9xC8tNyOf2R4okGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SuRoiwp/ZcUQOP/L6HwhPaDXN5M4GqtuyfGduRLdzD85+CI4SvfO7QgbzhSPrBUPHDiCvIeK2WH+UeLBRuyisRaLlLebQ/LXqjt2JaBIdWJhaPLt6Y7CUWsDJ3+dqvg/U4vR4cewEg5gJ7IcjDeAslRTk/irYxzOMtMjTk3n7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SglTaY2o; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cceb8d8b4so11822515ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728929821; x=1729534621; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N1pIXYFYjicnxAJcgtoMJcMNKVVED7cjquULU/++1wY=;
        b=SglTaY2oUxC2lQ0M2p6pFI78dqL4B8Z64QNoPZg0k9B3lEFgg1RRv+yVmPzWIekyg0
         Gc8qKzDAxqovcQLi3FevqpJcPhCK9pkj7wb/vVl1i+Cmmt61fFdzqpQfWhGYCR6eTEbV
         IUaXx+8R51rwjkfzMaKGrFg+UYVbwGQX6HQ84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929821; x=1729534621;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1pIXYFYjicnxAJcgtoMJcMNKVVED7cjquULU/++1wY=;
        b=b6B3Wjk6cv6NAhWXlMK7Ub3+6wvq3bbces3PXJPodPHwtyL5ab16K1ifd1qYGRcwRc
         eai44qkUwcH7Tv3WQL927AeJri7/TL5RNlBZ4qabnYRLuy7yfhO+EeU8ssANBSoTr6Iw
         Z6UasoX9D6s0oux/5xc00+hJv2qYBn4PAe/WzxsspXk6nv12VhxPU25ISgk1m6ufVEh/
         U9H5mBabHKfE5RkSfbLwCn2dqmGAF18k51/axsq2T2ZxMoXOIsfj20ObsmPM+LvXEV3z
         P18LB95YN8ZZqMN4n6tCRr2sBVML9eVqh9aWUWFkcaXreUKI99o6SpI3Tv2+lActZbt4
         QEew==
X-Gm-Message-State: AOJu0Yz3NAhHxtICwkLtDv0gMjAqwxabhoIDbl/sE4/FN4IUPdlJCv1t
	7G5zZnUsfLPN4TnTFAtgsXeq1b8ujQi9xm3rC1U3lI5MpLI2Lf/nN40ONdckzA==
X-Google-Smtp-Source: AGHT+IF8AKTKtS6+5VOLrUiO55GqK9KfDqRWVTmMKgOM54HKhyF/fi1SoYo4PrB55DCuyAtkqNP4Ow==
X-Received: by 2002:a17:902:e743:b0:20c:7e99:3df2 with SMTP id d9443c01a7336-20ca03d4703mr173396975ad.23.1728929821444;
        Mon, 14 Oct 2024 11:17:01 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bada14asm69245605ad.7.2024.10.14.11.16.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:17:00 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 3/4] RDMA/bnxt_re: Add support for modify_device hook
Date: Mon, 14 Oct 2024 10:56:00 -0700
Message-Id: <1728928561-25607-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
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


