Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36CB68B7DA
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 09:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBFI6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 03:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBFI6p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 03:58:45 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 00:58:38 PST
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED5DBC4;
        Mon,  6 Feb 2023 00:58:38 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id CCM00026;
        Mon, 06 Feb 2023 16:57:26 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.16; Mon, 6 Feb 2023 16:57:27 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] RDMA/restrack: Correct spelling
Date:   Mon, 6 Feb 2023 03:57:25 -0500
Message-ID: <20230206085725.1507-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20232061657266002f1b6be9d16f5251f971d716169a6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We should use this replace thie.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 include/rdma/restrack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 79d109c47242..d7ee54b7b9ae 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -162,7 +162,7 @@ struct rdma_restrack_entry *rdma_restrack_get_byid(struct ib_device *dev,
  * rdma_restrack_no_track() - don't add resource to the DB
  * @res: resource entry
  *
- * Every user of thie API should be cross examined.
+ * Every user of this API should be cross examined.
  * Probaby you don't need to use this function.
  */
 static inline void rdma_restrack_no_track(struct rdma_restrack_entry *res)
-- 
2.27.0

