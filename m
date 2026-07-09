Return-Path: <linux-rdma+bounces-22978-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6GrgJSobUGqktQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22978-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 00:05:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6CA735EF6
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 00:05:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DpEOLwQk;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22978-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22978-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99635302B3A7
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7E3D75BC;
	Thu,  9 Jul 2026 22:04:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84A3DB64B
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 22:04:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783634650; cv=none; b=peFYoPKAg3FY6VkREaYIJ+4e2Bj7RNF5gDbLpU6ztU+2PzAd0woecg4gYopS2jqkjaJB+ES39YADton4XHlsrANA+HDZxLHvgj7GJderMQq+wM5rTMyQO7Q+Y/BYWy1eLYphH46hqe9ikSckE8vpjJGWsIlkXW5I/cEDKUdy5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783634650; c=relaxed/simple;
	bh=SLRygtL8PYdaF0y40wvuOUGMmZQCCUNipD24skUoDow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+CU0ZCOe23n3w0b6A2qDNreUhTAu4qtSIdMHaSiYXq2JbCEmVbXT4C5o5Yj/F23StT9BU9W9LOCRDiILfhSTpDUng0PVEx3Yd9oMRi0no/j/N0RKS7+aehItnsca8Ep6FzVsjqzaiMUvNKGKKthzedaNpKQeLbOZhAHq6qlR/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpEOLwQk; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783634647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnUp6qjGBob0N/SRZ7zKy7NhfyN8EoWWWrbVSgjNge0=;
	b=DpEOLwQkruZEKs9DSVHcfhigrc3K6g9/9vfjux0n4LVgQNRUrCOV1DggTQ5q2k7gg9osVI
	HPG5cRSTiN3UaT94wB7EWXFrNrBjgZsPfGZ5Mf3E8pdjv+9+5nlBO7+tqz3yKtmlXl1bMW
	QeFJWehyXixn0AKKS4CEW5GHeQ/hSmA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-GT58c4lxNFmv1G-SXoGcdw-1; Thu,
 09 Jul 2026 18:04:04 -0400
X-MC-Unique: GT58c4lxNFmv1G-SXoGcdw-1
X-Mimecast-MFC-AGG-ID: GT58c4lxNFmv1G-SXoGcdw_1783634643
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F4EE1956048;
	Thu,  9 Jul 2026 22:04:03 +0000 (UTC)
Received: from lima-fedora43.redhat.com (unknown [10.22.80.56])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9279E180059F;
	Thu,  9 Jul 2026 22:04:01 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: linux-rdma@vger.kernel.org
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH rdma-rc 2/2] RDMA/ionic: Fix potential NULL pointer dereference in ionic_create_ibdev
Date: Thu,  9 Jul 2026 18:03:53 -0400
Message-ID: <20260709220353.729951-3-kheib@redhat.com>
In-Reply-To: <20260709220353.729951-2-kheib@redhat.com>
References: <20260709220353.729951-1-kheib@redhat.com>
 <20260709220353.729951-2-kheib@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-22978-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 3D6CA735EF6

The ionic_lif_netdev() function can return NULL if lif->netdev is not set,
but the caller in ionic_create_ibdev() was not checking for this before
dereferencing the returned pointer in addrconf_ifid_eui48().

Add a NULL check after calling ionic_lif_netdev() and return -ENODEV if
no netdev is available.

Fixes: 8d765af51a09 ("RDMA/ionic: Register auxiliary module for ionic ethernet adapter")
Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 8614546b2558..c738eb5be085 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -348,6 +348,11 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	ibdev->num_comp_vectors = dev->lif_cfg.eq_count - 2;
 
 	ndev = ionic_lif_netdev(ionic_adev->lif);
+	if (!ndev) {
+		rc = -ENODEV;
+		goto err_admin;
+	}
+
 	addrconf_ifid_eui48((u8 *)&ibdev->node_guid, ndev);
 	rc = ib_device_set_netdev(ibdev, ndev, 1);
 	/* ionic_lif_netdev() returns ndev with refcount held */
-- 
2.55.0


