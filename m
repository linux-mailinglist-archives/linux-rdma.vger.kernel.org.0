Return-Path: <linux-rdma+bounces-16952-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO1jHbZPlGktCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16952-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 12:23:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D714B4BE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 12:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7C823004DBE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F1331A59;
	Tue, 17 Feb 2026 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PPF5lyKq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6102331A49
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327410; cv=none; b=hH9cvqHwHW0OgAvH17dgLKxM+47srGhVxmdkw8vn3qNBUKe9CfCUEgk7ORjIcyqedsB+xlIjY8BElBIlME1hjEMyHnws/oYz3k2mrTLPTHIHfWWgrAk27KJPrBwp20+ht9Uj7H+9Tak9rfLJV6oYKuDu6BibYudb8nQobe/8Hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327410; c=relaxed/simple;
	bh=6Bf1GLkH7Ne+EKe4A4PUhXIkDg/2ap10kQ0JV6+AN1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOxr1rN4ZbJUsSa9qGIzauVbFhiVLjzFayfgsksYWUXmy79J8BG0bfKsXFeYnMbHE4q7saOtnx06resrHXX4lOBlNpdFIo5uI4K+HhFSNplTVk9RuxQ0wi2Gka/Y/JX0XYJJ5PAODZ7X2pzJV6r5wUdxEKuDSGM5+4gCaygXNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PPF5lyKq; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771327408; x=1802863408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mlClrv1hOv/2S6xgBk+m2G0EitQoMVPzUtU+e3bQhXI=;
  b=PPF5lyKqzJ3CWZzRvIvnBNBXz8nHk30LYd4oJDz/MJeLDremRn61zXhN
   QuRhv7yjA62FnanYRzyrVqnrdZu7AhDCpxHYiFWsjxGLuV3eKpdK5J/ey
   OxmsNYddZl+vRV/luH+yw8JuP5qky0+iyaPzbYiBIc8VUsxgCYuU4LVQL
   2tvSzMvuDiaTAit8EVpr0ivHntP0VseQvvJV+sTJzVgVL8rKUbdIg1+hf
   kPdQRpyqEGwuFHhn2D+ARS6WbCbI2Cs0kg1e0MOcu4to4w3eqaDF6p0N7
   wgrop3kB4uryXoczEnYS1Da9He6sHHy/R+lLY9tEe/TMlfadnYittZotw
   w==;
X-CSE-ConnectionGUID: gTaQjpghSf27bB13vjPS4g==
X-CSE-MsgGUID: 3vFNaj9DQc+fd0OX9iDXuw==
X-IronPort-AV: E=Sophos;i="6.21,296,1763424000"; 
   d="scan'208";a="13217231"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 11:23:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:15521]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.12:2525] with esmtp (Farcaster)
 id 19167fb1-3cf3-4358-8d7a-bebf73b8d14b; Tue, 17 Feb 2026 11:23:23 +0000 (UTC)
X-Farcaster-Flow-ID: 19167fb1-3cf3-4358-8d7a-bebf73b8d14b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 17 Feb 2026 11:23:23 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Tue, 17 Feb 2026
 11:23:22 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v3 3/3] RDMA/efa: Use extended inline buff size for inline validation
Date: Tue, 17 Feb 2026 11:23:04 +0000
Message-ID: <20260217112304.36849-4-ynachum@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217112304.36849-1-ynachum@amazon.com>
References: <20260217112304.36849-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16952-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 975D714B4BE
X-Rspamd-Action: no action

On QP creation we validate the requested max inline size is supported by
the device. Use the new extended max inline size instead of the old one
to support actual max inline available.

Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 85c3a7dd4335..e5756b479eba 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -641,11 +641,11 @@ static int efa_qp_validate_cap(struct efa_dev *dev,
 			  init_attr->cap.max_recv_sge, dev->dev_attr.max_rq_sge);
 		return -EINVAL;
 	}
-	if (init_attr->cap.max_inline_data > dev->dev_attr.inline_buf_size) {
+	if (init_attr->cap.max_inline_data > dev->dev_attr.inline_buf_size_ex) {
 		ibdev_dbg(&dev->ibdev,
 			  "qp: requested inline data[%u] exceeds the max[%u]\n",
 			  init_attr->cap.max_inline_data,
-			  dev->dev_attr.inline_buf_size);
+			  dev->dev_attr.inline_buf_size_ex);
 		return -EINVAL;
 	}
 
-- 
2.47.3


