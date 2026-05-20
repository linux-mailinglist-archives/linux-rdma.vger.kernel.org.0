Return-Path: <linux-rdma+bounces-21048-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ6MNSWJDWpdygUAu9opvQ
	(envelope-from <linux-rdma+bounces-21048-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:12:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ABE58B7B3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8AB1304EA27
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2013D6476;
	Wed, 20 May 2026 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="RZnOM8MY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D63CFF7E
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271926; cv=none; b=N+OPX/lLZ6Wmm91Rvikg5vbi8Mg2i4GqI/X9u0cdk3BhFooO+gWgB5SWmIRUnwHlf6+7rbSHTJSKB3AwBMxtAaZJ+doZyynzkaz1Wj2YGm1TxpLyEPRrQ4oBJiyCoD24nhL85uHZIEbeK7J6+KTKjvsNP9PbSJ3z/sOsmM4f0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271926; c=relaxed/simple;
	bh=3MBUSC56L3QG3w/RCNq7t2nwLk+Z/8r802JEBYfd5wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQoIWqDcytBAi/OWtIsBWWVXy/wSxNrKvXcUj3ASGOtb2tOHbdMkJ/YFaMb3nck/zmaYhDAB3lVsawgmBOY+4ypN9s39qT8NkFQpzWSTNMJUqQx47aaLzzAXR9bTuCrurJ46ZZiiA9pfMViRbxlYftDvQJRTD3tFnP2BVwNlU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=RZnOM8MY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso49641845e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271918; x=1779876718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3pRgsOLNcuNG8pxrFALvJMmV2NBYkMcPr8zoft7jYI=;
        b=RZnOM8MY9cXILlwLPNeTKrZRjTqQnkjWxlJ3MKRMuAybQTHGZUL6XJS4k0iCvt4fAS
         x5d/qPTY5BqwLAJGwgTJaMOAtvf7bbhrTe6zmM5hV2/k0TooBtzKRQ92cTYTG5B+K5eu
         p49VZGz5cnMIf1y2Bk8MWNlDEdiLYoL72aENZ2XO+tsj4l1l6f75E4hoAVtlTn5aeoiS
         6/qY4o/Gn/mwMvNKvP9DBeWTQ3lm3f17MuZALm1cjRaP726igR8b1wU7RCXV6kT62e2K
         hIsj3Q+D69hf4CvSiFiSM0j+QTcBbusjzGFjTO7ZnCZXC63A60fMKvheLV3dtFDhy6RA
         y/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271918; x=1779876718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3pRgsOLNcuNG8pxrFALvJMmV2NBYkMcPr8zoft7jYI=;
        b=dKTdVFle2KKSDuprfF5Y3J4X0Du9jaamV6c0oLt0/AAEX6qvFq5XP68XTe/serKi6h
         Qaqr0ZUpzCv4ol2/snNeoDRh7ipKWS5sZvMtU444WoRSU16rPN/R5+wK6p9xVgcFm34i
         /744IsFmTPmUwD8bIa/1IzHkTZyoKjaOCnqG9OKEaFWBDfkX/HIjitXBwwudOMItCHfV
         viBH5HTMt1ZYMUGDUTbJj38DXH2nEpGeWMtWVZBJIn0UxITSM19zNZ4Nk5jEhHaQsqBC
         6keAKm+Xq3fBX98mOxDioqAGCw1zuQvV9PxdOKT/krWpl+X3rWB10xrzsJNkGbYKhMT8
         vLYQ==
X-Gm-Message-State: AOJu0Yw/wr19IaD+DHMclxL+Uk9DXJjfaSAMsebaZGrvKL0P94AY1tn7
	FQjfL6AQjmXTMp9z+CI166tAYx+e+1ZuFOSlXp81EZD2plst9tWpwzhmFsjg+ltWdPVct4b05Nx
	dOJ52unt0kg==
X-Gm-Gg: Acq92OG/zIxEriIxJmYMgOdVJsEwemfhbyfJmZymhBXadCWoWT/7NGZEHbymo8aDCmO
	G/TQfT3DTGHbsHPWaUrW2wiI7BsvyIll7BHb5njShqKHQ4AsOdWiSJd9OJN8OA/xxElv0yite6j
	VPqmJ0BHFdfQQtJmqIq4fxRaCAvxdl5IXz/aA0zaebt9aPHogc8qjTJGXLT5U2++8RYfejYouDY
	hw+vZ7zHPqxJyKtZwXj4kHGY6yKoeMJ/hidbxWlhnU4BvOLDFuPKcyEPv6TWlh/TZsiQ6g2X8pX
	tovomrsobb8r+roJjPmwUK1ynY3P+j+VNERfDWjI4+smfAOCoXvzAwJWGK0k80uPoCWJxTCgVSS
	71WAqznfeEVu5xeOzk0304LfyWl1AU+onDXY/ZTkSsSmEEQWP1wxQAz/yiK2jIB5zR6+WUATrYg
	07YbNWtS77QKjlj/FlEErKHEAWtwjYi1f+xtQDLG2AdS4=
X-Received: by 2002:a05:600c:181c:b0:48f:d5b2:7c1a with SMTP id 5b1f17b1804b1-48fe60eca66mr232623815e9.13.1779271918078;
        Wed, 20 May 2026 03:11:58 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c90b27sm403036125e9.8.2026.05.20.03.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:57 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 15/15] RDMA/mlx5: Use UMEM attribute for QP doorbell record
