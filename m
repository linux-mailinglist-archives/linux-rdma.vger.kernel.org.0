Return-Path: <linux-rdma+bounces-21035-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNcdNH6JDWpKywUAu9opvQ
	(envelope-from <linux-rdma+bounces-21035-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:14:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D948558B813
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1272303B2C7
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4D3D5646;
	Wed, 20 May 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="DvuTCBf/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D43C3443
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271899; cv=none; b=Ujr6GcS4lBGRw90kVuzQKY27NV4y8kuPM8Q8vP5nMWb9XVIPSzxMcOe8HQYCYsbs1weAftDkI2XttyksJ1bS17ENVV/LtGxdrHdcZuPM0wghq7yb7XD9WDfzIjWHZpWHbUGq12bF4PimdK4xYnZnDuUHJgWZxrwSOfIQiAnMoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271899; c=relaxed/simple;
	bh=CdHNvdVyWwn4B7PYsPkfFQFpo97DkDkDhNP32go/344=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFF2+aiX6mf6eUMfARniuyZ3VtnQ+IW6QK1GX2S9PO9Z/6vCCkx+ZOg66DlmhPib9DWDTvsHUFmJlnKYdhuL3Oe7aSw8BqI4TjwhrdI+SzioXw7DIr5QcGS+lUIybsbifihXDFgDGgqEEuPVOOcRpheNDLg3vKet9dTaVuIw9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=DvuTCBf/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so68279605e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271896; x=1779876696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=DvuTCBf/pVNXykOdl0TBEj5Narv10saOlryIf6A517bJYJmMQ1tW2JZKfwKUwERSQq
         RZ/27vn2JCUHTak2F68ikWKRYMAqeotFC7dlhCVObiBfF/3CcDNSusl5XZyLwv+kvuIx
         9XD/ncgJwAEegdKieuZ2NLWOiF7oGljP/sD+QF6BiIzaJ9quICt/IPOt58/q6vEXs6xU
         v20qqhQTXc2lXrwXK5KOif6zdx7EJmSnAUUizexmQnxK+vK/BSTB/Kn8/zfRMrdJO2nn
         OVQChfK2sox8ksBRrqgegYiSG6kH+NE0UYgk1qlIb2AAXr68RUPR5v1WjugZP2ikh716
         V29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271896; x=1779876696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=Y6KVmF2YOW+BKJbxDXReCNwu7N1C2+wZRMjxf+FRbeARyPuYge5+2AjGYSkUcPXB5U
         pFe9JD8j6nN9AOOdl4EHHEbDc2VHJimVQqoXPmcY7v/27eVyRhNMvlinXrhXvIuqMynd
         7owqHfOupOwl2aUm+fWijIL8LRLUF9XcNrC4ZRFK9hLEtrockQkNhuconKAIaGhwrLEI
         JLNrRyYwHgZYiEsigOrKO0zFDQ+W1Ehy43PZlVQwzioW9dMwIo69uKfSxXtXOlZxi8Ah
         AqTUHxi7exa0ok6KSz8Snf9Ej9zjA/Ylk7JKJmOn5A/AUaStFwi0qDG4qRolqhe4KGUr
         8Nyw==
X-Gm-Message-State: AOJu0Yw8z2GCNn1kQUZCX+tMS7ZirJlSZH1Jwihs4I3PNgVBFLYy4L2D
	sTXZ6ysh5oH3sPRkFwMQ5V1PzvAWEYfmjS/CsKklmzev/EzsiaxdxilMEHSILaJDclL3TW7oGcs
	iWUQreNNJBA==
X-Gm-Gg: Acq92OEsEHCEg4QGcMaj3NET1dvyKt3DVjXkOuE5VvWeBp1mDoZuwsnbVQK2CBacdXa
	xHPvnHuJGyOKDexXlfhwLdEo7RysucaMWfcK7YYfUwwVAUTnF1+lV+/BrdIQuyEmxkfrD4YFw5D
	X8YSSh+9RRVg998iAE8sPY5X8SeLiOqLd8d6j/R42dh0K2g1S4s8pKdmKAmhtWTJrLlUKoh20d5
	QTRagLTi+CN9qOMR8xHicKI+FztEj3YMWx/q3q+fdyadWOSaf7HjVoSUjP0BPZ2nQGUmZoWHcEe
	Q4rwuqVAueE7tedypcS4G2Dufr5o5d4jjKUT+xHt4FFnoIBC1CwPGkTJ2znPHrI/IxLgSDqo97i
	k9sSNKpjoCfIL1pvK6KpO2cUfPBPo5u66LaNpqYTYyPpZoZiXEV+BUCLmhqisHHB01xBWFRQp9U
	48FtcFD9s1amHB8dwnu+OKXuisGWYX5ab/vd2978WBShw=
X-Received: by 2002:a05:600c:8906:b0:48a:5501:7995 with SMTP id 5b1f17b1804b1-48fe63270f0mr284986295e9.18.1779271895807;
        Wed, 20 May 2026 03:11:35 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf8305dsm187849295e9.9.2026.05.20.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:35 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 02/15] RDMA/umem: Split ib_umem_get_va() into a thin wrapper around __ib_umem_get_va()
Date: Wed, 20 May 2026 12:11:16 +0200
Message-ID: <20260520101129.899464-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101129.899464-1-jiri@resnulli.us>
References: <20260520101129.899464-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21035-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D948558B813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

The follow-up patch is going to introduce ib_umem_get_desc(),
the canonical desc-to-umem helper, which needs to pin a userspace VA
without going through the exported ib_umem_get_va() helper so later on
ib_umem_get_va() would use the ib_umem_get_desc() flow too.

Move the existing ib_umem_get_va() to a static __ib_umem_get_va()
and have ib_umem_get_va() as a thin wrapper that calls it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index b253090bb1ab..0056f23af57b 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -153,16 +153,9 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 }
 EXPORT_SYMBOL(ib_umem_find_best_pgsz);
 
-/**
- * ib_umem_get_va - Pin and DMA map userspace memory.
- *
- * @device: IB device to connect UMEM
- * @addr: userspace virtual address to start at
- * @size: length of region to pin
- * @access: IB_ACCESS_xxx flags for memory being pinned
- */
-struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
-			       size_t size, int access)
+static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
+					unsigned long addr, size_t size,
+					int access)
 {
 	struct ib_umem *umem;
 	struct page **page_list;
@@ -275,6 +268,20 @@ struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
 	}
 	return ret ? ERR_PTR(ret) : umem;
 }
+
+/**
+ * ib_umem_get_va - Pin and DMA map userspace memory.
+ *
+ * @device: IB device to connect UMEM
+ * @addr: userspace virtual address to start at
+ * @size: length of region to pin
+ * @access: IB_ACCESS_xxx flags for memory being pinned
+ */
+struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
+			       size_t size, int access)
+{
+	return __ib_umem_get_va(device, addr, size, access);
+}
 EXPORT_SYMBOL(ib_umem_get_va);
 
 /**
-- 
2.54.0


