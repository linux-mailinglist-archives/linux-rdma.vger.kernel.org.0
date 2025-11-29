Return-Path: <linux-rdma+bounces-14827-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A6BC94567
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 18:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEB83AC1FA
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0123C506;
	Sat, 29 Nov 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z2ICRhiS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F242397AA
	for <linux-rdma@vger.kernel.org>; Sat, 29 Nov 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435736; cv=none; b=aGQFa5e/DuV4FILD+zHmoyQVQzXwWvVFopiRjSs6UULcg+9zeGkMk1AODAxKSl/S+W5miEZXnUC2bIQS5MKpIJUijcDSgklJ/6aYeOF4YwQUZOx1povs8w5w9j1cPWiQB/0UVqBztxBBbHImKo6CVLDQeFIaM5hzUQWRlq/0VBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435736; c=relaxed/simple;
	bh=/l1of2iOgAmkxUtGr0zH1Em/YEDHT1z8V7ceWVKcFAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0I6pC2E8xmOwTnX+ZK+P9ehd196Pyn85uQ2Qg6xm275JZ4HZcegeHxY1dRrVsPlMqfCwF4rjP/GIsr/Prb1M4TUE9IH9WK918qlyyZoZAp614eilfKtGqMe/bAmYGoYlG7UfJGe9TT0+DO3jqbXV81bpFyvSE0Tdh964gGsxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z2ICRhiS; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-640d4f2f13dso2484982d50.1
        for <linux-rdma@vger.kernel.org>; Sat, 29 Nov 2025 09:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435733; x=1765040533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVWcoFvVno5u3A+GYTSJAmrwOPF1MsSo0I1G0gAolkc=;
        b=e1mJNzXJdkA1bLJ4KSpYelG5WfyEfbF6isOhbLuEI4juMGN37iNXqx5lkoJpP5tdGt
         0DGzz7M0cD/k1Yl/53PoBMWqxAgiitSuU+cQ3ukJH50rh2lAbL6VtnXVDd66UJTOpbxs
         dH4dTzYSwoIm/GO8ZmzPEpiV67jT1MlXtuiQ3UFnbz8fhW21pkTugDQBrtxyqnYz+JqX
         t4awZPaGx3yZ5TtwczAC7d5DHHMDJZIoC8Fsts332iGns6Bd89Sug/WErjyjiW4V2Qup
         JnEQUtUZ6OirUo7jrV5DfLxTKFSwpgprmc6r5jCh/eOPAmEq/wx6JsyNHylphIITV2C+
         VQUQ==
X-Gm-Message-State: AOJu0YzkKCU7G2iOWIZOYuWrmwULe9IDSviLl3m73H4rfuhOiXVmmLpR
	QbCgUtSEKRDQXAW3vXjgkNdqjJY1H0EafC2FUKUppm1G6VugZairH/Wu83E2+GpGmTFpzQqPX4R
	tInpa7AKSikCPS0kFwo4OeSTcuADJk3K1TKQQ4Xi9K5LNGjeO4JaeW32iA4RxDKDI2Cs8/sn4bP
	lWAqk5OsfVlgUMGBXRlL4clFEmC/8TzSAQ85hQvqDLwTCNe4akcVWbym8RgM5YhvSMKGlKreP3R
	Qe5jO+bnzXGRMBTlZ9qwqtlLm4a
X-Gm-Gg: ASbGnctjYmR06m8yfBKXYV9CjAiS8Z731WpmLIgMOp2V8M+xey9YYrWPT112kMdFqij
	yvfh24JePLuNibFIGv9tgAlSaHuT623wxmXL7oqvWcL+w20FtJV5ujm+vn8YXpJ8t4se468DJIt
	ejMccfR0nlB2v0y4mJuAdpo6WRJdeHtlSm474cfik5nbUVUumoWn0w8SowuP3aQ2mWDBIw960bI
	6YXFuAx1dOjN+OAoJ/o7TKmqb0xAnK8egvcMmsLgdhgUaH4sH25RHvWJXoctVPNEF2I4Iw8Mjjl
	vO/13TpT24yu/78nGvHq92s+x6kB7GCO757fZbvcwZ1M1zKinRlCTZtimuzlyb2LuAlvum6hn27
	uynx8Gs02bLaO8UR3NiDqNxsA5Q8iGX9hwyhPZntYm8CFGNtK+TJBopg8x+k/vZVwlf5vZ2MPAQ
	Ct3NUjPYOKs5W6cp0JSgy6Y1cXH4EIVjIMkrXQ40RX7WcPyiPwuNlVO9EdI7E=
