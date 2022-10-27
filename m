Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CFC6100DC
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiJ0S4l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbiJ0S4e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:34 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B450120B2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:31 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l5so3390979oif.7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHGXOAOhbEcwRQzY0mcWLUvYuFLqS/3dakiHV4dZphs=;
        b=OgCoTdRtchxhiwUkTc6P6SMQVXWD2wF30F35OikqTxhP6qcKI7ukNFOu/kadpYqJKG
         2vFRuD5hwl8hSyJBHBF4djfLYzqDGAFGga4juWzhUGvPgJ21taTMWyR/ErlWFPsuAP9w
         iHXcNLVS9AiTcPOi1IKRCAJmAFMrfPXvKx27975xSNcRVtMKgSWhEQeZ7R7t+0f9R1nx
         s+beVNt+PsGCqHAUR3gEfsagM8w63E7UZebJ/tYeQpyFLO2JwUivQ/boSRw4Xm4s1Gkf
         ueHFBPRe51+X83MEn3PmeewMC+sdodQWOCxosTnE0U9tyhDTe8zMizeBYI5jQ7vwojO0
         O8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHGXOAOhbEcwRQzY0mcWLUvYuFLqS/3dakiHV4dZphs=;
        b=qpA9tEufwHgLTVmm4r8OqpcqilT/Cla1LeniLhZr198K4Fl2uFmVLLP/cNgjDT/uLB
         D2kIC8oWOffyozCMS5efgWWvKvFr29vAlpQxTDGFo0N/fPiolwhzyi3qLgLdCVnNeRHw
         QiJbc6J3lP6+4s4hk/xHSBBr+nAs4OEFnVw3AuQ6hOcoIy+K6x2KMYE+GsBflIa6P7ia
         HjfM10Fnm4fcD+AbHoCkaUtLwJLwfw18x8JJoUUmMflOfmjAW2CwI+0fpAzeJJMFaTGV
         Z41XpllS7gjzWNXBAA/r8vfBGwQPvm3s4ACtJR+YIejiA1I06s3ghdheHK64pbSjzuQ5
         zXsw==
X-Gm-Message-State: ACrzQf0OhpIATUHBW1jKhbDkQYULXGn0jBl734Lbb7AZR2S1CoJJdOKM
        mcSp0/xWVfFlrxHfmo0Xv6A=
X-Google-Smtp-Source: AMsMyM6rzoUkAdHrNyKUTAdrZ23Waqa4ZEEh76uvkI9Dtu8uIbiamhs4pMW3Pxhm5eoM9bX4b20vuw==
X-Received: by 2002:a05:6808:1408:b0:355:77b:b78c with SMTP id w8-20020a056808140800b00355077bb78cmr5478853oiv.169.1666896990548;
        Thu, 27 Oct 2022 11:56:30 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:30 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 17/17] RDMA/rxe: Enable sg code in rxe
Date:   Thu, 27 Oct 2022 13:55:11 -0500
Message-Id: <20221027185510.33808-18-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027185510.33808-1-rpearsonhpe@gmail.com>
References: <20221027185510.33808-1-rpearsonhpe@gmail.com>
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
index ea9ab63a2dc1..758346977da3 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -521,8 +521,8 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 	struct rxe_av *av;
 	struct rxe_ah *ah;
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

