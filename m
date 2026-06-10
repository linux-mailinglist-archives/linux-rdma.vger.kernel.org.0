Return-Path: <linux-rdma+bounces-22062-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lqYEKt3sKGpcNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22062-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 276EC665D06
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=CAwJHvMR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22062-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22062-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C3A30EE7A7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5644335DA42;
	Wed, 10 Jun 2026 04:46:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B02DA749
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066814; cv=none; b=j6KzllJ22xOz0x2m/kjBjcURBmjc+uxwq34OHbdlZHbPjraCtzeWuasROalw4Rx2115VjtIC7iLP8ylmW55VADfmyVgqrdWv99S4GmFJQLw+osp1VQscTcvxeLFqWC9Xfyxt3/Sg9QVUyfB/9LcKg9g4+RhWrbRjCWPjoa5zQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066814; c=relaxed/simple;
	bh=ZNn4KwJgTZv7NqpjWmoRQNIHd2H3ogFEtKX50pa1Euo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASYEe9kJQcmgQWmSWiYwbaU5D5TgVQE0gr77XpcN47b1/8BwznIuJXkb26Qx7lBxd1gA91yjRoUUy2rbLHWIPiNiOm4lnGRDuQrWC7FPeDcprriOTayT7PNUzg8F+4/fFjVmKZ64G9dwPsrsi3efC1w3xQlCCu1dP+yhLqBqFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CAwJHvMR; arc=none smtp.client-ip=209.85.214.227
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2c0b9328c4aso43776025ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066812; x=1781671612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNOo8e+qytJGuXppzMjF/iflAHvf+YDJ/Yhh16dy7Rg=;
        b=IMYFBEAA8qioYet5pOH5iU3XTkkfXi6iu5mLnuSPa+nhfEsDWnE2py+qDfbSfGI4Mr
         xmNX4hczR6HWkH2UcZYTmWNTzhjbA2TmtG5THoWk5Byg33Y0y/DYeORMB6D+AKqHR2Zm
         u6pAkInLVSZVLWQkajwaZbVfDjC1Vk+joPQU2vMya3XBys4KHP0OyvrEO13UkteC7mDh
         PEqbOurDKb/fhVs4A6TdTk0IW5zh+xqA8eDSnWpDb8X7qMnCvY1VndvapG2XoI2nZ/K5
         yF4i9LIgrQmM+xZ5YdH0z31cWA8JtEN15jqq5H6NloQOifmWTWTkh5DLW++PZHTAJLsa
         TdIg==
X-Gm-Message-State: AOJu0YydD95vnfaHiEWGUgZM3t1PN49PgFY+y/ltgOtEIQVIbLkwQLMc
	CKX++euJIC/Nq4O7fvyk5j3siyZ1rTfpbr/CWfv2YxoxOWXeAMuSRdBno89b0o/tyjEVRN1iATz
	DAgQZYq0PjbTPii+ZGDEjhOUortKB2r1Nv5VAJcsvxFUXB+CNT6pOqnmergK9RP2SDbt8nYLIDD
	kgvdIkFZTEit8sUVvFf5E7aP7JKKtqWDsOAHNZUcABSddVSpKkXWc8DkntPXrX+XLwW7RWseVKD
	VYhm3jms+FbAmcwUQ==
X-Gm-Gg: Acq92OGSfWZNMWnRpFLbzstpmGABVFrY0Rh1uNTcp7aCtYnpchobah4f37j8xtcv0OF
	z3SfCmGxMsOQCVmaQnK3b2IMhm8fAuGl/Z870upZg0xf1a2t+OEFi53zHUNmLFDtZgIr7yvvH2L
	2mkvyXz7vhRzQk7NDkkVKNdYON2B1jLPIU42Vch2vbANVG6HZoWRz+LS3T7miQK5yzo5dN8IL+Q
	2DsJv4KX8WfvdhpPFgcXGk5kG+miMwS859SwcY4WdFZgRtA+ZdQBhN/OXg/iAZE+vcznJZA7G2L
	OJ2v3VFr4lNAwADKov849Gb2kR91KNcx2MXwMIZeYWIe6vFq55M8wcmSUCsYreVghnR0MgXQtok
	505uNHSm/LTxDU2wNxTAlINdSC/QOeTlXHbuIfUCtWUuerzDiqHJ8+dbzk+NCNMIiX9EuPzPy8V
	nFmEviygyz8uquBJFR2z9ypmQi7qJvhypLsXdEzxy9PiS16E992bqnsZhm9/UOcyan31Gch+8=
