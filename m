Return-Path: <linux-rdma+bounces-19397-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMgKC4ZE4WlErAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19397-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 22:20:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A299C4148C4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 22:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00BC3050230
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C03914E8;
	Thu, 16 Apr 2026 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="V8YtAhML"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF131F9A7
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370474; cv=none; b=YmxFdeKduo0W7JKaPshzFb/uCKdLS3b989Xu1Pa0UnxvUtoiYyeU1SD6qT4+WAKr8mhj5XEKswhHn6PvOvFznbZsKvHvjC3lnY6Hbz6/7jzwoRV11nTR5t3iMNyv21o66mHoZFeYhyQVOhUDNg8KJS4u26j061+mvl1slM38ICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370474; c=relaxed/simple;
	bh=Gwp0b1UoLegjCArxkJL42+tpYJgNGUtcH5x4ySVwVqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oj+Fyl6RYzjx3IsOA8X7aNpe/7p1jGSj/b1ds9IySpV+Nre/lAJ72s/L5QgjZm/WQKN3VAjnLuBO7DBZ/6YBMzQR1APZxMae/V/oJL715Y88vU5eXkjNV6QoJgr8OHsECJ3aXGWgWEJ7sNb/HgIpmJnAegEzhcde1gVbww6BhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=V8YtAhML; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776370469; x=1807906469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NxKRlCVhheyJuIpkmwnPtm2lGhG1LRcr31c6ZLNwb1k=;
  b=V8YtAhML/G8Cx3qNTBv3VDj6m0NdLdQCkr4CrZe6g7pbNYKfgJO11kHt
   6hsOKD3+lnBmbrisjZlbz8BqRGnlu3Vpo6dxTbCT9LjCuvKzAG+ER/Jl9
   GpLymnQXB5rY6/7fY5TFEPM0UojFd5LGE4cggPWnYBlDRxubkihZvNUfh
   d4lf8tI4E4ZOg0y9JLqs/PLQaHYTSj/+E1PPkMlk7+ZseRyoxlQgkKnPd
   l7XBEb8qY2u6gxvnrTlsyrLqDCu+QE8DmqtEmzmT7e0P/BIjVFqwV/mKC
   VQ0l+qUJZI2pT90BDr82TbSyXc0kpGnSyOlI9Ts6D4DuLFjeBj84Tb0AM
   Q==;
X-CSE-ConnectionGUID: O4LW075rSPK9NAZ843KcwA==
X-CSE-MsgGUID: 8L5aENnIQNS/f6nNuWlx4g==
X-IronPort-AV: E=Sophos;i="6.23,181,1770595200"; 
   d="scan'208";a="17320519"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 20:14:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:6334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.68:2525] with esmtp (Farcaster)
 id a34aaf00-b20c-4cdc-8c8a-636e76682907; Thu, 16 Apr 2026 20:14:22 +0000 (UTC)
X-Farcaster-Flow-ID: a34aaf00-b20c-4cdc-8c8a-636e76682907
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 16 Apr 2026 20:14:18 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 16 Apr 2026
 20:14:17 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next] RDMA/core: Fix user CQ creation for drivers without create_cq
Date: Thu, 16 Apr 2026 20:14:08 +0000
Message-ID: <20260416201408.13980-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19397-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A299C4148C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CQ creation is failing for drivers that only implement create_user_cq
(e.g. EFA), when buffer isn't provided by userspace. This because of a
leftover check that requires create_cq existence in such case.

Remove the create_cq existence check from the no-buffer path. The
buffer is optional and drivers that handle their own memory should work
through create_user_cq regardless.

Fixes: 584ec74748e6 ("RDMA/core: Prepare create CQ path for API unification")
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/core/uverbs_std_types_cq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index d2c8f71f934c..79b51f60ce2a 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -172,8 +172,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 		}
 		umem = &umem_dmabuf->umem;
 	} else if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
-		   uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH) ||
-		   !ib_dev->ops.create_cq) {
+		   uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH)) {
 		ret = -EINVAL;
 		goto err_event_file;
 	}
-- 
2.47.3


