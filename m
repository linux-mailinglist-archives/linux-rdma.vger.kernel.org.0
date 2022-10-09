Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351145F8A17
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Oct 2022 10:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJIILj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Oct 2022 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJIILi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Oct 2022 04:11:38 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BD0F2E9C9;
        Sun,  9 Oct 2022 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vsWH7
        IkxtHbChJdSNgFucJQ2WMShYDa2SxxjSkF8E2M=; b=Vku5RKwYh4r0uR9d4lxXt
        EUI9ZaTELqphKO0wZSEoWVyeE5HTWS7VAzxg5c1U7cXj4NheCvHu9EqQ2RP07xbF
        cMzuBsSAOJO08e8pi6QwhplpruiyB5F1KKicuRqI7AUKU+ML70NmCf18NmWbGwPs
        NK9kkB1HeIrZAWT5FuoYUs=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgB3ttMtgkJjdr25jw--.48799S2;
        Sun, 09 Oct 2022 16:11:26 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] include/rdma/opa_vnic.h: fix spelling typo in comment
Date:   Sun,  9 Oct 2022 16:10:47 +0800
Message-Id: <20221009081047.2643471-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgB3ttMtgkJjdr25jw--.48799S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GryxtF1kZrb_yoW3Wrg_Z3
        y7ta1jg34DJFZavr4Y9F4FqryUKan0ka95Wwn8Xr4DGa97W3yDJ3yDJrn29a47WrZ0qa43
        W3Z3GryUJ3WYqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUby8B5UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbi8A6V+1uoiZrgYwAAsz
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 include/rdma/opa_vnic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/opa_vnic.h b/include/rdma/opa_vnic.h
index f3d5377b217a..d297f084001a 100644
--- a/include/rdma/opa_vnic.h
+++ b/include/rdma/opa_vnic.h
@@ -51,7 +51,7 @@ static inline void *opa_vnic_dev_priv(const struct net_device *dev)
 	return oparn->dev_priv;
 }
 
-/* opa_vnic skb meta data structrue */
+/* opa_vnic skb meta data structure */
 struct opa_vnic_skb_mdata {
 	u8 vl;
 	u8 entropy;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

