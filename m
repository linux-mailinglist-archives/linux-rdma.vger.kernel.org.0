Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5E56D5B0
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 09:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiGKHJA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGKHIR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 03:08:17 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 050B01ADA7;
        Mon, 11 Jul 2022 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OS8yM
        oEJWC5pIc75D33LcDyvm2Vl3MkjdgsLOHnTjlI=; b=fpPb2r1SRLjaz/7u3Eh6A
        Yo0yfDPbOvbwcSsQ/a3iPfxVFWCxhJ7FOEvPN9gkx18e2yHn9s3mZOrZmjYiffTD
        RG3cDsHcKN3peqZa0gPPFWhkWNyddrsdLg1/5NRat+blS8Z6vXSSkeCNAs8ygJxv
        lSQXzFERcMQU1xq2CZ47xc=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp3 (Coremail) with SMTP id G9xpCgDn_4knzMtimgUiOg--.9376S4;
        Mon, 11 Jul 2022 15:07:25 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] RDMA/hfi1: fix potential memory leak in setup_base_ctxt()
Date:   Mon, 11 Jul 2022 15:07:18 +0800
Message-Id: <20220711070718.2318320-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDn_4knzMtimgUiOg--.9376S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw47GrW3Xw43Jw17Xw1xAFb_yoWfKrcEgr
        yUuryDXr4YkwsYvw40vws3ZrWIqrW8Xrs5Za9aq3sxAF15CrZxtF1kuF43X348ZayjvFW5
        urs7Kr4SyF4fKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRibAwPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiQxU7jFc7ajP70QAAs+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

setup_base_ctxt() allocates a memory chunk for uctxt->groups with
hfi1_alloc_ctxt_rcv_groups(). When init_user_ctxt() fails, uctxt->groups
is not released, which will lead to a memory leak.

We should release the uctxt->groups with hfi1_free_ctxt_rcv_groups()
when init_user_ctxt() fails.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 2e4cf2b11653..629beff053ad 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1179,8 +1179,10 @@ static int setup_base_ctxt(struct hfi1_filedata *fd,
 		goto done;
 
 	ret = init_user_ctxt(fd, uctxt);
-	if (ret)
+	if (ret) {
+		hfi1_free_ctxt_rcv_groups(uctxt);
 		goto done;
+	}
 
 	user_init(uctxt);
 
-- 
2.25.1

