Return-Path: <linux-rdma+bounces-19920-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFucM2qm+GkExgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19920-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:00:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B24BE4C0
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A36CB30416F6
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A73DDDD6;
	Mon,  4 May 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="WYlHebXf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE93DDDBC
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903070; cv=none; b=moNOwJGVlBMfcmfsu07fbG+Kgf7nwVxq4L1Day9luYXL9ZF586L6ItIn+G1g/tYLopBXvkfL+/WKFIe3i26KwNKG+arGZwqPJb8oHockRJretOsqHRo7vRsXAdnRmBcQ4zCSePzGZoJ9jA5Qkjpaq5KjPIWSF3FSAfS9AyQt254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903070; c=relaxed/simple;
	bh=M7GJ7MLZgM+UuTqwtmzJSWQkIjactky1g71N84AMors=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPo9vUzh9OqZB+/3EtpZdQMJnTOnr2BRZG/ErpZqMAlG+ZnXx87w9Fesw/hDuAqIi5Hl4PLyktVBZUKnR74XkOvsfPs7SHiBV9ThSEvXw80oYB/BryfJPyiM/m/pWsTk128bA7fa3ShQkGeq4vfnU1fHM5XN2AcSzlb9Q8/1DQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=WYlHebXf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44a14580111so2476230f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903067; x=1778507867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcrPaO1KiZTA6vxSkr8MVEYIAp0Ilk88EHRISmjPs+0=;
        b=WYlHebXfWC3tG4i7CVFcDG6Hl9lXQQRfil8DrhBJvro9eMU9KB6sWyeF5oezfDx2+N
         VAeWN+CJ9AagthLytgY4FK6HW8CJI338dlg8W7Z+EKFkCOCMPjD7+Of08PxvMSkflCur
         JEQqIzKqXD8R1QSowx/2BSYAvL2NukJ10aPya4A54vQ3q7im3r9AMybrSg7xHjrYTxaM
         TUmsxYV1C+OYTIfhtQ93/2RAJ3uaeoFaChRynRgtnsKRdv8NW6/GDhzcLj57yBUZx9zQ
         54AtwL4cCJoqjaMdPZBU7PytIkFwjfVNsqDqnPr6P08u9PlJUk9o0SuVC1wzfwQjVg1I
         lKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903067; x=1778507867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcrPaO1KiZTA6vxSkr8MVEYIAp0Ilk88EHRISmjPs+0=;
        b=njVB1uNVQfGQ2dWSznAnp0nldz96UusViiWqxyOYiBZPvGxyokpffqVhiGeX7bFxo3
         fGbPN3x9EhYpH2YKby9yO7u1rN3d2OmM11/tg+f13uV30EoS04112hSR3cV5W99bIe5F
         296sG6xQWtqGrFFq8skGWBpVhSRodKg7l34zzHS7wO8XiVeCGm9LPSh0Sf8ST0hEoGUl
         U0VVQl65IhVzlGoYNOyK71Csq9/lRNadHCEs2npQBiqnkR5IWonPvwykDP85+z0BVx/H
         E41dNtsVxuFZOmIgi2SRiL5Z3U3YV6lssZWUaoyvb2VFbWmXm+rDbsyDFiL3YiD4+AYN
         DpJg==
X-Gm-Message-State: AOJu0YyOwFDLdfVWThQHpZFGG5H8CVvObyN8K+QkbKdQen0tX/3VZ4an
	UfEU6sFiIXOLkkuQ+grwXeY1SMQiE7e2KUJdpAsGGoRK2Y5RSbqxofE09BnTWaKeyj1dIQYb2ND
	hSOT2Acw=
X-Gm-Gg: AeBDiesj8Yyz1GcyUpeQMWWK43znaGBLY8S/Zt2FhrRR5kl6OlUYvS62uP8wU2+AZsm
	1Ra3coN1gcuzXl3Fu018/OdpFtznrysdfozGsJ/StHELNaFXNVXMd9aJ7mvRNFEKqBg+ZXfGZLV
	fzRSKOuX7LzZFajtQKS2aqIUI1jSpMjG1zJtG+HqCicPO31K2yqYAObT7PoU3AlpFnGz+Cl3Bba
	T1K8z2KYssTry8xwahpv0TtuXgl7PXhk4VtAugCcjxGtrBrA2AXXX31KoxcDk2qSFE1x29eyL2t
	7FTgDRbSR1QE8KJ/tN2/aM//OxdY81lAedntfsRbASGOguxNNwomyWJCt2OowWatJ0xFVsJqOXX
	c7BWO2oC2/nURrZQwMQbk6iuf0F1iw9Jwhc8sTZ7+NL1QXGDL0oVL9O/P3AgJeuuktrEudOT/qC
	zbrNMH3aXrzTBpEzRjQkiY+u+f
