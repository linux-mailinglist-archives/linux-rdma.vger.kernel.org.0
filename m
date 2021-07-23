Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B93D3BA2
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 16:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhGWN2n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 09:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhGWN2j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 09:28:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D84760EB4;
        Fri, 23 Jul 2021 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627049353;
        bh=ZjLvOmzqi0R/gZHt4+asaVHLpatmXCpAJZ1abJMhj5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNwofrMRy9sRxJJ+wdOawJD16RdjaH7ALKUEycWnuEuCdtVA+HzA3WBriqxJL3SK2
         93tHc0Dd7t6KNslj1W69Lpbxw4tpVaLzqrbjIdbgqNO/Hca+UxeODqwOv1ml025QB4
         yg9be7IH4jhumkMIkHkowcazI9LHNwmw7JjQUQGsWjzEm9opzaG2Np+tIsjBgeTq/9
         zDM2eqw2uKNugXAGrr7l+0b3MQ+aBLQvdCba2IabYBNChyfkydufTBCgoUu+/dSKJ9
         g/v4fkE25mhte44U4o7OcQVuEuVIbUnhcvtyzWA2ua2Pxf3tf+SGUWwGqhe2CxriTH
         Su9BKRts+WnbQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        "Tatyana E. Nikolova" <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-next 1/3] RDMA/iwcm: Release resources if iw_cm module initialization fails
Date:   Fri, 23 Jul 2021 17:08:55 +0300
Message-Id: <b01239f99cb1a3e6d2b0694c242d89e6410bcd93.1627048781.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627048781.git.leonro@nvidia.com>
References: <cover.1627048781.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The failure during iw_cm module initialization partially left the system
with unreleased memory and other resources. Rewrite the module init/exit
routines in such way that netlink commands will be opened only after
successful initialization.

Fixes: b493d91d333e ("iwcm: common code for port mapper")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/iwcm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 42261152b489..2b47073c61a6 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1186,29 +1186,34 @@ static int __init iw_cm_init(void)
 
 	ret = iwpm_init(RDMA_NL_IWCM);
 	if (ret)
-		pr_err("iw_cm: couldn't init iwpm\n");
-	else
-		rdma_nl_register(RDMA_NL_IWCM, iwcm_nl_cb_table);
+		return ret;
+
 	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", 0);
 	if (!iwcm_wq)
-		return -ENOMEM;
+		goto err_alloc;
 
 	iwcm_ctl_table_hdr = register_net_sysctl(&init_net, "net/iw_cm",
 						 iwcm_ctl_table);
 	if (!iwcm_ctl_table_hdr) {
 		pr_err("iw_cm: couldn't register sysctl paths\n");
-		destroy_workqueue(iwcm_wq);
-		return -ENOMEM;
+		goto err_sysctl;
 	}
 
+	rdma_nl_register(RDMA_NL_IWCM, iwcm_nl_cb_table);
 	return 0;
+
+err_sysctl:
+	destroy_workqueue(iwcm_wq);
+err_alloc:
+	iwpm_exit(RDMA_NL_IWCM);
+	return -ENOMEM;
 }
 
 static void __exit iw_cm_cleanup(void)
 {
+	rdma_nl_unregister(RDMA_NL_IWCM);
 	unregister_net_sysctl_table(iwcm_ctl_table_hdr);
 	destroy_workqueue(iwcm_wq);
-	rdma_nl_unregister(RDMA_NL_IWCM);
 	iwpm_exit(RDMA_NL_IWCM);
 }
 
-- 
2.31.1

