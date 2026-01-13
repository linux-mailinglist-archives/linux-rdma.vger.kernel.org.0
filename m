Return-Path: <linux-rdma+bounces-15527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AEDD1A92E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67B6F3003862
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2CC34EEE9;
	Tue, 13 Jan 2026 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WxFsDy1T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060322E03EC
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324689; cv=none; b=gSTN/ov3D1m+8qDGDAjuTdq9/JfBbkv20OlLdwfQ8Jzkc71KlGmVPJAoHC14NBHW1D39K6kUuAQowUIqCJCGMtPM0pLGuRJRBN9BfktddMM/VN6Pq3H8CSa7Cf6icszShT54GaMlufNcj74WmOWW4XC0Qe5qQbiUPiF8+951Ggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324689; c=relaxed/simple;
	bh=V++GwT9XuuP2qE6n3bYEs43zVyWd5MZzEU4lpkJyXxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtW6955kJwoARFx9g+VBrGrPvbrgtAs4DZp9XdwLOHmAivhP6IDJZ9MfJZcXnVIyDyIleE3syhsCvAxvtbECvNnjewFxrq2QrZ2nRcZq7UYF9tqZAjTvz6jggPwSGOSnGks5WoHHOqzz9MUZcPXHm3RqS/ffGDHsQ7S66U8DXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WxFsDy1T; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-79028cb7f92so68283587b3.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324687; x=1768929487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiNV4lNfwFKvhmuy1yTQ6SyqgPmMFkgkcONitzvbSAM=;
        b=uXlzEbpBZunPgBarGhHmg82OlfjpfLoAPfQq8dy+41z58/u6XzE2eKjogkCoaAMUnc
         xTvbglV2P93JwLpqYGqEzjloLuvoEe44PF2Jbic2Ca6RWDu5OAiUCO3DhuHRm031xYtv
         WfyVJg93HgkQmQhtv8a2pjO0Lyw8dRtkqHX2yohh3KrkbcGVk3feJzDfjPCIGx+jOJ+i
         hGyQG5h0YebMpeZI+XAb3l2kAngbhFolhoWuTYro8JTcH4a9uxh0sInP2M+oHvRKlXK/
         WE3mu16yhDfLmZuSEOpUdDy1OPSHjHrEZSsJbrnY/RoDo/uq4v7OSQYEI+XEQkzLkN2T
         iC5A==
X-Gm-Message-State: AOJu0YxtRjJOaEzFCHiatcfry+QA/GBURnRJkwYQF/EzkU+KxwTykb/B
	fYZ1pIn6Yfs5ntdmNNMNZxJGqwT3JCamxUPxTUqZIOZJseIND+b/vWPctv2E0p+YVRdqG60p5p9
	MvlDoUNqLGRz0Uvi6qjnRqk2srxp/OHER4CF/Smdc7h21utIXF3v+f649wdTIVigStdk5Kx6Wdj
	ZNsdcKXZiplC2VAo+8t5OFPX5qosGk7UZBuh+i/4uMS2QdOQaJBGsgUfxfFBkowLzd7ulPX/zZR
	AylW5XdMZEL8fiE/0GIvpV+sMkV
X-Gm-Gg: AY/fxX6gTaquDLzMM4h0JGq1YD53FjWxchUNldowlF8cbTF6SAgXHJDxSo+6SVlsyNd
	A/hMPUQUi7J+gYdWrtapPNer+X/+oysFzTswPi1QHQQZ9RxIVWYSFKLiKWg4M1OgLf+Jsd+1+9V
	Nhyff+74sAuA1jsANj2Hfjq98DIvGbOnDFsWtzDhg2OJBmGvjCkIEA5cOBY+xDkktlJu+VOXq33
	qKusr6ZQ+SF+hQZN8/Hx2QmANqe5pkJIKD3//qUj5LdQowt6h31PK2ITnzzcugcZmK4U7qlgKah
	VZxAPxShP9OSt+K7+J2lLKKAmmKyl3FifYgtOqEkUXD89O3v5KvUrv1T/SZKIlWwc9HF1P+CRzf
	RIAcj+Q0i/zOBvgF4TI60d6/2heuX62TwpH4+kjHHhoOr0tzrTAL2gGGSX2u9udNh5SLz0k1ZGn
	sUVTQXjpuBM64W/GnxYXOvo7KF1J7X4V4iEBN8iWB8Sr4oePpvaDm0zc3xARY=
X-Google-Smtp-Source: AGHT+IEoEn8cmwCdcQ9RsTMxB9qLFGwhPJakl/iJ2KLfUvcv8N5/ue+CzZz/hD7XlEWHx+vDftjd9ihtTWv3
X-Received: by 2002:a05:690c:e0a:b0:786:6dcc:9786 with SMTP id 00721157ae682-790b5847b75mr169977987b3.62.1768324686739;
        Tue, 13 Jan 2026 09:18:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa6a9e09sm16573877b3.20.2026.01.13.09.18.06
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:18:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so80385375ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768324685; x=1768929485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiNV4lNfwFKvhmuy1yTQ6SyqgPmMFkgkcONitzvbSAM=;
        b=WxFsDy1TAunbJ39XygUwobTL0G1LR98UYIdhLdq4avcOixTNazgbAZNzDMYCL65LEy
         YhY0+AUZ8IJz3h5lHe2Da4S4PZiLhNDmG8Pf90vnF0nfQjqdeHgnrSxQPbybvObXwcFb
         leozLzu/RvV904RqTiAxRX/JtyNAi1ngQR06Q=
X-Received: by 2002:a17:902:c409:b0:2a0:cb8d:2edc with SMTP id d9443c01a7336-2a3ee441672mr210068575ad.13.1768324684441;
        Tue, 13 Jan 2026 09:18:04 -0800 (PST)
