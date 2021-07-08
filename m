Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4E3C1B12
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jul 2021 23:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhGHViW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jul 2021 17:38:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:2861 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhGHViV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Jul 2021 17:38:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="196777237"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="196777237"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 14:35:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="450070379"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.213.168.178])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 14:35:34 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, mustafa.ismail@intel.com,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: [PATCH rdma-next] Check vsi pointer before using it
Date:   Thu,  8 Jul 2021 14:35:21 -0700
Message-Id: <20210708213521.438-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix a coverity warning about NULL pointer dereference:
>> Dereferencing "vsi", which is known to be "NULL".

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1505164 ("Null pointer dereferences")
Fixes: 8498a30e1b94 ("RDMA/irdma: Register auxiliary driver and implement private channel OPs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index ea59432351fb..51a41359e0b4 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -215,10 +215,10 @@ static void irdma_remove(struct auxiliary_device *aux_dev)
 	pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(pf->pdev->devfn));
 }
 
-static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf)
+static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf,
+				   struct ice_vsi *vsi)
 {
 	struct irdma_pci_f *rf = iwdev->rf;
-	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 
 	rf->cdev = pf;
 	rf->gen_ops.register_qset = irdma_lan_register_qset;
@@ -253,12 +253,15 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 							    struct iidc_auxiliary_dev,
 							    adev);
 	struct ice_pf *pf = iidc_adev->pf;
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	struct iidc_qos_params qos_info = {};
 	struct irdma_device *iwdev;
 	struct irdma_pci_f *rf;
 	struct irdma_l2params l2params = {};
 	int err;
 
+	if (!vsi)
+		return -EIO;
 	iwdev = ib_alloc_device(irdma_device, ibdev);
 	if (!iwdev)
 		return -ENOMEM;
@@ -268,7 +271,7 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 		return -ENOMEM;
 	}
 
-	irdma_fill_device_info(iwdev, pf);
+	irdma_fill_device_info(iwdev, pf, vsi);
 	rf = iwdev->rf;
 
 	if (irdma_ctrl_init_hw(rf)) {
-- 
2.27.0

