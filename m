Return-Path: <linux-rdma+bounces-21516-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OO1NnuZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21516-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F92603182
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2149311331F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBB233D4EC;
	Fri, 29 May 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="jC2Jh4eu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BA2C0260
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062250; cv=none; b=CLRKnfokBoLWfOgqtlxDdzsQLccF7Z7oP4wpNGOuxGtLHe7uPbioVe9fmcutMO7jBgzBMaaaFf/YwTIOv57wvG/+FArUEVqnnYaIH7bY26P+psprF7JdC3mFUdfW1lyH6O7cIy/HctuNomM5CD73rT2S6l4Ej0/TFRtcKNWdj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062250; c=relaxed/simple;
	bh=fevxdSZjCBZecK0kqCAr7ZVRl3x0wXcLq5MdSuVq8kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNf6VU4LLsLlmBMuJIAgjd9vxP5t7+fdZgZFWBNp9rpWUJ8xbf7DJKFxiMS1f8IitPY/jnkKVH6hDoh194aJvV3ShZCUT957Xt5IMT6xPvF/MJYb11v1U3HWzBRMdrSvaONLvNvqwv+xmIeASgLN3qbkq3yeOTbz0Vw7//dGwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=jC2Jh4eu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4905529b933so56054235e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062247; x=1780667047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9izQ8Rg6mHM9tIila18JcJ8uO9+KTod7pRo/axl+xc=;
        b=jC2Jh4euXlxJ70E2SBeA9bYMyG0YajJqQZ+7qzQLMmiLtjQhm1CSMPcO7LRMGNW6w0
         HDQ40bZqJ0+Sj1kB6kiRVZZffZTHX9kqqIzXLk+EePykAoJxcP/w2VT/TOJkE4LOVdp5
         HtwozfxR8FA2hDDD84e4VG9pJ9ByiEjcrnNuFYkpszuk6BxhKV5kjswP/hhdiI8LABHu
         Fs5aUE+yVnsEAWBjeyL7X3JgMeRBfFg63X58FhgkGMK3S86fOy7pY1qV9pqMobk65n4j
         farxSdDMBQe11jhSj4JatI9P2IOUuXj2GhJIoouArCUc7VvEbjIW1z5szDOAsefnrSgQ
         53NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062247; x=1780667047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9izQ8Rg6mHM9tIila18JcJ8uO9+KTod7pRo/axl+xc=;
        b=dDhb8ziDVVaopfkgkbz0hBhln6gLAGWjq6GFUMOo3Fu5J+lxM28NHy9KobL+U4cP6G
         5j1y/bwlhVTYZQwkNBIlfhoi7u9Q84vpV8YkKQXTe8j2cw8wDeskgpfu3Dgca5+G7QlD
         PBaIXIt6DtcrLVNzxRK1MtZkbgKvAmbbYmuLPHzhZUcXcyZu3n4pk4Iti3ifJWi+iTvH
         9YvXIPqZlyS3uozvxOddx59B7BmZGEnWPL6juEhK14xUOOvlN3yLKNm+QolHuMiXXTTg
         XtP/kBuJ6yzGbYgXvV9mz7yFzcI0PUx4F4tqZ+pDR09emF/qSlCOmt6MnvM0eGkBdfN6
         yb8Q==
X-Gm-Message-State: AOJu0YzVVpNifmZU0N5JtyMCxXLdh+6iXooiy8oeQlwvX61BWIg3lx9w
	5tilQOcdwQXEPR2wFA4CuDVwPdmeTI/hHET6d6K5260OMj/TpAaRUExErKUwTbMuFmLizmf3YUl
	KKqna+hOglQ==
X-Gm-Gg: Acq92OHYMMQEq0wbRIXc25Vvh7a2pkV3dj3ZalStlcb95TP5d/AyVBWXcDHuUhZH1iK
	4JMRQd3rZ+smWhgMeWKSd5+kJHWwBdf637PqniacpENhZcNlXxqKPd5RDNvd5ytESQUfab/dBuT
	h/ucuanq3p+JS1u5JgbR+0YAK4u5ydgtAlHzRDhMhKRFKMPTUOhd8pLo4pdQIgimIBbom8Zf+rf
	Eo4lXzBKTAlArsSk7XfusPvgYLN+czPidL4k9cZKUzTn54fTvNeT3CK8VZGiOYCAcwhNcQTrxJb
	y6Cx2jaOBe9ByT67oK+xt9bombRn6lT7EB72T8M8qF2P7Y3gdz7PLTyjT4aC0ReCZo3/HXSUbPz
	4lH9BD8oDUAeTw9us2jqRRF+2tcpEUtEVJ9uIV4JmWl2isNsfxXa0/veNVHnrEgt9PPFdK2LShj
	SMjA8P6oLyCtokjVsx769cp0g0nFfireAgjhp7nKx4RRg=
X-Received: by 2002:a05:600c:34d6:b0:490:9dc3:3473 with SMTP id 5b1f17b1804b1-4909e24e5e7mr38984275e9.2.1780062247396;
        Fri, 29 May 2026 06:44:07 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0d4f4esm20254635e9.1.2026.05.29.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:44:06 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 16/16] RDMA/mlx5: Use UMEM attribute for QP doorbell record
Date: Fri, 29 May 2026 15:43:12 +0200
Message-ID: <20260529134312.2836341-17-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529134312.2836341-1-jiri@resnulli.us>
References: <20260529134312.2836341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21516-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,resnulli-us.20251104.gappssmtp.com:server fail,resnulli.us:server fail,nvidia.com:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 54F92603182
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


