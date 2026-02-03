Return-Path: <linux-rdma+bounces-16429-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEgyGv62gWmEJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16429-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3174D663A
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F4FF300C56D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC06D39525B;
	Tue,  3 Feb 2026 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XQoLRA6K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8859396B81
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108619; cv=none; b=LQF2kia1BuQ5JXHEzGtKSCCe2W5k683gnlfQIg+uPs9K3jxErUjhgYENBuw/JKrrZ6qhubyKOOJZuC53udYaTFVeA+vL27OMSgpFRQqrWX0hgr/MgGkJu+RuslD5XhUTmveLZdz4Ry/B15taUfs7/bqBRu+Lv8hN60fJwDdMcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108619; c=relaxed/simple;
	bh=SfIcxcTBBi074HJP3G9ABWfB8tzS+iaOieilLKCd2sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QY0+B04OO2k/Ij7OBievzPvBTTQcil1z9kt6JSD1+/3PWLxuHO8AgrHEOpqf0J8bT0jC2c6bEc6YLMlGqiNUcgCz66bq2UzeKQtYe72i1U/gjZ7KdcNovuTn+NiBoLvzDn8LPdtNvnkRsnmGiCGcgL5ID470oE7iG/bruufoU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XQoLRA6K; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-481188b7760so35306625e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108616; x=1770713416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKviU2MwGxenqc9fW0Uek87sygf9yWcEsdN5503tbRA=;
        b=XQoLRA6KhjKXCQSgjtwTwiNPblq+bXnASrfzTdpl84X4/MndAQx/Sn5yRaNApVG9us
         H6wVSRHz+Pf+Zq6Nf9aMnYlyw2exyz20baG7zrpLoPGJzhBI1OgVqUkcnZQPaVIoaGnW
         x5CtvSwjdTZc3qF0QQou6cHqXaW4fEUJgsKWeeH+mGFpAzMplgR5BmI+sgA08OWDK8U/
         XS/6Scgys0F6CHw3Hlc2VI9KJjnjh1CUgOs+MkhqAUX9r21UH1gnNkodWR6cZy01giod
         D48LGfcm7cElZU73oMjl/MidNxNzYuojhJpL4LNBQ62VgOzCMQA/2pSLiOR9fLjEpwmM
         bGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108616; x=1770713416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OKviU2MwGxenqc9fW0Uek87sygf9yWcEsdN5503tbRA=;
        b=VNU2SQ6ch1puZcxsBUoxh11VreG4gMM2S2Gzd76RoK/3GTHoopJX8h+0DZEciUaquA
         20lnKMb5VowV5MYOJEC/R+NtfIBdHb//EXuPxroeGEGv16uZPcve1gsahvAJgn8y0A4r
         GO+rW/kHibotp2g/ErCW5KNX5ImMCGAWWchiQTfCnAOQSv2qb4CWWAOHuxVSTBkLDZ5C
         +V+0wZJSZVyGvgV/chafdmiFfCONMWs/v9EUSaviVttnQdvFXdMxiXte9DLxoEoj3zjF
         0qo3+HpyNLVGMPm9+ZcSBwBwzg5r+dotcL8kmnoA73aUkv3vxK9qyXGeeqvk4DFjm58C
         OsWA==
X-Gm-Message-State: AOJu0Yy4WYOj/Gf/03aTy5aW1irZDi6o98yp3JCgenVYzSphg3bhPpvL
	xlwrou2rBKXfaO2wh3CADtWLPQ6x8w7von172zifu6FoVVMt1Sx18SzWjjRnlup/zY7DOQj3yKr
	5ysvH
