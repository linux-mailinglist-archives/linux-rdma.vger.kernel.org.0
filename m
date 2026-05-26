Return-Path: <linux-rdma+bounces-21279-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN+YMDRjFWprUwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21279-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:09:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CFC5D305D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 845E530451F0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB53D1ABE;
	Tue, 26 May 2026 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZHZdmhgd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA236356A12
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786447; cv=none; b=co3Brwqj3O7fUulxmZVfvwlmKvmYW67+xdnDcEva2ubst1ZVm9yl3cgaLKB9Qse9o7dxSzuxJRO8wWVGP16lCFkQdpb1ImiAjVR/1LPGRTJICtkVBFAyBcqqH/U90mjz92n7qU8gsuxevOBhtfs8XT51LlXHfEql/ZI9wNLzVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786447; c=relaxed/simple;
	bh=3fGEfBXSJ9Ca6VsUZqI1ST9X3nGq5EjGBOe0b9UeUtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbVwmYmdCN33OCWzPmmiozuklsDTCLpsBR5uwfbvySStPFgu1YAzVWo6RfbO8uOCaA724ie+wcUwU7/x8Pr0HaId687mfc0K3WXV4nD0dnA3rleKVMzVDVuTYDIX7zn8xrihZ/DjUrdujh7dC0G3BdZG3Er7a9z5IN6AC/A5egE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZHZdmhgd; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779786445; x=1811322445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ah+rWSdu+d8UedvkU1lD3PJYduWu6otjmFXbmHIEN2w=;
  b=ZHZdmhgdUa00S+IFzfbvFM0pXbF37ID1EkwVml7lhm7IGj2eKE49W8XJ
   XEVBzp3yHuB/eLjzfLG8nHQ+qpsh/15mkVVXAwUIVVTZoFpz8FmOwAyp0
   DX/Agn0XnYAZKLtyUkeyQgePipBQ8IVEyP4iWvnORer/Ls2GOvz33qj2b
   +N0pPpUTXpjLrbsIi+UMOfLERDbyUTHnwuBlRiTZPi0A+IjORaPynxbhX
   gYHdMtqP1VcLGLcLuUO9xSXtXfb0odRGFI83E8nsnky/OWk8xgMnWAEkq
   nNoat+i1IRXkxF/Hhh/u2PheMmFgPbarJ453gEiR75/X3bkcrxwMwE7A3
   w==;
X-CSE-ConnectionGUID: ipOm2F5zTDes1J0+byVHuA==
X-CSE-MsgGUID: V4hnfTIwStuOgXvY3KsiKQ==
X-IronPort-AV: E=Sophos;i="6.24,169,1774310400"; 
   d="scan'208";a="20260840"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:07:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:14523]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.25:2525] with esmtp (Farcaster)
 id 5c3db884-2c62-41ad-bcbe-8ff12b07a81f; Tue, 26 May 2026 09:07:20 +0000 (UTC)
X-Farcaster-Flow-ID: 5c3db884-2c62-41ad-bcbe-8ff12b07a81f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 09:07:18 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 26 May 2026
 09:07:16 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v5 2/5] RDMA/core: Prevent destroying in-use completion counters
Date: Tue, 26 May 2026 09:07:09 +0000
Message-ID: <20260526090712.17575-3-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526090712.17575-1-mrgolin@amazon.com>
References: <20260526090712.17575-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21279-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 73CFC5D305D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject comp_cntr destroy while it is attached to any QP. Track
attachments using an xarray in ib_qp keyed by the attach op_mask.
Use op bitmask to reject overlapping attaches early.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 .../infiniband/core/uverbs_std_types_comp_cntr.c |  3 +++
 drivers/infiniband/core/uverbs_std_types_qp.c    | 16 +++++++++++++++-
 drivers/infiniband/core/verbs.c                  |  8 ++++++++
 include/rdma/ib_verbs.h                          |  3 +++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
index 91ad54b270cf..967f05f76bbe 100644
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
index c401972865a0..aa740478c117 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -395,7 +395,21 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_ATTACH_COMP_CNTR)(
 	if (!attr.op_mask)
 		return -EINVAL;
 
-	return qp->device->ops.qp_attach_comp_cntr(qp, cc, &attr);
+	if (attr.op_mask & qp->comp_cntr_op_mask)
+		return -EBUSY;
+
+	ret = qp->device->ops.qp_attach_comp_cntr(qp, cc, &attr);
+	if (ret)
+		return ret;
+
+	ret = xa_err(xa_store(&qp->comp_cntrs, attr.op_mask, cc, GFP_KERNEL));
+	if (ret)
+		return ret;
+
+	atomic_inc(&cc->usecnt);
+	qp->comp_cntr_op_mask |= attr.op_mask;
+
+	return 0;
 }
 
 DECLARE_UVERBS_NAMED_METHOD(
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bac87de9cc67..3a7ab4df89d1 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1293,6 +1293,7 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->qp_context = attr->qp_context;
 
 	spin_lock_init(&qp->mr_lock);
+	xa_init(&qp->comp_cntrs);
 	INIT_LIST_HEAD(&qp->rdma_mrs);
 	INIT_LIST_HEAD(&qp->sig_mrs);
 	init_completion(&qp->srq_completion);
@@ -1325,6 +1326,7 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->device->ops.destroy_qp(qp, udata ? &dummy : NULL);
 err_create:
 	rdma_restrack_put(&qp->res);
+	xa_destroy(&qp->comp_cntrs);
 	kfree(qp);
 	return ERR_PTR(ret);
 
@@ -2147,6 +2149,8 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	const struct ib_gid_attr *alt_path_sgid_attr = qp->alt_path_sgid_attr;
 	const struct ib_gid_attr *av_sgid_attr = qp->av_sgid_attr;
 	struct ib_qp_security *sec;
+	struct ib_comp_cntr *cc;
+	unsigned long index;
 	int ret;
 
 	WARN_ON_ONCE(qp->mrs_used > 0);
@@ -2177,6 +2181,10 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
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
index 776070e061cd..9cfc5691f217 100644
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


