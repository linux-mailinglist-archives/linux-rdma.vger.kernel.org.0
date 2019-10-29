Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF8E803F
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfJ2G17 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbfJ2G17 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:27:59 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA412086A;
        Tue, 29 Oct 2019 06:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330479;
        bh=yNdqKwkPUg1nfJduhuUGNRF3C81UVlmbtCghjnjrVBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQgVDXotZruCKRt/hvHhT7cXfiO7Nxl3eprMTyC0zsHWVSUiwZ2Ih1/011gEcClg0
         saNvmiCuUYOXKkPxyLaK+hjy628H1zgo/4VCZ4cTa3FDG3NJJhL/vNoGPWpL4o+yC8
         6VwnD4RJdr8KWARAAeqBRDwQjVPQgGHI2a5UOV2U=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 03/16] RDMA/mlx4: Delete redundant zero memset
Date:   Tue, 29 Oct 2019 08:27:32 +0200
Message-Id: <20191029062745.7932-4-leon@kernel.org>
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

All callers to process_mad() allocate MAD output buffer
with kzalloc, so there is no need to clear memory again.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/mad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 57079110af9b..985cced5d509 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -966,7 +966,6 @@ static int iboe_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 	}
 	mutex_unlock(&dev->counters_table[port_num - 1].mutex);
 	if (stats_avail) {
-		memset(out_mad->data, 0, sizeof out_mad->data);
 		switch (counter_stats.counter_mode & 0xf) {
 		case 0:
 			edit_counter(&counter_stats,
-- 
2.20.1

