Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196AE578403
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 15:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiGRNma (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 09:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiGRNm3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 09:42:29 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26FE20BD7;
        Mon, 18 Jul 2022 06:42:24 -0700 (PDT)
X-QQ-mid: bizesmtp82t1658151726t7d1sdd1
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:42:04 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: ClLnYZSF2IvTozRVxtF6YebvLnrNYenGsdA2/UM9MFlC7l+OJ4jHiYtX/GGgB
        2LziMNiBt27F95lkCLXZM/ULVy8ZKf0KYVuaLfqkyRxQxbmqlf+qVXufcNRZ1fL+w9rIxDA
        e0CIaXvwh5tGTUlVvWkXPVQabvp6WWmDxjY7ZHxY2NUkAzd122UemOi/lhPZxg7LU0ZAhxe
        5JaWjojMYd6uzrvbVZWfQ7w+9gNb1jkVBdYz3x7D5OnjA3W2OmEAO2KUahUlFtaJHRdYNJ8
        6TzhtKXIh1Bya9iKutbn3shyWh/Fink5lnXhQ5WhxQ/hVLieyyLuJzXUsZ0xI+aHGzJtg+m
        nvk8nRm8b2+HKfvgGMk+2jr02xddiG8k24LQGT9cB2uUadwKv4BXr/aelNapfYIgiQyDClm
        eljtvwNE01vUtdm1hmIYcQ==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jgg@ziepe.ca
Cc:     dennis.dalessandro@cornelisnetworks.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] IB: Fix comment typo
Date:   Fri, 15 Jul 2022 13:40:07 +0800
Message-Id: <20220715054007.5320-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The double `are' is duplicated in line 156, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index f61e07f684cf..3937144b2ae5 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -153,7 +153,7 @@ static int qib_get_base_info(struct file *fp, void __user *ubase,
 		kinfo->spi_tidcnt += dd->rcvtidcnt % subctxt_cnt;
 	/*
 	 * for this use, may be cfgctxts summed over all chips that
-	 * are are configured and present
+	 * are configured and present
 	 */
 	kinfo->spi_nctxts = dd->cfgctxts;
 	/* unit (chip/board) our context is on */
-- 
2.35.1

