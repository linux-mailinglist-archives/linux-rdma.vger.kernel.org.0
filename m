Return-Path: <linux-rdma+bounces-21395-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCOZF+0lF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21395-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:12:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C798C5E8385
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CCB63022F45
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587DE44CAF8;
	Wed, 27 May 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="UhMcLxd1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7D44CAC2
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901848; cv=none; b=EulHuRnJhYoUP2mhjnaqfDRql2oLmUxNtIKQpvGmrbJ4pFyDA5qvAPYwgpyBpBroPBk2OO+IaWvbVICqgdM8/DIxTSqKaIR5yIBqHXTO+kOyev5BIkOcVf+MFKFPV68SBkUXZCpg2EBRwLGLlBxX8Wy1OUOGEcibcz3M3ZlC3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901848; c=relaxed/simple;
	bh=fevxdSZjCBZecK0kqCAr7ZVRl3x0wXcLq5MdSuVq8kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ot59WnPKHVqbGbL540WubFBS+ceocjsfR6ZWNbyks3uM9XT1V4XEaQtWgo2OmMPjAKVM+k1BE4jgxMPWfp14A8MYeTT+fMxjunFzxZXvJwu+4qB7TgifkBxnxZIF3tam5kJj+2G1LJK1/IIKbm99HXsm8xsqACaD15UHnpNnok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=UhMcLxd1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44a14580111so8841622f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901845; x=1780506645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9izQ8Rg6mHM9tIila18JcJ8uO9+KTod7pRo/axl+xc=;
        b=UhMcLxd1ZgMlpmFV8CzAuBHiI0B5k6DlFnOYOqnYdcHc1gN2xtVqYL/k/giNvzT3Ml
         lG//TKwRndpw5lmdAyKDp/X6O1QVWQZwgW2atb//L6t8wbkC2CvgxSqxyTZEU/DVPq8T
         vmyVjwlI8+T7XP5PhbloEMQ0f19MVv6NqXWzV+P7bgQ8FPLB25BwZVtfcEPzsYoUEZ6F
         KvuMo+FmkrIycll7zlVF+yd31JGRcLqOuSZTjd4uowSvnuu1XjkFe5lhCxV5APzGSE61
         HjuYB9Wz5+ajo1mWlJ277IS0oGSXEQnY2quKgh9XRPh1ImfVFLBZgcPW6/WzBOu5R1xo
         TxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901845; x=1780506645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9izQ8Rg6mHM9tIila18JcJ8uO9+KTod7pRo/axl+xc=;
        b=ON+OsZELStfvqaJJLrN/HA7PXqLckRWYrBoEj7G9m6GX7jnCdNrQVPXboBAE/VYcUj
         dkWUZiM9V2aMtjRa3yPa9MB+iSUanLoXkPlxVoBOBAvRXyEWKwNPz0wFRFlMx/loofZc
         e5KMqPCCizym+14+xSNJ5usRWkAA522mN6nP00ImtFt0aYQA7i858LIYVkbzDHO0SwJE
         zrr9Lg6Ra5+RGxH+aKOZxAT36DLppkz0wDmchrxZGkUZ21QphTbl2S8D4H5Kf34YcV7p
         cmj66HTcIjs9Q8V+sGaqPg7yiNOFBNE8mn5zzBotg1+PlBth1xrhQuwXBfNx++xr+Zrm
         rYQg==
X-Gm-Message-State: AOJu0YzxySPW1QVm37DHxhhMPv2HoaGgWilXEmS34P/MNF872FkZy24u
	unADeS1esaWxQnioIAI/CAPnVRXeddZPjhJQTQfFMVzMYud1vPZT/ycNyGZTiLPuogGAwxcCTjo
	cODR+lsQJmA==
X-Gm-Gg: Acq92OHK5eHjp6Q313KYJVTnnXpr+Crrj4GG5r+pL0ar2pr/FWmWZy9RlZoVT6eWWB4
	ZAmAqCfVvRiNeEEI7P1lI6AybybdOrhIlsvyIWBRYr3FQopROMFZjPKwxrf2WKcw2utqFZlGGVf
	kO4bz5fIqaZPzRdsjbEcTqk91/bcbaVK3l3aBLcynA/wpw40mzuwdTYEg9Y3LYZK8kHF+oxw5UK
	axKZMvg7ntr5qgIjOToxsBDjP8FLPkimtlYpb+oD8x1+uYitoCsTt0+YqR/qNB+x7J6IZVsTmlt
	mm9YLW66bOtMm7damG4YTtC/BvJGv9n2WtieZsUVw7J86gMp2RqVVL25BKmChvlT5XmYHl1pOkZ
	JTRxQw1IlmC3kbpwF4bPsatyfA82GPXQ00GMq+gue3742CPsL1vGzKDeX8dtw9qKgdCc94yYg8V
	gM3iGiqhChK57+aGhG0zJAXSP/mbj7LcQ=
X-Received: by 2002:a05:6000:1446:b0:45e:7415:8c4c with SMTP id ffacd0b85a97d-45eb38e0657mr42144582f8f.43.1779901844754;
        Wed, 27 May 2026 10:10:44 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b19aasm8096511f8f.25.2026.05.27.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:44 -0700 (PDT)
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
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v8 15/15] RDMA/mlx5: Use UMEM attribute for QP doorbell record
Date: Wed, 27 May 2026 19:09:48 +0200
Message-ID: <20260527170948.2017439-16-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
References: <20260527170948.2017439-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21395-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C798C5E8385
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
index 419489bd2199..12bfefc91b02 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4456,6 +4456,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
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
index 58997714df70..e8d34d54b435 100644
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
@@ -5877,3 +5882,15 @@ void mlx5_ib_qp_event_cleanup(void)
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


