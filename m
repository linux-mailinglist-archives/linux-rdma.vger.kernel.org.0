Return-Path: <linux-rdma+bounces-20844-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KrEAQfNCWq2qAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20844-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:13:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A55AE561833
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76FFB300C922
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E452F8BC0;
	Sun, 17 May 2026 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="bRN1KpL0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B9405C32
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027203; cv=none; b=fWGGCfP6i30aGYuJJF7lnJgopNqg5nY/IbXYj/BkS/6zEoECvKXm72Dz468HDqPXi1ocTWCb+blEyWhZMEafTluB3/QRhGbJ0Mu7Evkuji6HOWOkWUx7KXEMvBIegdyXwMRp17xT34pP4cWF/aLlVXf3iP9DE9GCazpcJI8kRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027203; c=relaxed/simple;
	bh=6m6YIr4qgjNXffSdZ6U2AVugfbXcYRTrf7zjU2IdDcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kByb/wAa/d+FsT8mec2RO7W4zMMZqbacHyRbRZJGHRK4eSgFlc8ocMCY3vCvTZsCFO7yECxITdEEiOz3pUiS3qOtC9pcosnxfqz7hGyClvEV/OhKba5+3YEquRmpzkt2Zc7WgBavE1yzXWWl5Rc1WIAm65HPnn7RRrn+Kp8QNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=bRN1KpL0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488d2079582so12859315e9.2
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779027200; x=1779632000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCJEcohJq7ptWw27jUXsKU5wYWZet7K0eamxTq2gGRc=;
        b=bRN1KpL0ojGzXZC5UXxATQLIvwpO3vzAECruXu/gmGYYliPxw9d6y43ZduGFPgrLT4
         P7kW4XsW/z7kOVLa+i5n9XehEiAFOFo4j31X4o2FDMx1jhgW1EGrynXkEjppTGh8BkYU
         pRyibVHwbGkmOiCrmmrNVfNvDM+yTft5DnCzfZ9AzDBtjzUvbVCYrmcFQ13QptkDFoP2
         C4lC3pnRICcFxwy46DBOy8URfmifss3+QbiLviLoDal1VjYoRhDqzZS6NayPW8a9I7fk
         SmNhMMxkLsItn73ytDYIw1YgPi04mGoipMgjH30aqj3z7g/xWqnQ9AkZsJ0F2vbz60kq
         AYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027200; x=1779632000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCJEcohJq7ptWw27jUXsKU5wYWZet7K0eamxTq2gGRc=;
        b=ITSD/hLrQlTYUSWmGV74TOQibOBl3cJ6sdmb6m4lsB7SSTR5YyRvLpypSkJdlLdIKl
         742DKhIITJzqUW+e/8eOkFt2UXW+vT4e49o88h40tHS2uxss4lAUGATiMUWpU8yC1H6F
         IWRNSP7RMt1kQXwDTOWYjl/AON5heRj/cZ0BET0FS2MZCytHCGdoaUnK+zUvsOkbzyrV
         FVUu6pmpWW1ov46tNZpBwmH3yQIVTt3Q4+mE5+b9BmVm1kUNfHyRExmGRHUDfd0e1kOo
         nOJgzovNsOnr/DdYlZx0Xu1jOxWvNeECbDqGGri2omegifv4jKTSZSR/KVezcFcfYW6e
         cIrQ==
X-Gm-Message-State: AOJu0YxnV+CW7Zqu8vWfjEL2eFkKgqCJMdIMvtEVCYLRORRdMjXzhsty
	wPZAsDj9M7cW/2c/4S9u6XoZXTdWiHETw7oN+/8JMrTEaK6ijZESjTomS6fYPgI9OQw0k73hh9V
	GhWo8E2uLKbdc
X-Gm-Gg: Acq92OElm/0uvWxn0F7HMxKZQmxQZWbuZoy4TYLKkS1hrrJ69Xq4IdJKVqG+6KEl55U
	xPXY4FcP8xx57TFcP581iVemAfRiH/AS7gSGxYBQBxc6O/xhoI/Pr90vHFCXJ7KC9DACBJGuM9l
	IHWsOSQopBjbH/ukR1ZlSK3g2/mCEvHmwKk+2v9bOge22D/d+Jr7By0UlQd7QLwEiZFLRdOFlMc
	W6cEtCqfK4sCzzrmO/p4GdM3DvHKjTudJcWIJ6kJrgqL4umTjCG81pOG8Nr837gk7GQxhjFWWH7
	TJo0msslOsMEPBODXM0R/ozHGrUAdTnUTniW3XgU95eW+59uVvTyZlj9kPMlqiHos3mLsCBmwZz
	ZoP9ntpBfrCUkouM9VRP1/Bl5Kl4cQDJSmWd79CtL6VmA0Omk5TUIxl/kgZAmzIA9gWBUBr6GJm
	XbCl4DFfIwxh3CgJZ/QE2G4UkGFaBDj/R8ho1j2WX4GNMsEsRSRcC/Gtuuj3nC0rw=
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe60eb0ebmr184726635e9.10.1779027199659;
        Sun, 17 May 2026 07:13:19 -0700 (PDT)