X-Received: by 2002:a05:6000:3109:b0:43c:cf25:f29a with SMTP id ffacd0b85a97d-44bb36d1923mr16420355f8f.8.1777903066917;
        Mon, 04 May 2026 06:57:46 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef45sm27333803f8f.32.2026.05.04.06.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:46 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 07/17] RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
Date: Mon,  4 May 2026 15:57:21 +0200
Message-ID: <20260504135731.2345383-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 541B24BE4C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19920-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Jiri Pirko <jiri@nvidia.com>

Add UVERBS_ATTR_CREATE_CQ_BUF_UMEM and two driver-facing
wrappers, ib_umem_get_cq_buf() and ib_umem_get_cq_buf_or_va(),
that pin a CQ buffer umem from it. The wrappers reuse the
existing legacy CQ buffer-attr filler.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c                | 48 +++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_cq.c |  2 +
 include/rdma/ib_umem.h                        | 19 ++++++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 4 files changed, 70 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index f720de8cb162..04684411c82e 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -427,6 +427,54 @@ static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
 	return -ENODATA;
 }
 
+/**
+ * ib_umem_get_cq_buf - Pin a CQ buffer umem from per-command attributes.
+ * @device:  IB device.
+ * @udata:   uverbs udata bundle (may be NULL).
+ * @size:    minimum required CQ buffer length.
+ * @access:  IB access flags.
+ *
+ * Resolves the CQ buffer from the new UMEM attribute or the legacy
+ * CQ buffer attributes. There is no UHW VA fallback, so the caller
+ * must arrange its own backing (typically an in-kernel allocation)
+ * when no source is available.
+ *
+ * Return: caller-owned umem on success; NULL when no source supplied
+ * a buffer; ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+				   struct ib_udata *udata, size_t size,
+				   int access)
+{
+	return ib_umem_get(device, udata, UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+			   uverbs_create_cq_get_buffer_desc, false, 0,
+			   size, access);
+}
+EXPORT_SYMBOL(ib_umem_get_cq_buf);
+
+/**
+ * ib_umem_get_cq_buf_or_va - Pin a CQ buffer umem with UHW VA fallback.
+ * @device:  IB device.
+ * @udata:   uverbs udata bundle (may be NULL).
+ * @addr:    UHW user VA used when no per-command attribute matched.
+ * @size:    minimum required CQ buffer length.
+ * @access:  IB access flags.
+ *
+ * Like ib_umem_get_cq_buf(), but pins @addr/@size when neither the
+ * UMEM attribute nor the legacy CQ buffer attributes are supplied.
+ *
+ * Return: caller-owned umem on success, ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+					 struct ib_udata *udata, u64 addr,
+					 size_t size, int access)
+{
+	return ib_umem_get(device, udata, UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+			   uverbs_create_cq_get_buffer_desc, true, addr,
+			   size, access);
+}
+EXPORT_SYMBOL(ib_umem_get_cq_buf_or_va);
+
 /**
  * ib_umem_get_cq_tmp - Temporary CQ buffer umem getter.
  * @device: IB device.
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 711bad0aa8a3..05d1294762c0 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -215,6 +215,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
 			   UVERBS_ATTR_TYPE(u64),
 			   UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+			 UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_CQ_DESTROY)(
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index afe12a1bedb0..174788a0640d 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -92,6 +92,12 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 			    u16 attr_id,
 			    ib_umem_buf_desc_filler_t legacy_filler,
 			    bool va_fallback, u64 addr, size_t size, int access);
+struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+				   struct ib_udata *udata, size_t size,
+				   int access);
+struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+					 struct ib_udata *udata, u64 addr,
+					 size_t size, int access);
 struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
 				   struct uverbs_attr_bundle *attrs);
 
@@ -208,6 +214,19 @@ ib_umem_get(struct ib_device *device, struct ib_udata *udata, u16 attr_id,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+						 struct ib_udata *udata,
+						 size_t size, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+						       struct ib_udata *udata,
+						       u64 addr, size_t size,
+						       int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline struct ib_umem *
 ib_umem_get_cq_tmp(struct ib_device *device, struct uverbs_attr_bundle *attrs)
 {
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 72041c1b0ea5..02835b7fd76d 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -117,6 +117,7 @@ enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH,
 	UVERBS_ATTR_CREATE_CQ_BUFFER_FD,
 	UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
+	UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
 };
 
 enum uverbs_attrs_destroy_cq_cmd_attr_ids {
-- 
2.53.0


