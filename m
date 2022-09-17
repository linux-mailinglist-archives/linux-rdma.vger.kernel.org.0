Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D635BB5D0
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIQDL4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIQDLT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:19 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC18C03C
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:12 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x23-20020a056830409700b00655c6dace73so13827621ott.11
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ozTLBWu+OgVpUPFoK0XaDtZgeXfSbSLcsDTataCzAd4=;
        b=aUvHwte3LuQf8lkJhhaoqSwrmPjDN7La6QqnDNdVJfOY85GCbdYvx9sD5FHRG3JkQV
         2NemwePx+r4Mjj+WIHuW6nbATa/jOUdf2EItzpO7OzyJQAOzHL7CNTZOo+uDShLpj/Ip
         P46AQnjFDJTExUBS1e/uVDzfarw8/O8IAM9QuZ0U9u8jdsrEPET6hdY1KJKOK0D1WKhq
         tK3k+i2HmFFmaZFc96zvtQm1pqsuaPd/BO+m9lpfs38Jk4nImiqAm/pfnn4Q63mFCbMK
         4knWBV0PLo0rxGbS3LuyvVaHq7FJsaciA12xX6GEv120yGQjSfyVlg/SV7tS5KtRSP4Z
         4Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ozTLBWu+OgVpUPFoK0XaDtZgeXfSbSLcsDTataCzAd4=;
        b=KbQDVTe7y6/wAQ2VXUExM4yUX3WNmZqwHlqQG63rSldGfVz61EGLSFVhMNN+0+eKDe
         cT+bHlCXarjUBdj2qm51yd2+/LrM4+P4oHaS11vvAWXnR+VoIpI4qBjgN2NOPiSAi+4L
         HdFs7r+qhvaBUnF87sayXVX3Y3EcqX8Ot/z7uCOPezZUfir5iaHHWujr7Mh6KeCrM9XV
         auckR0TK0HikdxH2ucTfTuJTKoO6vw2yh4z8SL7w6idPxFvGAHew2S2UpHK2uY6mXIFb
         IyYBzaXEUYYt/oSecisHqnPqZE4GBLtwv4q/xlOM2TtnWl2f08HrOQcym72O8TLYamf4
         wdaA==
X-Gm-Message-State: ACrzQf21POHI/yysoa5FM+WaasdGhAu7rAxBnL0kv/bxNmYFHjvi7opA
        N8audwSgz6V7TF5vn4sHRFXUBtk84ro=
X-Google-Smtp-Source: AMsMyM7UxRjA+ap2RHCI1ukO3wGVTj7VwA1Zv/bNOPaCcOwmq8OGDgBrzhv/pAROQXcCTc6oQ2YFPA==
X-Received: by 2002:a05:6830:6303:b0:659:f2cc:1508 with SMTP id cg3-20020a056830630300b00659f2cc1508mr119488otb.126.1663384272436;
        Fri, 16 Sep 2022 20:11:12 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 05/13] RDMA/rxe: Add xrc opcodes to next_opcode()
Date:   Fri, 16 Sep 2022 22:10:56 -0500
Message-Id: <20220917031104.21222-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
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

