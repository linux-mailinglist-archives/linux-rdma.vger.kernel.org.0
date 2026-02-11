Return-Path: <linux-rdma+bounces-16759-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHDPFPB8jGkcpgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16759-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F31249B7
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1259C301C6F2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BC636BCFC;
	Wed, 11 Feb 2026 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V7KSLjRA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF7367F39
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814698; cv=none; b=XYobhzoIFX2WMr6DD3NHJTJTcKCaMyFxKHVoZ+j0NiHZOy632BjX6IBXkbkjBso0PBZM43FcaOzmGA6FkA7mPIrdOuBcilIU5Y1OF9j0e+FLeoXRpW8fe/FV0CPSLRWj4K/uMcT/d2LWgivb1iWrWg7uYzesrJB8EHPtk5V1RbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814698; c=relaxed/simple;
	bh=IEQgprYg5P8OqBia8cl4ZRdpYxefIHv0cLLO3sgh2ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcusj8Zz0wd/1XKEerMk/qxYBjE3u5WxT/Un9DRCW7vrwejOWFcJ54CCMvKyCDJAzSMgw/R2Dw1P0UDwe+/K5y3UniclvMxXcAz3PrkBx+h8xFCWRoc+8dQIF7BnBBebxgMdxRKKUiPF5FnS6rOYK4ETR3/7jOnuE1nT3NmQEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V7KSLjRA; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-82318b640beso1069280b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814697; x=1771419497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZzdwnpShgE+LqdOdI6Rmj13DGxu7mJFPC6yhTWCsv4=;
        b=Kq3qTddNjICghoR/8M6qSWDLmqgrEdk1vNyC+dytilil3MwQRVKEpK4GgsBn3z7Lx7
         RJrbdL+qdAezO1Tq6/nD1EY29HZCmA1GUaw9m5TWjnb2fl5TSaD/Gh5rDQqW5rUeWp4A
         eyzPwfeEjNV0jGycVSNJU7BZG7M9sX17wlbYdgxo/PXQfMUJr3ScuPiPksOoFykG+0GR
         kejlRISvJqNlYOBr9D88PBXPxNgD46FDhnnhXtcp6kK2bvOL4q6k7CsWX22R65vU6UEI
         APGAIRGyrELPxdBTP+aIhUd0ticguBE58Ndye4VGAzfG9kPeZLpw2fkcAqnR+8jbcmrq
         pHvg==
X-Gm-Message-State: AOJu0YxJ+YExzr0+gY+C9scy7EwATqFZe5rBA6DEa34Ge/T3KDQEBhqE
	TfyS+q62LKOFOyXbcAiTj0AmtcrIOtf6U+MQ+sn7m01vR3gzt6nQkSU+FjVTyNYUS+kECS9vWuD
	s8pmNdEPvGDRPTcDznvrQs+M8FQP+KKtrKeXdkJ57OKVXLhn+IxYOv64w1X31TCKCV+cQmy7UYY
	OH3X3EtiPAF925AF7gODAAlubarWv1U0hIX5iwrYUHhKoBQP+OyaBebxalrf80qU5RbKPRgwVOU
	OT84xCrKfDVfc0umrcEC11InRzV
X-Gm-Gg: AZuq6aJ6VErEa+JS6S7ESyirajTYGrSvzcdMHVrGaKSCfzgC5EU7SBIUKPOaGfS/tHj
	CeE8B1ctVpfuKnuabgJd5m6oL9TmZAz0WSzw0T3XPN4o/bvZT9Fe999OPMS+dpgndJcXnRV69PK
	UruEqWoraeRsRjEJ45oxG1Npx8FlplPBNsiPPXqQwg8e+UndCLhWaKO6m2ueWzW8P4JATk1JlAs
	ChJRyRmai7wx1Y2q04E0yGZDfXx2Sap+IY6c+Twh6rtOSVu0CgbtN39FfWLTmLJY5wfo7HSUsL7
	nfMyaOcbDKaMhR2adxuzELQ4JhiY25vtBsmiGdPK//YvDfAsiPmhkJ/bxTmqZ2mQ91ZLlaptd4b
	QkaAfUsPrr6+uNO2JPDNmRdGoAvFMhBIfubsvyspc9ksiqKnvwqFsze6+fMqIv7WgjnGsy7yCvB
	7Z4KSeOV9Pj3TrDcZhYBkG0PmNzObGjN8BkB5rR/mJME6jCkeTvkMMrXi4T9JcA4Z/A7es
X-Received: by 2002:a05:6a00:3989:b0:823:f04:e89b with SMTP id d2e1a72fcca58-824417242admr15370611b3a.48.1770814696552;
        Wed, 11 Feb 2026 04:58:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8249e7ab7c7sm179219b3a.7.2026.02.11.04.58.16
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 04:58:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a79164b686so22859095ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770814695; x=1771419495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZzdwnpShgE+LqdOdI6Rmj13DGxu7mJFPC6yhTWCsv4=;
        b=V7KSLjRAW+cewv/nXQteBmGPfw1FkbRFUKd9lSWJ2AXh15RCfOFPs71xgtnafHv3U9
         18L5pYc3T8Dzg10hSvBeV0BWVsSR+umLUZQgyEQABFeDKc38Ygp8INd0CD1q9godyu/X
         RDHqUUsYRW92bqG7TZMub5mqog3jTs3PijatY=
X-Received: by 2002:a17:902:d54e:b0:2aa:d5e5:b12d with SMTP id d9443c01a7336-2aad5e5ca9dmr146739135ad.27.1770814694727;
        Wed, 11 Feb 2026 04:58:14 -0800 (PST)
X-Received: by 2002:a17:902:d54e:b0:2aa:d5e5:b12d with SMTP id d9443c01a7336-2aad5e5ca9dmr146738975ad.27.1770814694344;
        Wed, 11 Feb 2026 04:58:14 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab299983d0sm22206515ad.79.2026.02.11.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:58:13 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v12 5/6] RDMA/bnxt_re: Support dmabuf for CQ rings
Date: Wed, 11 Feb 2026 18:19:26 +0530
Message-ID: <20260211124927.57617-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
References: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16759-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A4F31249B7
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
index 9fa89f330c5a..30aefbd0112e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3368,8 +3368,8 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
 	return 0;
 }
 
-int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
@@ -3406,13 +3406,18 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
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
@@ -3480,12 +3485,19 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
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


