Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF179B613
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 02:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjIKWGh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 18:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbjIKMSV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 08:18:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DADF125
        for <linux-rdma@vger.kernel.org>; Mon, 11 Sep 2023 05:18:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19A7C433C8;
        Mon, 11 Sep 2023 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694434694;
        bh=MUxYobSM38VCQnHSUcuw7WH7Cd0NMFvSfe6kmIFxjvA=;
        h=From:To:Cc:Subject:Date:From;
        b=Gc2cNt1GYIv1ITJvcNt/DWhFkj7SpzGQTEQ4Q4ssKVG+8I9jccqkDJKG+ZYfo3yTK
         DDVBkendOwiG3CweKFJYJl/VhdXiyY/3RIwpHkpuPcne8KqytpZvdY9by7wQk1ICy6
         Ac3OKhs1du+W63RKol3ceyZfnMr8nhQjwrXNte4HtxX2sdjXftwwdF708AJtxjj/ca
         LLcqnerTXD9OH45hVKBGaeVhpH6tbQSMy8/qWOpkImxw0EO0uUrDjf1nI60erxJJw5
         I2Gi1HuFGaTuRxmFM7gA5Z/kUYmn/dh8QBpyWFCNXHZp6zDSyYLuq4Jt1JdXJtKkrF
         HAfg5cg5Ze20g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/cma: Fix truncation compilation warning in make_cma_ports
Date:   Mon, 11 Sep 2023 15:18:06 +0300
Message-ID: <a7e3b347ee134167fa6a3787c56ef231a04bc8c2.1694434639.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The following compilation error is false alarm as RDMA devices don't
have such large amount of ports to actually cause to format truncation.

drivers/infiniband/core/cma_configfs.c: In function ‘make_cma_ports’:
drivers/infiniband/core/cma_configfs.c:223:57: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  223 |                 snprintf(port_str, sizeof(port_str), "%u", i + 1);
      |                                                         ^
drivers/infiniband/core/cma_configfs.c:223:17: note: ‘snprintf’ output between 2 and 11 bytes into a destination of size 10
  223 |                 snprintf(port_str, sizeof(port_str), "%u", i + 1);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:243: drivers/infiniband/core/cma_configfs.o] Error 1

Fixes: 045959db65c6 ("IB/cma: Add configfs for rdma_cm")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma_configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 7b68b3ea979f..f2fb2d8a6597 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -217,7 +217,7 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
 		return -ENOMEM;
 
 	for (i = 0; i < ports_num; i++) {
-		char port_str[10];
+		char port_str[11];
 
 		ports[i].port_num = i + 1;
 		snprintf(port_str, sizeof(port_str), "%u", i + 1);
-- 
2.41.0

