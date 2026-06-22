Return-Path: <linux-rdma+bounces-22399-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PBWaL2G9OGpohQcAu9opvQ
	(envelope-from <linux-rdma+bounces-22399-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 06:43:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4696AC989
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 06:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=fjhNyroB;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22399-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22399-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA58C3006464
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 04:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56853546CF;
	Mon, 22 Jun 2026 04:43:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733733ADB3
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2026 04:43:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103391; cv=none; b=ulmSE3LW0b5xzhSYjlTo1N8hm6Lz7coaK5TX51YLm9zMWftU54zsF+w/z/H6VCb3cQjS+wXrsGNP6F+9MIc7ZFwvtEmFyxEtlsqviyOtbpvnTf0BhZZ/fn1Q5HhNfgL/jU8MmRr4TwvPejFGLDF5Tv7+C+1yOjCvR+BNuSRTJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103391; c=relaxed/simple;
	bh=jN1h8ykQiktAHtcZl2b3c/fkp8ZNcWP3OceAySm42uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdVAffCkuFBxCQE9erItedV5/z0IcN4mFJmMU5H46/6m7lkT+vL4UPy59kVWj80WcQO+ZZELQjYQ/gFDA1QYhAcgynGMlAT32xbh5dPxk7VEOaZjgKITN8hUL3XYcLhCOpZSQb2c96qj3MxsEhPu39hl6Kmk3/+1r/7IpR1Y4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fjhNyroB; arc=none smtp.client-ip=209.85.214.228
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2bf1cda2b17so22818355ad.1
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2026 21:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782103389; x=1782708189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUO3VWAnM0DiVCaKAicua3cdiYI4Ji8REP6KTXfgNSE=;
        b=CEC4/ceu3tjlrqvPAwzBeRYrfExBpBZwyy6eG8FzBpuiUop+zLr6tCCgO53spmbmzk
         yDmCYlCJ2tDF+wde0yGQ9pOZSR0zLNDq1wzJXOV8XNKoCZ0gYUSCnjyVDoz8gMRKh47l
         ikD3zl9N/KS61omj/ALUbxBChECTMXtrcl41rW83zpEKHtKD5cDVnrbXY9w5N2e0BcEX
         QR5W+ODad7Dqr0se2AZs4unGxluBevlwxAbB0tvQ7Qa2Vbgb1+PO5FmYLt2itJlw/A6C
         lJ6aBZS0WAFCAwMxop2xsYvSLigJR7jL1ID5Jk7DfnH/d2O0zVFolSzKb30TJNzKo71t
         /BsA==
X-Gm-Message-State: AOJu0YzScscdlgmL5ucgvUgeeQ4DYLn1+fKbMMgy6uOG1bliGYzp2rg8
	5M3iPiPb3Nnp57U17ET6CoD4KHnycHqN+J3UrLLn6N3FPWPo1SmW6+I8y4qr+FNFT0t4GK6ggjL
	Gg7ZYqC8gm9HWHpr4z4EldKxQAeMqhYyvDsOGgwKO0E4XjklI9WKXuH6zPiHvJj0VQG6B2OrMhq
	sNGs/CBJFUrF+K49ZXRks+s/iAxXfprrXg5D36c/DrKb8wWuO6pDUOJU77OYeOzh0A9+UIaNYof
	S6uHM8vJvH8Txgd6Q==
X-Gm-Gg: AfdE7cmblLkNMob/YumUYgMfXn5E5xmVlWZsp1acAXEAfQlHoo5kO/if26nRYDncWDH
	gmFXKSfIntLeiNkrozFRCcN9SsbOdX4d/K20RL3Vl4ftAW9K4e89SIwQUJUKzX7OjrFewUQUAJM
	n89hUeXgHOLwk3Lq6Soka6TrJayJRAzoJPp6p+VyfsFHyC5toxuq5HogdMAhLXeJoeNlv64mj6b
	JHIfYkgACapl8jVFazjysBl5C1wSvypphLzndwvlU0bOL18y8IVCu0SaDIWZlbkjoC3x00pguu8
	kvsEiB9ImfVGCj8GkdsnYPTzsRFkDv73lXWXSwRVG5k9HfQvcfB51i4xcQVTlpJgrMXRy5BIqn2
	500UnXbLtoB8ujyam4QrqzJl+K1L8CabW6lLaU8emYLJIx5bli8i3V/dWNuJWBAv2fcirLHWgwb
	9zjuExgaLPntnhuNH9x/HCXW0QIC+SGzQ0LIeGP3/7aI+cbQ0=
X-Received: by 2002:a17:903:a86:b0:2c6:b429:f111 with SMTP id d9443c01a7336-2c7196546e6mr103384435ad.29.1782103389178;
        Sun, 21 Jun 2026 21:43:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c74600799dsm5276825ad.53.2026.06.21.21.43.08
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2026 21:43:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf11699875so48969715ad.1
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2026 21:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782103387; x=1782708187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUO3VWAnM0DiVCaKAicua3cdiYI4Ji8REP6KTXfgNSE=;
        b=fjhNyroBwyYSBmPup6eS7Waa6tofhiGo0eeXMs5mkFpBex0Z9PTNF/7YP341c+GccH
         8daLD0jQZuTtZmixdb1orOkS7FyiSmBCxKLDQlXXU22cvQlkBssy9JfTcTjZK9ZFyEpN
         FQ1+XNWuqb/Em1spLIBSIb673gcqdHaJa8b5Y=
X-Received: by 2002:a17:903:2ac3:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2c7195e66a4mr111412335ad.20.1782103387171;
        Sun, 21 Jun 2026 21:43:07 -0700 (PDT)
X-Received: by 2002:a17:903:2ac3:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2c7195e66a4mr111412135ad.20.1782103386616;
        Sun, 21 Jun 2026 21:43:06 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f901bsm60607475ad.44.2026.06.21.21.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 21:43:06 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/2] RDMA/bnxt_re: Replace per-device hash tables with per-context XArray
