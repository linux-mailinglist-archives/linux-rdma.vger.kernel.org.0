Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B5753DAF1
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jun 2022 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbiFEJFh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jun 2022 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiFEJFg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jun 2022 05:05:36 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC96357;
        Sun,  5 Jun 2022 02:05:31 -0700 (PDT)
X-QQ-mid: bizesmtp72t1654419915tj24ww37
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 17:05:09 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: TskX/GkkryC05Wp6pvdlYOKVa4mTTI4oeTT8wapDAWtaZeFty6+pv1W2bKEPS
        1osoDzONAkW9P9YkXrBpkiaROxB3GJci2m5Qaf3W3pJpHuvnaSqNNYKGKJ1tEkTxkphsi97
        pmVVqT/48JpY5zUhkQ/NoDBeqAoosY3iYcEkRRCUCvfa6mFYawRLnW2p3tevvuhw3DGY5hm
        1WMnxFhFCmylfEPqPP9NiZYlIa0IJxQPgvI9cWrTyn+cfux5VW3ykVK8vzsFqf9trncP+gB
        ceD/rUiBHE2gjgHxOcETujf6Wzeymb2Ruk+G0ihExAYHuhmuPdLa/HZ4aKvljEF+SjPVZJm
        CaWB2a47zbOsnpnDwr3Wd2SH+mYEQ==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] RDMA/hw/hfi1/pio_copy: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 17:05:08 +0800
Message-Id: <20220605090508.12124-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/infiniband/hw/hfi1/pio_copy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/pio_copy.c b/drivers/infiniband/hw/hfi1/pio_copy.c
index 136f9a99e1e0..7690f996d5e3 100644
--- a/drivers/infiniband/hw/hfi1/pio_copy.c
+++ b/drivers/infiniband/hw/hfi1/pio_copy.c
@@ -172,7 +172,7 @@ static inline void jcopy(u8 *dest, const u8 *src, u32 n)
 }
 
 /*
- * Read nbytes from "from" and and place them in the low bytes
+ * Read nbytes from "from" and place them in the low bytes
  * of pbuf->carry.  Other bytes are left as-is.  Any previous
  * value in pbuf->carry is lost.
  *
-- 
2.36.1

