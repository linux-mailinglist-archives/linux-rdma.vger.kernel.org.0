Return-Path: <linux-rdma+bounces-16063-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N/qD/aVeGn4rAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16063-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:39:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE2692ECC
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E5433015D12
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A381342177;
	Tue, 27 Jan 2026 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ai7rMWqr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190C342160
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510371; cv=none; b=f7Vx6oaGlNFL/9quBqInqLM8C8NtLxUcmmadoBiMhZE8ZxWbgb4kqebG0FV2FWaTVgd1jQSu0lI9AR00++Rl+esHmGhN6lnlqsoWe0ps+4N9C41fUHeeqkL7QQiAap7IG+22deDLLpHdYmaHVXdPNJ2ueRlgxqmmfQk0jDswIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510371; c=relaxed/simple;
	bh=x1YtjKCneiIYCLH/qdzOn9tu1LM7RxG71+TbYUUsIIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0/tdpLz+28qdad6gUYufNotLMEx/BSkXjwc1ZkyMPiVWpJUEZM1HbCrgTSjE0wnNa5MbhNJKS3AGmJGs7zmb3WucKKrtbp6sBY9ReVh8dbv9rmX0tfd7mJKKmlXh8muroWh8lZuONUwmhtcnv//9oqTuEpN5m3QUiuQ2KGBYKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ai7rMWqr; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a0a95200e8so37570025ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 02:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510369; x=1770115169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r29ITZ4nSMVe6Yvr3tJnBt49B3Qajsqa7s4ADyVXWio=;
        b=wlnGcApcwiA73nujYqvqDxacDlshIcUqTiwZSmJORs6i+8CERB69rx+sJVewGPX19y
         2K0lX6f23cyt40Xy1uO8s0Dx9MDLKcs0RDWBH84qbemgov1FO78eN2SgrOWLcnv9KepP
         cJTZGdldxJQxprssSuyDCdnwSWUKe8iUvM0aEXobAOmqU7VB4Er2jger1jnKwzbVQ1JX
         d8r97akYoB9EP348/48HlMaDMcRCMZIAmcvrGuwI2b1VnzaVtN72cfNN6Dey0uOy7HG4
         aUB+qBQsQGA2jyD/sJFh8GqR6vCbuwoEz3aeawWjETdSTpWocNVjn7S+ZCVg5JY1jLHC
         qA0g==
X-Gm-Message-State: AOJu0YyPIuK4+zAJpai1pltqZL5vqYV98Tlze/esIk/Q8w9BLBFatYDo
	nWpN9009FBFAgjTNcPR4KEMFrb/8nf+8jObSJWwzKvIs/YxWOsnoWtscIsaHiKbqOPcNzJsXxZ+
	rp4dy4btFpxSEYkRd90/8OuL47lpnOrjQvSiQlZjreiW/WSVA9Pow7oX/1eVHxyGk6grfATER8P
	5zAc89gOMG5NTi9YxquzjVF8i4sv9pMBtQGJOMNrQL5pRzUx8Pv/2TNuFErKlvB9RBogWI/itWM
	1CsleWybKNpM0bZNGBK9IQa1eoW
X-Gm-Gg: AZuq6aJfTqw+6z3HTMNF/XyIG1qC1E8xZxEgyOb9UHLJE4OcpPQ7rUw72f7ovwQrtVd
	HlH63EZz5rQ0iVC515DZdZJJ15opDxyM5jxwjzWAbq/bpK/gjlM950cFhGKig7AqLpkH/R+9hnZ
	H6iVpZru51joGyLddF2nznA9G0sJl6deInNb1xUkzRzqRtTgoC3QSLLG+rmUfBhHGuhypfTBGEZ
	pBEVIfQdigfq1A9b5QwTwE4WlJEwneOk+CU9gN5g7XK7jFtaNRsZSAa/Xa3hp0Xln5nNPGag2J9
	aHb9vKVuaGE/b2bIyZB+FSi3Y1TxGnYKCpy+qGu1Fpy+eAq5zyeucFSkGvff9kIjH5xd5VeIAlg
	klHgQ31qHIRb0OBqJGZpoZAccEK93ODSIoW+JcJd7YqOvwsC5lqlr9aSdu2Dq77uTGdEY2V4YoZ
	4Om1bmGB//WtsAfkC2yP441XmoH59n5WSljgSz8GYjgy55LXIvpTv5yZuP
