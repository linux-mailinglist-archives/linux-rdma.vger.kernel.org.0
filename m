Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5C05B1E95
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiIHNVH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiIHNVA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 09:21:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531F85F22D;
        Thu,  8 Sep 2022 06:20:58 -0700 (PDT)
X-QQ-mid: bizesmtp62t1662643244tal9ihya
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:20:43 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 6PjtIMncaiwO2h15Zi0JzS593J4vJe9nukg65GZI9MuAkk6eMo3sJ2GNddB13
        U2LBSjcapx55NK95rt2CT41tacvSMrBi/QpUtK2qw/JqolU9PhgO/NI0CmRTaoGjLOs2So1
        nTFrlpqu4a+BtW2j6/SJ292/gI3GWVPk41J19D4a/K8iRL0Bi/ldJXFN0Tsh9fEGJ8eIz1I
        GwmWmDNmo7cVoR8GMN6xv8zQfup6qGFRdzQapAKhhEtJELaSBUZYEzVs6FjTuyJR2oQow2Y
        EVoKh+O6q5MBtjVRXEqBGUnHSC3KTPYMRNLGO4DZvz6nG/K0x2PB+cXtKxoQtGohmxxOUZb
        JK1UEguBrBE/eTrQJ0isTIWiLMhwGXbnQs6SrA4jEN0rsgFmr+Dck/oh5t3cA==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] hw/qib: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:20:36 +0800
Message-Id: <20220908132036.42355-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/infiniband/hw/qib/qib_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index cb2a02d671e2..692b64efad97 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -295,7 +295,7 @@ void qib_free_irq(struct qib_devdata *dd)
  * Setup pcie interrupt stuff again after a reset.  I'd like to just call
  * pci_enable_msi() again for msi, but when I do that,
  * the MSI enable bit doesn't get set in the command word, and
- * we switch to to a different interrupt vector, which is confusing,
+ * we switch to a different interrupt vector, which is confusing,
  * so I instead just do it all inline.  Perhaps somehow can tie this
  * into the PCIe hotplug support at some point
  */
-- 
2.36.1

