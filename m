Return-Path: <linux-rdma+bounces-22976-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9sw1HtkaUGp0tQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22976-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 00:04:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C364C735EE8
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 00:04:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BTa3unaj;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22976-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22976-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A744B30331A9
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757793D88EB;
	Thu,  9 Jul 2026 22:04:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6DD347BAF
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 22:04:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783634646; cv=none; b=jlFMJpB8RSl/09WilnfR+E+U2pjC3cGQ4XgZZbrWtJqxkTWMMm/QZXEmJlD8xi92W2vadf6JI++4Z75Gyezhchqw5O6wYhD2D34FD8xSZNgt0P0HAHhcTQ/ploGRPplZU11BpYQQPrrLeR+shgm6ML5CEhiyGU7IjmD9akKDzjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783634646; c=relaxed/simple;
	bh=8CTuY0rp+50ttcUxPczEqakrirHL7DDnHRxTRnmunmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axJ2CQqmkWLThSf114a+lu9xh7B4xWDgdihnT85YLSRseD14RheZTyr37sY0ppSGaDPkPH74T18/UYOPoh9r9Tfzsp71oiKc7MvX/RIUfbFowy2rtQqxS/1z9mJWkDFtl8VQvDnvpWJyFsdmtP0LPn6s60uKT4jhBt46SCW2GoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTa3unaj; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783634644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JZ6eTJbXFUyCCa7AiotM1+arUJd8tq+Ft2Kk/lg135E=;
	b=BTa3unajyNKAkfSzjbdMxpcqZ2f80SwJSo3WDv1WvUUybe6jTReIOokvtRQc7RJKoL2y00
	0FA+IUW7EPzuTDnfROeDrzUdv78J2B6GBQLr/BVjfBDJHA8oc6VgrgEtEoVeX//kaayqly
	j0MUMuOUIbPvDg4wUWOvxh8+ymDa0nA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-6z0XyiXfPMOQBrmOIEStig-1; Thu,
 09 Jul 2026 18:04:00 -0400
X-MC-Unique: 6z0XyiXfPMOQBrmOIEStig-1
X-Mimecast-MFC-AGG-ID: 6z0XyiXfPMOQBrmOIEStig_1783634639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F15C1955F19;
	Thu,  9 Jul 2026 22:03:59 +0000 (UTC)
Received: from lima-fedora43.redhat.com (unknown [10.22.80.56])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69A2E18004D4;
	Thu,  9 Jul 2026 22:03:57 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: linux-rdma@vger.kernel.org
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH rdma-rc 0/2] RDMA/ionic: Fix NULL pointer dereferences
Date: Thu,  9 Jul 2026 18:03:51 -0400
Message-ID: <20260709220353.729951-1-kheib@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22976-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C364C735EE8

Fix two potential NULL pointer dereferences in the ionic driver by
adding the missing NULL checks before dereferencing netdev pointers.

Kamal Heib (2):
  RDMA/ionic: Fix potential NULL pointer dereference in
    ionic_query_device
  RDMA/ionic: Fix potential NULL pointer dereference in
    ionic_create_ibdev

 drivers/infiniband/hw/ionic/ionic_ibdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.55.0


