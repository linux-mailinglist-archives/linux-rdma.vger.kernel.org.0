Return-Path: <linux-rdma+bounces-17041-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I51cKYPemGk3NwMAu9opvQ
	(envelope-from <linux-rdma+bounces-17041-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 23:21:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C216B299
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 23:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF129301475E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5BC2E8E09;
	Fri, 20 Feb 2026 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4wYOtnH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E219D093
	for <linux-rdma@vger.kernel.org>; Fri, 20 Feb 2026 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626112; cv=none; b=NCE9MMAWC4yEZnqM+rQVviigZQxawY0cs5bXP3tjdRGUi1PFkJeNoEHoekWagQvDZaduchsDZojdBmFMNRBb7SK6yogC7qWcnfjUC5JeESpNs1RB0VBM6RCFviW06t6OuMbSnUy9tJwtblES/KonSMaObaVy2oUSPd1qiq0KTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626112; c=relaxed/simple;
	bh=Wrmt7v9ScSt9b7z43FGS0Au1fnVb951jWi08/sgn/+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coXG7NZf/LK/YglpnNOHEGZKGwSTQNqCuHS4iqOoGwd2VvAXBoyZmO0b7tlkGmSbO8FIQI9a64VBV1lsicmAK4UPq2vC3NamM6mNtIZYZTVRF38/bQzCv1v0G4Cx69LDw86CrFSsVkeNJdoQmmo2GVdh0v3P2YHOQhLcjXaDhjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4wYOtnH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771626110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lv7FOvvZ2nqB5JyI2hl4/kR3EM7vATzMlCuaNJhPNlo=;
	b=b4wYOtnHgGuLQdlfZeaqm8XBKrQBshj5DmuvE1e+9ICSsAjhuzyIpyub6B2alxUylI+iAA
	xIPytxPNOfLye+oeGbMGFoGIzSdPIUkdRhW3AFRLRaaBZ9IoTCQVpEzGVGXqD5yyPDEPIr
	CZRHxkIbj6Jo9IO/A8nS0pkNPNw+0tU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-QtvkncIvMqG5D7FbJKKt7Q-1; Fri,
 20 Feb 2026 17:21:46 -0500
X-MC-Unique: QtvkncIvMqG5D7FbJKKt7Q-1
X-Mimecast-MFC-AGG-ID: QtvkncIvMqG5D7FbJKKt7Q_1771626105
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47DEA18003F5;
	Fri, 20 Feb 2026 22:21:45 +0000 (UTC)
Received: from lima-fedora.redhat.com (unknown [10.22.64.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4152A3000C26;
	Fri, 20 Feb 2026 22:21:44 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: linux-rdma@vger.kernel.org
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH] RDMA/ionic: Fix potential NULL pointer dereference in ionic_query_port
Date: Fri, 20 Feb 2026 17:21:26 -0500
Message-ID: <20260220222125.16973-2-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17041-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kheib@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 091C216B299
X-Rspamd-Action: no action

The function ionic_query_port() calls ib_device_get_netdev() without
checking the return value which could lead to NULL pointer dereference,
Fix it by checking the return value and return -ENODEV if the 'ndev' is
NULL.

Fixes: 2075bbe8ef03 ("RDMA/ionic: Register device ops for miscellaneous functionality")
Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 164046d00e5d..bd4c73e530d0 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -81,6 +81,8 @@ static int ionic_query_port(struct ib_device *ibdev, u32 port,
 		return -EINVAL;
 
 	ndev = ib_device_get_netdev(ibdev, port);
+	if (!ndev)
+		return -ENODEV;
 
 	if (netif_running(ndev) && netif_carrier_ok(ndev)) {
 		attr->state = IB_PORT_ACTIVE;
-- 
2.52.0


