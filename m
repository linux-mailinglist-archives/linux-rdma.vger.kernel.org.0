Return-Path: <linux-rdma+bounces-16425-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNBXOAa3gWmEJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16425-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74192D664F
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B5AB302B21C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6933F395DA0;
	Tue,  3 Feb 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YFUn+BpY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EED396B87
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108615; cv=none; b=pbwpTLla3EVqZs55jUAKwIxOfI0vhnb0Yyq9JFaW5V8j+FI/fjDFPbWIvlsEbh2XveU93idEml1O9O5CGoQC9H915+DGGUaEAA+3a2AJoT8CXWModgri2W2d72utpvupo258iZZHkwCJNqvnaVcRpGWQCsj1BP3xJ4Yr69h3rIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108615; c=relaxed/simple;
	bh=4w7bivvq09xqleH0F508z1D7BgsI6qATZMUc60ifCmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltOBWMDdJr8i2VeaQknjZ/mjyfoej/2AayGuoH1iu3ALW0iofMeUbaAnRA0rGLU1tCST/vvQ5ogi+4N4ndmS07pPrffEXUv+eTKpxm1b9NRFL60es3j5lPznutdq666/k/glVKCO//+ZW6SsA9jHnu6OPb8SwLveffSfDaxLbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YFUn+BpY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4359a16a400so4586306f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108611; x=1770713411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1nAS9Q+qVXnO09DWSHSO5BpDuL+wsHDVz1IjX7Dl3o=;
        b=YFUn+BpY2q51pIutNnxhMMYR1G4I1Y1bMtC3Mz0VqCmT2K5cmiDo3rAyRjXVAHFTIw
         em1nVwnWdS//JHm2EzHo+Hy9mnakK2Zs2P/YUlTrcYM9VliXlAy/tkxmudz2mabhB8l8
         LRCt8YGukHCJLSgpatQZ94OGHwCbyfr6TARUmlOfSjLqQn5xSKumzWD44UIKByv7uh+m
         MBNDArZQldaOHDt6ZhEJTquVqC1/xOUB/YYD6yPZ5gXNgFyjaWhbZz7VC4zMxsurmZqi
         j3PQVg0w1srednKOY6jCrz955MA6KkKqaSYLE+bTApXHUx7kJpqlpMjVxv4JRreVI/ys
         VZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108611; x=1770713411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1nAS9Q+qVXnO09DWSHSO5BpDuL+wsHDVz1IjX7Dl3o=;
        b=oN5u+q7+jDnlPk2sHTlaLzb0HIdhTAvsMHbZJ5fxydIXrvBHtWPg5cISHA74f5Lhna
         npOiZG5OJ0WECZgeB7hB1h4K0wlVH1VU5X4V4QsiudhvPF0jJLRNW8EkOKHhlPJyR9Sy
         qocnB3iaxMQVHMIsRRJ52reneQNULJUX40BvGj6u+76YY2d0YlaGYi0tilT5z2keh0KV
         QNLtSw5foLjWcmnEbrYa563ZDQRCkoNiamUwWvLOgs03JG7c63sSBukyFwXl348rbikR
         fS1KvUVdG2JI/XhggOGCzPLZLsulbFb38b0twj5lBSQo4ad1MML1NQE2GFJHROUwh8rd
         MhCw==
X-Gm-Message-State: AOJu0YxTGWGfexe+OQXlSw9pmuOXNuf3LKwK3JEPqmbSok2G3XiUs+ut
	Ln/1OdiBNsOnM6aIN7sj5m/AXvcsiFk4kCS0b1vAnYh9ucpma87c4wRDH73mTfrmMTeV4GKIwlI
	oya+4
X-Gm-Gg: AZuq6aKjIMShYZ/+0qz0WXiHMuJkniR8v8IeV7YIlRkEefsVvk9lzNVFR/1/WrtP4fN
	GqZE9tgQDPuLqjY1NK4MkCdudalCxZeQQPGjvWtkDRrq0fmqIrCdnyKhEbJfGfpfyjNgTZQZdmJ
	DN0k8Rjd/YjOuAwuuCGk4+HarUyF2OuRSjl+GAeWTurs2zf2JEzAIemnooIeAOBHwfbi7mdc0xJ
	pjJ/TkiL+4QTJ7m+gVlvIABU9CmaIrs4gtf6JDApLGbXUQZ3FeWuu2586Ngi49ekIrsDWQIKaUS
	vjcy9aaPJBLa6vYYM8ylY+M7UZs9kkHaJR6svacw6dAcR1EsBHtC1gmnWXcPvmOltQoDq92WnNA
	RX13tHg3eYZlt8idG5BRO7xEnItBz2IpeQWs6lZbsMz12jxDP1FCv0QQjNRHvGOL+QA+FaTRU66
	uLow==
