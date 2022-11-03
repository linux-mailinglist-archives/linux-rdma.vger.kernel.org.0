Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645376185E0
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiKCRLr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKCRKv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:51 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60072DD2
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:50 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-12c8312131fso2897692fac.4
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9KN+nsy/jNz2u8oyOp3fs+Pd0Y5afz/sRJ9THx9gMw=;
        b=RXAV4wTqDMrmaWfD8eAUqUpLTkVv/HPjfP3y8iq/NJIJEVVWTZ0NrFBXio77tRuo9K
         yDWqsvlhwnsrw6Q0A0QIQKPOKmm9EvmYtzTU1bgX6KGmziK7HzLBlxNVBAWgPiApjVrp
         h1WkVkRLTMIJmnXtrf6IbYcjETFWVSWGiZuhnNf0Aq/iDKsKizJw7h2CAKdSrFazJnie
         2v0HZ1GektQO2IYR8PtcZJB0MtQSGjKh23hy5mgXhBgavxF4ina0EF26PgCrQy52+rb9
         I4esyJSPG60fk1jEB5X7/i4Aj4iYDRakfYYEaihsUDMpynLgidCJHvbxESzA+ac/5kFr
         wJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9KN+nsy/jNz2u8oyOp3fs+Pd0Y5afz/sRJ9THx9gMw=;
        b=Z8BHh+1pBuankgR8OcMdPBtO4BVeEKU7mAQhay786BWkxfarzZGOsxnn1B/fmOmf6w
         knSQ5A6Fx8g4gaVIg3SQmhNgfJcPVRNE9NmPaXb4gSZJxbxRZACG2sc+AeaGveMuyuE5
         Kwhl4oP7iwy5wPwKFbrQlcStK5hxVO3upKj8FSGgN+chbZD/ydTmYJpuMth8fKeG2Ji/
         19kGBrUnog/g/5dltHD/D4EDMtEQpDlf6jvhnv4awK/gvTN+1Wg9IfFoCpPT3hoJki3A
         yKwjTVlT11YBkWLkdBDc3ywy7bzmKwk3gUcQtK5NpBCfuFBW/C/KT+8TcPEgTL8gfwP0
         suzg==
X-Gm-Message-State: ACrzQf28zJI5ZB1jCwccVRgNycWrH2OnxvE3aeEs0Jt0bza/r0yl17zp
        4ck05rsX7PECIvgSlIdr6vY=
X-Google-Smtp-Source: AMsMyM680n1oJ7hKMpvgWRKPnmLjuV9cqvoJpZKAIkk5rQEYi7jtoseKa2nZz9gE8ebuCx+vLiT31A==
X-Received: by 2002:a05:6870:f6a3:b0:13c:db72:bb60 with SMTP id el35-20020a056870f6a300b0013cdb72bb60mr15392532oab.167.1667495450502;
        Thu, 03 Nov 2022 10:10:50 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 15/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_icrc.c
Date:   Thu,  3 Nov 2022 12:10:13 -0500
Message-Id: <20221103171013.20659-16-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe_icrc.c with rxe_dbg_xxx().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 46bb07c5c4df..71bc2c189588 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -21,7 +21,7 @@ int rxe_icrc_init(struct rxe_dev *rxe)
 
 	tfm = crypto_alloc_shash("crc32", 0, 0);
 	if (IS_ERR(tfm)) {
-		pr_warn("failed to init crc32 algorithm err:%ld\n",
+		rxe_dbg(rxe, "failed to init crc32 algorithm err: %ld\n",
 			       PTR_ERR(tfm));
 		return PTR_ERR(tfm);
 	}
@@ -51,7 +51,7 @@ static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
 	*(__be32 *)shash_desc_ctx(shash) = crc;
 	err = crypto_shash_update(shash, next, len);
 	if (unlikely(err)) {
-		pr_warn_ratelimited("failed crc calculation, err: %d\n", err);
+		rxe_dbg(rxe, "failed crc calculation, err: %d\n", err);
 		return (__force __be32)crc32_le((__force u32)crc, next, len);
 	}
 
-- 
2.34.1

