Return-Path: <linux-rdma+bounces-16395-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Oz8HRaDgWlNGwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16395-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A455D4948
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 738B0303CEA7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 05:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176EE335555;
	Tue,  3 Feb 2026 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zw5eUnr5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6FC34B1A5
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095373; cv=none; b=AF+at0MVqM5nRwjqROSEVCk3RtXR5PIXT6txI+Ry+5wnhfqAiCz34jCamVNjQnSaqPu15W0DrUSrh2ON7cPoTOvo5avWlmFuecW+Ss1+2CB0Dxgw3IbpFrOqJRJbeNO4MbQQNT83ERcd/kysdt2j6NkCvymfndD9fyfLnyft7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095373; c=relaxed/simple;
	bh=Wxmn2OY+3SLIYajj3RN3qxnXd4JZqUTHbwF7cjKLvuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLTFIE/aIXTzW9lqPARR787V5HjGpx3365Rny20lo+Qqp7D8sEgwfLaZ/jprNHhTKM7lEIqzDEQLfp9JYt+CsgK4OVJZBmi0scX0wETU8rMUvm+pFt3eKg0oj1c00n5t8w2jwz3WAcSjV8wctXmbZ9uYI1dY09DD3YD/LY0aIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zw5eUnr5; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a09d981507so2918015ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095371; x=1770700171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzMLSDQGTueJlaf83p3HQRe3j5KyEXS/09ME3qXzNfs=;
        b=X/WOO/NBl160tMb5Phyj6f4W6n5wqVF+o1eATKM+B46RN5YUIIECOFucxh6evdbfbA
         HUsPcaMY89nn3H3yXcBXzdSF3V+ygVpyrz+9qoRpcLqOLF5WMFQQz8yfJm4TJzhlA2Ak
         8UaOpK35ne3fi8LfcaAM9Z8nDEKvQ/Mzt7v8LjsHzKOjCt2HRC+hPZfCJPjmPdFyrJpI
         0ihSXhNTG7NeV6sKepBXnV1cEBPskwJeabgyq05AMHOYnv4ULN1NOaHfGUhh21akn4u+
         UicnM9Ax3iLgo4EdaQ1TA6UYp23SVKNo4Ktp7OUvMXYnLZ490ocYESC68MyQy/1jvLEu
         xuGA==
X-Gm-Message-State: AOJu0YxFKoUgQqvkq9OEvLEbhy+3oL4/Gk38pC7ILA7GHJ/19cJtkG7i
	mRFAmG+cBOf6MFFjfwoQlcYrYDwiU0wVfthjnJ9dZkyR3S/kx7V6pMz3OwPsokdx81v8fhV/e7p
	A29pryDNubaS2w1dS2wG8swzJlpuyB1Vzmqps29OPUALBaroPqaPFHj6IfQnBO/qm2ib3mgpa7B
	XmjQMiYLKlF4WBu6ZbfjJVwGsErt24qRETp1sc+myRmqv40Rpo3ZrOhMJfAHPCqPhRFRbLwBVNr
	/2ImTK/C36Z/ht3yU9HZ5pvLa+D
X-Gm-Gg: AZuq6aL5ezqbBP04w++PQwZR+2JkUEefgO6Z1Y+jIH2nLDYT9GH/iGWpP7AKPjI85H1
	ZJiyySzOiW+7r7rnUPlrmKrIIIsLyIv2LHCR9h6m2hOlIqoLKKsJGZXaHappe75Z7gcGci0k1nW
	0mS61eMHLtWmfqqb3u1Nq6/9LTYTEKC05wwkiDzlodILDSj6YhDmX0XbOjIfrxpuGv54wmVTzdd
	ksuHW35tuCo02DWfGplu0hWJddd0NV+FkHq2HEJnzCvBj5pg+XkOyolGzhqufw5KxuOXPyqbJ8f
	zR8SOE6E05D8taCBTIgEBklpN4Pb6dFt21eN3zY7NhQ4DKIvFy7eNWEN8P9dqLr09zCu3NLXHtw
	3VRbIpmC5e8Nxw7ecPbisGjCjj0N42Ar98h1bf3rkoMt3X/stTOysC8awoPpN9lOzR1S/7Jd3Qd
	aflmqrWFdUNWY9ATS4KkGCAg8duJB79aIdCwWP5y1qJesuJKINaqaQLQ==
