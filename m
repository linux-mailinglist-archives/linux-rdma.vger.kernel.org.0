Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822EE488A20
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jan 2022 16:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiAIPO4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jan 2022 10:14:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:53051 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbiAIPO4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 Jan 2022 10:14:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="240645997"
X-IronPort-AV: E=Sophos;i="5.88,274,1635231600"; 
   d="scan'208";a="240645997"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 07:14:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,274,1635231600"; 
   d="scan'208";a="527976542"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2022 07:14:53 -0800
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/irdma: Remove the redundant return
Date:   Mon, 10 Jan 2022 02:37:33 -0500
Message-Id: <20220110073733.3221379-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The type of the function i40iw_remove is void. So remove
the unnecessary return.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/i40iw_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index d219f64b2c3d..43e962b97d6a 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -198,7 +198,7 @@ static void i40iw_remove(struct auxiliary_device *aux_dev)
 							       aux_dev);
 	struct i40e_info *cdev_info = i40e_adev->ldev;
 
-	return i40e_client_device_unregister(cdev_info);
+	i40e_client_device_unregister(cdev_info);
 }
 
 static const struct auxiliary_device_id i40iw_auxiliary_id_table[] = {
-- 
2.27.0

