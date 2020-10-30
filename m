Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB772A0D2D
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 19:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJ3SNz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 14:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3SNz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 14:13:55 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF17C0613D5
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 11:13:55 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id u5so1804096oot.0
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2VW0hcJ4C/nDavnDVRxLGevZyABxNoDvpwfaSSV5Xk=;
        b=N1CD6tSLVvEV1wpFtW78JRKYhbn+QxprRxcXLF2vgMtF3jaS7cAAyiU5FN5MNHGhw6
         oe3wGWAzMlJTgfbDqHd6ALuGq3LV0KlL/E2IPj7iTSigCWBOISteCo47aco1rGvr5XRu
         pg1eaO32sw8hVMLqBrlE/XLagfEG6WnGhhleUK8ieiXraXStSIwbkPhU/8jA/qfGYtkq
         ohgCqb1/YCEuFvhuMynmTWcSwulz7PBmzgh98XSyTiL7P42GFGIbRdPkqHnyCN+DuoXp
         hi2N5TkuGMZPs0JGOCRfleWmJLckZB6Ou9KaFGqdYhhIT/PVrYd77KUfcrRnF42kNqcn
         NxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2VW0hcJ4C/nDavnDVRxLGevZyABxNoDvpwfaSSV5Xk=;
        b=dQ/PiIzYyWrjrU0x6SqNyrV0MNCZh87Qg6lHIBlJZM8NitHD43UjIQURjJZeyKzLUv
         8n65+4DY5ROqNUQxWkAkVr+BOeRhaxGBLYPVPgR1TrxMXTnypdRMgvR4hLyEkNaPZsH7
         UUZ2Kt9GAcuICW1NBzxgwv+tFdZVmBTdJ9G8rtDMnHnI4LZeg4dGandHrmsE5h3uSYjx
         zA/87Z4vjLoy8412yKSJuQcUTS7cHxn9v9uRuOKGzAUHpF5d1MOZOidv8IVDiSfWCytA
         6z3P3B9CogPhYReIVDkH7h4CiH0qa2wMFh0kUEHhKhiFJssF6qpmbe2O4j3CF7zJn6h7
         SNKA==
X-Gm-Message-State: AOAM530tJ44NTse1XDiVtousQzwdVUB/d9UbdEZEjAu0CSvTCyBvbE18
        vSPywX/GFvsDfd4uLWlBOkI=
X-Google-Smtp-Source: ABdhPJxONq1rpyURE4pe43MBUV0CV7rEm4gxYqChhzAqcMrcsWbK29O+azovJKgmw23CwJe8ypVkwQ==
X-Received: by 2002:a4a:41cc:: with SMTP id x195mr2896729ooa.48.1604081634503;
        Fri, 30 Oct 2020 11:13:54 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9ab5-99a7-d140-ecf9.res6.spectrum.com. [2603:8081:140c:1a00:9ab5:99a7:d140:ecf9])
        by smtp.gmail.com with ESMTPSA id t5sm1552257oth.16.2020.10.30.11.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:13:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, parav@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3] RDMA/rxe: fix regression caused by recent patch
Date:   Fri, 30 Oct 2020 13:13:51 -0500
Message-Id: <20201030181351.6630-1-rpearson@hpe.com>
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

This patch gives dma_mask a valid value.  It also removes unnecessary
logic which was setting dev->parent. It is equivalent to the patch
submitted by Parav Pandit.

Fixes: f959dcd6ddfd2 ("dma-direct: Fix potential NULL pointer dereference")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 -
 drivers/infiniband/sw/rxe/rxe_net.c   | 12 ------------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 ++++++++--
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0d758760b9ae..8adcef54e4b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -116,7 +116,6 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
-struct device *rxe_dma_device(struct rxe_dev *rxe);
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 575e1a4ec821..2b4238cdeab9 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -20,18 +20,6 @@
 
 static struct rxe_recv_sockets recv_sockets;
 
-struct device *rxe_dma_device(struct rxe_dev *rxe)
-{
-	struct net_device *ndev;
-
-	ndev = rxe->ndev;
-
-	if (is_vlan_dev(ndev))
-		ndev = vlan_dev_real_dev(ndev);
-
-	return ndev->dev.parent;
-}
-
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	int err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7652d53af2c1..6afbb507ddb1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1128,19 +1128,25 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
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
+	dma_mask = IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64)
+					    : DMA_BIT_MASK(32);
+	err = dma_coerce_mask_and_coherent(&dev->dev, dma_mask);
+	if (err) {
+		pr_warn("unable to set dma_mask, err = %d\n", err);
+		return err;
+	}
 
 	dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
 
-- 
2.27.0

