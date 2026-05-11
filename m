Return-Path: <linux-rdma+bounces-20417-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPabMjFaAmosrgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20417-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:37:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B783517008
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEA4F302D0B9
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B174356759;
	Mon, 11 May 2026 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="S7RSKjsG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D085356750
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539053; cv=none; b=akzBNrALsd8C0KqKNobWlpc5R+f6auChmflxwVr+6ooPEiJ55w6E1kaSSVyXEqht70i+DItGza0SShfmACfsDOdFFLnH3g+eXcWTAlV3OWPwY0YjH8UNArE9GWAwtCO92QFuAN9p1DeFtBSROy5ODFCiPQNcsCM8sF+l5kuU+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539053; c=relaxed/simple;
	bh=OLAE0nqWY3VpdO1dfZCsyMlaxkKdsASXndsH3/1cATw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmSuuurVGpP1LZCyT2gP+9WZj0sqnqsecu1mtmRsYfy+qKLqDqwnn2529LJxjE1fBV/gufgUOJqBfEN80t9lPPpmN8zWfxhho1qB5tQZG8Rzz8UTHPojstUr0c0hgqVeJmQvKtUKz3htu1hH8vF1I1ZqxzShl+rMy0Qcj9AqOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=S7RSKjsG; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778539052; x=1810075052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8B/OGiAH/b4B4Aeh2MXr1nSgtMC+pKiXcTcihZ2vAg0=;
  b=S7RSKjsGi6t87jtkUC4f0kgnI1dicz2KEFxfDj80Nlz5XRjQRdtmGEnT
   yt3Okh5bqVadzMkw9e6LutTsl8NxjRPBckcU5dmunu9oIiF30Javt23O/
   154TWtXUFo45aUstfySJyzZrbbnnzuGPf7WfWdSNgNXdG+vZuZq21nmgW
   chc3TV/Giuc8fj7LYsKm3wUIeOAxIkRTfKesLIRqbQrWNaLG5ICYbzsuj
   P/GTE27R3X2zUWZgfqIx1Gngg8ihhjUVJ+qRX/N1cocsLAm3dhrTOw+Ib
   ZsOhayTeeDYO/QeMS241FO35SDyJ2lxjUGeunIoR3LPnQy4rV5Q3Mv+HO
   Q==;
X-CSE-ConnectionGUID: MoiG0hnFTJqkDvlQ7GkJJQ==
X-CSE-MsgGUID: gFYsf8M7TS65Et5YYsPVVA==
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="19198566"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:37:29 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:30532]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.215:2525] with esmtp (Farcaster)
 id 2aea27f7-d0f7-4583-8231-6677e1263143; Mon, 11 May 2026 22:37:28 +0000 (UTC)
X-Farcaster-Flow-ID: 2aea27f7-d0f7-4583-8231-6677e1263143
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 11 May 2026 22:37:28 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 11 May 2026
 22:37:27 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v4 3/5] RDMA/core: Add Completion Counters to resource tracking
Date: Mon, 11 May 2026 22:37:19 +0000
Message-ID: <20260511223721.18365-4-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511223721.18365-1-mrgolin@amazon.com>
References: <20260511223721.18365-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 1B783517008
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20417-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
index 96c745d5bac4..155954fef3e2 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -446,6 +446,7 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
 		[RDMA_RESTRACK_MR] = "mr",
 		[RDMA_RESTRACK_CTX] = "ctx",
 		[RDMA_RESTRACK_SRQ] = "srq",
+		[RDMA_RESTRACK_COMP_CNTR] = "comp_cntr",
 	};
 
 	struct nlattr *table_attr;
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index ac3688952cab..d152cc5f042b 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -102,6 +102,8 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
 		return container_of(res, struct ib_srq, res)->device;
 	case RDMA_RESTRACK_DMAH:
 		return container_of(res, struct ib_dmah, res)->device;
+	case RDMA_RESTRACK_COMP_CNTR:
+		return container_of(res, struct ib_comp_cntr, res)->device;
 	default:
 		WARN_ONCE(true, "Wrong resource tracking type %u\n", res->type);
 		return NULL;
diff --git a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
index d64ec4c296dd..cfdbd712ea34 100644
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
index 270b49a7d174..b644a1d8bb90 100644
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


