Return-Path: <linux-rdma+bounces-22451-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6a4QAhgRPGrMjQgAu9opvQ
	(envelope-from <linux-rdma+bounces-22451-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 19:17:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEC96C0499
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 19:17:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=hapRBdLn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22451-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22451-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55ABD30297BF
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3BC3DCDA1;
	Wed, 24 Jun 2026 17:17:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D5265CDD
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 17:17:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321428; cv=none; b=t2S76dhOl6jITJPzVRRR66NhOR/QYv8VvWtwrCI9fcPC7EKPsglyq2/XCAUwUh+/ilyuR3L/9w6Pt13UMVGEyxD7bkMNc8AuDX8kK36egAec40eRmYiZlQTpUlvv3eZ29Y+51F+kE5tmloaiGUFho3eE8c1kw7RSyDjf/xlFtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321428; c=relaxed/simple;
	bh=sOsRyydpNqZ+jKnxpsdxWdF8Hs8uYi35a5Onbff12ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVyXSCSAnWlE4MH/mq6RyVnNPIZioAq8CM/Pv7BwRCXChc7No7LcSPG7O1IigV/AFjkRSWiXPqVECa6+QhJEr3CZwybiXyXYzWqQMACQRb6Nvx6japXZiLMZcVD+NXY38bglfAqKHpGFw1+Ixo0cyRfTYq23jgCw4O0wD2yewg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hapRBdLn; arc=none smtp.client-ip=209.85.222.98
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-966801d093aso478060241.2
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 10:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321426; x=1782926226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNfw1ITRE8HC7Z3mEkUeecnkvyaN9yFFwMJ/eihxfco=;
        b=XQD0jtLCkaG++OJIY1P7zTk8GCnJ19DAz1GjwBFfi3bYzLazikNpr8ThvAFrRFClsQ
         CW2K4xqyUcZwcmltX2RnS2woyO2eVF0FGXBu9lT7UgfMj+E8C1SmJQ5R24F6u017gr4Y
         2I3FQyaJlFRU5SPaYuYlYd7w1CdXGbZgoUvh8Im2gN1PaCvJOoFaw5IZtTU0QmYK8rZd
         8Y6MnVuTVB99uXlz9MPtyBElIBuGDk3JQIYVx8oO/7MGUef1cJsJN31/pZZoJpotFtq4
         a8P1DzOG009+3vc7PORa01WFWnVVwSBnFRE30lMGmYJ32JLDDsETsfx31rMykWWCnZ3A
         uDsw==
X-Gm-Message-State: AOJu0YySEMgSyuzqXM25x45KTPDLEmG4EkVXOasfNCmWReSMxzCQe8c3
	2YUnC0Mc8FCSoO95AuU3daS0leTP73+ctPVvwsZKPkxc+0+MkZrImvNidAfuXyX6ZJG0UTbMdh6
	p8nujPdDGlr1xP0DGMO6jtL9K97RngCnzAUCXOSym6nrnlka+NWCtcW6jrQ9mne3eNCz5WV1tQP
	8qeR4bq+RwaOUWYNLnzEoaHsgcnHbJhhcDNtAdf8Fc8O4PqVcdRE8WBWHsczIkad4StGcRO5KSN
	DH//vA/XEQ7oMsiBxyY
X-Gm-Gg: AfdE7ckjLMEPai2VtQgLvGQejfXtLPKevdyrmEFrutMHLtSy/FEvLgzJygDr2aOMgyL
	Cm70fwW5Af0/iyDU8d+MZFY/L/E1WAmTqqC55T8mjyxEvcOdKRvHFAmUDqVZExGrmRKIiuUUgB7
	9XHp0T4Fl/2pb+YPBi5Djw3jlV2PG/qmSWnITtZ4Yw+9leHAJV374Q/xRG2WgXjKHLUIPh1qn2F
	O3Dv1Am3Ggdmvw++GojpbAMHBiGqonDskI1n2iQ5/2MAJ8Wvuo6xMQXra/vsPGoQzUD2BUEP84h
	uLC8pnfZbA3yQFBMFHrNq5jPpHMrm5hW0k6FqmnpIwomveY+CeBI7l1yWTmEm/ed3Tmfu/GX/0s
	xo1saQSgIzfcUBBCWkn5mAG5WPsjLbs36RymPGBDHkglStwzbSRDpR/86XkrJhCLxC3PUlf4PQA
	W9nejA2EOdJ67I0dShPfek2iALxYLl9OKAowvEOa/eogQvrNM=
X-Received: by 2002:a05:6102:1614:b0:728:68cf:c76 with SMTP id ada2fe7eead31-72fd7c54a4amr5075448137.23.1782321425780;
        Wed, 24 Jun 2026 10:17:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-925ff9e91c8sm35128885a.7.2026.06.24.10.17.05
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2026 10:17:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7e921550fso8622845ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782321424; x=1782926224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNfw1ITRE8HC7Z3mEkUeecnkvyaN9yFFwMJ/eihxfco=;
        b=hapRBdLnEuBQknm7C9Pora/wHSrGzymE3fsouZsy4I5SqhBrWPM7Q4E3Af3mJvWQPu
         SqN8LYarcOJZ2mgsyZyBCwfNLSuG85fIQfIyS1F/fpxkxcbg1Gns+OfPZuS/KOFiXTYK
         +TD5AvVmCHQTiAangvgNZH2Mgi+o6RlqBdsuY=
X-Received: by 2002:a17:903:1246:b0:2c2:27be:39aa with SMTP id d9443c01a7336-2c7c76846b6mr90924905ad.17.1782321424311;
        Wed, 24 Jun 2026 10:17:04 -0700 (PDT)
X-Received: by 2002:a17:903:1246:b0:2c2:27be:39aa with SMTP id d9443c01a7336-2c7c76846b6mr90924355ad.17.1782321423593;
        Wed, 24 Jun 2026 10:17:03 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afbbd9sm3004965ad.28.2026.06.24.10.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:17:03 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 1/2] RDMA/bnxt_re: Replace per-device hash tables with per-context XArray
