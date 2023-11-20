Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C734B7F17A3
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjKTPl7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjKTPl6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:41:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F95A7
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso2949624f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494913; x=1701099713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXPmJMkioa/Lt/uDsbu9HL2/rHo4GFujuqmlR3mwNy4=;
        b=PZt1Lm7yj+UHfD8kC9zfHok6DL//n63AyRPGPtuvHDtEojLiPB9ntBMKHzNpOV30Lm
         Om0jtePZsYZ61xZcpBDf5C4voCN2/1BfXfqwUDZTLXKCahgJuj+D1nvhXefpF7aUniQf
         FBdQj9ZGy/jottrIavaBNwqsd/L7JQLh2EfhAm70vM34wOgtboBWyKHGiXw07G6KeE43
         nVgemP7vcuwJw+SZEEt4/y0sGZYxcdPzFULBy1JYw+lVn/UA8WLWTDsf+HMIaS8rVCV2
         oikpwSxvuuNi4ZReD1YPYW/RwTwlK1m1inkPc/BlBh/IXvAV/QVnzzzr1eQxSx6RJa0X
         AfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494913; x=1701099713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXPmJMkioa/Lt/uDsbu9HL2/rHo4GFujuqmlR3mwNy4=;
        b=FvK0Z0K7lCtqVH91iIEPR4uOJD/YFqoMS7xxprWY/AmC/24DplJa7BGJzQMJNuAwgE
         lx9WeLG7ZU/ve1tPFS2lIN307CjOwV9ST6UnD5GdQdmwzBn/YCxse8zrW2A/oqJteyX1
         i89fD83Y3nduo+WS3zUYEumIAZjss3oPKteNhbEf+QrAdkI0ol+L0aMrJ0K2P8rEw84O
         EQLQ0jMHXss5nXSy1683QDVysXYirgpWgjErgkmxpxzHpEv+WT9neM6QgNHYqNLeThEN
         LifEIiIePHsrKCj2IYOI08SFSltJxs7TSV66+JJG2bMuedZ45fMtpJLF4/k1Pb7f49MF
         GbXQ==
X-Gm-Message-State: AOJu0YwShhUw78SGf1/HZs3EDTPuQmF5tHaCf3ys7MrFjQ1wZSTpJaAS
        w75zaHOBcjVRChFSKEVyQy7YqR3F9OYYKmLuanw=
X-Google-Smtp-Source: AGHT+IFXeM9mnu7GKrPNUF6ejSVC/2MH3vb0DWilDGuIbfuvH8PwICuQDtDsi6ckWsltund8Qc+tsg==
X-Received: by 2002:a05:6000:1001:b0:331:34c1:7a0 with SMTP id a1-20020a056000100100b0033134c107a0mr4904311wrx.57.1700494912991;
        Mon, 20 Nov 2023 07:41:52 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:52 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 6/9] RDMA/rtrs-clt: Fix the max_send_wr setting
Date:   Mon, 20 Nov 2023 16:41:43 +0100
Message-Id: <20231120154146.920486-7-haris.iqbal@ionos.com>
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

For each write request, we need Request, Response Memory Registration,
Local Invalidate.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 83ebd9be760e..df10d29c3fe9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1699,7 +1699,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		clt_path->s.dev_ref++;
 		max_send_wr = min_t(int, wr_limit,
 			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
-			      clt_path->queue_depth * 3 + 1);
+			      clt_path->queue_depth * 4 + 1);
 		max_recv_wr = min_t(int, wr_limit,
 			      clt_path->queue_depth * 3 + 1);
 		max_send_sge = 2;
-- 
2.25.1

