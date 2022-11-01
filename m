Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2273C615335
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiKAUYn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiKAUYL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:24:11 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656781EEE4
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:24:04 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-12c8312131fso18117403fac.4
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8kjCkmDp8qX2VpLn2gD9O5IPnX7KvkfQZ6zg8BpYMY=;
        b=pVpIT/mdREaQ3OzO2hjq1jciqlDUlHKm59w0drzVVFB6fCjyWpzMjA8dbtPb93XQgb
         wQ+Q1WQkIlYc91X70VOeOBHZnWurG3ZPwWGNbKS+9jAd4Nam2nYDea8rZRHmXH0pAr3D
         kdla+DGNozu1ku88cirPlDiwJnA8G5zpZjZe15ye6CoASqbCaQ5+PmPbmXKhmCmP4Z68
         DM8cU41W6D/bf5tIXJws1JwvzhLBHbtMqFL9iTjO8Q/k6lxB9XZlZLln/zjZ8P/H3Dbo
         IVfxXIQ/YCQx3IAm6gOikown4gga3BDTR3xJ7SKVpTxkfuJ+DaJUSzEo1vtJ4zOjY911
         fxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8kjCkmDp8qX2VpLn2gD9O5IPnX7KvkfQZ6zg8BpYMY=;
        b=fdUjpWJzIU8LMQxx13jB5N4n7USbvhcCTzd9djk+WRM+NvRftT/d39mmu2xQAEDzIc
         S5Uje4FLe+txuQRu2fwllBW3JoKU4fzd3OWk+OMkYFmN0WnTmLdfHXtv1pgKSciwDQOd
         tH36Xrgc/UHEZmKl6zaRgHx1OkFI1KssoEVj4VFfGbwZT4RW/48dak85REf77gZaKHf9
         TeLYJ58H3p/fIr2Ii+TBUeXYJeJtFSbzk0royF2JfBFZOed0s0imxzh1YKSGQXUgDEsg
         54JJyinHznj8mY2Z6dQwzqHLf02Zoiaxjz0ZuYbFpL1sjPNMszU+NXg7RWEhAsooPgla
         nIMA==
X-Gm-Message-State: ACrzQf1AdqIgHYjK2m4kZQq+HYeH7QUOYMesGhl8Ua8YS9tMCJ9bW9Vf
        xhniJkhZSzsa7Cp2WSfmp+I=
X-Google-Smtp-Source: AMsMyM7BAC9zYFyMyAOvPxfrJjeuvZSA9v4oV4eFevoWsu3wxaAmnon4Ej7v/7qdBYYaCqIvHc56IA==
X-Received: by 2002:a05:6870:d14f:b0:13c:673d:6799 with SMTP id f15-20020a056870d14f00b0013c673d6799mr12305175oac.149.1667334243634;
        Tue, 01 Nov 2022 13:24:03 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:24:03 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 15/16] RDMA/rxe: Replace pr_xxx by rxe_dbg in rxe_icrc.c
Date:   Tue,  1 Nov 2022 15:22:40 -0500
Message-Id: <20221101202238.32836-16-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_err/warn in rxe_icrc.c with rxe_dbg().

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

