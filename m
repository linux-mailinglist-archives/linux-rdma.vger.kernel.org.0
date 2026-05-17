Return-Path: <linux-rdma+bounces-20817-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ROyRGo9gCWr3XQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20817-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2080055F7EC
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CF8830156C9
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66D319644B;
	Sun, 17 May 2026 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="U6a5RgSl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD34282F12
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999420; cv=none; b=IPFeC2SOcI07mcV5ZduD6tj5ZmADrAAxDNkhayQuLst6W2ILfbIEjnZvNgTSUNQOGSZdgVnp84WU6l1Jn9+D2Mz8UyJtDqaa2oiYiIjjVWhF1rUXDk/GrC0rgy9xLGmrtIRqYjoGdFhsqI/Bb7/OR4BnMfnb315S1gxKaoCUe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999420; c=relaxed/simple;
	bh=xihdQXtc+RML7LZJhllg7XfyFW/SkJcTLfYVaB7vKns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZAkxfZqTsGTqKlrAXXX0E4Y1U/vfgAa9qkDR5FGH63TH3pRenRW94tg7xB/djN/sqxGzcupRGeYKbQS7ELIkmJgumExTIzggZl0wDNAJWIaFJVG0WHtbpHFeFHuvDumlgPeNyIaB3/mVDkTlW2FZ3UlSuMBFgvrb6HB9HF3TsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=U6a5RgSl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso7389245e9.2
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999417; x=1779604217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OaQOWsSmoECJJ/1gw0pbQ8onn4UZI+hVrgMI7rgmLU=;
        b=U6a5RgSlqYcME28HEV4804WKTcMz0k2tMgGyEjj+5nF10CB7Kr9juACrWIOigxB9Mn
         JcwVowRaHknTrq1c2mUa9kwBYkPrTjJLltrqe1wbKnWEHu5DRq15iQiFjLzaDW3lEw18
         B62hfQ1MduogxQ+g9Se/UXeLWTbU6mAEuI+Dr4H/cQJUY0ZAkfpW3lJ2kM0uIpJfgdlW
         0jAO5cieKVD+B96JjqyzMez9ZUnBxP51G839EBul6QCW4cxbC26Dk7m9GVZyw28AsyBg
         OSH3pAYZxjOgl+vSQeVAMFvcWCOnm9qF41dQgGz+yTZ0HdJbyNkioPYfkiHlTtzzd5tZ
         P4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999417; x=1779604217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OaQOWsSmoECJJ/1gw0pbQ8onn4UZI+hVrgMI7rgmLU=;
        b=hri2ZdsdOxapG6KWjAtpo8CRQC4mq5dW3sBS7HAKlgKXxN3f5Grp0BCXggKdvfhnk+
         upRZSqhiMEpm4bVAjROGSwhhJF/i7jV2hNPt7oxYxSV4Rpr7+nZf2jcVRrtexXkukxSn
         N/qnOuJHmW5d41CsNl08QlIiIkm4KgUfIRx+6DtsWxKk0YciDjSXK7r37pgRnHJSz8V3
         HTHwS7EFQiPXxNrrmGazyBtGz/qPmjrJLz846KP7i74g6ShVUoJ43Z+U11fymMmMcxzc
         kw5Q9OV1lpNuG4FUDkbqeWIc21bP1x3C4djus2amYjv5Kas7sDkU62HafbTllMtsvu7f
         Ooxw==
X-Gm-Message-State: AOJu0Yy6I5JINB3RfTgXDUGYaworB8KT1PLHUyxA3SG6BtQcBKvsLC7+
	zPOA145uho050OGSTTdha6i+K/1dJP1/ILt+04JqTWaw8mr4D76sfVNbP0Has9fdIFRcZTM79b7
	cXRVPD88cX6Bf
X-Gm-Gg: Acq92OE5TVCs8yBbvRGqoHEdsHMBRfVVJG41jZ7OQlLMH2PQaxUURDIgt6q7O2WJ4AS
	04sIL17Io1TDRP6P0YAUUXZrb1YUIFAE6XFQKK6bgNBhGHVYmIuivHhuOy2YlHCFjzob8xpknPx
	r+NDEn75t7wvwbUsNwo1MFeKyBaGyJXatdTkemVXrj3WVfZMCL+lXk3hzwaFJS0CqbUI2BfoCR4
	r09wArAXeEG1XURODPduNbSlGnFz1K0+b7/y7iudyQwgre8x2+1BJuPljSs3QZqW2WMY09evwfv
	YOCfeD2Wl1YCyppGx3hpo+nM8jz+5QM8W4ZaWvI4vez3+gThe0kdd+AI57yoptRDSq0MwQJjk/K
	wnqYAo/O8PdawHJu6WBHX+M9qhcjITsekcw2WydRpOi/8/LSFUxO9EnmWvv9XfzKdBBrSQeLSxf
	iC7ZYU0uKeP5RdfNPQ4c/YVCAHAYMa/8qCHcGdoqsEtGRTT52Y2BHwxfD9
X-Received: by 2002:a05:600c:a405:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-48fe5fcded3mr136876775e9.2.1778999417267;
        Sat, 16 May 2026 23:30:17 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm84527175e9.9.2026.05.16.23.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:16 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 06/15] RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
Date: Sun, 17 May 2026 08:29:57 +0200
Message-ID: <20260517063006.2200680-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517063006.2200680-1-jiri@resnulli.us>
References: <20260517063006.2200680-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2080055F7EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20817-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

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
index 54830351b050..b514ef6737f9 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -444,6 +444,54 @@ static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
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
+			   size, size, access);
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
+			   size, size, access);
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
index 0c32b055257a..5387d886df0d 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -96,6 +96,12 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 			    ib_umem_buf_desc_filler_t legacy_filler,
 			    bool va_fallback, u64 addr,
 			    size_t addr_size, size_t min_size, int access);
+struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+				   struct ib_udata *udata, size_t size,
+				   int access);
+struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+					 struct ib_udata *udata, u64 addr,
+					 size_t size, int access);
 struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
 				   struct uverbs_attr_bundle *attrs);
 
@@ -219,6 +225,19 @@ ib_umem_get(struct ib_device *device, struct ib_udata *udata, u16 attr_id,
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
2.54.0


