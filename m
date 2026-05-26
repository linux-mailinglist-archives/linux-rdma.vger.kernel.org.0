Return-Path: <linux-rdma+bounces-21319-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJzwGYWzFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21319-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:51:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D82125D7F70
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 889E3307BDAA
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5AD400E0C;
	Tue, 26 May 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="m56mZ/nt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E13FF891
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806573; cv=none; b=nhShdIZRSplmm3qF8RgbCFB+p1ejeV216iEXMvSPnLfaplzTW0UuPYPPSq1+zaQ4yZjpQ3vcgbDc/piWSifUlLocv/he3EvhV0IiATKIski9Uyw2GvLoiiHJgB7fUGs14MafVn81KqLAKq1xpD/XSROQSNcGP7MCswOYhCeMKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806573; c=relaxed/simple;
	bh=fevxdSZjCBZecK0kqCAr7ZVRl3x0wXcLq5MdSuVq8kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LL9LZB+c+Oa4QzW3FSnA+aNsU0ky7HhGwnzTFkdSrltSsWVMIEZPsrFHiM23qBGzXtZ2VkW0CukljUjpbMmXa5+cqDk4ZU9j3srSitIC8+GyvOxo9y7kZRwAX7tL2qVbYpwz926bkM8emS6xSE3+iA8RmmMXJsmcpOwRuEoaBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=m56mZ/nt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so34546925e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806570; x=1780411370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9izQ8Rg6mHM9tIila18JcJ8uO9+KTod7pRo/axl+xc=;
        b=m56mZ/ntl9HkakPlhX6LT+J3M1ax0IsGmydqYrwk5GcG/kqlW4lj88tKc6To2kf1PI
         PP67wx0+VwFlMgyYzhUeXzHPbisXcG2cjWoqov69Irmgy3ez6zM/G6qdcJ4aeTW1Axqy
         t3MvRwpbXImdyM5RWfbGSK7h2/YKXRUEulp1qKX4Y3fF4h9QsRKb2k2FvehV9Y/HQvSq
         PwxgSPYrqH1NOh+NCTGaGFz89wHDwqYtpilPCi9qNEtN8tL5OpWAEXlhJ3t6VuGAJTrh
         aDJdfKGwMOuYbEY7vElJjLOekwO/NW/ywIDCBWdoQf1gFyd5UmKWizZCC9QZc+D7O+wG
         /dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806570; x=1780411370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9izQ8Rg6mHM9tIila18JcJ8uO9+KTod7pRo/axl+xc=;
        b=EFIXJGb15ILZpRUbFzdLq/sACWMnmp8bXYYlmHrTQ5N0b5mLvZQa/2wP/RkVrQSJGx
         LWjhA+A/WtMvJ0WinKoo/zVw6Go6lGiRZNqGxo6lnJ8cgC3vZYd7Qb57oiThk9kpzcnw
         X3qkToWFM/mmIj5vZeU6tnJEwQrwSn4U39ZAKJBnHyMoPrE67jhBauNOjXpJU/eBqkZy
         lOTdpIZU2DhXL67RM7+qt/jc/xdorDKXzfC53kaSzbuRUp/cMiBlgH/tgXoubEzrmi7F
         5XxaoPCzQKkiY1+/ZolW2P3pFnDna8UWk0bIKsTWR4f/eyZVJr+RFwLPI5mN3m9+FP+X
         /KkA==
X-Gm-Message-State: AOJu0YwW3JKkRA5CA+OltC06c/1S29fjIU2RLpzxapygj5w0+Y2lcDnK
	mNmDYUfRZBTA4aIzGAONzfAyU1xCRyXSUhoOhAE8i8HiVxb+Byyj3dAt3JdXy7kH31a/TCbiYR/
	A3+2c+mdkow==
X-Gm-Gg: Acq92OFg5IketzyewXEwqKJGS9Iokd0aHkYLWlsMXV/UQ3TSKJXT2B5pguPyb0l3Vxv
	O4JTGAl4P78+qc78OZwl0yMFuDNjbBShdz5XCoQjFJHeVVjNzSzI6d3zUDlLeSRVooAQWGJ5ek2
	ji/WIP/iNTqQXD9soozNTrrq5hUelVm347LiGgrgxwVtNSA07PlA23ZzwF1A2FP8GOGvmNYHaJX
	w7sLRHs7EOH1NPG/MOVGJuE5JmPJl2SR934802xxtCYAQchjOXiA0WupMGVTbWzsMAKAmXmXSg6
	kJ3q6wmgjfCIg/ihhBJV0vrBqzluQ3S5RBTqIIifCCR5oQ6jMLVHE4TmUzk/czIJvsbmUivgN9b
	bEABzHyMl1tD3HXDdMGdxoCOWDCUoau1Wk8VhE1nwiq80JqZdrDDMka5kCj47G589XVMcqcY8vu
	mnxZd7sfzdaN+UG+GvK2WUPre00fb/FwQE
X-Received: by 2002:a05:600c:4ecc:b0:489:2005:b36e with SMTP id 5b1f17b1804b1-490428c9564mr307715555e9.19.1779806570138;
        Tue, 26 May 2026 07:42:50 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6bc5479sm38438111f8f.0.2026.05.26.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:49 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 15/15] RDMA/mlx5: Use UMEM attribute for QP doorbell record
Date: Tue, 26 May 2026 16:41:52 +0200
Message-ID: <20260526144152.1422310-16-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526144152.1422310-1-jiri@resnulli.us>
References: <20260526144152.1422310-1-jiri@resnulli.us>
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
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21319-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D82125D7F70
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


