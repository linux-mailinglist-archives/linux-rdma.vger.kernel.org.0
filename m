Return-Path: <linux-rdma+bounces-23099-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N8RdM9elVGoiowMAu9opvQ
	(envelope-from <linux-rdma+bounces-23099-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:46:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C35FE748E3A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:46:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=NFocChw9;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23099-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23099-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5288C304EEBF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048A3B47DD;
	Mon, 13 Jul 2026 08:36:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BF3B3886
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 08:36:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931810; cv=none; b=MQ9y1EjXhN8B3fjZSZj+391W0hW9YfF7K9yUXDPwW/6Webgc5bymDh0HeWll0pghC64kxai9Vj79DmNNMqMi+fLNMX0uaJFVvwkN6eMjvpJQ0nQ8Lb1ejj8pUIhaW2kA/yLSin9lPZwiFzcOnKkZUpbTYu0SJS+/mny/VxlbFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931810; c=relaxed/simple;
	bh=iFakRUdRcMfRaj2kTeCRJdxQA11gy3DN6JfG1N4UiQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBxMJvuYXpmKCaV2b4P0MZBxTtynDTPgzzLkwmSgvPcZ1fYeMzyIAZwu4XQpqsgbvjgCQwkB4qMqRoLRWA7dKHYNn4QxrnTrUcf2FoaETT3IXZwdPe09GGVBXjwtuVDm9AnKhHud1QlDqcdXD9P+GQJBcReicoK2WvtpztCeKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NFocChw9; arc=none smtp.client-ip=209.85.219.100
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8f186025973so30587576d6.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783931807; x=1784536607;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xut17HqvTzXOCQPWrO5tZDrJfwAIxAEzV6WQY3EQSe0=;
        b=hb65Sk9KB2fz+XmpXET7Kuu8kTz+YgFfbLsDyIekt22JT9DlZ59C4T9sArg0aaCqEN
         WJhS/3giLrFF9qU0XpCnYDDz3L2kIcfUsSX70BHfIYHVmJb5Jr9TzsGJJu6wuyv39Wy4
         GqhuwUB0uoT9B0e4AY2D6tfZwic3amq6zmgNxw4ZaIoCx8DHRyWfG368q2hIyqhnGu+P
         9dhu0uaBpeb3H0o5wvAY/lu4LJmZxYo3GFigODl8RYUWpfm/rJnfO/uU0nBXROcQgdi7
         WD0OpcFEK/o12kWmP3kuur4F/xNe7rvYnvoP68Cch0kTIPgDmSnnW2fkHy9sDuWNrM5V
         PT1Q==
X-Gm-Message-State: AOJu0YzmhQrDURWGgToNna3RbXyBmfl/0T99jFoeyeJQQlCVmi5ImeXk
	bgNz3gHUlbY4vnXsvU2xQfIBonQ7ALK2/8cRi33MGCqlxBGAZeIbFBQZjJmkgSJKrSQLtaMbZNu
	KQLt297VzD7pjA5tIOyjIb3y8W0qTL92Vck0yW9udOb1E//xwnp9nnMev+Tx1fRu1YaLJjGbbhN
	gk2dz9rXGSuRgTBX3DVY5KSXqAdTBd3uZh/CVjqo1WD6H9uuI6w5XRWqX730af7j9W9DKDUcxhv
	13zbS5DMFTwTPSn9Q==
X-Gm-Gg: AfdE7ckyPPUKZWB31et3VMAGbKNwLq4KPOoO+Pxv2U32PYIZsKzrW0RIdcjTin2aM0f
	pXxcFUTTcpqiuoeDJuT5Jr9mANSc6VwzCqSCrqc/gq/pVAev+Lg3KgVYPQIVqWdKEDow/EXGbMM
	UDAOOqk2Gxjmz3CcmRwVneP1YOU7TRO6ztCto5QYxr0zSSDuLz5255djAXjyuukjsrASzWffWh0
	M7w+FwFTma4s06UPDEUiYwcYaeZKVtOYLFkRZt+4yCy+1u4rEKCWaawdlPtbaLHUuzsdij2gAxI
	Hl9GvKY1Nklli99788m4ir6XOuDG8RbfHFhmBhtXSc9ettMkmWXX2unKSI40Sf8ZIbU513qOjmp
	GjXfnGEk0MBZyQ1l2UtBH4fLVvEuIyOIsH65VYv32DqZvGUq10X+TI1iVhZjqztLHjrmJuRPAsW
	1rsMe5wIeI21aGRAJMmQptSVlv9h9CbfOC1JlnfnpFU2bt
X-Received: by 2002:a05:6214:4a0a:b0:8ef:c64a:ffef with SMTP id 6a1803df08f44-903ff452bbemr97988326d6.1.1783931807086;
        Mon, 13 Jul 2026 01:36:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-6.dlp.protect.broadcom.com. [144.49.247.6])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ffd8ab080fsm7272926d6.16.2026.07.13.01.36.46
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 01:36:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c804e38c65so60597215ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783931806; x=1784536606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xut17HqvTzXOCQPWrO5tZDrJfwAIxAEzV6WQY3EQSe0=;
        b=NFocChw9Pzb1oVNpk6V6E4h3xaDg/KOMMK+sdZXWCfnAQrjBOVQE0MKbblaFok/1Ou
         Fb8GJ0FJzNuzkziDuJOwgfI5FboiX5sWYweeIDwVVscFRquKdcmzWzXTgj+O4hja1MWJ
         nE8EU25NIBjZq1pkmpEo6JCbmMwKojRgVpV50=
