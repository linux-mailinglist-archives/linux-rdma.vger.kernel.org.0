Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969C86C676B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 12:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCWL7Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjCWL6l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 07:58:41 -0400
Received: from out-11.mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF9C3803F
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 04:57:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679572665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wmqRaGyi3JH4o0KZA2eTUBxg4BRr4LpAbEfXiy8+oTI=;
        b=bLmbke4OQaFppFOXuIrOCuoDf88knLrRGc0uNO6Gr9n/JEeBCjXJKVR9HiAwHhLenM/qfr
        oFRHp+dMBOeBA9B8/YIO9kcmTgmHAple4WjNCVcCznI3+0WUI3i9TW4mF6GeeJaXFfXk7Y
        3KPxIDusCMpmCW2Xn+N3tuwlF1ArqBA=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/usnic: Remove redundant pci_clear_master
Date:   Thu, 23 Mar 2023 19:57:42 +0800
Message-Id: <20230323115742.13836-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove pci_clear_master to simplify the code,
the bus-mastering is also cleared in do_pci_disable_device,
like this:
./drivers/pci/pci.c:2197
static void do_pci_disable_device(struct pci_dev *dev)
{
	u16 pci_command;

	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
	if (pci_command & PCI_COMMAND_MASTER) {
		pci_command &= ~PCI_COMMAND_MASTER;
		pci_write_config_word(dev, PCI_COMMAND, pci_command);
	}

	pcibios_disable_device(dev);
}.
And dev->is_busmaster is set to 0 in pci_disable_device.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/infiniband/hw/usnic/usnic_ib_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 46653ad56f5a..13b654ddd3cc 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -602,7 +602,6 @@ static int usnic_ib_pci_probe(struct pci_dev *pdev,
 	usnic_vnic_free(vf->vnic);
 out_release_regions:
 	pci_set_drvdata(pdev, NULL);
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 out_disable_device:
 	pci_disable_device(pdev);
@@ -623,7 +622,6 @@ static void usnic_ib_pci_remove(struct pci_dev *pdev)
 	kref_put(&pf->vf_cnt, usnic_ib_undiscover_pf);
 	usnic_vnic_free(vf->vnic);
 	pci_set_drvdata(pdev, NULL);
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	kfree(vf);
-- 
2.34.1

