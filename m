Return-Path: <linux-rdma+bounces-6406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7869EC1F6
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A76D188B540
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D01FBCBC;
	Wed, 11 Dec 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CMSz46yA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B6544384
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882986; cv=none; b=flHpo4Ckaa8AmqiU3cwsUPASuipIpZ3FHNtcgWnAARwmtjvT0SxVHHu8ReTebXR7UnGwf0W8qVJcq9+7TioPm3jl9ZnXF9rOuDELAOe62g9ZuZRw17D5+ATyIzbO0j6K1Yqa2t8ZBGfuhvMI6SwPcFk8VoBX/bOAkngSsou75a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882986; c=relaxed/simple;
	bh=ynn5NhfsqabqOggZV2nGHrl4gTUC9kyBxmwOYwqL9+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIKfAtvWDx4CH/GSIbLZjQUu8dp73ogg8KyNuI+ZPa0SURigGUmxxeXe6Q2X5Hstmh3ieUaMGiTI+pbUpmSF3+f3qe/4UKt45010h0njFqTyDs/x0zDk5nqQwKl12pp4NtsRxZlIvuuwxFQbciglASJzNqlGOI7WWnZZyiRG+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CMSz46yA; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733882975; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N2OVsrgs+J3bn6XTv6n+GcTEWou0qjV1szQwZNmtkqA=;
	b=CMSz46yAtWzabD4aQoTho9pqPqKWUFs/Bk90cWTCsNl8DOvZxWv3aGaF7/jPq6KhCAR0fuU9M/aBNijY+MjHS6ZP0yqbH9dt2Zv3JEV7LkxSmV60jpoAcbCE2JJpPQHbtWJ36kZ4hKvWIA60Aias8an1Aw1OBXh8kVfkSchwnoo=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WLGVL1l_1733882974 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:09:35 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next v2 3/8] RDMA/erdma: Add the erdma_query_pkey() interface
Date: Wed, 11 Dec 2024 10:09:03 +0800
Message-ID: <20241211020930.68833-4-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
References: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The erdma_query_pkey() interface queries the PKey at the specified
index. Currently, erdma supports only one partition and returns the
default PKey for each query. Besides, the correct length of the PKey
table can be obtained by calling the erdma_query_port() and
erdma_get_port_immutable() interfaces.

Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    |  2 ++
 drivers/infiniband/hw/erdma/erdma_main.c  |  1 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 14 ++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  1 +
 4 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 7e03c5f97501..f7f9dcac3ab0 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -23,6 +23,8 @@
 
 /* RoCEv2 related */
 #define ERDMA_ROCEV2_GID_SIZE 16
+#define ERDMA_MAX_PKEYS 1
+#define ERDMA_DEFAULT_PKEY 0xFFFF
 
 /* erdma device protocol type */
 enum erdma_proto_type {
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 77440324b7e7..b9d0ad77436a 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -481,6 +481,7 @@ static const struct ib_device_ops erdma_device_ops_rocev2 = {
 	.get_link_layer = erdma_get_link_layer,
 	.add_gid = erdma_add_gid,
 	.del_gid = erdma_del_gid,
+	.query_pkey = erdma_query_pkey,
 };
 
 static const struct ib_device_ops erdma_device_ops_iwarp = {
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 9944eed584ec..03ea52bb233e 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -336,6 +336,9 @@ int erdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 	attr->max_fast_reg_page_list_len = ERDMA_MAX_FRMR_PA;
 	attr->page_size_cap = ERDMA_PAGE_SIZE_SUPPORT;
 
+	if (erdma_device_rocev2(dev))
+		attr->max_pkeys = ERDMA_MAX_PKEYS;
+
 	if (dev->attrs.cap_flags & ERDMA_DEV_CAP_FLAGS_ATOMIC)
 		attr->atomic_cap = IB_ATOMIC_GLOB;
 
@@ -372,6 +375,7 @@ int erdma_query_port(struct ib_device *ibdev, u32 port,
 	} else {
 		attr->gid_tbl_len = dev->attrs.max_gid;
 		attr->ip_gids = true;
+		attr->pkey_tbl_len = ERDMA_MAX_PKEYS;
 	}
 
 	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
@@ -411,6 +415,7 @@ int erdma_get_port_immutable(struct ib_device *ibdev, u32 port,
 			RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
 		port_immutable->max_mad_size = IB_MGMT_MAD_SIZE;
 		port_immutable->gid_tbl_len = dev->attrs.max_gid;
+		port_immutable->pkey_tbl_len = ERDMA_MAX_PKEYS;
 	}
 
 	return 0;
@@ -1903,3 +1908,12 @@ int erdma_del_gid(const struct ib_gid_attr *attr, void **context)
 	return erdma_set_gid(to_edev(attr->device), ERDMA_SET_GID_OP_DEL,
 			     attr->index, NULL);
 }
+
+int erdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey)
+{
+	if (index >= ERDMA_MAX_PKEYS)
+		return -EINVAL;
+
+	*pkey = ERDMA_DEFAULT_PKEY;
+	return 0;
+}
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 23cfeaf79eaa..1ae6ba56f597 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -394,5 +394,6 @@ enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev,
 					  u32 port_num);
 int erdma_add_gid(const struct ib_gid_attr *attr, void **context);
 int erdma_del_gid(const struct ib_gid_attr *attr, void **context);
+int erdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey);
 
 #endif
-- 
2.43.5


