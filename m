Return-Path: <linux-rdma+bounces-22229-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lGH5Jcm9L2pqFgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22229-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:54:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C0F684C33
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:54:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=LTH3d9ab;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22229-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22229-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6110D304B9AD
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D983D5250;
	Mon, 15 Jun 2026 08:51:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB303C2795
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 08:50:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513469; cv=none; b=O0ivosBeBk0fBPbnYw1qrRSBDs6LUu7piOd3a2T6JQEtfNi7grOtuR9BqO/AGJ/+NCke9/Blc/9pCIX9YXQOMD72wT70YupD1mawzB2FkLL2RLyEFwoWZtlBWGB74k9b3Rcp1MK2a7suVl0lyAr21kVgCjJXPWBi/IqnJGW8dOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513469; c=relaxed/simple;
	bh=mSN9Mpz+T0z3hwBDr/T4yw1H/GRE8+IHQPvikd9txJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwIu6Amw/4hk709QTDYF2C0l7DUI0Xpz7KnU5OqZoRBL6FZM/UPDzgVVUXe3L7xvC+9K8fpxwMHL0vNVG6Fp4myQwqswy60BJ5/VmRPSCaDOQ19g1T0FqbwIsYIAz0Craizqzmx0SNhAMgx3Dx8x3cFKkN8alWFfB9ZzRVUBfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=LTH3d9ab; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4905529b933so30875595e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781513457; x=1782118257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UFB0VV200uFZjBoOZFsiZLAKpXQCuDw7QshVi3yes0=;
        b=LTH3d9ab+iATQDVMz7oMSKnIMW0YdjBX+fv7HrlWkaww/P2P/lIeN+Fx5ZB5L2cN6b
         yfSpKxqwZG0Wqo8jPUfFhQQ63TgcJmi8tPFm4uEQ9PKmp0ULAT7L/gWjMONRwUIJhIKY
         520xrNMvLK/vwfeT/JbmcOSCp5osnVudDzsJVvlOCX1LuNkoHSjmq19WwYO4BphSQyOQ
         UHIXaQrZO+Q7sJvTo69w40wRr2HLQxMzgu9pjoNl7NCQbbYz53OFDv0QlkwiDV+t8+8l
         IfmvL3sqftAHPAVXfwNgOd2d+fktmAulzqGwKCyH9fIK8vT3mI25YDNF2hZDMzWnewGI
         1KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513457; x=1782118257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UFB0VV200uFZjBoOZFsiZLAKpXQCuDw7QshVi3yes0=;
        b=FgzAjCbIJKaz5PblidkUHbaF7QL/Kym+IMYlp8oq21N6wQrV82khHo7gbBFrZBlIG+
         KP6QVnGopJn6LxgjXGTc6C1SpjCYzZbiEuL8mn7jLC964SB0Tb9QuIlDZm1e5fUXmnIz
         UkOe46Ua5oUrd1Zo0jyoRAB55h8FZjhm1wp0SrU31EJSrpzyIrdzHj8vMQh+InRJvCqb
         ZCVKZHTB9UsYb/IEIPbo371iZaLtfEM0MmRZVrDQx81zXKQO0LTeGDg0YBjTbrNEihbG
         oOzdMP/FpCOFS5lYd//migwrmgToXyH1boP4z2pHFlds88+lEI43z1qW8E7/WVboryjA
         qyAA==
X-Gm-Message-State: AOJu0YybhEJw4SvcoJFGyOrogzPRp7F7rHndmLUaCrwCwIAHftSkwusM
	TVP/P0obmgz9OMV0vtS1zSXUs47FTkZYeZbTN/I3tC4ekUHt32Dxk1T38WI755k0ZqLL0bT2KoL
	hOxI6
X-Gm-Gg: Acq92OEtBvylyPujqgsO2rsfuH5A0jcwYSuMNoZABggpkwwm+M3gMNpm0I9brmR9FnL
	QBciyz+vUAeqTmmaB/dmZffFJFSavXUPeCBPEOOcZVSAcJAenPYeXRBQWLd9hKWaO2v1hPwakbW
	YECbocLMpgY+J/vfbCcbEkwcLll0tjnKPgnGo8mxdcYbINYoCjPZlSWQLs/izC2PVRFhIRmZ3bY
	bo8uceHGwUiUC/H8XTqbxWEVOrMVYS/BSj0G3RMHgDeufSh/cC2ko2+tZBSzVorCge3qk8/Nyaw
	VvN3M5mmG9FxLbsBLIBPfIStw+v5Vz3sRv8SFOMq281taaUjD0inQPm7IIAH/aavasHktCqIyGt
	nJblOSbXzvXMpS3gY+RTKoJFEWz/5aLYubomBEOTK9pMjXAbB3O6a0Npg12DLe8PSkQ7ghjhcqO
	1crorkhikFurgy6gqMVyw9IRsTlo3X9/QI
