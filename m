Return-Path: <linux-rdma+bounces-16427-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UENoDgu3gWmEJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16427-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE498D6666
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BDBA306F944
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E96396B69;
	Tue,  3 Feb 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="G4Jyc4Ti"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D63395D8C
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108617; cv=none; b=NxgAjvu5u8K1SQC21xUtb022hNFmMiita/yzZowLPRu92YkBBjo26BlE0sSnR5pFahrDMoTSGmYh77zWlStTNnUH2dtVAYpDueMEM8/dPh/sAR8Wvzk5yTCnw6V6+SsNVB+9b50bs4an3tgxCxHLRrPMDbNSooUEWTXotxftOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108617; c=relaxed/simple;
	bh=g9v89xtpDO2LI7+u44KAPjmDsrDFdAallNld9XUu0Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsQT6MvvVQaZOKaVOSPhv+OD5eyBfPEg0miLMbkkbChCparYH4qrtaRSOB0urFWpsgsauD7YCY2Tu7kiOj+sMHBlHpUkC8m7thXdHK/QF5llhIczWUXT1MTQzmsS+pH42oobVPOgXBfTJ7AC30EKrTBGyIeJj+5qdXK2O/g6n20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=G4Jyc4Ti; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee0291921so50782115e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108614; x=1770713414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a//Yl4lV6Xmjj5qCC9OHdSRgOS+jaL6hjeb+ymkLGdY=;
        b=G4Jyc4TikuLA20hRKd/80bX6NrpxYevvrnf5NREIz9ka0RvfrWhbZVVCW9JInFDoAo
         viLQEEZ8dvxgyFNK7QX831hiGJS8CjNv75qgHcPmwNFQFBh+42qJk29ItDKyJDwDxwe2
         MI6BvG9+2mKfMIX7KbvUcBy7vKBoyUDNlY3X0e1st+H3CotQ0/ZUu+cPuituO3ZdGPQ2
         ja3p0kkNPlnfHlc1/sYgzeH0tYA3RT0OAS9DDS/8dwh4TYAcBE4Pbxl5DKGDc3KDz5k9
         XJeGA64l/poAFJMz04uq00ZpU8wJSYUl/iK4MslLqmdmPN30qkZLtgkQEIAakoYGWXuI
         fdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108614; x=1770713414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a//Yl4lV6Xmjj5qCC9OHdSRgOS+jaL6hjeb+ymkLGdY=;
        b=mOuOc/2GioNI54LkOKfjRs+U5E1wroKlj3plps08g3kOmBIX7f9xZo97ByLEs461oe
         91iSmVAD4ahoEJQCQNv0U89hgXbdlh2Y37CfUDMhfA70jrg2RERM72Z/R0q3IEF7Apru
         a/j3pyyNR2RSukW/PViJPSHVuL9QXRg+XrKW04Of5ac1+bKyWW+LvaJMYyCMk/+MT5Po
         RR9dWvSL1BL8zxgM+/GEd4CNvrgvEifvH8EiijC3lCNEQuhfiLSHDve7hx3F5kNSOqnC
         c0YCaL8onIjZRWcYDcJmC+1zqzVLgC8oLI/0rfORkQew6wpEXrm2u+5Jg5Q4Or1SevR4
         fNbQ==
X-Gm-Message-State: AOJu0YyW7/o7kBJ+u74Rnrcv/7bIJOHV6jTtSIs7HWBMiqAYLdFDsmGa
	3hpn885Z14U3rsIcUfXAPXLNUuG0lJhZFCcMKDi2Cj9YKi9+RPPlxLq/5vxB3gC5oKlwwT8VK3p
	aTq3H