Date: Mon, 22 Jun 2026 03:05:27 -0700
Message-Id: <20260622100528.132463-2-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260622100528.132463-1-selvin.xavier@broadcom.com>
References: <20260622100528.132463-1-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22399-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D4696AC989

The CQ and SRQ hash tables (cq_hash, srq_hash) on struct bnxt_re_dev
were used exclusively to look up a toggle-page pointer from a
user-space-supplied hardware queue ID in the GET_TOGGLE_MEM
ioctl handler. This approach has couple of problems. First,
because the tables are per-device, any user can look up another
user's CQ or SRQ by guessing the hardware queue ID. Second,
concurrent add and remove operations on the hash table are not
protected by any lock, leaving a race window.

The correct fix is to retrieve the CQ and SRQ objects via the uverbs
object handle, which gives built-in ownership verification and reference
pinning for the duration of the ioctl. That is added in the next patch of
this series.

To maintain backward compatibility with older rdma-core versions that
do not send a uverbs object handle, the driver must continue to support
the existing TYPE + RES_ID lookup path. This patch replaces the per-device
hash tables with per-ucontext XArrays (cq_xa and srq_xa on struct
bnxt_re_ucontext), which narrows the lookup scope to the calling context,
eliminating the cross-user visibility, and relies on the XArray's
built-in locking to close the synchronization gap.

The GET_TOGGLE_MEM ioctl handler is updated to call xa_load()
in place of the now-removed bnxt_re_search_for_cq()/
bnxt_re_search_for_srq() helpers. No ABI changes are required.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  6 ---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 51 +++++++++++++++++-------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  4 +-
 drivers/infiniband/hw/bnxt_re/main.c     |  5 ---
 drivers/infiniband/hw/bnxt_re/uapi.c     | 37 ++---------------
 5 files changed, 42 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3a7ce4729fcf..a43e678151d3 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -41,7 +41,6 @@
 #define __BNXT_RE_H__
 #include <rdma/uverbs_ioctl.h>
 #include "hw_counters.h"
-#include <linux/hashtable.h>
 #define ROCE_DRV_MODULE_NAME		"bnxt_re"
 
 #define BNXT_RE_DESC	"Broadcom NetXtreme-C/E RoCE Driver"
@@ -158,9 +157,6 @@ struct bnxt_re_nq_record {
 	struct mutex		load_lock;
 };
 
