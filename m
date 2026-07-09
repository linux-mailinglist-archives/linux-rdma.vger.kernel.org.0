Return-Path: <linux-rdma+bounces-22977-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tfyEAicbUGqjtQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22977-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 00:05:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA208735EF3
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 00:05:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EmUls5XM;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22977-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22977-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64EC4302881D
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 22:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2606B3DEAC2;
	Thu,  9 Jul 2026 22:04:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A53DDAE2
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 22:04:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783634647; cv=none; b=ryFZ+fJ4YffBv89xVUbDWiHJegpjXqL6mHNzY/SME8iHK6lIMdTtgyujp6yp4rfVUdqgBZZJAPhyPzKF21EGB+8+Zbibs6jq2jaPGslIYgzpXWeUuTS7TrspEL8yGatW6YG3knDIE0AZDiCL78Iv6onDmjAjqTBY9UXCymUP/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783634647; c=relaxed/simple;
	bh=seNJmBfWOr1+xiEtRxX8BxaiRGbk2nCEifvisn5LmXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iK+Q4Ym+FFT03DZMv7qxkcuVsJvb3xoqyzQRHec02BHoQ65it1V2kMFFGHpR+u3jBJt94msPOWh82J4r7XKWHekBFJ5PMXygkhHaShA0xJGZ5lEXcB7H7gSB6HNROPOBi67T37Ou4zi8Nw9KEYLfzIzjn+H/RU5G58uKAbNspUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmUls5XM; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783634645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTILFqUwvrUgLGjZdU4373l6qqH2yygsdTPE6cH2z5o=;
	b=EmUls5XMGmoeBnJF2t3RVjTS+mDL+pQO/0CL6NFvEvBH41VbHXSz+fxOUUPj0K0ZSJ7aN7
	TWEpXOlDfESokyCYtdKk0gooIaRYfLaeIcycfoArMLBwT1f5HdqQcKjldCSDamRKY8HxtR
	c2aHitjbmxZjVJE5m2i9EiTIxHcFs0w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-OCs9t6XBP_qjaiQbgmk5RQ-1; Thu,
 09 Jul 2026 18:04:02 -0400
X-MC-Unique: OCs9t6XBP_qjaiQbgmk5RQ-1
X-Mimecast-MFC-AGG-ID: OCs9t6XBP_qjaiQbgmk5RQ_1783634641
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 406F0195606C;
	Thu,  9 Jul 2026 22:04:01 +0000 (UTC)
Received: from lima-fedora43.redhat.com (unknown [10.22.80.56])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AAE918004D4;
	Thu,  9 Jul 2026 22:03:59 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: linux-rdma@vger.kernel.org
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH rdma-rc 1/2] RDMA/ionic: Fix potential NULL pointer dereference in ionic_query_device
Date: Thu,  9 Jul 2026 18:03:52 -0400
Message-ID: <20260709220353.729951-2-kheib@redhat.com>
In-Reply-To: <20260709220353.729951-1-kheib@redhat.com>
References: <20260709220353.729951-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22977-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:abhijit.gangurde@amd.com,m:allen.hubbe@amd.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:kheib@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[kheib@redhat.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kheib@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA208735EF3

The function ionic_query_device() calls ib_device_get_netdev() without
checking the return value which could lead to NULL pointer dereference,
Fix it by checking the return value and return -ENODEV if the 'ndev' is
NULL.

Fixes: 2075bbe8ef03 ("RDMA/ionic: Register device ops for miscellaneous functionality")
Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index b0449c75f893..8614546b2558 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -32,6 +32,9 @@ static int ionic_query_device(struct ib_device *ibdev,
 		return err;
 
 	ndev = ib_device_get_netdev(ibdev, 1);
+	if (!ndev)
+		return -ENODEV;
+
 	addrconf_ifid_eui48((u8 *)&attr->sys_image_guid, ndev);
 	dev_put(ndev);
 	attr->max_mr_size = dev->lif_cfg.npts_per_lif * PAGE_SIZE / 2;
-- 
2.55.0


