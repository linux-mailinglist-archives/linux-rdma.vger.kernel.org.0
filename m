Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2962341D86
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 13:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSM5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 08:57:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:4853 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhCSM4q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 08:56:46 -0400
IronPort-SDR: 9xqoJYeNjOSNDOIoFOXFC2UxXuea+XvQCXWAxbcgEbCahD0sO088kBA6vHoQbBooX4rfMapW7S
 g2dgwgQ5ZgVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="209910293"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="209910293"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 05:56:46 -0700
IronPort-SDR: 3A1/7FDTIMOpZf9AuUax5FzaRQ16o9IF1AWBbib3mi2XJbNN5D1wEKlfEgaReVhAXf7M9sEULX
 APYi+fIi41jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="450851760"
Received: from phwfstl014.hd.intel.com ([10.127.241.142])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2021 05:56:45 -0700
From:   kaike.wan@intel.com
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, todd.rimmer@intel.com,
        Kaike Wan <kaike.wan@intel.com>
Subject: [PATCH RFC 9/9] RDMA/rv: Integrate the file operations into the rv module
Date:   Fri, 19 Mar 2021 08:56:35 -0400
Message-Id: <20210319125635.34492-10-kaike.wan@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210319125635.34492-1-kaike.wan@intel.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

Integrate the file operations into the module_init and module_exit
functions so that user applications can access the rv module.

Signed-off-by: Todd Rimmer <todd.rimmer@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
---
 drivers/infiniband/ulp/rv/rv_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/ulp/rv/rv_main.c b/drivers/infiniband/ulp/rv/rv_main.c
index c40ee36c6f9e..04c5a8606598 100644
--- a/drivers/infiniband/ulp/rv/rv_main.c
+++ b/drivers/infiniband/ulp/rv/rv_main.c
@@ -253,11 +253,16 @@ static int __init rv_init_module(void)
 		return -EINVAL;
 	}
 
+	if (rv_file_init()) {
+		ib_unregister_client(&rv_client);
+		return -EINVAL;
+	}
 	return 0;
 }
 
 static void __exit rv_cleanup_module(void)
 {
+	rv_file_uninit();
 	ib_unregister_client(&rv_client);
 	rv_deinit_devices();
 }
-- 
2.18.1

