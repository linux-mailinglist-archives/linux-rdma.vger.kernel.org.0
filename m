Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9E18470A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 13:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCMMkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 08:40:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:59702 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMMkC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 08:40:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 05:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="290015208"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2020 05:40:01 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02DCdxXQ044718;
        Fri, 13 Mar 2020 05:40:00 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02DCdvgx014365;
        Fri, 13 Mar 2020 08:39:57 -0400
Subject: [PATCH for-rc] IB/rdmavt: Free kernel completion queue when done
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 13 Mar 2020 08:39:57 -0400
Message-ID: <20200313123957.14343.43879.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

When a kernel ULP requests the rdmavt to create a completion queue, it
allocated the queue and set cq->kqueue to point to it. However, when
the completion queue is destroyed, cq->queue is freed instead, leading
to memory leak:

https://marc.info/?l=linux-rdma&m=158344182614924&w=2

unreferenced object 0xffffc90006639000 (size 12288):
comm "kworker/u128:0", pid 8, jiffies 4295777598 (age 589.085s)
    hex dump (first 32 bytes):
      4d 00 00 00 4d 00 00 00 00 c0 08 ac 8b 88 ff ff  M...M...........
      00 00 00 00 80 00 00 00 00 00 00 00 10 00 00 00  ................
    backtrace:
      [<0000000035a3d625>] __vmalloc_node_range+0x361/0x720
      [<000000002942ce4f>] __vmalloc_node.constprop.30+0x63/0xb0
      [<00000000f228f784>] rvt_create_cq+0x98a/0xd80 [rdmavt]
      [<00000000b84aec66>] __ib_alloc_cq_user+0x281/0x1260 [ib_core]
      [<00000000ef3764be>] nvme_rdma_cm_handler+0xdb7/0x1b80 [nvme_rdma]
      [<00000000936b401c>] cma_cm_event_handler+0xb7/0x550 [rdma_cm]
      [<00000000d9c40b7b>] addr_handler+0x195/0x310 [rdma_cm]
      [<00000000c7398a03>] process_one_req+0xdd/0x600 [ib_core]
      [<000000004d29675b>] process_one_work+0x920/0x1740
      [<00000000efedcdb5>] worker_thread+0x87/0xb40
      [<000000005688b340>] kthread+0x327/0x3f0
      [<0000000043a168d6>] ret_from_fork+0x3a/0x50

This patch fixes the issue by freeing cq->kqueue instead.

Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
Cc: <stable@vger.kernel.org> # 5.4.x
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/sw/rdmavt/cq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 13d7f66..5724cbb 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -327,7 +327,7 @@ void rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	if (cq->ip)
 		kref_put(&cq->ip->ref, rvt_release_mmap_info);
 	else
-		vfree(cq->queue);
+		vfree(cq->kqueue);
 }
 
 /**

