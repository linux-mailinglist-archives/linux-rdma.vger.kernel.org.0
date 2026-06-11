Return-Path: <linux-rdma+bounces-22118-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lTQ7JRnRKmrfxQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22118-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B2672FCE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=BcfBgB1t;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22118-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22118-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F5B230C97CF
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFE73F0773;
	Thu, 11 Jun 2026 15:12:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296A3F0ABD
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 15:12:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190766; cv=none; b=cdWDVIGSud/hO9P7iWT6pho5C/IpeEZl4eiuXXFjeK+fDaDBFuvjr9lDUoQi8RYGxvD2qcnDQRdflnrlNuZw+tWNjaY2/n2T9OLyYT8khKhh1MqVKB1qbYXUPtBYhm434Kkx0XSWqIe0eWO7McNkiISfSV1s8lxlvq1NqRttcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190766; c=relaxed/simple;
	bh=mSN9Mpz+T0z3hwBDr/T4yw1H/GRE8+IHQPvikd9txJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0quDqtwe/mjnZh+4KZTZW9gv9lWPUVS7iPNHx7LD+6qqGcDcnhjO7iXpCBeGLFWnA/3a5tJQ2F0aOXk8hiOKYLLJx6PnEdFL5sYSuzTzeaZstpSpdwTmzZwaBred1YheWD8tsBMPA8GX44rl8VXlyLYCQ+r6RkxDAsoGne1juU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=BcfBgB1t; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4905529b933so86062355e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781190763; x=1781795563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UFB0VV200uFZjBoOZFsiZLAKpXQCuDw7QshVi3yes0=;
        b=BcfBgB1t9x0Cg1iT7ATLQJn25ga2hYqKMClvKcovxETpDo3WPULnhkuNvBKcTMqOND
         mmuaFjUFPv64jVlqDA0junKOkjlXa8Tmy3q0cBSNkCvovi1NtSumFO6aQo7EBHEXTp8n
         DD/D2ipIQeclWVwbgNo0fPUUl4kBRjjB34zW/6ZL5Zr0OJ7KkinlI7fkFZdCug1nMj/C
         EyLwbL1ixNez45t+nVbKjQpBlE6/6WmZQQNwzVKbzCMjE8MSf15hpW8dGRXw5ndeDGgL
         +M0mHxTlLAwsLKXUjaurkoru5MRWImi611vHcqexDa9LHZK7nGYQXKcL1oLzuj+Matjv
         VMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190763; x=1781795563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UFB0VV200uFZjBoOZFsiZLAKpXQCuDw7QshVi3yes0=;
        b=L92tOizX8TePPnddbRnEOuu/KH42+1uodgN2KHKl1zEOTljOz4pTE52J5K8/HOMc5L
         X1Eg2uJvRSYa3UqUEc0sYW9Xibs+o/gp0YMI3Im/5Yz/gZzrORKhH1C8b459DfmX+I38
         6LbCRrKki+aLuNuCuR+X4kAQtPHa84cTDKgB5wMU3bCW+fJ98L8qP9XxjGCncwnTgD7U
         yJeMZtLk+zxdurhLt2sPKrb2cMltG1n57wXPaTEtOC6OicXMVzwWKOX4sZ9j3VehGnPU
         8UTuGrRM/1pvEKRGsiIPDLlE21Ub9sxKRWy77POHL8RikhvMGOznkTXtRf/HoBsCq/Q5
         E2NQ==
X-Gm-Message-State: AOJu0YxWHZ4d6TnHL2Zne/4VeLpFz9KUMZKuNLIIMkt3gMHNe9WLqPFO
	Lo04Bmlxf8AD7k2ZxahtLgBmj9eEPNnAqT8/Ze/ZINyK3Pkd4rpJXKH1XJ7Ws8ThDXPmV1P+Rd8
	6Q4mt8nYI9w==
X-Gm-Gg: Acq92OEaOSPemwUK+YaJ9xdyOzrM+yGaCIMOgl7bxvXFFOjPikYGYsJUSmG54klNhQQ
	4OBA5fhqGLbh6J5f5lcz/kD0l+Ie0OXprEWocysr8AyTOxKV68KU4Ozp7RQb5RjKnYgocPl43KI
	9yPLYNUdKVKTuz3Zrb4yGocpSCkLTpx2EUfXBL6ykvkQ0Ec5g6CdIX72YiNuor4qY0bk/yHw6oU
	Po3Gjd75biOHBdyEbtbFnBjdwV+8uqWzWbpZoASF7sKqaP//4U7Np2ndkjgPBztBh7N5EIx0k+2
	DEfSTAU3aotoNkC0FLjHeRfa6pZIuyv1XGAdFwNvdH9zynn6jgkfLONfnV83wGtzLttKoEPAdHs
	+f6Fjb6/J5X3Da77gPKXdOEGWln2Cahr5a6SdCdTDjyv/iF954Z5OmPKSBa2LV6PXhiQgSVIo/k
	xA97mNqiMbjnPrXw1N4WTxNQXDL17LQ8NznTqwWPnz4Wo=
X-Received: by 2002:a7b:c399:0:b0:490:c024:2eba with SMTP id 5b1f17b1804b1-490e56172f8mr35397255e9.22.1781190762445;
        Thu, 11 Jun 2026 08:12:42 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e47a9284sm48779465e9.1.2026.06.11.08.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:12:42 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	sfual@cse.ust.hk
Subject: [PATCH rdma-next 3/6] RDMA/mlx5: Use UMEM attribute for SRQ doorbell record
Date: Thu, 11 Jun 2026 17:12:26 +0200
Message-ID: <20260611151229.879514-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611151229.879514-1-jiri@resnulli.us>
References: <20260611151229.879514-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,m:sfual@cse.ust.hk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22118-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,resnulli.us:from_mime,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 060B2672FCE

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


