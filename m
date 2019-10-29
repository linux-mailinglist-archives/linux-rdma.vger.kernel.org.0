Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34172E8047
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbfJ2G2N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732249AbfJ2G2N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:13 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A40920862;
        Tue, 29 Oct 2019 06:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330492;
        bh=QiVeTlKAIpjT8Y6NaGKZXudMXq7ScjW6RpgOl7QRgZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgazuVhe9iZGdkEi5zmUDrCgs8uHMs5h4QTepQbAR067HkP1qYmr3XKJ1aHirJ2Lg
         z0UnX/5sbmA+6KUGixZPg6v+BoQfK0GtL0RGomSeyl9cZ/rRTQ6siJ7fik3IL+dUyT
         kY2xTraBlfKczCy66TS0zPBT3BrW88afbGIVYlD8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 07/16] RDMA/hfi1: Delete unreachable code
Date:   Tue, 29 Oct 2019 08:27:36 +0200
Message-Id: <20191029062745.7932-8-leon@kernel.org>
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

All callers allocate MAD structures with proper sizes,
there is no need to recheck it.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/hfi1/mad.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index d8ff063a5419..a54746f4a0ae 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -4921,10 +4921,6 @@ int hfi1_process_mad(struct ib_device *ibdev, int mad_flags, u8 port,
 {
 	switch (in_mad->base_version) {
 	case OPA_MGMT_BASE_VERSION:
-		if (unlikely(in_mad_size != sizeof(struct opa_mad))) {
-			dev_err(ibdev->dev.parent, "invalid in_mad_size\n");
-			return IB_MAD_RESULT_FAILURE;
-		}
 		return hfi1_process_opa_mad(ibdev, mad_flags, port,
 					    in_wc, in_grh,
 					    (struct opa_mad *)in_mad,
-- 
2.20.1

