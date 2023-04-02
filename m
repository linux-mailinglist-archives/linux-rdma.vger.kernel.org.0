Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23116D3590
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Apr 2023 07:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDBFKb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Apr 2023 01:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBFKa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 2 Apr 2023 01:10:30 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BE5A27B
        for <linux-rdma@vger.kernel.org>; Sat,  1 Apr 2023 22:10:28 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3325AE8p026436;
        Sun, 2 Apr 2023 14:10:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sun, 02 Apr 2023 14:10:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3325ADTW026433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 2 Apr 2023 14:10:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a44e9ac5-44e2-d575-9e30-02483cc7ffd1@I-love.SAKURA.ne.jp>
Date:   Sun, 2 Apr 2023 14:10:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] RDMA/siw: remove namespace check from siw_netdev_event()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

syzbot is reporting that siw_netdev_event(NETDEV_UNREGISTER) cannot destroy
siw_device created after unshare(CLONE_NEWNET) due to net namespace check.
It seems that this check was by error there and should be removed.

Reported-by: syzbot <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=5e70d01ee8985ae62a3b
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Suggested-by: Leon Romanovsky <leon@kernel.org>
Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/infiniband/sw/siw/siw_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index dacc174604bf..65b5cda5457b 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -437,9 +437,6 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 
 	dev_dbg(&netdev->dev, "siw: event %lu\n", event);
 
-	if (dev_net(netdev) != &init_net)
-		return NOTIFY_OK;
-
 	base_dev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_SIW);
 	if (!base_dev)
 		return NOTIFY_OK;
-- 
2.18.4
