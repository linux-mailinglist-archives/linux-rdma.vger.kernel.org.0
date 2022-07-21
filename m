Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD87557C6DB
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiGUIw5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiGUIwu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 04:52:50 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D885E7E836;
        Thu, 21 Jul 2022 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sHrKD
        57Aica5jJxqsvfHugmuoPlDwEvveCrwPU7y57A=; b=TW6x56P0UPIsDVBWsILyG
        Z/16950hVdVbdXN78PXuA+XPvPDKoo8rICN/OJw/s/M8vR6zlpUvzgp2OwT3Ij9K
        xTp9nMTVu9W2q2u9UBJu77/DufIhhwBeGRxm/wojk0uIMt7HlJ2r4x7TvTtd/rvF
        qxDgq1RdpufJDn/USrw8pA=
Received: from localhost.localdomain (unknown [223.104.68.234])
        by smtp14 (Coremail) with SMTP id EsCowACnvanSE9lia0v5OA--.57S2;
        Thu, 21 Jul 2022 16:52:38 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] IB/core: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 16:52:32 +0800
Message-Id: <20220721085232.50291-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACnvanSE9lia0v5OA--.57S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr15ur4rZFWkuF43trb_yoWfWrgE9w
        nFvFn7XrZ5AF1vyr45Z3WfWF9avw4Iva1S9rs2g3s3XryUurn3Xr18ZrZ8tw1UJw17JF98
        XF13Gr409rW5ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiHGmtUUUUU==
X-Originating-IP: [223.104.68.234]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAwRFZGB0LndACwAAsg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/infiniband/core/roce_gid_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index 68197e576433..e958c43dd28f 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -250,7 +250,7 @@ static bool upper_device_filter(struct ib_device *ib_dev, u32 port,
 
 /**
  * is_upper_ndev_bond_master_filter - Check if a given netdevice
- * is bond master device of netdevice of the the RDMA device of port.
+ * is bond master device of netdevice of the RDMA device of port.
  * @ib_dev:		IB device to check
  * @port:		Port to consider for adding default GID
  * @rdma_ndev:		Pointer to rdma netdevice
-- 
2.25.1

