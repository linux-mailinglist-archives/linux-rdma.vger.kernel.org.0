Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842F46D5740
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 05:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjDDDhN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 23:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjDDDhM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 23:37:12 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66EECE47;
        Mon,  3 Apr 2023 20:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=k1rQvXrNNJdd31+9AY
        3b02aZnuxnFQyMxmz0+mFMwKE=; b=e8OIhkaG1Qphn6JcA+hIYz3Ctf+ha+rJhN
        BbCKFUBRrUIvyA8fJ69QYc8E2IrTpTtCZHHFxd7hPuxQAupAkLIpn5gn+If6px7K
        XROLYLQacJnIGVvzTeVc/VuZjNEET9WrkgVHKzgWN6XebQzx+4PUrIZxmyOwySeW
        1/5Zf6jZM=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wC3p0_2kytkxp+dAw--.17217S2;
        Tue, 04 Apr 2023 11:05:27 +0800 (CST)
From:   xiaolinkui <xiaolinkui@126.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] RDMA/hfi: add a judgment on the availability of cpumask
Date:   Tue,  4 Apr 2023 11:05:25 +0800
Message-Id: <20230404030525.24020-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wC3p0_2kytkxp+dAw--.17217S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF47trWUWw4kZF47WrWUtwb_yoW8JFW8pF
        45ZFWjgFW8Xa10ga1kAa17ArW5tas7JayvyF9Fqw1Sv345Xan0qrZ8K3W5ZryIkFykGr1a
        qrsavr1Y9r17WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uh18PUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/1tbiHBxH1lpEJlhTQwAAsh
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Linkui Xiao <xiaolinkui@kylinos.cn>

When CONFIG_CPUMASK_OFFSTACK is n, cpumask may fail to allocate, cpumask may
be NULL, and performing a bitmap operation on cpumask may cause problems at
this time.

Of course, this is a unlikely event.

Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/infiniband/hw/hfi1/affinity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 77ee77d4000f..3caa861f4d1d 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -1047,16 +1047,16 @@ int hfi1_get_proc_affinity(int node)
 	 */
 
 	ret = zalloc_cpumask_var(&diff, GFP_KERNEL);
-	if (!ret)
+	if (!ret || unlikely(!diff))
 		goto done;
 	ret = zalloc_cpumask_var(&hw_thread_mask, GFP_KERNEL);
-	if (!ret)
+	if (!ret || unlikely(!hw_thread_mask))
 		goto free_diff;
 	ret = zalloc_cpumask_var(&available_mask, GFP_KERNEL);
-	if (!ret)
+	if (!ret || unlikely(!available_mask))
 		goto free_hw_thread_mask;
 	ret = zalloc_cpumask_var(&intrs_mask, GFP_KERNEL);
-	if (!ret)
+	if (!ret || unlikely(!intrs_mask))
 		goto free_available_mask;
 
 	mutex_lock(&affinity->lock);
-- 
2.17.1