X-Received: by 2002:a5d:63c1:0:b0:431:38f:8bc4 with SMTP id ffacd0b85a97d-435f3ad853bmr16249312f8f.61.1770108611174;
        Tue, 03 Feb 2026 00:50:11 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353ac2sm53001735f8f.38.2026.02.03.00.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:10 -0800 (PST)
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
Subject: [PATCH rdma-next 05/10] RDMA/core: Add support for QP buffer umem in QP creation
Date: Tue,  3 Feb 2026 09:49:57 +0100
Message-ID: <20260203085003.71184-6-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-16425-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 74192D664F
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Extend the QP creation path to support passing SQ and RQ buffers
via user memory (umem), either through virtual address or dmabuf
file descriptor.

Add new uverbs attributes for QP creation:
- SQ/RQ buffer virtual address
- SQ/RQ buffer length
- SQ/RQ buffer dmabuf file descriptor
- SQ/RQ buffer offset (for dmabuf)

The VA and FD modes are mutually exclusive for each buffer.

Introduce ib_create_qp_user_umem() function that extends
ib_create_qp_user() with sq_umem and rq_umem parameters. The
existing ib_create_qp_user() becomes a wrapper that passes NULL
for umem pointers, maintaining backward compatibility with all
existing callers.

Add create_qp_umem device op for drivers to implement umem-based
QP creation. When umem buffers are provided, the core calls
create_qp_umem instead of create_qp, allowing drivers to use
pre-pinned memory for QP buffers.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: I08b1542a15fe6b89755ab7199b461050a45a9160
---
 drivers/infiniband/core/core_priv.h           |  7 ++
 drivers/infiniband/core/device.c              |  1 +
 drivers/infiniband/core/uverbs_std_types_qp.c | 63 +++++++++++++++++-
 drivers/infiniband/core/verbs.c               | 65 +++++++++++++++----
 include/rdma/ib_verbs.h                       |  4 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  8 +++
 6 files changed, 132 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 05102769a918..553326c4eca9 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -320,6 +320,13 @@ struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
 				struct ib_qp_init_attr *attr,
 				struct ib_udata *udata,
 				struct ib_uqp_object *uobj, const char *caller);
+struct ib_qp *ib_create_qp_user_umem(struct ib_device *dev, struct ib_pd *pd,
+				     struct ib_qp_init_attr *attr,
+				     struct ib_umem *sq_umem,
+				     struct ib_umem *rq_umem,
+				     struct ib_udata *udata,
+				     struct ib_uqp_object *uobj,
+				     const char *caller);
 
 void ib_qp_usecnt_inc(struct ib_qp *qp);
 void ib_qp_usecnt_dec(struct ib_qp *qp);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 4e09f6e0995e..a9ae03f1e936 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2704,6 +2704,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_cq_umem);
 	SET_DEVICE_OP(dev_ops, create_flow);
 	SET_DEVICE_OP(dev_ops, create_qp);
+	SET_DEVICE_OP(dev_ops, create_qp_umem);
 	SET_DEVICE_OP(dev_ops, create_rwq_ind_table);
 	SET_DEVICE_OP(dev_ops, create_srq);
 	SET_DEVICE_OP(dev_ops, create_user_ah);
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index be0730e8509e..f1e2cfb27aa5 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -96,6 +96,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	struct ib_xrcd *xrcd = NULL;
 	struct ib_uobject *xrcd_uobj = NULL;
 	struct ib_device *device;
+	struct ib_umem *sq_umem, *rq_umem;
 	u64 user_handle;
 	int ret;
 
@@ -248,12 +249,39 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	set_caps(&attr, &cap, true);
 	mutex_init(&obj->mcast_lock);
 