X-Received: by 2002:a17:903:4b47:b0:2c9:ff83:41fa with SMTP id d9443c01a7336-2ce9ee1890amr77710335ad.24.1783931805608;
        Mon, 13 Jul 2026 01:36:45 -0700 (PDT)
X-Received: by 2002:a17:903:4b47:b0:2c9:ff83:41fa with SMTP id d9443c01a7336-2ce9ee1890amr77710175ad.24.1783931805071;
        Mon, 13 Jul 2026 01:36:45 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm95005385ad.57.2026.07.13.01.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:36:44 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	alhouseenyousef@gmail.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 1/4] RDMA/bnxt_re: Replace per-device hash tables with per-context XArrays
Date: Mon, 13 Jul 2026 06:58:27 -0700
Message-Id: <20260713135830.1934471-2-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260713135830.1934471-1-selvin.xavier@broadcom.com>
References: <20260713135830.1934471-1-selvin.xavier@broadcom.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:alhouseenyousef@gmail.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,gmail.com];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23099-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C35FE748E3A

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
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  5 --
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 76 ++++++++++++++++++------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  6 +-
 drivers/infiniband/hw/bnxt_re/main.c     |  4 --
 drivers/infiniband/hw/bnxt_re/uapi.c     | 75 ++++++++---------------
 5 files changed, 87 insertions(+), 79 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3a7ce4729fcf..aceb237d605b 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -41,7 +41,6 @@
 #define __BNXT_RE_H__
 #include <rdma/uverbs_ioctl.h>
 #include "hw_counters.h"
-#include <linux/hashtable.h>
 #define ROCE_DRV_MODULE_NAME		"bnxt_re"
 
 #define BNXT_RE_DESC	"Broadcom NetXtreme-C/E RoCE Driver"
@@ -158,8 +157,6 @@ struct bnxt_re_nq_record {
 	struct mutex		load_lock;
 };
 
