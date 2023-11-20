Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670467F179F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjKTPl4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjKTPlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:41:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5720EB4
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32deb2809daso3012606f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494909; x=1701099709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+OOsE2xAPZkvAFo9npeNem8c9f44n2F1KRwXZMGoT0=;
        b=H8tDXZK0/EfSm4Yw817MHlDNwP7HuORKr4+dBo9wOXZ/pBYe/spsYPDLg26Ic3JKmN
         ehajbsKA4+4bNyY6i+SLFhIuHgJjO+5K/VRv98Qp39SrAd18qCV1lqKB0VELrOtSoOt8
         eXL3qQ6vJGzzLIalM7nxZfG2d78+0IOafccSvLVOyXxRXGMn1ZsE1Ee1DOiZ9mnEBZ10
         QLfOpErzJZOUc3j8h8fYNFadLrVzuwcz8WAKOfj9qhkXPvCbnFQPXaRXtT1ZMoRNerS6
         6WMSgzBNeQKBxUdxGdsEOL3OyexC2c4xaAHllOoMTYr2bzag64I4VaYVy6x710/vkzYz
         ZJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494909; x=1701099709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+OOsE2xAPZkvAFo9npeNem8c9f44n2F1KRwXZMGoT0=;
        b=JB8fza/uNNC5ej2x76OOcvm1g7OHjnJHsPlhDZQaPIQh3nxsnBtLQot1ev6/CERB1M
         a5BWggsXI44d/shf8QTey0UqKkmFcGNXByr6KqwqA+TA8PtryzxfymFuKzjQX+yaZcdU
         csLptBpuTqYMgmf1tH6nULi9Zuqg5P5PJef7fPt1WKV5pd1QEhg3Smh5lERuqFL3UtCa
         6Fi/u7GGqg1mh90IBzhyhDiHMrZWMRSLO5fOLH+vrkr04xPJkX5smbbCOtUPF7OQiDSc
         L4Nof2TpI7byXk6NT0EauMNxaFpYB9qSZPHe7MpzHqrf18HbBmH83jsG32PiAcIWa/kf
         Z00Q==
X-Gm-Message-State: AOJu0YxPzjINz3F1JJWOk0iTnnVoNjmz+b6nEUlKIUvaBzVF+JTNRmL3
        LGudugV6LZPuQsDOwfZvyfAt+wVanMByAGg3da8=
X-Google-Smtp-Source: AGHT+IFS0/ju48xbPYhbO/ZgodEM9nvgSCp4YhagBWFb2H1ClH2CzN2cg7WKN6BXddohtpocxI8odQ==
X-Received: by 2002:a05:6000:186d:b0:32f:80cf:c3cd with SMTP id d13-20020a056000186d00b0032f80cfc3cdmr6640699wri.4.1700494909533;
        Mon, 20 Nov 2023 07:41:49 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:49 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Florian-Ewald Mueller <florian-ewald.mueller@ionos.com>,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 1/9] RDMA/rtrs-srv: Do not unconditionally enable irq
Date:   Mon, 20 Nov 2023 16:41:38 +0100
Message-Id: <20231120154146.920486-2-haris.iqbal@ionos.com>
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

When IO is completed, rtrs can be called in softirq context,
unconditionally enabling irq could cause panic.

To be on safe side, use spin_lock_irqsave and spin_unlock_irqrestore
instread.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 75e56604e462..ab4200041fd3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -65,8 +65,9 @@ static bool rtrs_srv_change_state(struct rtrs_srv_path *srv_path,
 {
 	enum rtrs_srv_state old_state;
 	bool changed = false;
+	unsigned long flags;
 
-	spin_lock_irq(&srv_path->state_lock);
+	spin_lock_irqsave(&srv_path->state_lock, flags);
 	old_state = srv_path->state;
 	switch (new_state) {
 	case RTRS_SRV_CONNECTED:
@@ -87,7 +88,7 @@ static bool rtrs_srv_change_state(struct rtrs_srv_path *srv_path,
 	}
 	if (changed)
 		srv_path->state = new_state;
-	spin_unlock_irq(&srv_path->state_lock);
+	spin_unlock_irqrestore(&srv_path->state_lock, flags);
 
 	return changed;
 }
-- 
2.25.1

