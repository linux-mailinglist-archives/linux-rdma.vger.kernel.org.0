Return-Path: <linux-rdma+bounces-22862-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TfCAGfJiTWrBzAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22862-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 22:34:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D464E71F8EE
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 22:34:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b="B5Re1J/H";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22862-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22862-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1502302BCD6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 20:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721C3BC69C;
	Tue,  7 Jul 2026 20:34:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184873DD525
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 20:34:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456478; cv=none; b=M3eGnTM+mR3zodnoxzS9a86jIVUwPLDFbUJumRs9jtS9hYgc4H7ej1BYIAA6BuIGt6uAHBXoFC8tdOPMTN6hSSeqNNHsbU9xizaapljZ0YwSR5T0TAKrxwYROLz+MFoW5/WBZHmx6DnBaUzrgj/bhSQxvVVAfAYgXurG+erSaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456478; c=relaxed/simple;
	bh=bTpVNwi/WTTqs6s1spvuk5J3dKYD6Hl7xgvKbLk3k3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dT3j3U/7Y8tRzNoA7VaJfVOwToS6BDd86eRJIept79gZ4Tlp9zp2oyxGOd3mA3W4NoZBxyp/VHb6NrF3jRY6UA8P79TlEPwRSQBbnbQJgiv8EFnA1gQpb1xaY8SD7ebUao5cRtuN+oaHmn2vavN9cjKpCqpC242MoAaeH0Czpqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=B5Re1J/H; arc=none smtp.client-ip=34.218.115.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783456477; x=1814992477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yu/9Rdj569Bpe3zgkP1O6QDbcJVLyO9GqBgIS++tcU4=;
  b=B5Re1J/HkqHt8XwJzv3ToAFWN7Gl2W38GEvW7gUm6jtyZL0QyE/DkSiP
   ZkuzFbep2mAiUKhUe6gnU++ktWSkL+fFQDPzLPZeVszKYULlw/bywd7k6
   Eh+9d5dU5sw91djYyG34Y5UhNCc/7gc/LdE7keVmkFbEcRPAO2KHU+ZFK
   Y9p9TAc6KXlrmq0sFbhLJA0nT+WQ/93DdFuBqA8X1H0worCzx6zgu64Ve
   VgkcXwjlt71/faM/GVrgzwuQjpEpCUrDoacOunE8xVf0brC/bMeKTtqUS
   38s6wKXAN8nSJ1XyK6Wx3Bt3tRf8rtqO7J916JBLtlLV5NpWslReZHXld
   A==;
X-CSE-ConnectionGUID: 6cNZVb/KQDubbJ3mvTLVXg==
X-CSE-MsgGUID: hb26jWGRRqi49ubAUNLqiQ==
X-IronPort-AV: E=Sophos;i="6.25,153,1779148800"; 
   d="scan'208";a="23044154"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 20:34:34 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:15836]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.125:2525] with esmtp (Farcaster)
 id e9507e28-bebb-4f8d-86d0-fe496d9913b2; Tue, 7 Jul 2026 20:34:33 +0000 (UTC)
X-Farcaster-Flow-ID: e9507e28-bebb-4f8d-86d0-fe496d9913b2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 7 Jul 2026 20:34:33 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Tue, 7 Jul 2026
 20:34:31 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v8 2/5] RDMA/core: Prevent destroying in-use completion counters
Date: Tue, 7 Jul 2026 20:34:24 +0000
Message-ID: <20260707203427.6923-3-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707203427.6923-1-mrgolin@amazon.com>
References: <20260707203427.6923-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22862-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D464E71F8EE

Reject comp_cntr destroy while it is attached to any QP. Track
attachments using an xarray in ib_qp keyed by the attach op_mask.
Use op bitmask to reject overlapping attaches early.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 .../core/uverbs_std_types_comp_cntr.c          |  3 +++
 drivers/infiniband/core/uverbs_std_types_qp.c  | 18 +++++++++++++++++-
 drivers/infiniband/core/verbs.c                |  8 ++++++++
 include/rdma/ib_verbs.h                        |  3 +++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
