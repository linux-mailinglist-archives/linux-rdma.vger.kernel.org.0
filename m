Return-Path: <linux-rdma+bounces-19228-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMBqILVf2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19228-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D31FB3E06D5
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2692303988B
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418441531C8;
	Sat, 11 Apr 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="RW5VJODo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AAF262FFC
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918964; cv=none; b=eIUBrZR+nyvhdIKPoQc2skhs79C6X5Pq1tpcTTwB89bGnIqACG3PADq3wJTmShzeGi/2M1su7KaVeN6BmbJm5lQGiM8IngDP/vGLGgE1fy83JPmmDJ3XHghyXGIus7jrur76wj1fr2WkU1wr+O6atE9YPkfmTV9xkFhrDVq2TuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918964; c=relaxed/simple;
	bh=WqCEFJBJgqvEtyHQX/JpSphLKTr8jcqUJ9dwhJLYx/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbcwLTMZvK/bVTA2fGfRDrLCNEqjgoEi01/F/+isR1KLX2TgvCVWj4AUea2GjYRKectPea9mQEz7CiCkn0m7keOccVFUdgsYFk3xX90idOfk0PHr7eC13XVotoQzsqQS4LAmPwFH8vVgNBchXr8v1pb8sLYWxhxDRo5sG/+XtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=RW5VJODo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so2047219f8f.0
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918960; x=1776523760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV/tVKLOwKRIfNhp8NMLshlhVptCxqhDDJj3AGxl4us=;
        b=RW5VJODol4f5TbzxEeX7oyvTy+ubuEzEy/oGUxvbqGLKPsNNwJazdxODtY3m0kgy/o
         AdIM/nwAduRFGMJQBrXCGfbU3PgUVCLVLdUfKjdBD7by4xtahDWeiXenLUHohARW72Q0
         UGU9J8rD0Fl9i2k98fDB2YPOuAVwVMRLyijOPYG/5tDX4/2l3Yofnk/EygRNW+KOjDtl
         eRvUHnThR+mEKu21mZQBoPl3/RYYFELeO3a60LUEVKnZtmq7cX79Fl2aWIpBZsBQ4srg
         tAecmK3yfiPmx2KSGPEzWXFrzbDjzNsQeqhLu04jP72DuL6IXp5EwtMjI+DocnNDsZBp
         IuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918960; x=1776523760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EV/tVKLOwKRIfNhp8NMLshlhVptCxqhDDJj3AGxl4us=;
        b=cweNAlaN9IU0Cdpkg7+NnZx6HTVZKNkWkU4nhvX0jNVttcuyGH27jU5c/RrbPLy215
         uhtK0OomVVnsdfxu7uvyN6K/WZJTyY/GIpRytUbMuyCfZz7Nz0EFVGB0vCqoVEiwHJiF
         8zOUmVLlOJEqSGhbEYd+K3/9dfmKr5H0I29Q814GDryU/WcQsO9IIRwnG6Xe7dc5vPLu
         WkyLLiSnqrnmpvQ1SkIKYQYKZkbe3LGkrZdp/e2ojSFqy5cCrAqkrySIPwVG/B6izspR
         ZqxrjUdSz+n8ox5OymxuGvjfy/kWGP48nvSY1QRhFaIiwk6EJ8NceUYLAo+8EzR4n7M1
         vR1Q==
X-Gm-Message-State: AOJu0YyDczzDghUopfesA1UBF8ih5lwqif+5mgv295k8GYek7agKCtWO
	NdxYbgOM76GEWUMEVQg+CfzgF4lztIYXdZrEuc8a5+2Pd+Oa5+9ucvG8ANzKGhF4EZiMJZbpAXO
	sZeID
X-Gm-Gg: AeBDiestUvxeJNafZxwYQXgvwREbOQ3vxV86zavdmCCDi743f7cL2Z1JPicbpsLJVTx
	8DG+SV/Bf+BqSZLOOLL25Ar6bLHzzZdQtfRIHoCL+QZaqob59uhxoknzlMvHVh1vu69FpaFK5Bn
	Y3raxsgnCq377P3uJdOLBwroKJSMwgk/SHe1mJVjvFTO2GZQdJswt0qAS520nsgnoIaH910U0uF
	/uwEzHpILDnWXSTKb2XqfdlWUm3CJkbGxZ07EYtVf8X+G0TliOpIH9nv32yy8egnCpJDTQe4st9
	95Ctmal0OpylBfkpaAe39PbBzk8WPN96BRk2ab4jRhqyL8N0qxE85b+X5J00K2BXfET4wDL1MZn
	t+YIPoe+uxVqEOgsNHgQBpkpcSYlgtq/xDZYHcDHtcJ0HW+PVm7ps1v+x/wSSgfUCWGkraxo3eQ
	tk4ivQszCucBkkyA9sL+bql63HnC1QZE4JqZ7BK2NSljQ=