Date: Wed, 20 May 2026 12:11:29 +0200
Message-ID: <20260520101129.899464-16-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101129.899464-1-jiri@resnulli.us>
References: <20260520101129.899464-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21048-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 98ABE58B7B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Add an optional mlx5 driver-namespace UMEM attribute on QP
create so userspace can supply the doorbell record umem
explicitly, symmetric to the CQ side. Resolve it inside
mlx5_ib_db_map_user() and use it as a private DBR page when
present; otherwise take the existing UHW share-or-pin path
that preserves per-page DBR sharing across CQ/QP/SRQ in the
same process.

Add mlx5's first UVERBS_OBJECT_QP UAPI definition chain to
attach the new attr.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
v2->v3:
- moved QP DBR attr to mlx5 driver namespace
- added new mlx5_ib_create_qp_defs[] UAPI chain (mlx5 had only a CQ one)
- changed to use ib_umem_get_attr() to get umem inside
  mlx5_ib_db_map_user()
---
 drivers/infiniband/hw/mlx5/main.c        |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  1 +
 drivers/infiniband/hw/mlx5/qp.c          | 19 ++++++++++++++++++-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  4 ++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 428811fa805b..d18187107ff4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4455,6 +4455,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 	UAPI_DEF_CHAIN(mlx5_ib_std_types_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_dm_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_create_cq_defs),
+	UAPI_DEF_CHAIN(mlx5_ib_create_qp_defs),
 
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_DEVICE, &mlx5_ib_query_context),
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_MR, &mlx5_ib_reg_dmabuf_mr),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 078f281bcdac..1f03c05b0cbd 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1511,6 +1511,7 @@ extern const struct uapi_definition mlx5_ib_flow_defs[];
 extern const struct uapi_definition mlx5_ib_qos_defs[];
 extern const struct uapi_definition mlx5_ib_std_types_defs[];
 extern const struct uapi_definition mlx5_ib_create_cq_defs[];
+extern const struct uapi_definition mlx5_ib_create_qp_defs[];
 
 static inline int is_qp1(enum ib_qp_type qp_type)
 {
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 9accc5dc70ee..970a5abdda24 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -44,6 +44,9 @@
 #include "qp.h"
 #include "wr.h"
 
+#define UVERBS_MODULE_NAME mlx5_ib
+#include <rdma/uverbs_named_ioctl.h>
+
 enum {
 	MLX5_IB_ACK_REQ_FREQ	= 8,
 };
@@ -1053,7 +1056,9 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, NULL, 0, ucmd->db_addr, &qp->db);
+	err = mlx5_ib_db_map_user(context, attrs,
+				  MLX5_IB_ATTR_CREATE_QP_DBR_BUF_UMEM,
+				  ucmd->db_addr, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
@@ -5872,3 +5877,15 @@ void mlx5_ib_qp_event_cleanup(void)
 {
 	destroy_workqueue(mlx5_ib_qp_event_wq);
 }
+
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	mlx5_ib_qp_create,
+	UVERBS_OBJECT_QP,
+	UVERBS_METHOD_QP_CREATE,
+	UVERBS_ATTR_UMEM(MLX5_IB_ATTR_CREATE_QP_DBR_BUF_UMEM,
+			 UA_OPTIONAL));
+
+const struct uapi_definition mlx5_ib_create_qp_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_QP, &mlx5_ib_qp_create),
+	{},
+};
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index b63e75034cda..ddb898afd813 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -277,6 +277,10 @@ enum mlx5_ib_create_cq_attrs {
 	MLX5_IB_ATTR_CREATE_CQ_DBR_BUF_UMEM,
 };
 
+enum mlx5_ib_create_qp_attrs {
+	MLX5_IB_ATTR_CREATE_QP_DBR_BUF_UMEM = UVERBS_ID_DRIVER_NS_WITH_UHW,
+};
+
 enum mlx5_ib_reg_dmabuf_mr_attrs {
 	MLX5_IB_ATTR_REG_DMABUF_MR_ACCESS_FLAGS = (1U << UVERBS_ID_NS_SHIFT),
 };
-- 
2.54.0


