Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9867F3642A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfFETJn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:09:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFETJm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EgU5lGgALUASevuDqm6D+3fpiqvPjFDOViczDZXWl1A=; b=iP43xkcuQju+K/iAv4LV7OsM5c
        zGaqdnFk4lE0l2DNYnd3Gw99DBrcivQgCGaBxRk3mFqk+mSe9guYc3DA6lvc3xuEKCeEYDpX9uL2y
        cDTHiUeL18KagEuzHu2dQNbKpgdnj1GtrCkCy61hJ5Oqus5hCQkFISo7CZLi2nFhy+0uSc5oUlYuL
        lpMVEq35Z3kkSw4luioz18tbqjCQkw/JJ3/qXhwoC315K/YhbOXovm9T0ogudlWAHcbu5WlyUdEG/
        vdx8IBUq9q7A54kDix0/Ic+5PKKl8hCdqbDsvGgZLPeVAF7RfMVVmAOfQ8BcX3nABXpNTiUn3086/
        6RMNGzeA==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHO-0005XN-7d; Wed, 05 Jun 2019 19:08:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] scsi: add a host / host template field for the virt boundary
Date:   Wed,  5 Jun 2019 21:08:28 +0200
Message-Id: <20190605190836.32354-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605190836.32354-1-hch@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This allows drivers setting it up easily instead of branching out to
block layer calls in slave_alloc, and ensures the upgraded
max_segment_size setting gets picked up by the DMA layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/hosts.c     | 3 +++
 drivers/scsi/scsi_lib.c  | 3 ++-
 include/scsi/scsi_host.h | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index ff0d8c6a8d0c..55522b7162d3 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -462,6 +462,9 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	else
 		shost->dma_boundary = 0xffffffff;
 
+	if (sht->virt_boundary_mask)
+		shost->virt_boundary_mask = sht->virt_boundary_mask;
+
 	device_initialize(&shost->shost_gendev);
 	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
 	shost->shost_gendev.bus = &scsi_bus_type;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 65d0a10c76ad..d333bb6b1c59 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1775,7 +1775,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 	dma_set_seg_boundary(dev, shost->dma_boundary);
 
 	blk_queue_max_segment_size(q, shost->max_segment_size);
-	dma_set_max_seg_size(dev, shost->max_segment_size);
+	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
+	dma_set_max_seg_size(dev, queue_max_segment_size(q));
 
 	/*
 	 * Set a reasonable default alignment:  The larger of 32-byte (dword),
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index a5fcdad4a03e..cc139dbd71e5 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -369,6 +369,8 @@ struct scsi_host_template {
 	 */
 	unsigned long dma_boundary;
 
+	unsigned long virt_boundary_mask;
+
 	/*
 	 * This specifies "machine infinity" for host templates which don't
 	 * limit the transfer size.  Note this limit represents an absolute
@@ -587,6 +589,7 @@ struct Scsi_Host {
 	unsigned int max_sectors;
 	unsigned int max_segment_size;
 	unsigned long dma_boundary;
+	unsigned long virt_boundary_mask;
 	/*
 	 * In scsi-mq mode, the number of hardware queues supported by the LLD.
 	 *
-- 
2.20.1

