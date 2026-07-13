Return-Path: <linux-rdma+bounces-23154-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /2o9OIUdVWqBkAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23154-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:16:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D05974DEF5
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:16:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ma8JmQ5q;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23154-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23154-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C3BD3040A8A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFAD3438BD;
	Mon, 13 Jul 2026 17:13:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35618224F3
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 17:13:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962792; cv=none; b=XoRQyfXkDbwvhV3jt/R5wmSCijO2oPP8hVUnmiF21F0NbxaTfkBALT0iK3kuzf4nQ5RrQgrmqAXf/o6dWLw1qwUBMlW0PJr3wKt94eZhUxw81Uhr2qZYCFZqXZidXc0NruJg5nTat7ipsT8uHGAt0UzgbRbXD7X4spWkznihDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962792; c=relaxed/simple;
	bh=xsxwODBGAPyFp4Ft6IyXswY7HDJNqazdx1HBkEQhSYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ah9VPmED68KBWCqWdgnVN1rB5m2Vrz0uJTduRk8scip8F5yFfeR6hh4j3/SRss1KEA51EqIWVcV2oGz6T+An7Ur0V/CUgWzajUsaHpHu6jN2eTNMzAoqXJDScu3fFXS/7z1P5Klv6ni53OcfJWOjnj2X15XkyqqF3vP1BqmoROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ma8JmQ5q; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51bf321d786so1373091cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783962790; x=1784567590; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tcutcPBX8LiIp5sHYqcCqsSfwMVQC2Ex7o3EgEMr/Co=;
        b=ma8JmQ5qcx8FcfRcwlVpvvgkQGG6GZrKcEukq+p9PMgPqP8DNT2NnhKKg2JaWJi+lH
         An/5M8cu5Ezi1dEdi6rYoL8kyQo0oGDua8i/T61ZluercMzdEqtRpZNcvyf2X/V6G1CU
         hdVgwHi1imtxznjgpcAF8Q0Dx7tdFwW0CMuQSxCmor+FeppMpCdnAtbp4UYLLdgZP00a
         dRs0zeHk4rRHibMrfQVCpE/6Ir23M5YpGpKJj/ki3GtuRx99nxinELjK+cXyDvVIAXdY
         iw7RXY306GfAO2kCxkw6V9VBIfRmIuYi1qYJauccYoA0fTiznF8F3tlnFci/dbwzpIHO
         Ofmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783962790; x=1784567590;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tcutcPBX8LiIp5sHYqcCqsSfwMVQC2Ex7o3EgEMr/Co=;
        b=DlVHbl2vMHXBt2m30jKlUFaf9vD8rcRquJJIFXXAH1dOY/jTmK7NqxTSve/Wa1vhJZ
         YLd3BbYGJJCuCM900tedhAH8oYlH0X0NFQNt8WmLpdpSSf9YycGKyvvgUShP7i9Fdr6y
         FgA3x5p8RqOmXnYiQuFP8GNwVlU9ohT0jpkWdynY/f4Dc7z4MiB9sOe5ETFPgjqy4F8z
         KqmxG/zMKgqYZk4bm8iZCCQ+n776DWdPWaomJKOUDgwO0E6c8USdSRI3531RySvd5BU5
         ElsKJT7sBJ2fgtkvs6fB5VU1FaqTHhMLGXmFpJfeOlXeC3xoKENypyGR0rmheP6JZVqM
         5Z5w==
X-Gm-Message-State: AOJu0YxC9wNM4NH7tKK4yMINvPRPnSMzuNwExfyn5BwcJRcDAXMJivl8
	yg9N02QrMFPb+i+wCYK3nywGSSd9V/EPrcKrBDXhMSVa301G2MN4OVxkX5n+iVRcGN7q2uhSMJJ
	7+KssyRfr9A==
X-Received: from qtkb9.prod.google.com ([2002:ac8:7fc9:0:b0:51c:e93:45f5])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:5f96:0:b0:517:905d:dc72
 with SMTP id d75a77b69052e-51cbf05bc66mr97810111cf.18.1783962789729; Mon, 13
 Jul 2026 10:13:09 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:12:52 +0000
In-Reply-To: <20260713171257.3131493-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713171257.3131493-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713171257.3131493-2-jmoroni@google.com>
Subject: [PATCH rdma-next v4 1/6] RDMA/irdma: Add checks for no udata
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
	TAGGED_FROM(0.00)[bounces-23154-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D05974DEF5

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
index 965fec124bc..db297974214 100644
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
 
@@ -4023,6 +4069,10 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	bool dmabuf_revocable = iwmr->region && iwmr->region->is_dmabuf;
 	int ret;
 
+	ret = ib_no_udata_io(udata);
+	if (ret)
+		return ret;
+
 	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM) {
 		if (iwmr->region) {
 			struct irdma_ucontext *ucontext;
@@ -5344,6 +5394,10 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 	struct irdma_ah *parent_ah;
 	int err;
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	if (udata->outlen < IRDMA_CREATE_AH_MIN_RESP_LEN)
 		return -EINVAL;
 
@@ -5395,6 +5449,10 @@ static int irdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *attr,
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
2.55.0.795.g602f6c329a-goog


