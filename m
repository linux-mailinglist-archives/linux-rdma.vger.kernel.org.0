Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758486A3F0F
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Feb 2023 11:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjB0KC1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Feb 2023 05:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjB0KCS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Feb 2023 05:02:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB41E5E0;
        Mon, 27 Feb 2023 02:02:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so9587630pjh.0;
        Mon, 27 Feb 2023 02:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGw69Ao6qloJzQpM7a4rbzig7UZL4E2CNk5RXvvJ2jI=;
        b=Hp8kOKNrjUZqrU5VJ0fFDZCvgyyiIPkE98pdsTYM1uI0KDV57EX3ePMyMG2KgY0ExQ
         ke11LwPJqZdfZyuTX6ZM3gVGwSb4aXCgtG8Tk3IsaZ/sYCk4dTETWd7YKj3e+JbwgYwE
         naUKqLMvKr+En5KtKQFxRgAQFwVPnA00HdKe1mr7/JVI4pW+eeKXQL5rD0fVW+sWczO4
         ojEYh97F+0q2QNaYK1NLfPIHsAVdlkg5GyOnlBA+lAs8G72BJNIDIPXomrDn7Ms81MW9
         KkBkq00aMctduW6sTY8LwqquOxUQUEN8vRmxvbjBbszrDPtDlDutsMUoOPf28EHVbmVE
         0Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGw69Ao6qloJzQpM7a4rbzig7UZL4E2CNk5RXvvJ2jI=;
        b=sC+Yg/KrMcFTB06F5RFT8pI0QcM2tAEDUmj0xJmO2BeUVHSvcgqG85Rt8pw8O1ZYgm
         gJw+iSZlfoW9kmTbbVPFVpQChbGgBTntAiayZ2soMAD4fh1p/rLxw+y+GP9G8dvb9YE0
         pYrH0yzDNkbN72qMKxgsIKiRXEErnjTmuNwykBi07lEXPC3DNOELvmtQZ6g2nRlBfNr9
         peqAGbx+rV1KYXYczvOfEqOmhE721hR8k0B8Ma30mhPUfRnjWoQysh1Ae3wZGgoBHLs9
         FX4jzFTNyXUqmQSpnppfh+z/4kOCBI1IQNk9a5KaHK/hE2T4+FlknWjK2d3Mic0XRpAP
         j+iQ==
X-Gm-Message-State: AO0yUKWbqe4K8YWRjVVR2z6aUtaeMBwUw0O/E1lgq9/awYpQBVWhqEWb
        jVawEgMAtRgRqrp9OMpMKq0=
X-Google-Smtp-Source: AK7set+sLOgHWnH64zsnuiCcCyu5wJj8x4YqQj0iIRUKLf8hauwN0zboyMiZbUsyhw8NJLROZ0DsZg==
X-Received: by 2002:a17:902:e851:b0:19a:839f:435 with SMTP id t17-20020a170902e85100b0019a839f0435mr8148392plg.3.1677492137344;
        Mon, 27 Feb 2023 02:02:17 -0800 (PST)
Received: from localhost.localdomain ([103.116.245.58])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902780500b0019a8530c063sm4175562pll.102.2023.02.27.02.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:02:16 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     dennis.dalessandro@cornelisnetworks.com
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] IB/hifi1: add a null check of kzalloc_node in hfi1_ipoib_txreq_init
Date:   Mon, 27 Feb 2023 18:02:12 +0800
Message-Id: <20230227100212.910820-1-void0red@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kang Chen <void0red@gmail.com>

kzalloc_node may fails, check it and do the cleanup.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 5d9a7b09c..349eb4139 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -737,10 +737,13 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 		txq->tx_ring.shift = ilog2(tx_item_size);
 		txq->tx_ring.avail = hfi1_ipoib_ring_hwat(txq);
 		tx_ring = &txq->tx_ring;
-		for (j = 0; j < tx_ring_size; j++)
+		for (j = 0; j < tx_ring_size; j++) {
 			hfi1_txreq_from_idx(tx_ring, j)->sdma_hdr =
 				kzalloc_node(sizeof(*tx->sdma_hdr),
 					     GFP_KERNEL, priv->dd->node);
+			if (!hfi1_txreq_from_idx(tx_ring, j)->sdma_hdr)
+				goto free_txqs;
+		}
 
 		netif_napi_add_tx(dev, &txq->napi, hfi1_ipoib_poll_tx_ring);
 	}
-- 
2.34.1

