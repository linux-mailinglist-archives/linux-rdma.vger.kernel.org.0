Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD5C57C703
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiGUJAG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 05:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiGUJAF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 05:00:05 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A289580539;
        Thu, 21 Jul 2022 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=M6jxu
        ah1ujD34G4yChP0Qpozpm0vxAM5+IQLqvBa/18=; b=j1JiQvBEdjvgrHyMbi4P6
        JyU13a6WJdttrNqibg+NNpk9o6Tm/l2eTpFCpcCcg8334UA73j06z1KmZ7TPRCPz
        xlVgygtKMIV49usqUlixWF/+dqNU9AvE2duE+ncVVK4CuHiDp4rYgqU+bmEovMPJ
        /cOy/n8X9Tr3nlpi0nb8G4=
Received: from localhost.localdomain (unknown [223.104.68.234])
        by smtp10 (Coremail) with SMTP id DsCowAAX67OCFdlijGHcOQ--.101S2;
        Thu, 21 Jul 2022 16:59:48 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] IB/qib: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 16:59:44 +0800
Message-Id: <20220721085944.50506-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAX67OCFdlijGHcOQ--.101S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1DCw1xWw1rZF17GFg_yoWfAFbEgF
        1UX397Ww1rCFy2kF4DWr15ZFW0kw4kWr1kZ3sav3ZxC343tF13A3sYyFWfZw4rWrWUWFWr
        Kr45Wwn2yw45GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiQ6p3UUUUU==
X-Originating-IP: [223.104.68.234]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivwRFZFWB0i97NQAAs9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/infiniband/hw/qib/qib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index b37b1c6d35c6..26c615772be3 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -321,7 +321,7 @@ struct qib_verbs_txreq {
  * These 7 values (SDR, DDR, and QDR may be ORed for auto-speed
  * negotiation) are used for the 3rd argument to path_f_set_ib_cfg
  * with cmd QIB_IB_CFG_SPD_ENB, by direct calls or via sysfs.  They
- * are also the the possible values for qib_link_speed_enabled and active
+ * are also the possible values for qib_link_speed_enabled and active
  * The values were chosen to match values used within the IB spec.
  */
 #define QIB_IB_SDR 1
-- 
2.25.1

