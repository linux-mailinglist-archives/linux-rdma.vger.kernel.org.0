Return-Path: <linux-rdma+bounces-7909-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4831CA3E45B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 19:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E0A42177B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8963265634;
	Thu, 20 Feb 2025 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c5twu1Ee"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900C265623
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077770; cv=none; b=qYrM13yqnc3P4heNu41+RHietY4tJ/H6wRLIA0cHv6Ew4mqULuadE1jjHyVhKGWhYzPY3Mav/z9FLKoADVBA8VklF21ylIL7HeJb1EkdDDrwmZVUb8/pK5EuhfGQiCRNBoIxdXcENAwKnE9D7uB/zHKXERG98SBT/1Y1g3bBQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077770; c=relaxed/simple;
	bh=D8r3NMs/v/gdOgXckK137771Z7EmXwYtM9x6L549VTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AIui9ZRhXfIzsgJO7b0g8+rD6AG7nWDmqNrEPZjHKJZpzrHDwHi3hYUdfG9sFwqzw5u8aNHlGwCzl/4CoAuluVtCleNuq/BboIwgi/sL9dtWVIXRvRlWgazL0TqCOVopy9yPqLY8cxGmTbOoaA0rSrCYMswKqZ3dNByDQ2s1k/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c5twu1Ee; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220dc3831e3so37838125ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 10:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077768; x=1740682568; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DDGE3L4+QtgAAh6Ko802g9HGK0Xw8N2Rxx0aARspUp4=;
        b=c5twu1Ee+b62oEfz88Cq4R02kV0MES30ivKaXpVXLT3NAdG1xyEMmWFAWiiMEmO5WL
         jVlLE0KOMTbDgb3brE2VvDmzDP1CtXDijhn64CuzYCbRFBIlDl7Jwcf7+NpHAJ6gPiDj
         w7a85qfRjusiAP5jKkBjUc/9FL2eLSInR+UdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077768; x=1740682568;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDGE3L4+QtgAAh6Ko802g9HGK0Xw8N2Rxx0aARspUp4=;
        b=Bc7fzwVyLb0Zxoz3DFlmGElpQfzWN+Gzhu8Js41o6Hpe+0ezzNz+HyWtRhc8F1BZeh
         IvzkG4XAfKAN4kDANhkk37a8Y5TwLA9pz1sDtiHZnbdjlhS843kWry5Hjqu1RLIOW1JT
         f+oVz5ZI3HOJFT9BxJHx2m/r+vUICib5CZoQoUlBTuEM19RPweSP7E0Ie9U8NuJgn9Fd
         SfTL1+vXyDIjTlD3fHn5w1O7HF2/2HFRYO+Y+HMHfZXV2A0K2BTbFMy/NajMkB2rUZpo
         8GKcpekJSDy0sx80PmZgQr5sPj9jSEMs63rPMzfsgjqfhuYhZf1dLpmOPAe3BUPHW5jT
         xp6A==
X-Gm-Message-State: AOJu0Yw/PuEoa6Lwhz0kxpGw0uNwr05bzIJrZsRjpAEpzpC0NpJaWT/E
	6+k8CPtjFXQh9mVDSaS77dZiMV6Z/bd+UuWi7M7FAqfV9kB7rooKg+lPBdMicQ==
X-Gm-Gg: ASbGnctKmykh+pqZPpnPSMzdAolb8vJCqejG1FiG/ua35lDSwN/7GnQrVt8usGrRInL
	4JX12kjVpR8FpR2OV3aukI3xe1OGsfDVBUOcfgcWncf2YL8kK/cChxYJc9B0377ks76ZJXHFhHA
	s8qFNZzG56OS2VclKC0jFmGX8sw3BTIFfYjsacabKMwL7rIaU0uqqf6UHdrggNkkd7GCprTN1Bw
	JhsTiRQrwP8lS62YJTIIxYQ3YKV8l1UCaCNe9Fq9mKauiOnVD0RJmMi6VVillTdEag8eoOE324t
	eBtma55jrzWlVSfKVZZgbWjMQnyRn3LkZMBAtEoWflTvHDPXFqdvRZ4VZ8gCeIia/jQlC50=
