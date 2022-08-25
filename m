Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C575A1B40
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 23:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbiHYVjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 17:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbiHYVjM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 17:39:12 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0678C12F2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 14:39:11 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id io24so6326814plb.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 14:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3Mw+ejviqqmcadHo47IKXdXfT8te6+F1g89OeLJKqhQ=;
        b=USwajTQQCECzH2hsq9AOWSwwTwBQhw/D8q9UCt1BypoDFZ5NPeALqzHiE9mFohSpJK
         645HVQgxXAV11gbkha9GaljJI88Vx1dQbD8u92MT00TzdnveFkg5PFzXBlG8qaekQpAa
         7CSbIU2bq2b7igLjRf6/YfHdEIzTSPpwc4leS82G8uuMIwmGIjBttSQVrGgjHa9qno5/
         /f2ucfov2l4WRCm2lM0YMK+dSh8sQYznxv6tDuJ7r1Ug8YqfIHfLLhy2s3dpXGGUs8cF
         L+U4nlPSbiidr07nSzBeppCR3f3A65Fm/UZTtINgfpCE0tYrOp+sKATLjs1Ze3QGEhyA
         lW2g==
X-Gm-Message-State: ACgBeo1AvYFo5XA2EcdgV4Pr2a3yLiE+nn9LWVeDqhyrbrmFAfZsg2R8
        fczQsNQyAI0bZ5zIkvNw8rk=
X-Google-Smtp-Source: AA6agR5G1MdhIsvYXww7Sl59YVvv96pFFbBnBKK5q+zCoTPP0yPTmOTYMwNjhuvSFkGyScGz9u85pA==
X-Received: by 2002:a17:902:ca01:b0:172:bc42:be8e with SMTP id w1-20020a170902ca0100b00172bc42be8emr937786pld.47.1661463551072;
        Thu, 25 Aug 2022 14:39:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id n27-20020aa7985b000000b005379e480445sm111676pfq.94.2022.08.25.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:39:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH 3/4] RDMA/srp: Handle dev_set_name() failure
Date:   Thu, 25 Aug 2022 14:38:59 -0700
Message-Id: <20220825213900.864587-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220825213900.864587-1-bvanassche@acm.org>
References: <20220825213900.864587-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of ignoring dev_set_name() failure, handle dev_set_name()
failure. Convert a device_register() call into device_initialize() and
device_add() calls.

Reported-by: Bo Liu <liubo03@inspur.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 1d3a15e63732..3f31a0eef1ef 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3902,12 +3902,13 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
 	host->srp_dev = device;
 	host->port = port;
 
+	device_initialize(&host->dev);
 	host->dev.class = &srp_class;
 	host->dev.parent = device->dev->dev.parent;
-	dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
-		     port);
-
-	if (device_register(&host->dev))
+	if (dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
+			 port))
+		goto put_host;
+	if (device_add(&host->dev))
 		goto put_host;
 	if (device_create_file(&host->dev, &dev_attr_add_target))
 		goto put_host;
