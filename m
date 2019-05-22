Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D193225EA6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 09:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfEVHX5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 03:23:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43013 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfEVHX5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 03:23:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so689125wrr.10
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 00:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5MM4Q0cjSy236n1bCUgLnN4uk0PLibyeh5GN+Z9eM4=;
        b=ETeNdrZsZF1AFjLND9Y8uX/lar5cMFkqcT8UVuHXr8xgJzXebG3g+S4LN6phGsboSI
         HPn5BW+tU5pBhhczq9wvQamHfeKBTyMd+1cAMNQVEmH2zz1CU0CtveuCKtozPlE6MwsF
         bhLEQQ/SCkSvEYizYPaqRcwyLik4e0Zuht/9MtDsmUXbKeUP/hg3bv6TxUQJLirJkVTo
         pDd5HViAnvFHvJw4qDYCmWKIdNoWTm9kJAeqBga2ydpTHUoiK68Dirummi+PwjZOxCGB
         G0HnerZdKgdi/C5XVKqIw/jz9tObBi+Dr/VvHxF6bbfPLNxU9Shzs+j0s8e3dAshQX8U
         hbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5MM4Q0cjSy236n1bCUgLnN4uk0PLibyeh5GN+Z9eM4=;
        b=mirGHjs79et/XarjbvR3vqSra0rQ87gL2Yty7CyLuY+p3RICUWPa7FcciWG8rtX/Em
         HtckE3tRtTk+UI6kMAjjI7tsg4Vsg3bVnV8RI1gggl9Wmuks08tn2m8Tj1dA7WO+V9jU
         c2f/pONk62ba86wIqmi7KWSIzS2X6U59X42efmu20qsxKomiIEMsUXC1HiltLwkv9+VN
         N9Z/VUf4G2DSFkwQefiHtzG/GPSxu3IvRRqsusPSOoyzcSRpOEpVS6XCSkHLUJq/tpBd
         PjjgbvGc7fEsMIahkhWDn4y2Rr2Ji6Z/R/+45XmIZY+HeaXYbOmexWk2CM263FxCYmvd
         BKuw==
X-Gm-Message-State: APjAAAXE596l1SZz9PwnVdWcJ74tuDS7MMcvMx8CBbcAhf4O7UK4OwPB
        Ef+mOXRt9ZP2UJoiXyM4c5St2Wl3EUM=
X-Google-Smtp-Source: APXvYqwu+48Y9vBq94CZ8UWrnguGox+l0Uax4tQ830t+sjMtCT3p+e5Wf1bYyNc0LBojB3bGMoNGQw==
X-Received: by 2002:a5d:448e:: with SMTP id j14mr34038528wrq.158.1558509835575;
        Wed, 22 May 2019 00:23:55 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-8-139.red.bezeqint.net. [79.181.8.139])
        by smtp.gmail.com with ESMTPSA id d26sm4709021wmb.4.2019.05.22.00.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 00:23:55 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/core: Avoid panic when port_data isn't initialized
Date:   Wed, 22 May 2019 10:23:40 +0300
Message-Id: <20190522072340.9042-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A panic could occur when calling ib_device_release() and port_data
isn't initialized, To avoid that a check was added to verify that
port_data isn't NULL.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/cache.c    | 3 +++
 drivers/infiniband/core/device.c   | 3 +++
 drivers/infiniband/core/security.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 18e476b3ced0..87801e3848a8 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1520,6 +1520,9 @@ void ib_cache_release_one(struct ib_device *device)
 {
 	unsigned int p;
 
+	if (!device->port_data)
+		return;
+
 	/*
 	 * The release function frees all the cache elements.
 	 * This function should be called as part of freeing
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 78dc07c6ac4b..3a497e57f673 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1935,6 +1935,9 @@ static void free_netdevs(struct ib_device *ib_dev)
 	unsigned long flags;
 	unsigned int port;
 
+	if (!ib_dev->port_data)
+		return;
+
 	rdma_for_each_port (ib_dev, port) {
 		struct ib_port_data *pdata = &ib_dev->port_data[port];
 		struct net_device *ndev;
diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 1ab423b19f77..fba7bd5d4a2e 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -564,6 +564,9 @@ void ib_security_release_port_pkey_list(struct ib_device *device)
 	struct pkey_index_qp_list *pkey, *tmp_pkey;
 	unsigned int i;
 
+	if (!device->port_data)
+		return;
+
 	rdma_for_each_port (device, i) {
 		list_for_each_entry_safe(pkey,
 					 tmp_pkey,
-- 
2.20.1

