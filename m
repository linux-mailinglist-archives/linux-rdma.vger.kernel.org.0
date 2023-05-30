Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0F4717081
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 00:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjE3WNz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 18:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjE3WNx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 18:13:53 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B647B93
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:51 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-55564892accso2567848eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685484831; x=1688076831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dz2nwIGxOzz+SVosFIWkmYlpgXcgM7vnvgGkGH9MErI=;
        b=V4EuvVkkgfyM2sF3eDJgYYq6LsJUl8qpG0edGEKSgn9jkUIYF/UkBi3iZWtg7V3Urb
         rgSugAKOhnWUCwb/ij5iaz5vBnrJjkiV6HjcpfTcpoMnvTJRPh5ZFaEp8NHszERAlTam
         A6dRPGcD3K3BQRDk95XRXrQWG/QGWDVJY+dxYs3Q54D5LhlQJ0XiyzX/aQ09asBsVRkt
         h8Dk+72T4ogHbn+7ZVx7OLSLnRynrD0HufDeOpzshq46/euyUw+gr/7i9gc7cFZx6mfs
         zOPUoh+Cy0vGu5BfumM/r31Amc1sxIldsWPPIaGqNguQ3yLDmeIOGu9FDK4euKSds1lh
         p5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685484831; x=1688076831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz2nwIGxOzz+SVosFIWkmYlpgXcgM7vnvgGkGH9MErI=;
        b=lQPPIJN/2UsuXR/60taLUjddWYbzSGgsP68wprVNVx4BtmnlETW/rIHpTvobTBnq7h
         7ly/mL9hc8B90yCvlExMLlngck7RB4RXZCnIO+CkpBirILk/K0U6cIfZTJ34i57NhWdV
         FYGlRdGWxax6HICLq79Lb8W992rC6/boZ2GN6tj9NCBlssMHBLI/eKCHV0Ls6XCOnHte
         jdZF4WB1BGy69iBAczZY64QnuOnSw12yZYse8m1+QCDmNSjFyEkO3jMtJ5P1+Ov3QrMw
         Ttz9/ShQ8L9IrpPfokKHHOnrEgNraBNGLpOLCaP+azE0WrXCAe61QGeQNmkwaw914WyU
         QnPw==
X-Gm-Message-State: AC+VfDy3buhIft+5KFn8VS6kJHyU3X+oWw4q/BrdC1/W56a2FX1W//1s
        RQgyZLLby3WLCxjv40HlrL2sVW1FewI=
X-Google-Smtp-Source: ACHHUZ5qYhs6ypjxi5XP7ZHBPhfqespySQ2AhqOMoVg80LBI1Yny6c8qECOrJ/lBpDaIo2Hbj6IElw==
X-Received: by 2002:a05:6808:181a:b0:398:45bf:6e65 with SMTP id bh26-20020a056808181a00b0039845bf6e65mr2118261oib.9.1685484831033;
        Tue, 30 May 2023 15:13:51 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-61e7-5a75-8a81-5bfc.res6.spectrum.com. [2603:8081:140c:1a00:61e7:5a75:8a81:5bfc])
        by smtp.gmail.com with ESMTPSA id r77-20020a4a3750000000b00541854ce607sm6156772oor.28.2023.05.30.15.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:13:50 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, edwards@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 2/6] rdma/rxe: Optimize send path in rxe_resp.c
Date:   Tue, 30 May 2023 17:13:31 -0500
Message-Id: <20230530221334.89432-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530221334.89432-1-rpearsonhpe@gmail.com>
References: <20230530221334.89432-1-rpearsonhpe@gmail.com>
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

Bypass calling check_rkey() in rxe_resp.c for non-rdma messages.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 +++
 drivers/infiniband/sw/rxe/rxe_resp.c   | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index cea4e0a63919..5686b691d6b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -91,6 +91,9 @@ enum rxe_hdr_mask {
 	RXE_READ_OR_ATOMIC_MASK	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
 	RXE_WRITE_OR_SEND_MASK	= (RXE_WRITE_MASK | RXE_SEND_MASK),
 	RXE_READ_OR_WRITE_MASK	= (RXE_READ_MASK | RXE_WRITE_MASK),
+	RXE_RDMA_OP_MASK	= (RXE_READ_MASK | RXE_WRITE_MASK |
+				   RXE_ATOMIC_WRITE_MASK | RXE_FLUSH_MASK |
+				   RXE_ATOMIC_MASK),
 };
 
 #define OPCODE_NONE		(-1)
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b92c41cdb620..07299205242e 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -387,7 +387,10 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
 		}
 	}
 
-	return RESPST_CHK_RKEY;
+	if (pkt->mask & RXE_RDMA_OP_MASK)
+		return RESPST_CHK_RKEY;
+	else
+		return RESPST_EXECUTE;
 }
 
 /* if the reth length field is zero we can assume nothing
@@ -434,6 +437,10 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access = 0;
 
+	/* parse RETH or ATMETH header for first/only packets
+	 * for va, length, rkey, etc. or use current value for
+	 * middle/last packets.
+	 */
 	if (pkt->mask & (RXE_READ_OR_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK)
 			qp_resp_from_reth(qp, pkt);
@@ -454,7 +461,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		qp_resp_from_atmeth(qp, pkt);
 		access = IB_ACCESS_REMOTE_ATOMIC;
 	} else {
-		return RESPST_EXECUTE;
+		/* shouldn't happen */
+		WARN_ON(1);
 	}
 
 	/* A zero-byte read or write op is not required to
-- 
2.39.2