X-Received: by 2002:a5d:5f90:0:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-43d64235d55mr11003714f8f.6.1775918960164;
        Sat, 11 Apr 2026 07:49:20 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50289sm16827498f8f.28.2026.04.11.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:19 -0700 (PDT)
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
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v2 02/15] RDMA/uverbs: Push out CQ buffer umem processing into a helper
Date: Sat, 11 Apr 2026 16:49:02 +0200
Message-ID: <20260411144915.114571-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411144915.114571-1-jiri@resnulli.us>
References: <20260411144915.114571-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19228-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D31FB3E06D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Extract the UVERBS_ATTR_CREATE_CQ_BUFFER_* attribute processing from
the CQ create handler into uverbs_create_cq_get_umem() and separate
buffer acquisition logic from the rest of CQ creation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_cq.c | 127 ++++++++++--------
 1 file changed, 69 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index d2c8f71f934c..4afe27fef6c9 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -58,6 +58,72 @@ static int uverbs_free_cq(struct ib_uobject *uobject,
 	return 0;
 }
 
+static struct ib_umem *uverbs_create_cq_get_umem(struct ib_device *ib_dev,
+						  struct uverbs_attr_bundle *attrs)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+	u64 buffer_length;
+	u64 buffer_offset;
+	u64 buffer_va;
+	int buffer_fd;
+	int ret;
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA)) {
+		ret = uverbs_copy_from(&buffer_va, attrs,
+				       UVERBS_ATTR_CREATE_CQ_BUFFER_VA);
+		if (ret)
+			return ERR_PTR(ret);
+
+		ret = uverbs_copy_from(&buffer_length, attrs,
+				       UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
+		if (ret)
+			return ERR_PTR(ret);
+
+		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD) ||
+		    uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
+		    !ib_dev->ops.create_user_cq)
+			return ERR_PTR(-EINVAL);
+
+		return ib_umem_get(ib_dev, buffer_va, buffer_length,
+				   IB_ACCESS_LOCAL_WRITE);
+	}
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD)) {
+		ret = uverbs_get_raw_fd(&buffer_fd, attrs,
+					UVERBS_ATTR_CREATE_CQ_BUFFER_FD);
+		if (ret)
+			return ERR_PTR(ret);
+
+		ret = uverbs_copy_from(&buffer_offset, attrs,
+				       UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET);
+		if (ret)
+			return ERR_PTR(ret);
+
+		ret = uverbs_copy_from(&buffer_length, attrs,
+				       UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
+		if (ret)
+			return ERR_PTR(ret);
+
+		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA) ||
+		    !ib_dev->ops.create_user_cq)
+			return ERR_PTR(-EINVAL);
+
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(ib_dev, buffer_offset,
+							buffer_length, buffer_fd,
+							IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem_dmabuf))
+			return ERR_CAST(umem_dmabuf);
+		return &umem_dmabuf->umem;
+	}
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
+	    uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH) ||
+	    !ib_dev->ops.create_cq)
+		return ERR_PTR(-EINVAL);
+
+	return NULL;
+}
+
 static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	struct uverbs_attr_bundle *attrs)
 {
@@ -66,16 +132,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 		typeof(*obj), uevent.uobject);
 	struct ib_uverbs_completion_event_file *ev_file = NULL;
 	struct ib_device *ib_dev = attrs->context->device;
-	struct ib_umem_dmabuf *umem_dmabuf;
 	struct ib_cq_init_attr attr = {};
 	struct ib_uobject *ev_file_uobj;
 	struct ib_umem *umem = NULL;
-	u64 buffer_length;
-	u64 buffer_offset;
 	struct ib_cq *cq;
 	u64 user_handle;
-	u64 buffer_va;
-	int buffer_fd;
 	int ret;
 
 	if ((!ib_dev->ops.create_cq && !ib_dev->ops.create_user_cq) ||
@@ -122,59 +183,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	INIT_LIST_HEAD(&obj->comp_list);
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 
-	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA)) {
-
-		ret = uverbs_copy_from(&buffer_va, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA);
-		if (ret)
-			goto err_event_file;
-
-		ret = uverbs_copy_from(&buffer_length, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
-		if (ret)
-			goto err_event_file;
-
-		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD) ||
-		    uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
-		    !ib_dev->ops.create_user_cq) {
-			ret = -EINVAL;
-			goto err_event_file;
-		}
-
-		umem = ib_umem_get(ib_dev, buffer_va, buffer_length, IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(umem)) {
-			ret = PTR_ERR(umem);
-			goto err_event_file;
-		}
-	} else if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD)) {
-
-		ret = uverbs_get_raw_fd(&buffer_fd, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD);
-		if (ret)
-			goto err_event_file;
-
-		ret = uverbs_copy_from(&buffer_offset, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET);
-		if (ret)
-			goto err_event_file;
-
-		ret = uverbs_copy_from(&buffer_length, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
-		if (ret)
-			goto err_event_file;
-
-		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA) ||
-		    !ib_dev->ops.create_user_cq) {
-			ret = -EINVAL;
-			goto err_event_file;
-		}
-
-		umem_dmabuf = ib_umem_dmabuf_get_pinned(ib_dev, buffer_offset, buffer_length,
-							buffer_fd, IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(umem_dmabuf)) {
-			ret = PTR_ERR(umem_dmabuf);
-			goto err_event_file;
-		}
-		umem = &umem_dmabuf->umem;
-	} else if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
-		   uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH) ||
-		   !ib_dev->ops.create_cq) {
-		ret = -EINVAL;
+	umem = uverbs_create_cq_get_umem(ib_dev, attrs);
+	if (IS_ERR(umem)) {
+		ret = PTR_ERR(umem);
 		goto err_event_file;
 	}
 
-- 
2.53.0


