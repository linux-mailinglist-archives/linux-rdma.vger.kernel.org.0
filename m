Return-Path: <linux-rdma+bounces-22571-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ly+cEvv+QmqbLwoAu9opvQ
	(envelope-from <linux-rdma+bounces-22571-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 01:25:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D066DF35C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 01:25:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XTveGU7B;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22571-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22571-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B7D63012E86
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 23:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6473D3CEB8B;
	Mon, 29 Jun 2026 23:25:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13473CF02B
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 23:25:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775543; cv=none; b=DF5e2VfhtY30kfRadSD/p07nNTOS5iwQ1S34GI2XI/s/auso1lupEzKeymkO/xQG5jtqF2IcfXV7gQMY3JHhfzEEHjOdSB3F1YqdqCsWRd3WgkZP6wOBHMPCNiIOZx78JQASV/n8MMK/CYKR/wKGgFs1k/IVb5Z1ogOxY0Je8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775543; c=relaxed/simple;
	bh=+foSnLfM/VNsdH3h//VOxAhzTPeyXCcI5Z7icSuMTJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=On2Y2x+NE0y41cue7XYLqIdyXvmgXE/MJGFYR/tt8CDp3hzDrvTLsiZ0Ru+vA/j7NLGV89bheoaS6oMyJqQ/Ee8B+z9BBqZQZq2RsntYj4jlsEJO2LjB+evKAkTlLW6vQJ1cHEIYi+0V6y9PxTROtnrhW/bL1HMRNEDPlAl7UnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTveGU7B; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-92e66f9e2baso6564585a.0
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 16:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782775541; x=1783380341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5C4qIkx+VOp4rwaD6X+IPw/o/a6321ZS1/IUsOtbgg=;
        b=XTveGU7BzpYxYx9/N2vFIDbiLWa3rGKUJ+nuuS2sj8pSQj5R3IdQ7cmCB14exOPHEy
         EqFk5hwX4I90UyCJoDIbkXQMy8cTfgWxdu7NUKuAyod4I/j4C/dhMcd6o88WM9OJLWla
         vynZllDayG3Db/Wq7RLowe4epOD/At6ESG9GYMzW5h4NNnMJ+kKfY3c0F4w+kPlBi3y0
         lsxXxdjpz1sAujGYquYB3Pa61rU8fW5+ZzDGASgzq6N//HXpm2+ImbnPi1ym+CPv9ehI
         sCRHodB+KoWSGrj1/k0Wvz0CV3qWfsBFC5sSjWPdH5aIvBco6YBzhXaUbgxbuSSyn+jP
         +Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782775541; x=1783380341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5C4qIkx+VOp4rwaD6X+IPw/o/a6321ZS1/IUsOtbgg=;
        b=DflrFLTQn7jzG4ihUKMKLXYMHlNqy9gbWoXitnncx16HGzWrdaEJAXguD89X5UMG68
         4s5Eep2Zomd6dqp3sctcP5cqjVOiOqDN475Hq912AWxIIJb8rOtfiouVX9LcGB1UoCbD
         X/pLJIUd2bjP9pe6/oo2dj5Z5XTZznaAAbzTPFTh/uydwpBPghnf0zCGB+bf3tZSfN4H
         ccYbx+XtNVGpBaoRdaBZaeEPDiqQtvyub2734/XmKyEjSAmq2a/C2P3Iir+zmrhLbHnL
         nhaqPBTnFHXQDqrMgYbpInASoc+S/+cn4V5NhjxUgNKjr71LJ1MHxAFMhJdfUncYgUg3
         uEng==
X-Gm-Message-State: AOJu0YxG0coA0p5vZMpcj0roOAlrXlo+QgijsOOCWZM6zfYEt5TPa8Vj
	ZG2jTyyRkUi/rfgRoAidAJnRX2JGEjLkwwPqFyGqNV16f5m6kIpBWA72t6UDOHRzT64FzFbDJtT
	rPUDCUt3xcA==
X-Received: from qkal14.prod.google.com ([2002:a05:620a:a48e:b0:923:ee73:790d])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:2611:b0:915:bf79:3e08
 with SMTP id af79cd13be357-92e627e2485mr253408485a.56.1782775540559; Mon, 29
 Jun 2026 16:25:40 -0700 (PDT)
Date: Mon, 29 Jun 2026 23:25:28 +0000
In-Reply-To: <20260629232532.2057423-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629232532.2057423-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629232532.2057423-2-jmoroni@google.com>
Subject: [PATCH rdma-next v2 1/5] RDMA/irdma: Enforce empty udata input for
 no-input ops
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22571-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99D066DF35C

Validate that the udata input buffer is empty for operations
that do not expect input data from userspace.

The irdma rdma-core provider as well as the legacy i40iw
provider were both checked to ensure they never passed any
udata to these ops.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 48 +++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b79f5afe68e5..e1c894fba2af 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -410,6 +410,10 @@ static int irdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 	if (udata && udata->outlen < IRDMA_ALLOC_PD_MIN_RESP_LEN)
 		return -EINVAL;
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	err = irdma_alloc_rsrc(rf, rf->allocated_pds, rf->max_pd, &pd_id,
 			       &rf->next_pd);
 	if (err)
@@ -445,6 +449,11 @@ static int irdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct irdma_pd *iwpd = to_iwpd(ibpd);
 	struct irdma_device *iwdev = to_iwdev(ibpd->device);
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	irdma_free_rsrc(iwdev->rf, iwdev->rf->allocated_pds, iwpd->sc_pd.pd_id);
 
@@ -542,6 +551,11 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct irdma_qp *iwqp = to_iwqp(ibqp);
 	struct irdma_device *iwdev = iwqp->iwdev;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	iwqp->sc_qp.qp_uk.destroy_pending = true;
 
@@ -1959,6 +1973,11 @@ static int irdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	struct irdma_device *iwdev = to_iwdev(ibsrq->device);
 	struct irdma_srq *iwsrq = to_iwsrq(ibsrq);
 	struct irdma_sc_srq *srq = &iwsrq->sc_srq;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	irdma_srq_wq_destroy(iwdev->rf, srq);
 	irdma_srq_free_rsrc(iwdev->rf, iwsrq);
@@ -1979,6 +1998,11 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	struct irdma_sc_ceq *ceq = dev->ceq[cq->ceq_id];
 	struct irdma_ceq *iwceq = container_of(ceq, struct irdma_ceq, sc_ceq);
 	unsigned long flags;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	spin_lock_irqsave(&iwcq->lock, flags);
 	if (!list_empty(&iwcq->cmpl_generated))
@@ -2195,6 +2219,10 @@ static int irdma_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	struct cqp_cmds_info *cqp_info;
 	int status;
 
+	status = ib_is_udata_in_empty(udata);
+	if (status)
+		return status;
+
 	if (attr_mask & IB_SRQ_MAX_WR)
 		return -EINVAL;
 
@@ -3035,6 +3063,10 @@ static int irdma_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	int err_code;
 	u32 stag;
 
+	err_code = ib_is_udata_in_empty(udata);
+	if (err_code)
+		return err_code;
+
 	stag = irdma_create_stag(iwdev);
 	if (!stag)
 		return -ENOMEM;
@@ -3785,6 +3817,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
 	struct ib_umem_dmabuf *umem_dmabuf;
 	int ret;
 
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ERR_PTR(ret);
+
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
@@ -3973,6 +4009,10 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	bool dmabuf_revocable = iwmr->region && iwmr->region->is_dmabuf;
 	int ret;
 
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
+
 	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM) {
 		if (iwmr->region) {
 			struct irdma_ucontext *ucontext;
@@ -5292,6 +5332,10 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 	if (udata->outlen < IRDMA_CREATE_AH_MIN_RESP_LEN)
 		return -EINVAL;
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	err = irdma_setup_ah(ibah, attr);
 	if (err)
 		return err;
@@ -5340,6 +5384,10 @@ static int irdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *attr,
 	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
 	int err;
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	err = irdma_setup_ah(ibah, attr);
 	if (err)
 		return err;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