X-Google-Smtp-Source: AGHT+IHbu1a2myEu6bbSddsVk6kFpxU5QPzW8w99SFhUlfkvwUZjoIVfFz1eyyKTTRIJxL15oGVXrXC0qXFA
X-Received: by 2002:a53:accc:0:20b0:640:fca9:bfd6 with SMTP id 956f58d0204a3-64329346f4cmr11204512d50.49.1764435733153;
        Sat, 29 Nov 2025 09:02:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6433c44c5b4sm698958d50.9.2025.11.29.09.02.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Nov 2025 09:02:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3438b1220bcso2697257a91.2
        for <linux-rdma@vger.kernel.org>; Sat, 29 Nov 2025 09:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764435732; x=1765040532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVWcoFvVno5u3A+GYTSJAmrwOPF1MsSo0I1G0gAolkc=;
        b=Z2ICRhiSusdnwZf1IPsCepu/bKjk+wJNdZ9lzbuyNsY/zCSa/ZlB1S4rIHosGLVDio
         skPHtl9B9dW8jVITSFnIaBp7QSn1RkKfeytaiRaNxncUPXvfq5H/aL5JTnFUeia2mj+S
         fIAFHOgYVU1i5BXiewigB9H69yY1RU3SlZ5PI=
X-Received: by 2002:a17:90b:54cd:b0:33b:a5d8:f198 with SMTP id 98e67ed59e1d1-3475ed6ada7mr17215577a91.25.1764435731139;
        Sat, 29 Nov 2025 09:02:11 -0800 (PST)
X-Received: by 2002:a17:90b:54cd:b0:33b:a5d8:f198 with SMTP id 98e67ed59e1d1-3475ed6ada7mr17215534a91.25.1764435730599;
        Sat, 29 Nov 2025 09:02:10 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b1cbdc0sm8099285a91.2.2025.11.29.09.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:02:09 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v5 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
Date: Sat, 29 Nov 2025 22:24:40 +0530
Message-ID: <20251129165441.75274-4-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
References: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The following Direct Verbs (DV) methods have been implemented in
this patch.

Doorbell Region Direct Verbs:
-----------------------------
- BNXT_RE_METHOD_DBR_ALLOC:
  This will allow the appliation to create extra doorbell regions
  and use the associated doorbell page index in DV_CREATE_QP and
  use the associated DB address while ringing the doorbell.

- BNXT_RE_METHOD_DBR_FREE:
  Free the allocated doorbell region.

- BNXT_RE_METHOD_DBR_QUERY:
  Return the default doorbell page index and doorbell page address
  associated with the ucontext.