X-Received: by 2002:a17:902:d2cf:b0:2a0:fe4a:d67c with SMTP id d9443c01a7336-2a870d457bfmr14762875ad.10.1769510369043;
        Tue, 27 Jan 2026 02:39:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a802dc7ab4sm13434035ad.14.2026.01.27.02.39.28
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 02:39:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a78c094ad6so54756165ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 02:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769510367; x=1770115167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r29ITZ4nSMVe6Yvr3tJnBt49B3Qajsqa7s4ADyVXWio=;
        b=Ai7rMWqrnTyLa1lbHzaA8NPxevUFatBu7cCpxdfY9pdrojDOkQnK5oUGRJGeyXfFI+
         jCmaVDBj9cPAaiOKwnK/H2iHs5NLwt4lylDqfkbIHCpQLXGk1moXKc17hB5eO0oD/V7C
         5iTGa+fKFd9nSBqyydarm78H77Jvc9pz+ZiNM=
X-Received: by 2002:a17:902:da82:b0:2a1:3e15:380e with SMTP id d9443c01a7336-2a870dc88aemr12962415ad.34.1769510367078;
        Tue, 27 Jan 2026 02:39:27 -0800 (PST)
X-Received: by 2002:a17:902:da82:b0:2a1:3e15:380e with SMTP id d9443c01a7336-2a870dc88aemr12962295ad.34.1769510366707;
        Tue, 27 Jan 2026 02:39:26 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa792sm114502875ad.19.2026.01.27.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:39:26 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Jiri Pirko <jiri@resnulli.us>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v9 1/5] RDMA/uverbs: Support QP creation with user allocated memory
Date: Tue, 27 Jan 2026 16:01:05 +0530
Message-ID: <20260127103109.32163-2-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16063-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,resnulli.us:email];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AFE2692ECC
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@resnulli.us>

This patch supports creation of QPs with user allocated memory (umem).
This is similar to the existing CQ umem support. This enables userspace
applications to provide pre-allocated buffers for QP send and receive
queues.

- Add create_qp_umem device operation to the RDMA device ops.
- Implement get_qp_buffer_umem() helper function to handle both VA-based
  and dmabuf-based umem allocation.
- Extend QP creation handler to support umem attributes for SQ and RQ.
- Add new uAPI attributes to specify umem buffers (VA/length or
  FD/offset combinations).

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/uverbs_std_types_qp.c | 157 +++++++++++++++++-
 include/rdma/ib_verbs.h                       |   4 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   8 +
 4 files changed, 165 insertions(+), 5 deletions(-)

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
index be0730e8509e..3bc7a9adbf24 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -79,6 +79,75 @@ static void set_caps(struct ib_qp_init_attr *attr,
 	}
 }
 
