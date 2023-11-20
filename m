Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E57F17A6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjKTPmC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbjKTPmA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:42:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E748E8
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32fb190bf9bso3367692f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494915; x=1701099715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqt4fMWcJnFqkRrUUz0aUqIPI3sm4QD1GNMIR/9PVwY=;
        b=WWRdsrtptwTokqyRRGbOE7WnfKxXwxq3ClH7vNfLi4UZ8gMMRouvCN1KD1nsdUImEn
         4gPlQJhHvzLFFTFIg4vjSRlztUnHP82u35W/37vYrfAmAl1INEVwzDGx5q1MTmCO8nuT
         qzYbTvF2rBRA/sz7sRe1HkWlE7XMmHgJnyi/14a+qGAR0FhhoHvjtwH1Qah8GUIzwKKx
         UkJdimCRCLQLHeMBQafYt+S7YX0XOTKE5i3jU70Bz20C3WvCwSnK9VMdQmFE+vzvKEm1
         1ThpzBrvyXVqwqJpl5y9BUiyClZzRPOgYg1wWPhaCpp3hs3nrjOwGLy1yKA+RL3ZG64x
         eDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494915; x=1701099715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqt4fMWcJnFqkRrUUz0aUqIPI3sm4QD1GNMIR/9PVwY=;
        b=blor22FmnctXJ7XIHUSjURQjAhd9vNYoD3eZXHBxvtlkmU9JGNB0SAOx3Cq2hvaP7w
         h0ZtQP33LCS8eLxfzPcOshH0h/jONvoKC9dQbMLTUNM6JT9T0jba8hiS6qIXaIi9uB5O
         TX5ptAIbnF2hyx/1uyO5TkFtR/rnrWWSub2sNe3pYMiFab4EObWqGqbbTeSehujbRgtY
         tYwDfSdvj6q1oz1/4ahcSVs/LWP/0Wx6mmW75gYTT6YndWoVJaYgs9AR/qUvLv3siaoV
         1HP5e9ri+i9xxAZ7bQMokYna/cR0oE5H1CCJ7hol3NKGMM9pf2jgTLdLtmk1mGz4egAp
         aT4g==
X-Gm-Message-State: AOJu0YxfN35LHJF5m3V0pt1A6WZtLD5gEnrET+U71/Ri+0B684Vk5SuO
        euaKFFzH8tRGGaCxAH5Xcz0MVWQsmfew82uaHb0=
X-Google-Smtp-Source: AGHT+IGFCR8gtMaeeZtjJ8nPjDmkP9GDlGMciy31uYk0KYgANeGos+EOYoPDITwFslzxTLfwIYgrRA==
X-Received: by 2002:a05:6000:1ac7:b0:332:c542:287c with SMTP id i7-20020a0560001ac700b00332c542287cmr3904235wry.4.1700494915000;
        Mon, 20 Nov 2023 07:41:55 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:54 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Supriti Singh <supriti.singh@ionos.com>,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 9/9] RDMA/rtrs: use %pe to print errors
Date:   Mon, 20 Nov 2023 16:41:46 +0100
Message-Id: <20231120154146.920486-10-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120154146.920486-1-haris.iqbal@ionos.com>
References: <20231120154146.920486-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Supriti Singh <supriti.singh@ionos.com>

While printing error, replace %ld by %pe. %pe prints a string
whereas %ld would print an error code.

Fixes: c0894b3ea69d ("RDMA/rtrs: core: lib functions shared between client and server modules")
Signed-off-by: Supriti Singh <supriti.singh@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index d80edfffd2e4..4e17d546d4cc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -242,8 +242,8 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
 		cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_ctx);
 
 	if (IS_ERR(cq)) {
-		rtrs_err(con->path, "Creating completion queue failed, errno: %ld\n",
-			  PTR_ERR(cq));
+		rtrs_err(con->path, "Creating completion queue failed, errno: %pe\n",
+			  cq);
 		return PTR_ERR(cq);
 	}
 	con->cq = cq;
-- 
2.25.1

