Return-Path: <linux-rdma+bounces-22501-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wrhcC/s7P2p/QAkAu9opvQ
	(envelope-from <linux-rdma+bounces-22501-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:56:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B86D0CEB
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:56:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RXievliq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22501-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22501-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B16B1302DF6B
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532FC32B10E;
	Sat, 27 Jun 2026 02:56:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6CD331EAC
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 02:56:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782529015; cv=none; b=Y9jNvvMH1NJS1VbJ1vNDSIhL8nHpGAvtg3rnyCSB3aUwnVCqr+4MIoRHKHyc0Rs3x2GuUgKrsekUpuCYUDZWuGmivixJAJVMPofTzUQfQNsh6mjrUfQ5WTmIdOjVbbsOJuoROm+BJ7KJYfStOLVXkjL6VOXbzPaKrpn0oxBMHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782529015; c=relaxed/simple;
	bh=+foSnLfM/VNsdH3h//VOxAhzTPeyXCcI5Z7icSuMTJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fVnbiu0AZtf+LoOj8JyL0TCTRKKdfJ7drrkZxxYYKQpcI0Pb/OLE6u0XCA+UwxHVDuR+F8BOQbLQz2vhcNrU343Rzyh/IcYT10aONheHRwRBT47emBcneTwZCPlhXd6xH/Wi8bfyl13hnbHuZXRfOUO+xpbAPJrsxpgDbjWPNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RXievliq; arc=none smtp.client-ip=74.125.224.74
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-662cea4ddf3so1974443d50.0
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2026 19:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782529013; x=1783133813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5C4qIkx+VOp4rwaD6X+IPw/o/a6321ZS1/IUsOtbgg=;
        b=RXievliqOOcvvuyigy/6MmykuPLxZ0mr7agqyob+MqrSvoJeXhjbK1Mbq7V24UjmgJ
         jC9m9QwZ6iuagsBHagrj1Hixi8+888NyG8Vtd5DCUdmhxZKhMIjzxC8Tpehsy7AM9Tfw
         p4thA11xPRHND2SMd0UOkp91+sn4ru1iinWC3LJ34aq9juG7wQKTz03mxXXEhzhepNzv
         we6QizHE6M04j9I0PHXbAH69xFqoYo75o0TijOJFGtZhttx5hU/g14ySBo3GBZJ61x6p
         bM3+4HJYBmbBaLD2l2E98QGutQgbozbQSrMhj54z22QVvEi1PzHHIz4Gzv3wH9DttiOX
         ljJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782529013; x=1783133813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5C4qIkx+VOp4rwaD6X+IPw/o/a6321ZS1/IUsOtbgg=;
        b=dca3d2b8ynVu674P/wrBqzfH207XVRQtlbGddfGWGz0VESaT5Xjv8MV/4lbA28BBfn
         c73U+mtALNcFGUGO4OMKaj9Im2CgLqy6yuSD07ZtiYGzrDeQZtufl7zi3dcx3ghiFJHX
         5njQCMALVj2bLZBPeHWWXv1ULoUDXX2AmcJPO2WWBerK5eaJOV+GVvkwmQcP7y5zlVW0
         aR5nP+VLfVR3FBHqSW9OdDcE2gCj70YzuUaIB3exJSzPHjpuZvG5iiBPFtoLb3CxQRMi
         wE3gaj+J8dYNM74d9xIYov0C+oTlqrJihGot1cbAqEw6CXxMudq1x5ZLCwaX9xXO8BKU
         TekA==
X-Gm-Message-State: AOJu0YwmduH2FXJpzjeUDDZM9ZTlRN0OCfCjVr1iQANxle40U+Mx4VKx
	+CamQghjO2/6g9QhHPhdqYydb0sihq9pud1LTko48n9AJb+GF6DGN3J4CFhQBocXIBh6Sg3/OI8
	gRP5Bwiom+g==
X-Received: from yxc17.prod.google.com ([2002:a05:690e:2111:b0:664:a5e6:e0f2])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:1c07:b0:658:84f5:3c6f
 with SMTP id 956f58d0204a3-6648847e7a5mr7308265d50.58.1782529012345; Fri, 26
 Jun 2026 19:56:52 -0700 (PDT)
Date: Sat, 27 Jun 2026 02:56:38 +0000
In-Reply-To: <20260627025642.4064973-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260627025642.4064973-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260627025642.4064973-2-jmoroni@google.com>
Subject: [PATCH rdma-next 1/5] RDMA/irdma: Enforce empty udata input for
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-22501-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B80B86D0CEB

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


