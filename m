Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F15B6A3E6E
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Feb 2023 10:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjB0JdZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Feb 2023 04:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjB0JdY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Feb 2023 04:33:24 -0500
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 01:33:20 PST
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D86EBB
        for <linux-rdma@vger.kernel.org>; Mon, 27 Feb 2023 01:33:19 -0800 (PST)
From:   Daniil Dulov <d.dulov@aladdin.ru>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     Daniil Dulov <d.dulov@aladdin.ru>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] RDMA/siw: Fix potential page_array out of range access
Date:   Mon, 27 Feb 2023 01:17:51 -0800
Message-ID: <20230227091751.589612-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.20.32]
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When seg is equal to MAX_ARRAY, the loop should break, otherwise
it will result in out of range access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 3c3ae5ef2942..f9eb314c6e14 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -548,7 +548,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			data_len -= plen;
 			fp_off = 0;
 
-			if (++seg > (int)MAX_ARRAY) {
+			if (++seg == (int)MAX_ARRAY) {
 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
 				siw_unmap_pages(page_array, kmap_mask);
 				wqe->processed -= c_tx->bytes_unsent;
-- 
2.25.1