X-Gm-Gg: AZuq6aIHAptOxB3PP6/vrCbjudiPIokpkEFI6HzU1m+2/WQShYgDfOk38aNCgngT5nS
	ytoyF0mlYdCPAJnZcjurcozWOJunhlZAEVkYT7cNLnu3VC+Vei4zSqzuDER/G8+Ns8XISqDPAbe
	0tku8aDi9KGKqYpr6fhpTe2ipSE13xQkcRRS4QjdnIoak1OF+aR+WjMCjxGJBs+jz7Ysy6L4jM3
	Pjym6cvoWOum94q5aZfZUW8jJtsPk377MlBXyq8QpEY6ZRJoFrmlaFMfl05vT/DumW+IM5g9LBf
	+VEhnVVcORpRUHIO9ueGyni+pmUC27rP0ziCvzB9RyxCBuT0vYP+0wKF5dNiszWW3ZuFUYVWmnz
	N3PC4kO41PCZmXhBuZkBZMVKgkzAFZ2l71Uy4nkafQI2i8lQCH3W9edZWUyIQuL0toF9JBkbYFG
	g6Tg==
X-Received: by 2002:a05:600c:1385:b0:47e:dc64:f1c6 with SMTP id 5b1f17b1804b1-482db493eb4mr216924405e9.6.1770108613608;
        Tue, 03 Feb 2026 00:50:13 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd0f043sm132733665e9.7.2026.02.03.00.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:13 -0800 (PST)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 07/10] RDMA/uverbs: Add doorbell record umem support to CQ creation
Date: Tue,  3 Feb 2026 09:49:59 +0100
Message-ID: <20260203085003.71184-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260203085003.71184-1-jiri@resnulli.us>
References: <20260203085003.71184-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16427-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli.us:mid]
X-Rspamd-Queue-Id: EE498D6666
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Extend the user CQ creation path to support passing doorbell record
(DBR) memory via umem. This allows userspace to provide pre-pinned
doorbell record buffers, which is useful for confidential computing
scenarios where doorbell records need to be in decrypted memory
accessible by the device.

The DBR umem can be provided via:
- Virtual address (VA) mode: UVERBS_ATTR_CREATE_CQ_DBR_VA + LENGTH
- DMA-buf file descriptor mode: UVERBS_ATTR_CREATE_CQ_DBR_FD + OFFSET +
  LENGTH

These modes are mutually exclusive, similar to the CQ buffer umem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: Id0d92c0c98133dcf938664a37444535d4e0a9ea6
---
 drivers/infiniband/core/uverbs_std_types_cq.c | 38 +++++++++++++++----
 drivers/infiniband/hw/efa/efa.h               |  3 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  5 ++-
 drivers/infiniband/hw/mlx5/cq.c               |  3 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  3 +-
 include/rdma/ib_verbs.h                       |  1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  4 ++
 7 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 64c43dbd96ba..95ee0fea09b0 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -68,7 +68,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	struct ib_device *ib_dev = attrs->context->device;
 	struct ib_cq_init_attr attr = {};
 	struct ib_uobject *ev_file_uobj;
-	struct ib_umem *umem;
+	struct ib_umem *umem, *dbr_umem;
 	struct ib_cq *cq;
 	u64 user_handle;
 	int ret;
@@ -123,17 +123,25 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	if (ret)
 		goto err_event_file;
 
+	ret = uverbs_get_buffer_umem(ib_dev, attrs,
+				     UVERBS_ATTR_CREATE_CQ_DBR_VA,
+				     UVERBS_ATTR_CREATE_CQ_DBR_LENGTH,
+				     UVERBS_ATTR_CREATE_CQ_DBR_FD,
+				     UVERBS_ATTR_CREATE_CQ_DBR_OFFSET,
+				     ib_dev->ops.create_cq_umem, 0, &dbr_umem);
+	if (ret)
+		goto err_umem;
+
 	/* If no external buffer provided, require create_cq op */
