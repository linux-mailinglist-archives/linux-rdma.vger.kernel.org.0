Return-Path: <linux-rdma+bounces-20813-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qELSC4JgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20813-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 995DA55F7BB
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3B1030185AB
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5801FF5E3;
	Sun, 17 May 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Ufi6NJ1X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381901F1534
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999415; cv=none; b=MQglRgs/iqNsd5bS4H5IaYK2TDc1Ec9R07K0Cane9ofGO7XW/Vi+MR/bak8Ts4nV2Ul+6Fvgl4twhPrf/ri6fADzaGNM6gvqFDLoC3CMHOS+Qh65otvrjs1g1XA15C9EOXGztK7UKjGmX4e6k5I1vRAr7OwxEHLrUZHYIdPH+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999415; c=relaxed/simple;
	bh=CdHNvdVyWwn4B7PYsPkfFQFpo97DkDkDhNP32go/344=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy6IJlPi3pMCQkpgk7WosnEBvnA98E07694LWVIJ6b7S36SQ3S1DZLbEbLc5sL8V4blNzvceqC/yVH7oUR4RR1DCb6uitBAbLDHqM5u/dwWDUepGqpX6KonQMHw2ankv7rw6RKzog2DVvcc4M7NVmlYk7WJ5xzn6IZvogOLAZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Ufi6NJ1X; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d734223e4so587824f8f.0
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999411; x=1779604211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=Ufi6NJ1X9Q9+foUAu03Ycj5b3zqdJ3bgYKmLd90/avTpahXZf3Xij+EITKSLyl9yo5
         oKpwF2HspxMoIQj/R6A09AdSn1m8crpMvIDvli88s5jMvHuj5O5UVdKGDJPVZEW9dQda
         At7/RNWVPtue+oCdiAJa74WW3cWB5FXI8WgOLNyMzWb6mSr3i/VclmyN/1vIYIZnljFM
         tM/h5jLMQt6EBbDNwirqLOMxkFIzerKczrG0w4sb3U8Kzvav4lB38gmXv6kmqMHrn8Hq
         y0OSjaZLsaCYiqHz4csB/XM45M6q1y7dWgvUbWjgDq4kolElUiv/jjv7Bg6uT+daOa6B
         bE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999411; x=1779604211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=BXhK31rxB4WyE2XLt4qoBevpJc8+aKwpARLUo2RBzyFDZJS5plTGrQFp2WF4HVABJH
         cnD9GDQiTU/POFALVFeyxoiqdzh+yecZnLpr2gHuBQSBvrTj/iHZxdi8aOyaQSa8GD4w
         osBJFCA0hKIrYguXdFcoq/LKspKD7gnAGXwWUS0+khHwMupSoAl6+E+JhKiTtEbr54T+
         MhHNqm3ZPie6zzV3nvqxotLRbae3Yvp+7kMfI3rk4ZNyw2uqVG8lS2WjOUlrgDdrcsYL
         PgO6yDmKzTQmYkq1afbb2XIUK6izxIqlgUhp5qYYKU89BH1dpIaF4H8Q+7Q/59K7UfwV
         D6Cw==
X-Gm-Message-State: AOJu0YwUuwVNZak0+N9sdsRXAmTLvjMofw6LcLECM5GmTKsRy6YTgcOe
	mXhzObbFi3BVAh4DDAxYbkgwvwyVM8ZbimvcfuaZEwO+vkKo4kG1TKcVkbvhrHsPe8MxiIUjf1B
	4Vs3SUAe59cxp
X-Gm-Gg: Acq92OGeypThejrXxWLZoO+14ZfMddbtdQsqgYxySYU54v7V6XOO0JRfWMGu0KrMcps
	5UM9d2XiT3Guy/qZo8+1AX2hBdT1TcjfzeaqkJcUQ87tjsE5TgIi7GyJUHud3A2COec0g58bcqc
	frGMHPF+FoyXXI+axX1sNKlhW4WxdjeLRj8l/NLw5wZ0nPobrxBJAy3NEOR9lBgotOGnBY3anqC
	9/lqkwdpLFfO39fNzu/2SDXv3UEglkB2OTKgsroKHw/uNktNeLvrIbxjmxVk172lvLQo43d9WWE
	XIsOaD7g81B3Bxy7J3B+wzyTDSPStSkxz4QqylBdve7yIv8C52Wd2FUMX9/vLfqeXuyVuwk63Mf
	y/ECm0MlORTUPCfrA8jq0URr6TEmOt8Q60RV2XPf7WdsBFM3JiH6XIFavbObQkANaVVaF/EW6o4
	9nMu+m9NWEhRMcXMBsA0jLo6UPw1aBoMiHX9Qn+ja8nZxbmvWYUccuRgw/
X-Received: by 2002:a5d:5846:0:b0:45e:733a:a0ff with SMTP id ffacd0b85a97d-45e733aa2e1mr2323161f8f.3.1778999411020;
        Sat, 16 May 2026 23:30:11 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm26505501f8f.20.2026.05.16.23.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:10 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 02/15] RDMA/umem: Split ib_umem_get_va() into a thin wrapper around __ib_umem_get_va()
Date: Sun, 17 May 2026 08:29:53 +0200
Message-ID: <20260517063006.2200680-3-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 995DA55F7BB
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
	TAGGED_FROM(0.00)[bounces-20813-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
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
2.54.0