-#define MAX_CQ_HASH_BITS		(16)
-#define MAX_SRQ_HASH_BITS		(16)
 
 static inline bool bnxt_re_chip_gen_p7(u16 chip_num)
 {
@@ -215,8 +212,6 @@ struct bnxt_re_dev {
 	struct bnxt_re_pacing pacing;
 	struct work_struct dbq_fifo_check_work;
 	struct delayed_work dbq_pacing_work;
-	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
-	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 565762529007..1a020c6f5703 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2152,11 +2152,18 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
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
+					       ib_srq->uobject, GFP_KERNEL))) {
+				rc = -ENOMEM;
+				goto fail_free_srq_page;
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
@@ -2285,6 +2293,19 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 
 	return 0;
 
+fail_respond:
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+		xa_lock(&uctx->srq_xa);
+		__xa_erase(&uctx->srq_xa, srq->qplib_srq.id);
+		xa_unlock(&uctx->srq_xa);
+		free_page((unsigned long)srq->uctx_srq_page);
+	}
+	bnxt_qplib_destroy_srq(&rdev->qplib_res, &srq->qplib_srq);
+	goto fail;
+fail_free_srq_page:
+	free_page((unsigned long)srq->uctx_srq_page);
+fail_destroy_srq:
+	bnxt_qplib_destroy_srq(&rdev->qplib_res, &srq->qplib_srq);
 fail:
 	ib_umem_release(srq->umem);
 exit:
@@ -3475,11 +3496,18 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
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
+			xa_lock(&uctx->cq_xa);
+			__xa_erase(&uctx->cq_xa, cq->qplib_cq.id);
+			xa_unlock(&uctx->cq_xa);
+			free_page((unsigned long)cq->uctx_cq_page);
+		}
+	}
 
 	bnxt_re_put_nq(rdev, nq);
 
@@ -3554,14 +3582,16 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
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
+		if (xa_is_err(xa_store(&uctx->cq_xa, cq->qplib_cq.id,
+				       ibcq->uobject, GFP_KERNEL))) {
+			rc = -ENOMEM;
+			goto free_cq_page;
+		}
 		resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
 	}
 	resp.cqid = cq->qplib_cq.id;
@@ -3574,6 +3604,12 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	return 0;
 
 free_mem:
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		xa_lock(&uctx->cq_xa);
+		__xa_erase(&uctx->cq_xa, cq->qplib_cq.id);
+		xa_unlock(&uctx->cq_xa);
+	}
+free_cq_page:
 	free_page((unsigned long)cq->uctx_cq_page);
 destroy_cq:
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
@@ -4795,6 +4831,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		goto cfail;
 	}
 	uctx->shpage_mmap = &entry->rdma_entry;
+	xa_init(&uctx->cq_xa);
+	xa_init(&uctx->srq_xa);
 	if (rdev->pacing.dbr_pacing)
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED;
 
@@ -4847,6 +4885,8 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *ib_uctx)
 	uctx->shpage_mmap = NULL;
 	if (uctx->shpg)
 		free_page((unsigned long)uctx->shpg);
