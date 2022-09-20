Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853015BD9DD
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 04:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiITCHs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Sep 2022 22:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiITCHq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Sep 2022 22:07:46 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E695723C;
        Mon, 19 Sep 2022 19:07:44 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id OBB00036;
        Tue, 20 Sep 2022 10:07:36 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 20 Sep 2022 10:07:40 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <ennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] IB/qib: update the comments of qib_free_irq
Date:   Mon, 19 Sep 2022 22:07:38 -0400
Message-ID: <20220920020738.2248-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   2022920100736bbf15e3331bd11c227f8913beb382fee
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

remove the double word to.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
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
2.27.0