X-Received: by 2002:a17:903:1a8b:b0:2a0:d454:5372 with SMTP id d9443c01a7336-2a92462dedbmr15193385ad.22.1770095371547;
        Mon, 02 Feb 2026 21:09:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b414cd2sm23551815ad.23.2026.02.02.21.09.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 21:09:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-353a5c295e4so385976a91.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770095369; x=1770700169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzMLSDQGTueJlaf83p3HQRe3j5KyEXS/09ME3qXzNfs=;
        b=Zw5eUnr5v1nrT8a4p8/U41C4pxg85YgzRCvCoIUMcuB7r44mk3zdy6AENyZd3xdw18
         B6Hie+hslBMI+9+ySdwIE2L+0qKYQHx/Ni6A98i1zy0J51Xit/OS1uGxWQrh6SfjrJBq
         TWoSCNEouuM1U4XRjItqdhTd2rlrMaCzPTp1E=
X-Received: by 2002:a17:90b:3f87:b0:343:3898:e7c7 with SMTP id 98e67ed59e1d1-3547775f293mr1428814a91.12.1770095369331;
        Mon, 02 Feb 2026 21:09:29 -0800 (PST)
X-Received: by 2002:a17:90b:3f87:b0:343:3898:e7c7 with SMTP id 98e67ed59e1d1-3547775f293mr1428801a91.12.1770095368895;
        Mon, 02 Feb 2026 21:09:28 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547b1306c5sm621948a91.15.2026.02.02.21.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:09:28 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v10 5/6] RDMA/bnxt_re: Direct Verbs: Support CQ verbs
Date: Tue,  3 Feb 2026 10:30:48 +0530
Message-ID: <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16395-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A455D4948
X-Rspamd-Action: no action

The following Direct Verbs have been implemented, by enhancing the
driver specific udata in existing verbs.

CQ Direct Verbs:
----------------
- CREATE_CQ:
  Create a CQ using the specified udata (struct bnxt_re_cq_req).
  The driver registers a new device op 'create_cq_umem' that is
  used to process CQ memory allocated by the userspace application.
  The driver maps/pins the CQ user memory and registers it with the
  hardware.

- DESTROY_CQ:
  Unmap the user memory and destroy the CQ.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Co-developed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Co-developed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   3 +
 drivers/infiniband/hw/bnxt_re/dv.c       | 121 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  60 +++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   7 ++
 drivers/infiniband/hw/bnxt_re/main.c     |   1 +
 include/uapi/rdma/bnxt_re-abi.h          |   4 +
 6 files changed, 179 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 0999a42c678c..ec3ce69bcbe7 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -277,6 +277,9 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
 	return 0;
 }
 
+struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev);
+void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq);
+
 #define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5	1088
 #define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5		128
 #define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5	128
diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index db69f25e294f..4d7534abcff1 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -12,6 +12,7 @@
 #include <rdma/ib_user_ioctl_cmds.h>
 #define UVERBS_MODULE_NAME bnxt_re
 #include <rdma/uverbs_named_ioctl.h>
+#include <rdma/ib_umem.h>
 #include <rdma/bnxt_re-abi.h>
 
 #include "roce_hsi.h"
@@ -459,6 +460,126 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
 DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_DEFAULT_DBR,
 			      &UVERBS_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR));
 
