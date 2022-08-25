Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1815A1B3E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 23:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbiHYVjP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 17:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbiHYVjN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 17:39:13 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B1C2282
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 14:39:13 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id bg22so59125pjb.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 14:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JVFyLLiK90YZLe6E4ZKDxjpX8sjUAOTPT6vNVXEYaes=;
        b=M1y5Y8762baSxTB7OkbArxgRvgUFevRpPXxX1BveIK7Cgn0u609uY5VFoq3XHldT1i
         O0sREu2l2gLWlbRlpBUF9SM9m3b6srVLD8u3X7NnTputOZB9fRo8zoLe0PJHppLm7qGI
         XF6eLD2F7KtaKak2Othww60x9BhTfGSp5ulYkyHqByUWfemJDNblTO494GEPl/BBjBpK
         ThecHy2v/9yslZLxnCdzD0fazpa2FdhXkVkanNChDB9mOK7pux5a4SjvyZ0gs9kxx/BH
         wivQ+tNb/7PCQbgN4DiD0fMfczfUmO02PQBEK5x2aY6v2xE9IiSADeQTG5mRW+vB+/ax
         H6lw==
X-Gm-Message-State: ACgBeo0Yq+I9ZMLfAV1Rbt87v+XWFm7uX9pfShFyUXUXMb246ZgqnmaL
        HgnJriRL96GUuTsj1LNnJ6U=
X-Google-Smtp-Source: AA6agR411VjD05+u4SyVg9T6+hzRn3lnjzkpoh2bOHBNsuOIekxLPnq1aoPxvJr+MopFYp/puAzpUA==
X-Received: by 2002:a17:90a:d585:b0:1f4:f9a5:22a9 with SMTP id v5-20020a17090ad58500b001f4f9a522a9mr1122564pju.49.1661463552645;
        Thu, 25 Aug 2022 14:39:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id n27-20020aa7985b000000b005379e480445sm111676pfq.94.2022.08.25.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:39:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 4/4] RDMA/srp: Use the attribute group mechanism for sysfs attributes
Date:   Thu, 25 Aug 2022 14:39:00 -0700
Message-Id: <20220825213900.864587-5-bvanassche@acm.org>
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

Simplify the SRP driver by using the attribute group mechanism instead
of calling device_create_file() explicitly.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 3f31a0eef1ef..1e777b2043d6 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3181,8 +3181,13 @@ static void srp_release_dev(struct device *dev)
 	kfree(host);
 }
 
+static struct attribute *srp_class_attrs[];
+
+ATTRIBUTE_GROUPS(srp_class);
+
 static struct class srp_class = {
 	.name    = "infiniband_srp",
+	.dev_groups = srp_class_groups,
 	.dev_release = srp_release_dev
 };
 
@@ -3888,6 +3893,13 @@ static ssize_t port_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(port);
 
+static struct attribute *srp_class_attrs[] = {
+	&dev_attr_add_target.attr,
+	&dev_attr_ibdev.attr,
+	&dev_attr_port.attr,
+	NULL
+};
+
 static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
 {
 	struct srp_host *host;
@@ -3910,12 +3922,6 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
 		goto put_host;
 	if (device_add(&host->dev))
 		goto put_host;
-	if (device_create_file(&host->dev, &dev_attr_add_target))
-		goto put_host;
-	if (device_create_file(&host->dev, &dev_attr_ibdev))
-		goto put_host;
-	if (device_create_file(&host->dev, &dev_attr_port))
-		goto put_host;
 
 	return host;
 
