Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EC329B69
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389950AbfEXPoz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 11:44:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:6774 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389663AbfEXPoy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 11:44:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 08:44:54 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga007.jf.intel.com with ESMTP; 24 May 2019 08:44:54 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x4OFirML006145;
        Fri, 24 May 2019 08:44:53 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x4OFippE010687;
        Fri, 24 May 2019 11:44:52 -0400
Subject: [PATCH for-rc 3/5] IB/{qib, hfi1,
 rdmavt}: Correct ibv_devinfo max_mr value
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Josh Collier <josh.d.collier@intel.com>
Date:   Fri, 24 May 2019 11:44:51 -0400
Message-ID: <20190524154451.10588.66940.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190524154320.10588.44693.stgit@awfm-01.aw.intel.com>
References: <20190524154320.10588.44693.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

ibv_devinfo -v reports 0 for max_mr.

Fix by assigning the query values after the mr lkey_table has been
built rather than early on in the driver.

Fixes: 7b1e2099adc8 ("IB/rdmavt: Move memory registration into rdmavt")
Reviewed-by: Josh Collier <josh.d.collier@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/verbs.c    |    2 --
 drivers/infiniband/hw/qib/qib_verbs.c |    2 --
 drivers/infiniband/sw/rdmavt/mr.c     |    2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 1eb4105..a2b26a6 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1356,8 +1356,6 @@ static void hfi1_fill_device_attr(struct hfi1_devdata *dd)
 	rdi->dparms.props.max_cq = hfi1_max_cqs;
 	rdi->dparms.props.max_ah = hfi1_max_ahs;
 	rdi->dparms.props.max_cqe = hfi1_max_cqes;
-	rdi->dparms.props.max_mr = rdi->lkey_table.max;
-	rdi->dparms.props.max_fmr = rdi->lkey_table.max;
 	rdi->dparms.props.max_map_per_fmr = 32767;
 	rdi->dparms.props.max_pd = hfi1_max_pds;
 	rdi->dparms.props.max_qp_rd_atom = HFI1_MAX_RDMA_ATOMIC;
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 5ff32d3..2c4e569c 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1459,8 +1459,6 @@ static void qib_fill_device_attr(struct qib_devdata *dd)
 	rdi->dparms.props.max_cq = ib_qib_max_cqs;
 	rdi->dparms.props.max_cqe = ib_qib_max_cqes;
 	rdi->dparms.props.max_ah = ib_qib_max_ahs;
-	rdi->dparms.props.max_mr = rdi->lkey_table.max;
-	rdi->dparms.props.max_fmr = rdi->lkey_table.max;
 	rdi->dparms.props.max_map_per_fmr = 32767;
 	rdi->dparms.props.max_qp_rd_atom = QIB_MAX_RDMA_ATOMIC;
 	rdi->dparms.props.max_qp_init_rd_atom = 255;
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 54f3f9c..f48240f 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -96,6 +96,8 @@ int rvt_driver_mr_init(struct rvt_dev_info *rdi)
 	for (i = 0; i < rdi->lkey_table.max; i++)
 		RCU_INIT_POINTER(rdi->lkey_table.table[i], NULL);
 
+	rdi->dparms.props.max_mr = rdi->lkey_table.max;
+	rdi->dparms.props.max_fmr = rdi->lkey_table.max;
 	return 0;
 }
 

