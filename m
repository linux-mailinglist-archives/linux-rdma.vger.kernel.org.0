Return-Path: <linux-rdma+bounces-21745-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BOm1L6ZlIWoBFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21745-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:46:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D163F8AB
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:46:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=Wh2ceaXS;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21745-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21745-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 947B73096FC7
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84575425CF0;
	Thu,  4 Jun 2026 11:45:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36CD425CE1;
	Thu,  4 Jun 2026 11:45:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573529; cv=none; b=Z2nkp2jg8lEWJcwb1jlY8r2DAyp242iEEChFIX3KrCtxFNCBagsgpr+ZHzEsIydjoFJeWd9G4Z/enJNgspNGbqhJwCwrOLu7/KG/asbpD7/Bn9IugFfcSzi5+94KLHqK56jODBY0FuGVcEeO0xMNHyZErekipdKYb9Dpb/l5WMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573529; c=relaxed/simple;
	bh=vebusa1eZmDb3cD4rm8P2Yx27GhxkEHXrT/cIyaVmwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ro5hhH6fzt0zH7lHdFdb86JiAel6957tS0S6chjxzZ5EBSzXsvKlYa+Ha1eXQXw96VThRsP6MUqwhsVljT0ef9dBVyXuztC/q8794wTkxp9q9+XaUE8kYrFzRSlZEv2QJhGtMVr9MlJPHJ8cFSisAGwZL7vEMplnPIC3+xl0zac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wh2ceaXS; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YM
	/9VqWu3m7TrPwzFB5YPC2jCH/xULVDjTWw9xL6Ghk=; b=Wh2ceaXSLV+HfK+/Rt
	YocLHgKG93qEPocEWv1sI5MAMOjuKSSVtleOlAHL0HMo5jG3qam+ed6BkiV90N+W
	/rQDD9NsGIYblZrDu/0EhDZIwrpoGS66YvXjMKv6pJB0nN2dbE00OFGtR4hJRrhJ
	W0M5mXY5H/tDbbSaLHucdyoxM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA320NHZSFqPEN8AQ--.47837S3;
	Thu, 04 Jun 2026 19:45:12 +0800 (CST)
From: hginjgerx@163.com
To: huangjunxian6@hisilicon.com,
	hginjgerx@qq.com
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:HISILICON ROCE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for-next 1/3] RDMA/hns: Fix hung task when drain qp failed.
Date: Thu,  4 Jun 2026 19:45:08 +0800
Message-Id: <20260604114510.2955010-2-hginjgerx@163.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260604114510.2955010-1-hginjgerx@163.com>
References: <20260604114510.2955010-1-hginjgerx@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgA320NHZSFqPEN8AQ--.47837S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryxuF45ArW8trW5WFW8Xrb_yoW8Cr4fpF
	4Yka45KFWDGFnF9a1xJr4a9w1ftaykG3ykWrZ7Ka43trnxCa1Fqr18t34UtFWrJrZ5J3W2
	vr90grsruFyIvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ji3kZUUUUU=
X-CM-SenderInfo: hkjl0yhjhu5qqrwthudrp/xtbC5AhOIWohZUhmDAAA3P
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21745-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[hginjgerx@163.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:huangjunxian6@hisilicon.com,m:hginjgerx@qq.com,m:tangchengchang@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hisilicon.com,qq.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hginjgerx@163.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,hisilicon.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 232D163F8AB

From: Chengchang Tang <tangchengchang@huawei.com>

The flush CQE is executed asynchronously. If the drain QP has already
triggered the flush CQE, but a HW error occurs during this process,
the driver is unable to detect the flush failure. In this case, the
drain QP thread will wait for the completion signal indefinitely
by using wait_for_completion(), leading to a hung task exception
warning.

Replace wait_for_completion() with wait_for_completion_timeout() to
avoid indefinite waiting.

Fixes: 354e7a6d448b ("RDMA/hns: Support drain SQ and RQ")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4afd7d6ae3ca..fe3c658d8c08 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -914,6 +914,7 @@ static void handle_drain_completion(struct ib_cq *ibcq,
 				    struct hns_roce_drain_cqe *drain,
 				    struct hns_roce_dev *hr_dev)
 {
+#define DRAIN_QP_TMO (HZ * 30)
 #define TIMEOUT (HZ / 10)
 	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
 	unsigned long flags;
@@ -958,8 +959,10 @@ static void handle_drain_completion(struct ib_cq *ibcq,
 		ibcq->comp_handler(ibcq, ibcq->cq_context);
 
 waiting_done:
-	if (ibcq->comp_handler)
-		wait_for_completion(&drain->done);
+	if (ibcq->comp_handler) {
+		if (!wait_for_completion_timeout(&drain->done, DRAIN_QP_TMO))
+			ibdev_err_ratelimited(&hr_dev->ib_dev, "Drain qp timeout!\n");
+	}
 }
 
 static void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
-- 
2.33.0


