Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE417F179E
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjKTPl4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjKTPlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:41:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B794DC8
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-332cb136335so460192f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494910; x=1701099710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxRGiPmVuAngoWRt/X13RMIN/CXy2q8KaB8SoYPQuMs=;
        b=BIwY8e+oIR8BgOpdJ+VfnZq9uCbBCa2A6MgZNXYPglIjmXv9aZVWtnpVFqXIB5fM18
         Q700/1xf5hvl/6/lSgQtSccTsbW6rr2+zEFGbIONH4t4KDHS3+DpSp8zSaK4+46+n3DU
         RnBEpZpu2JGIjhh0aBkiMCghHKdxPb/1eKnioo+qxFjHBzYskFzfBRk+cdDj8vdAZc2Q
         8Q/16OPkmshxXcw0tPHUYrDuY188ZdroQUGr3l6/eO2WuUx0qjX3bDP8E7DCDL6kafnS
         aOTSujfOxMcRVe/gHitdwOnstsdl6IP7LIoi1VqzW9hPorHgFk28nL/0t5aHiy7dPK3j
         dDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494910; x=1701099710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxRGiPmVuAngoWRt/X13RMIN/CXy2q8KaB8SoYPQuMs=;
        b=Z3U+a1VnLxp+6IfEFL3o0kjSHGqWOR7GLYNexhE03EzLkUb3/CqEa2/nAdPtfKawjQ
         OQQwPKn0ymP3Ci6dNXpZ2JkIwHt921+3xwfX1UeK8Jajk4kfJXXQ9kIoI0DGM2dqcYrN
         qqcY7eSAvN8bkUfNkaKzF81ezffRlz4y/nPC59Ke7CWidPHOt4xshKMKTjPRAYYcNEEK
         rAqsXFN+LapHqN01+HhTXDsvEasnhZFgZ5rqwLgYKoTCpUwAKHFnIgA9xIxvrSJZsx92
         wnyUbLM/pCj6voVriI+jxaww4NTrERCHl+Z3OSYhypbpnjPhNe4MdCzwtt7rFSV7D2Zy
         Ps8w==
X-Gm-Message-State: AOJu0Yx13OUtHKRxRLixk2fBikLLPWKboTAVsa5XMboHy3qU7qr4o6Hy
        Q4VpYoHU+dSJyAW8ukDrpxwMWXFXXRxyhWPxmo0=
X-Google-Smtp-Source: AGHT+IEqjmrW9TSMw6hLFpu2aZwFSeuAruAtTPCzcKTJTyZkYDjOi+FlsjPA7U6vUkfJwoD5qlzcJA==
X-Received: by 2002:a5d:5f89:0:b0:32d:b06c:80b2 with SMTP id dr9-20020a5d5f89000000b0032db06c80b2mr6075379wrb.0.1700494910230;
        Mon, 20 Nov 2023 07:41:50 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:49 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 2/9] RDMA/rtrs-clt: Start hb after path_up
Date:   Mon, 20 Nov 2023 16:41:39 +0100
Message-Id: <20231120154146.920486-3-haris.iqbal@ionos.com>
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

From: Jack Wang <jinpu.wang@ionos.com>

If we start hb too early, it will confuse server side to close
the session.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 984a4a1db3c8..83ebd9be760e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2352,8 +2352,6 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 	if (err)
 		goto destroy;
 
-	rtrs_start_hb(&clt_path->s);
-
 	return 0;
 
 destroy:
@@ -2627,6 +2625,7 @@ static int init_path(struct rtrs_clt_path *clt_path)
 		goto out;
 	}
 	rtrs_clt_path_up(clt_path);
+	rtrs_start_hb(&clt_path->s);
 out:
 	mutex_unlock(&clt_path->init_mutex);
 
-- 
2.25.1

