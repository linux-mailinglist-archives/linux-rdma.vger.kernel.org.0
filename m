Return-Path: <linux-rdma+bounces-11585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B2AE6593
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C483163988
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C4B29ACC4;
	Tue, 24 Jun 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iEC0RgYJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C15298CA3;
	Tue, 24 Jun 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769567; cv=none; b=BY84bP7JzCbjpez1ZnRKVpV3wJ/hC34Q88MBzIqxrJQgyV67xznX2lo4EaBaq2C7euXfU/LfKW7CfoeUMDMpGaE4pGvqz1AcXdy+J3MZKpMLTwe/YII/YMU5iu5hVfCAJ1Uqk2nJvHfGsJbzADI9udhRNSQZAhQ6c7gQ9nWNZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769567; c=relaxed/simple;
	bh=0miedgvjiUpkxowR5HNDs0A/aoQ9IvAC+c9NLutFNhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qd2bRPEmmlX13VhEs8kVuImw1NXnq+nC246PACuIdtVpGDLXyN9ASw7Z/tXIoyPTtOLb2a0cuwVlP7fdB3hPXEfFCgJXdu69ORDugjTAi1mnqk9rIQMWIQO9DrQQhnPv8eXzNhHOiOA2N2jmBhgn0aM6hj9RLqaR3HGVAuVvPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iEC0RgYJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=x8dRNZ5aNIiOxu05kd9PpADF1fUn1J7SNju2ALPieSk=; b=iEC0RgYJ7cUOwtSd8LL8jpsoxy
	Fs04WKFMNvdV1BgrB4Lf9sMd/+A7pBZktnNCPNOWlP1vyGzFVNPI+dcAjaSFYB7/yL+V5JwVxWqso
	wtjO9QM0atpN5yiVP4qOvY91oWBKayLYth+oaPy93PT9HbVNLFlBbR0Jg2e5s+t0OnZRbHcHL1B8b
	AuC9vWL1j+D3B+OgaUP63rcfjTSfrbnht9GkUcO9oRGPxR+MtWEOGn28fsSljg8IagBY/XQOiGMT8
	ALDyGG3F3FZ16qbcteaU1lU4W77rlE00WI2LTA/IQDfVmJ4nTXjprVoclD7IrNoNRz5CjcjAFY5bD
	fa8ct8iA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU38k-00000005duw-0VY4;
	Tue, 24 Jun 2025 12:52:42 +0000
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
	linux-block@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] scsi: enforce unlimited max_segment_size when virt_boundary_mask is set
Date: Tue, 24 Jun 2025 14:52:28 +0200
Message-ID: <20250624125233.219635-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250624125233.219635-1-hch@lst.de>
References: <20250624125233.219635-1-hch@lst.de>
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
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/hosts.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index e021f1106bea..cc5d05dc395c 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -473,10 +473,17 @@ struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int priv
 	else
 		shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS;
 
-	if (sht->max_segment_size)
-		shost->max_segment_size = sht->max_segment_size;
-	else
-		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
+	shost->virt_boundary_mask = sht->virt_boundary_mask;
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
@@ -492,9 +499,6 @@ struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int priv
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