+	xa_destroy(&uctx->cq_xa);
+	xa_destroy(&uctx->srq_xa);
 
 	if (uctx->dpi.dbr) {
 		/* Free DPI only if this is the first PD allocated by the
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 22bf81668cfb..4c78c183784b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -70,6 +70,8 @@ struct bnxt_re_ah {
 	struct bnxt_qplib_ah	qplib_ah;
 };
 
+struct bnxt_re_user_mmap_entry;
+
 struct bnxt_re_srq {
 	struct ib_srq		ib_srq;
 	struct bnxt_re_dev	*rdev;
@@ -78,7 +80,6 @@ struct bnxt_re_srq {
 	struct ib_umem		*umem;
 	spinlock_t		lock;		/* protect srq */
 	void			*uctx_srq_page;
-	struct hlist_node       hash_entry;
 };
 
 struct bnxt_re_qp {
@@ -113,7 +114,6 @@ struct bnxt_re_cq {
 	struct ib_umem		*resize_umem;
 	int			resize_cqe;
 	void			*uctx_cq_page;
-	struct hlist_node	hash_entry;
 };
 
 struct bnxt_re_mr {
@@ -147,6 +147,8 @@ struct bnxt_re_ucontext {
 	void			*shpg;
 	spinlock_t		sh_lock;	/* protect shpg */
 	struct rdma_user_mmap_entry *shpage_mmap;
+	struct xarray		cq_xa;  /* cqid → ib_uobject, per-context toggle page lookup */
+	struct xarray		srq_xa; /* srqid → ib_uobject, per-context toggle page lookup */
 	u64 cmask;
 };
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index d25fdc458120..ce72db1b4bc3 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2337,10 +2337,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
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
index 263238a6e4cd..0ab3512e56f7 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -22,31 +22,6 @@
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
 
 static int UVERBS_HANDLER(BNXT_RE_METHOD_NOTIFY_DRV)(struct uverbs_attr_bundle *attrs)
 {
@@ -244,12 +219,10 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	enum bnxt_re_mmap_flag mmap_flag = BNXT_RE_MMAP_TOGGLE_PAGE;
 	enum bnxt_re_get_toggle_mem_type res_type;
 	struct bnxt_re_user_mmap_entry *entry;
+	struct ib_uobject *res_uobj;
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
-	struct bnxt_re_dev *rdev;
-	struct bnxt_re_srq *srq;
 	u32 length = PAGE_SIZE;
-	struct bnxt_re_cq *cq;
 	u64 mem_offset;
 	u32 offset = 0;
 	u64 addr = 0;
@@ -265,35 +238,37 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		return err;
 
 	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
-	rdev = uctx->rdev;
 	err = uverbs_copy_from(&res_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
 	if (err)
 		return err;
 
-	switch (res_type) {
-	case BNXT_RE_CQ_TOGGLE_MEM:
-		cq = bnxt_re_search_for_cq(rdev, res_id);
-		if (!cq)
-			return -EINVAL;
+	if (res_type == BNXT_RE_CQ_TOGGLE_MEM) {
+		struct bnxt_re_cq *cq;
 
-		addr = (u64)cq->uctx_cq_page;
-		if (!addr)
-			return -EOPNOTSUPP;
-		break;
-	case BNXT_RE_SRQ_TOGGLE_MEM:
-		srq = bnxt_re_search_for_srq(rdev, res_id);
-		if (!srq)
-			return -EINVAL;
-
-		addr = (u64)srq->uctx_srq_page;
-		if (!addr)
-			return -EOPNOTSUPP;
-		break;
-
-	default:
+		xa_lock(&uctx->cq_xa);
+		res_uobj = xa_load(&uctx->cq_xa, res_id);
+		if (res_uobj) {
+			cq = container_of(res_uobj->object, struct bnxt_re_cq, ib_cq);
+			addr = (u64)cq->uctx_cq_page;
+		}
+		xa_unlock(&uctx->cq_xa);
+	} else if (res_type == BNXT_RE_SRQ_TOGGLE_MEM) {
+		struct bnxt_re_srq *srq;
+
+		xa_lock(&uctx->srq_xa);
+		res_uobj = xa_load(&uctx->srq_xa, res_id);
+		if (res_uobj) {
+			srq = container_of(res_uobj->object, struct bnxt_re_srq, ib_srq);
+			addr = (u64)srq->uctx_srq_page;
+		}
+		xa_unlock(&uctx->srq_xa);
+	} else {
 		return -EOPNOTSUPP;
 	}
 
+	if (!addr)
+		return -EOPNOTSUPP;
+
 	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
 	if (!entry)
 		return -ENOMEM;
@@ -322,7 +297,7 @@ static int get_toggle_mem_obj_cleanup(struct ib_uobject *uobject,
 				      enum rdma_remove_reason why,
 				      struct uverbs_attr_bundle *attrs)
 {
-	struct  bnxt_re_user_mmap_entry *entry = uobject->object;
+	struct bnxt_re_user_mmap_entry *entry = uobject->object;
 
 	rdma_user_mmap_entry_remove(&entry->rdma_entry);
 	return 0;
-- 
2.39.3


