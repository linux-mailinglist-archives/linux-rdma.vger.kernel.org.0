Return-Path: <linux-rdma+bounces-20065-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LoRDsci+2lvWwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20065-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 13:15:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C716C4D9A48
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 13:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E15EB3018ADD
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC132402B9B;
	Wed,  6 May 2026 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="A4ELac1r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0E421A1A
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066093; cv=none; b=g8GJusW7Y7mcHcuYebcXxvhhGnt7eWUfZ4WDOb4418hgh93RB6+F19Iu+0HkrAo8OawAoIbormbMNlF1ljia6pTBgMIXgL2rJLEXb6iGwxzDqZxLP8U/8ocZDh63IEbPhIfBkTUdF4ciEmaL4/+E8fR7qWMpd+Buz6ZEoUxyjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066093; c=relaxed/simple;
	bh=wTHHWR8xnN3+8MTTxzKkim/R71uDYVjvpK3WaWzElBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGNio6I2e1TBIbrLVXzU/V+4g6Xt+zv5eu0bW/ypC9zmPbxnU6o2ZvN59v3TzmQc+v/k4buz2ycjE85pOFn5erIL+ibMDDY/qkNaFvuCFOg5Poun6xKXnCBgURLKOFk7Q/LAGQje4mixy91oiWq7t3aYu6SJf1nJ369HbRWbHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=A4ELac1r; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d73352cf2so5759188f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 04:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778066090; x=1778670890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgv8Nu4lwCwl1JcWgOpH3eoML0uI5ZuiaWITMWsA420=;
        b=A4ELac1r7tVz8h2gLX6IWbMTUFhqaMsXKjspfypJBhOhcLo5DcPT6qJGhg9oYO7Z8w
         pGmFc7vFX2b8nMqeSDaCUWA3Ro7jeotiRRHBSLolJVSYw483rYbD9lOwPGMWSYTGlW5X
         gcaDBz93d2057p1B0r75tq/CPD3bn1TW9r3DFQ4/4j9QeIwaZ1/ZYC2+CAj2eqPT7Udm
         EUaefQffioNoBg/XgYmvP2aWxMEEg6KFCrW7lkUIM4qpCkpqHYNXH1F0lPJiKK6c8h1c
         +RCaehW9B3z7wSoZlqX0S98f/Pk0dJcCp07Bj0R14zgRZo3lNuq4XUm0keXTVEi+8mlS
         70pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778066090; x=1778670890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qgv8Nu4lwCwl1JcWgOpH3eoML0uI5ZuiaWITMWsA420=;
        b=mLs2g4M2HBNqTlpC3NLS7FJvVfn7xPoW/2lK+h9V5uOzHL2KWxXkF9sv2PG3K1pgxn
         NRwRTqAuK6Czf/fgGVRt8k5SmRsOj/64Vq2sYg8TkWd4M/Ea5b8YsaBSqR4Bb+1mQIfx
         nUmdtybCl8FlthkGiIMDdv3PFsfN2atUtilnOBGH+5lBPJVYbFZ5BcBItHY4QNq6K178
         8IXJeyCBYsPT1bwmW2ZQVkC4kQCBUT9lA77i0uNRjChIJWrs9hN1na0giLDlNdlr+W4G
         oZRZz6qlbNGoC7eWeaeYIl/qLbpCdGyisRLgVksSiGUiuapAYMPEtMvOm/AIS80+n6Pw
         5S4w==
X-Gm-Message-State: AOJu0YznU+tPHsy1M2Oi/JHw4jggKqrWSORkEYjL+pwuGHWy2F10I77f
	VOp9PzNka8vny3zOQ6oKr9RmYubcn3E3mFLTj4nZh4aKI5hrZrauSNcwxSw0bs/JgRWOFxmiwij
	d/kfYTVs=
X-Gm-Gg: AeBDiesT+tUnwJL2HjclfAw5B3aYtNggiakZ+pIwjvjOturZQ7JEEJOohHHsspLCDJ7
	LjZ0qs0HawuW1X2IiANPC/5/y0I8SbMZMm6P82y/3TuNO0ZGNL+aeeES1rdxU/R6aUlaskwKcus
	f77fcKX2CA/LPzZKtFQ6Npw3DKbETPVhQ9mB2o0yCpqx5Qy7YGX0nwG4CQ0WJn380Ru8dWn3TTU
	lIzQNB1RcMrlGWIkXxdiHbp07dqt0Ctg+fjVyhbg8XWWKHwu6UfBxJWG0dgsrKp12PS2mOCf8hU
	+SMDoZ/3uzwIiXxCnZ4UYQx+itQlvjRb9mAxYi+wKtGOnhIVC1pwV2zyA5cs3L8IV7f8wnuK91f
	heXoVQAglzlgmdBDttF0Zkn3OvDkIciQ1JqqOM3ZEeRl1HL6+5ZLfrW+PlLe1V4Gt7+vezmmmKk
	bdYp0LOp82GD868nHcJ8lLg1lb
X-Received: by 2002:a05:6000:61e:b0:43d:7e6f:3816 with SMTP id ffacd0b85a97d-4515d9a05b5mr4879726f8f.40.1778066090280;
        Wed, 06 May 2026 04:14:50 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2487dsm11994769f8f.35.2026.05.06.04.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:14:49 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 1/2] RDMA/uverbs: expose CoCo DMA bounce requirement to userspace
Date: Wed,  6 May 2026 13:14:46 +0200
Message-ID: <20260506111447.2697789-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506111447.2697789-1-jiri@resnulli.us>
References: <20260506111447.2697789-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C716C4D9A48
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
	TAGGED_FROM(0.00)[bounces-20065-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Jiri Pirko <jiri@nvidia.com>

In CoCo guests, device DMA to regular userspace memory does not work
because the DMA mapping layer redirects all mappings through swiotlb
bounce buffers. Since RDMA devices access registered memory directly
without CPU involvement, there is no opportunity for swiotlb to
synchronize between the bounce buffer and the original pages.

Expose this condition to userspace as IB_UVERBS_DEVICE_CC_DMA_BOUNCE
in device_cap_flags_exi.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c     | 6 ++++++
 drivers/infiniband/core/uverbs_cmd.c | 2 ++
 include/rdma/ib_verbs.h              | 3 +++
 include/uapi/rdma/ib_user_verbs.h    | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b89efaaa81ec..ad3da92c9318 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -42,6 +42,8 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/hashtable.h>
+#include <linux/cc_platform.h>
+#include <linux/swiotlb.h>
 #include <rdma/rdma_netlink.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
@@ -1419,6 +1421,10 @@ int ib_register_device(struct ib_device *device, const char *name,
 	 */
 	WARN_ON(dma_device && !dma_device->dma_parms);
 	device->dma_device = dma_device;
+	if (dma_device &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    is_swiotlb_force_bounce(dma_device))
+		device->cc_dma_bounce = 1;
 
 	ret = setup_device(device);
 	if (ret)
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 240f8a0cfd86..2a70774c639a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3655,6 +3655,8 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
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
2.53.0


