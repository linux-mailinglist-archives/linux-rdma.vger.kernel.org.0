Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76EA2A0C4D
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 18:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgJ3RRz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJ3RRz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 13:17:55 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEEAC0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 10:17:55 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i18so1488908ots.0
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ea02V0gD7fl7r9EkkfIlVRfPLNH+c/n7YfZ8Gk5JFvY=;
        b=SFZ5UVkaFCL4Ej+bY41rbZpqxVNLeIFJZqWab+1+lOOX5l6Cb4xc5WbvQiL4/5KBhJ
         n+NlYrPG/WCJZ/dECwEBzs3vZkNOFK/zhYd4Z3m22QkFXOKnjODXMG3HNnWFyOw1gbS0
         k6RuS02LX8UZ9osTQBiuvN7HRQZMjZ6tpuqgFDHriqEVmFn8BEfX6hN+Jq+3aKv12CUE
         RnT+IlWqW5IwHrBjvbXfj1z6Zq/UW3qpR5A4/j//uux77/eMeW8KpCAnXQ/TS23ES6xw
         eY1OBgkyeZxTKE1z6EvhcooIWZ6h5ObEO8ZKDs1xSbfQxAsPev3jyjdurmb1EFEsUP4O
         WDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ea02V0gD7fl7r9EkkfIlVRfPLNH+c/n7YfZ8Gk5JFvY=;
        b=UzPXkV4xYq5AGrio630KfilHzWLb1hO3y4J6sIcmhGvOo23YfPGpz6Zjd8D70XnxN6
         WGTpqlONgBfa+EJgxoy/GikVDTcMEinsmtnrl24xRJkQ9Q3sBrnoZreoQtpb3LGxMAQX
         qPvxWkagBipz76s5blx9KPkfOlBzdVZk2sz8p/i446tEC2LzhhMktfwqKbJEvmQadkj0
         sx8wgq8arpfzBTxJr2LwMeKit6UjK2yBMZKblVZmqvm1GWXAtMqqg5EpPpm8p0R9cuuk
         RrreivbK9nyYF8DQl/vvbcoOEHPp8L3sSi7bvwJ6zVKqqkRgRVbTJWBGbKGlnshx7fGU
         Zb3g==
X-Gm-Message-State: AOAM531vIpo1xyv9HKrYzB79uHA22D9NzPpnvyEWOTCK+aP+WCi317Pr
        WGc/DjDnPl6PvjLIMYPzY/g=
X-Google-Smtp-Source: ABdhPJxW0BO5Rc25z//mN7c0Zwpb8tBZcDF2mKRr9I0BX0px3TJeaJR82KYjdUkj+ih+IfX6bWLOUQ==
X-Received: by 2002:a05:6830:1694:: with SMTP id k20mr2651559otr.100.1604078274540;
        Fri, 30 Oct 2020 10:17:54 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9ab5-99a7-d140-ecf9.res6.spectrum.com. [2603:8081:140c:1a00:9ab5:99a7:d140:ecf9])
        by smtp.gmail.com with ESMTPSA id v5sm1498414otb.44.2020.10.30.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 10:17:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2] RDMA/rxe: fix regression caused by recent patch
Date:   Fri, 30 Oct 2020 12:11:07 -0500
Message-Id: <20201030171106.4191-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The commit referenced below performs additional checking on
devices used for DMA. Specifically it checks that

device->dma_mask != NULL

Rdma_rxe uses this device when pinning MR memory but did not
set the value of dma_mask. In fact rdma_rxe does not perform
any DMA operations so the value is never used but is checked.

This patch gives dma_mask a valid value extracted from the device
backing the ndev used by rxe.

Without this patch rdma_rxe does not function.

N.B. This patch needs to be applied before the recent fix to add back
IB_USER_VERBS_CMD_POST_SEND to uverbs_cmd_mask.

Dennis Dallesandro reported that Parav's similar patch did not apply
cleanly to rxe. This one does to for-next head of tree as of yesterday.

Fixes: f959dcd6ddfd2 ("dma-direct: Fix potential NULL pointer dereference")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7652d53af2c1..c857e83323ed 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1128,19 +1128,32 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	int err;
 	struct ib_device *dev = &rxe->ib_dev;
 	struct crypto_shash *tfm;
+	u64 dma_mask;
 
 	strlcpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
 
 	dev->node_type = RDMA_NODE_IB_CA;
 	dev->phys_port_cnt = 1;
 	dev->num_comp_vectors = num_possible_cpus();
-	dev->dev.parent = rxe_dma_device(rxe);
 	dev->local_dma_lkey = 0;
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
 	dev->dev.dma_parms = &rxe->dma_parms;
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
-	dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
+
+	/* rdma_rxe never does real DMA but does rely on
+	 * pinning user memory in MRs to avoid page faults
+	 * in responder and completer tasklets. This code
+	 * supplies a valid dma_mask from the underlying
+	 * network device. It is never used but is checked.
+	 */
+	dev->dev.parent = rxe_dma_device(rxe);
+	dma_mask = *(dev->dev.parent->dma_mask);
+	err = dma_coerce_mask_and_coherent(&dev->dev, dma_mask);
+	if (err) {
+		pr_warn("dma_mask not supported\n");
+		return err;
+	}
 
 	dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
 
-- 
2.27.0