+static int bnxt_re_dv_setup_umem(struct bnxt_re_dev *rdev,
+				 struct ib_umem *umem,
+				 struct bnxt_qplib_sg_info *sginfo)
+{
+	unsigned long page_size;
+
+	if (!umem)
+		return -EINVAL;
+
+	page_size = ib_umem_find_best_pgsz(umem, SZ_4K, 0);
+	if (!page_size)
+		return -EINVAL;
+
+	sginfo->umem = umem;
+	sginfo->npages = ib_umem_num_dma_blocks(umem, SZ_4K);
+	sginfo->pgsize = SZ_4K;
+	sginfo->pgshft = __builtin_ctz(SZ_4K);
+	ibdev_dbg(&rdev->ibdev,
+		  "umem: 0x%llx npages: %d page_size: %d page_shift: %d\n",
+		  (u64)umem, sginfo->npages, sginfo->pgsize, sginfo->pgshft);
+
+	return 0;
+}
+
+static int bnxt_re_dv_create_qplib_cq(struct bnxt_re_dev *rdev,
+				      struct bnxt_re_ucontext *re_uctx,
+				      struct bnxt_re_cq *cq,
+				      struct bnxt_re_cq_req *req,
+				      struct ib_umem *umem)
+{
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_qplib_cq *qplcq;
+	u32 cqe = req->ncqe;
+	u32 max_active_cqs;
+	int rc = -EINVAL;
+
+	if (!atomic_add_unless(&rdev->stats.res.cq_count, 1, dev_attr->max_cq)) {
+		ibdev_dbg(&rdev->ibdev, "Create CQ failed - max exceeded(CQs)");
+		return rc;
+	}
+
+	/* Validate CQ fields */
+	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
+		ibdev_dbg(&rdev->ibdev, "Create CQ failed - max exceeded(CQ_WQs)");
+		goto fail_dec;
+	}
+
+	qplcq = &cq->qplib_cq;
+	qplcq->cq_handle = (u64)qplcq;
+
+	rc = bnxt_re_dv_setup_umem(rdev, umem, &qplcq->sg_info);
+	if (rc)
+		goto fail_dec;
+
+	cq->umem = umem;
+	qplcq->dpi = &re_uctx->dpi;
+	qplcq->max_wqe = cqe;
+	qplcq->nq = bnxt_re_get_nq(rdev);
+	qplcq->cnq_hw_ring_id = qplcq->nq->ring_id;
+	qplcq->coalescing = &rdev->cq_coalescing;
+	rc = bnxt_qplib_create_cq(&rdev->qplib_res, qplcq);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to create HW CQ");
+		goto fail_dec;
+	}
+
+	cq->ib_cq.cqe = cqe;
+	cq->cq_period = qplcq->period;
+
+	max_active_cqs = atomic_read(&rdev->stats.res.cq_count);
+	if (max_active_cqs > rdev->stats.res.cq_watermark)
+		rdev->stats.res.cq_watermark = max_active_cqs;
+	spin_lock_init(&cq->cq_lock);
+
+	return 0;
+
+fail_dec:
+	/* Note: umem will be freed by uverbs handler, since DV CQ
+	 * creation happens through devop->create_cq_mem().
+	 */
+	atomic_dec(&rdev->stats.res.cq_count);
+	return rc;
+}
+
+static void bnxt_re_dv_free_qplib_cq(struct bnxt_re_dev *rdev,
+				     struct bnxt_re_cq *re_cq)
+{
+	bnxt_qplib_destroy_cq(&rdev->qplib_res, &re_cq->qplib_cq);
+	bnxt_re_put_nq(rdev, re_cq->qplib_cq.nq);
+}
+
+int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct bnxt_re_cq *re_cq, struct bnxt_re_cq_req *req,
+			 struct ib_umem *umem)
+{
+	struct bnxt_re_ucontext *re_uctx =
+		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	struct bnxt_qplib_cq *qplcq = &re_cq->qplib_cq;
+	struct bnxt_re_cq_resp resp = {};
+	int ret;
+
+	ret = bnxt_re_dv_create_qplib_cq(rdev, re_uctx, re_cq, req, umem);
+	if (ret)
+		return ret;
+
+	resp.cqid = qplcq->id;
+	resp.tail = qplcq->hwq.cons;
+	resp.phase = qplcq->period;
+	ret = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+	if (ret)
+		goto fail_resp;
+
+	re_cq->is_dv_cq = true;
+	return 0;
+
+fail_resp:
+	bnxt_re_dv_free_qplib_cq(rdev, re_cq);
+	return ret;
+};
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e8a5c860d1fc..dea80cea64a3 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3241,7 +3241,7 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct ib_recv_wr *wr,
 	return rc;
 }
 
-static struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
+struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
 {
 	int min, indx;
 
@@ -3256,7 +3256,7 @@ static struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
 	return &rdev->nqr->nq[min];
 }
 
