Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0CC567A8E
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiGEXJL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiGEXJG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:09:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBF9BCAD
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062545; x=1688598545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y8Q2eZu7IzUHYV1AciK1kxtE+YV77cUX1yFcT0F64ug=;
  b=F/EifyRsqCtkflZGWSFzKUHvqPuHoOkbsPUAzxCOUTtxOh/6IvmIdnUQ
   qZVFxzJHwE+iPcLiH6HO/kg9mQ9aDc981IuUkujz7KGpUQ3pXQt5wWlSf
   4GxQC2JoRfBhUHk8b6x3E4TlBsyC7t8pSPOW7EUGgFpLOouDuvbNjr58k
   xOzheUsqFWgbtwMFSC9QY+atNtIo8/yJ6SZxL1aV4lI2DEHHngJ22Tj4S
   rlh/ORyAAptBoCWJI9VYf/zgNmsILruytvAKlsFEiT0jehHBGIJasN+Ed
   qbCZ9OtFVebRZRme+Ay1j8t+QT2cwApxHy1aaXDxdSLMpabwyGC2WcKqg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284677277"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="284677277"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047762"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:52 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc] RDMA/irdma: Fix sleep from invalid context BUG
Date:   Tue,  5 Jul 2022 18:08:37 -0500
Message-Id: <20220705230837.294-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220705230837.294-1-shiraz.saleem@intel.com>
References: <20220705230837.294-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Taking the qos_mutex to process RoCEv2 QP's on netdev events causes a
kernel splat.

Fix this by removing the handling for RoCEv2 in
irdma_cm_teardown_connections that uses the mutex. This handling is only
needed for iWARP to avoid having connections established while the link
is down or having connections remain functional after the IP address is
removed.

BUG: sleeping function called from invalid context at kernel/locking/mutex.
Call Trace:
kernel: dump_stack+0x66/0x90
kernel: ___might_sleep.cold.92+0x8d/0x9a
kernel: mutex_lock+0x1c/0x40
kernel: irdma_cm_teardown_connections+0x28e/0x4d0 [irdma]
kernel: ? check_preempt_curr+0x7a/0x90
kernel: ? select_idle_sibling+0x22/0x3c0
kernel: ? select_task_rq_fair+0x94c/0xc90
kernel: ? irdma_exec_cqp_cmd+0xc27/0x17c0 [irdma]
kernel: ? __wake_up_common+0x7a/0x190
kernel: irdma_if_notify+0x3cc/0x450 [irdma]
kernel: ? sched_clock_cpu+0xc/0xb0
kernel: irdma_inet6addr_event+0xc6/0x150 [irdma]

Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c | 50 ----------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 638bf4a..646fa86 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -4231,10 +4231,6 @@ void irdma_cm_teardown_connections(struct irdma_device *iwdev, u32 *ipaddr,
 	struct irdma_cm_node *cm_node;
 	struct list_head teardown_list;
 	struct ib_qp_attr attr;
-	struct irdma_sc_vsi *vsi = &iwdev->vsi;
-	struct irdma_sc_qp *sc_qp;
-	struct irdma_qp *qp;
-	int i;
 
 	INIT_LIST_HEAD(&teardown_list);
 
@@ -4251,52 +4247,6 @@ void irdma_cm_teardown_connections(struct irdma_device *iwdev, u32 *ipaddr,
 			irdma_cm_disconn(cm_node->iwqp);
 		irdma_rem_ref_cm_node(cm_node);
 	}
-	if (!iwdev->roce_mode)
-		return;
-
-	INIT_LIST_HEAD(&teardown_list);
-	for (i = 0; i < IRDMA_MAX_USER_PRIORITY; i++) {
-		mutex_lock(&vsi->qos[i].qos_mutex);
-		list_for_each_safe (list_node, list_core_temp,
-				    &vsi->qos[i].qplist) {
-			u32 qp_ip[4];
-
-			sc_qp = container_of(list_node, struct irdma_sc_qp,
-					     list);
-			if (sc_qp->qp_uk.qp_type != IRDMA_QP_TYPE_ROCE_RC)
-				continue;
-
-			qp = sc_qp->qp_uk.back_qp;
-			if (!disconnect_all) {
-				if (nfo->ipv4)
-					qp_ip[0] = qp->udp_info.local_ipaddr[3];
-				else
-					memcpy(qp_ip,
-					       &qp->udp_info.local_ipaddr[0],
-					       sizeof(qp_ip));
-			}
-
-			if (disconnect_all ||
-			    (nfo->vlan_id == (qp->udp_info.vlan_tag & VLAN_VID_MASK) &&
-			     !memcmp(qp_ip, ipaddr, nfo->ipv4 ? 4 : 16))) {
-				spin_lock(&iwdev->rf->qptable_lock);
-				if (iwdev->rf->qp_table[sc_qp->qp_uk.qp_id]) {
-					irdma_qp_add_ref(&qp->ibqp);
-					list_add(&qp->teardown_entry,
-						 &teardown_list);
-				}
-				spin_unlock(&iwdev->rf->qptable_lock);
-			}
-		}
-		mutex_unlock(&vsi->qos[i].qos_mutex);
-	}
-
-	list_for_each_safe (list_node, list_core_temp, &teardown_list) {
-		qp = container_of(list_node, struct irdma_qp, teardown_entry);
-		attr.qp_state = IB_QPS_ERR;
-		irdma_modify_qp_roce(&qp->ibqp, &attr, IB_QP_STATE, NULL);
-		irdma_qp_rem_ref(&qp->ibqp);
-	}
 }
 
 /**
-- 
1.8.3.1

