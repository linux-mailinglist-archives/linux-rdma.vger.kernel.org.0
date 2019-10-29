Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103AEE8050
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbfJ2G22 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfJ2G21 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:27 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A3820862;
        Tue, 29 Oct 2019 06:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330507;
        bh=ptECk6m4CTNStAdHzWmnO1V5MI7w3Be/xjfOsKy0/GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3AanfsFtexWDmAAlCvIEXIfDVOY3IvlQ7TzK/43rmvJSjwEuX3cBqa27xJJ3AvRc
         UGtFQGS4CwqfGHHNWiGudpZ41nqisoWBgt3WwMPD9vnJbEuR0yI6OehdqY3vm+OLYk
         MB2YArUXljHTl/LjaTDx/s1GHFVUx2Z7eKOv5jqY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 11/16] RDMA/ocrdma: Simplify process_mad function
Date:   Tue, 29 Oct 2019 08:27:40 +0200
Message-Id: <20191029062745.7932-12-leon@kernel.org>
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

Rewrite ocrdma implementation of process_mad in order to simplify code.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
index f8ebdf7086a1..4098508b9240 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
@@ -256,24 +256,16 @@ int ocrdma_process_mad(struct ib_device *ibdev,
 		       struct ib_mad_hdr *out, size_t *out_mad_size,
 		       u16 *out_mad_pkey_index)
 {
-	int status;
+	int status = IB_MAD_RESULT_SUCCESS;
 	struct ocrdma_dev *dev;
 	const struct ib_mad *in_mad = (const struct ib_mad *)in;
 	struct ib_mad *out_mad = (struct ib_mad *)out;
 
-	if (WARN_ON_ONCE(in_mad_size != sizeof(*in_mad) ||
-			 *out_mad_size != sizeof(*out_mad)))
-		return IB_MAD_RESULT_FAILURE;
-
-	switch (in_mad->mad_hdr.mgmt_class) {
-	case IB_MGMT_CLASS_PERF_MGMT:
+	if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT) {
 		dev = get_ocrdma_dev(ibdev);
 		ocrdma_pma_counters(dev, out_mad);
-		status = IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
-		break;
-	default:
-		status = IB_MAD_RESULT_SUCCESS;
-		break;
+		status |= IB_MAD_RESULT_REPLY;
 	}
+
 	return status;
 }
-- 
2.20.1

