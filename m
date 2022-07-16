Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0485E579F5B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiGSNPK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 09:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243542AbiGSNOA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 09:14:00 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD92991CF2;
        Tue, 19 Jul 2022 05:30:56 -0700 (PDT)
X-QQ-mid: bizesmtp87t1658233653tkyknpj6
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:27:32 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000020
X-QQ-FEAT: 0AHoP94G71VNcRvqrE44TIGCI91Hf/fhA9+UmUPYEiA0BScjVDDUB7VKoETS9
        uDkKwlBq210vc9pQw6Wg+cUKUeTsnJ+hFIaw9DBFg9iw+fWhjMLj3ifkFxtFbdrzJ99ZsVT
        8AejSUoUsw+b1x4OUE1IxJKbmcbiFq1r1day/lpGiwXXAvEUMoxkS4bAdya/VPuJsiBXAHS
        Rh/FNHDYgC4Zw5uTuOSKBatd0SjgVrOjkvfwVhOHTqGq3Rrb8lGgHOs/ZZW6Iq+ER1Bzqv7
        f7opRZgYdwjjSDjeakaEMzbQ7JP4N+fwJ0JHVymIbbTGsRj39Y5iexYCQlGK8n0qERnhcjE
        LVoC2qWEG2pzO4i0MTm7wOIiIWXVBVlSXYZHXDu3lkNY6kQJYc6QyzW+VhcMEZVJC31guJ0
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     leon@kernel.org
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] RDMA: Fix comment typo
Date:   Sat, 16 Jul 2022 12:25:18 +0800
Message-Id: <20220716042518.37360-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1

