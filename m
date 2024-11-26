Return-Path: <linux-rdma+bounces-6101-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302199D9211
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 08:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB98166440
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB788191F9E;
	Tue, 26 Nov 2024 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JwwIdgoo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D10178372
	for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2024 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604646; cv=none; b=KE3qTUoHrnavhbLSpeb/rKm6KO+oD+Ah9UTsiqLWLWTScxfPOtGj1q4UKwFkVG6X8jlEa80CfvCehEgojVtOnz2mg7wlKx2GOi3GTAEnygYNyLLqwmkGHGrUnpHIb6klXeddtuFoCx5P0IIsDmWxOw5UqpF3jvyB9/XOke8j9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604646; c=relaxed/simple;
	bh=orxAFCES0UBkgYN5APIi4bfYUpNJCV488lsriHjAFIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwT5tJH/TMtjkU/Nw5YHDNQ1utQCSEQqCGOaTYF7SwwCAMd1r2rgxNK62AXWY0gK6kWtITUXEqtCvDwkPTQN6ei+jP2kEXgGhp1eauaVE9RozFoxxrbdr5mkndsPOeCL+8KwKO42Dpa8XlMDyFJ5tVmtqJATnE2fcTwHVMZVogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JwwIdgoo; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732604635; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ItKLWpu2Wh4RWwl5gfdsUro9T/IEbMJNOgJdziKoxEk=;
	b=JwwIdgooeH4qSB/xqZy4L27UEZHTgTEffmvRgc6wJNS6psUSMpgwmEjDEzeGKaf18kJljtMCvNL3B0381Bh5vTUtd9dEbtEU+opUXXzzcm+DXTJ7lUXQW4wk9zxTDwI/4LZbEr+Wq3gG/sHI413RbjvtbCZ0GYG1/PjnH5GprQY=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WKHOCDu_1732604634 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 15:03:55 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 3/8] RDMA/erdma: Add the erdma_query_pkey() interface
Date: Tue, 26 Nov 2024 14:59:09 +0800
Message-ID: <20241126070351.92787-4-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
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
index d72b85e8971d..fca5bf7519dd 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -485,6 +485,7 @@ static const struct ib_device_ops erdma_device_ops_rocev2 = {
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


