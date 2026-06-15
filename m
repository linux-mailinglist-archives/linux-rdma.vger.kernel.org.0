Return-Path: <linux-rdma+bounces-22246-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j8i3OdM1MGoTQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22246-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:26:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A8688D7C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:26:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=XflPIKxq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22246-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22246-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C5F730241AC
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84BB416CE3;
	Mon, 15 Jun 2026 17:25:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97741325C
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544341; cv=none; b=JviEaFM0FdFU02ktNSST47edayrm94s4QewdIQk3P+Qb76qPdUAasfzwY/COAtRkrk49DBKnEbf9BgA2bkV4Z3DdCVpLRDleJWI7ePJxBwf0MmpdrdygvW/0PlMSjebbqnYt6W0IwzLfzK6GdZL5qX6TXJl8s1yjbHdGZ3xtSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544341; c=relaxed/simple;
	bh=XOxCUDuhObVQev38tnOAlJC5FoD0UABYAzLDqLLxLQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taCnmW/vVEX03T3E7/p2de95LX9tyw0KDQIKFp/Du/JD57ieH2f+df+OvCZbC+VrZN0oslVe3qNG8CW7CNP6Al5yX6qSJfhOgpbjethWej3213SbsvB2apR1GNKx+1F7dIzsO/1eCuhQUyH8aUxbCksFok5iFE3AKN9Q2ravplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XflPIKxq; arc=none smtp.client-ip=209.85.160.228
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-51764768c36so50573951cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544339; x=1782149139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3KryRWfNVCMGA2hDA4beI2+Z+nqA4sjMlWTo5p9oEk=;
        b=oBLEgM2RCUY1japFz6TUjvF/xiRUfbdPnIgNBu7VnEQTI5BUuMfgBs1VGvO9tikyjd
         ZjDwK8O4rteCsafoYEAjqlK1+Xvdc5RPVV/RU60Yh3aAluXNVH4beQlZ31/DuLgB45aw
         5Mey5fzk3/Bn4oVONG8LXzFxjiUk9DoWxxxgTgClyOrsUzb87zOMe3eBHU6BEYikTJJU
         XdBaHtrx/5BuQCMVN9fyAk5cA+zzYVFPLB8/btlcQ2UCcaNH+G48iURxmzXacE/zD0lx
         KVSYTKoTzXtai/r0s93SYx55PlTkWeg6woBXxUGTjr9CA4o1KrzRV+ZYh/xN1pgYeLM4
         w8rA==
X-Gm-Message-State: AOJu0YzDQPHjXJi5d3QduxBnjrthRsOCfEAZr9xE1ircYfYPmOkngjtr
	HMJL8S7BQBs8jKfiVP1nw+RJ/Sbf2S1dYbqI8dTawWZgqJzqRIPqRoqUCvEuyS8JOWub3d8A/C8
	tfnwAa5bF5Y/EyR2/zIBNwCLxSN9b+ANdao/GRLVzCrrujUGMafmlqEqW7GxFBvp8pKsREIR6y0
	vVkt2yKDG09h6gAW1exFST3qXQJl0ICrsEBZkX1dTg5QMI5awF62DL0UM1AeEk+j8JFl0e1GhMS
	aNIq7XlTB1R5T34sw==
X-Gm-Gg: Acq92OFl6qMYB6OC1U+gBje9YVwYQZylJhvvi9ODxf+iyo8g8mWAPqRoRN0vZNc5VF6
	N/SFfx1hJXm/xlFQU2PYoqBP1ICz5Id4TO+IL7vQFu7dNXxF2Tf3eYYE5Wvo9mXciy2FJrL4nmR
	Xu6a6Iu73tW+m2ysJ77Ubjqvw1YEihE+6ObDJK2KCK22d0mKFF/wxn0RDDHmqoSkK+QLTD5d5VN
	qalmL6Rh73XgDfSb04YX4QDTt9eCrnj03LUoQT5qZ+8itXTMmrwQyBHr2enXBlO2RKzyoKUohRp
	anSNDVI/iD9eBI44ah7QCLKIBr7+ACIZdLIdhI0/snpwQVuSx9XVgXzBlt6yd9y8/LPpn/eWpbR
	SV7yIdaQ25MxQMqzBYl+FmUG5vkmIComsrX5PqxdBEpqwVfLHO+JIQEZR7q2J4fzo/1ewgZi9Fo
	OTsbicmyhCv5Bl9wptNxptX5eZVXatw/PJes/hf7V6pJZSAO9QwNCUcqX9SouD
X-Received: by 2002:a05:622a:2d2:b0:517:a7ff:935f with SMTP id d75a77b69052e-519534dbeeamr184713671cf.9.1781544338960;
        Mon, 15 Jun 2026 10:25:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-517fb61ad01sm5367971cf.2.2026.06.15.10.25.38
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d99181eaaso4561499a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544338; x=1782149138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3KryRWfNVCMGA2hDA4beI2+Z+nqA4sjMlWTo5p9oEk=;
        b=XflPIKxqlWD7XgCbjntS3eYHWQxciywfTZT3A/B4U6hV2nt83OPutOL0ISqqj9h8Pt
         sSqEm+6TpzyA7FbHXW5xxouJOINy6SVG1aUUhLg/vy7GI6yRYrIJiHCuBfBQNb18zmaC
         +yXQzf+SHOJgxlJcHaPpYtu3Sm0iWddIofURQ=
