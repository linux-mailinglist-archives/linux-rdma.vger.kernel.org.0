Return-Path: <linux-rdma+bounces-17415-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NhtvO29lpmlHPQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17415-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 05:37:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCA71E8E03
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 05:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6451230406A8
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 04:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3D377030;
	Tue,  3 Mar 2026 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKgYGwnP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96315374E77
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512617; cv=none; b=sYBayPMEHB6hXiL/HiD35N+8ZtFujIIQoN2dLXB6CSs3fI5I5pg/NR3xHbs5ltVRaKmxzGpFqWEN6KbCRPwzCP8+MjY+ceMd7tHb54uQSlyqSNRE2V/k/zYbhvQ6A0WMBGbIoysbPrwdBNFZK0BGlj/cEBNOIT6M++SNRsZLjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512617; c=relaxed/simple;
	bh=QOnPmJV0B6gEdKmi+0wi4J/iR7lZu4jgitEjkf4T4gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWQNLO4fILOavCAjkdvL1SwE+FkcoMDqsmmX2yzo2Xm294IZP3vi0PU1vUYGmQBEyJR9s7vrveLro74ZIoWeMBFsi5Dab8n4MA2tW6pI956iAd+g051ltuHIjj4YFGGYwtdlKi6QjYoJA912LDPEssOmCXwUtCAstkEYr/Lq/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKgYGwnP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772512615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XprJkV6Y/U/fqBshzlbNfzvJ/G4cJlCbmzjT2x51YhU=;
	b=iKgYGwnPvAffLnq1p4AjUZcGOyan32Y/+SNL072EQQPBbPRPU7XCJKp7xvULn6Vyl2C01I
	9uwA9b2WIrYCSdBWx8NyoWz1rXFQPjAabHn2oDDKYXv/thRAD6cJPWPlWpIRKy2cExI/II
	AXdyViFNYP3gpPn67p5ffoVDFuTe0ds=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-kcZzjKciPteSyBu-wtcMWQ-1; Mon,
 02 Mar 2026 23:36:52 -0500
X-MC-Unique: kcZzjKciPteSyBu-wtcMWQ-1
X-Mimecast-MFC-AGG-ID: kcZzjKciPteSyBu-wtcMWQ_1772512611
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 297F218003FC;
	Tue,  3 Mar 2026 04:36:51 +0000 (UTC)
Received: from lima-fedora.redhat.com (unknown [10.22.80.119])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39AD81800349;
	Tue,  3 Mar 2026 04:36:50 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: linux-rdma@vger.kernel.org
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH for-rc] RDMA/bng_re: Fix silent failure in HWRM version query
Date: Mon,  2 Mar 2026 23:36:45 -0500
Message-ID: <20260303043645.425724-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 5CCA71E8E03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17415-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kheib@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

If the firmware version query fails, the driver currently ignores the
error and continues initializing. This leaves the device in a bad state.

Fix this by making bng_re_query_hwrm_version() return the error code and
update the driver to check for this error and stop the setup process
safely if it happens.

Fixes: 745065770c2d ("RDMA/bng_re: Register and get the resources from bnge driver")
Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index d34b5f88cd40..17147175a9b0 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -210,7 +210,7 @@ static int bng_re_stats_ctx_alloc(struct bng_re_dev *rdev)
 	return rc;
 }
 
-static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
+static int bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 {
 	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
 	struct hwrm_ver_get_output ver_get_resp = {};
@@ -230,7 +230,7 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to query HW version, rc = 0x%x",
 			  rc);
-		return;
+		return rc;
 	}
 
 	cctx = rdev->chip_ctx;
@@ -244,6 +244,8 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 
 	if (!cctx->hwrm_cmd_max_timeout)
 		cctx->hwrm_cmd_max_timeout = BNG_ROCE_FW_MAX_TIMEOUT;
+
+	return 0;
 }
 
 static void bng_re_dev_uninit(struct bng_re_dev *rdev)
@@ -306,7 +308,9 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 		goto msix_ctx_fail;
 	}
 
-	bng_re_query_hwrm_version(rdev);
+	rc = bng_re_query_hwrm_version(rdev);
+	if (rc)
+		goto query_hwrm_ver_fail;
 
 	rc = bng_re_alloc_fw_channel(&rdev->bng_res, &rdev->rcfw);
 	if (rc) {
@@ -392,6 +396,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 nq_alloc_fail:
 	bng_re_free_rcfw_channel(&rdev->rcfw);
 alloc_fw_chl_fail:
+query_hwrm_ver_fail:
 	bng_re_destroy_chip_ctx(rdev);
 msix_ctx_fail:
 	bnge_unregister_dev(rdev->aux_dev);
-- 
2.52.0


