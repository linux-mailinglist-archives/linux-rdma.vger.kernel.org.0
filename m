Return-Path: <linux-rdma+bounces-22247-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z75xCdk1MGoUQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22247-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:26:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B51688D7F
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:26:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="DumQd/Fy";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22247-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22247-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3B10302D4D3
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE3416D05;
	Mon, 15 Jun 2026 17:25:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CE416D03
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544345; cv=none; b=iLXEhNH+aFKhQDFvcHanlabcXmsoM3ftxviqYaf5srn3d2r1k+8vJdLseRlvwhDzl+/xFADf/DGaEjvdw3mIG4F4/PgevhN83v3RBj4FNLpFM+teZbS6wTAMFjdoDiXBIGAjuxzFeIsGrjjTNmQj0pA7TQo6Slyq9DKloWdZ7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544345; c=relaxed/simple;
	bh=ka57qBs0JroYcPdXKGYFwtmIrO8k5IFM2igBEGDvGBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhVYUiol43ZTvkKemm2vWZR9repq2lRrgAhcAy4GEv5uyR5HYsJvCTyL/pZhXgtBYWNFxiQEy5pq4XaRxhVbkuZ8qONRv4dXiL6xRNLgtH4StVJEejbQYfpPyFM/IaUyco3CBln47p7LUk9WSUDuLscEyMtfeWr6GvI28vLvYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DumQd/Fy; arc=none smtp.client-ip=209.85.214.225
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2c0a5354da1so28867555ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544343; x=1782149143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbeOvFYcdo3wCkMrYnQLx0c8yI4Gygx+970Boe1QnQE=;
        b=qsispfTywz5nGX//OS5yiHjksWkE4HglEkV18ylYYt4YXBMsHgdExkwlKpHverdoEN
         3flScpABBS0EZnm2d6XDCkcesGv6iLZSSW+ofeoCPSBBEUUThaY94w+EpewXUKXckFpE
         1MVt2Gju0vX0i0L1tcu57qsYvLlXw6mo27s79HifBNwoD2uyUzZZx0txg+0AOVCw+oCw
         ORL2zqPUrw1JdQ9SRt6hXF6ZNt+xBHGGVt7B4U5/f5fLvVHQufUdc5kCVettFWn6CQzR
         rAP4MkmSzarJ7lvCj3qH3v0QwE1LB6kLt+QGM2w7fjC9MxgLyMopIptmcHH/Jd3tb2o3
         JseQ==
X-Gm-Message-State: AOJu0Yxgo6mBGy84sneSfy5FaV024Rr8oQ0HNDQvYqMABWe75BVAyWM+
	LbiTcGXnvscZAxmqHfDZcwBqCxs4hoqBIiOo61/+7NTbjNvVrQGZSgHI1RpdTBoCoK+Jw/uk6HL
	ZT/YWrkuGm2Sr9EBn/NLuqcnfXcTBagGLJOjQzNTMD2e5oJGsVuZzI+eRUVfJlCSVLcP9QfQYY3
	2GRkwaBq9rUj3cbiwdcik7f7991Gw8yab95ob21KRxZ0UAkjc9b8w4ISGvanyj7r+qj54hVuwiK
	63fIGAp5U054yxC2w==
X-Gm-Gg: Acq92OEKvNRZ+WL17z6x8h+6U5zHm8Fp7cxoQ0Jn9U8sossIjLtlegs2thRjrjMvWi6
	D7X/BUgQNndkZ0sxhc10APEoL4rciGca+AmVit1iFUYBx+OnCZJe5Qo5AgZUeRBNPRnOcj84spp
	rMN7nmQXYV+EVKDRXvhp+s6yEmhy1yeOsJuCeYfqVgxcPebjdBUAbRCWjDIVTyJ/Ig7FjA1CVDS
	Vhk5zGNJWUI6+4AwK76Pwbfgn90SAaCzOG/8gfChWepG8ZiRIbL9+faEstMlyD/iIdviWU7SKp1
	+63gPh8r09Sf/SYwmjWWvuCah0SLuBPrlubucz1efHowE2ofB3/8FR13mZ9NwSihxHle5PxM5zK
	TzAH3q1YU2WcxX1XlZIaoljIid4MYJDQjl69zseBGH64fj3ZoG3qjmjpLLMIq75ONSoFaQ39CCi
	T5qteU9qEOViLkjtjUXraGiCAvIHWDUOrbzuQvkVB5jowGKrr5brQ6MZQAg6AS
X-Received: by 2002:a17:902:e84a:b0:2bf:2ea3:af30 with SMTP id d9443c01a7336-2c699a8bcdamr3296865ad.4.1781544342735;
        Mon, 15 Jun 2026 10:25:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c4329a3c78sm8660675ad.26.2026.06.15.10.25.42
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b1bb53a8so23094445ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544341; x=1782149141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbeOvFYcdo3wCkMrYnQLx0c8yI4Gygx+970Boe1QnQE=;
        b=DumQd/FyY36VB4k3oauF4ULHTCpuM0prTGSEs+fVF8YOGq6rfXMYEut/qUAtaYcoIf
         9hqme144wUR8leCCSyJj6zsXUeP/gPAN5cUEiS+Qid52c6LPhbAkZD9vy1NH4eDxvgyf
         FxL1v0NU22K2KPPBWpshYaGu9lnL9COOqhzks=
