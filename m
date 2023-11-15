Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF757EC72B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjKOP2G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjKOP2E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:28:04 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D663518A
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507973f3b65so9805607e87.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062079; x=1700666879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIwdTD2wwefJLEoIwT50HmG4gzgICRaFcaA956d/E3E=;
        b=TKy3uMYc+Pa+Q2iD1FW/m8cVPr5jgHtCbfB18hLdcCr1IE07H382ou22yoweEw/hT9
         4uxQ+UQMv/WbqCacz3now7vAO0upKG/QVoQhUDNwZ7CTtVAAzvRtOPhUAhLfynuPispX
         3OhoeRdEts5SqRQwfjhpWVjVNpMypfkP6GgvD4O4Ci4LNdDOy1K5mEpBBUJVYrzJ2Yxd
         54XiVGF7lGL9m7Bv6Q/yPJOlSYUFUjGsridO1UOu8nSPaCtIajf7awiO5vXtTgyMn/xs
         xF2VOSUBKclro6YF64gc4Ul/8HO06ZNzkqyuTfROl2BdqqVMRcnhASoSQFh61OBsf3a9
         QY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062079; x=1700666879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIwdTD2wwefJLEoIwT50HmG4gzgICRaFcaA956d/E3E=;
        b=cSQRpCfMN16OTpBbilC9EnWj4QDZWKW87oFSdxrLib6YFN2ub0Ppiszh+PhXYOVND0
         8ReumhRLWMviiBukfkyRJg0TKib3ltcJEWiWUL+ooP3F5hhs++OdLVhPWcVNbiBVaewg
         Tt2SOQXAi/QHEtiMdYRPPnqlRa7LvY7zr3NJ1a/voqaFuTSGpC7AqBeIspA7tKNGowTj
         XrP590zcbUzCTdKbgP7Nfrv2VstCm5LSkfG5qN68UjA918JzE2xf76c+oEClTO77umzT
         jMSDTgz95UrVIRLLa5f89XuYfS8LG7Zi5ETmv9+xy4iQAsCfi3VKKTb3f2DW3MR2hI3X
         paKg==
X-Gm-Message-State: AOJu0YycYfhROqdKkTO+8TAKwL55j1VPzdLCOGYAa4qqqygi1+3V0KNM
        4GS6vc4i0200KbBSQuu1GozgHJM6vRwmZv9uROA=
X-Google-Smtp-Source: AGHT+IE1c3FTS23VgwV/ElRn+gXXcmeNiBx3kmLJ3vwJUOu4GKj4JqYDsWP8inku9PIVoehklqK5Gg==
X-Received: by 2002:ac2:4d05:0:b0:509:8d88:b770 with SMTP id r5-20020ac24d05000000b005098d88b770mr9528869lfi.39.1700062079230;
        Wed, 15 Nov 2023 07:27:59 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:27:58 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 5/9] RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
Date:   Wed, 15 Nov 2023 16:27:45 +0100
Message-Id: <20231115152749.424301-6-haris.iqbal@ionos.com>
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

Since srv_mr->iu is allocated and used only when always_invalidate is
true, free it only when always_invalidate is true.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 4be0e5b132d4..925b71481c62 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -551,7 +551,10 @@ static void unmap_cont_bufs(struct rtrs_srv_path *srv_path)
 		struct rtrs_srv_mr *srv_mr;
 
 		srv_mr = &srv_path->mrs[i];
-		rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
+
+		if (always_invalidate)
+			rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
+
 		ib_dereg_mr(srv_mr->mr);
 		ib_dma_unmap_sg(srv_path->s.dev->ib_dev, srv_mr->sgt.sgl,
 				srv_mr->sgt.nents, DMA_BIDIRECTIONAL);
-- 
2.25.1

