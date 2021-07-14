Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4F3C6EE5
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhGMKvs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 06:51:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:16175 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235552AbhGMKvr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Jul 2021 06:51:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="189823691"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="189823691"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 03:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="459532977"
Received: from unknown (HELO intel-86.bj.intel.com) ([10.238.154.86])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2021 03:48:55 -0700
From:   yanjun.zhu@linux.dev
To:     zyjzyj2000@gmail.com, yanjun.zhu@intel.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCH 3/3] RDMA/irdma: change returned type of irdma_setup_virt_qp to void
Date:   Tue, 13 Jul 2021 23:11:30 -0400
Message-Id: <20210714031130.1511109-4-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210714031130.1511109-1-yanjun.zhu@linux.dev>
References: <20210714031130.1511109-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Since the returned value of the function irdma_setup_virt_qp is always 0,
remove the returned value check and change the returned type to void.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 9712f6902ba8..717147ed0519 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -557,7 +557,7 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
  * @iwqp: qp ptr
  * @init_info: initialize info to return
  */
-static int irdma_setup_virt_qp(struct irdma_device *iwdev,
+static void irdma_setup_virt_qp(struct irdma_device *iwdev,
 			       struct irdma_qp *iwqp,
 			       struct irdma_qp_init_info *init_info)
 {
@@ -574,8 +574,6 @@ static int irdma_setup_virt_qp(struct irdma_device *iwdev,
 		init_info->sq_pa = qpmr->sq_pbl.addr;
 		init_info->rq_pa = qpmr->rq_pbl.addr;
 	}
-
-	return 0;
 }
 
 /**
@@ -914,7 +912,7 @@ static struct ib_qp *irdma_create_qp(struct ib_pd *ibpd,
 			}
 		}
 		init_info.qp_uk_init_info.abi_ver = iwpd->sc_pd.abi_ver;
-		err_code = irdma_setup_virt_qp(iwdev, iwqp, &init_info);
+		irdma_setup_virt_qp(iwdev, iwqp, &init_info);
 	} else {
 		init_info.qp_uk_init_info.abi_ver = IRDMA_ABI_VER;
 		err_code = irdma_setup_kmode_qp(iwdev, iwqp, &init_info, init_attr);
-- 
2.27.0