X-Received: by 2002:a17:903:8cd:b0:2c6:829b:b0c2 with SMTP id d9443c01a7336-2c699ac621dmr3547515ad.11.1781544341071;
        Mon, 15 Jun 2026 10:25:41 -0700 (PDT)
X-Received: by 2002:a17:903:8cd:b0:2c6:829b:b0c2 with SMTP id d9443c01a7336-2c699ac621dmr3547195ad.11.1781544340478;
        Mon, 15 Jun 2026 10:25:40 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:40 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 05/15] RDMA/bnxt_re: Avoid any race while handling the hash list of SRQ
Date: Mon, 15 Jun 2026 15:47:41 -0700
Message-Id: <20260615224751.232802-6-selvin.xavier@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-22247-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5B51688D7F

Add/Delete to/from hash list needs to be synchronized with the traversing
of the hash list. Add a mutex for this synchronization to avoid any usage
of the SRQ structures after the SRQ is freed.

Fixes: 181028a0d84c ("RDMA/bnxt_re: Share a page to expose per SRQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 29 ++++++++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  3 +++
 drivers/infiniband/hw/bnxt_re/main.c     |  1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     |  4 ++++
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index c346dec14dec..5fec474fcc2e 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -218,6 +218,7 @@ struct bnxt_re_dev {
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
 	struct mutex			cq_hash_lock;  /* guards cq_hash  */
+	struct mutex			srq_hash_lock; /* guards srq_hash */
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e74f19c5038a..43a2aedc4819 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2137,6 +2137,19 @@ static enum ib_mtu __to_ib_mtu(u32 mtu)
 }
 
 /* Shared Receive Queues */
+/* Shared Receive Queue lifetime helpers */
+static void bnxt_re_srq_release(struct kref *ref)
+{
+	struct bnxt_re_srq *srq = container_of(ref, struct bnxt_re_srq, srq_ref);
+
+	complete(&srq->srq_destroy_comp);
+}
+
+void bnxt_re_put_srq(struct bnxt_re_srq *srq)
+{
+	kref_put(&srq->srq_ref, bnxt_re_srq_release);
+}
+
 int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 {
 	struct bnxt_re_srq *srq = container_of(ib_srq, struct bnxt_re_srq,
@@ -2149,10 +2162,18 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT && srq->uctx) {
+		mutex_lock(&rdev->srq_hash_lock);
 		hash_del(&srq->hash_entry);
+		mutex_unlock(&rdev->srq_hash_lock);
+		/* Drop the creator's reference and wait for any concurrent
+		 * bnxt_re_search_for_srq() caller to finish with the pointer.
+		 */
+		kref_put(&srq->srq_ref, bnxt_re_srq_release);
+		wait_for_completion(&srq->srq_destroy_comp);
+	}
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
-	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT && srq->uctx)
 		free_page((unsigned long)srq->uctx_srq_page);
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
@@ -2260,7 +2281,11 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 
 		resp.srqid = srq->qplib_srq.id;
 		if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+			kref_init(&srq->srq_ref);
+			init_completion(&srq->srq_destroy_comp);
+			mutex_lock(&rdev->srq_hash_lock);
 			hash_add(rdev->srq_hash, &srq->hash_entry, srq->qplib_srq.id);
+			mutex_unlock(&rdev->srq_hash_lock);
 			srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
 			if (!srq->uctx_srq_page) {
 				rc = -ENOMEM;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index aaec5dbc322e..1456fdc3935b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -79,6 +79,8 @@ struct bnxt_re_srq {
 	spinlock_t		lock;		/* protect srq */
 	void			*uctx_srq_page;
 	struct hlist_node       hash_entry;
+	struct kref		srq_ref;
+	struct completion	srq_destroy_comp;
 };
 
 struct bnxt_re_qp {
@@ -247,6 +249,7 @@ int bnxt_re_modify_srq(struct ib_srq *srq, struct ib_srq_attr *srq_attr,
 		       struct ib_udata *udata);
 int bnxt_re_query_srq(struct ib_srq *srq, struct ib_srq_attr *srq_attr);
 int bnxt_re_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
+void bnxt_re_put_srq(struct bnxt_re_srq *srq);
 int bnxt_re_post_srq_recv(struct ib_srq *srq, const struct ib_recv_wr *recv_wr,
 			  const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *qp_init_attr,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 902eda6011ad..8e89218bd666 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2343,6 +2343,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	mutex_init(&rdev->cq_hash_lock);
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
 		hash_init(rdev->srq_hash);
+	mutex_init(&rdev->srq_hash_lock);
 
 	bnxt_re_debugfs_add_pdev(rdev);
 
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index a0cd2dce6168..1d7031a23b02 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -42,12 +42,15 @@ static struct bnxt_re_srq *bnxt_re_search_for_srq(struct bnxt_re_dev *rdev, u32
 {
 	struct bnxt_re_srq *srq = NULL, *tmp_srq;
 
+	mutex_lock(&rdev->srq_hash_lock);
 	hash_for_each_possible(rdev->srq_hash, tmp_srq, hash_entry, srq_id) {
 		if (tmp_srq->qplib_srq.id == srq_id) {
+			kref_get(&tmp_srq->srq_ref);
 			srq = tmp_srq;
 			break;
 		}
 	}
+	mutex_unlock(&rdev->srq_hash_lock);
 	return srq;
 }
 
@@ -263,6 +266,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 			return -EINVAL;
 
 		addr = (u64)srq->uctx_srq_page;
+		bnxt_re_put_srq(srq);
 		break;
 
 	default:
-- 
2.39.3


