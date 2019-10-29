Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704F5E8043
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfJ2G2G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfJ2G2G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:06 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BF0720862;
        Tue, 29 Oct 2019 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330485;
        bh=xO5+0Io3LgGT2CEDARDmC/N4PUalpN34PWFaMb/IKpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJC/1WQQ8Vb5BrPuae8SGdRzuP5/Jh1nsp4dQEZnwECbumVgYwTLHbJyFKpt9Bfe0
         RXAcKGxd0U89vBa3iu6BGNLOhB2s7JPT4iKqzUwLlPB3jBrS3seY0ismfmmclj9q+3
         e0yGh+9DlYxPB46SVXljCDiGro/V/PqHQZE62qNY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 05/16] RDMA/ocrdma: Clean MAD processing logic
Date:   Tue, 29 Oct 2019 08:27:34 +0200
Message-Id: <20191029062745.7932-6-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029062745.7932-1-leon@kernel.org>
References: <20191029062745.7932-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Remove redundant memset and useless return value.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c    | 6 ++----
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 5 +----
 drivers/infiniband/hw/ocrdma/ocrdma_stats.h | 3 +--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
index 8d3e36d548aa..f8ebdf7086a1 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
@@ -268,10 +268,8 @@ int ocrdma_process_mad(struct ib_device *ibdev,
 	switch (in_mad->mad_hdr.mgmt_class) {
 	case IB_MGMT_CLASS_PERF_MGMT:
 		dev = get_ocrdma_dev(ibdev);
-		if (!ocrdma_pma_counters(dev, out_mad))
-			status = IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
-		else
-			status = IB_MAD_RESULT_SUCCESS;
+		ocrdma_pma_counters(dev, out_mad);
+		status = IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
 		break;
 	default:
 		status = IB_MAD_RESULT_SUCCESS;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
index a902942adb5d..95e8c1560cc2 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -670,12 +670,10 @@ static ssize_t ocrdma_dbgfs_ops_write(struct file *filp,
 	return -EFAULT;
 }
 
-int ocrdma_pma_counters(struct ocrdma_dev *dev,
-			struct ib_mad *out_mad)
+void ocrdma_pma_counters(struct ocrdma_dev *dev, struct ib_mad *out_mad)
 {
 	struct ib_pma_portcounters *pma_cnt;
 
-	memset(out_mad->data, 0, sizeof out_mad->data);
 	pma_cnt = (void *)(out_mad->data + 40);
 	ocrdma_update_stats(dev);
 
@@ -683,7 +681,6 @@ int ocrdma_pma_counters(struct ocrdma_dev *dev,
 	pma_cnt->port_rcv_data     = cpu_to_be32(ocrdma_sysfs_rcv_data(dev));
 	pma_cnt->port_xmit_packets = cpu_to_be32(ocrdma_sysfs_xmit_pkts(dev));
 	pma_cnt->port_rcv_packets  = cpu_to_be32(ocrdma_sysfs_rcv_pkts(dev));
-	return 0;
 }
 
 static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.h b/drivers/infiniband/hw/ocrdma/ocrdma_stats.h
index bba1fec4f11f..98feca26ac55 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.h
@@ -69,7 +69,6 @@ bool ocrdma_alloc_stats_resources(struct ocrdma_dev *dev);
 void ocrdma_release_stats_resources(struct ocrdma_dev *dev);
 void ocrdma_rem_port_stats(struct ocrdma_dev *dev);
 void ocrdma_add_port_stats(struct ocrdma_dev *dev);
-int ocrdma_pma_counters(struct ocrdma_dev *dev,
-			struct ib_mad *out_mad);
+void ocrdma_pma_counters(struct ocrdma_dev *dev, struct ib_mad *out_mad);
 
 #endif	/* __OCRDMA_STATS_H__ */
-- 
2.20.1

