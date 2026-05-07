Return-Path: <linux-rdma+bounces-20142-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE8yGzGL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20142-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CB04E883E
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CEF7300EF91
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83E3F0AA6;
	Thu,  7 May 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="siAAk3Y6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935C3E92B4
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158358; cv=none; b=btL6ftla8EZljku7gSrmmPvRTD9AhwJDLNFQHQcqiXpbQ/hpo29cRHoButmJIATjo6XEibEX3iG+OIN9tsnz7HNqxmIT+pAFvMuLIesnu5AB9dypCX9MLN3nSBiYWSXo0rU6IL4pe68IIpmrf48I8r60e9si41egFAYUcwbR0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158358; c=relaxed/simple;
	bh=JQ/S18U5nMe2FTxM59cnzhYFw1VtNt4nt2w878D3P30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxgYUqjiQ5Bl14WPmLldHJ4sDlqqGehlSh+yIRP4dDYsxxn9KUGHEzZeUtUCUEN+t5xZ8YIueEaAxEB6ZcdiBRzkabkoG6kVhTDL2dE4zXe7Snl1hxF3q2RDwfVUT/Vpd2qVmeJs/0Jk6NaCVFgHp1Dd7BALECxng4YNadG56+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=siAAk3Y6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so12049535e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158355; x=1778763155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ6phLnLq5MHLF9hmJE0j59zNtUjERkzOzDe/cDq9B4=;
        b=siAAk3Y6/9aNbxCiGbE+l3UqDXEvbqc6MgdXzcIIeNmwf4wqqRcmDtRubXIrygHOVE
         pbfkVN80BXD/qzN8OQNa5dLoat/ktsaxRw5FWZeOlANhNFErckXKaVmgNq8hzE9WTbvS
         IKRKdlZ6twnGSp4OBSQErCYI/KGl2HH5TXYdmQs/2G/2Z01IIxFU8M5Dn5ugD5A4aT3k
         yONeO11thj+7l4WFl4zCGse/9kaaz5QQS/hNF6Fwns+SZE27No82wB1oCOEwpvzUlvaC
         u7jPqvPnkAjeEtICjt8XfvQbHzX7Df49IUBwQbRTZFWE6m2WEJSohY2CiQJjcOopdLa4
         hNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158355; x=1778763155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LJ6phLnLq5MHLF9hmJE0j59zNtUjERkzOzDe/cDq9B4=;
        b=Us8HpoP0HQok7kSzp6f8oEt9mZp9m/RLe86FI0ICVRHb+clyAq/vRp8JqFeJgT/icM
         I7RHQAx/nwjIbIj4jASmRmlVErAms5ACqFyY1xEZ7dotPPFTh+Bxfi/pzdG9zBBBY9aC
         PDS7K0pMQqKobefxdMHcXGgwQlEBj1NgwZuyzrzVlEsaZ2BWC7Kl6eZEaZrZIT/IYVQ4
         tpCWihU+n/qy/w8/VBd2JtkcDpsPcEOUp7Bo21XSEjJi3JyGNRwdB9CpGJMq/Es5u/4h
         jGR/ZBEk6J321U9W0IHI8zzGSHuepnpWKruY/mt/j+lCr3hE/cv/vUWzBrljc33JanlW
         k2vw==
X-Gm-Message-State: AOJu0Yy8bWlyZCJ165llzEKrxMNZfoaWMrQvV2rxzdUCTTqihdn/J028
	hhcn9iv3VxLY7vnu2IPSwIuvFM+aVB3jW2TL+go/WFHH561JaUbjfCD3D29NQ7S6YIongQJ7Ysc
	YT8rv
X-Gm-Gg: AeBDieuYsRbZKjuiktrvwzD4MOOR93PltdUHDli7Q5BB3a5wru9fYtrH1Pi5XXVNo0r
	lWpXAi9bk+BeBOAtma0ZAvAlFUmOfBs1zsM76TqqAYcBcmCdhKydKA+xa1KjLM+GrW8H+72EYXK
	88phLI4U1EdZ/NhWD3JAg6Ji9w3GyXmutCUCVO0B/c+TUX/nlF+PPhks+irUHfLnsk7nNgJzQUF
	XTTZNox8QQPzeftMFI2UWIrIKcBRNxO48+DHSd6LvJJyNpX1SBD042OTVEkigcRcKe6xhZwv6oi
	RbCHLgH20Rx0JG0y9WdsXApwBzYb+Flxx24VOPPX5CBsHT0g4V3WlSKz15oDZm4YZ1bsxFWsDIB
	lx/o84ptTpIqt5mV0CAVR3sxAiZ2Q7tCkyIyjRMga9CxJfEFYmMGtWac4B89ufs6ha9qcuSA6vb
	IidB/KcsQMS9I54bCx+d4T32YlnJTxRF8kzD0deqKfFLG7+UV3i+4x+zOx
X-Received: by 2002:a05:600c:8b65:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-48e51f4e5fdmr146719575e9.28.1778158354746;
        Thu, 07 May 2026 05:52:34 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5314b989sm40411995e9.30.2026.05.07.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:34 -0700 (PDT)
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
Subject: [PATCH rdma-next v4 02/16] RDMA/umem: Split ib_umem_get_va() into a thin wrapper around __ib_umem_get_va()
Date: Thu,  7 May 2026 14:52:17 +0200
Message-ID: <20260507125231.2950751-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507125231.2950751-1-jiri@resnulli.us>
References: <20260507125231.2950751-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15CB04E883E
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
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20142-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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
2.53.0


