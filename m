Return-Path: <linux-rdma+bounces-19929-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMDFBdSm+GkExgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19929-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA594BE5ED
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B72305930F
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB83DDDD7;
	Mon,  4 May 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="KjI+VX9O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBB3DDDDF
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903084; cv=none; b=nrZ/g2TrHrs6Gfe1wFiMqaZqaBn+DK7taZ2OkSUzK8r0Qa9vxONHhMAjAeItCs2rzcoNECpuYcaz45UU/sOaMO+KrtdqVeVY1a7z+0/AyiIBtg1/8gY+y8MkFJhxgIlE43Gx+7uiFcdbPaVtj6wqBmbHhE6bDYQW9io1PP1h844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903084; c=relaxed/simple;
	bh=fWL6+pKQKA74Q72Y0nYPRU+1xmwT9h+zfGf8qrATHAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4bP1Aor3ooJkSW6xsi1iwFZcAEwndSrLR3skkphHNaR+NvltpzYbJ+oZE9OCdufd2nG6xTBN+vqImGdInbRFQ25QdKnOgz5d+v97cuji/NfI4DiSg5xHwPEsGfwGmVhVKXdGqKHvyAPps8vZWzg6lfs/0PtVys79xwW6LlEqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=KjI+VX9O; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-449de065cb3so1718591f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903081; x=1778507881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxlttQfz5I4C/XGu5hCBn3Tt89cCs8qCdh8b2GwcCR4=;
        b=KjI+VX9O7bDObw7+WBF8TPheMRIUDeUdzOEQdzqIHrLKUi1PkqcuOBGQ/PXe+78LN7
         rAltq/yPGeOls5I1B64cv8KQJ19YmPNnf53ubbizxZdawEOmnJCvt6goER+orMyoER4s
         AfGBsDiN9eyYMJVpUtuuPW0t/I6xahYS8IM06ysG42x6BFQ1BxLN+EHRNsV32990XpUP
         7NIeiXl7Jl/Dohwt5Eck39/F8mCaYYdx6BbziD4O/yedZ8xSCNQsnG4CtvutOp04oEIZ
         UOEjV4yszNrKLLSGaD6c82XwDNCm5RdDxt9pn5fuswBZifD0d4mII2+aQoyNyXOZxvbn
         Q7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903081; x=1778507881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZxlttQfz5I4C/XGu5hCBn3Tt89cCs8qCdh8b2GwcCR4=;
        b=ibqHbtfBQJedpHp5HQ/tVo1HsGpv1snQcz2UppRsrt4B6PB2FkhcOC9sPFQCKoDOE8
         3FGdxX0ItWQf7qsq5m90OYcH2xLiS97MxQZks5ocBLsg7csQ6vCcHpSbkW3pH7smqy3b
         JMDtVh52nR85YONWlDde51rb6dWshjDXfKnnMiwUnB+3fvwt9qzpCj6w+T3XKMpUit5w
         afjjKCe9lQfcXi6o1GKTtZL/uyChqMISaTbQcPbZmQV1Am/fGbMArfGgAET17YqWyRWK
         3wjYW74SGJBT89blgdjhogDT+HPJ+Noi1wECtOaNcjc6ZVJAZ9lor7+LbGDrQOFcuw+k
         n8tw==
X-Gm-Message-State: AOJu0YzdGxQwoFcJciatsnuGBNi+/P9KU+3ziGW44fWsbQe239eg66pM
	GX5eD6hOUeJ0u6AZm6glYdbREQ5Tb7ko4IlGnLYW1JoGUFcpUiTC2mYghHaLbpSp3HcVn3+hKpo
	wcu1Pbf4=
X-Gm-Gg: AeBDieuqcl6Tazog81SgUaLDW2Rxo75x510wpDoo42B6a3U6/8i1ESFBlqq1srwhD8V
	KeJf1xgC5MqrBlf6nDtkiNdF9NY93ZYivoIw2hiRZIxYUPciHKfDcKkLn2CurZbr/C6MGfY8NLR
	OasmmVlW0CJijFgK5/pewPd3oNpq20aROooZGc0/lyyfGodxzR6mKRfteoR5s+XynjMf5znZZfY
	N1HaD3Vv4tCQ2rYctUrVD3Q2bypNuWv2X8ZByOee4PMdPLR/r2QXfqk6l0po0jnVLteM8MtuqmP
	Cp1nvG6+fWYpfZonzWl2D4cMmkeR9DYo9Yn5Ae+7dcZgAA2h6H36EoBEzImtX1v7oqQrWLAZcFO
	yva8x+aqcpsi5C/cLdqgMijLCc/ERLvurxKG/2KfPawETm2wBmhYQfH3TAs/kPH7qI6QDi+k8sP
	2rTdzyVYYYej2CbVmN5hLr4KlO
X-Received: by 2002:a05:6000:220e:b0:43e:a8ad:975e with SMTP id ffacd0b85a97d-44bb66d6554mr16225228f8f.27.1777903081243;
        Mon, 04 May 2026 06:58:01 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aa70dsm26774183f8f.25.2026.05.04.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:58:00 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v3 16/17] RDMA/mlx5: Use UMEM attribute for QP doorbell record
Date: Mon,  4 May 2026 15:57:30 +0200
Message-ID: <20260504135731.2345383-17-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6AA594BE5ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19929-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
index 109661c2ac12..a94cf6dd4992 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4449,6 +4449,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 	UAPI_DEF_CHAIN(mlx5_ib_std_types_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_dm_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_create_cq_defs),
+	UAPI_DEF_CHAIN(mlx5_ib_create_qp_defs),
 
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_DEVICE, &mlx5_ib_query_context),
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_MR, &mlx5_ib_reg_dmabuf_mr),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 45bc8928523a..5ea0b755a000 100644
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
index 997ea9bcfc55..d384dd17b19c 100644
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
@@ -1056,7 +1059,9 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, NULL, 0, ucmd->db_addr, &qp->db);
+	err = mlx5_ib_db_map_user(context, udata,
+				  MLX5_IB_ATTR_CREATE_QP_DBR_BUF_UMEM,
+				  ucmd->db_addr, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
@@ -5871,3 +5876,15 @@ void mlx5_ib_qp_event_cleanup(void)
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
2.53.0


