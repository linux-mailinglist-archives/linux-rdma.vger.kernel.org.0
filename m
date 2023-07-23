Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A66A75E053
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jul 2023 09:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjGWHp1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jul 2023 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGWHp1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jul 2023 03:45:27 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FA7819BF
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 00:45:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [36.24.99.225])
        by mail-app3 (Coremail) with SMTP id cC_KCgD3_g6B2rxkkDN_Cw--.46290S4;
        Sun, 23 Jul 2023 15:45:05 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com,
        michaelgur@nvidia.com, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, yuancan@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1] RDMA/nldev: Add length check for IFLA_BOND_ARP_IP_TARGET parsing
Date:   Sun, 23 Jul 2023 15:45:04 +0800
Message-Id: <20230723074504.3706691-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgD3_g6B2rxkkDN_Cw--.46290S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1Dtr45WrW8WF48ur1UAwb_yoW8JFW3pF
        W0qFy7KF47JF13Ga1Dta1kWFWa93W7ZFyagFWDt343urn8Xw1S9345CFyYvFWDArWkA3W2
        vF15Z34j9FZ2qr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VU10tC7UUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The nla_for_each_nested parsing in function
nldev_stat_set_counter_dynamic_doit() does not check the length of the
attribute. This can lead to an out-of-attribute read and allow a
malformed nlattr (e.g., length 0) to be viewed as a 4 byte integer.

This patch adds the check based on nla_len() just as other code does,
see how bond_changelink (drivers/net/bonding/bond_netlink.c) parses
IFLA_BOND_NS_IP6_TARGET.

Fixes: 3c3c1f141639 ("RDMA/nldev: Allow optional-counter status configuration through RDMA netlink")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/infiniband/core/nldev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index d5d3e4f0de77..74635c23b371 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1989,6 +1989,11 @@ static int nldev_stat_set_counter_dynamic_doit(struct nlattr *tb[],
 
 	nla_for_each_nested(entry_attr, tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS],
 			    rem) {
+		if (nla_len(entry_attr) < sizeof(index)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		index = nla_get_u32(entry_attr);
 		if ((index >= stats->num_counters) ||
 		    !(stats->descs[index].flags & IB_STAT_FLAG_OPTIONAL)) {
-- 
2.17.1

