Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25709354E70
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhDFIWf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:22:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15488 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbhDFIWb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 04:22:31 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF0nn1tlHzwRN2;
        Tue,  6 Apr 2021 16:20:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 16:22:16 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/6] RDMA/core: Remove the redundant return statements
Date:   Tue, 6 Apr 2021 16:19:40 +0800
Message-ID: <1617697184-48683-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
References: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The return statements at the end of a void function is meaningless.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/mad.c   | 2 --
 drivers/infiniband/core/sysfs.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index ce0397f..16ecb81 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -1860,8 +1860,6 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 						   mad_recv_wc);
 		deref_mad_agent(mad_agent_priv);
 	}
-
-	return;
 }
 
 static enum smi_action handle_ib_smi(const struct ib_mad_port_private *port_priv,
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 91a53b2..dcff5e7 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1049,7 +1049,6 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 	kfree(hsag);
 err_free_stats:
 	kfree(stats);
-	return;
 }
 
 static int add_port(struct ib_core_device *coredev, int port_num)
-- 
2.8.1

