Return-Path: <linux-rdma+bounces-16423-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BIxN/+2gWmEJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16423-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B3D6641
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61CC0306ABD9
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE15396B7F;
	Tue,  3 Feb 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NWyImh30"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA7395D8F
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108612; cv=none; b=m3LlCw72zv510lwVNbPMgMdq0KcRX8+EwW2veJVIBWHPx7JMK4Dk7KDNUQVcLwZw6HCrEb6m9RCoeeNhr+ZGM8y2RfOMyYQKqKam49tsTXWwr72vVOeU4/WhBo/tR33w4cGQ8yZEv0+DzeC8BWrwYRie3s4P4bHeycgcI/lYNRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108612; c=relaxed/simple;
	bh=81Fxx7kIXX//q9jhujXjDK3SS2zaZFy2vtCPO7AHA9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFIX3kV6hvH/mdHQc0iFFqm3vXUyOQ3P3+aVx0etJ+au40+IdjGlVvR1HLgG3cyCDnarZ82VLjB7BcZoeZAfQKRF6LkFpbKwFG7PkGyWPmGz9VUwkdhR6BuAsdCFr4HRQVPrYzO1Qioc0+So2H6f0fWZcGvHNzs10mkHtS3KKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NWyImh30; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-435903c4040so3548071f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108609; x=1770713409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8z5qh7HsYpAPsupSkp0GNPkqkbgFxPOEkIpLkpLbxk=;
        b=NWyImh30FcGzE9RzFW8lqavHKx3+c8UM2FSCnsfaqglSv4gFpUbW5Y7j+dvy3ZQG60
         0zXMBC9Ijkd50btpsbbxtO4j2JY17lyG0V4DO7FxM3T4Pvt30vqH1ngWoKt9mvJgaT5Q
         IRV63BVTyzJKZlz7CPFpRfi76GwzphNMw8jXUlo6E8epT+QNnw4uabpVY6ixBreiPDLv
         d7zVixhId5v2ULY8m4LABIB08ofDnnd3u3B8PKsDdAl+Hr/72SLSHu2tU6V2jvHae2Y6
         mxasgV2Xu6r8iyUYLLRn2mDqUw98AuhVq3L05jThPq7PqmjQKQmXzIlP2VJgVf6+RXDO
         tajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108609; x=1770713409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8z5qh7HsYpAPsupSkp0GNPkqkbgFxPOEkIpLkpLbxk=;
        b=HfH0ta7vvmzBMUqL48y+Wrj68Js3QvT0qWVzDAzf4/gS5n84FiRWTfbxWDckOZiL0M
         9wsoY4D1L1hFfOWE48GVwj6nu3ENqja5nB59eqIGEtBWLRyoTDfayfiX+AQkZbOmbTyu
         3uyZ7MHo49EmgpTM+ZvXbQzf8B20qJ7i23voLnBWWH1W41+MmXAiGZH3QQIzxYzaxp8a
         +hQGKmyQny9Vm9uwQmifml1QVRT6vtqOZGrjjtMC2SV2yPd9VmIiPsWf5Ob5KDcQLXnH
         cj72LZUurLZ6wKjy96nQArqWj2gALQJysxrPHdUVMpw37O8f/yiSet6cWQwUPShjLh5w
         lnIA==
X-Gm-Message-State: AOJu0Yy8FIogSZLc+QE58UpGLBoZ/NVfPxV2fasI/PLXfsTAnm6t3hMz
	4MzjIjUQDbnatFNEAP2k3WbmUbsMZnvbhWbCBjKH4kaLZBs0jLWtDdkkCe1M9bs5tfxspVdko8L
	lyIcs
X-Gm-Gg: AZuq6aIVBGfL01PlErjJTS+Oeu8cGNDi4UMQdpjss3VXpkHOoNLeSP63fNcT74L6D+0
	hEJM0ze59PQiFzxMwv0w2grekyqicb5qcrXYQN12G+bHjB7fvc2rOv9rLx0nvFXsjsVfvRdlHJp
	qHWokH+vQnsT9a8V6YDOEXl/Gk5D/k7cLcv9ydfKcUew4S0n7QluX+6VEnM2lX+A2clwdaTOUez
	+ajb7Szw2fcCMAxB5TFQCA/kHmpszaQflDTRip3C3FLztZORgdE8KAmGk3o1owJAUPAyu6vg/GH
	9oGDUez/Xfcdr21tkkf6tz0qJVoxNXAzjm6GsqHLCyNhzPWweQB3kYfnYVw8SPIjm7O1w+phmyv
	/iwScbAZ8mQ8dcP89Vfi0fx+0rY22g6aytN41SC5ofawtZeyDEiwlO2bxCRI/gsxTUEPpjHt9zw
	EiZw==