Received: from localhost ([2001:1ae9:6084:ab00:4146:8430:fb4a:baf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8d39esm195384085e9.7.2026.05.17.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:13:18 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 1/2] RDMA/uverbs: expose CoCo DMA bounce requirement to userspace
Date: Sun, 17 May 2026 16:13:10 +0200
Message-ID: <20260517141311.2409230-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517141311.2409230-1-jiri@resnulli.us>
References: <20260517141311.2409230-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A55AE561833
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
	TAGGED_FROM(0.00)[bounces-20844-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

In CoCo guests, guest memory is encrypted and untrusted (T=0) devices
cannot DMA to it directly; such transfers must go through unencrypted
bounce buffers. RDMA registers user pages for direct device access,
bypassing the DMA layer and thus any bouncing, so registered memory
does not work in this configuration.

Until trusted (T=1) device detection is available, conservatively
flag every device attached to a CoCo guest. Expose the condition to
userspace as IB_UVERBS_DEVICE_CC_DMA_BOUNCE in device_cap_flags_ex so
applications can avoid memory registration and fall back to copying
buffers through send/recv.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- Dropped is_swiotlb_force_bounce()/swiotlb.h; keyed off CC_ATTR_GUEST_MEM_ENCRYPT alone.
- Added comment noting T=1 detection should narrow the check.
- Rewrote log: dropped SWIOTLB rationale, explained T=0 assumption; fixed device_cap_flags_ex typo.
---
 drivers/infiniband/core/device.c     | 9 +++++++++
 drivers/infiniband/core/uverbs_cmd.c | 2 ++
 include/rdma/ib_verbs.h              | 3 +++
 include/uapi/rdma/ib_user_verbs.h    | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b89efaaa81ec..21ada0fe9059 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -42,6 +42,7 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/hashtable.h>
+#include <linux/cc_platform.h>
 #include <rdma/rdma_netlink.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
@@ -1419,6 +1420,14 @@ int ib_register_device(struct ib_device *device, const char *name,
 	 */
 	WARN_ON(dma_device && !dma_device->dma_parms);
 	device->dma_device = dma_device;
+	/*
+	 * In a CoCo guest every device is currently assumed to be untrusted
+	 * (T=0) and therefore subject to DMA bouncing. Once trusted (T=1)
+	 * device detection is wired up, narrow this check to exclude such
+	 * devices.
+	 */
+	if (dma_device && cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		device->cc_dma_bounce = 1;
 
 	ret = setup_device(device);
 	if (ret)
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 8eed017091b0..2269f636bf58 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3579,6 +3579,8 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
 	resp.timestamp_mask = attr.timestamp_mask;
 	resp.hca_core_clock = attr.hca_core_clock;
 	resp.device_cap_flags_ex = attr.device_cap_flags;
+	if (ib_dev->cc_dma_bounce)
+		resp.device_cap_flags_ex |= IB_UVERBS_DEVICE_CC_DMA_BOUNCE;
 	resp.rss_caps.supported_qpts = attr.rss_caps.supported_qpts;
 	resp.rss_caps.max_rwq_indirection_tables =
 		attr.rss_caps.max_rwq_indirection_tables;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 167fb924f0cf..d06071b87d96 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -275,6 +275,7 @@ enum ib_device_cap_flags {
 	IB_DEVICE_FLUSH_GLOBAL = IB_UVERBS_DEVICE_FLUSH_GLOBAL,
 	IB_DEVICE_FLUSH_PERSISTENT = IB_UVERBS_DEVICE_FLUSH_PERSISTENT,
 	IB_DEVICE_ATOMIC_WRITE = IB_UVERBS_DEVICE_ATOMIC_WRITE,
+	IB_DEVICE_CC_DMA_BOUNCE = IB_UVERBS_DEVICE_CC_DMA_BOUNCE,
 };
 
 enum ib_kernel_cap_flags {
@@ -2950,6 +2951,8 @@ struct ib_device {
 	u16                          kverbs_provider:1;
 	/* CQ adaptive moderation (RDMA DIM) */
 	u16                          use_cq_dim:1;
+	/* CoCo guest with DMA bounce buffering required */
+	u16                          cc_dma_bounce:1;
 	u8                           node_type;
 	u32			     phys_port_cnt;
 	struct ib_device_attr        attrs;
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 3b7bd99813e9..d2aeadb6d2f9 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1368,6 +1368,8 @@ enum ib_uverbs_device_cap_flags {
 	IB_UVERBS_DEVICE_FLUSH_PERSISTENT = 1ULL << 39,
 	/* Atomic write attributes */
 	IB_UVERBS_DEVICE_ATOMIC_WRITE = 1ULL << 40,
+	/* CoCo guest with DMA bounce buffering required */
+	IB_UVERBS_DEVICE_CC_DMA_BOUNCE = 1ULL << 41,
 };
 
 enum ib_uverbs_raw_packet_caps {
-- 
2.54.0


