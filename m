Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC65F3B0AF1
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhFVQ7R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 12:59:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:56792 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhFVQ7K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 12:59:10 -0400
IronPort-SDR: E06Ry6tRZgL2/Sj9XFDR6aXCh3/hVkbCjjC1Mw12LS92LAzhdy9JabVFnCxF5usygUy3QUhiHE
 hBxodT1/BqJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194408104"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="194408104"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 09:56:24 -0700
IronPort-SDR: s2BwDnZyMjQskcsJj5BGgqhuiSA0OZzV+M6OKn1PVBuZtrFq0X+aPPC0IH4sO3L/H1steauqDk
 L8yjeJsankAw==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="452685198"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 09:56:23 -0700
From:   ira.weiny@intel.com
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] RDMA/irdma: Remove use of kmap()
Date:   Tue, 22 Jun 2021 09:56:22 -0700
Message-Id: <20210622165622.2638628-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210622061422.2633501-3-ira.weiny@intel.com>
References: <20210622061422.2633501-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() is being deprecated and will break uses of device dax after PKS
protection is introduced.[1]

The kmap() used in the irdma CM driver is thread local.  Therefore
kmap_local_page() is sufficient to use and may provide performance benefits
as well.  kmap_local_page() will work with device dax and pgmap
protected pages.

Use kmap_local_page() instead of kmap().

[1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V2:
	Move to the new irdma driver for 5.14
---
 drivers/infiniband/hw/irdma/cm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 3d2bdb033a54..6b62299abfbb 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3675,14 +3675,14 @@ int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	ibmr->device = iwpd->ibpd.device;
 	iwqp->lsmm_mr = ibmr;
 	if (iwqp->page)
-		iwqp->sc_qp.qp_uk.sq_base = kmap(iwqp->page);
+		iwqp->sc_qp.qp_uk.sq_base = kmap_local_page(iwqp->page);
 
 	cm_node->lsmm_size = accept.size + conn_param->private_data_len;
 	irdma_sc_send_lsmm(&iwqp->sc_qp, iwqp->ietf_mem.va, cm_node->lsmm_size,
 			   ibmr->lkey);
 
 	if (iwqp->page)
-		kunmap(iwqp->page);
+		kunmap_local(iwqp->sc_qp.qp_uk.sq_base);
 
 	iwqp->cm_id = cm_id;
 	cm_node->cm_id = cm_id;
@@ -4093,10 +4093,10 @@ static void irdma_cm_event_connected(struct irdma_cm_event *event)
 	irdma_cm_init_tsa_conn(iwqp, cm_node);
 	read0 = (cm_node->send_rdma0_op == SEND_RDMA_READ_ZERO);
 	if (iwqp->page)
-		iwqp->sc_qp.qp_uk.sq_base = kmap(iwqp->page);
+		iwqp->sc_qp.qp_uk.sq_base = kmap_local_page(iwqp->page);
 	irdma_sc_send_rtt(&iwqp->sc_qp, read0);
 	if (iwqp->page)
-		kunmap(iwqp->page);
+		kunmap_local(iwqp->sc_qp.qp_uk.sq_base);
 
 	attr.qp_state = IB_QPS_RTS;
 	cm_node->qhash_set = false;
-- 
2.28.0.rc0.12.gb6a658bd00c9