X-Gm-Gg: AZuq6aL9JGk1MfuqqUpTocddBE3BsZOw18hi/GkJMK+wvy4l3yFuy88MS8hMYR9UXte
	NU6BZsRvPT6cN6F0/Ac7aQdLfAm0Jnp1itYkFOBcPjIo/hHAR0sWPCI9ZVO6Wdg60VreATN8lMv
	b30SlCkfBUD5KT6sJdV/o2hb0VDeXYfIVxaVvGLUO4quaMrW4lO2fgbgFI6nwRCJibWH7YA4w9r
	njSjifAD4WoCW5zX1ED4HyW9noJH1O/SBPWErR+asZxYkzqRSJbv0TU7H085lu5OWG/hQjcj4ly
	wUCKiCUe7B9ERVsYS6Mge6jIfS+sZzb+FhGA6BnmieQoTL5caNeeTFAu3G8qk5kGPwlsu4U/hhB
	KN0ApWfgA8kNh5jL4N68SsqB6i3Gb/z4omDkqNkVUyYEQGS27ZTcnR9KKmbkUXBf5jWJsqfiw61
	tnHg==
X-Received: by 2002:a05:600c:a00d:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-482db465e44mr183380805e9.14.1770108615981;
        Tue, 03 Feb 2026 00:50:15 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4360ef9e804sm8375532f8f.41.2026.02.03.00.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:15 -0800 (PST)
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
Subject: [PATCH rdma-next 09/10] RDMA/uverbs: Add doorbell record umem support to QP creation
Date: Tue,  3 Feb 2026 09:50:01 +0100
Message-ID: <20260203085003.71184-10-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16429-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: A3174D663A
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Extend the QP creation path to support passing doorbell record (DBR)
memory via umem for both SQ and RQ. This allows userspace to provide
pre-pinned doorbell record buffers.

The DBR umem can be provided via:
- Virtual address (VA) mode: UVERBS_ATTR_CREATE_QP_{SQ,RQ}_DBR_VA + LENGTH
- DMA-buf file descriptor mode: UVERBS_ATTR_CREATE_QP_{SQ,RQ}_DBR_FD +
  OFFSET + LENGTH

These modes are mutually exclusive, similar to the QP buffer umem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: Id2836b852d114a93c9b5b45c09bcef386386a193
---
 drivers/infiniband/core/core_priv.h           |  2 +
 drivers/infiniband/core/uverbs_std_types_qp.c | 55 ++++++++++++++++++-
 drivers/infiniband/core/verbs.c               | 25 ++++++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  1 +
 drivers/infiniband/hw/mlx5/qp.c               |  1 +
 include/rdma/ib_verbs.h                       |  2 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  8 +++
 7 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 553326c4eca9..baca8cc120aa 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -324,6 +324,8 @@ struct ib_qp *ib_create_qp_user_umem(struct ib_device *dev, struct ib_pd *pd,
 				     struct ib_qp_init_attr *attr,
 				     struct ib_umem *sq_umem,
 				     struct ib_umem *rq_umem,
+				     struct ib_umem *sq_dbr_umem,
+				     struct ib_umem *rq_dbr_umem,
 				     struct ib_udata *udata,
 				     struct ib_uqp_object *uobj,
 				     const char *caller);
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index f1e2cfb27aa5..3c8817f286a2 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -96,7 +96,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	struct ib_xrcd *xrcd = NULL;
 	struct ib_uobject *xrcd_uobj = NULL;
 	struct ib_device *device;
-	struct ib_umem *sq_umem, *rq_umem;
+	struct ib_umem *sq_umem, *rq_umem, *sq_dbr_umem, *rq_dbr_umem;
 	u64 user_handle;
 	int ret;
 
@@ -271,14 +271,37 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	if (ret)
 		goto err_release_sq_umem;
 
+	/* Get SQ DBR umem (from VA or dmabuf FD) */
+	ret = uverbs_get_buffer_umem(device, attrs,
+				 UVERBS_ATTR_CREATE_QP_SQ_DBR_VA,
+				 UVERBS_ATTR_CREATE_QP_SQ_DBR_LENGTH,
+				 UVERBS_ATTR_CREATE_QP_SQ_DBR_FD,
+				 UVERBS_ATTR_CREATE_QP_SQ_DBR_OFFSET,
+				 device->ops.create_qp_umem, 0, &sq_dbr_umem);
+	if (ret)
+		goto err_release_rq_umem;
+
+	/* Get RQ DBR umem (from VA or dmabuf FD) */
+	ret = uverbs_get_buffer_umem(device, attrs,
+				 UVERBS_ATTR_CREATE_QP_RQ_DBR_VA,
+				 UVERBS_ATTR_CREATE_QP_RQ_DBR_LENGTH,
+				 UVERBS_ATTR_CREATE_QP_RQ_DBR_FD,
+				 UVERBS_ATTR_CREATE_QP_RQ_DBR_OFFSET,
+				 device->ops.create_qp_umem, 0, &rq_dbr_umem);
+	if (ret)
+		goto err_release_sq_dbr_umem;
+
 	qp = ib_create_qp_user_umem(device, pd, &attr, sq_umem, rq_umem,
+				    sq_dbr_umem, rq_dbr_umem,
 				    &attrs->driver_udata, obj, KBUILD_MODNAME);
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
-		goto err_release_rq_umem;
+		goto err_release_rq_dbr_umem;
 	}
 
 	/* Driver took a reference, release ours */