Co-developed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   2 +
 drivers/infiniband/hw/bnxt_re/dv.c        | 132 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   9 ++
 drivers/infiniband/hw/bnxt_re/main.c      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 +++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   4 +
 include/uapi/rdma/bnxt_re-abi.h           |  30 +++++
 7 files changed, 221 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3a7ce4729fcf..ce717398b980 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -160,6 +160,7 @@ struct bnxt_re_nq_record {
 
 #define MAX_CQ_HASH_BITS		(16)
 #define MAX_SRQ_HASH_BITS		(16)
+#define MAX_DPI_HASH_BITS		(16)
 
 static inline bool bnxt_re_chip_gen_p7(u16 chip_num)
 {
@@ -217,6 +218,7 @@ struct bnxt_re_dev {
 	struct delayed_work dbq_pacing_work;
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
+	DECLARE_HASHTABLE(dpi_hash, MAX_DPI_HASH_BITS);
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index 5655c6176af4..991506394910 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -331,9 +331,141 @@ DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_GET_TOGGLE_MEM,
 			    &UVERBS_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM),
 			    &UVERBS_METHOD(BNXT_RE_METHOD_RELEASE_TOGGLE_MEM));
 
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_dv_db_region dbr = {};
+	struct bnxt_re_alloc_dbr_obj *obj;
+	struct bnxt_re_ucontext *uctx;
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_qplib_dpi *dpi;
+	struct bnxt_re_dev *rdev;
+	struct ib_uobject *uobj;
+	u64 mmap_offset;
+	int ret;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = uctx->rdev;
+	uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	dpi = &obj->dpi;
+	ret = bnxt_qplib_alloc_uc_dpi(&rdev->qplib_res, dpi);
+	if (ret)
+		goto free_mem;
+
+	obj->entry = bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_UC_DB,
+					       &mmap_offset);
+	if (!obj->entry) {
+		ret = -ENOMEM;
+		goto free_dpi;
+	}
+
+	obj->rdev = rdev;
+	dbr.umdbr = dpi->umdbr;
+	dbr.dpi = dpi->dpi;
+
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR_ATTR,
+					    &dbr, sizeof(dbr));
+	if (ret)
+		goto free_entry;
+
+	ret = uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
+			     &mmap_offset, sizeof(mmap_offset));
+	if (ret)
+		goto free_entry;
+
+	uobj->object = obj;
+	uverbs_finalize_uobj_create(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
+	hash_add(rdev->dpi_hash, &obj->hash_entry, dpi->dpi);
+	return 0;
+free_entry:
+	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
+free_dpi:
+	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, dpi);
+free_mem:
+	kfree(obj);
+	return ret;
+}
+
+static int bnxt_re_dv_dbr_cleanup(struct ib_uobject *uobject,
+				  enum rdma_remove_reason why,
+				  struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_alloc_dbr_obj *obj = uobject->object;
+	struct bnxt_re_dev *rdev = obj->rdev;
+
+	hash_del(&obj->hash_entry);
+	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
+	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
+	kfree(obj);
+	return 0;
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_QUERY)(struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_dv_db_region dpi = {};
+	struct bnxt_re_ucontext *uctx;
+	struct ib_ucontext *ib_uctx;
+	int ret;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	dpi.umdbr = uctx->dpi.umdbr;
+	dpi.dpi = uctx->dpi.dpi;
+
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_QUERY_DBR_ATTR,
+					    &dpi, sizeof(dpi));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_ALLOC,
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_ALLOC_DBR_HANDLE,
+					    BNXT_RE_OBJECT_DBR,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_ALLOC_DBR_ATTR,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_db_region,
+								   dbr),
+								   UA_MANDATORY),
+			    UVERBS_ATTR_PTR_IN(BNXT_RE_DV_ALLOC_DBR_OFFSET,
+					       UVERBS_ATTR_TYPE(u64),
+					       UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_QUERY,
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_QUERY_DBR_ATTR,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_db_region,
+								   dbr),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DBR_FREE,
+				    UVERBS_ATTR_IDR(BNXT_RE_DV_FREE_DBR_HANDLE,
+						    BNXT_RE_OBJECT_DBR,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_DBR,
+			    UVERBS_TYPE_ALLOC_IDR(bnxt_re_dv_dbr_cleanup),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_ALLOC),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_FREE),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_QUERY));
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DBR),
 	{}
 };
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index a11f56730a31..70891f8243b8 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -113,6 +113,7 @@ struct bnxt_re_cq {
 	int			resize_cqe;
 	void			*uctx_cq_page;
 	struct hlist_node	hash_entry;
+	struct bnxt_re_ucontext *uctx;
 };
 
 struct bnxt_re_mr {
@@ -164,6 +165,14 @@ struct bnxt_re_user_mmap_entry {
 	u8 mmap_flag;
 };
 
+struct bnxt_re_alloc_dbr_obj {
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_dv_db_region attr;
+	struct bnxt_qplib_dpi dpi;
+	struct bnxt_re_user_mmap_entry *entry;
+	struct hlist_node hash_entry;
+};
+
 struct bnxt_re_flow {
 	struct ib_flow		ib_flow;
 	struct bnxt_re_dev	*rdev;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73003ad25ee8..2f5f174ed5e7 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2338,6 +2338,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 			bnxt_re_vf_res_config(rdev);
 	}
 	hash_init(rdev->cq_hash);
+	hash_init(rdev->dpi_hash);
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
 		hash_init(rdev->srq_hash);
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 875d7b52c06a..30cc2d64a9ae 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -685,6 +685,49 @@ static int bnxt_qplib_alloc_pd_tbl(struct bnxt_qplib_res *res,
 }
 
 /* DPIs */
+int bnxt_qplib_alloc_uc_dpi(struct bnxt_qplib_res *res, struct bnxt_qplib_dpi *dpi)
+{
+	struct bnxt_qplib_dpi_tbl *dpit = &res->dpi_tbl;
+	struct bnxt_qplib_reg_desc *reg;
+	u32 bit_num;
+	int rc = 0;
+
+	reg = &dpit->wcreg;
+	mutex_lock(&res->dpi_tbl_lock);
+	bit_num = find_first_bit(dpit->tbl, dpit->max);
+	if (bit_num >= dpit->max) {
+		rc = -ENOMEM;
+		goto unlock;
+	}
+	/* Found unused DPI */
+	clear_bit(bit_num, dpit->tbl);
+	dpi->bit = bit_num;
+	dpi->dpi = bit_num + (reg->offset - dpit->ucreg.offset) / PAGE_SIZE;
+	dpi->umdbr = reg->bar_base + reg->offset + bit_num * PAGE_SIZE;
+unlock:
+	mutex_unlock(&res->dpi_tbl_lock);
+	return rc;
+}
+
+int bnxt_qplib_free_uc_dpi(struct bnxt_qplib_res *res, struct bnxt_qplib_dpi *dpi)
+{
+	struct bnxt_qplib_dpi_tbl *dpit = &res->dpi_tbl;
+	int rc = 0;
+
+	mutex_lock(&res->dpi_tbl_lock);
+	if (dpi->bit >= dpit->max) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	if (test_and_set_bit(dpi->bit, dpit->tbl))
+		rc = -EINVAL;
+	memset(dpi, 0, sizeof(*dpi));
+unlock:
+	mutex_unlock(&res->dpi_tbl_lock);
+	return rc;
+}
+
 int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_dpi *dpi,
 			 void *app, u8 type)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index ccdab938d707..3a8162ef4c33 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -436,6 +436,10 @@ int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 			 void *app, u8 type);
 int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
 			   struct bnxt_qplib_dpi *dpi);
