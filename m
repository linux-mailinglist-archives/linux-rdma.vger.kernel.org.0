Return-Path: <linux-rdma+bounces-19083-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAb+D0bx1GkjywcAu9opvQ
	(envelope-from <linux-rdma+bounces-19083-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 13:57:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995653AE04D
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 13:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24BB1308BA07
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562C3AF648;
	Tue,  7 Apr 2026 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="K7/po8U4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8383AA1B2
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562877; cv=none; b=YG00sTI6XRZ0R0Guo/5Zr92OIxVneOGvlMRFBxFPPqkh6hZOUyKrxry87kZYWFhcBUNoVw9/APHjtx3Ir1WreXVGSFHdYML5SlfntWf/FYox+rflbKNJn4hiG0BSedFuHKX9CSgJKeZS80Ad3NC23yNy6RJfE4lIxjLjWrOZFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562877; c=relaxed/simple;
	bh=bWkhJ/xro1lAqo1i2/mB5QM5JoPirzJIlejOIy9BD/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwxYfPydD5ldnZB8PtaRnptMhj/OIkdoxO74eSPiXelpuOMegNnEGkm+rxBv3By41tYYPyXqFv1sYZutS1ZAbtRSpJkAxJO4cFQmJ/CN8HBFABdGkg8vPjQoI6AqhIau4nGtGcYRPBGsLRa5maD5WKMWgDJWu5t25/yUkxrtj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=K7/po8U4; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775562875; x=1807098875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qw3hHQAOSkTV8kI0gWUE+6Ja5cre/KLKWPPq0YFwVEE=;
  b=K7/po8U4TVx4sVKS190LIOsWvju8RdSADfvel+8ayFHg8R33IMFnQlkG
   3P1mAqwWpu3EPsikyoWHppvMr338C84A13pkWMS4EZ50AdwmhfptS4uwb
   xlE37bM0ToIaMpK0jC/ShnNQP9+SCWYZ4oAJqC1RUmHy6pMdRl1h9AFX3
   dnGn5gectI4ZeIC9tId9m9vngJwDNmO4X31j8kwbVWjUUm6p8gdpE4wEJ
   dUbTAT+kZppDphoRe0bR3xERVFLHfRUsBW8eIWvX8Yf+mqQqECQu65An/
   +IvB+7ym3kf3cH7jSKVEYIvGPJIMBg6kdh2Z1l46Wavm1N/MXcezroRJs
   A==;
X-CSE-ConnectionGUID: 3wwUsxgvQXGbltnTeJsOng==
X-CSE-MsgGUID: o9kmScZfST+Q4Pods4xJCg==
X-IronPort-AV: E=Sophos;i="6.23,165,1770595200"; 
   d="scan'208";a="16733201"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 11:54:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:30671]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.88:2525] with esmtp (Farcaster)
 id aeca6ea2-2009-4d53-9810-fd052932c3e2; Tue, 7 Apr 2026 11:54:33 +0000 (UTC)
X-Farcaster-Flow-ID: aeca6ea2-2009-4d53-9810-fd052932c3e2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 7 Apr 2026 11:54:31 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 7 Apr 2026
 11:54:29 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next 2/4] RDMA/core: Add Completion Counters to resource tracking
Date: Tue, 7 Apr 2026 11:54:22 +0000
Message-ID: <20260407115424.13359-3-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407115424.13359-1-mrgolin@amazon.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19083-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 995653AE04D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index a62c20d4e5a4..708cac838d43 100644
--- a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
+++ b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
@@ -8,6 +8,7 @@
 #include <rdma/ib_umem_dmabuf.h>
 #include "rdma_core.h"
 #include "uverbs.h"
+#include "restrack.h"
 
 static int uverbs_free_comp_cntr(struct ib_uobject *uobject,
 				 enum rdma_remove_reason why,
@@ -20,6 +21,7 @@ static int uverbs_free_comp_cntr(struct ib_uobject *uobject,
 	if (ret)
 		return ret;
 
+	rdma_restrack_del(&cc->res);
 	ib_umem_release(cc->comp_umem);
 	ib_umem_release(cc->err_umem);
 	kfree(cc);
@@ -120,7 +122,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_CREATE)(
 	if (ret)
 		goto err_err_umem;
 
+	rdma_restrack_new(&cc->res, RDMA_RESTRACK_COMP_CNTR);
+	rdma_restrack_set_name(&cc->res, NULL);
+
 	uobj->object = cc;
+	rdma_restrack_add(&cc->res);
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE);
 
 	ret = uverbs_copy_to(attrs,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 76fa705389a4..2193e9d678cb 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1754,6 +1754,7 @@ struct ib_comp_cntr {
 	struct ib_umem		*err_umem;
 	u64			comp_count_max_value;
 	u64			err_count_max_value;
+	struct rdma_restrack_entry res;
 };
 
 struct ib_comp_cntr_attach_attr {
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


