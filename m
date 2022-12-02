Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA20640FE9
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 22:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiLBVUL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 16:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiLBVTv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 16:19:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209AA9D2E6;
        Fri,  2 Dec 2022 13:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oV6byBYn0tYljp79kb76vPExm6qPuaFXLFbzIN1Gi3c=; b=lnJcPZFJS0R/dpvl0Gq+K5lQSR
        YmE2/eMHy0Y8CPju06DjtzSTvdcfzjDWl9/42ArRjqWkNLYlUnHaqldz/k/hvFkHAg0Z0I0uQplpo
        TMwbvD9pjvr8iPdEv/YtwLMgRf38lM0dcer5EYpq5KuZwUMAd18+79Dza6xICzBqczHxV0nw+n+D5
        QRFpFbtq5MTJJTHRY6luSsVrGWtZVWcRPCFI/GvClnINnKe7dShzFjnHj1pcGLZqdlBlTH3O+j3HP
        3n6YSaFFQHFVXpp8492HMQ+jtTAfk6SER0KdDMI7FWNfw8i37o8k7R8nLjNbkez2Uz6lahb95DKdP
        lTkOALHg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1DRp-000X5k-Sp; Fri, 02 Dec 2022 21:19:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH v2] infiniband: disable IB HW for UML
Date:   Fri,  2 Dec 2022 13:19:40 -0800
Message-Id: <20221202211940.29111-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Disable all of drivers/infiniband/hw/ for UML builds until someone
needs it and provides patches to support it.

This prevents build errors in hw/qib/qib_wc_x86_64.c.

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-rdma@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
v2: just disable infiniband/hw/, not all of infiniband.

 drivers/infiniband/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -78,6 +78,7 @@ config INFINIBAND_VIRT_DMA
 	def_bool !HIGHMEM
 
 if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
+if !UML
 source "drivers/infiniband/hw/bnxt_re/Kconfig"
 source "drivers/infiniband/hw/cxgb4/Kconfig"
 source "drivers/infiniband/hw/efa/Kconfig"
@@ -94,6 +95,7 @@ source "drivers/infiniband/hw/qedr/Kconf
 source "drivers/infiniband/hw/qib/Kconfig"
 source "drivers/infiniband/hw/usnic/Kconfig"
 source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
+endif # !UML
 source "drivers/infiniband/sw/rdmavt/Kconfig"
 source "drivers/infiniband/sw/rxe/Kconfig"
 source "drivers/infiniband/sw/siw/Kconfig"