-#define MAX_CQ_HASH_BITS		(16)
-#define MAX_SRQ_HASH_BITS		(16)
-
 static inline bool bnxt_re_chip_gen_p7(u16 chip_num)
 {
 	return (chip_num == CHIP_NUM_58818 ||
@@ -215,8 +211,6 @@ struct bnxt_re_dev {
 	struct bnxt_re_pacing pacing;
 	struct work_struct dbq_fifo_check_work;
 	struct delayed_work dbq_pacing_work;
-	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
-	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 565762529007..72b4c47d694a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -38,6 +38,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/if_ether.h>
@@ -51,8 +52,6 @@
 #include <rdma/ib_cache.h>
 #include <rdma/ib_pma.h>
 #include <rdma/uverbs_ioctl.h>
-#include <linux/hashtable.h>
-
 #include "roce_hsi.h"
 #include "qplib_res.h"
 #include "qplib_sp.h"
@@ -2152,11 +2151,16 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
-		hash_del(&srq->hash_entry);
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
-	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
-		free_page((unsigned long)srq->uctx_srq_page);
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+		struct bnxt_re_ucontext *uctx =
+			rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+
+		if (uctx) {
+			xa_erase(&uctx->srq_xa, srq->qplib_srq.id);
+			free_page((unsigned long)srq->uctx_srq_page);
+		}
+	}
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
 	return ib_respond_empty_udata(udata);
@@ -2263,12 +2267,16 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 
 		resp.srqid = srq->qplib_srq.id;
 		if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
-			hash_add(rdev->srq_hash, &srq->hash_entry, srq->qplib_srq.id);
 			srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
 			if (!srq->uctx_srq_page) {
 				rc = -ENOMEM;
 				goto fail;
 			}
+			if (xa_store(&uctx->srq_xa, srq->qplib_srq.id, srq, GFP_KERNEL)) {
+				free_page((unsigned long)srq->uctx_srq_page);
+				rc = -ENOMEM;
+				goto fail;
+			}
 			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
 		}
 		rc = ib_respond_udata(udata, resp);
@@ -3475,11 +3483,16 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
-		hash_del(&cq->hash_entry);
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
-	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
-		free_page((unsigned long)cq->uctx_cq_page);
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		struct bnxt_re_ucontext *uctx =
+			rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+
+		if (uctx) {
+			xa_erase(&uctx->cq_xa, cq->qplib_cq.id);
+			free_page((unsigned long)cq->uctx_cq_page);
+		}
+	}
 
 	bnxt_re_put_nq(rdev, nq);
 
@@ -3554,14 +3567,15 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	spin_lock_init(&cq->cq_lock);
 
 	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
-		hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
-		/* Allocate a page */
 		cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!cq->uctx_cq_page) {
 			rc = -ENOMEM;
 			goto destroy_cq;
 		}
-
+		if (xa_store(&uctx->cq_xa, cq->qplib_cq.id, cq, GFP_KERNEL)) {
+			rc = -ENOMEM;
+			goto free_toggle_page;
+		}
 		resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
 	}
 	resp.cqid = cq->qplib_cq.id;
@@ -3574,6 +3588,9 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	return 0;
 
 free_mem:
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
+		xa_erase(&uctx->cq_xa, cq->qplib_cq.id);
+free_toggle_page:
 	free_page((unsigned long)cq->uctx_cq_page);
 destroy_cq:
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
@@ -4823,6 +4840,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		}
 	}
 
+	xa_init(&uctx->cq_xa);
+	xa_init(&uctx->srq_xa);
+
 	rc = ib_respond_udata(udata, resp);
 	if (rc)
 		goto cfail;
@@ -4848,6 +4868,9 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *ib_uctx)
 	if (uctx->shpg)
 		free_page((unsigned long)uctx->shpg);
 
