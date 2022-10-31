Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7001F613F07
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJaU3F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJaU2y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:54 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0153113DD7
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:52 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t62so3143892oib.12
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP+kS18ux1vXKk+clUeAUlAJBUbYbdRVWffzkGjI8i0=;
        b=kWme63R9Bnnw4FkhP/X2R0pS369JRfqmaZsOknu7a7OTnC2XKDFmyKK4NSaIbQaTl7
         B8E15sbmwoKR7ly3uvJLykKIMST5PT0PXNEMCinJQECgnWOTPxwN7icbVuCTK4J4NSWm
         fCz30vfRjPc75C2/JLZee2/NftiwaLjCFOCCKlUz8JZxpnrCCRZ+4Eifii9r1/qxISwV
         5aNmSvnDmLVABBqkFyrDIrASkV9AonjYR1B10CGnt2szJVgEvXO/GEDFqP61vlcajcGD
         17jqwJ40gHKNHEgvGDNy9YHqjlHOz4LZVBVtbmUY9wwIZ9+UWXFqcisG9QohCg6BcS49
         EQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fP+kS18ux1vXKk+clUeAUlAJBUbYbdRVWffzkGjI8i0=;
        b=hdiZELO7g2TgElYhNYKjUxJznwFigbyCnirgZbtkJlATtNExz/vSE7AKU/tc32MLEE
         8isaOjQHxGb/FEjTG8as2PNiT7BASb8VAL+37hnB+Oa0z4kZyKLPgGSHsmrpd88UT3YW
         or//5AFhDYPv44cmp+kR2J0L/SPN8Jmuu0OBkXCh0Oun1wDA6895XM87xe+6uzQudBOF
         DerD++GT9bIoWc1o73jI/hGUMOM0f6HiFRujGdLLHnKac2fl/wXhYg/jl593uUwT26gn
         yN+KpVtPBC6p8Ezw3t+oVod+24t3b6MlStIlxuK47njDNhyIa4Bo6A+77YrjGqIcANUp
         5Q1A==
X-Gm-Message-State: ACrzQf2gxWtw9OpRYM7NKA04MTwHIFC8FgaAjMxVWo0MnOAo1E5rcYVc
        F3jniAmaYulRNEMRJ2JLdqc=
X-Google-Smtp-Source: AMsMyM5LdbBTOem3dmLcvopm8hTINhtpUBq+Xu4WU9uMceDYbY7bmno7WgYoNth/8E15wKAJVKH2IQ==
X-Received: by 2002:a05:6808:1057:b0:359:ef57:46b4 with SMTP id c23-20020a056808105700b00359ef5746b4mr5821862oih.286.1667248131352;
        Mon, 31 Oct 2022 13:28:51 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:50 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 18/18] RDMA/rxe: Enable sg code in rxe
Date:   Mon, 31 Oct 2022 15:28:07 -0500
Message-Id: <20221031202805.19138-18-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031202805.19138-1-rpearsonhpe@gmail.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
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

Make changes to enable sg code in rxe.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c     | 2 +-
 drivers/infiniband/sw/rxe/rxe_req.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 388d8103ec20..fd5e916ecce9 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -14,7 +14,7 @@ MODULE_DESCRIPTION("Soft RDMA transport");
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* if true allow using fragmented skbs */
-bool rxe_use_sg;
+bool rxe_use_sg = true;
 
 /* free resources for a rxe device all objects created for this device must
  * have been destroyed
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 984e3e957aef..a3760a84aa5d 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -521,8 +521,8 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 	struct rxe_av *av;
 	struct rxe_ah *ah = NULL;
 	int pad;
+	bool frag;
 	int err = -EINVAL;
-	bool frag = false;
 
 	pkt->rxe = rxe;
 	pkt->opcode = opcode;
@@ -543,7 +543,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 						pad + RXE_ICRC_SIZE;
 
 	/* init skb */
-	skb = rxe_init_packet(qp, av, pkt, NULL);
+	skb = rxe_init_packet(qp, av, pkt, &frag);
 	if (unlikely(!skb))
 		goto err_out;
 
-- 
2.34.1

