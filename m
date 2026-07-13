Return-Path: <linux-rdma+bounces-23100-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wH+oFlikVGq3ogMAu9opvQ
	(envelope-from <linux-rdma+bounces-23100-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:39:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B31748D0C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:39:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=WzBe4Sdk;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23100-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23100-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9BC83039C6B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CB3B3C11;
	Mon, 13 Jul 2026 08:36:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59B3B3BE1
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 08:36:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931813; cv=none; b=QSZW8Rv6B8CAoASNWsClgqQa6KNa12c6TdPIK1Zkc7zZ1VAutHxxpEhLKTsrlVqqmamVHKY7ju76QZV+sP0UaZaByVwrZJiSoQZKkIA5Gyspz4yx++0jR8XfrXKwfxWANOfAv8q/gSCXDN18jSavX+C9fnSvpZIcrYjruGeo1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931813; c=relaxed/simple;
	bh=jzq9hWZ/tVw8V0zJTPy1nxn6dnLDjmXh+Z2snCud1TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIyP63BqrnFY/OccD+fjbOFbCaCItrt0t17L5GX5SFBrVjr88/azDbT9yg+VxY8XyES5fiVUBYcYlJAqFLSDkz8H6Ar77wznCiPt5ho44Y4yQiwUYK9K3cxhODIWgxxtGyIq0AEGbl4nCgVJ508YgzjNia1MGZy7n3YMt3gNPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WzBe4Sdk; arc=none smtp.client-ip=209.85.221.227
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso995192e0c.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783931810; x=1784536610;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vt+10NsqpD2zobtgPnHP8jsCHwcWJ9lROkhdomgtQVw=;
        b=coz/BtR6DFb1nCy6OaiMleJS0uxLJKScrVStRDkThvAs3oFxlk1ENJzJsy9bWzW3+M
         B0tEnYj/Y9bddOMfO76svx7+dwGOKi0VUWiW8meNuNMfsEWAEEmG6MzQbfO1UIYXabVx
         szrEf5IFcEdHPNWL8q6MsVV5+uivdFGP/iiMx1ywdHZwUelKknf8rVueeoRFKgekZio7
         MT5HZrZPd4hjKEHeBx7aFB10UofwUXWtRvcfWIjf7r+JdhZ4fz8+4CbZ1YBCYAhcwpAg
         yLKEB9ztSWrcC/rfVwgJ4/ExNtPhkcCjOLniDailpv+lcC46uKrgxJJL7rCOHbryqhHb
         fCCw==
X-Gm-Message-State: AOJu0Yxf7mHf+kqsNNcSd6s+QwLZrnDDAw8yPDbeY6vUTBayQVf1ZIG1
	4+L0xeM1NnVg1Xl4KgNu5tdvcRehoMpnTQXgXMxaVPDVDITmlIc2Srl/0QBr+Ddfm2O7DPym+P+
	jzekkc/JvK10u9RdjxaiX3EYAjnyxrw7ud3EKq8Zp/0ojUKq9WK4v1NN0rE+nzj9lSdQWL/UrXQ
	giEeDg/XGm0n3ITHWTOJw6y36eacIRvz+h86FYx1d3ypJY9/K1Xq5EFLNlr1E1rOliJSBxRV9ny
	dftlqS9iiTEdmRaYA==
X-Gm-Gg: AfdE7cm/YHmpjOLMfWen64G5g4sblzXuuVOuwSg3or+2gxkYott3XyknMnWBEDZbLj7
	GObNOe1Ch4qC9cvKVIChQjFZ/kEUmLAqekvwwnmx8IgqiVOgtFRNZ674NuCYbeJ3tksHA3X+AIG
	VaDBBcLU+1eBMSo+5J2s2Kk48AGIeybwTSEF7dAWQrZeglHUgk1hpuoVd7H4gHl38aZiyaZcMeY
	R7bUjBbVab6NFYiyfz0EYb5HVYdO4R1FqbwOxxF/bzxFL4M4E6iB6UKPI9RlOXZ0RcgRIVuRqtX
	y6XRvyNlYiIbXLGgaI+SfbEjRjx1nl3kB7ri4V468WFg/EZzJ3EBmuKfyzBoSKl7/BZLNa2t5Ws
	PwzyHs1YQqr7NUt3pchV1gQemg3ASd+ssuUYWw7SG+yVFYsn02tj0jVfeknakytlVChIyXSfMZq
	41cZ528PDg9daA2E5Yyjb0MwKsKYK+vihAWD5AOhxUg4BHUmYo/g==
X-Received: by 2002:a05:6122:c83:b0:5a0:5805:c8ba with SMTP id 71dfb90a1353d-5bfbf40d913mr4301917e0c.11.1783931810241;
        Mon, 13 Jul 2026 01:36:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5bf83e26f27sm1418905e0c.4.2026.07.13.01.36.49
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 01:36:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc8bde6318so56479235ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783931809; x=1784536609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vt+10NsqpD2zobtgPnHP8jsCHwcWJ9lROkhdomgtQVw=;
        b=WzBe4SdkEv0N8Wa/e6LNb4F4052tQBwOvB6KE2GzcyMr8JZdPKkjhV6TIG/2sQU9WV
         k4Ypl/9pRx5C5HvULfkrjuv4zfcPhD6Tw5EcuUO7zwW2SMimpe5ktqEUbn/ePDTdBuqV
         bhZw3nMFawX8Pgw6mlr77iNTlFx73BA5QFYeM=
X-Received: by 2002:a17:903:b07:b0:2c9:d298:6c06 with SMTP id d9443c01a7336-2ce9f0268c4mr84158405ad.25.1783931808798;
        Mon, 13 Jul 2026 01:36:48 -0700 (PDT)
X-Received: by 2002:a17:903:b07:b0:2c9:d298:6c06 with SMTP id d9443c01a7336-2ce9f0268c4mr84158005ad.25.1783931808235;
        Mon, 13 Jul 2026 01:36:48 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm95005385ad.57.2026.07.13.01.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:36:47 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	alhouseenyousef@gmail.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 2/4] RDMA/bnxt_re: Defer toggle page free to rdma_user_mmap_entry teardown
