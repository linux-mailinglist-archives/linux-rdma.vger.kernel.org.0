Return-Path: <linux-rdma+bounces-15881-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bz/CSUBcmmvZwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15881-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 11:51:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09665851
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 11:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA42F862F1F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B13ED129;
	Thu, 22 Jan 2026 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CPITBbFK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE72E0418
	for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078142; cv=none; b=WX6BrlvLgzGtyX8wMFSqsfArS0rB7vZGKuFtn25fVIgLINCEebul8M3U30LJBvQhgGE5DQWu5szJIquMoDH2wtIjcrd7uRdsHMuq/e3B17leGinfwl4WtBatrj1K8XvoaUOmGgCHiYcb0z6oyjaobQVUQjqN1SY1P/iry3YopWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078142; c=relaxed/simple;
	bh=wnPemGkiETjUQHuKaMFclgr//FeyZEFVPptwzm5dVJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngQCTRF0q4st5RJK9DZstvQxYD61bMO0EZhaLeTszJVGxSYg+53m8LDig9nMy+4eRkhWq0gISu0QNywuP8tXfchDwSEaEB8nlbJ+RLAL7uchGbFbmnAmhRH6UmK6dxmmiqwR184o/OlCniJFL4/xT2O4YlM4mkZBC0BJNXQrxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CPITBbFK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48049955f7fso4385485e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 02:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769078136; x=1769682936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkV+XAvcoWEix1n9H2Tl7osuua8NNvV/VLiRAbP4Lvs=;
        b=CPITBbFKt577qT+8kS4fxb1YBU2yL1XIpbQ4FCZ+OMboje2DzJxSIvl+61N+BK0WEw
         bSJ/G4p9dF4Ll7ko9fTrh5DR5Lgkok6Wp5qPgaK37PTWsHGs1c8OgB+04wafIW0uNIik
         vWGREGTm9SCtfYuc8lrPy5xh8huHM0AZeuW65P8f1nuUVxNM+hboiwxdW9rX8hYnufBR
         70Lpl6q2JB4eMyttiKH/wzCaFhhqwaCe7r49pW4NCJ4Rdhq81kd0mpD+QxMaWtQxm2gW
         /lwnaKoLaQwPiNHMu/v2kzJ7x6I15OJjdcTujAlnNXrhMoVdbOWari1CBMnYSstwst5s
         rVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769078136; x=1769682936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkV+XAvcoWEix1n9H2Tl7osuua8NNvV/VLiRAbP4Lvs=;
        b=GE5tVYtUZkjVB52ylJuOqx0GIm6gvII8wtmqy6RY5dI5z2RLh8eUUWgDAYu0RhOaqv
         kFkDv/SAK7/xUzFGrgknbNob0GiibeEb1uJH3pl3f/z933j1TGtXvriQwbsZTCxVAmTe
         kEEmIkm5t5gLByf4SdaKbvyET9hzQRDOx3qpil0GYkY78Wso+JUR9KCEeJGjsSKnU076
         kiN131UaM0Y6DeOvKFBquZas9svQtuWa59qPsNKY3A8HlllfKp31pwLJrdpF6cZ5qfBV
         0wNhU+M6TO3R75MtLixI0UyHeytHiZTnrzK+OT5uIEiJPgKuC/e9mOfJeIabMplLfyWc
         M3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5rTQg0zoJNPmqvm9dTIcvgtu/tG9qCPgecl4tA+FWZIKq+egwBgvQ0ozOJRWlEF8C3BcwG5sksJmQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOoDSBSJJNPDRCvFEDaML/eDnLPWrMbKDQiWlvrcyT+skHtN+a
	eZQO26SP/M8AMNGRu6BAYs82WBiyDdvgiYAxR4cd7GCkwh8PU9jMfXjyXx8NnrK5FR8=
