Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1453E5F5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiFFMfy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiFFMfy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 08:35:54 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBE2AD996;
        Mon,  6 Jun 2022 05:35:48 -0700 (PDT)
X-QQ-mid: bizesmtp77t1654518866tsuslvzx
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 06 Jun 2022 20:34:21 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: gDHn9VCP/rxflbaaDKzGJ/IapudJoJpOUO9NKEeMpAnuW4pnNla36YdLzfRhL
        KGf/xNh0wOPaBDovpfTQz/r9AsGld1qTGLmCICVSiW2k29qdA3C0FejJt+Ds0DrGk2nMife
        kiJWAu4ZXwdORrMcdpoaojCEqnI/81e85ZSfDKmbXumw8gP4U6IlR3ffiLh0Vty+g3ECtCf
        OgQDIHbVSkCoXvNtHAM/F4fJh+1P2VaLxPxycPQ9Pyuk+ODHa3xvRJjtT3Ng96ARuQH0CDN
        Q6+bYXC/O4QNVxrvl5LHfX2uIUNbT1DhesPMaL4hBI5DDW3wEOoETawPMWS3ZCuMaw80mFu
        B/VVarTmlsdgVag4zMHWwVgxrdKfQ==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v2] RDMA/hw/hfi1/pio_copy: Fix typo in comment
Date:   Mon,  6 Jun 2022 20:34:19 +0800
Message-Id: <20220606123419.29109-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---

Changes since v1
*Change commit log

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