+static int get_qp_buffer_umem(struct ib_device *ib_dev,
+			      struct uverbs_attr_bundle *attrs,
+			      int va_attr, int len_attr,
+			      int fd_attr, int offset_attr,
+			      struct ib_umem **umem_out)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+	u64 buffer_va, buffer_length, buffer_offset;
+	int buffer_fd;
+	int ret;
+
+	*umem_out = NULL;
+
+	if (uverbs_attr_is_valid(attrs, va_attr)) {
+		/* VA mode - use regular umem */
+		ret = uverbs_copy_from(&buffer_va, attrs, va_attr);
+		if (ret)
+			return ret;
+
+		ret = uverbs_copy_from(&buffer_length, attrs, len_attr);
+		if (ret)
+			return ret;
+
+		/* VA and FD are mutually exclusive */
+		if (uverbs_attr_is_valid(attrs, fd_attr) ||
+		    uverbs_attr_is_valid(attrs, offset_attr))
+			return -EINVAL;
+
+		*umem_out = ib_umem_get(ib_dev, buffer_va, buffer_length,
+					IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(*umem_out)) {
+			ret = PTR_ERR(*umem_out);
+			*umem_out = NULL;
+			return ret;
+		}
+	} else if (uverbs_attr_is_valid(attrs, fd_attr)) {
+		/* Dmabuf mode */
+		ret = uverbs_get_raw_fd(&buffer_fd, attrs, fd_attr);
+		if (ret)
+			return ret;
+
+		ret = uverbs_copy_from(&buffer_offset, attrs, offset_attr);
+		if (ret)
+			return ret;
+
+		ret = uverbs_copy_from(&buffer_length, attrs, len_attr);
+		if (ret)
+			return ret;
+
+		/* FD and VA are mutually exclusive */
+		if (uverbs_attr_is_valid(attrs, va_attr))
+			return -EINVAL;
+
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(ib_dev, buffer_offset,
+							buffer_length, buffer_fd,
+							IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem_dmabuf))
+			return PTR_ERR(umem_dmabuf);
+
+		*umem_out = &umem_dmabuf->umem;
+	} else if (uverbs_attr_is_valid(attrs, len_attr) ||
+		   uverbs_attr_is_valid(attrs, offset_attr)) {
+		/* Length or offset without VA/FD is invalid */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	struct uverbs_attr_bundle *attrs)
 {
@@ -95,6 +164,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	struct ib_cq *send_cq = NULL;
 	struct ib_xrcd *xrcd = NULL;
 	struct ib_uobject *xrcd_uobj = NULL;
+	struct ib_umem *sq_umem = NULL;
+	struct ib_umem *rq_umem = NULL;
 	struct ib_device *device;
 	u64 user_handle;
 	int ret;
@@ -248,11 +319,58 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	set_caps(&attr, &cap, true);
 	mutex_init(&obj->mcast_lock);
 
-	qp = ib_create_qp_user(device, pd, &attr, &attrs->driver_udata, obj,
-			       KBUILD_MODNAME);
-	if (IS_ERR(qp)) {
-		ret = PTR_ERR(qp);
+	/* Get SQ buffer umem (from VA or dmabuf FD) */
+	ret = get_qp_buffer_umem(device, attrs,
+				 UVERBS_ATTR_CREATE_QP_SQ_BUFFER_VA,
+				 UVERBS_ATTR_CREATE_QP_SQ_BUFFER_LENGTH,
+				 UVERBS_ATTR_CREATE_QP_SQ_BUFFER_FD,
+				 UVERBS_ATTR_CREATE_QP_SQ_BUFFER_OFFSET,
+				 &sq_umem);
+	if (ret)
 		goto err_put;
+
+	/* Get RQ buffer umem (from VA or dmabuf FD) */
+	ret = get_qp_buffer_umem(device, attrs,
+				 UVERBS_ATTR_CREATE_QP_RQ_BUFFER_VA,
+				 UVERBS_ATTR_CREATE_QP_RQ_BUFFER_LENGTH,
+				 UVERBS_ATTR_CREATE_QP_RQ_BUFFER_FD,
+				 UVERBS_ATTR_CREATE_QP_RQ_BUFFER_OFFSET,
+				 &rq_umem);
+	if (ret)
+		goto err_release_sq_umem;
+
+	/* Use umem-based creation if buffers are provided */
+	if (sq_umem || rq_umem) {
+		if (!device->ops.create_qp_umem) {
+			ret = -EOPNOTSUPP;
+			goto err_release_rq_umem;
+		}
+
+		qp = rdma_zalloc_drv_obj(device, ib_qp);
+		if (!qp) {
+			ret = -ENOMEM;
+			goto err_release_rq_umem;
+		}
+
+		qp->device = device;
+		qp->pd = pd;
+		qp->uobject = obj;
+		qp->real_qp = qp;
+		qp->qp_type = attr.qp_type;
+
+		ret = device->ops.create_qp_umem(qp, &attr, sq_umem, rq_umem,
+						 attrs);
+		if (ret) {
+			kfree(qp);
+			goto err_release_rq_umem;
+		}
+	} else {
+		qp = ib_create_qp_user(device, pd, &attr, &attrs->driver_udata,
+				       obj, KBUILD_MODNAME);
+		if (IS_ERR(qp)) {
+			ret = PTR_ERR(qp);
+			goto err_put;
+		}
 	}
 	ib_qp_usecnt_inc(qp);
 
@@ -277,11 +395,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
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
 	return ret;
-};
+}
 
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_QP_CREATE,
@@ -340,6 +463,30 @@ DECLARE_UVERBS_NAMED_METHOD(
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
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6c372a37c482..8bbf37b9e823 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2520,6 +2520,10 @@ struct ib_device_ops {
 	int (*destroy_srq)(struct ib_srq *srq, struct ib_udata *udata);
 	int (*create_qp)(struct ib_qp *qp, struct ib_qp_init_attr *qp_init_attr,
 			 struct ib_udata *udata);
+	int (*create_qp_umem)(struct ib_qp *qp,
+			      struct ib_qp_init_attr *qp_init_attr,
+			      struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			      struct uverbs_attr_bundle *attrs);
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
2.51.2.636.ga99f379adf


