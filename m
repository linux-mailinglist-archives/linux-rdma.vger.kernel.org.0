Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FEA5740F4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 03:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiGNBaw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jul 2022 21:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiGNBav (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jul 2022 21:30:51 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E40114D30
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jul 2022 18:30:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJGv736_1657762247;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VJGv736_1657762247)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 09:30:48 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org, BMT@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com
Subject: [PATCH for-next] RDMA/siw: Fix duplicated reported IW_CM_EVENT_CONNECT_REPLY event
Date:   Thu, 14 Jul 2022 09:30:47 +0800
Message-Id: <dae34b5fd5c2ea2bd9744812c1d2653a34a94c67.1657706960.git.chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If siw_recv_mpa_rr returns -EAGAIN, it means that the MPA reply hasn't
been received completely, and should not report IW_CM_EVENT_CONNECT_REPLY
in this case. This may trigger a call trace in iw_cm. A simple way to
trigger this:
 server: ib_send_lat
 client: ib_send_lat -R <server_ip>

The call trace looks like this:

 kernel BUG at drivers/infiniband/core/iwcm.c:894!
 invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
 <...>
 Workqueue: iw_cm_wq cm_work_handler [iw_cm]
 Call Trace:
  <TASK>
  cm_work_handler+0x1dd/0x370 [iw_cm]
  process_one_work+0x1e2/0x3b0
  worker_thread+0x49/0x2e0
  ? rescuer_thread+0x370/0x370
  kthread+0xe5/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 17f34d584cd9..f88d2971c2c6 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -725,11 +725,11 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 	enum mpa_v2_ctrl mpa_p2p_mode = MPA_V2_RDMA_NO_RTR;
 
 	rv = siw_recv_mpa_rr(cep);
-	if (rv != -EAGAIN)
-		siw_cancel_mpatimer(cep);
 	if (rv)
 		goto out_err;
 
+	siw_cancel_mpatimer(cep);
+
 	rep = &cep->mpa.hdr;
 
 	if (__mpa_rr_revision(rep->params.bits) > MPA_REVISION_2) {
@@ -895,7 +895,8 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 	}
 
 out_err:
-	siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, -EINVAL);
+	if (rv != -EAGAIN)
+		siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, -EINVAL);
 
 	return rv;
 }
-- 
2.37.0

