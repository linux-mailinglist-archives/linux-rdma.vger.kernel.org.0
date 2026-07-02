Return-Path: <linux-rdma+bounces-22712-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UigyAb6cRmqQaAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22712-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:15:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAE36FB2AB
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:15:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Ui3Tuobh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22712-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22712-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDD0B30315ED
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E17933689F;
	Thu,  2 Jul 2026 17:07:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F0318B9D
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:07:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012027; cv=none; b=GxT/ynGKiiH3FeR4ZhrT1mOdYcgA13UiKtge4AUHa4vTCkEeAyDSaaOr1oi23Bgl6z4frUr5NeoRUoLvdAn9yD8xDFEGAAVjKA5cHbzOl5s9TChEs5B+se55DsvzKOgyUJ11Yl+34zJnaNNtMEoLSsL0iF2VrrDjZLOGcHTX0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012027; c=relaxed/simple;
	bh=4xQlmvb6Ckq83RTeOuqoKjbNaNuxchFD/NlcWup+gu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hPLEQ0PyMuEktb+IdktZ85fwMaFKBz4gtgEuIJzXdEf/vM+BaC7TdSKDWQmHDeD6zcc6TSS8hjvXI97pJ58GbTuLI16fl3BXax6aoTLCBHJfvyFksm1kRLlBbmlpyjNJ+QUW9UfsnrA5USsDdZcxpQQrGbwA/4uyHx8krrr9ufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ui3Tuobh; arc=none smtp.client-ip=74.125.224.74
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-664bf61b2bbso5081529d50.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783012025; x=1783616825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=amz2XWGJJMU1cX21mQOSJ/3CXoBbLxP6Whk1F3PrBaM=;
        b=Ui3TuobhUaOHVDbiYx/hJkN5A0LPhkyhsxQDQvDYMV6KromjGx/iFSfrYzSTnP3Tt5
         yeI5mogjhGhuLje3qCTxuBZMaXhk5l/0DuGklEGQt1r/rmypvV6sqppDtgEgZ2yAJNFr
         l0NlZccwasr7bc3KVcAQFh7yu4ie4CBFBtydGX6X0/bqE84D08IuoWlaE1AqOAxyhwGt
         Y8X5nBMIlZZQ/cP3oES4YKtPeAQmux25OhlSsQL4OAfwW/GJ5+bbiRPsfnsx2e4Nc1TJ
         4UE6mvZjYUMxnPhXG+mf2Z60tBrkUFQzwUvTT+E6MwsRvJe/MsQHIHYR1eh3lT3iDysF
         fu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012025; x=1783616825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amz2XWGJJMU1cX21mQOSJ/3CXoBbLxP6Whk1F3PrBaM=;
        b=W12GEPv2HBd4PehQnAD5LdZlVUNWyxNGlsoJUxNlX/YLSW9dZCEvj31GJZ37ZWZfmZ
         8+9YoQUlz5oTewXBJF0syhMPpRnWc+B5bmu2st7VV1EeNS8d7Ud4E+auFd/ZB+inDLGE
         J7kqt4U6tgpJqX1wmGnu6w4gThT5AqEB0i9Pq2dxWimec+SjnKt4k6vAdCkGJqh2NBHr
         9f7PBem/eioKVIw07jD++MF24NRZHS6do6ZDMnfjV6YQEpTi0uCrBm8q8gAbWe+e0dvR
         feidVBKkiCsg98pnMHKl/8ACaKozAzXUj5joT6kDgi86X1C3UkfOe57nfOXf/tVR4oZB
         ojjA==
X-Gm-Message-State: AOJu0Yz4lji+cNLB0xmzUv76A8+XMfg5swhHbJXoJCxW2KxCB8VPNQfQ
	ysASc9Rw0bpWnXEUyw3YcUWeVsCF5OmOOfwFgo4D8fMRK+z2l2ncnb9FV8jsd10Dr98380uIkbL
	upyk33sgd4A==
X-Received: from yxcj19-n2.prod.google.com ([2002:a05:690e:4893:20b0:651:d659:9f55])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:2d1:b0:664:f384:807d
 with SMTP id 956f58d0204a3-66521967783mr5093080d50.15.1783012024457; Thu, 02
 Jul 2026 10:07:04 -0700 (PDT)
Date: Thu,  2 Jul 2026 17:06:47 +0000
In-Reply-To: <20260702170652.4159201-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702170652.4159201-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702170652.4159201-3-jmoroni@google.com>
Subject: [PATCH rdma-next v3 2/7] RDMA/irdma: Add checks for no udata
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22712-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AAE36FB2AB

Several methods do not accept udata input and do not provide
a udata response. Use the ib_no_udata_io helper to check that
the input buffers are empty and to zero fill any user response
buffers. For methods that do provide a response, enforce the
input buffer is empty using ib_is_udata_in_empty.