X-Received: by 2002:a5d:5885:0:b0:432:dfa8:e1b6 with SMTP id ffacd0b85a97d-435f3aae088mr21443324f8f.39.1770108608616;
        Tue, 03 Feb 2026 00:50:08 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353f8bsm47108542f8f.39.2026.02.03.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:08 -0800 (PST)
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
Subject: [PATCH rdma-next 03/10] RDMA/mlx5: Add support for CQ creation with external umem buffer
Date: Tue,  3 Feb 2026 09:49:55 +0100
Message-ID: <20260203085003.71184-4-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-16423-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 9F5B3D6641
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Add mlx5_ib_create_cq_umem() function that allows creating a Completion
Queue with an externally provided user memory region instead of
allocating one internally.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: Ie686dc8aa76fb72299a2bff2de30e95efbcffb3e
---
 drivers/infiniband/hw/mlx5/cq.c      | 42 ++++++++++++++++++++++------
 drivers/infiniband/hw/mlx5/main.c    |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 651d76bca114..2558a52c31c0 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -718,6 +718,7 @@ static int mini_cqe_res_format_to_hw(struct mlx5_ib_dev *dev, u8 format)
 static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 			  struct mlx5_ib_cq *cq, int entries, u32 **cqb,
 			  int *cqe_size, int *index, int *inlen,
+			  struct ib_umem *ext_umem,
 			  struct uverbs_attr_bundle *attrs)
 {
 	struct mlx5_ib_create_cq ucmd = {};
@@ -749,12 +750,21 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 
 	*cqe_size = ucmd.cqe_size;
 
-	cq->buf.umem =
-		ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-			    entries * ucmd.cqe_size, IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->buf.umem)) {
-		err = PTR_ERR(cq->buf.umem);
-		return err;
+	if (ext_umem) {
+		if (ext_umem->length < entries * ucmd.cqe_size) {
+			mlx5_ib_dbg(dev, "External umem too small for CQ\n");
+			return -EINVAL;
+		}
+		ib_umem_get_ref(ext_umem);
+		cq->buf.umem = ext_umem;
+	} else {
+		cq->buf.umem =
+			ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
+				    entries * ucmd.cqe_size, IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(cq->buf.umem)) {
+			err = PTR_ERR(cq->buf.umem);
+			return err;
+		}
 	}
 
 	page_size = mlx5_umem_find_best_cq_quantized_pgoff(
@@ -949,8 +959,10 @@ static void notify_soft_wc_handler(struct work_struct *work)
 	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
 
-int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+static int __mlx5_ib_create_cq(struct ib_cq *ibcq,
+			       const struct ib_cq_init_attr *attr,
+			       struct ib_umem *ext_umem,
+			       struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
@@ -989,7 +1001,7 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	if (udata) {
 		err = create_cq_user(dev, udata, cq, entries, &cqb, &cqe_size,
-				     &index, &inlen, attrs);
+				     &index, &inlen, ext_umem, attrs);
 		if (err)
 			return err;
 	} else {
@@ -1058,6 +1070,18 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return err;
 }
 
+int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct uverbs_attr_bundle *attrs)
+{
+	return __mlx5_ib_create_cq(ibcq, attr, NULL, attrs);
+}
+
+int mlx5_ib_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
+{
+	return __mlx5_ib_create_cq(ibcq, attr, umem, attrs);
+}
+
 int mlx5_ib_pre_destroy_cq(struct ib_cq *cq)
 {
 	struct mlx5_ib_dev *dev = to_mdev(cq->device);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index eba023b7af0f..a719738ebd0c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4447,6 +4447,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.check_mr_status = mlx5_ib_check_mr_status,
 	.create_ah = mlx5_ib_create_ah,
 	.create_cq = mlx5_ib_create_cq,
+	.create_cq_umem = mlx5_ib_create_cq_umem,
 	.create_qp = mlx5_ib_create_qp,
 	.create_srq = mlx5_ib_create_srq,
 	.create_user_ah = mlx5_ib_create_ah,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4f4114d95130..25efdae83d27 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1371,6 +1371,8 @@ int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void *buffer,
 			 size_t buflen, size_t *bc);
 int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int mlx5_ib_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
 int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx5_ib_pre_destroy_cq(struct ib_cq *cq);
-- 
2.51.1


