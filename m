Return-Path: <linux-rdma+bounces-19986-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIG0OYuK+Wnh9gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19986-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 08:13:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A24C71E9
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 08:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52E373043D7C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 06:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B08E3CBE74;
	Tue,  5 May 2026 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="uK7aw2E7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561B3C8729
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777961521; cv=none; b=tAWPdyl5MVHIRJ36Qlu2TXEk/G2vC9lr6684/BQLejLX2pXDdlW/ot31S9oiMPjJ0dcUtEsw+08FfzpAVTvxsJ8IaPhRHI2hjIosQTwn5DGONN/yqL5RRKz6lwVrH3Zs7OHYpt8as7/WW/QZi7baMwtKnXO337bF60fEPREgbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777961521; c=relaxed/simple;
	bh=wTHHWR8xnN3+8MTTxzKkim/R71uDYVjvpK3WaWzElBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqy18nG6IsbXAFXpqSG9/YiY3IaZVnIN8ACInEpq0qzTReoDNy1PvTEdoSBzoU5LVUL2gAyLzmFIdfpPwUhEN+osNE9Ih6tFh2cTBAugFXUA9tMlFDa+5UYCm4Yb9JZ5OMHi8fO7y6h8uBl8HODLtkqVe7FaIp+Pw3TOcGqIWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=uK7aw2E7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-445795cf6f1so2884934f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 23:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777961515; x=1778566315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgv8Nu4lwCwl1JcWgOpH3eoML0uI5ZuiaWITMWsA420=;
        b=uK7aw2E778dXB3gbIEJFsyeCWEo6ZcFD4qt2We6Ice8PMG7qNCVcoacl08OYuOlv2b
         FzDxT+zwuMMmOWWztTQRcKo51Q+Kj79ttvaaUqpR2KlLe+Gc4UciLIeml/+Jg38Vv436
         85zmNgJ0MKli4o+S/hmGIAEj4KzkpErS96Ut6trIF3ir0rQQhku7X41p0eCEV6Kb/jve
         TeGBM/DvKmVAfq/xzr973DusA8P/chY6aTRgZ3ZWfVcFAQMW9oLmh6aSeRo0ngO8dBAQ
         oPyTNr+l+3plNaopaFZbH8yf5cbP1ff92GmOhyiQIdt3S7df/ubFFvRmtgOyejeBZbhS
         H/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777961515; x=1778566315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qgv8Nu4lwCwl1JcWgOpH3eoML0uI5ZuiaWITMWsA420=;
        b=l/fPPyINCqwkntlDegOJuFqHW7v3j6m8d4bWgKz2lgLMRRIsZt8ieR8fxOW6rKsooy
         zyoXiNMWFVKGyh7wKaZRiIZRwB8afOC4jnoyWOiTFVSw0fh6UM7nx3yXKD8cYSMHEXi/
         EuxnjRLw9dcZNP6ea4pZRIFliwwTKQkFoCMg5FZolbi8h7EcHmHHk4UMje3KZUiUvpbQ
         yB+A6J+lBmqYpAc9TDYvRaurM39b9tO8OIzOn534n2j4FV4zBiVv+kmDbpHPn0/1WW51
         31wPzpPeJti4/BJ25DtVVNJ1Z8yqVj7k3JhD7iELGfybbsQ1mIksbnl4vUWo4dCJ1Htd
         9xTg==
X-Gm-Message-State: AOJu0YxUUoY0B26q7gxItGI0VA9JK+bTF7xmUF0uIbOX6mc2U/Vt2Wdw
	QrRhIjknUVYDYpKzWJgCwdJGyielUOxmY96MQZ6AjZ+NVV9UbootZ+lBaUCv7kK6PQCx4uPOB5j
	0jvHV
X-Gm-Gg: AeBDietxQi9iOj51frMIa7fxbmCYdEKE5a+2JLmbwK9hbldEmgQ2Ok+UZpKckjgBxnT
	BSGVOCVRIdu704ASZKSOVB6LnTLOgR/+PaTY1mEdH0LQ7IIC3GnP2BgMUCXKaiZ3MQD+bS8J9Ds
	cJbkdEn14VfUq1NuKgJBYSJMGqrkwY+eXY9v7Kcldbwrnqwn0V5J8G8xtmulbcYAycIfbcSsLnZ
	jUYV9bUr3dPMFsXVDXsPzQjEgPqxsSVy3WxSdaOyERvgM0KFs/VATUNUsr9nRPiSpELnohVkSzI
	LznVKOClNZB6Esjv25fnAsvxr1sbSiwPQrRvcckAUGmY9AdjVK5HSGZQXM6489fa/oXVx0aY4OF
	IqjCxMvI3Ej5vdUj7SwKHZuFJmy4OiHpZYFYnNNvqqDjznRx+eeJjKEFr4mIh7sKfW7ypWl/scH
	d8jmxvM4GS0tuq+BAXitV1zzsDpcgQl7pzztWbLauiTq9gY18Ujscaykzg
X-Received: by 2002:a05:6000:1789:b0:43c:fe66:43ec with SMTP id ffacd0b85a97d-450042a4b5fmr3072712f8f.14.1777961515160;
        Mon, 04 May 2026 23:11:55 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b03df9sm1923926f8f.24.2026.05.04.23.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:11:54 -0700 (PDT)
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
	liuy22@mails.tsinghua.edu.cn
Subject: [PATCH rdma-next 1/2] RDMA/uverbs: expose CoCo DMA bounce requirement to userspace
Date: Tue,  5 May 2026 08:11:48 +0200
Message-ID: <20260505061149.2361536-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505061149.2361536-1-jiri@resnulli.us>
References: <20260505061149.2361536-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E6A24C71E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-19986-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