Date: Wed, 24 Jun 2026 15:39:26 -0700
Message-Id: <20260624223927.521882-2-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260624223927.521882-1-selvin.xavier@broadcom.com>
References: <20260624223927.521882-1-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22451-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: AEEC96C0499

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
eliminating the cross-user visibility. Also adds Xarray locking mechanism
for synchronization.

The GET_TOGGLE_MEM ioctl handler is updated to call xa_load()
in place of the now-removed bnxt_re_search_for_cq()/
bnxt_re_search_for_srq() helpers. No ABI changes are required.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  6 --
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 84 ++++++++++++++++++------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  4 +-
 drivers/infiniband/hw/bnxt_re/main.c     |  5 --
 drivers/infiniband/hw/bnxt_re/uapi.c     | 55 ++++------------
 5 files changed, 80 insertions(+), 74 deletions(-)

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
index 565762529007..d1eebd7b56f4 100644
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
@@ -2152,11 +2151,19 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
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
+			/* similar to cq, use __xa_erase() with the lock already held */
+			xa_lock(&uctx->srq_xa);
+			__xa_erase(&uctx->srq_xa, srq->qplib_srq.id);
+			xa_unlock(&uctx->srq_xa);
+			free_page((unsigned long)srq->uctx_srq_page);
+		}
+	}
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
 	return ib_respond_empty_udata(udata);
@@ -2263,20 +2270,21 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 
 		resp.srqid = srq->qplib_srq.id;
 		if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
-			hash_add(rdev->srq_hash, &srq->hash_entry, srq->qplib_srq.id);
 			srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
 			if (!srq->uctx_srq_page) {
 				rc = -ENOMEM;
-				goto fail;
+				goto fail_destroy_srq;
+			}
+			if (xa_is_err(xa_store(&uctx->srq_xa, srq->qplib_srq.id,
+					       srq, GFP_KERNEL))) {
+				rc = -ENOMEM;
+				goto fail_free_toggle;
 			}
 			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
 		}
 		rc = ib_respond_udata(udata, resp);
-		if (rc) {
-			bnxt_qplib_destroy_srq(&rdev->qplib_res,
-					       &srq->qplib_srq);
-			goto fail;
-		}
+		if (rc)
+			goto fail_respond;
 	}
 	active_srqs = atomic_inc_return(&rdev->stats.res.srq_count);
 	if (active_srqs > rdev->stats.res.srq_watermark)
