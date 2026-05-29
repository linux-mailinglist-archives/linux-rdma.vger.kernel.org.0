Return-Path: <linux-rdma+bounces-21502-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BeUFUaZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21502-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:48:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A878960310D
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF186304503F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F7622425B;
	Fri, 29 May 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="y5h4RIWo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94863382E1
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062206; cv=none; b=lurq9FCtUe+Tq+JxjQJDN/5pa2Jzzxb/kZwNEEIN6/Ka+DgT34j5MaS5l5YPWlTIckKDMqbEXb5U66MlZRVNdb2S3E6c22EBSxI4u4RsRuwjIcol0wsMZn1YC8/iT+SiO7bNhqnythsNu0bEgSvmMLzcVHyeMBg7jW5NLpjgJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062206; c=relaxed/simple;
	bh=CdHNvdVyWwn4B7PYsPkfFQFpo97DkDkDhNP32go/344=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSdmMRxPCiPS1ONynXm9v6+THpx7yqMUPBxG6K6nNC94W2LG+ywl+v1bpO1+uYNsQHpw6N9rtVd6boJIzXFKa2jSZ/k3FJKsvLCXAQXM2Po+VGaHXLK6pZzDx1SxHyyJpj6rhIRiSnr7UJ+9K13n9zwTKBD2VpoxdXEiXHvMpqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=y5h4RIWo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso82835045e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062202; x=1780667002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=y5h4RIWo05eyBZkHWGDjNCSGJRKY0b1YomyEJ0H+GiOwiWBkf6iN+3+4lMvo6f8wx6
         PH8axtUw4HmQhr0TK3yGtaJ0aAf7l2wIKMWA8+Hys5NGGteJ5emzlqaIn1rmD4dZ20s0
         4CX2TQIjHTKqmtS270za2XDGe5CJJUxSmeXPFqVkvxtw/4OgXxeLd/0XexM169POSNj2
         YdcPoDb5E7HtpgzO4tNh01JX0vDn++4Dn0R309B5VMD66CF83/fuQVBSDXVgLpmnZQRy
         8tTp6H4Nz4GQ1DPSDI/MfZPV+GC3FTgxtHW7VBdciL0/p8nFe1vt9PU/DUXLbgelQvPN
         h2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062202; x=1780667002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=etDvYS2FkXgHCudAcx967Zy55pAgoUPToIIrDE4ARwlV68jCN2mPzFZKtBDsoGDWfb
         YXc/19N0DsA94kWJxtvTVUbv3s12TKRBrpNYDFF1HDyEwPxKB2mg54luf3SjhprAb3np
         /aXmBzoDYfIIkN5bVeyZMpjBUZK8Y+LqDXO7a4f73mZh6jknkLUKFoRYgowzaB96hAJD
         p9IYs/Vo3SvBryEqxiJ8gFFh/lB4E0q83S7pFiSBHmdsgtXMUkcbGAxd/kJzh7WQuMo3
         WsyfY2FBXW/G1UUtTThZVUzG1L9KB3040+KUS6DgdLu/J/CpGu8CDaq60b5iZB6kNuKg
         7Ucg==
X-Gm-Message-State: AOJu0YwWcBuB90SQnXm8TW46lJT4qhKK3cfJKjNwQkIZjZYdL/EWal95
	k0DB31tBgBJqexa5H9zKqP+pG6qjLlZmbfUFBGJvmebl2hcVVMCv84R+kfgfGodndzBflDgh5nu
	7AItRr8AcqQ==
X-Gm-Gg: Acq92OFcuRD5NuSDPQSwg3p/RpR9yFgLJaVAJ35zRgq4UmqOnG8GdeFeK5r30RpudVY
	AaKG5ig+rh2ipLGgKImZ2s3by3aMV5xsRo3/4NVV8cOnjsHemwvLELy9ne8uh9LHbGfULcT/In7
	ulkv/IxZaFq+UMDDCoxS3JAIAD0xjOlXdHNIVYTTXa9iifF/tkIy85sM750T3uNmSReWbhVjuka
	6iBRTVMIgAG7omou2Fsf+mcqj5fH6mGNBWKBfk9+PNw3OKvNGL8BqkDAIbLVPW+tfVZk9+AxAnY
	IvVDU/pP//XNxU/5+rOWGDuw/Cw33N2llwgKHYOEI8CFjBFfGcAtdBLUd7qNYwV/e24KAXnlWT2
	FNICCxNR7C04xb6N9O6XTE8fqS19EgD8kxFFiOYYrM0zyJcd4FJgxf1K/CgEo0nnGX0cT1zxrc6
	GWWPOaLWwJr+19WttbCeKDUwPvUpQAnO5k58LAl/8HQ1k=
X-Received: by 2002:a05:600c:4f53:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-4909c0d7a6dmr52610295e9.21.1780062202129;
        Fri, 29 May 2026 06:43:22 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0d4f4esm20231495e9.1.2026.05.29.06.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:21 -0700 (PDT)
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
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v9 02/16] RDMA/umem: Split ib_umem_get_va() into a thin wrapper around __ib_umem_get_va()
Date: Fri, 29 May 2026 15:42:58 +0200
Message-ID: <20260529134312.2836341-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529134312.2836341-1-jiri@resnulli.us>
References: <20260529134312.2836341-1-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21502-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli.us:mid]
X-Rspamd-Queue-Id: A878960310D
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