+	xa_destroy(&uctx->cq_xa);
+	xa_destroy(&uctx->srq_xa);
+
 	if (uctx->dpi.dbr) {
 		/* Free DPI only if this is the first PD allocated by the
 		 * application and mark the context dpi as NULL
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 22bf81668cfb..76f407cd3435 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -78,7 +78,6 @@ struct bnxt_re_srq {
 	struct ib_umem		*umem;
 	spinlock_t		lock;		/* protect srq */
 	void			*uctx_srq_page;
-	struct hlist_node       hash_entry;
 };
 
 struct bnxt_re_qp {
@@ -113,7 +112,6 @@ struct bnxt_re_cq {
 	struct ib_umem		*resize_umem;
 	int			resize_cqe;
 	void			*uctx_cq_page;
-	struct hlist_node	hash_entry;
 };
 
 struct bnxt_re_mr {
@@ -147,6 +145,8 @@ struct bnxt_re_ucontext {
 	void			*shpg;
 	spinlock_t		sh_lock;	/* protect shpg */
 	struct rdma_user_mmap_entry *shpage_mmap;
+	struct xarray		cq_xa;		/* cqid → bnxt_re_cq, for toggle page lookup */
+	struct xarray		srq_xa;		/* srqid → bnxt_re_srq, for toggle page lookup */
 	u64 cmask;
 };
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index d25fdc458120..637f023b18ac 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -54,7 +54,6 @@
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
-#include <linux/hashtable.h>
 #include <linux/bnxt/ulp.h>
 
 #include "roce_hsi.h"
@@ -2337,10 +2336,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		if (!(rdev->qplib_res.en_dev->flags & BNXT_EN_FLAG_ROCE_VF_RES_MGMT))
 			bnxt_re_vf_res_config(rdev);
 	}
-	hash_init(rdev->cq_hash);
-	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
-		hash_init(rdev->srq_hash);
-
 	bnxt_re_debugfs_add_pdev(rdev);
 
 	bnxt_re_init_dcb_wq(rdev);
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 263238a6e4cd..9485aa890b04 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -22,32 +22,6 @@
 #include "bnxt_re.h"
 #include "ib_verbs.h"
 
-static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
-{
-	struct bnxt_re_cq *cq = NULL, *tmp_cq;
-
-	hash_for_each_possible(rdev->cq_hash, tmp_cq, hash_entry, cq_id) {
-		if (tmp_cq->qplib_cq.id == cq_id) {
-			cq = tmp_cq;
-			break;
-		}
-	}
-	return cq;
-}
-
-static struct bnxt_re_srq *bnxt_re_search_for_srq(struct bnxt_re_dev *rdev, u32 srq_id)
-{
-	struct bnxt_re_srq *srq = NULL, *tmp_srq;
-
-	hash_for_each_possible(rdev->srq_hash, tmp_srq, hash_entry, srq_id) {
-		if (tmp_srq->qplib_srq.id == srq_id) {
-			srq = tmp_srq;
-			break;
-		}
-	}
-	return srq;
-}
-
 static int UVERBS_HANDLER(BNXT_RE_METHOD_NOTIFY_DRV)(struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_ucontext *uctx;
@@ -246,9 +220,8 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	struct bnxt_re_user_mmap_entry *entry;
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
-	struct bnxt_re_dev *rdev;
-	struct bnxt_re_srq *srq;
 	u32 length = PAGE_SIZE;
+	struct bnxt_re_srq *srq;
 	struct bnxt_re_cq *cq;
 	u64 mem_offset;
 	u32 offset = 0;
@@ -265,31 +238,27 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		return err;
 
 	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
-	rdev = uctx->rdev;
 	err = uverbs_copy_from(&res_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
 	if (err)
 		return err;
 
 	switch (res_type) {
 	case BNXT_RE_CQ_TOGGLE_MEM:
-		cq = bnxt_re_search_for_cq(rdev, res_id);
+		cq = xa_load(&uctx->cq_xa, res_id);
 		if (!cq)
 			return -EINVAL;
-
 		addr = (u64)cq->uctx_cq_page;
 		if (!addr)
 			return -EOPNOTSUPP;
 		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
-		srq = bnxt_re_search_for_srq(rdev, res_id);
+		srq = xa_load(&uctx->srq_xa, res_id);
 		if (!srq)
 			return -EINVAL;
-
 		addr = (u64)srq->uctx_srq_page;
 		if (!addr)
 			return -EOPNOTSUPP;
 		break;
-
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.39.3


