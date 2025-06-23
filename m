Return-Path: <linux-rdma+bounces-11532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B770AE37C2
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDB31726A7
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09815218AC1;
	Mon, 23 Jun 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="18p/3Iu3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668911FE471;
	Mon, 23 Jun 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750665820; cv=none; b=dq9jicTQnyZDiihp4PF1dVuzVomnppgxCMBFuSWUu97xtIRVQs5DM6KcKyAvqhXPd0eX/kqgx+1TWPL8VKUQ0vRXBvtz9owbeT4bLBq5CZAq5DOIwaiLBJLZBXTOKYv+v8OHkbweyO38E6P5DLC92gPD30TkFpzBjcrdDMfJBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750665820; c=relaxed/simple;
	bh=Nbi/LRaUdXUfs4xX5S6kikdylOckq1IzPJw0YQbto8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQbkyiCxAEGfDj68yS6dPzA8WmiS4Vzpa88zXSOpQVujYMQSCMqtw5DTEwek5YXLpqEr2sO+x9iA+DI18L0vejw1sZjbZeG2TuwgXAoHKXm//WV4g4oUGgX1q3CUUrjNjmhaVyEnRwDNRA3UBJqxnP5N4T2KF519PHHOPx10fmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=18p/3Iu3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KcvnqVn9z4ugRuUKq/fSUnCCQ1hYNuish+Qsv9QWSuI=; b=18p/3Iu3HoDAV7WUKRG8rTKnIp
	OqbG0KldNkzgg9aQ43z+zT5a3tnhQlfpAuLhN/wTm1V6YSK2QYhJmc37V35DbInaxz9IMgOFGdrCj
	OZ+TqtVSnLsSITBjhWbHRfbzzWUyH5DEkaVehb+AQ6J8GRJMTJtm2xyrFajtGr2o/Zga61M+NWU37
	BT2Rqy4xpVb6J7TW6j808sE9VNvHaBGZxZrf0Zw6PUmvn02oVSxz+eZw4WbQc/kJOD0yqLRBELzj9
	kUMXrj75SsLyhdiAUGunDXk18mCeKsfxLUOdEJQOZEeVd0jLhgLyat/Z8F6+++w4yeTV2F7QRGEZu
	VYS7r28A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTc9O-00000001wyM-41ny;
	Mon, 23 Jun 2025 08:03:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"Ewan D. Milne" <emilne@redhat.com>,
	Laurence Oberman <loberman@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] scsi: enforce unlimited max_segment_size when virt_boundary_mask is set
Date: Mon, 23 Jun 2025 10:02:54 +0200
Message-ID: <20250623080326.48714-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250623080326.48714-1-hch@lst.de>
References: <20250623080326.48714-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The virt_boundary_mask limit requires an unlimited max_segment_size for
bio splitting to not corrupt data.  Historically, the block layer tried
to validate this, although the check was half-hearted until the addition
of the atomic queue limits API.  The full blown check than triggered
issues with stacked devices incorrectly inheriting limits such as the
virt boundary and got disabled in commit b561ea56a264 ("block: allow
device to have both virt_boundary_mask and max segment size") instead of
fixing the issue properly.

Ensure that the SCSI mid layer doesn't set the default low
max_segment_size limit for this case, and check for invalid
max_segment_size values in the host template, similar to the original
block layer check given that SCSI devices can't be stacked.

This fixes reported data corruption on storvsc, although as far as I can
tell storvsc always failed to properly set the max_segment_size limit as
the SCSI APIs historically applied that when setting up the host, while
storvsc only set the virt_boundary_mask when configuring the scsi_device.

Fixes: 81988a0e6b03 ("storvsc: get rid of bounce buffer")
Fixes: b561ea56a264 ("block: allow device to have both virt_boundary_mask and max segment size")
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/hosts.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index e021f1106bea..6ca7be197dfe 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -473,10 +473,19 @@ struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int priv
 	else
 		shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS;
 
-	if (sht->max_segment_size)
-		shost->max_segment_size = sht->max_segment_size;
-	else
-		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
+	if (sht->virt_boundary_mask)
+		shost->virt_boundary_mask = sht->virt_boundary_mask;
+
+	if (shost->virt_boundary_mask) {
+		WARN_ON_ONCE(sht->max_segment_size &&
+			     sht->max_segment_size != UINT_MAX);
+		shost->max_segment_size = UINT_MAX;
+	} else {
+		if (sht->max_segment_size)
+			shost->max_segment_size = sht->max_segment_size;
+		else
+			shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
+	}
 
 	/* 32-byte (dword) is a common minimum for HBAs. */
 	if (sht->dma_alignment)
@@ -492,9 +501,6 @@ struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int priv
 	else
 		shost->dma_boundary = 0xffffffff;
 
-	if (sht->virt_boundary_mask)
-		shost->virt_boundary_mask = sht->virt_boundary_mask;
-
 	device_initialize(&shost->shost_gendev);
 	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
 	shost->shost_gendev.bus = &scsi_bus_type;
-- 
2.47.2


