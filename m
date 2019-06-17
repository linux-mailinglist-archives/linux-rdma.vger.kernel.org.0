Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6458C484C8
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2019 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFQOBm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 10:01:42 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:51984 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOBm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jun 2019 10:01:42 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id Rq1f2000J3XaVaC01q1fHF; Mon, 17 Jun 2019 16:01:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsCZ-0002Ai-CR; Mon, 17 Jun 2019 16:01:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsCZ-0000Ca-9x; Mon, 17 Jun 2019 16:01:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] IB/hfi1: Spelling s/statisfied/satisfied/
Date:   Mon, 17 Jun 2019 16:01:38 +0200
Message-Id: <20190617140138.734-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 6fb93032fbefcb7e..24f30ff6b5fbc868 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -477,7 +477,7 @@ static struct rvt_qp *first_qp(struct hfi1_ctxtdata *rcd,
  * Must hold the qp s_lock and the exp_lock.
  *
  * Return:
- * false if either of the conditions below are statisfied:
+ * false if either of the conditions below are satisfied:
  * 1. The list is empty or
  * 2. The indicated qp is at the head of the list and the
  *    HFI1_S_WAIT_TID_SPACE bit is set in qp->s_flags.
-- 
2.17.1

