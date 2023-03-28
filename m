Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893DD6CBCE4
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Mar 2023 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjC1Kwz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Mar 2023 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjC1Kwt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Mar 2023 06:52:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B6618A
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 03:52:47 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32SAqWcb059087;
        Tue, 28 Mar 2023 19:52:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 28 Mar 2023 19:52:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32SAqW6J059079
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Mar 2023 19:52:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0e031582-aed6-58ee-3477-6d787f06560a@I-love.SAKURA.ne.jp>
Date:   Tue, 28 Mar 2023 19:52:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] RDMA: don't ignore client->add() failures
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

syzbot is reporting refcount leak when client->add() from
add_client_context() fails, for commit 11a0ae4c4bff ("RDMA: Allow
ib_client's to fail when add() is called") for unknown reason ignores
error from client->add(). We need to return an error in order to indicate
that client could not be added, otherwise the caller will get confused.

Reported-by: syzbot <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=5e70d01ee8985ae62a3b
Fixes: 11a0ae4c4bff ("RDMA: Allow ib_client's to fail when add() is called")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/infiniband/core/device.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..c72f810ceae1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -718,17 +718,17 @@ static int add_client_context(struct ib_device *device,
 		goto out;
 	downgrade_write(&device->client_data_rwsem);
 	if (client->add) {
-		if (client->add(device)) {
+		ret = client->add(device);
+		if (ret) {
 			/*
-			 * If a client fails to add then the error code is
-			 * ignored, but we won't call any more ops on this
-			 * client.
+			 * If a client fails to add, we won't call any more
+			 * ops on this client.
 			 */
 			xa_erase(&device->client_data, client->client_id);
 			up_read(&device->client_data_rwsem);
 			ib_device_put(device);
 			ib_client_put(client);
-			return 0;
+			return ret;
 		}
 	}
 
-- 
2.18.4