X-Google-Smtp-Source: AGHT+IGk3I5xMJOQybBNubZesmP0ZDBZjg0y/axwJ+QSrgEcCl4h1AEI/eEbdqV5zZZFRZPg+G0BBQ==
X-Received: by 2002:a05:6a21:6d88:b0:1e1:a789:1b4d with SMTP id adf61e73a8af0-1eef3d9f0cfmr321809637.15.1740077768126;
        Thu, 20 Feb 2025 10:56:08 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.56.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:56:07 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	abeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 5/9] bnxt_en: Introduce ULP coredump callbacks
Date: Thu, 20 Feb 2025 10:34:52 -0800
Message-Id: <1740076496-14227-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Michael Chan <michael.chan@broadcom.com>

Add .ulp_get_dump_info() and .ulp_get_dump_data() callbacks to
struct bnxt_ulp_ops.  When ethtool -w is invoked to get the coredump,
these 2 callbacks to the bnxt_re auxbus driver will be called if
they are populated by the bnxt_re driver.  The first callback gets
the number of coredump segments and the size of each coredump
segment.  The 2nd callback copies the coredump data for each segment.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 12 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      | 57 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      | 22 +++++++++
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 7236d8e..2106d0d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -14,6 +14,7 @@
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_coredump.h"
+#include "bnxt_ulp.h"
 
 static const u16 bnxt_bstore_to_seg_id[] = {
 	[BNXT_CTX_QP]			= BNXT_CTX_MEM_SEG_QP,
@@ -414,13 +415,20 @@ static int __bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf,
 	}
 
 	if (dump_type == BNXT_DUMP_DRIVER) {
-		u32 drv_len, segs = 0;
+		u32 drv_len, drv_segs, segs = 0;
+		void *drv_buf = NULL;
 
 		drv_len = bnxt_get_ctx_coredump(bp, buf, offset, &segs);
+		drv_segs = segs;
+		segs = 0;
+		if (buf)
+			drv_buf = buf + offset + drv_len;
+		drv_len += bnxt_get_ulp_dump(bp, dump_type, drv_buf, &segs);
+		drv_segs += segs;
 		*dump_len += drv_len;
 		offset += drv_len;
 		if (buf)
-			coredump.total_segs += segs;
+			coredump.total_segs += drv_segs;
 		goto err;
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index e4a7f37..6f640b2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -25,6 +25,7 @@
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_ulp.h"
+#include "bnxt_coredump.h"
 
 static DEFINE_IDA(bnxt_aux_dev_ids);
 
@@ -393,6 +394,62 @@ void bnxt_register_async_events(struct bnxt_en_dev *edev,
 }
 EXPORT_SYMBOL(bnxt_register_async_events);
 
+static void bnxt_ulp_fill_dump_hdr(struct bnxt *bp, void *buf, u32 seg_id,
+				   u32 seg_len)
+{
+	struct bnxt_coredump_segment_hdr seg_hdr;
+
+	bnxt_fill_coredump_seg_hdr(bp, &seg_hdr, NULL, seg_len, 0, 0, 0,
+				   BNXT_DRV_COMP_ID, seg_id);
+	memcpy(buf, &seg_hdr, sizeof(seg_hdr));
+}
+
+u32 bnxt_get_ulp_dump(struct bnxt *bp, u32 dump_flag, void *buf, u32 *segs)
+{
+	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_ulp_dump *dump;
+	struct bnxt_ulp_ops *ops;
+	struct bnxt_ulp *ulp;
+	u32 i, dump_len = 0;
+
+	*segs = 0;
+	if (!edev || !bnxt_ulp_registered(edev))
+		return 0;
+
+	ulp = edev->ulp_tbl;
+	ops = rtnl_dereference(ulp->ulp_ops);
+	if (!ops || !ops->ulp_get_dump_info || !ops->ulp_get_dump_data)
+		return 0;
+
+	dump = &ulp->ulp_dump;
+	if (!buf) {
+		memset(dump, 0, sizeof(*dump));
+		ops->ulp_get_dump_info(ulp->handle, dump_flag, dump);
+		if (dump->segs > BNXT_ULP_MAX_DUMP_SEGS)
+			return 0;
+		for (i = 0; i < dump->segs; i++) {
+			dump_len += dump->seg_tbl[i].seg_len;
+			dump_len += BNXT_SEG_HDR_LEN;
+		}
+	} else {
+		for (i = 0; i < dump->segs; i++) {
+			struct bnxt_ulp_dump_tbl *tbl = &dump->seg_tbl[i];
+			u32 seg_len = tbl->seg_len;
+			u32 seg_id = tbl->seg_id;
+
+			bnxt_ulp_fill_dump_hdr(bp, buf, seg_id, seg_len);
+			buf += BNXT_SEG_HDR_LEN;
+			dump_len += BNXT_SEG_HDR_LEN;
+			ops->ulp_get_dump_data(ulp->handle, seg_id, buf,
+					       seg_len);
+			buf += seg_len;
+			dump_len += seg_len;
+		}
+	}
+	*segs = dump->segs;
+	return dump_len;
+}
+
 void bnxt_rdma_aux_device_uninit(struct bnxt *bp)
 {
 	struct bnxt_aux_priv *aux_priv;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 7fa3b8d..9298589 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -29,11 +29,31 @@ struct bnxt_msix_entry {
 	u32	db_offset;
 };
 
+#define BNXT_ULP_MAX_DUMP_SEGS	8
+
+/**
+ * struct bnxt_ulp_dump - bnxt ULP aux device coredump info
+ * @segs:	number of coredump segments with info in the seg_tbl
+ * @seg_tbl:	coredump segment table
+ * @seg_tbl.seg_id:	coredump segment ID
+ * @seg_tbl.seg_len:	coredump segment len
+ */
+struct bnxt_ulp_dump {
+	u32	segs;
+	struct bnxt_ulp_dump_tbl {
+		u32	seg_id;
+		u32	seg_len;
+	} seg_tbl[BNXT_ULP_MAX_DUMP_SEGS];
+};
+
 struct bnxt_ulp_ops {
 	/* async_notifier() cannot sleep (in BH context) */
 	void (*ulp_async_notifier)(void *, struct hwrm_async_event_cmpl *);
 	void (*ulp_irq_stop)(void *, bool);
 	void (*ulp_irq_restart)(void *, struct bnxt_msix_entry *);
+	void (*ulp_get_dump_info)(void *handle, u32 dump_flags,
+				  struct bnxt_ulp_dump *dump);
+	void (*ulp_get_dump_data)(void *handle, u32 seg_id, void *buf, u32 len);
 };
 
 struct bnxt_fw_msg {
@@ -51,6 +71,7 @@ struct bnxt_ulp {
 	u16		max_async_event_id;
 	u16		msix_requested;
 	atomic_t	ref_count;
+	struct bnxt_ulp_dump	ulp_dump;
 };
 
 struct bnxt_en_dev {
@@ -119,6 +140,7 @@ void bnxt_ulp_start(struct bnxt *bp, int err);
 void bnxt_ulp_sriov_cfg(struct bnxt *bp, int num_vfs);
 void bnxt_ulp_irq_stop(struct bnxt *bp);
 void bnxt_ulp_irq_restart(struct bnxt *bp, int err);
+u32 bnxt_get_ulp_dump(struct bnxt *bp, u32 dump_flag, void *buf, u32 *segs);
 void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl);
 void bnxt_rdma_aux_device_uninit(struct bnxt *bp);
 void bnxt_rdma_aux_device_del(struct bnxt *bp);
-- 
2.5.5