Date: Mon, 13 Jul 2026 06:58:28 -0700
Message-Id: <20260713135830.1934471-3-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:alhouseenyousef@gmail.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,gmail.com];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23100-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: C4B31748D0C

Fix the page lifetime by making the rdma_user_mmap_entry the sole owner
of the toggle page allocation. Creating the rdma_user_mmap_entry and page
during the CQ/SRQ creation time. Freeing the page is handled when the
mmap free is called. Introduce struct bnxt_re_toggle_mem to carry
the mmap_offset for the lifetime of the GET_TOGGLE_MEM uobject handle.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 40 +++++++++++++++++++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  2 ++
 drivers/infiniband/hw/bnxt_re/uapi.c     | 33 +++++++++++--------
 3 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 1a020c6f5703..9ee2cd0fcda8 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2161,7 +2161,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 			xa_lock(&uctx->srq_xa);
 			__xa_erase(&uctx->srq_xa, srq->qplib_srq.id);
 			xa_unlock(&uctx->srq_xa);
-			free_page((unsigned long)srq->uctx_srq_page);
+			rdma_user_mmap_entry_remove(&srq->toggle_entry->rdma_entry);
 		}
 	}
 	ib_umem_release(srq->umem);
@@ -2275,10 +2275,17 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 				rc = -ENOMEM;
 				goto fail_destroy_srq;
 			}
+			srq->toggle_entry = bnxt_re_mmap_entry_insert(uctx, (u64)srq->uctx_srq_page,
+								      BNXT_RE_MMAP_TOGGLE_PAGE,
+								      NULL);
+			if (!srq->toggle_entry) {
+				rc = -ENOMEM;
+				goto fail_free_srq_page;
+			}
 			if (xa_is_err(xa_store(&uctx->srq_xa, srq->qplib_srq.id,
 					       ib_srq->uobject, GFP_KERNEL))) {
 				rc = -ENOMEM;
-				goto fail_free_srq_page;
+				goto fail_remove_toggle_entry;
 			}
 			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
 		}
@@ -2298,10 +2305,13 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 		xa_lock(&uctx->srq_xa);
 		__xa_erase(&uctx->srq_xa, srq->qplib_srq.id);
 		xa_unlock(&uctx->srq_xa);
-		free_page((unsigned long)srq->uctx_srq_page);
+		goto fail_remove_toggle_entry;
 	}
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, &srq->qplib_srq);
 	goto fail;
+fail_remove_toggle_entry:
+	rdma_user_mmap_entry_remove(&srq->toggle_entry->rdma_entry);
+	goto fail_destroy_srq;
 fail_free_srq_page:
 	free_page((unsigned long)srq->uctx_srq_page);
 fail_destroy_srq:
@@ -3505,7 +3515,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 			xa_lock(&uctx->cq_xa);
 			__xa_erase(&uctx->cq_xa, cq->qplib_cq.id);
 			xa_unlock(&uctx->cq_xa);
-			free_page((unsigned long)cq->uctx_cq_page);
+			rdma_user_mmap_entry_remove(&cq->toggle_entry->rdma_entry);
 		}
 	}
 
@@ -3587,10 +3597,16 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 			rc = -ENOMEM;
 			goto destroy_cq;
 		}
+		cq->toggle_entry = bnxt_re_mmap_entry_insert(uctx, (u64)cq->uctx_cq_page,
+							     BNXT_RE_MMAP_TOGGLE_PAGE, NULL);
+		if (!cq->toggle_entry) {
+			rc = -ENOMEM;
+			goto free_cq_page;
+		}
 		if (xa_is_err(xa_store(&uctx->cq_xa, cq->qplib_cq.id,
 				       ibcq->uobject, GFP_KERNEL))) {
 			rc = -ENOMEM;
-			goto free_cq_page;
+			goto remove_toggle_entry;
 		}
 		resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
 	}
@@ -3609,6 +3625,10 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		__xa_erase(&uctx->cq_xa, cq->qplib_cq.id);
 		xa_unlock(&uctx->cq_xa);
 	}