-static void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
+void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
 {
 	mutex_lock(&rdev->nqr->load_lock);
 	nq->load--;
@@ -3292,6 +3292,15 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs)
+{
+	return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
+}
+
+static u64 bnxt_re_cq_cmask_supported = (BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT |
+					 BNXT_RE_CQ_DV_CQ_ENABLE);
+
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
@@ -3299,7 +3308,9 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct bnxt_re_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_re_cq_resp resp = {};
 	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_cq_req req = {};
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3317,6 +3328,22 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cctx = rdev->chip_ctx;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
+	if (udata) {
+		if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen)))
+			return -EFAULT;
+		if (req.comp_mask & ~bnxt_re_cq_cmask_supported) {
+			ibdev_dbg(&rdev->ibdev,
+				  "Invalid CQ comp_mask: 0x%llx supported: 0x%llx\n",
+				  req.comp_mask, bnxt_re_cq_cmask_supported);
+			return -EOPNOTSUPP;
+		}
+		if (req.comp_mask & BNXT_RE_CQ_DV_CQ_ENABLE) {
+			if (!umem)
+				return -EINVAL;
+			return bnxt_re_dv_create_cq(rdev, udata, cq, &req, umem);
+		}
+	}
+
 	entries = bnxt_re_init_depth(cqe + 1, uctx);
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
@@ -3324,18 +3351,16 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
 	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
-		struct bnxt_re_cq_req req;
-		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-			rc = -EFAULT;
-			goto fail;
-		}
-
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
 		cq->qplib_cq.sg_info.umem = cq->umem;
 		cq->qplib_cq.dpi = &uctx->dpi;
@@ -3370,8 +3395,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	spin_lock_init(&cq->cq_lock);
 
 	if (udata) {
-		struct bnxt_re_cq_resp resp = {};
-
 		if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
 			hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
 			/* Allocate a page */
@@ -3399,7 +3422,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 free_mem:
 	free_page((unsigned long)cq->uctx_cq_page);
 c2fail:
-	ib_umem_release(cq->umem);
+	if (cq->umem && !umem)
+		ib_umem_release(cq->umem);
 fail:
 	kfree(cq->cql);
 	return rc;
@@ -4574,6 +4598,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 			if (resp.mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
 				uctx->cmask |= BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED;
 		}
+		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_DV_CQ_SUPPORTED;
+		uctx->cmask |= BNXT_RE_UCNTX_CAP_DV_CQ_SUPPORTED;
 	}
 
 	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 33e0f66b39eb..1f6817d2a315 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -113,6 +113,7 @@ struct bnxt_re_cq {
 	int			resize_cqe;
 	void			*uctx_cq_page;
 	struct hlist_node	hash_entry;
+	bool			is_dv_cq;
 };
 
 struct bnxt_re_mr {
@@ -189,6 +190,7 @@ static inline u16 bnxt_re_get_rwqe_size(int nsge)
 enum {
 	BNXT_RE_UCNTX_CAP_POW2_DISABLED = 0x1ULL,
 	BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED = 0x2ULL,
+	BNXT_RE_UCNTX_CAP_DV_CQ_SUPPORTED = 0x4ULL,
 };
 
 static inline u32 bnxt_re_init_depth(u32 ent, struct bnxt_re_ucontext *uctx)
@@ -254,6 +256,8 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
 int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
@@ -303,4 +307,7 @@ void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
 struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset);
+int bnxt_re_dv_create_cq(struct bnxt_re_dev *rdev, struct ib_udata *udata,
+			 struct bnxt_re_cq *re_cq, struct bnxt_re_cq_req *req,
+			 struct ib_umem *umem);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
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
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 51f8614a7c4f..4c079d60b43d 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -56,6 +56,7 @@ enum {
 	BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED = 0x08ULL,
 	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
 	BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,
+	BNXT_RE_UCNTX_CMASK_DV_CQ_SUPPORTED = 0x80,
 };
 
 enum bnxt_re_wqe_mode {
@@ -101,10 +102,13 @@ struct bnxt_re_pd_resp {
 struct bnxt_re_cq_req {
 	__aligned_u64 cq_va;
 	__aligned_u64 cq_handle;
+	__aligned_u64 comp_mask;
+	__u32 ncqe;
 };
 
 enum bnxt_re_cq_mask {
 	BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT = 0x1,
+	BNXT_RE_CQ_DV_CQ_ENABLE = 0x2,
 };
 
 struct bnxt_re_cq_resp {
-- 
2.51.2.636.ga99f379adf


