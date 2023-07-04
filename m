Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236017466B2
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 02:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGDAxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 20:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDAxD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 20:53:03 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 17:53:00 PDT
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7200F136;
        Mon,  3 Jul 2023 17:53:00 -0700 (PDT)
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id ZXD00050;
        Tue, 04 Jul 2023 08:51:50 +0800
Received: from lihongweizz00.home.langchao.com (10.180.207.169) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.27; Tue, 4 Jul 2023 08:51:50 +0800
From:   lihongweizz <lihongweizz@inspur.com>
To:     <sagi@grimberg.me>, <mgurtovoy@nvidia.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rock Li <lihongweizz@inspur.com>
Subject: [PATCH] IB/iser: Protect tasks cleanup in case iser connection was stopped
Date:   Tue, 4 Jul 2023 08:51:44 +0800
Message-ID: <20230704005144.1172-1-lihongweizz@inspur.com>
X-Mailer: git-send-email 2.40.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.180.207.169]
tUid:   20237040851508f3372386f2df8ea6a16e04484201e48
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rock Li <lihongweizz@inspur.com>

We met a crash issue as below:
...
 #7 [ff61b991f6f63d10] page_fault at ffffffffab80111e
    [exception RIP: iscsi_iser_cleanup_task+13]
    RIP: ffffffffc046c04d RSP: ff61b991f6f63dc0 RFLAGS: 00010246
    RAX: 0000000000000000 RBX: ff4bd0aalf7a5610 RCX: ff61b991f6f63dc8
    RDX: ff61b991f6f63d68 RSI: ff61b991f6f63d58 RDI: ff4bd0aalf6cdc00
    RBP: 0000000000000005 R8: 0000000000000073 R9: 0000000000000005
    R10: 0000000000000000 R11: 00000ccde3e0f5c0 R12: ff4bd08c0e0631f8
    R13: ff4bd0a95ffd3c78 R14: ff4bd0a95ffd3c78 R15: ff4bd0aalf6cdc00
    ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
 #8 [ff616991f6f63dc0] __iscsi_put_task at ffffffffc0bd3652 [libiscsi]
 #9 [ff61b991f6f63e00] iscsi_put_task at ffffffffc0bd36e9 [libiscsi]
...

After analysing the vmcore, we find that the iser connection was already
stopped before abort handler running. The iser_conn is already unbindded
and released. So we add iser connection validation check inside cleanup
task to fix this corner case.

Signed-off-by: Rock Li <lihongweizz@inspur.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index bb9aaff92ca3..35dfbf41fc40 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -366,7 +366,12 @@ static void iscsi_iser_cleanup_task(struct iscsi_task *task)
 	struct iscsi_iser_task *iser_task = task->dd_data;
 	struct iser_tx_desc *tx_desc = &iser_task->desc;
 	struct iser_conn *iser_conn = task->conn->dd_data;
-	struct iser_device *device = iser_conn->ib_conn.device;
+	struct iser_device *device;
+
+	/* stop connection might happens before iser cleanup work */
+	if (!iser_conn)
+		return;
+	device = iser_conn->ib_conn.device;
 
 	/* DEVICE_REMOVAL event might have already released the device */
 	if (!device)
-- 
2.27.0

