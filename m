Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B9250347B
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Apr 2022 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiDPGhF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 16 Apr 2022 02:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDPGhF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 16 Apr 2022 02:37:05 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59A4FCBE8
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 23:34:33 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id q189so10091211oia.9
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIGhQCXJDK11kpUfCuGP4lZthQ+FuAV/cYfZfOF2x4o=;
        b=bVqnSKbctsbWAxb/O66lyb2YygU4jgErZXWwtPlYQcAhFzYzo5BDaIh53NWZzXfVZu
         rEDDEqhJKZQ44xbfmePsSKpzko1nCtI3VhhpUormocLz+cvEzp1/xjPcP0sLJ88d8nSD
         ZgGxH9ghLVg7LnWuTtSFnKpZZCN4Pw4TXJ5of/STO82RjznHiO+JMp10BeYMuY2hrWGh
         /ZNEUlK4cEfyG/QkDYxFx8YbMES6g1iTKYiL1JgaZPzhBUt7Q0ZRASREA/ihgOb4UbLI
         /U6sP6IoCjhkBIdCZCkX5t/DVSfMYvDHkqxbDrPMEbU0KyYKU/kT2Q+NPF+QUTVexhmf
         TTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIGhQCXJDK11kpUfCuGP4lZthQ+FuAV/cYfZfOF2x4o=;
        b=uaABPzNmzvFDhCf4kW+aCZBA4/SaJwcysulERFRkzeMQYXUjKH0b+66KenyVFrCZCy
         tfPNDu3bMaNpnkEe7liK3xn7uXzXUo2OSroyaedBhny51nFux5I24fxsvDzfSzANYT20
         LhQ+eJ0y2+yN2chuM8mZm93gbF3MM3z1UJuL5RDtqamoU22scC8G6JLGT0Z1BMjmmLk+
         XRoFvtUTDRpEHT4xnnWX0nlNvinEYSnAcT1TDfoXyhyMI5iOuNRc2LIK94KKFWoaC08S
         bsMO1Aryoi1IBx+/NVdEQTuTq2Nd4jgp9YmThgigBf6W2n7lIZXyMJpm5mDEI0XGI0as
         ElLA==
X-Gm-Message-State: AOAM5314RHJk2DRD1NOYFG49I3unJm4GaSqj9oGQO5RECt8+fshLImK6
        0ZUrTu0JKDEycRsOZRZ8QePq65iXox8=
X-Google-Smtp-Source: ABdhPJxQevmt1otwWuRQjNGNLoqhXxe0afwcf74KV7fMVyLJjO0sil15xOHrHpp0owaPE32gTStvFQ==
X-Received: by 2002:aca:2818:0:b0:322:3bd7:66f1 with SMTP id 24-20020aca2818000000b003223bd766f1mr1025778oix.38.1650090872991;
        Fri, 15 Apr 2022 23:34:32 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-0663-b630-41ee-9f7d.res6.spectrum.com. [2603:8081:140c:1a00:663:b630:41ee:9f7d])
        by smtp.googlemail.com with ESMTPSA id s6-20020a4ae546000000b0032480834193sm1897685oot.46.2022.04.15.23.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 23:34:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] Subject: [PATCH for-next] RDMA/rxe: Fix "Soft RoCE Driver"
Date:   Sat, 16 Apr 2022 01:33:13 -0500
Message-Id: <20220416063312.7777-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rping benchmark fails on long runs. The root cause of this
failure has been traced to a failure to compute a nonzero value of mr
in rare situations.

Fix this failure by correctly handling the computation of mr in
read_reply() in rxe_resp.c in the replay flow.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e2653a8721fe..2e627685e804 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -734,8 +734,14 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	}
 
 	if (res->state == rdatm_res_state_new) {
-		mr = qp->resp.mr;
-		qp->resp.mr = NULL;
+		if (!res->replay) {
+			mr = qp->resp.mr;
+			qp->resp.mr = NULL;
+		} else {
+			mr = rxe_recheck_mr(qp, res->read.rkey);
+			if (!mr)
+				return RESPST_ERR_RKEY_VIOLATION;
+		}
 
 		if (res->read.resid <= mtu)
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY;

base-commit: 98c8026331ceabe1df579940b81eec75eb49cdd9
-- 
2.32.0

