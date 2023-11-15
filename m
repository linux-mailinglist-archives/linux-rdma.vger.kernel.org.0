Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454B77EC728
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjKOP2D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjKOP2C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:28:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D347A18A
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:27:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso851979a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062077; x=1700666877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mnD/MS4Zvh8PQ5PRgjBo4e3nhT20PGw9b1s4Mi6YtI=;
        b=ESwh1QHX/n7xwJFfDgzTvhuLYzKlP165nlZ2V87A9jFB+3DJzel9gHGrGOANAlWIRD
         qvKUTTnR2uBiRb6GL8+Z1Xct101sslxaZWNN6ld7nLEE+/5X62jWaYwDke1oJaxXqMyf
         8O+BWVw2rLTCbfLrjY/8vL2mon0K99eIe5eqQjN1ceVuUA/6AiOq0qNuAZZXjCIHEspU
         knyuedH5K2xDI4LuDg8SpU6UnmLonxldRBIm+VB/y0iRfkKVjqC9kFGGiymbZH5MsQaK
         zoENIO+IoDRW9TEo0Rd907mlANO1+Ni8BEVeco0rBLU9lld+qJtu76LRl1AoGaVRLm1j
         aa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062077; x=1700666877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mnD/MS4Zvh8PQ5PRgjBo4e3nhT20PGw9b1s4Mi6YtI=;
        b=Knx9zMBnslMAn4csTalnAO6GPqyJXA7tVvf+6YQXbw95S7jYKD/RKvusueAyFESm/m
         2RxiQnrkepPAn1A5UBkWkFLa1IbcDoYTYExhsNtlnO24f6SYeDh8xCU3pQZIgHGVV9SW
         SsDY4fGwQbNVfej/gfE3BpMgFBoFPXQqIyMH/3TLldfmd3V+O0lG8V68/IMBLrrpkn4z
         k1fBtI8s+pCvxbzQh7RJIAKMDEGMVupIF7pcB8Xdbi9znoxlkXyUF7k7Nvd3DexJTfoH
         nFYgIJ90oLIY37gxexYMsbKqBdLe9WLay/ATqjhbW3lL4XY0VCO53+rE1HNhiLxcncJA
         pjTw==
X-Gm-Message-State: AOJu0Yx7lSc4pVbQjYTsBw5FjXfcrYnpAsq5veh1VcMIJzVCzztz4vdp
        jklIaLNh9yFvk8c4PWmC6oz4xWzD6ed9mIxH7yk=
X-Google-Smtp-Source: AGHT+IGYoQE9Tu/vD8pkOIT/Du3aPz3MxfK0eg+PHcsndw5EBbKnBmzGwTe33hPufdKxzpOVMYFsbQ==
X-Received: by 2002:a05:6402:115a:b0:53d:b59c:8f8d with SMTP id g26-20020a056402115a00b0053db59c8f8dmr5421531edw.8.1700062077286;
        Wed, 15 Nov 2023 07:27:57 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:27:57 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Florian-Ewald Mueller <florian-ewald.mueller@ionos.com>,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 2/9] RDMA/rtrs-srv: Do not unconditionally enable irq
Date:   Wed, 15 Nov 2023 16:27:42 +0100
Message-Id: <20231115152749.424301-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

