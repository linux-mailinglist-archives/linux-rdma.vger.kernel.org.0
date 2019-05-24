Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE029B68
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 17:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbfEXPos (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 11:44:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:55977 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389620AbfEXPos (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 11:44:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 08:44:47 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2019 08:44:47 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x4OFillQ006139;
        Fri, 24 May 2019 08:44:47 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x4OFijhm010678;
        Fri, 24 May 2019 11:44:45 -0400
Subject: [PATCH for-rc 2/5] IB/hfi1: Insure freeze_work work_struct is
 canceled on shutdown
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 24 May 2019 11:44:45 -0400
Message-ID: <20190524154445.10588.51457.stgit@awfm-01.aw.intel.com>
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

By code inspection, the freeze_work is never canceled.

Fix by adding a cancel_work_sync in the shutdown path to insure
it is no longer running.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 310105d..4221a99e 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -9850,6 +9850,7 @@ void hfi1_quiet_serdes(struct hfi1_pportdata *ppd)
 
 	/* disable the port */
 	clear_rcvctrl(dd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+	cancel_work_sync(&ppd->freeze_work);
 }
 
 static inline int init_cpu_counters(struct hfi1_devdata *dd)

