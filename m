Return-Path: <linux-rdma+bounces-18621-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNJdHS8DxGnOvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18621-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:45:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C997A328553
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7115F312D9A9
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A9C3FFAB1;
	Wed, 25 Mar 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xD5nsmga"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6A3F9F52
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450856; cv=none; b=ab1iBuFS09Yidc5F11P4uUZhZw+qkOq6bBemewhceGjd6jepjbHD3/2RpTOxt64BEGb/gUqy9eTvM581z2Vf99DmZTpc2QivbF9hyT/W0e3VwiJHVPWugso+aD5sO/KpdeevwqzCEd+ykuRe3thyfLcQEX9IXEE1/k/r+AmDC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450856; c=relaxed/simple;
	bh=HzwtKkH2VT5iYfyOxrNTG/2+m8qQKCeNFwvoiVbMcl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5TuBmgPzVEQV/uv/7YG4zIA7faS0GGgLTKzBz6FS2pZKjWCNW+o53rxLZu5zPwL/NYzDv1Q36MUjHbI2WCjOWM6rfXcb0XrXvdllLAq5pfndy50oh8mMuVS4bx3KnHo06ZpASnT6d8Yb7/1N+Gpowus1pA23t8HNXGATHU4OaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xD5nsmga; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b94a19fdso4884796f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450852; x=1775055652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5s7qbQUMJRRk509cExHxJE0JFzfHVtayMYRWFFAdDQ=;
        b=xD5nsmgaZEJFKI2mt7vWmV/GPoZi7qOapthHkAAv0N03V5aszXngGZqyir6UfT7jbK
         Eufe+NJNmKrBGl9QWzX5wOeTjQArNhQuvMAGJnZhfgtXfLYNSXR646kDKIBI6DFGLgzm
         3TZ6omVo6E28rcgvsf8fBS/TjDijlHEgYnH0KRRHQwZTQKjZcI98MqeuL7dghWItXKF7
         XtFfbcjA/sS8vBaR5D/fKHjKc6vYnHIfNjryeQee3kSdqhJjKnZxXUa3iuhPdLGYL58E
         +zqeyI93gw2NLTT+yQAAcczNJHqhuxlOuzGfQmuXpCuL1HOIW5ZA58PLh/W5Uwu5V8Ek
         +4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450852; x=1775055652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w5s7qbQUMJRRk509cExHxJE0JFzfHVtayMYRWFFAdDQ=;
        b=PPhjjAcsMjYwhliNaLDrbmbh8As4b3sdodYMCO1n43mUUwOrHDiyo90ic/KUfb+HVc
         NNOvQ8ksPr8djWDdXZbkxj2WoQrUPu9Dw5/PUbk7rNA/H0tsRoOpIyEsR8DDjq4TbP6o
         JEevziviIMioJY4WZxXeLF/CEHdGA0hPhHV78bIQi5ZkQ6uUmUzz3YzF9cRpxcYTml/M
         SkTmTouoHFecpt+iyeYgBuhFnwGZAivIzCHrUbjAqDsAAH95gvVTLUva8y191p+xlq+x
         w3/fInW2eOI3nR2IkEMhFSCw90btj2IOAyEt16DV6ysdl74R82hKaWulGBpYXCpVdE6K
         R0Vw==
X-Gm-Message-State: AOJu0YzOEICByKyxuPNMqiYarUgxldj02KwAS6tzMS/q34Y9DpMj+Xwr
	yjrG14Axlu/Fyz2l6+YKpXrp0wWn2Qr1aikGOKrd0eAT1TtXhmy5a5FFBU3vpThocVbxT2o2gTn
	hhyTGbFw=
X-Gm-Gg: ATEYQzzAT2ay2P7SY0jr103lqFcFk3/LbabpXW192gJeKK0qh9nauIPDcIMab11supW
	U+iZwg/5/8m6RzmXKIQc/nrRN5tOYq1z2/jTTnw5W+o9fB/l5f+CR8ZdTvOIEpKQN3Qs7g2Mk1t
	6yqXK830hFxi2zorEwu7MyIXyQMJX6cjKwuglB+D6ch7yVyBMF9wYVrMPZdgccwmcHwnszuxlI8
	NRYV6RBuMBWAv+0PdJb4EZKlZAbJfs/pRzaUEO31N8cT7OchSf0+GS/JsOCZtelddQGET74oxKM
	VGbgY7fnNVLXst7yZnD9D56Ua0LQAEs36VVVbl4OGiZDBS2B25yQSFo+u1+aC9Xe3GWgffDxGSc
	uw23uhP/0TxvERVqt13YMYql4CRpBI8Tb3PAlkfqAVaTlQb4EAziU7wDMWuKUGNosUIDkJVsfKc
	j0vjOpeL/OHd/Ha5t2AAps7bGz
X-Received: by 2002:a05:600c:1f8e:b0:485:3fa9:358c with SMTP id 5b1f17b1804b1-4871605677amr60460605e9.17.1774450852279;
        Wed, 25 Mar 2026 08:00:52 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871e6e7c69sm232415e9.15.2026.03.25.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:00:51 -0700 (PDT)
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
Subject: [PATCH rdma-next 02/15] RDMA/uverbs: Push out CQ buffer umem processing into a helper
Date: Wed, 25 Mar 2026 16:00:35 +0100
Message-ID: <20260325150048.168341-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18621-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C997A328553
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
2.51.1