+remove_toggle_entry:
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
+		rdma_user_mmap_entry_remove(&cq->toggle_entry->rdma_entry);
+	goto destroy_cq;
 free_cq_page:
 	free_page((unsigned long)cq->uctx_cq_page);
 destroy_cq:
@@ -5053,6 +5073,16 @@ void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 	bnxt_entry = container_of(rdma_entry, struct bnxt_re_user_mmap_entry,
 				  rdma_entry);
 
+	/*
+	 * For toggle pages the kernel VA was stored directly in mem_offset
+	 * at creation time (bnxt_re_create_user_cq / bnxt_re_create_srq).
+	 * Free it here — this is the only place it is freed, ensuring the
+	 * page outlives every concurrent bnxt_re_mmap() call that may have
+	 * incremented the entry's reference count.
+	 */
+	if (bnxt_entry->mmap_flag == BNXT_RE_MMAP_TOGGLE_PAGE)
+		free_page((unsigned long)bnxt_entry->mem_offset);
+
 	if (bnxt_entry->dpi_valid)
 		bnxt_qplib_free_uc_dpi(&bnxt_entry->uctx->rdev->qplib_res,
 				       &bnxt_entry->dpi);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 4c78c183784b..b7b33f6acf91 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -80,6 +80,7 @@ struct bnxt_re_srq {
 	struct ib_umem		*umem;
 	spinlock_t		lock;		/* protect srq */
 	void			*uctx_srq_page;
+	struct bnxt_re_user_mmap_entry *toggle_entry;
 };
 
 struct bnxt_re_qp {
@@ -114,6 +115,7 @@ struct bnxt_re_cq {
 	struct ib_umem		*resize_umem;
 	int			resize_cqe;
 	void			*uctx_cq_page;
+	struct bnxt_re_user_mmap_entry *toggle_entry;
 };
 
 struct bnxt_re_mr {
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 0ab3512e56f7..c879f5223ea7 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -213,19 +213,21 @@ DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_NOTIFY_DRV,
 			      &UVERBS_METHOD(BNXT_RE_METHOD_NOTIFY_DRV));
 
 /* Toggle MEM */
+struct bnxt_re_toggle_mem {
+	u64 mmap_offset;
+};
+
 static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
-	enum bnxt_re_mmap_flag mmap_flag = BNXT_RE_MMAP_TOGGLE_PAGE;
 	enum bnxt_re_get_toggle_mem_type res_type;
-	struct bnxt_re_user_mmap_entry *entry;
+	struct bnxt_re_toggle_mem *tmem;
 	struct ib_uobject *res_uobj;
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
 	u32 length = PAGE_SIZE;
-	u64 mem_offset;
+	u64 mmap_offset = 0;
 	u32 offset = 0;
-	u64 addr = 0;
 	u32 res_id;
 	int err;
 
@@ -249,7 +251,9 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		res_uobj = xa_load(&uctx->cq_xa, res_id);
 		if (res_uobj) {
 			cq = container_of(res_uobj->object, struct bnxt_re_cq, ib_cq);
-			addr = (u64)cq->uctx_cq_page;
+			if (cq->toggle_entry)
+				mmap_offset =
+					rdma_user_mmap_get_offset(&cq->toggle_entry->rdma_entry);
 		}
 		xa_unlock(&uctx->cq_xa);
 	} else if (res_type == BNXT_RE_SRQ_TOGGLE_MEM) {
@@ -259,24 +263,27 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		res_uobj = xa_load(&uctx->srq_xa, res_id);
 		if (res_uobj) {
 			srq = container_of(res_uobj->object, struct bnxt_re_srq, ib_srq);
-			addr = (u64)srq->uctx_srq_page;
+			if (srq->toggle_entry)
+				mmap_offset =
+					rdma_user_mmap_get_offset(&srq->toggle_entry->rdma_entry);
 		}
 		xa_unlock(&uctx->srq_xa);
 	} else {
 		return -EOPNOTSUPP;
 	}
 
-	if (!addr)
+	if (!mmap_offset)
 		return -EOPNOTSUPP;
 
-	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
-	if (!entry)
+	tmem = kzalloc_obj(*tmem);
+	if (!tmem)
 		return -ENOMEM;
 
-	uobj->object = entry;
+	tmem->mmap_offset = mmap_offset;
+	uobj->object = tmem;
 	uverbs_finalize_uobj_create(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
 	err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_PAGE,
-			     &mem_offset, sizeof(mem_offset));
+			     &mmap_offset, sizeof(mmap_offset));
 	if (err)
 		return err;
 
@@ -297,9 +304,9 @@ static int get_toggle_mem_obj_cleanup(struct ib_uobject *uobject,
 				      enum rdma_remove_reason why,
 				      struct uverbs_attr_bundle *attrs)
 {
-	struct bnxt_re_user_mmap_entry *entry = uobject->object;
+	struct bnxt_re_toggle_mem *tmem = uobject->object;
 
-	rdma_user_mmap_entry_remove(&entry->rdma_entry);
+	kfree(tmem);
 	return 0;
 }
 
-- 
2.39.3