-	if (!umem && !ib_dev->ops.create_cq) {
+	if (!umem && !dbr_umem && !ib_dev->ops.create_cq) {
 		ret = -EINVAL;
-		goto err_event_file;
+		goto err_dbr_umem;
 	}
 
 	cq = rdma_zalloc_drv_obj(ib_dev, ib_cq);
 	if (!cq) {
 		ret = -ENOMEM;
-		ib_umem_release(umem);
-		goto err_event_file;
+		goto err_dbr_umem;
 	}
 
 	cq->device        = ib_dev;
@@ -146,12 +154,14 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
 
-	ret = umem ? ib_dev->ops.create_cq_umem(cq, &attr, umem, attrs) :
+	ret = (umem || dbr_umem) ?
+		ib_dev->ops.create_cq_umem(cq, &attr, umem, dbr_umem, attrs) :
 		ib_dev->ops.create_cq(cq, &attr, attrs);
 	if (ret)
 		goto err_free;
 
 	/* Driver took a reference, release ours */
+	ib_umem_release(dbr_umem);
 	ib_umem_release(umem);
 
 	obj->uevent.uobject.object = cq;
@@ -164,9 +174,12 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	return ret;
 
 err_free:
-	ib_umem_release(umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
+err_dbr_umem:
+	ib_umem_release(dbr_umem);
+err_umem:
+	ib_umem_release(umem);
 err_event_file:
 	if (obj->uevent.event_file)
 		uverbs_uobject_put(&obj->uevent.event_file->uobj);
@@ -214,6 +227,17 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
 			   UVERBS_ATTR_TYPE(u64),
 			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_DBR_VA,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_DBR_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_CQ_DBR_FD,
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_DBR_OFFSET,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_CQ_DESTROY)(
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 96f9c3bc98b2..e4be0335af51 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -164,7 +164,8 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		  struct uverbs_attr_bundle *attrs);
 int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		       struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
+		       struct ib_umem *umem, struct ib_umem *dbr_umem,
+		       struct uverbs_attr_bundle *attrs);
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
 			 struct ib_dmah *dmah,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index aca48825cd71..165a2e1e5b72 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1132,7 +1132,8 @@ static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
 }
 
 int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		       struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
+		       struct ib_umem *umem, struct ib_umem *dbr_umem,
+		       struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(
@@ -1314,7 +1315,7 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		  struct uverbs_attr_bundle *attrs)
 {
-	return efa_create_cq_umem(ibcq, attr, NULL, attrs);
+	return efa_create_cq_umem(ibcq, attr, NULL, NULL, attrs);
 }
 
 static int umem_to_page_list(struct efa_dev *dev,
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 2558a52c31c0..35c51a91e8c4 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1077,7 +1077,8 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 }
 
 int mlx5_ib_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
+			   struct ib_umem *umem, struct ib_umem *dbr_umem,
+			   struct uverbs_attr_bundle *attrs)
 {
 	return __mlx5_ib_create_cq(ibcq, attr, umem, attrs);
 }
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 755d7c17dbfd..05f764185e92 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1375,7 +1375,8 @@ int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void *buffer,
 int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
 int mlx5_ib_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
+			   struct ib_umem *umem, struct ib_umem *dbr_umem,
+			   struct uverbs_attr_bundle *attrs);
 int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx5_ib_pre_destroy_cq(struct ib_cq *cq);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 831426d27078..eeafa5358b49 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2535,6 +2535,7 @@ struct ib_device_ops {
 	int (*create_cq_umem)(struct ib_cq *cq,
 			      const struct ib_cq_init_attr *attr,
 			      struct ib_umem *umem,
+			      struct ib_umem *dbr_umem,
 			      struct uverbs_attr_bundle *attrs);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 0d6b4151512d..ef33b96511a8 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -116,6 +116,10 @@ enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH,
 	UVERBS_ATTR_CREATE_CQ_BUFFER_FD,
 	UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
+	UVERBS_ATTR_CREATE_CQ_DBR_VA,
+	UVERBS_ATTR_CREATE_CQ_DBR_LENGTH,
+	UVERBS_ATTR_CREATE_CQ_DBR_FD,
+	UVERBS_ATTR_CREATE_CQ_DBR_OFFSET,
 };
 
 enum uverbs_attrs_destroy_cq_cmd_attr_ids {
-- 
2.51.1