X-Received: by 2002:a05:600c:1d22:b0:490:e5c1:b8bd with SMTP id 5b1f17b1804b1-490ec313655mr182356685e9.0.1781513456618;
        Mon, 15 Jun 2026 01:50:56 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202edc23sm238495895e9.2.2026.06.15.01.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:50:56 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com
Subject: [PATCH rdma-next v2 3/6] RDMA/mlx5: Use UMEM attribute for SRQ doorbell record
Date: Mon, 15 Jun 2026 10:50:37 +0200
Message-ID: <20260615085040.1396623-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615085040.1396623-1-jiri@resnulli.us>
References: <20260615085040.1396623-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22229-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,resnulli.us:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2C0F684C33

From: Jiri Pirko <jiri@nvidia.com>

Add an optional mlx5 driver-namespace UMEM attribute on SRQ create so
userspace can supply the doorbell record umem explicitly, symmetric to
the CQ and QP sides. Resolve it inside mlx5_ib_db_map_user() and use it
as a private DBR page when present; otherwise take the existing UHW
share-or-pin path that preserves per-page DBR sharing across CQ/QP/SRQ
in the same process.

Add mlx5's first UVERBS_OBJECT_SRQ UAPI definition chain to attach the
new attr.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c        |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  1 +
 drivers/infiniband/hw/mlx5/srq.c         | 19 ++++++++++++++++++-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  4 ++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index a558ac5bb219..e07479346f1a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4468,6 +4468,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 	UAPI_DEF_CHAIN(mlx5_ib_dm_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_create_cq_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_create_qp_defs),
+	UAPI_DEF_CHAIN(mlx5_ib_create_srq_defs),
 
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_DEVICE, &mlx5_ib_query_context),
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_MR, &mlx5_ib_reg_dmabuf_mr),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 0550cdfacad4..1b77668eb50a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1516,6 +1516,7 @@ extern const struct uapi_definition mlx5_ib_qos_defs[];
 extern const struct uapi_definition mlx5_ib_std_types_defs[];
 extern const struct uapi_definition mlx5_ib_create_cq_defs[];
 extern const struct uapi_definition mlx5_ib_create_qp_defs[];
+extern const struct uapi_definition mlx5_ib_create_srq_defs[];
 
 static inline int is_qp1(enum ib_qp_type qp_type)
 {
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 6fa4c5a9a0d5..a973c1b7515f 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -10,6 +10,9 @@
 #include "mlx5_ib.h"
 #include "srq.h"
 
+#define UVERBS_MODULE_NAME mlx5_ib
+#include <rdma/uverbs_named_ioctl.h>
+
 static void *get_wqe(struct mlx5_ib_srq *srq, int n)
 {
 	return mlx5_frag_buf_get_wqe(&srq->fbc, n);
@@ -78,7 +81,9 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	}
 	in->umem = srq->umem;
 
-	err = mlx5_ib_db_map_user(ucontext, NULL, 0, ucmd.db_addr, &srq->db);
+	err = mlx5_ib_db_map_user(ucontext, attrs,
+				  MLX5_IB_ATTR_CREATE_SRQ_DBR_BUF_UMEM,
+				  ucmd.db_addr, &srq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map doorbell failed\n");
 		goto err_umem;
@@ -466,3 +471,15 @@ int mlx5_ib_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 
 	return err;
 }
+
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	mlx5_ib_srq_create,
+	UVERBS_OBJECT_SRQ,
+	UVERBS_METHOD_SRQ_CREATE,
+	UVERBS_ATTR_UMEM(MLX5_IB_ATTR_CREATE_SRQ_DBR_BUF_UMEM,
+			 UA_OPTIONAL));
+
+const struct uapi_definition mlx5_ib_create_srq_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_SRQ, &mlx5_ib_srq_create),
+	{},
+};
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index ddb898afd813..3528743e3858 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -281,6 +281,10 @@ enum mlx5_ib_create_qp_attrs {
 	MLX5_IB_ATTR_CREATE_QP_DBR_BUF_UMEM = UVERBS_ID_DRIVER_NS_WITH_UHW,
 };
 
+enum mlx5_ib_create_srq_attrs {
+	MLX5_IB_ATTR_CREATE_SRQ_DBR_BUF_UMEM = UVERBS_ID_DRIVER_NS_WITH_UHW,
+};
+
 enum mlx5_ib_reg_dmabuf_mr_attrs {
 	MLX5_IB_ATTR_REG_DMABUF_MR_ACCESS_FLAGS = (1U << UVERBS_ID_NS_SHIFT),
 };
-- 
2.54.0


