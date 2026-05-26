Return-Path: <linux-rdma+bounces-21271-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPefNeFMFWoIUQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21271-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:33:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F65D1B95
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3FB300F5DA
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262783CB2FA;
	Tue, 26 May 2026 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="O2CEKuxS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1153BC68E
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779780829; cv=none; b=UMmXH+Xkr/2s/Z3Nu83OXexmZn3qrW+rjUbVXDbFtSK2oChNZyMO3/Hs0WWo0Hd/dqsTFgnKp1vsTrhqOokJrtXDRXjV0rPuF57+pDF3m0VZc8zF4DPeGfF/pDiqPmpbflk3cUDOvrpH7jliIl1uKhv7HWopLRSHxBuShAYRvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779780829; c=relaxed/simple;
	bh=CGmmRhDjUUUVWiObYJqpjKYzm9upLCB01fGTt9N1nkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sj9Lb5EaDa0HYWFMvuu35FWd4gifl7hOBiKmcWyP3ZGQmwjUadSdKJveiHtxyTDE6zoe3fD1BOZLnpGhG/xWItm68+35p2h7w28v8lJ4d2/aD57mE6KpoCCT6MMkFTCOYkS1oj4PgX95Evs5AnAkLacLRE4XcmUFrl9T/PSm/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=O2CEKuxS; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779780828; x=1811316828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9aBWXlORkL978qNe/YRYOVfnGRncFbvIpvDhKVros3c=;
  b=O2CEKuxSWpkUreB0jISe6mz50IO1vyaxPfOLd+9R4we0jXamtzsSQn5p
   0CALHkOU2MobIzDFsaXl7EWtnzVWQjuSkXfe6+ESeik8Mw0pu/LQuWCwR
   8P3X2oPWLeT7KVs9kASnXi9dUZjyb0KyQHbsdWFvv1y/Y5m/JKuR7+k1Q
   OGC/rxorI14rZvpt5W4BPUaVMOW81ZTHTxSeqshDLbgbaT+prNHXvtdb5
   QE3XnhJJ6JfJUc1tiOat4nDrhOe1QCMteGAHiHgDqIW+/VWULNuSNmlW3
   fB6fHV1oPA8nkh9O/AVuHSQhMM0a26pLtkerML0yPI39DZYXdPjGFeWfs
   w==;
X-CSE-ConnectionGUID: Fa9bIYneQxOCHf6hodRYWg==
X-CSE-MsgGUID: CIlNQ8CCQ9y8yu1PkZolKA==
X-IronPort-AV: E=Sophos;i="6.24,169,1774310400"; 
   d="scan'208";a="20446047"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 07:33:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:3637]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.206:2525] with esmtp (Farcaster)
 id f91fb014-429a-4b18-a5b4-3d38cdfdf732; Tue, 26 May 2026 07:33:45 +0000 (UTC)
X-Farcaster-Flow-ID: f91fb014-429a-4b18-a5b4-3d38cdfdf732
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 07:33:45 +0000
Received: from dev-dsk-tomsela-1c-ce9cc34e.eu-west-1.amazon.com (10.15.30.17)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 07:33:43 +0000
From: Tom Sela <tomsela@amazon.com>
To: <mrgolin@amazon.com>, <tomsela@amazon.com>, <jgg@nvidia.com>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-rc] RDMA/efa: Propagate destroy AH error
Date: Tue, 26 May 2026 07:33:34 +0000
Message-ID: <20260526073334.24905-1-tomsela@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21271-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tomsela@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F8F65D1B95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AH destruction currently always returns success, ignoring any error
from the device. Propagate the actual device error so the caller can
handle failures appropriately.

Fixes: 9a9ebf8cd72b ("RDMA: Restore ability to fail on AH destroy")
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Tom Sela <tomsela@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7bd0838ebc99..1e4f052e6385 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -2134,8 +2134,7 @@ int efa_destroy_ah(struct ib_ah *ibah, u32 flags)
 		return -EOPNOTSUPP;
 	}
 
-	efa_ah_destroy(dev, ah);
-	return 0;
+	return efa_ah_destroy(dev, ah);
 }
 
 struct rdma_hw_stats *efa_alloc_hw_port_stats(struct ib_device *ibdev,
-- 
2.47.3