-	qp = ib_create_qp_user(device, pd, &attr, &attrs->driver_udata, obj,
-			       KBUILD_MODNAME);
+	/* Get SQ buffer umem (from VA or dmabuf FD) */
+	ret = uverbs_get_buffer_umem(device, attrs,
+				     UVERBS_ATTR_CREATE_QP_SQ_BUFFER_VA,
+				     UVERBS_ATTR_CREATE_QP_SQ_BUFFER_LENGTH,
+				     UVERBS_ATTR_CREATE_QP_SQ_BUFFER_FD,
+				     UVERBS_ATTR_CREATE_QP_SQ_BUFFER_OFFSET,
+				     device->ops.create_qp_umem,
+				     IB_ACCESS_LOCAL_WRITE, &sq_umem);
+	if (ret)
+		goto err_put;
+
+	/* Get RQ buffer umem (from VA or dmabuf FD) */
+	ret = uverbs_get_buffer_umem(device, attrs,
+				     UVERBS_ATTR_CREATE_QP_RQ_BUFFER_VA,
+				     UVERBS_ATTR_CREATE_QP_RQ_BUFFER_LENGTH,
+				     UVERBS_ATTR_CREATE_QP_RQ_BUFFER_FD,
+				     UVERBS_ATTR_CREATE_QP_RQ_BUFFER_OFFSET,
+				     device->ops.create_qp_umem,
+				     IB_ACCESS_LOCAL_WRITE, &rq_umem);
+	if (ret)
+		goto err_release_sq_umem;
+
+	qp = ib_create_qp_user_umem(device, pd, &attr, sq_umem, rq_umem,
+				    &attrs->driver_udata, obj, KBUILD_MODNAME);
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
-		goto err_put;
+		goto err_release_rq_umem;
 	}
+
+	/* Driver took a reference, release ours */
+	ib_umem_release(rq_umem);
+	ib_umem_release(sq_umem);
+
 	ib_qp_usecnt_inc(qp);
 
 	if (attr.qp_type == IB_QPT_XRC_TGT) {
@@ -277,6 +305,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 			     sizeof(qp->qp_num));
 
 	return ret;
+
+err_release_rq_umem:
+	ib_umem_release(rq_umem);
+err_release_sq_umem:
+	ib_umem_release(sq_umem);
 err_put:
 	if (obj->uevent.event_file)
 		uverbs_uobject_put(&obj->uevent.event_file->uobj);
@@ -340,6 +373,30 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
 			   UVERBS_ATTR_TYPE(u32),
 			   UA_MANDATORY),
+	/* SQ buffer attributes - use VA or FD, not both */
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SQ_BUFFER_VA,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SQ_BUFFER_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_QP_SQ_BUFFER_FD,
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SQ_BUFFER_OFFSET,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	/* RQ buffer attributes - use VA or FD, not both */
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_BUFFER_VA,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_BUFFER_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_QP_RQ_BUFFER_FD,
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_BUFFER_OFFSET,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_QP_DESTROY)(
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 8b56b6b62352..97073b50fc30 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1264,6 +1264,7 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 
 static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 			       struct ib_qp_init_attr *attr,
+			       struct ib_umem *sq_umem, struct ib_umem *rq_umem,
 			       struct ib_udata *udata,
 			       struct ib_uqp_object *uobj, const char *caller)
 {
@@ -1271,8 +1272,13 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	struct ib_qp *qp;
 	int ret;
 
-	if (!dev->ops.create_qp)
-		return ERR_PTR(-EOPNOTSUPP);
+	if (sq_umem || rq_umem) {
+		if (!dev->ops.create_qp_umem)
+			return ERR_PTR(-EOPNOTSUPP);
+	} else {
+		if (!dev->ops.create_qp)
+			return ERR_PTR(-EOPNOTSUPP);
+	}
 
 	qp = rdma_zalloc_drv_obj_numa(dev, ib_qp);
 	if (!qp)
@@ -1302,7 +1308,12 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
 	WARN_ONCE(!udata && !caller, "Missing kernel QP owner");
 	rdma_restrack_set_name(&qp->res, udata ? NULL : caller);
-	ret = dev->ops.create_qp(qp, attr, udata);
+
+	if (sq_umem || rq_umem)
+		ret = dev->ops.create_qp_umem(qp, attr, sq_umem, rq_umem,
+					      udata);
+	else
+		ret = dev->ops.create_qp(qp, attr, udata);
 	if (ret)
 		goto err_create;
 
@@ -1330,28 +1341,33 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 }
 
 /**
- * ib_create_qp_user - Creates a QP associated with the specified protection
- *   domain.
+ * ib_create_qp_user_umem - Creates a QP with optional umem buffers
  * @dev: IB device
  * @pd: The protection domain associated with the QP.
  * @attr: A list of initial attributes required to create the
  *   QP.  If QP creation succeeds, then the attributes are updated to
  *   the actual capabilities of the created QP.
+ * @sq_umem: SQ buffer umem (optional)
+ * @rq_umem: RQ buffer umem (optional)
  * @udata: User data
- * @uobj: uverbs obect
+ * @uobj: uverbs object
  * @caller: caller's build-time module name
  */
-struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
-				struct ib_qp_init_attr *attr,
-				struct ib_udata *udata,
-				struct ib_uqp_object *uobj, const char *caller)
+struct ib_qp *ib_create_qp_user_umem(struct ib_device *dev, struct ib_pd *pd,
+				     struct ib_qp_init_attr *attr,
+				     struct ib_umem *sq_umem,
+				     struct ib_umem *rq_umem,
+				     struct ib_udata *udata,
+				     struct ib_uqp_object *uobj,
+				     const char *caller)
 {
 	struct ib_qp *qp, *xrc_qp;
 
 	if (attr->qp_type == IB_QPT_XRC_TGT)
-		qp = create_qp(dev, pd, attr, NULL, NULL, caller);
+		qp = create_qp(dev, pd, attr, sq_umem, rq_umem, NULL, NULL, caller);
 	else
-		qp = create_qp(dev, pd, attr, udata, uobj, NULL);
+		qp = create_qp(dev, pd, attr, sq_umem, rq_umem, udata, uobj,
+			       NULL);
 	if (attr->qp_type != IB_QPT_XRC_TGT || IS_ERR(qp))
 		return qp;
 
@@ -1364,6 +1380,28 @@ struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
 	xrc_qp->uobject = uobj;
 	return xrc_qp;
 }
+EXPORT_SYMBOL(ib_create_qp_user_umem);
+
+/**
+ * ib_create_qp_user - Creates a QP associated with the specified protection
+ *   domain.
+ * @dev: IB device
+ * @pd: The protection domain associated with the QP.
+ * @attr: A list of initial attributes required to create the
+ *   QP.  If QP creation succeeds, then the attributes are updated to
+ *   the actual capabilities of the created QP.
+ * @udata: User data
+ * @uobj: uverbs obect
+ * @caller: caller's build-time module name
+ */
+struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
+				struct ib_qp_init_attr *attr,
+				struct ib_udata *udata,
+				struct ib_uqp_object *uobj, const char *caller)
+{
+	return ib_create_qp_user_umem(dev, pd, attr, NULL, NULL, udata, uobj,
+				      caller);
+}
 EXPORT_SYMBOL(ib_create_qp_user);
 
 void ib_qp_usecnt_inc(struct ib_qp *qp)
@@ -1413,7 +1451,8 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
 	if (qp_init_attr->cap.max_rdma_ctxs)
 		rdma_rw_init_qp(device, qp_init_attr);
 
-	qp = create_qp(device, pd, qp_init_attr, NULL, NULL, caller);
+	qp = create_qp(device, pd, qp_init_attr, NULL, NULL, NULL, NULL,
+		       caller);
 	if (IS_ERR(qp))
 		return qp;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8bd020da7745..831426d27078 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2521,6 +2521,10 @@ struct ib_device_ops {
 	int (*destroy_srq)(struct ib_srq *srq, struct ib_udata *udata);
 	int (*create_qp)(struct ib_qp *qp, struct ib_qp_init_attr *qp_init_attr,
 			 struct ib_udata *udata);
+	int (*create_qp_umem)(struct ib_qp *qp,
+			      struct ib_qp_init_attr *qp_init_attr,
+			      struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			      struct ib_udata *udata);
 	int (*modify_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 			 int qp_attr_mask, struct ib_udata *udata);
 	int (*query_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 35da4026f452..0d6b4151512d 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -157,6 +157,14 @@ enum uverbs_attrs_create_qp_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_QP_EVENT_FD,
 	UVERBS_ATTR_CREATE_QP_RESP_CAP,
 	UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
+	UVERBS_ATTR_CREATE_QP_SQ_BUFFER_VA,
+	UVERBS_ATTR_CREATE_QP_SQ_BUFFER_LENGTH,
+	UVERBS_ATTR_CREATE_QP_SQ_BUFFER_FD,
+	UVERBS_ATTR_CREATE_QP_SQ_BUFFER_OFFSET,
+	UVERBS_ATTR_CREATE_QP_RQ_BUFFER_VA,
+	UVERBS_ATTR_CREATE_QP_RQ_BUFFER_LENGTH,
+	UVERBS_ATTR_CREATE_QP_RQ_BUFFER_FD,
+	UVERBS_ATTR_CREATE_QP_RQ_BUFFER_OFFSET,
 };
 
 enum uverbs_attrs_destroy_qp_cmd_attr_ids {
-- 
2.51.1