X-Received: by 2002:a17:903:22d2:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2c2a1cb92f6mr68514995ad.37.1781066812147;
        Tue, 09 Jun 2026 21:46:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c164f71acbsm22852105ad.11.2026.06.09.21.46.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85a2c129b3so2985402a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066810; x=1781671610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNOo8e+qytJGuXppzMjF/iflAHvf+YDJ/Yhh16dy7Rg=;
        b=CAwJHvMRJe/I04Xi1tLLHNHki2hWesyv+iOAkkkW9VWljqGm6FobPdIxuI5jREQncf
         tdGNKatXio20W9AvG9cE+4wvAqD1a+kCF5oD/u6T65FAReknNCHv0VycNt6XGNV8nTcb
         i2jkhntQaQDXNgYbaKKcG0FQ7saKWivpQzISU=
X-Received: by 2002:a05:6a00:139a:b0:83f:2568:d466 with SMTP id d2e1a72fcca58-8430a73bec0mr6735982b3a.31.1781066810600;
        Tue, 09 Jun 2026 21:46:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:139a:b0:83f:2568:d466 with SMTP id d2e1a72fcca58-8430a73bec0mr6735964b3a.31.1781066810188;
        Tue, 09 Jun 2026 21:46:50 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:48 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 07/11] RDMA/bnxt_re: Avoid any race while handling the hash list of CQ
Date: Wed, 10 Jun 2026 03:08:51 -0700
Message-Id: <20260610100855.64212-8-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260610100855.64212-1-selvin.xavier@broadcom.com>
References: <20260610100855.64212-1-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22062-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 276EC665D06

Adding/Deleting to/from hash list needs to be synchronized
with the traversing of the hash list. Adding a mutex for this
synchronization to avoid any usage of the CQ structures
after the CQ is freed.

Fixes: e275919d9669 ("RDMA/bnxt_re: Share a page to expose per CQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++++
 drivers/infiniband/hw/bnxt_re/main.c     | 1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3a7ce4729fcf..c346dec14dec 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -217,6 +217,7 @@ struct bnxt_re_dev {
 	struct delayed_work dbq_pacing_work;
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
+	struct mutex			cq_hash_lock;  /* guards cq_hash  */
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index eb428d2409d6..15d54b718dbe 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3458,7 +3458,9 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
 		free_page((unsigned long)cq->uctx_cq_page);
+		mutex_lock(&rdev->cq_hash_lock);
 		hash_del(&cq->hash_entry);
+		mutex_unlock(&rdev->cq_hash_lock);
 	}
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
 
@@ -3536,7 +3538,9 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	spin_lock_init(&cq->cq_lock);
 
 	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		mutex_lock(&rdev->cq_hash_lock);
 		hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
+		mutex_unlock(&rdev->cq_hash_lock);
 		/* Allocate a page */
 		cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!cq->uctx_cq_page) {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index d25fdc458120..8e6257a4e048 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2338,6 +2338,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 			bnxt_re_vf_res_config(rdev);
 	}
 	hash_init(rdev->cq_hash);
+	mutex_init(&rdev->cq_hash_lock);
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
 		hash_init(rdev->srq_hash);
 
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index abd8f90ca0fb..5f56db41a445 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -26,12 +26,14 @@ static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq
 {
 	struct bnxt_re_cq *cq = NULL, *tmp_cq;
 
+	mutex_lock(&rdev->cq_hash_lock);
 	hash_for_each_possible(rdev->cq_hash, tmp_cq, hash_entry, cq_id) {
 		if (tmp_cq->qplib_cq.id == cq_id) {
 			cq = tmp_cq;
 			break;
 		}
 	}
+	mutex_unlock(&rdev->cq_hash_lock);
 	return cq;
 }
 
-- 
2.39.3


