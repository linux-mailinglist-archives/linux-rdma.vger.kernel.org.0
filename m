Return-Path: <linux-rdma+bounces-16391-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC0jLQSDgWlNGwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16391-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04FD4925
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D026B302AE2B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 05:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86853246FA;
	Tue,  3 Feb 2026 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OpQ9fbZA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA9192B7D
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095359; cv=none; b=bFCnsq8uYvKlAV5zr0SEsrU66A8OCWVp9XzBxrs968Q9+geybps4tUguZ/PXTQUx6asaWptf+j/8p0z9E6JJqpp+qHWV0mbjQ9LBD0dh3Xu1fVAyfBoEdHxlS9ZvoXZqx0oN0Uy94ZW1nA1o2pDg7vcdzA4XopjIXYB5LWFRSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095359; c=relaxed/simple;
	bh=XIsnXHzpbNVG4cgLvd59DiXIL6CS/sShLuO38c0n8eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wl32h0Tfr20VYm/8E0Vnn1Cf33Y1BFLgAnKFNAUENBAl6/BFQ0yz1g+Ehod0NDDbVVMxYVJsGHTDkbLjVdm+keWuc0jmhlK0Yhr3i0Kgv1Tpaixx7Dj19ekt9cbyAsd0UrnE97dA0ZL9zuwigv9DH8PGGF3PXhBPvSfZsO89DAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OpQ9fbZA; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-894674a4c4aso93046886d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095357; x=1770700157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+d9QeeN96tmRVPkP62NfL1ey4Ul15qmkoa8q5JR88Y=;
        b=p58+Z7PWc+ENOfzBPxne4YRAqzrwTaO5eFcqD/2XNZ482rrCNcZR0YeizhGft9jsUg
         R/ra8XggEdcsHsWsVB5rttGfyjuqLHxCn0CruqYLnCy6w4uRZAT+oX9LIU7fEhOv5euL
         h0kji0/ACGS0YHDnp5Kf3KVaeh/1KIvmS5qy540b98rvkf2M6v2jbHWzekDUbK8MzsdR
         c6E9HLePNhGjv6dxeMSfI4pc6bIhCKBcmnDUXKYXoAomn+ncq+j91jYgxYmA2P54rdwC
         mLB4je83lo5Ys/VE7aXLXek3ctQ38tibdK+T6POrjtuTh+GVxGe+twTOYc1Gj7OlL06Z
         vjDg==
X-Gm-Message-State: AOJu0YyM6YpUofbS8QFbDMrYoMvXPT0OCOb0Ywqo8j7FzsrLa7EnA5os
	nFLXbI/qYZ/ojJ6+PveFHIFhhUQ3V1NWhZt7Ci4ZAM76kcM7FGX6afeUDfWbUPX2jDSxp7SEtB+
	oyefT31vyZnqgt9oNgNZbxQDBY6OPi1G8t46bC24qjqcLiIS7fzpNXhI3FTOzxcKK6WdVlAzYzy
	3X4mASSX/QfcgBAkSfjTFmUJfJjwShiXopK9SgMKkTnJkdvZVS2vL8AL0RH5qz5Qrs3XWyhzT2C
	Q1barH7d3+3ibentCLAD7O8arzO
X-Gm-Gg: AZuq6aJvQitgF2Wa7YMR2IGvSAsf+Ndcg5DcIzPLnW//HEFY5HHGxiIqOw1bQjNdeDI
	RmTkltoumBo/fTea/WUdvLp0dUkKgvYKx349ms+R0E8/rBOGMLrqDa31xOANOmpBmZmBALnbT4U
	xU1VgyHK4a1RtxTX4Z9L/bjRvWbXr0vF9hzPtBbBbW6tQj3N4xwelzLa8HEXRYGFl7mG2Peq5Wl
	E40M/NkPAGTOu6FEc2uDnV3SAzqJo7gX2FjEFE3p6GQqoQngz7Qlc59QddAw3wLrZEeiLcy7xXN
	Ya0MY9oA0B+Y1zrZX1vL6HIAZ7QvTmPms/HFMq2St5IzOxpGwZrqsN+FU9uAWfB/8iIp4+yZFGN
	jveglUvUDEwEE2afsawYKrZy93dRiUM1eDmYlzrVch4N8gTwHf/DxsUDSI+Vt8rMbqQqBDLlQwX
	40dIP996Y+u35apk9Veh2LwJzm0hQ/78811Pg9gE7T+niq8BuGhO57TQ==
X-Received: by 2002:a05:6214:519c:b0:81b:23d:55a8 with SMTP id 6a1803df08f44-894ea0e5d80mr185813446d6.59.1770095356848;
        Mon, 02 Feb 2026 21:09:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d375698fsm26056426d6.32.2026.02.02.21.09.16
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 21:09:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c6e05af6fso4682019a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770095355; x=1770700155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+d9QeeN96tmRVPkP62NfL1ey4Ul15qmkoa8q5JR88Y=;
        b=OpQ9fbZAQ8OZmYZ05RN07h+l0gmB4P6hLDaanBqrNQa1WGF8hTjQ8ugRBTerhUp17F
         /bjTQyiJkFMCCcIgpf9ecdIolI7UvUatnaZMKQV7E5i4cFlcUakrs0Rp+BfXhGylsmMO
         cxvvgvv0rxzq4oQuzP+UlLy05whs4wzs9hLlg=
X-Received: by 2002:a17:90b:2e41:b0:34c:635f:f855 with SMTP id 98e67ed59e1d1-3543b2ebf18mr14130694a91.7.1770095355447;
        Mon, 02 Feb 2026 21:09:15 -0800 (PST)
X-Received: by 2002:a17:90b:2e41:b0:34c:635f:f855 with SMTP id 98e67ed59e1d1-3543b2ebf18mr14130684a91.7.1770095355018;
        Mon, 02 Feb 2026 21:09:15 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547b1306c5sm621948a91.15.2026.02.02.21.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:09:14 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH rdma-next v10 1/6] RDMA/uverbs: Support QP creation with user allocated memory
Date: Tue,  3 Feb 2026 10:30:44 +0530
Message-ID: <20260203050049.171026-2-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16391-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:email];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0C04FD4925
X-Rspamd-Action: no action

Some applications may need to allocate their own memory for queues,
instead of using memory allocated by the library. This patch supports
creation of QPs with such user allocated memory. This support already
exists for CQs. Along similar lines, add new uverb attributes to
specify umem buffers (VA/length or FD/offset combinations), for SQ
and RQ. The handler pins these buffers and passes them to the driver
through a new 'create_qp_umem' device op.

Co-developed-by: Jiri Pirko <jiri@resnulli.us>
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


