Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38229F6CF
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 22:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgJ2V1o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 17:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJ2V1o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 17:27:44 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE76C0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 14:27:42 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 32so3723474otm.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLhh20JqLGAcpH6U1jhAsEUSYpAbbInrMEqzw1cRWu0=;
        b=cvPhlNZTL0fJykjj7+n/6HbBs/IrhTIkDs3xyvN557pSs2P5LghhQzNqNIFjNHgNFt
         vE3SVAImE6jxG40Szs1/jHa6J+Q47IjoiMhtzOMISfEDjnuhrNFd6Gu4u9fN+pxiOiSM
         KRs5ri0GtpDA6SQgGpWkejNLAXkwBUj4ZGCtRA5ZZiK+tceV7bHFZJNQasl6ROyk5Bfh
         PEpCc++DnP1UG+3My9uK23dSLrGy9/QyipL9DulFfS5JaL9QIfkXumnT5Zeq0iXibwNR
         z9JwleEGRuxaN6dvQ9hUUBh96eK3BPcrkMfKRPp13rAIHt3RiiEe0GOzk7W7QCF5Re8Z
         2u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLhh20JqLGAcpH6U1jhAsEUSYpAbbInrMEqzw1cRWu0=;
        b=OYPivtq6BnPzP9UiAHAxZxQQglbKvZ9twC/oZ9Tih12YV4cBhju06rN0p76p2gMpST
         6/UwI/fWtGu4z67yoUGh5oeMbBUWmJ6gYz59SL8TJNTAjHQJfyDXSUMPVQdyXUeGWNG/
         ME0dnfv6+/+/e4jIHVfVnv0rlQZCxj9t+DJcq4NjLiMw0TfV32SI3pjFMK/7TdSFHrua
         Y4z32VTZIvj7w+50Nm1eM9iJwLVlFKaoplHyryGwjBNKgDVkW3Mnze1yx83d/S6GIh1b
         EBwhw6mPfICHaJ7NqnMRpa9M5jnbXn0Sy1HTD/i3z82Qf3bC0sb2086UpLnShp3NuU3q
         KHUg==
X-Gm-Message-State: AOAM531QboiA8NTvsgGfA2F2hzsyNh7nzgHXQHzpfjeTT7cctKd3OaBz
        eLrjQJeulyERx0oP8xTohSA=
X-Google-Smtp-Source: ABdhPJx+1/6BAOlvTAyqIbneFXpeOjcNaWOJn8/02XHXC+AnTEsmmHbIqhO+5ft4nSnIG2yTy6wLWQ==
X-Received: by 2002:a05:6830:1347:: with SMTP id r7mr5093385otq.203.1604006862028;
        Thu, 29 Oct 2020 14:27:42 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-5ec3-3713-23e4-7cdc.res6.spectrum.com. [2603:8081:140c:1a00:5ec3:3713:23e4:7cdc])
        by smtp.gmail.com with ESMTPSA id t65sm878844oib.50.2020.10.29.14.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 14:27:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: fix regression caused by recent patch
Date:   Thu, 29 Oct 2020 16:25:46 -0500
Message-Id: <20201029212545.6616-1-rpearson@hpe.com>
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

This patch gives dma_mask a valid value. Without this patch
rdma_rxe does not function at all.

Fixes: f959dcd6ddfd2 ("dma-direct: Fix potential NULL pointer dereference")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7652d53af2c1..116a234e92db 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1134,8 +1134,15 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	dev->node_type = RDMA_NODE_IB_CA;
 	dev->phys_port_cnt = 1;
 	dev->num_comp_vectors = num_possible_cpus();
+
+	/* rdma_rxe never does real DMA but does rely on
+	 * pinning user memory in MRs to avoid page faults
+	 * in responder and completer tasklets
+	 */
 	dev->dev.parent = rxe_dma_device(rxe);
+	dev->dev.dma_mask = DMA_BIT_MASK(64);
 	dev->local_dma_lkey = 0;
+
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
 	dev->dev.dma_parms = &rxe->dma_parms;
-- 
2.27.0

