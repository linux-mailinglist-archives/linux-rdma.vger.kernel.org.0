Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9128DD6F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Oct 2020 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgJNJY2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Oct 2020 05:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730819AbgJNJUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Oct 2020 05:20:11 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF675C00458B
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 18:35:18 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id w25so376964oos.10
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 18:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21oGAexv+KooXGYt4Wcrp9KOCSMG4QsemmYMz5bOURw=;
        b=daaW88tihKNyAH5gi78rlD5ZwTyxt5ssQfG1tTAGu3EHWGpZ/qAJ5rM9Pw2KgmGtDe
         cbrTcXwuLPHIIxi/wgd6ucrLsiT5kTRFyhHqMuxhCQ0RrwaNj3Te0dPdz8P061YVz3l8
         7cvVMelZd0xaWL0S2H5K9TJhOurTC51CwE0jmHOk37AdQRezzC0ma3fOaB3emg/z+v7G
         e9UzgW+5l1YylBEkfvAXvloTtmyCI/7JShfHrfMSl2sr73As6nKMQTGmSmXZ7cUokwXH
         jkVC+EVWgqqeCAnMAM56np/iPKS7pHe0LkZyi2eCmCCph7iPif8h2y1Sq2DpO/WPWc0I
         /Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21oGAexv+KooXGYt4Wcrp9KOCSMG4QsemmYMz5bOURw=;
        b=g5TJYx6F+uWP6QHMaT38sjyfDVmZD9HBudtCzmkZdszgTIU+SDTZh7zaXL1ggs53c1
         3SWw6f9Vkd92vdhIaXDOLf3Vf5qNwZP14hdLY5f3BrA7B9fdMdaVRmwPKx+d1u88AFUe
         Scg5az77XEJb+NdGHqFwnVZvKzCbO8pRdTTvzxpw2ZmTe9eOlNY8R1EQuKmuRywrsj20
         mjm3h+/4Tbj03u5xErBLnoweU547kMLjdeRRC2RyJWn3F3HZXloz3d6gj5/lpfINPWyZ
         H6x3qRCMvE4VjzQ/OvM2rZQ99g6VB3X6HYTxh/W5WI4HKlasp+t85jGV3y00QtsCaoCX
         Aggw==
X-Gm-Message-State: AOAM533FSHmEiegfFDM/HFqrmPAmanHqlhwz6ka7PoGkkPZkoi7LRMgh
        XK9c/lRVomGssV7Rnaynrfg=
X-Google-Smtp-Source: ABdhPJwtV1bNXgNEGZqGOM9lRAkPD9m8Yv6KqfnqxYUO/tcy7XRjp7bukfEPZau5e/Zb9J30fhIhAg==
X-Received: by 2002:a4a:4592:: with SMTP id y140mr1625023ooa.5.1602639318207;
        Tue, 13 Oct 2020 18:35:18 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-97f4-eab9-6f0e-197f.res6.spectrum.com. [2603:8081:140c:1a00:97f4:eab9:6f0e:197f])
        by smtp.gmail.com with ESMTPSA id l3sm661529oth.36.2020.10.13.18.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 18:35:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Set max_seg_size to a valid value
Date:   Tue, 13 Oct 2020 20:33:42 -0500
Message-Id: <20201014013341.3452-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With the recent change to __sg_alloc_table_from_page the old value
for max_seg_size is no longer valid.

Change to a new parameter RXE_MAX_SEG_SIZE wich is set to 1G.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 25ab50d9b7c2..03893d5634c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -36,6 +36,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
 /* default/initial rxe device parameter settings */
 enum rxe_device_param {
 	RXE_MAX_MR_SIZE			= -1ull,
+	RXE_MAX_SEG_SIZE		= SZ_1G,
 	RXE_PAGE_SIZE_CAP		= 0xfffff000,
 	RXE_MAX_QP			= 0x10000,
 	RXE_MAX_QP_WR			= 0x4000,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index d487ccd7f8b9..0a7d7c55d8d6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1129,7 +1129,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
 	dev->dev.dma_parms = &rxe->dma_parms;
-	dma_set_max_seg_size(&dev->dev, UINT_MAX);
+	dma_set_max_seg_size(&dev->dev, RXE_MAX_SEG_SIZE);
 	dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
 
 	dev->uverbs_cmd_mask = BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)
-- 
2.25.1