X-Received: by 2002:a17:902:c409:b0:2a0:cb8d:2edc with SMTP id d9443c01a7336-2a3ee441672mr210068275ad.13.1768324683962;
        Tue, 13 Jan 2026 09:18:03 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a2a4sm19357855ad.13.2026.01.13.09.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:18:03 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
Date: Tue, 13 Jan 2026 22:39:55 +0530
Message-ID: <20260113170956.103779-4-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
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

- BNXT_RE_METHOD_GET_DEFAULT_DBR:
  Return the default doorbell page index and doorbell page address
  associated with the ucontext.

Co-developed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   3 +
 drivers/infiniband/hw/bnxt_re/dv.c        | 137 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   8 ++
 drivers/infiniband/hw/bnxt_re/main.c      |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 +++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   4 +
 include/uapi/rdma/bnxt_re-abi.h           |  29 +++++
 7 files changed, 226 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3a7ce4729fcf..ca1327ea7e57 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -160,6 +160,7 @@ struct bnxt_re_nq_record {
 
 #define MAX_CQ_HASH_BITS		(16)
 #define MAX_SRQ_HASH_BITS		(16)
+#define MAX_DPI_HASH_BITS		(16)
 
 static inline bool bnxt_re_chip_gen_p7(u16 chip_num)
 {
@@ -217,6 +218,8 @@ struct bnxt_re_dev {
 	struct delayed_work dbq_pacing_work;
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
+	DECLARE_HASHTABLE(dpi_hash, MAX_DPI_HASH_BITS);
+	struct mutex dpi_hash_lock;	/* protect dpi hash table */
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index 5655c6176af4..0e9b0ddf8194 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -331,9 +331,146 @@ DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_GET_TOGGLE_MEM,
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
+	obj->entry = bnxt_re_mmap_entry_insert(uctx, dpi->umdbr,
+					       BNXT_RE_MMAP_UC_DB,
+					       &mmap_offset);
+	if (!obj->entry) {
+		ret = -ENOMEM;
+		goto free_dpi;
+	}
+
+	obj->rdev = rdev;
+	uobj->object = obj;
+	mutex_lock(&rdev->dpi_hash_lock);
+	hash_add_rcu(rdev->dpi_hash, &obj->hash_entry, dpi->dpi);
+	mutex_unlock(&rdev->dpi_hash_lock);
+	uverbs_finalize_uobj_create(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
+
+	dbr.umdbr = dpi->umdbr;
+	dbr.dpi = dpi->dpi;
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR_ATTR,
+					    &dbr, sizeof(dbr));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
+			     &mmap_offset, sizeof(mmap_offset));
+	if (ret)
+		return ret;
+	return 0;
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
+	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
+	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
+	mutex_lock(&rdev->dpi_hash_lock);
+	hash_del_rcu(&obj->hash_entry);
+	kfree_rcu(obj, rcu);
+	mutex_unlock(&rdev->dpi_hash_lock);
+	return 0;
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_DEFAULT_DBR)(struct uverbs_attr_bundle *attrs)
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
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_DEFAULT_DBR_ATTR,
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
+								   umdbr),
+								   UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_ALLOC_DBR_OFFSET,
+						UVERBS_ATTR_TYPE(u64),
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
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_FREE));
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_DEFAULT_DBR_ATTR,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_db_region,
+								   umdbr),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_DEFAULT_DBR,
+			      &UVERBS_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR));
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DBR),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DEFAULT_DBR),
 	{}
 };
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index a11f56730a31..c6daebd49a3b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -164,6 +164,14 @@ struct bnxt_re_user_mmap_entry {
 	u8 mmap_flag;
 };
 
+struct bnxt_re_alloc_dbr_obj {
+	struct bnxt_re_dev *rdev;
+	struct bnxt_qplib_dpi dpi;
+	struct bnxt_re_user_mmap_entry *entry;
+	struct hlist_node hash_entry;
+	struct rcu_head rcu;
+};
+
 struct bnxt_re_flow {
 	struct ib_flow		ib_flow;
 	struct bnxt_re_dev	*rdev;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73003ad25ee8..ec45134d3eb2 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2338,6 +2338,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 			bnxt_re_vf_res_config(rdev);
 	}
 	hash_init(rdev->cq_hash);
+	hash_init(rdev->dpi_hash);
+	mutex_init(&rdev->dpi_hash_lock);
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
index faa9d62b3b30..51f8614a7c4f 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -162,6 +162,8 @@ enum bnxt_re_objects {
 	BNXT_RE_OBJECT_ALLOC_PAGE = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_OBJECT_NOTIFY_DRV,
 	BNXT_RE_OBJECT_GET_TOGGLE_MEM,
+	BNXT_RE_OBJECT_DBR,
+	BNXT_RE_OBJECT_DEFAULT_DBR,
 };
 
 enum bnxt_re_alloc_page_type {
@@ -215,4 +217,31 @@ enum bnxt_re_toggle_mem_methods {
 	BNXT_RE_METHOD_GET_TOGGLE_MEM = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
 };
+
+struct bnxt_re_dv_db_region {
+	__u32 dpi;
+	__u32 reserved;
+	__aligned_u64 umdbr;
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
+enum bnxt_re_obj_default_dbr_attrs {
+	BNXT_RE_DV_DEFAULT_DBR_ATTR = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_obj_dpi_methods {
+	BNXT_RE_METHOD_DBR_ALLOC = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_METHOD_DBR_FREE,
+	BNXT_RE_METHOD_GET_DEFAULT_DBR,
+};
+
 #endif /* __BNXT_RE_UVERBS_ABI_H__*/
-- 
2.51.2.636.ga99f379adf


