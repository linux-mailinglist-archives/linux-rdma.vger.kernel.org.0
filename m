Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1622C3D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfETGn7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfETGn7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:43:59 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95566206B6;
        Mon, 20 May 2019 06:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558334639;
        bh=RtcbdDnEAlf/XaXNLoAfyL0k8Yehj38zL1UoqjxXQw0=;
        h=From:To:Cc:Subject:Date:From;
        b=cFRtIjY4js6gr2P1Pv4kYklA8y01O2hUcH0a4sTEugLa+5YwBLfm83i4//mIn1szr
         TfRQ70rpRfAb0U2vdFG/MgfYoQGXs/Cd07Q74qsAXo3e9xLTr1EaKw3zchiL9nMyll
         /eTTqYDxC1SoWfzVA5wAH30Rw0HWhNQVOhVFHMLc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA/hns: Fix PD memory leak for internal allocation
Date:   Mon, 20 May 2019 09:43:53 +0300
Message-Id: <20190520064353.8523-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

free_pd is allocated internally by hns driver hence needs to be
freed internally too.

Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 4c5d0f160c10..e068a02122f5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -899,6 +899,7 @@ static void hns_roce_v1_release_lp_qp(struct hns_roce_dev *hr_dev)
 		dev_err(dev, "Destroy cq for mr_free failed(%d)!\n", ret);
 
 	hns_roce_dealloc_pd(&free_mr->mr_free_pd->ibpd, NULL);
+	kfree(&free_mr->mr_free_pd->ibpd);
 }
 
 static int hns_roce_db_init(struct hns_roce_dev *hr_dev)
-- 
2.20.1