index 29033f9ea9b6..dfca9756bcd1 100644
--- a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
+++ b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
@@ -13,6 +13,9 @@ static int uverbs_free_comp_cntr(struct ib_uobject *uobject, enum rdma_remove_re
 	struct ib_comp_cntr *cc = uobject->object;
 	int ret;
 
+	if (atomic_read(&cc->usecnt))
+		return -EBUSY;
+
 	ret = cc->device->ops.destroy_comp_cntr(cc);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index 1a32a902bdba..30fc20fb251f 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -403,7 +403,23 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_ATTACH_COMP_CNTR)(
 	if (!attr.op_mask)
 		return -EINVAL;
 
-	return qp->device->ops.qp_attach_comp_cntr(qp, cc, &attr);
+	if (attr.op_mask & qp->comp_cntr_op_mask)
+		return -EBUSY;
+
+	ret = xa_err(xa_store(&qp->comp_cntrs, attr.op_mask, cc, GFP_KERNEL));
+	if (ret)
+		return ret;
+
+	ret = qp->device->ops.qp_attach_comp_cntr(qp, cc, &attr);
+	if (ret) {
+		xa_erase(&qp->comp_cntrs, attr.op_mask);
+		return ret;
+	}
+
+	atomic_inc(&cc->usecnt);
+	qp->comp_cntr_op_mask |= attr.op_mask;
+
+	return 0;
 }
 
 DECLARE_UVERBS_NAMED_METHOD(
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3b613b57e269..e30e250640c8 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1293,6 +1293,7 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->qp_context = attr->qp_context;
 
 	spin_lock_init(&qp->mr_lock);
+	xa_init(&qp->comp_cntrs);
 	INIT_LIST_HEAD(&qp->rdma_mrs);
 	INIT_LIST_HEAD(&qp->sig_mrs);
 	init_completion(&qp->srq_completion);
@@ -1327,6 +1328,7 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 		qp, uattrs ? uverbs_get_cleared_udata(uattrs) : NULL);
 err_create:
 	rdma_restrack_put(&qp->res);
+	xa_destroy(&qp->comp_cntrs);
 	kfree(qp);
 	return ERR_PTR(ret);
 
@@ -2144,6 +2146,8 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	const struct ib_gid_attr *alt_path_sgid_attr = qp->alt_path_sgid_attr;
 	const struct ib_gid_attr *av_sgid_attr = qp->av_sgid_attr;
 	struct ib_qp_security *sec;
+	struct ib_comp_cntr *cc;
+	unsigned long index;
 	int ret;
 
 	WARN_ON_ONCE(qp->mrs_used > 0);
@@ -2174,6 +2178,10 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (av_sgid_attr)
 		rdma_put_gid_attr(av_sgid_attr);
 
+	xa_for_each(&qp->comp_cntrs, index, cc)
+		atomic_dec(&cc->usecnt);
+	xa_destroy(&qp->comp_cntrs);
+
 	ib_qp_usecnt_dec(qp);
 	if (sec)
 		ib_destroy_qp_security_end(sec);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8ad9584ba0cc..723bf368c41f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1752,6 +1752,7 @@ struct ib_comp_cntr {
 	struct ib_uobject *uobject;
 	u64 comp_count_max_value;
 	u64 err_count_max_value;
+	atomic_t usecnt;
 };
 
 enum ib_comp_cntr_entry {
@@ -1947,6 +1948,8 @@ struct ib_qp {
 	struct completion	srq_completion;
 	struct ib_xrcd	       *xrcd; /* XRC TGT QPs only */
 	struct list_head	xrcd_list;
+	struct xarray		comp_cntrs; /* op_mask -> comp_cntr */
+	u32			comp_cntr_op_mask;
 
 	/* count times opened, mcast attaches, flow attaches */
 	atomic_t		usecnt;
-- 
2.47.3


