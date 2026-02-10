Return-Path: <linux-rdma+bounces-16734-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHvqBTxni2kiUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16734-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:13:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0A11DB25
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18A6530897BB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375E366826;
	Tue, 10 Feb 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DbmIDDhz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30F35BDBE
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743325; cv=none; b=HIOqj3hXzD+HapfJ3/w+tOl+ITGX05uu1BFC9QC1dzWl01gE7X9ZHx5GVJRW51sjHRII9FL2HTFTtkC0f04V5lZctjSp+hNnA8WCf9c2Y6TgM3TC3Vmi8F9zKbQrXXsbEYV5KrfI+/GcD3AWK/CLybd4SiQTpNl/+LG8VnhN5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743325; c=relaxed/simple;
	bh=gUV/B2qkSHBbPja9HSTq/Sy6FskiHgwLIU4nQymshjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RReK2vvpD+hk5fh3F47MH0lVfjoD/sqr0BTb49l6CuOBnKddJnr/jLg6hhZUN9RgElLL3X7JNKNCYdb1sBttsjGZN3adDDHRL21WEnhbWi13OIphX+EQkBjzRDngOGyNT5Kf5ZvZbMkooldYPAGFMhcJWzi0ie8z0O556wBOQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DbmIDDhz; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a9296b3926so6320165ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743324; x=1771348124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9vxhLwRld1bf696Lq7Qolkw79blI4V5buNy7C0lW3w=;
        b=E4GaBsdJnmbdTqC8Bz4SNYvLuAh1aeTK+hs91FFDrtHDANwBk3rulPad+CHDK9Loyd
         P0czPYRWypz+JpIzcqkRJZJZq4FHfTGLmxOzMXnrxkcfGKarTxLqMn0NLh4dtyqyxpbl
         EH7nXXLOz39gL1U0Y+7qMXkPVEdq94AThnaJi0QoSNN3UBOEMC1RSG9FApG5/JExxfHF
         sspowRqgoe5oQNzs7S0WWk9FvJH9B5z1WY9wB7DhTbmLhPQkiCXluGXuHivyFub+Pa6G
         nZjh0WloErSId6epI1xS3+MzveK3QDboU+iXAx8q7mCQEC0PA/ZbvjLiZ5MctWHKAoNR
         yzjA==
X-Gm-Message-State: AOJu0Yyzrp3145eFanXWUmmW+khTph9yDFtZSJPzUH77wL/1T+Xkpz5X
	mdrGvKwLRj+Vt8OtCHimq49G/oCkn54Cug4nwatanY+Sjmvhd2uL0kFl5YsP54W1cZv7H/det+k
	BzKaILTVbbiGpN3go4CzOWx0XRHIAwFLQRHKKsOAXR0FlMPJ3VHU8MpY9WHknjth3wZ8mDPL3Pt
	KXNMvPkpY5dUjo1sWo7a2zdrv7aluLZPXQqXRQG9B9W4MW3ATFZJEx8CJgkqTKcUfvph/mhvkD1
	gGHkB/M9AxaE738n8saGPwdYpAn
X-Gm-Gg: AZuq6aLV5454W1GiF3acNp9TYYJRcUcfQZz/rw0S5RcH0IYsphnynmT+B/s7629SEFI
	5Iag57h+90VmR115UwtcBWcXUBL1eQrBodoIzDVU5tUrVPCPlX4mMSXu30Wrj/pR7NnzpMieKa5
	mm3Tfz4ZZgaRuX6N372suD3QBczWIPyRQ5BcMbVj5euyJRV8p6362haOhlHX7rnpADowpwdK0iE
	NIzFuNdD8QeEkzBFGx5GfTwayeqfV3grPpVTMKpEKOKFXgZ+lH6Cv5Q+BNDg5NbUDX9oAffHHdh
	0K7FPvNWGhG+f+RIYPSX3CPOxTwGrxER6j1roKl8q2GqOgytVd14opSxdaoyv+Q6Z8HYQGReVdL
	b3Jb6K4Hzhgm2PWdpzP0/7GTZmICTjSUTu/+pf5tGo9f1Qb40gaKs00lWpOi7N6lyFeuOcSvVcw
	32F2JB2o2xwUW6ePvHpZpra0SUj3iQFzB8yVyZxpcyl6LfjrmeihwqKGxl22vtr+Ek22RvtIM=