X-Received: by 2002:a17:902:f64e:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2c664242da9mr128804745ad.24.1781544337796;
        Mon, 15 Jun 2026 10:25:37 -0700 (PDT)
X-Received: by 2002:a17:902:f64e:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2c664242da9mr128804425ad.24.1781544337319;
        Mon, 15 Jun 2026 10:25:37 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:36 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 04/15] RDMA/bnxt_re: Avoid any race while handling the hash list of CQ
Date: Mon, 15 Jun 2026 15:47:40 -0700
Message-Id: <20260615224751.232802-5-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260615224751.232802-1-selvin.xavier@broadcom.com>
References: <20260615224751.232802-1-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22246-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 572A8688D7C

Add/Delete to/from hash list needs to be synchronized with the traversing
of the hash list. Add a mutex for this synchronization. Also add a
reference for the CQ to avoid any usage of the CQ structures after the
CQ is freed.

Fixes: e275919d9669 ("RDMA/bnxt_re: Share a page to expose per CQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 28 ++++++++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  3 +++
 drivers/infiniband/hw/bnxt_re/main.c     |  1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     |  4 ++++
 5 files changed, 35 insertions(+), 2 deletions(-)

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
index 05b5b5936433..e74f19c5038a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3435,6 +3435,18 @@ static void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
 }
 
 /* Completion Queues */
+static void bnxt_re_cq_release(struct kref *ref)
+{
+	struct bnxt_re_cq *cq = container_of(ref, struct bnxt_re_cq, cq_ref);
+
+	complete(&cq->cq_destroy_comp);
+}
+
+void bnxt_re_put_cq(struct bnxt_re_cq *cq)
+{
+	kref_put(&cq->cq_ref, bnxt_re_cq_release);
+}
+
 int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
 	struct bnxt_qplib_chip_ctx *cctx;
@@ -3452,10 +3464,18 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT && cq->uctx) {
+		mutex_lock(&rdev->cq_hash_lock);
 		hash_del(&cq->hash_entry);
+		mutex_unlock(&rdev->cq_hash_lock);
+		/* Drop the creator's reference and wait for any concurrent
+		 * bnxt_re_search_for_cq() caller to finish with the pointer.
+		 */
+		kref_put(&cq->cq_ref, bnxt_re_cq_release);
+		wait_for_completion(&cq->cq_destroy_comp);
+	}
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
-	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT && cq->uctx)
 		free_page((unsigned long)cq->uctx_cq_page);
 
 	bnxt_re_put_nq(rdev, nq);
@@ -3531,7 +3551,11 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	spin_lock_init(&cq->cq_lock);
 
 	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		kref_init(&cq->cq_ref);
+		init_completion(&cq->cq_destroy_comp);
+		mutex_lock(&rdev->cq_hash_lock);
 		hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
+		mutex_unlock(&rdev->cq_hash_lock);
 		/* Allocate a page */
 		cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!cq->uctx_cq_page) {
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 4d6d1259a795..aaec5dbc322e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -114,6 +114,8 @@ struct bnxt_re_cq {
 	int			resize_cqe;
 	void			*uctx_cq_page;
 	struct hlist_node	hash_entry;
+	struct kref		cq_ref;
+	struct completion	cq_destroy_comp;
 };
 
 struct bnxt_re_mr {
@@ -265,6 +267,7 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
 		      struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
+void bnxt_re_put_cq(struct bnxt_re_cq *cq);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
 int bnxt_re_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
 struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *pd, int mr_access_flags);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a892f1172917..902eda6011ad 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2340,6 +2340,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 			bnxt_re_vf_res_config(rdev);
 	}
 	hash_init(rdev->cq_hash);
+	mutex_init(&rdev->cq_hash_lock);
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
 		hash_init(rdev->srq_hash);
 
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index b9922360f11b..a0cd2dce6168 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -26,12 +26,15 @@ static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq
 {
 	struct bnxt_re_cq *cq = NULL, *tmp_cq;
 
+	mutex_lock(&rdev->cq_hash_lock);
 	hash_for_each_possible(rdev->cq_hash, tmp_cq, hash_entry, cq_id) {
 		if (tmp_cq->qplib_cq.id == cq_id) {
+			kref_get(&tmp_cq->cq_ref);
 			cq = tmp_cq;
 			break;
 		}
 	}
+	mutex_unlock(&rdev->cq_hash_lock);
 	return cq;
 }
 
@@ -252,6 +255,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 			return -EINVAL;
 
 		addr = (u64)cq->uctx_cq_page;
+		bnxt_re_put_cq(cq);
 		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
 		srq = bnxt_re_search_for_srq(rdev, res_id);
-- 
2.39.3


