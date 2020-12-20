Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FE02DF469
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Dec 2020 09:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgLTIVu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Dec 2020 03:21:50 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:44970 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727153AbgLTIVu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Dec 2020 03:21:50 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Dec 2020 03:21:49 EST
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app3 (Coremail) with SMTP id cC_KCgA3_+ydB99fmttYAA--.15457S4;
        Sun, 20 Dec 2020 16:13:22 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Divya Indi <divya.indi@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/sa: Fix memleak in ib_nl_make_request
Date:   Sun, 20 Dec 2020 16:13:14 +0800
Message-Id: <20201220081317.18728-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgA3_+ydB99fmttYAA--.15457S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4rAr1fKFW7Wr4rKw43trb_yoWfXrg_Kr
        4jvF97XrW5CFn2kr47Kw4fWrn0vwn5Xrn3urs7K34fC345JF93W3yxZFyfC3W7GwsFkr4U
        J39rJwn3AF4fKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUMBlZdtRf+rwAHsy
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When rdma_nl_multicast() fails, skb should be freed
just like when ibnl_put_msg() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/infiniband/core/sa_query.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 89a831fa1885..8bd23b5cc913 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -873,8 +873,10 @@ static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
 	spin_lock_irqsave(&ib_nl_request_lock, flags);
 	ret = rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_flag);
 
-	if (ret)
+	if (ret) {
+		nlmsg_free(skb);
 		goto out;
+	}
 
 	/* Put the request on the list.*/
 	delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
-- 
2.17.1

