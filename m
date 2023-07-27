Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06713765CCD
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjG0UCf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjG0UCe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:34 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F1358D
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:22 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bb31245130so1123766a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488142; x=1691092942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+nZlg9ewOYl0jUwwq9E6BgOMSB9nsqE9ZhNzMzoYko=;
        b=rYH4N/j3fqWMhXoO7TDBhJwXz9MbkpdOEnhZF/NOKxWJNScvpReuRVxsU/xd5HSGHz
         vXUdVqZJqXHdlefyX6JBn1jASN2LFfgU3YPm7Iv8q2NNGYjZp1flWmSLlets4E59St6S
         dkR/b9k7ILJJgHgaAqw4Zcm9gQ9yvWtYyzFi+FzlSGZTGdU/fd3lHQy+fQLdzFge/yxV
         Hk2rvfWIy7lUYWHVAM9GbrhPhobcgJ1JwskF9hsXgO7kECewbukcgmRoPV9WUip/aFjc
         4gzsQ02JrzQXe+WV9eaacCz1pekBs4zuzvL60iL+1B3d6kvpJ62zVNy/8tB1gQhtPvYk
         Egmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488142; x=1691092942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+nZlg9ewOYl0jUwwq9E6BgOMSB9nsqE9ZhNzMzoYko=;
        b=hoQdC5m64fAT0fU8GNQB+W0BAjD7o5XuDwrQ0Cp084B13YUT+b40swYadeL6AuFBAI
         ipbHBh7/hxywVNQVYWQ2VzelzBpJP2idGR5MF6IiYm30XByQMG/YLxKAlphr4pmVmwu4
         gtlzvnemcgvXQMqkdr0m0eD91G4H+f/nnsRRkHGkr7QjLOgwx6ZNVfGHoUhTmwIbgma9
         7le7yR3gHIjnTfE0qaDK6+oYcgGtd4UradcOgQs7jpCYMnnK/pe/RA7K30FOcf7X9JPm
         amtt/Qe2duB2ccwXgMU0YfnMoP83WC4Na5s02wd7lrnDYkXFZgrojtKgQGpbgthhHVOk
         ANmg==
X-Gm-Message-State: ABy/qLZXeTK6Af2OVarYPbwSQQt+EpX+8Hi/LXBOBvSamMvY98i2US03
        ZpsXF7xkOpY40MZUOhJ1tFg=
X-Google-Smtp-Source: APBJJlFwjqDT71kjcQ846O/qXJio+zpLNjUnkVk7WIWJuBm2EPn+WlRZilnXarK9MTJ7moSHHgRFeA==
X-Received: by 2002:a05:6830:18c1:b0:6b9:a84a:a393 with SMTP id v1-20020a05683018c100b006b9a84aa393mr160649ote.37.1690488141937;
        Thu, 27 Jul 2023 13:02:21 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 10/10] RDMA/rxe: Enable sg code in rxe
Date:   Thu, 27 Jul 2023 15:01:29 -0500
Message-Id: <20230727200128.65947-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727200128.65947-1-rpearsonhpe@gmail.com>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
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

Make changes to enable sg code in rxe.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c     | 4 ++--
 drivers/infiniband/sw/rxe/rxe_req.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 800e8c0d437d..b52dd1704e74 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -14,9 +14,9 @@ MODULE_DESCRIPTION("Soft RDMA transport");
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* if true allow using fragmented skbs */
-bool rxe_use_sg;
+bool rxe_use_sg = true;
 module_param_named(use_sg, rxe_use_sg, bool, 0444);
-MODULE_PARM_DESC(use_sg, "Support skb frags; default false");
+MODULE_PARM_DESC(use_sg, "Support skb frags; default true");
 
 /* free resources for a rxe device all objects created for this device must
  * have been destroyed
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index cf34d1a58f85..d00c24e1a569 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -402,7 +402,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 	struct sk_buff *skb = NULL;
 	struct rxe_av *av;
 	struct rxe_ah *ah = NULL;
-	bool frag = false;
+	bool frag;
 	int err;
 
 	pkt->rxe = rxe;
@@ -426,7 +426,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 			pkt->pad + RXE_ICRC_SIZE;
 
 	/* init skb */
-	skb = rxe_init_packet(qp, av, pkt, NULL);
+	skb = rxe_init_packet(qp, av, pkt, &frag);
 	if (unlikely(!skb)) {
 		err = -ENOMEM;
 		goto err_out;
-- 
2.39.2

