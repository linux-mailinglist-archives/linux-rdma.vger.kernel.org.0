Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B87F7DAAE0
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Oct 2023 05:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjJ2E6Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Oct 2023 00:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2E6P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Oct 2023 00:58:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC8C5;
        Sat, 28 Oct 2023 21:58:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8ECC433C8;
        Sun, 29 Oct 2023 04:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698555493;
        bh=9hHkEnlThf+pFdPmQSzpTWl+go1cY54qJlbF0GzF9Mk=;
        h=From:To:Cc:Subject:Date:From;
        b=TdGlCM0beg6PNT02N3/UCV/N2Y51q7fBzp0wTXAYjfSKXyr/SBjEBgnj3MmYhzUd/
         5ADeFyyNlTmjAPmSR9KIgHWxgjQ0iSbeKH+V555ERdNx7zuzai7DOSA1DT9oglNeQa
         HS4YjiFzoms2TfRDadn5FYARxWDUcjZhdV5uehu+Hx6oMW3WnVyoEQIMuGHq7W2Yh2
         k1YdfCf775W7CMJ3oYi0oTWIX7QQ8CChKrs7GzJdAtLEsW/PhducZRq61NP1ZIplkT
         knGsl1V5YmYf+FrkNz3uHZ2No2JiIjpimXBitCa39rtIBl02xjqo79LyVoSOmNRMKU
         pAAnvVMCZ33ZA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org
Subject: [PATCH] RDMA/irdma: use crypto_shash_digest() in irdma_ieq_check_mpacrc()
Date:   Sat, 28 Oct 2023 21:57:56 -0700
Message-ID: <20231029045756.153943-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Simplify irdma_ieq_check_mpacrc() by using crypto_shash_digest() instead
of an init+update+final sequence.  This should also improve performance.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/infiniband/hw/irdma/utils.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 6cd5cb85dafe..ead573aabc5c 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1386,31 +1386,26 @@ void irdma_free_hash_desc(struct shash_desc *desc)
  * irdma_ieq_check_mpacrc - check if mpa crc is OK
  * @desc: desc for hash
  * @addr: address of buffer for crc
  * @len: length of buffer
  * @val: value to be compared
  */
 int irdma_ieq_check_mpacrc(struct shash_desc *desc, void *addr, u32 len,
 			   u32 val)
 {
 	u32 crc = 0;
-	int ret;
-	int ret_code = 0;
 
-	crypto_shash_init(desc);
-	ret = crypto_shash_update(desc, addr, len);
-	if (!ret)
-		crypto_shash_final(desc, (u8 *)&crc);
+	crypto_shash_digest(desc, addr, len, (u8 *)&crc);
 	if (crc != val)
-		ret_code = -EINVAL;
+		return -EINVAL;
 
-	return ret_code;
+	return 0;
 }
 
 /**
  * irdma_ieq_get_qp - get qp based on quad in puda buffer
  * @dev: hardware control device structure
  * @buf: receive puda buffer on exception q
  */
 struct irdma_sc_qp *irdma_ieq_get_qp(struct irdma_sc_dev *dev,
 				     struct irdma_puda_buf *buf)
 {

base-commit: 2af9b20dbb39f6ebf9b9b6c090271594627d818e
-- 
2.42.0