+int bnxt_qplib_alloc_uc_dpi(struct bnxt_qplib_res *res,
+			    struct bnxt_qplib_dpi *dpi);
+int bnxt_qplib_free_uc_dpi(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_dpi *dpi);
 void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res);
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res);
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index faa9d62b3b30..6de43cc37540 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -162,6 +162,7 @@ enum bnxt_re_objects {
 	BNXT_RE_OBJECT_ALLOC_PAGE = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_OBJECT_NOTIFY_DRV,
 	BNXT_RE_OBJECT_GET_TOGGLE_MEM,
+	BNXT_RE_OBJECT_DBR,
 };
 
 enum bnxt_re_alloc_page_type {
@@ -215,4 +216,33 @@ enum bnxt_re_toggle_mem_methods {
 	BNXT_RE_METHOD_GET_TOGGLE_MEM = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
 };
+
+struct bnxt_re_dv_db_region {
+	__u32 dbr_handle;
+	__u32 dpi;
+	__u64 umdbr;
+	void *dbr;
+	__aligned_u64 comp_mask;
+};
+
+enum bnxt_re_obj_dbr_alloc_attrs {
+	BNXT_RE_DV_ALLOC_DBR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_DV_ALLOC_DBR_ATTR,
+	BNXT_RE_DV_ALLOC_DBR_OFFSET,
+};
+
+enum bnxt_re_obj_dbr_free_attrs {
+	BNXT_RE_DV_FREE_DBR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_obj_dbr_query_attrs {
+	BNXT_RE_DV_QUERY_DBR_ATTR = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_obj_dpi_methods {
+	BNXT_RE_METHOD_DBR_ALLOC = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_METHOD_DBR_FREE,
+	BNXT_RE_METHOD_DBR_QUERY,
+};
+
 #endif /* __BNXT_RE_UVERBS_ABI_H__*/
-- 
2.51.2.636.ga99f379adf


