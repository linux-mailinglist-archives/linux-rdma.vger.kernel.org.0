Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3B7695C9
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjGaMOB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjGaMOA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 08:14:00 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A76210E3;
        Mon, 31 Jul 2023 05:13:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [125.120.146.22])
        by mail-app2 (Coremail) with SMTP id by_KCgCXn4tlpcdkEBfaCg--.57020S4;
        Mon, 31 Jul 2023 20:13:25 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, fw@strlen.de, yang.lee@linux.alibaba.com,
        jgg@ziepe.ca, markzhang@nvidia.com, phaddad@nvidia.com,
        yuancan@huawei.com, linma@zju.edu.cn, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, aharonl@nvidia.com, leon@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH net v1 2/2] RDMA/nldev: specify the nested length of RDMA_NLDEV_ATTR_STAT_HWCOUNTERS
Date:   Mon, 31 Jul 2023 20:13:24 +0800
Message-Id: <20230731121324.3973136-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCXn4tlpcdkEBfaCg--.57020S4
X-Coremail-Antispam: 1UD129KBjvJXoW7urykAw4Uuw1Dur45JF43Wrg_yoW8Wryrpa
        yqyFy2ka43GF1jkw1qyFWkWrWa9wnxZr9rGanFg343Cwn8Xwn7W342kr1vvaykt34UJ397
        Jr1UC347CFyqkr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUOeOJUUUUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The nla_for_each_nested parsing in function
nldev_stat_set_counter_dynamic_doit() does not check the length of the
attribute. This can lead to an out-of-attribute read and allow a
malformed nlattr (e.g., length 0) to be viewed as a 4 byte integer.

This patch leverages the newly introduced NLA_POLICY_NESTED_NO_TYPE
which sets the len field in nla_policy and allows the nlmsg_parse in
function nldev_stat_set_doit checks the nested length.

Fixes: 3c3c1f141639 ("RDMA/nldev: Allow optional-counter status configuration through RDMA netlink")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/infiniband/core/nldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index d5d3e4f0de77..c33eacc18d97 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -145,7 +145,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_STAT_COUNTER]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_STAT_COUNTER_ENTRY]	= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_STAT_COUNTER_ID]       = { .type = NLA_U32 },
-	[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]       = { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]       = NLA_POLICY_NESTED_NO_TYPE(sizeof(u32)),
 	[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY]  = { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME] = { .type = NLA_NUL_STRING },
 	[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE] = { .type = NLA_U64 },
-- 
2.17.1

