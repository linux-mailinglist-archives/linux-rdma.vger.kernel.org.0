Return-Path: <linux-rdma+bounces-21308-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLp2IRCzFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21308-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:49:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F8A5D7EA3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DB1A30475C6
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140A400DEE;
	Tue, 26 May 2026 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="do5xJ4HM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073503FFAA1
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806536; cv=none; b=bVBm7YiKOKHoREEJlcUZvp8q+UeKtPfrioejSaBhDkcPh80OGr/+pdYS96rcewFrHesszco4jt3XZoFHJavUkFU0l7+KalcLp3hvWx8Tsz41gQtqJUESOcWzuW++eW574z0Ey/bDWIWbjASeU+wZ9xVGaFIHXuLahgqssQtx8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806536; c=relaxed/simple;
	bh=PAJfEZZOVghBO2jkx60ZdGhbdxqLodCwY8cRrgeUeqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmgLXtkY7/bhacAsK3etvW8bc7vnDSEHRUDMZd/42uJcCYSr3jMy+2NdeJ158ZowRXwWsIuURBmcXI2mr84euX+E8tNPNbUPLqL3DdTdOqHKbBnMlbvXY1tVIfKnllxTU1n9o7n9EmILW0oRGFB+BclWdoNJV43sQBAz4SdvSSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=do5xJ4HM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso5943406f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806531; x=1780411331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HStQRlhmD2dLtEbEgDjhXzVoEiRemktVvUpUDAAyEgc=;
        b=do5xJ4HMRIuYZ5O4nzoGvR2YxN8p5cxQ6DoyDG3iar5avaWWShzRy1mV9NJgzEef6T
         r8FJWds3Wv3ZeRSO0alfjDN3u76F588dP8Th/WzDUd2Z48Pi9BEfsgTpFIy0nThSNT/l
         uHGNo6dMdix8dIpyKlFEMvDijglTNqcaJjAFZIy6+L5dP30YWTZMXmqR+wUhtyGo5Lgv
         C0/YTGgxsoAjIcms77RG2Aalupb5YVviFYege2sQdqLkj+y9GeTFv0G8/tdEV3tV1IxN
         dX317dn0cykQVH9GzK1uea9lyZOI0/MW4M02XruG5GarjY4OVIpLq+x5BAVCnRfvdgcV
         G5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806531; x=1780411331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HStQRlhmD2dLtEbEgDjhXzVoEiRemktVvUpUDAAyEgc=;
        b=CetSDe2P4vU+UdUfal+DV1UHdQ1Z9iu8miCIy2RN/wPTfajTqNXDae5DfOVxzed/6v
         GfdpqWErJXn0cD00FwHXYksRDE1aZs3ImxtyGIsswqjh7Fez4ZVe7GJ/plRjiG53VMks
         bC6jwTXRYUfY829Uqyat6UOEBP1fO/N6aRcJY4mrkk+2iqFstGFRnP2XuFQai7wEBxuF
         Hs4CufwH2dbgJY1k43bnshDi0yEm7X9P3Iz6sb2OYlksQ4zHKQciGaX0XPlw50ki9xoi
         2YPagdCzVmjH7oipYeo8QYOcmkbL3E6+W7/sTX5KjEO7hzpRIiA2OIeq+ZNt1gKixMGF
         Y+sA==
X-Gm-Message-State: AOJu0YxZFcljBChSfLc9/xpOKiwRmEchPPzgZkHMSWgsLW8/eTJfz2HK
	IYojLH1pZW7l5QHBpQTAiZwwbi4yvCjatbcCFfqL5lSX1QCNnEZpmFc6FV9OHqOo/6s9p/z+wb0
	/Ok+hTMyimQ==
X-Gm-Gg: Acq92OGJt/rE8fO462T8tuZx38M9hbTtsIWHcI44uOLx6hOUX/poXp4hoK7Tp9PUpP5
	y+wo4v2R9gxY9RGApXtfZvoWYpnUPNoN91ul7m5ikonLPfbj667Ks5soFEcNfsiyjV05H5wv/98
	SSJ2Y4Vd8HLCtcgbiBPF2mb/Y9cw6MhqTJ78DJGjuGvjZ4lDtNJHSNhnz1O+VYuRdGdJzHcDmJY
	3IuguJL7gORN2yon+vyMl1hI486ienmDZvA5uVYssT7ns2GvZoRD950uj7nd7EQsdHY9PtWGtt9
	NXjVgVeH7XM7ifStPg8g8bUuIOUjTJweCjPS2RKDvwYgNuWNFNKO1/T7rOSnVTCpfUSuyw5Uw+R
	4H6O+SMAefzA9UK9OIfJb7hWWn3+48Oj9pcqqVfmEj1rwfxwanBAjnZRedDO2Eka4wsIFBdHwDb
	QMfYRmovVwG1HSFV51BIOz2A+dccpNXXsa/w3Ey+HIx9Iy//fVjcskdw==
X-Received: by 2002:a05:6000:1acb:b0:45a:c97a:905e with SMTP id ffacd0b85a97d-45eb38a79aemr35731745f8f.1.1779806530984;
        Tue, 26 May 2026 07:42:10 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb9asm39039142f8f.27.2026.05.26.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:10 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 04/15] RDMA/umem: Route ib_umem_get_va() through ib_umem_get_attr_or_va()
Date: Tue, 26 May 2026 16:41:41 +0200
Message-ID: <20260526144152.1422310-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526144152.1422310-1-jiri@resnulli.us>
References: <20260526144152.1422310-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21308-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli.us:mid,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 24F8A5D7EA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

ib_umem_get_va() is now redundant: ib_umem_get_attr_or_va() with
attrs=NULL and attr_id=0 covers the exact same path. Make it a static
inline wrapper instead of a separately exported symbol.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- rebased on top of ib_umem_get() made static
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c | 15 ---------------
 include/rdma/ib_umem.h         |  9 +++++++--
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index a84550eaa026..ee31c8c87629 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -430,21 +430,6 @@ ib_umem_get_from_attrs_or_va(struct ib_device *device,
 	return ib_umem_get_desc_check(device, &desc, size, access);
 }
 
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
-{
-	return __ib_umem_get_va(device, addr, size, access);
-}
-EXPORT_SYMBOL(ib_umem_get_va);
-
 /**
  * ib_umem_get_attr - Pin a umem from a per-command UMEM attribute.
  * @device:  IB device.
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0f373679ea81..908eafa52840 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -83,8 +83,6 @@ struct uverbs_attr_bundle;
 struct ib_umem *ib_umem_get_desc(struct ib_device *device,
 				 const struct ib_uverbs_buffer_desc *desc,
 				 int access);
-struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
-			       size_t size, int access);
 struct ib_umem *ib_umem_get_attr(struct ib_device *device,
 				 const struct uverbs_attr_bundle *attrs,
 				 u16 attr_id, size_t size, int access);
@@ -93,6 +91,13 @@ struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
 				       u16 attr_id, u64 addr, size_t size,
 				       int access);
 
+static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
+					     unsigned long addr, size_t size,
+					     int access)
+{
+	return ib_umem_get_attr_or_va(device, NULL, 0, addr, size, access);
+}
+
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
-- 
2.54.0


