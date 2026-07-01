Return-Path: <linux-rdma+bounces-22632-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 79kvAO7tRGqO3QoAu9opvQ
	(envelope-from <linux-rdma+bounces-22632-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 12:37:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FFC6EC37F
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 12:37:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=qC8zNKQd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22632-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22632-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDBD30C7002
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED623C345A;
	Wed,  1 Jul 2026 10:35:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B44192EC
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 10:34:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902105; cv=none; b=jNcJVnQXhfOWhJOgf8A0D4z4QGxhtOE5mgknsa+Ih1UqVvX4umKeJSdiP0w8z5pDKIh7UK2e/hdkC94a4xEjG2WIMwtniWpmfRT2dQjwGEDb8RHo1wc28jnAxoDiJwyxDuCYIOodVHtqbwxqPQwrR8tn+GTuI9GzzQbd93kxMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902105; c=relaxed/simple;
	bh=Reeuy9UAR/uM3+aAo4vLWdZyYHZU+iZG5S4+tu37gqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8dPsVnhkCHPLB419n2zb/McrZyXar1jKbLHjHOdS5msTo02P3vX1yxc7NaKsqf6AL5uIx39/DYrAC55tUjI9/Ak49Wsmjy5l/MRa2n0E0EQNYlzuLWSwhWiP3OFSOHL3Mm2WJRMMqjB9kCG4nN+VoK4GRPQdlKQty9Td4+UH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qC8zNKQd; arc=none smtp.client-ip=44.246.77.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782902099; x=1814438099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jaQu7HWONq/gsfJe+ioyBKCGDKAaLq6Sv5MlP+blZpM=;
  b=qC8zNKQdvcI7uqEhv6x7dE6507TznfR+UCTDxROlcdwT5nis3QoPp4Ke
   kDxhuAzjc8I/S/owO5uEmIrApLTYbJbcLhUP18xtpw64pNaMa1v5MBfGu
   GZffj5GTXl1o9nYdgfC7zjMvmFmY1kQl367/Lu4bBlvFwqRDZ9FraUUwr
   8UgQHhDJDw16Iccp4Z0VyX38e+LRJDnNrHqO3q3Xrn24TYGAnhWQM4JT6
   Cn+k/gEtk2OyLrMjFtREdAL1WLfk8IZs1xxTAktt6mJ5mIsOS/nxe37ui
   GJ+i1/DCcXS7+fpjzW3mdwn/6FMQbyWhzOewgNA74bxdbmxEFQc/XLuwx
   A==;
X-CSE-ConnectionGUID: RuMplb8tR+iXKKE3HSo4OQ==
X-CSE-MsgGUID: beRih1jLTpWhOuhSXic/Ew==
X-IronPort-AV: E=Sophos;i="6.25,141,1779148800"; 
   d="scan'208";a="22835295"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 10:34:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:4690]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.151:2525] with esmtp (Farcaster)
 id 496bc69c-eb53-47fc-8a1f-ade43045ec7f; Wed, 1 Jul 2026 10:34:56 +0000 (UTC)
X-Farcaster-Flow-ID: 496bc69c-eb53-47fc-8a1f-ade43045ec7f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 1 Jul 2026 10:34:55 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Wed, 1 Jul 2026
 10:34:54 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v7 3/5] RDMA/core: Add Completion Counters to resource tracking
Date: Wed, 1 Jul 2026 10:34:46 +0000
Message-ID: <20260701103448.17895-4-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701103448.17895-1-mrgolin@amazon.com>
References: <20260701103448.17895-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22632-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55FFC6EC37F

Track completion counter objects in the resource tracking database so
they are visible through the rdma netlink interface. The rdma tool
displays the comp_cntr count in the resource summary.

Add RDMA_RESTRACK_COMP_CNTR type, embed rdma_restrack_entry in
ib_comp_cntr, and add the res_to_dev mapping. Register the resource
on create and remove it on destroy.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/core/nldev.c                      | 1 +
 drivers/infiniband/core/restrack.c                   | 2 ++
 drivers/infiniband/core/uverbs_std_types_comp_cntr.c | 6 ++++++
 include/rdma/ib_verbs.h                              | 1 +
 include/rdma/restrack.h                              | 4 ++++
 5 files changed, 14 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 02a0a9c0a4a6..471e803dc251 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -447,6 +447,7 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
 		[RDMA_RESTRACK_MR] = "mr",
 		[RDMA_RESTRACK_CTX] = "ctx",
 		[RDMA_RESTRACK_SRQ] = "srq",
+		[RDMA_RESTRACK_COMP_CNTR] = "comp_cntr",
 	};
 
 	struct nlattr *table_attr;
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index cfee2071586c..41359fce4dc0 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -104,6 +104,8 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
 		return container_of(res, struct ib_srq, res)->device;
 	case RDMA_RESTRACK_DMAH:
 		return container_of(res, struct ib_dmah, res)->device;
+	case RDMA_RESTRACK_COMP_CNTR:
+		return container_of(res, struct ib_comp_cntr, res)->device;
 	default:
 		WARN_ONCE(true, "Wrong resource tracking type %u\n", res->type);
 		return NULL;
diff --git a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
index 967f05f76bbe..41236cb39703 100644
--- a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
+++ b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
@@ -6,6 +6,7 @@
 #include <rdma/uverbs_std_types.h>
 #include "rdma_core.h"
 #include "uverbs.h"
+#include "restrack.h"
 
 static int uverbs_free_comp_cntr(struct ib_uobject *uobject, enum rdma_remove_reason why,
 				 struct uverbs_attr_bundle *attrs)
@@ -20,6 +21,7 @@ static int uverbs_free_comp_cntr(struct ib_uobject *uobject, enum rdma_remove_re
 	if (ret)
 		return ret;
 
+	rdma_restrack_del(&cc->res);
 	kfree(cc);
 	return 0;
 }
@@ -48,7 +50,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_CREATE)(struct uverbs_attr_bun
 	if (ret)
 		goto err_free;
 
+	rdma_restrack_new(&cc->res, RDMA_RESTRACK_COMP_CNTR);
+	rdma_restrack_set_name(&cc->res, NULL);
+
 	uobj->object = cc;
+	rdma_restrack_add(&cc->res);
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE);
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_COMP_CNTR_RESP_COUNT_MAX_VALUE,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 723bf368c41f..6fbf465b18cc 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1753,6 +1753,7 @@ struct ib_comp_cntr {
 	u64 comp_count_max_value;
 	u64 err_count_max_value;
 	atomic_t usecnt;
+	struct rdma_restrack_entry res;
 };
 
 enum ib_comp_cntr_entry {
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 451f99e3717d..4ab72bc6d8c7 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -60,6 +60,10 @@ enum rdma_restrack_type {
 	 * @RDMA_RESTRACK_DMAH: DMA handle
 	 */
 	RDMA_RESTRACK_DMAH,
+	/**
+	 * @RDMA_RESTRACK_COMP_CNTR: Completion Counter
+	 */
+	RDMA_RESTRACK_COMP_CNTR,
 	/**
 	 * @RDMA_RESTRACK_MAX: Last entry, used for array dclarations
 	 */
-- 
2.47.3


