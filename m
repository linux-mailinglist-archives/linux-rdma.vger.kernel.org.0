Return-Path: <linux-rdma+bounces-20919-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIWzCTA1C2qgEgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20919-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:50:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9D25704CA
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AB263021B68
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278148C41B;
	Mon, 18 May 2026 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b7tXS3Hx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08E370D63
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119230; cv=none; b=t80pZTkEcNAc1oeCiLbbySyXSZKzMTQ5a91nF4yATmQBdp6CC9is9DN00ahZGkvBnE2Od0yvVqGUO93wm2uzHQkoH6vs680TYnJcAtgYcxKuX/6/7gLeVrRVgb5+Eocmk+LGuO9t4HLo19heUqxjVAs8Jq1lx6zs3W0Hsih6uuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119230; c=relaxed/simple;
	bh=ywzOCWxdvCHvCjMdFj3myQHz6aAOarwACMoljeznHzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVhRw6N7tbxd7JtG9XHDH251dZxoTQuOuhxzy1wikdZihXOefKGeBLMLel1SBnQrSlHdLhyH/AbjnbieGqi2VBNFPP8LStytGLXnGSy88HisIOJv0OGjByFJDurgJ4O8cqlbMuMubgt/RuTEvCfrxGE8+mDNxE44/iU76FvCeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b7tXS3Hx; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2ba856db1c0so18502365ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119220; x=1779724020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YZztpL0TodEzzK65k+7saogZn2KkDHLiGIEeRdXBxg=;
        b=Ix6mywbNb4oqQLDzpJQR2Da2zlHZpZRjuQ+v9mdroqjuB0luHBuX5Rxzu/h3HEukbA
         572tyiLEcdvrClK3xYmKloixGWMRIJ/7kJ5RzHn6FxTE9BlTAxSQUOKIw+PpoxbrZq0A
         UEJKlJdjyuTXa0JEoqrTzHclHMui/NUOR/I25qAMNZex1wRhdad3c1cqLUmu2MiKwNwS
         z/hlSxUTOglROD8uKonBTA0zhptMMFyb0DQn2ic6NWpWmos0/j6OmKDjMHXn2QyU+ljQ
         zByXMLCzd8nDtFViD+gpfI37R9d1GiyeGJpJWVcnbIgXVQbXHy8jV/LblUpsU9EjbUVH
         BnuA==
X-Gm-Message-State: AOJu0YyXi305WChrJr3axFZks3fYMm2XIm5rH6S3TmIs2J9GoZFx5Su9
	p9tiTYbAiSJLR7b7dEGk4fIc+A+vyhNz0bdbGcHPMFVU8cBs9R8gYcKC6JRYV+Gt7ZUoueoIpcn
	Tyevje8jPsyFqiQOoW1Gc+oqUKzp+xMAbkRQFhOgFyKW3DpzHHnPH0Jr9QZBKEZBig1Qx5WJXuf
	nL5hgpg5A3v8hfuz8moIKj2rq1i5xMskQi9tqqGKMpflfkA4nDN+qsa9ncaSfM49qcabwiwxdVb
	m9/zmelQkfZazSrtktNYDoZznaO
X-Gm-Gg: Acq92OGtFgvFNGac03ZfrkKMCap4NKJ3C/7RGUUC6dWk4Z5vrpwrEQGpqRndwKHhlZP
	TxRnheFFqzE00y3Z2GYKzZKNkLBRrgMn2RDwyMzLXQTo5Edik1bIm95yv5CCdZfqcl5kAe8thLS
	3oZvBTh/4BJuXWHdcTqivZi1T0j4GeWk/RrezS89Ju2OaRnlfBL2LdYHVazIxoRqUUlZt6CDs6O
	6rTLYajf+F97p9YsT8Ww4Y/aSDqWxVwK9ivAZ79wx3gpS7HUdYQE5qzUN0gfOBBKYxTseKDwEaT
	/OOHnSBmNGItd5ekVzEv1nbUPv7hPlygnFdYh/U+TBQ85pHvrXiqK9JF5G/inXP4eM0fU2Lg2OS
	BxtXMjiNj7QIy7m7DxgyAB7raahmo0kyytuWwVVgKMydxOmKLcIk8POh/pzpuTY0SXAsYMrCFhF
	LFEvPaXys87cshNTqPfD0I8LIPf69yxHvqT6k9QCuYmBCBdYlXafYuwubOZIxdn4gTTnm5