@@ -2285,6 +2293,16 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 
 	return 0;
 
+fail_respond:
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+		xa_lock(&uctx->srq_xa);
+		__xa_erase(&uctx->srq_xa, srq->qplib_srq.id);
+		xa_unlock(&uctx->srq_xa);
+	}
+fail_free_toggle:
+	free_page((unsigned long)srq->uctx_srq_page);
+fail_destroy_srq:
+	bnxt_qplib_destroy_srq(&rdev->qplib_res, &srq->qplib_srq);
 fail:
 	ib_umem_release(srq->umem);
 exit:
@@ -3475,11 +3493,24 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
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
+		/*
+		 * Hold xa_lock across the erase so that GET_TOGGLE_MEM's
+		 * xa_lock + xa_load + dereference region is atomic with respect
+		 * to removal. xa_erase() would re-acquire the same lock and
+		 * deadlock; use __xa_erase() with the lock already held.
+		 */
+			xa_lock(&uctx->cq_xa);
+			__xa_erase(&uctx->cq_xa, cq->qplib_cq.id);
+			xa_unlock(&uctx->cq_xa);
+			free_page((unsigned long)cq->uctx_cq_page);
+		}
+	}
 
 	bnxt_re_put_nq(rdev, nq);
 
@@ -3554,14 +3585,15 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
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
+		if (xa_is_err(xa_store(&uctx->cq_xa, cq->qplib_cq.id, cq, GFP_KERNEL))) {
+			rc = -ENOMEM;
+			goto free_toggle_page;
+		}
 		resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
 	}
 	resp.cqid = cq->qplib_cq.id;
@@ -3574,6 +3606,12 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	return 0;
 
 free_mem:
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		xa_lock(&uctx->cq_xa);
+		__xa_erase(&uctx->cq_xa, cq->qplib_cq.id);
+		xa_unlock(&uctx->cq_xa);
+	}
+free_toggle_page:
 	free_page((unsigned long)cq->uctx_cq_page);
 destroy_cq:
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
@@ -4823,6 +4861,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		}
 	}
 
+	xa_init(&uctx->cq_xa);
+	xa_init(&uctx->srq_xa);
+
 	rc = ib_respond_udata(udata, resp);
 	if (rc)
 		goto cfail;
@@ -4848,6 +4889,9 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *ib_uctx)
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
index 263238a6e4cd..7e2acd0933f7 100644
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
@@ -246,10 +220,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	struct bnxt_re_user_mmap_entry *entry;
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
-	struct bnxt_re_dev *rdev;
-	struct bnxt_re_srq *srq;
 	u32 length = PAGE_SIZE;
-	struct bnxt_re_cq *cq;
 	u64 mem_offset;
 	u32 offset = 0;
 	u64 addr = 0;
@@ -265,31 +236,33 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		return err;
 
 	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
-	rdev = uctx->rdev;
 	err = uverbs_copy_from(&res_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
 	if (err)
 		return err;
 
 	switch (res_type) {
 	case BNXT_RE_CQ_TOGGLE_MEM:
-		cq = bnxt_re_search_for_cq(rdev, res_id);
-		if (!cq)
-			return -EINVAL;
+		struct bnxt_re_cq *cq;
 
-		addr = (u64)cq->uctx_cq_page;
+		xa_lock(&uctx->cq_xa);
+		cq = xa_load(&uctx->cq_xa, res_id);
+		if (cq)
+			addr = (u64)cq->uctx_cq_page;
+		xa_unlock(&uctx->cq_xa);
 		if (!addr)
-			return -EOPNOTSUPP;
+			return -EINVAL;
 		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
-		srq = bnxt_re_search_for_srq(rdev, res_id);
-		if (!srq)
-			return -EINVAL;
+		struct bnxt_re_srq *srq;
 
-		addr = (u64)srq->uctx_srq_page;
+		xa_lock(&uctx->srq_xa);
+		srq = xa_load(&uctx->srq_xa, res_id);
+		if (srq)
+			addr = (u64)srq->uctx_srq_page;
+		xa_unlock(&uctx->srq_xa);
 		if (!addr)
-			return -EOPNOTSUPP;
+			return -EINVAL;
 		break;
-
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.39.3


