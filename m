Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10FA248A9
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 09:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfEUHFm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 03:05:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35591 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfEUHFm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 03:05:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so4239644wrv.2
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kYbZD/pU6FiuG4Hgvt8IzH8N+h/UystKlzRYYOBxz8=;
        b=tpqbtIqeYOPCLg8eyxfYuyxVTJzJuJNwlqE1PZE+99e8yALnf8ENVfstjCtMwSBjle
         6SjlA6SsU27SJbiyp4pehqbKluUMIt58HF8KTUUPC33wvGCUnms9Milnm8wcjYJL3aeX
         tzujE9iVF2TVhkuBQdgsIjhajRX5pIXwL7VOzKeXuBT1TW4ytxKsD7PkrUwUiTU8eEju
         ygj7ReSuGfEz3qa1RqqGpgNEZPHg9xUlU9qLQFkhCIe5OC5e+mGhRzCTRjjBrPxHBp6a
         4/yOcuc/BuzEqNrk/aB3DKRC1Bp6LxRmJcA+46RSDit1YpwYazovqWQlSrqkSArD4R9D
         wzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kYbZD/pU6FiuG4Hgvt8IzH8N+h/UystKlzRYYOBxz8=;
        b=Oa4tK6Yjnxv1oV3rGvXd38PIdt2OatfxxjMlalVRbqbeJJXsSJvQ2pDHiiO5zbP+yr
         lk2pdzSKy0g9ehy3/weEA8AnOOydctsv9L3VFfAgePpqGg+JMd4Im8LLbh1EB7SQngMv
         YoZ0mFyjHH5E+mU1L2FZs2JRbOsNOY4OUHqIw7pauC0/4CtnFYc14sceQRltDu3LXe1h
         IJ/RdHABRS8EPJvbkFV5iCLrkcjjEHYL218mqtYub9j4XyFVnwfXLkfMZGoErWs/8bDv
         bDBTQhR4zhzTwXWRPrcoQNzaDa7rT7Iuc9rRFNsYIU6J7CABHtYKKLHjFwSxB5Fa+pRU
         mfMQ==
X-Gm-Message-State: APjAAAX9tfAjUw7OduC2HacjQq20wYIR0o49sMx5y0h/dSc6J0dKMEmQ
        HMcM1ggNWyP5vkT0+nn7COpSLDVG
X-Google-Smtp-Source: APXvYqylRM6EnmvZtAcA3cWkVH4/xlFvsOBMc/JzQxC5L5VDQC7NPIro/ULYDnCKR0zXceAClkPL1Q==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr41309692wra.278.1558422340997;
        Tue, 21 May 2019 00:05:40 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-8-139.red.bezeqint.net. [79.181.8.139])
        by smtp.gmail.com with ESMTPSA id u129sm2216311wmb.22.2019.05.21.00.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 00:05:40 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/core: Return void from ib_device_check_mandatory()
Date:   Tue, 21 May 2019 10:05:07 +0300
Message-Id: <20190521070507.16686-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The return value from ib_device_check_mandatory() is always 0 - change
it to be void.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 78dc07c6ac4b..afb3f5946796 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -270,7 +270,7 @@ struct ib_port_data_rcu {
 	struct ib_port_data pdata[];
 };
 
-static int ib_device_check_mandatory(struct ib_device *device)
+static void ib_device_check_mandatory(struct ib_device *device)
 {
 #define IB_MANDATORY_FUNC(x) { offsetof(struct ib_device_ops, x), #x }
 	static const struct {
@@ -305,8 +305,6 @@ static int ib_device_check_mandatory(struct ib_device *device)
 			break;
 		}
 	}
-
-	return 0;
 }
 
 /*
@@ -1175,10 +1173,7 @@ static int setup_device(struct ib_device *device)
 	int ret;
 
 	setup_dma_device(device);
-
-	ret = ib_device_check_mandatory(device);
-	if (ret)
-		return ret;
+	ib_device_check_mandatory(device);
 
 	ret = setup_port_data(device);
 	if (ret) {
-- 
2.20.1

