Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAAA5EFBA2
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiI2RJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiI2RJN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:13 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43611CE91B
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:11 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso530329ooo.12
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ozTLBWu+OgVpUPFoK0XaDtZgeXfSbSLcsDTataCzAd4=;
        b=jRt+TNiRkUfaNbKnPLGRKwzHIcDEiRvqit1UYZn/pAzo+YdsnwFgoLt+holU5pdZJh
         dD5xZoGChjNwIDYd3FG8xUFWEgDyFS7W89RP2Xql3QuwxlTNy+2KSPMGqkr7DXuRBaHA
         i2OtwP8bOmQpR897REyv2BaBO+6FEBJ7ljefRbZnzWcaX62oKmPmYrcewmen4C9BbBEE
         Vh4SS7njXhOdJ3eOGcJwgUFKTFdTk6S9HUkgvGDMS8wm1k3EBWnPeSXgmvVbpZvXnfeQ
         XG1QxMTD7DxOpCPKEd2FrUpypWD5WAtFrKM6WS+yRAU2WcnXDUOUUXSTASJtCUWB/U7P
         fzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ozTLBWu+OgVpUPFoK0XaDtZgeXfSbSLcsDTataCzAd4=;
        b=qs1AGWoah72qwG8rv8fWtz5bHW1/5CylE/1Bl4XL1Sr2cEHHEEkjAUDRlE754Nuj4b
         E3w1gOeqBvy+XYWHW3mSULq04UP36acGRESx95/+XjjFkLlBvTJg7fNkrZG4zDx1Siwn
         YhxjHF591U9XS+42/SGwglp13eQhTWxIXGZ/vzZlfXnQUFIYZaAdE2zGMx08vTi8ikRv
         a1+WdeHUvr4Q1U2pVKwWqLJ+oycHb1t7ekQZ+rrJCj5f7oRqUQo7W7mMZXy3OSsb7YRF
         x4xpaVkSR4pAzGSHLD79/Bn9BLb+lVlEFJN0nIBlqG8kXdnReJdP9kTrVsuj4DMSbB4C
         IDgw==
X-Gm-Message-State: ACrzQf0XsnrVOljbGVL3cWzU0ubiovc7eOpW4iEmWReNDzcIiBKPKwAu
        ivqQfjyVABjKp7KLm4r60lT58Efkv8wV6A==
X-Google-Smtp-Source: AMsMyM6PXlEJwNh+U0HsUJ5x2myO/kXOiZeDawOjB23FMui8JlgVTJFxfa6W4zYtyC6yq8B77PduWQ==
X-Received: by 2002:a4a:d6ce:0:b0:476:7f74:26ff with SMTP id j14-20020a4ad6ce000000b004767f7426ffmr1772769oot.32.1664471351138;
        Thu, 29 Sep 2022 10:09:11 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 05/13] RDMA/rxe: Add xrc opcodes to next_opcode()
Date:   Thu, 29 Sep 2022 12:08:29 -0500
Message-Id: <20220929170836.17838-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929170836.17838-1-rpearsonhpe@gmail.com>
References: <20220929170836.17838-1-rpearsonhpe@gmail.com>
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

