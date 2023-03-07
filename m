Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD076AF5FF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjCGToA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 14:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjCGTnh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 14:43:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90EC65A2;
        Tue,  7 Mar 2023 11:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5557761538;
        Tue,  7 Mar 2023 19:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBDEC4339B;
        Tue,  7 Mar 2023 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678217536;
        bh=54NM9OALq0MKWDH1qGbReeL8UC7AaboBAt1Fx0XokNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFEvuejqICQ/3s0OPFdMkg/RqVVpCpjTqimTfVJfDI/az2hV5ZUatETMz+0xgppr1
         TOrWSfl0hBg5mgqVSQPeTAIHweqySNbUM2HP3A1m+6TOKuuWxgFAoZVJjTD6ksdc4q
         o03+qPG9qSqbZNY8VyLu8SODGeEj3y9fZyAKGyqeTNlesHK3bhDH26GaL5fKR/e97T
         FHJp5bg5igb6hoKRj3x/RmiUF7GE4Qd1ZuBQ5KYJ1QbNwI14iAzlDcUYdsgfwwUyIb
         LQSTHhcpR+nB6fNik6XEsv1iOokHbP0x+Kvydb5RA1UcMWRJjCbIagFcytd/7IlBLI
         8JrO30yGsZyUA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] IB/hfi1: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 13:32:10 -0600
Message-Id: <20230307193211.874747-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307193211.874747-1-helgaas@kernel.org>
References: <20230307193211.874747-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 drivers/infiniband/hw/hfi1/pcie.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index a0802332c8cb..08732e1ac966 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -7,7 +7,6 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/vmalloc.h>
-#include <linux/aer.h>
 #include <linux/module.h>
 
 #include "hfi.h"
@@ -65,7 +64,6 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
 	}
 
 	pci_set_master(pdev);
-	(void)pci_enable_pcie_error_reporting(pdev);
 	return 0;
 
 bail:
-- 
2.25.1