X-Gm-Gg: AZuq6aJ3+Ssz/c/mlyIcBQmhdWwpZHMjH6aaTzBehteVTm2g2FkZsSImzstYZTVgCjm
	bkfS6vvTKXj0+PKy4s9UaiTDdi40ZONAZweqdJJLM0/XQrkRskBHh2WO7kLyk+m9vwnH1QV87GD
	lh0pyi8u+DkzAQET8QGSb17xOUvCIFFuKIFKDpwbZ0FazhM7P7q1ygbQWgUB6/AZuCDOjaRyeUf
	2s21FR83ki2EugIRyplkbgZYHEPsAxxjs7H0NqJgZGB9dT9DN3Y9j7P3aMZt5zpq/TKSsMYsUsv
	vA9sjKLhDH/REgNnVEFClrqih2WnIjRbL4rp2iEh8pAFqVCQHgyYBb6Dc0ISvGBR4FK0I6baTwT
	5CJz0E5MdYLcRGxbamK2ekCZHIJkRNTivx5AP5gltN6HONVcmF++oreRK2LRK/fzQCdXe4097vS
	W5xHJ0cdgqF+XBShaz28gQb1Q=
X-Received: by 2002:a05:600c:8207:b0:480:1c75:407c with SMTP id 5b1f17b1804b1-4801e30a4f9mr248609575e9.2.1769078136413;
        Thu, 22 Jan 2026 02:35:36 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480497035cdsm16682315e9.19.2026.01.22.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:35:35 -0800 (PST)
Date: Thu, 22 Jan 2026 11:35:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <k3mj4pl3ifyrva44z4bscpzwgmvctr2stgorixsj2xwtvi6sws@7miulfpsl2zw>
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15881-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 8B09665851
X-Rspamd-Action: no action

Tue, Jan 13, 2026 at 06:09:56PM +0100, sriharsha.basavapatna@broadcom.com wrote:
>The following Direct Verbs have been implemented, by enhancing the
>driver specific udata in existing verbs.
>
>CQ Direct Verbs:
>----------------
>- CREATE_CQ:
>  Create a CQ using the specified udata (struct bnxt_re_cq_req).
>  The driver maps/pins the CQ user memory and registers it with the
>  hardware.
>
>- DESTROY_CQ:
>  Unmap the user memory and destroy the CQ.

Perhaps I'm missing something, but why can't you use existing create cq
with umem extension introduces by following commit:

commit 1a40c362ae265ca4004f7373b34c22af6810f6cb
Author: Michael Margolin <mrgolin@amazon.com>
Date:   Tue Jul 8 20:23:06 2025 +0000

    RDMA/uverbs: Add a common way to create CQ with umem

    Add ioctl command attributes and a common handling for the option to
    create CQs with memory buffers passed from userspace. When required
    attributes are supplied, create umem and provide it for driver's use.
    The extension enables creation of CQs on top of preallocated CPU
    virtual or device memory buffers, by supplying VA or dmabuf fd, in a
    common way.
    Drivers can support this flow by initializing a new create_cq_umem fp
    field in their ops struct, with a function that can handle the new
    parameter.

    Signed-off-by: Michael Margolin <mrgolin@amazon.com>
    Link: https://patch.msgid.link/20250708202308.24783-2-mrgolin@amazon.com
    Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
    Signed-off-by: Leon Romanovsky <leon@kernel.org>


As a matter of fact I'm currently working on a similar extension to
create qp using dma-buf. Here there is totally untested draft, but I
think it provides a picture:

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1174ab7da629..6b89883028b8 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2732,6 +2732,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_cq_umem);
 	SET_DEVICE_OP(dev_ops, create_flow);
 	SET_DEVICE_OP(dev_ops, create_qp);
+	SET_DEVICE_OP(dev_ops, create_qp_umem);
 	SET_DEVICE_OP(dev_ops, create_rwq_ind_table);
 	SET_DEVICE_OP(dev_ops, create_srq);
 	SET_DEVICE_OP(dev_ops, create_user_ah);
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index be0730e8509e..218906875f4a 100644
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
+						       buffer_length, buffer_fd,
+						       IB_ACCESS_LOCAL_WRITE);
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
@@ -96,6 +165,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	struct ib_xrcd *xrcd = NULL;
 	struct ib_uobject *xrcd_uobj = NULL;
 	struct ib_device *device;
+	struct ib_umem *sq_umem = NULL;
+	struct ib_umem *rq_umem = NULL;
 	u64 user_handle;
 	int ret;

@@ -248,11 +319,57 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
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

@@ -277,11 +394,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
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
@@ -340,6 +462,30 @@ DECLARE_UVERBS_NAMED_METHOD(
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
index 6aad66bc5dd7..5f4db48a6bb9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2503,6 +2503,10 @@ struct ib_device_ops {
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
index de6f5a94f1e3..0eced4cafedb 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -151,6 +151,14 @@ enum uverbs_attrs_create_qp_cmd_attr_ids {
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