X-Received: by 2002:a17:902:cf09:b0:2bd:3d5b:e87c with SMTP id d9443c01a7336-2bd7e8f183bmr181400415ad.37.1779119219989;
        Mon, 18 May 2026 08:46:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bd5ced1174sm11293825ad.28.2026.05.18.08.46.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 08:46:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so37471055ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779119218; x=1779724018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YZztpL0TodEzzK65k+7saogZn2KkDHLiGIEeRdXBxg=;
        b=b7tXS3HxsBE/UTYz/1GoGJzUz5EAhO0smbcJvbNuH9CZWYy5qozmEKHbDxGVRgseCg
         XZbaO4Xzp4aolj8Xsyk5oiuIb8X5Bb9RO1edgVPNb7yyC87B3VNEPLp0WqB7FOKooddm
         E05DXAktlDY9aW3IC/fiGOf1N8V68Oof00FSU=
X-Received: by 2002:a17:903:11cf:b0:2bd:bd27:e234 with SMTP id d9443c01a7336-2bdbd27e463mr89335965ad.21.1779119218087;
        Mon, 18 May 2026 08:46:58 -0700 (PDT)
X-Received: by 2002:a17:903:11cf:b0:2bd:bd27:e234 with SMTP id d9443c01a7336-2bdbd27e463mr89335715ad.21.1779119217546;
        Mon, 18 May 2026 08:46:57 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d2360e8sm163954285ad.82.2026.05.18.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:46:56 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 6/9] RDMA/bnxt_re: Enhance dbr usecnt logic in doorbell uapis
Date: Mon, 18 May 2026 21:07:18 +0530
Message-ID: <20260518153721.183749-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20919-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2C9D25704CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current logic in the doorbell cleanup function is not
sufficient for a change in a subsequent patch, that fails
doorbell remove operation in some conditions. The cleanup
should facilitate freeing of the dbr object when the caller
may not retry the teardown operation (implicit teardown:
process-exit/driver-removal).

Extend this counter to use kref mechanism so that the dbr
object gets freed (via kref callback) when there are no more
references to it, rather than directly freeing it in the
cleanup uapi.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  3 ++-
 drivers/infiniband/hw/bnxt_re/uapi.c     | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 08f71a94d55d..13dac48ed453 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -167,7 +167,7 @@ struct bnxt_re_dbr_obj {
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_dpi dpi;
 	struct bnxt_re_user_mmap_entry *entry;
-	atomic_t usecnt; /* QPs using this dbr */
+	struct kref usecnt; /* 1 (uobject) + n (QPs using this dbr) */
 };
 
 struct bnxt_re_flow {
@@ -308,4 +308,5 @@ void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
 struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset);
+void bnxt_re_dbr_kref_release(struct kref *ref);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 3eaee7101615..b8fc8bfba2ad 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -369,6 +369,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *a
 	}
 
 	obj->rdev = rdev;
+	kref_init(&obj->usecnt);
 	uobj->object = obj;
 	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_DBR_HANDLE);
 
@@ -391,15 +392,24 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *a
 	return ret;
 }
 
+void bnxt_re_dbr_kref_release(struct kref *ref)
+{
+	struct bnxt_re_dbr_obj *obj =
+		container_of(ref, struct bnxt_re_dbr_obj, usecnt);
+	struct bnxt_re_dev *rdev = obj->rdev;
+
+	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
+	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
+	kfree(obj);
+}
+
 static int bnxt_re_dbr_cleanup(struct ib_uobject *uobject,
 			       enum rdma_remove_reason why,
 			       struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_dbr_obj *obj = uobject->object;
-	struct bnxt_re_dev *rdev = obj->rdev;
 
-	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
-	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
+	kref_put(&obj->usecnt, bnxt_re_dbr_kref_release);
 	return 0;
 }
 
-- 
2.51.2.636.ga99f379adf