+	ib_umem_release(rq_dbr_umem);
+	ib_umem_release(sq_dbr_umem);
 	ib_umem_release(rq_umem);
 	ib_umem_release(sq_umem);
 
@@ -306,6 +329,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 
 	return ret;
 
+err_release_rq_dbr_umem:
+	ib_umem_release(rq_dbr_umem);
+err_release_sq_dbr_umem:
+	ib_umem_release(sq_dbr_umem);
 err_release_rq_umem:
 	ib_umem_release(rq_umem);
 err_release_sq_umem:
@@ -397,6 +424,30 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_BUFFER_OFFSET,
 			   UVERBS_ATTR_TYPE(u64),
 			   UA_OPTIONAL),
+	/* SQ DBR attributes - use VA or FD, not both */
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SQ_DBR_VA,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SQ_DBR_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_QP_SQ_DBR_FD,
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SQ_DBR_OFFSET,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	/* RQ DBR attributes - use VA or FD, not both */
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_DBR_VA,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_DBR_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_QP_RQ_DBR_FD,
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_DBR_OFFSET,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_QP_DESTROY)(
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 97073b50fc30..db0ad750a78a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1265,6 +1265,8 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 			       struct ib_qp_init_attr *attr,
 			       struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			       struct ib_umem *sq_dbr_umem,
+			       struct ib_umem *rq_dbr_umem,
 			       struct ib_udata *udata,
 			       struct ib_uqp_object *uobj, const char *caller)
 {
@@ -1272,7 +1274,7 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	struct ib_qp *qp;
 	int ret;
 
-	if (sq_umem || rq_umem) {
+	if (sq_umem || rq_umem || sq_dbr_umem || rq_dbr_umem) {
 		if (!dev->ops.create_qp_umem)
 			return ERR_PTR(-EOPNOTSUPP);
 	} else {
@@ -1309,9 +1311,9 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	WARN_ONCE(!udata && !caller, "Missing kernel QP owner");
 	rdma_restrack_set_name(&qp->res, udata ? NULL : caller);
 
-	if (sq_umem || rq_umem)
+	if (sq_umem || rq_umem || sq_dbr_umem || rq_dbr_umem)
 		ret = dev->ops.create_qp_umem(qp, attr, sq_umem, rq_umem,
-					      udata);
+					      sq_dbr_umem, rq_dbr_umem, udata);
 	else
 		ret = dev->ops.create_qp(qp, attr, udata);
 	if (ret)
@@ -1349,6 +1351,8 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
  *   the actual capabilities of the created QP.
  * @sq_umem: SQ buffer umem (optional)
  * @rq_umem: RQ buffer umem (optional)
+ * @sq_dbr_umem: SQ doorbell record umem (optional)
+ * @rq_dbr_umem: RQ doorbell record umem (optional)
  * @udata: User data
  * @uobj: uverbs object
  * @caller: caller's build-time module name
@@ -1357,6 +1361,8 @@ struct ib_qp *ib_create_qp_user_umem(struct ib_device *dev, struct ib_pd *pd,
 				     struct ib_qp_init_attr *attr,
 				     struct ib_umem *sq_umem,
 				     struct ib_umem *rq_umem,
+				     struct ib_umem *sq_dbr_umem,
+				     struct ib_umem *rq_dbr_umem,
 				     struct ib_udata *udata,
 				     struct ib_uqp_object *uobj,
 				     const char *caller)
@@ -1364,10 +1370,11 @@ struct ib_qp *ib_create_qp_user_umem(struct ib_device *dev, struct ib_pd *pd,
 	struct ib_qp *qp, *xrc_qp;
 
 	if (attr->qp_type == IB_QPT_XRC_TGT)
-		qp = create_qp(dev, pd, attr, sq_umem, rq_umem, NULL, NULL, caller);
+		qp = create_qp(dev, pd, attr, NULL, NULL, NULL, NULL, NULL,
+			       NULL, caller);
 	else
-		qp = create_qp(dev, pd, attr, sq_umem, rq_umem, udata, uobj,
-			       NULL);
+		qp = create_qp(dev, pd, attr, sq_umem, rq_umem, sq_dbr_umem,
+			       rq_dbr_umem, udata, uobj, NULL);
 	if (attr->qp_type != IB_QPT_XRC_TGT || IS_ERR(qp))
 		return qp;
 
@@ -1399,8 +1406,8 @@ struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
 				struct ib_udata *udata,
 				struct ib_uqp_object *uobj, const char *caller)
 {
-	return ib_create_qp_user_umem(dev, pd, attr, NULL, NULL, udata, uobj,
-				      caller);
+	return ib_create_qp_user_umem(dev, pd, attr, NULL, NULL, NULL, NULL,
+				      udata, uobj, caller);
 }
 EXPORT_SYMBOL(ib_create_qp_user);
 
@@ -1452,7 +1459,7 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
 		rdma_rw_init_qp(device, qp_init_attr);
 
 	qp = create_qp(device, pd, qp_init_attr, NULL, NULL, NULL, NULL,
-		       caller);
+		       NULL, NULL, caller);
 	if (IS_ERR(qp))
 		return qp;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index c1e60f5c1754..f654d0fde3f1 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1358,6 +1358,7 @@ int mlx5_ib_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 		      struct ib_udata *udata);
 int mlx5_ib_create_qp_umem(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct ib_umem *sq_dbr_umem, struct ib_umem *rq_dbr_umem,
 			   struct ib_udata *udata);
 int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		      int attr_mask, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 4b926b6f2461..79d30e68b4cb 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3399,6 +3399,7 @@ int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 
 int mlx5_ib_create_qp_umem(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct ib_umem *sq_dbr_umem, struct ib_umem *rq_dbr_umem,
 			   struct ib_udata *udata)
 {
 	return __mlx5_ib_create_qp(ibqp, attr, udata, sq_umem, rq_umem);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index eeafa5358b49..36d59e9d45b5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2524,6 +2524,8 @@ struct ib_device_ops {
 	int (*create_qp_umem)(struct ib_qp *qp,
 			      struct ib_qp_init_attr *qp_init_attr,
 			      struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			      struct ib_umem *sq_dbr_umem,
+			      struct ib_umem *rq_dbr_umem,
 			      struct ib_udata *udata);
 	int (*modify_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 			 int qp_attr_mask, struct ib_udata *udata);
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index ef33b96511a8..5e9be458e990 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -169,6 +169,14 @@ enum uverbs_attrs_create_qp_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_QP_RQ_BUFFER_LENGTH,
 	UVERBS_ATTR_CREATE_QP_RQ_BUFFER_FD,
 	UVERBS_ATTR_CREATE_QP_RQ_BUFFER_OFFSET,
+	UVERBS_ATTR_CREATE_QP_SQ_DBR_VA,
+	UVERBS_ATTR_CREATE_QP_SQ_DBR_LENGTH,
+	UVERBS_ATTR_CREATE_QP_SQ_DBR_FD,
+	UVERBS_ATTR_CREATE_QP_SQ_DBR_OFFSET,
+	UVERBS_ATTR_CREATE_QP_RQ_DBR_VA,
+	UVERBS_ATTR_CREATE_QP_RQ_DBR_LENGTH,
+	UVERBS_ATTR_CREATE_QP_RQ_DBR_FD,
+	UVERBS_ATTR_CREATE_QP_RQ_DBR_OFFSET,
 };
 
 enum uverbs_attrs_destroy_qp_cmd_attr_ids {
-- 
2.51.1