The irdma rdma-core provider as well as the legacy i40iw
provider were both checked to ensure they never passed any
udata to these ops.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 66 +++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c8541c6c1a68..be964f777e64 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -407,6 +407,10 @@ static int irdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 	u32 pd_id = 0;
 	int err;
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	if (udata && udata->outlen < IRDMA_ALLOC_PD_MIN_RESP_LEN)
 		return -EINVAL;
 
@@ -445,6 +449,11 @@ static int irdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct irdma_pd *iwpd = to_iwpd(ibpd);
 	struct irdma_device *iwdev = to_iwdev(ibpd->device);
+	int ret;
+
+	ret = ib_no_udata_io(udata);
+	if (ret)
+		return ret;
 
 	irdma_free_rsrc(iwdev->rf, iwdev->rf->allocated_pds, iwpd->sc_pd.pd_id);
 
@@ -537,11 +546,10 @@ static int irdma_setup_push_mmap_entries(struct irdma_ucontext *ucontext,
 }
 
 /**
- * irdma_destroy_qp - destroy qp
+ * _irdma_destroy_qp - destroy qp
  * @ibqp: qp's ib pointer also to get to device's qp address
- * @udata: user data
  */
-static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
+static void _irdma_destroy_qp(struct ib_qp *ibqp)
 {
 	struct irdma_qp *iwqp = to_iwqp(ibqp);
 	struct irdma_device *iwdev = iwqp->iwdev;
@@ -573,6 +581,22 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (iwqp->sc_qp.qp_uk.qp_id == 1)
 		iwdev->rf->hwqp1_rsvd = false;
 	irdma_free_qp_rsrc(iwqp);
+}
+
+/**
+ * irdma_destroy_qp - destroy qp
+ * @ibqp: qp's ib pointer also to get to device's qp address
+ * @udata: user data
+ */
+static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
+{
+	int ret;
+
+	ret = ib_no_udata_io(udata);
+	if (ret)
+		return ret;
+
+	_irdma_destroy_qp(ibqp);
 
 	return 0;
 }
@@ -1127,7 +1151,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 
 		err_code = ib_respond_udata(udata, uresp);
 		if (err_code) {
-			irdma_destroy_qp(&iwqp->ibqp, udata);
+			_irdma_destroy_qp(&iwqp->ibqp);
 			return err_code;
 		}
 	}
@@ -1981,6 +2005,11 @@ static int irdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	struct irdma_device *iwdev = to_iwdev(ibsrq->device);
 	struct irdma_srq *iwsrq = to_iwsrq(ibsrq);
 	struct irdma_sc_srq *srq = &iwsrq->sc_srq;
+	int ret;
+
+	ret = ib_no_udata_io(udata);
+	if (ret)
+		return ret;
 
 	irdma_srq_wq_destroy(iwdev->rf, srq);
 	irdma_srq_free_rsrc(iwdev->rf, iwsrq);
@@ -2001,6 +2030,11 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	struct irdma_sc_ceq *ceq = dev->ceq[cq->ceq_id];
 	struct irdma_ceq *iwceq = container_of(ceq, struct irdma_ceq, sc_ceq);
 	unsigned long flags;
+	int ret;
+
+	ret = ib_no_udata_io(udata);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&iwcq->lock, flags);
 	if (!list_empty(&iwcq->cmpl_generated))
@@ -2235,6 +2269,10 @@ static int irdma_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	struct cqp_cmds_info *cqp_info;
 	int status;
 
+	status = ib_no_udata_io(udata);
+	if (status)
+		return status;
+
 	if (attr_mask & IB_SRQ_MAX_WR)
 		return -EINVAL;
 
@@ -3080,6 +3118,10 @@ static int irdma_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	int err_code;
 	u32 stag;
 
+	err_code = ib_no_udata_io(udata);
+	if (err_code)
+		return err_code;
+
 	stag = irdma_create_stag(iwdev);
 	if (!stag)
 		return -ENOMEM;
@@ -3831,6 +3873,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
 	struct ib_umem_dmabuf *umem_dmabuf;
 	int ret;
 
+	ret = ib_no_udata_io(udata);
+	if (ret)
+		return ERR_PTR(ret);
+
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
@@ -4026,6 +4072,10 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	bool dmabuf_revocable = iwmr->region && iwmr->region->is_dmabuf;
 	int ret;
 
+	ret = ib_no_udata_io(udata);
+	if (ret)
+		return ret;
+
 	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM) {
 		if (iwmr->region) {
 			struct irdma_ucontext *ucontext;
@@ -5347,6 +5397,10 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 	struct irdma_ah *parent_ah;
 	int err;
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	if (udata->outlen < IRDMA_CREATE_AH_MIN_RESP_LEN)
 		return -EINVAL;
 
@@ -5398,6 +5452,10 @@ static int irdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *attr,
 	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
 	int err;
 
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
+
 	err = irdma_setup_ah(ibah, attr);
 	if (err)
 		return err;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


