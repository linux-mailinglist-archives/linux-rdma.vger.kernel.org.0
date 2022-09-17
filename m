Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3D5BB5C1
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIQDKw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIQDKu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:10:50 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C324DF01
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:48 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso16101944otb.6
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ozTLBWu+OgVpUPFoK0XaDtZgeXfSbSLcsDTataCzAd4=;
        b=BeKDYMerdLVYIZkUKSunMmzkwQ6d2ee6nUWQCzKyEkFFYw4alxs2DcH76yVaoPaWuy
         G4V5XJ/zH2B6lfrmbWGWHGv9si/8N9HxEfm1jOfHJyNgdRKtXas1sbeh1XqBb7hximu+
         K1yP0EZM6IFOvj1ZZi1dtHFdqTkjCc/PpADkhHDQ6NeVq4x2lvSCx1r7W9F/2zew5+9E
         AIRmLT14sv58ElyVoT7H45TyiKe8j664yLF5DQay7eJDNEDv1jAgb8U43RJs8Wvhw+3r
         Fjb89QmGIVJlJQBvB4rOUvXCSVflt3SuKZeJPi22cMRzLwCc4/DCAiq3l4BF30JS+pp/
         cXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ozTLBWu+OgVpUPFoK0XaDtZgeXfSbSLcsDTataCzAd4=;
        b=18fBwOm7Hy1qEE/TbEWfwRjBbyl6ZbisDnk5bcixCPwU+Tdu+E2YCLF6n2Fx8bq/j5
         K3yEmUCX1HG2RT+pGYY2bhTVmbKzjZEhRjf2P1vCg/64akuvSogqPxTTkKRbRxDOrcrl
         K0UyQij11kyWoga797Ts1WTMOsgjQ3j+nmJNWA8KCvO3g4eTN0scBvy80A3qQ1xJ+AV1
         VDIfPXszHYXVK234XV9RdLGfqIu/DJVZ2RmeEBIqhqnMFLoKz4zBrvnXxUfIfC9MCVuh
         7msJyhw58yf/X4AAK99McfTl0Nn6WAqsUCETz1OrT9BmyK2pnyMt1powDjE2eI5W6dSZ
         fNNA==
X-Gm-Message-State: ACrzQf0OK3jd4BbX0BLRP5/6qqneMKliijylaGkyfYXOqNzb154UuZfn
        p89muRqP/K9ypeGfMiWGWmQ=
X-Google-Smtp-Source: AMsMyM5SgkYK047+KvZnT/Yx7BXOGPTVAx1NYfHU0L96d0Lfd/UQlIOoGOTHYbrBQfVOO9oiNx05jA==
X-Received: by 2002:a05:6830:90b:b0:659:4fe0:7ab6 with SMTP id v11-20020a056830090b00b006594fe07ab6mr3530682ott.385.1663384247790;
        Fri, 16 Sep 2022 20:10:47 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm4464800oab.3.2022.09.16.20.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:10:47 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 05/13] RDMA/rxe: Add xrc opcodes to next_opcode()
Date:   Fri, 16 Sep 2022 22:10:24 -0500
Message-Id: <20220917031028.21187-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031028.21187-1-rpearsonhpe@gmail.com>
References: <20220917031028.21187-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend next_opcode() to support xrc operations.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 4ae926a37ef8..c2bac0ce444a 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -1376,6 +1376,91 @@ static int next_opcode_uc(struct rxe_qp *qp, u32 opcode, int fits)
 	return -EINVAL;
 }
 
+static int next_opcode_xrc(struct rxe_qp *qp, u32 wr_opcode, int fits)
+{
+	switch (wr_opcode) {
+	case IB_WR_RDMA_WRITE:
+		if (qp->req.opcode == IB_OPCODE_XRC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_XRC_RDMA_WRITE_LAST :
+				IB_OPCODE_XRC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_XRC_RDMA_WRITE_ONLY :
+				IB_OPCODE_XRC_RDMA_WRITE_FIRST;
+
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_XRC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_XRC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_XRC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_XRC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_XRC_RDMA_WRITE_FIRST;
+
+	case IB_WR_SEND:
+		if (qp->req.opcode == IB_OPCODE_XRC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_XRC_SEND_LAST :
+				IB_OPCODE_XRC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_XRC_SEND_ONLY :
+				IB_OPCODE_XRC_SEND_FIRST;
+
+	case IB_WR_SEND_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_XRC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_XRC_SEND_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_XRC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_XRC_SEND_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_XRC_SEND_FIRST;
+
+	case IB_WR_RDMA_READ:
+		return IB_OPCODE_XRC_RDMA_READ_REQUEST;
+
+	case IB_WR_RDMA_READ_WITH_INV:
+		return IB_OPCODE_XRC_RDMA_READ_REQUEST;
+
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+		return IB_OPCODE_XRC_COMPARE_SWAP;
+
+	case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
+		return -EOPNOTSUPP;
+
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		return IB_OPCODE_XRC_FETCH_ADD;
+
+	case IB_WR_MASKED_ATOMIC_FETCH_AND_ADD:
+		return -EOPNOTSUPP;
+
+	case IB_WR_SEND_WITH_INV:
+		if (qp->req.opcode == IB_OPCODE_XRC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_XRC_SEND_LAST_WITH_INVALIDATE :
+				IB_OPCODE_XRC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_XRC_SEND_ONLY_WITH_INVALIDATE :
+				IB_OPCODE_XRC_SEND_FIRST;
+
+	case IB_WR_LOCAL_INV:
+	case IB_WR_REG_MR:
+	case IB_WR_BIND_MW:
+		return wr_opcode;
+	}
+
+	return -EINVAL;
+}
+
 int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe, u32 opcode)
 {
 	int fits = (wqe->dma.resid <= qp->mtu);
@@ -1387,6 +1472,9 @@ int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe, u32 opcode)
 	case IB_QPT_UC:
 		return next_opcode_uc(qp, opcode, fits);
 
+	case IB_QPT_XRC_INI:
+		return next_opcode_xrc(qp, opcode, fits);
+
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
 		switch (opcode) {
-- 
2.34.1

