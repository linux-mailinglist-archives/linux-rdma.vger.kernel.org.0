Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06CF6AF600
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCGToB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 14:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjCGTni (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 14:43:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD8171D;
        Tue,  7 Mar 2023 11:32:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EE8AB81A13;
        Tue,  7 Mar 2023 19:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8E4C433D2;
        Tue,  7 Mar 2023 19:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678217538;
        bh=0ajafqK3qaohYJkjyLboaiQW2r1fsUha7ulM5WFkbtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IHImR542j4zo6XPBVPwjD3nawD4qlgyD9P0u2/pmaMvMieE2fEhjeVlJ85ILgF7lp
         E2NwD4Zykb9Jv/N9X99mMF103MSBd70vBpAqlbjtruZmztKJF1Jjgntqp3iXIFuRoA
         BYSwuRLVUdX1sqLy2pEpjzf/ZAX/Lr8Xyo3j6SWtFPBOpAGdSVtkhhfXdEFcWn3qPN
         teX+xlmFVdgLxSNivOlQ6ft40SRaHV6MNctLBWvdFWdriHTO9ePmZDN0IjNKWSswbn
         E3dPjZf3wILNViD+HrEE2nqwoom3p1sV8jQiOy0SfOaHMFr3+vnkyWtbsO1cOGNhVp
         mdVHlpuOad5OA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] IB/qib: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 13:32:11 -0600
Message-Id: <20230307193211.874747-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307193211.874747-1-helgaas@kernel.org>
References: <20230307193211.874747-1-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() enables the device to send ERR_*
Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core does this for all devices during enumeration, so the
driver doesn't need to do it itself.

Remove the redundant pci_enable_pcie_error_reporting() call from the
driver.

Note that this only controls ERR_* Messages from the device.  An ERR_*
Message may cause the Root Port to generate an interrupt, depending on the
AER Root Error Command register managed by the AER service driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/qib/qib_pcie.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index 692b64efad97..47bf64ace05c 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -35,7 +35,6 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/vmalloc.h>
-#include <linux/aer.h>
 #include <linux/module.h>
 
 #include "qib.h"
@@ -105,13 +104,6 @@ int qib_pcie_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	pci_set_master(pdev);
-	ret = pci_enable_pcie_error_reporting(pdev);
-	if (ret) {
-		qib_early_err(&pdev->dev,
-			      "Unable to enable pcie error reporting: %d\n",
-			      ret);
-		ret = 0;
-	}
 	goto done;
 
 bail:
-- 
2.25.1

