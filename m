Return-Path: <linux-rdma+bounces-19915-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCHwLUKm+GnQxQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19915-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9D4BE420
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39482303ADDE
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF033DCD95;
	Mon,  4 May 2026 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="eLYeYSYW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B083DA7D7
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903062; cv=none; b=My5cB6ajZMjZheCwtBCbn0MOo4ZZCNWH0T+CoBjQWjB0L2No+WZ7AM1q6ARDoXyS65AUlM5QFa81c7ojE4R5qBo0hnHu6+14G1sBtbUGy5qcfbdbv9LYuIWMpYVDnga6Uis4kGmgQS57xwYYDQimGJK8Qx1z0fyURz70puAhWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903062; c=relaxed/simple;
	bh=vw2WsyK8sp2voWdhyr4x3tSWHeuq8Y1S1WEtildlrzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjmCfRLg53Ca0xzwRKhILNSAMnD1Uvy8dHLAfOIHHkdJ/77KaEcYp+uzvgANrHE5MXBe04pvJikPnnyi6c+xXrq2X5EgY8Ci/mB56ikjxG7vOQDfXm52ysQXRNC8IysnCOADOliQS0Mn0JwU6Wst6RRG+S0u3hWKbAWFeU7ZYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=eLYeYSYW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d102471a4so7575455e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903059; x=1778507859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey9rKdUkQwZ9VbxSF2CX/c1pEU04OcTuCkw4449iJS0=;
        b=eLYeYSYWFB+aTj15R8C38obz0qW5mrIvMQnwk8xHUfT1S+mLuq/JyA4xCJ1CjgCfzu
         wUU/Il1Wk5yDzgyEBTl/bmPgFHD3d6immOEH6sB4ulDZl4nKF5yPrtUgsTrd2P/IZ9EE
         CHKQegc/oseG3zg6uZhk9qLWJOzB/tRW8yTS6PHB20v158e0qvDDiDe8JcjURqtST3og
         KhnuCMkldAT1CfqQ1i1+ioYf44gkpOkXrryBeVfEx+G5K7mN3QHNXqG/fxs1nuWEzfL/
         dw4CU3Wq8N7PZZWD6M2zqHHxAmY0OP2IAPzgxD56pm5avdVrKJJWA/bLsrDnv4NK6k7C
         H7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903059; x=1778507859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ey9rKdUkQwZ9VbxSF2CX/c1pEU04OcTuCkw4449iJS0=;
        b=hrrYntSQ3xpNevTbuFpPsO6Sn4bUkFy8qqjvltH7lXaat3jgHmIlWF+1wf1Nr7dqT7
         ZSqOao1EZe0WfMC4v38SI1hyKSX+q6xjQ8YKpykUbJTB9+k4BxIThVgS4ILwowKpvMmX
         5grDXYSEGWGfXrvaMAQSVLwHFjP/u3B/mfj9L6P5ScO2TlaQXPSOaYQqRy7keYJgFtNR
         29DZwtNNCFy4idd/rJJQzbbTvidB5glhLN2cIOPhwp64DVFwPJmN7dMb+UdoQVclp+Gt
         vqzGFRHQb29PaclMz2iESXIUIRAqieJ+hjOg5hLlGqxKAP4gCsGKjapY2vXdfV3+VrKw
         lGrQ==
X-Gm-Message-State: AOJu0YxL3D6s3fO0r7q+AR241Dzf+9N+9/XmgZIlPF+zwmSL5yLSbmBh
	CaDJnSymS7HynEN3rSv6M54tVPsov2bgD9scEA1OOOTm1jGyYx2pNK2XFrbhzEhxNFsWW+MMYol
	7twTFI5c=
X-Gm-Gg: AeBDietwG+Qf4yqzWM4ew9YofTQ/12lXsRjkM61vDpsXsDILTiS8BxtlS6IxiB8Dw4i
	ots/As7Hkwyktmfqwu46h3/em7aWl6VOHBcufdfWIJOej2cOFoVloPeQnAk6U3K7hSwQn1mT88n
	Kkv18i9rVbtOobDrJy7uZ9Cos7tR6BSInvX9FlrvaKVia+OIOSczVB9WUAXHtBd6IfDzps1uzKP
	odImBKlxQ/gQm+Ea9GKrujFzGsiKPSTJV3spEeMXXRobTUa1e4RyQXFmUL14MdryLeA17QpIy56
	vHFeVm8cRa6/oyzGG442dsrj+HuWqvSQJRKT9mHTXFTJa5T/mqAXh9kpn160NB055bsJi+BBSxJ
	+9Oio6wvMzE/qUU7FC1RvrYTifbE0SzzQ2hTLuRNbRC3b0hRxK1ZSSR71Luh2ivyEHlJmuixAJi
	JxNzgFchl9sBqoWtz5frSud0D95Cv3AwB6+Q8=
X-Received: by 2002:a05:600c:5308:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48d03b401f5mr101183465e9.22.1777903058776;
        Mon, 04 May 2026 06:57:38 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef1db8sm81541725e9.29.2026.05.04.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:38 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 02/17] RDMA/umem: Split ib_umem_get_va() into a thin wrapper around __ib_umem_get_va()
Date: Mon,  4 May 2026 15:57:16 +0200
Message-ID: <20260504135731.2345383-3-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: D7D9D4BE420
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
	TAGGED_FROM(0.00)[bounces-19915-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]

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
index 986f785a37cd..6e0906f0f5c4 100644
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
@@ -278,6 +271,20 @@ struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
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
2.53.0


