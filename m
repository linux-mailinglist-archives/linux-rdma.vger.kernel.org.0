Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0173D9E5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jun 2023 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFZIfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jun 2023 04:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjFZIfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jun 2023 04:35:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196181A1;
        Mon, 26 Jun 2023 01:35:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so3919092e87.1;
        Mon, 26 Jun 2023 01:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687768537; x=1690360537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9MrkiBWSdaWnAC9L6QYTchQNu8YBLbIyeAdR6NesYXo=;
        b=A1D2/vWRDY0gMh6FvrQ/M1SacXwWHuWn5MtFitZFegdbFsD7Z05rQUNRB+Wf2F+rEO
         chpNmQJrFda+TvtWyxrvyveWbrTzqZhqxA3a1S85tOdOFK+3A9okAvp9gJNr5KwV9P6g
         nx4GpH/k+9sHrbqIyiXTkeTMAiqex/A+fqNo2v5F7VlPnERnHoiqgLI6VB3WRUs9OyJ1
         /u+fQMqLcMTNAl1aaVqh67pBNEtS191lzZRSdWFlwkTRaYZ9TduEIKnRj7sP5wM5dBVn
         WHWhcZFdB0vWykQYBMe62vezSjo4BCTMKiU6b4zUUJMIg48tkNjIXr9fakDk/35KD7Ts
         Cgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687768537; x=1690360537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MrkiBWSdaWnAC9L6QYTchQNu8YBLbIyeAdR6NesYXo=;
        b=l596NYOErtI8PmO6XkDh5loRr+dxO0AoIbUj/4VG0tPN0C1PHTs//X2mDwg5LXWVoo
         QtsdEor1u54VXbhf/hT4SxEkSD5Tadp2gGyYrtojirpYpQjKtIx2n8YZQO8BhpyC0EDU
         E9S8uwROykxZ9Je/8Nc8cqizI5Q0oBFpO1yjDYMVlFMvkuPulVk30TSaZCft+X1j4B8m
         Ai8YCA7nRlQH/4a0DhIDsDUur7QGHkFjMn0rkcKR6RzJ+989Fci0OGEqKzyromu4o1sE
         UJXydTqchcEZ04pWJfUbUi55LOmPdicbVYMyRG2c8dCGSoSDDm/oPRCPcoLVGBq8ys1y
         oJrg==
X-Gm-Message-State: AC+VfDw02PclytRzOyG1lBRjbcVe+/JTBY0nSVrDnHptjsA8fkDDsYYC
        05GAWCpLEHiT0dUqBzL0Xok=
X-Google-Smtp-Source: ACHHUZ7otToh0hZinYK6A1vqz6otwhOcWbjMm0WVFh/Ap36znKkk8PbS+LM0n63exa5Agz6TvLTO6w==
X-Received: by 2002:a05:6512:3414:b0:4f9:cd02:4af1 with SMTP id i20-20020a056512341400b004f9cd024af1mr2777347lfr.34.1687768536987;
        Mon, 26 Jun 2023 01:35:36 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b00307a86a4bcesm6667577wrz.35.2023.06.26.01.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 01:35:36 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/bnxt_re: Fix spelling mistake "priviledged" -> "privileged"
Date:   Mon, 26 Jun 2023 09:35:35 +0100
Message-Id: <20230626083535.53303-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a comment and in a dev_err error message.
Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 1c6c6c0bcf52..5fd8f7c90bb0 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -726,7 +726,7 @@ int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 
 	switch (type) {
 	case BNXT_QPLIB_DPI_TYPE_KERNEL:
-		/* priviledged dbr was already mapped just initialize it. */
+		/* privileged dbr was already mapped just initialize it. */
 		dpi->umdbr = dpit->ucreg.bar_base +
 			     dpit->ucreg.offset + bit_num * PAGE_SIZE;
 		dpi->dbr = dpit->priv_db;
@@ -932,7 +932,7 @@ int bnxt_qplib_map_db_bar(struct bnxt_qplib_res *res)
 	}
 	ucreg->bar_reg = ioremap(ucreg->bar_base, ucreg->len);
 	if (!ucreg->bar_reg) {
-		dev_err(&res->pdev->dev, "priviledged dpi map failed!");
+		dev_err(&res->pdev->dev, "privileged dpi map failed!");
 		return -ENOMEM;
 	}
 
-- 
2.39.2