X-Received: by 2002:a17:902:ea0a:b0:2a0:bb05:df55 with SMTP id d9443c01a7336-2a95164acc9mr163942505ad.21.1770743323477;
        Tue, 10 Feb 2026 09:08:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a95219e0d6sm19305275ad.46.2026.02.10.09.08.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:08:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f3c36dd2cso1136459b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770743320; x=1771348120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9vxhLwRld1bf696Lq7Qolkw79blI4V5buNy7C0lW3w=;
        b=DbmIDDhzSoKiNjNn0rPjnxrrawiaAmcdx3EBJVoqz5UaxVZsyWvOuyXqobqXfsonuE
         ILix5lcRowc4Y1uls9pETwKbnjyz/6yOXCuqVwjg5iy6NdBNUUSf16THZtCDbUWuokh5
         I264cqCw+KS+HZpYSWnuhdFBEgz1u+CZvwrps=
X-Received: by 2002:a05:6a00:ab86:b0:81f:9c54:65df with SMTP id d2e1a72fcca58-82441754f9bmr12385763b3a.50.1770743320479;
        Tue, 10 Feb 2026 09:08:40 -0800 (PST)
X-Received: by 2002:a05:6a00:ab86:b0:81f:9c54:65df with SMTP id d2e1a72fcca58-82441754f9bmr12385748b3a.50.1770743320053;
        Tue, 10 Feb 2026 09:08:40 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166f269sm15620806b3a.7.2026.02.10.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:08:39 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v11 5/6] RDMA/bnxt_re: Support dmabuf for CQ rings
Date: Tue, 10 Feb 2026 22:29:38 +0530
Message-ID: <20260210165939.41625-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
References: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16734-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6CC0A11DB25
X-Rspamd-Action: no action

For CQs, kernel already supports pinning dmabuf based application
memory, specified through provider attributes. Register a new devop
for create_cq_umem() and process the umem argument. Refactor the
existing create_cq() handler so that code is shared across both
handlers.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 30 +++++++++++++++++-------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  2 ++
 drivers/infiniband/hw/bnxt_re/main.c     |  1 +
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index fb30b3831d49..dc73f0072528 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3372,8 +3372,8 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
 	return 0;
 }
 
-int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
@@ -3410,13 +3410,18 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		if (rc)
 			goto fail;
 
-		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
-				       entries * sizeof(struct cq_base),
-				       IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(cq->umem)) {
-			rc = PTR_ERR(cq->umem);
-			goto fail;
+		if (umem) {
+			cq->umem = umem;
+		} else {
+			cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
+					       entries * sizeof(struct cq_base),
+					       IB_ACCESS_LOCAL_WRITE);
+			if (IS_ERR(cq->umem)) {
+				rc = PTR_ERR(cq->umem);
+				goto fail;
+			}
 		}
+
 		rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
 		if (rc)
 			goto fail;
@@ -3484,12 +3489,19 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 free_mem:
 	free_page((unsigned long)cq->uctx_cq_page);
 c2fail:
-	ib_umem_release(cq->umem);
+	if (!umem)
+		ib_umem_release(cq->umem);
 fail:
 	kfree(cq->cql);
 	return rc;
 }
 
+int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct uverbs_attr_bundle *attrs)
+{
+	return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
+}
+
 static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 {
 	struct bnxt_re_dev *rdev = cq->rdev;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 33e0f66b39eb..27cbe9a1c7e1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -254,6 +254,8 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
 int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73003ad25ee8..401a481afecc 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1334,6 +1334,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.alloc_ucontext = bnxt_re_alloc_ucontext,
 	.create_ah = bnxt_re_create_ah,
 	.create_cq = bnxt_re_create_cq,
+	.create_cq_umem = bnxt_re_create_cq_umem,
 	.create_qp = bnxt_re_create_qp,
 	.create_srq = bnxt_re_create_srq,
 	.create_user_ah = bnxt_re_create_ah,
-- 
2.51.2.636.ga99f379adf


