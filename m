Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6753BB25A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407220AbfIWKmP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 06:42:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbfIWKmO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 06:42:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so13352412wrj.6
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9qZBJNnGOCRqEqEbxRrGaxjH2A/vCG2kzdnacqtBRo=;
        b=GAxgdkaFqjsNZyAakxIzatH6onrj5tyMMi9K8ZJncDMz+s0atySTa1YWMpDJ9L/UFO
         3oJ/8/y41qQRzEufxAlqVphKjorhxsgDByuI0BSuy4aoLDEOp1DSXJqLTy4WvkVAo9Ko
         9lDuEzC5iPBD46whI9ywK3Ugj2Rg++tGTqv2w/a+61C/YnnYkGvMAXp5UAPEie3UxcCo
         mRvGVhWovMRYyTVk/PC33x7Z6xDgvKy/ohJ8fWXLL3ztuaMDZpEo+KCHdCfMfUndkk3p
         xiOjS+XIqb7qB3PN47azzY7OEq0goIx7c+S75wre7WVXJY1zkwqFNtkKETf0Zt1VGZ2y
         /jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9qZBJNnGOCRqEqEbxRrGaxjH2A/vCG2kzdnacqtBRo=;
        b=lPesNUxz9k0I5yJiQv39HCk1jICKZe/Yq/4ApGoNTrume79T/4fflfoqxTtZXi6IP8
         kgLY1+EH8AWuMG3W2PTWNLAXmC6/fO2UJae83xK+vm574CtkdLwFUcZSJEE4E7vFzXvp
         xiEyZXY0N+cqnvD9kob/gz2oCMH6DDD+QhTxTq0xYU90ggrkHYx29piKeUrzPuU+lc9C
         QFOa3ConwSZRpdF26pO+wm0xAp9RPrOAAiRY9rfYEA+cCYP7HCEMiJvuuxudxC4meD0a
         3AVeh+isXWHBdN0DDau1aJYlrHpa2C/bcfeIrOzXU9/DI0kGOvJlBGZ+W/QyjNzwXpFY
         GspQ==
X-Gm-Message-State: APjAAAXPTGFmM7mpo0Q8boVppNNRLDKPKgGX5vFwUcpRTHjBTmMag6HU
        gAGgtjUooTkq29EcbNMP4ouFXk8X
X-Google-Smtp-Source: APXvYqz+w1J4gO6aze1YRUtZKap6LGPSiWfO0TxdLIU2ZunHeWuEG/SLgP6Bn5xTijfhNMRd1EJ9Rw==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr8272873wrp.69.1569235332479;
        Mon, 23 Sep 2019 03:42:12 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-41-92.red.bezeqint.net. [79.181.41.92])
        by smtp.gmail.com with ESMTPSA id u22sm18508427wru.72.2019.09.23.03.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:42:12 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Moni Shoua <monis@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 1/3] RDMA/core: Fix return code when modify_device isn't supported
Date:   Mon, 23 Sep 2019 13:41:56 +0300
Message-Id: <20190923104158.5331-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923104158.5331-1-kamalheib1@gmail.com>
References: <20190923104158.5331-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The proper return code is "-EOPNOTSUPP" when modify_device callback is
not supported.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c | 2 +-
 drivers/infiniband/core/sysfs.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 99c4a55545cf..a667636f74bf 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2365,7 +2365,7 @@ int ib_modify_device(struct ib_device *device,
 		     struct ib_device_modify *device_modify)
 {
 	if (!device->ops.modify_device)
-		return -ENOSYS;
+		return -EOPNOTSUPP;
 
 	return device->ops.modify_device(device, device_modify_mask,
 					 device_modify);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 7a50cedcef1f..92c932c067cb 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1268,7 +1268,7 @@ static ssize_t node_desc_store(struct device *device,
 	int ret;
 
 	if (!dev->ops.modify_device)
-		return -EIO;
+		return -EOPNOTSUPP;
 
 	memcpy(desc.node_desc, buf, min_t(int, count, IB_DEVICE_NODE_DESC_MAX));
 	ret = ib_modify_device(dev, IB_DEVICE_MODIFY_NODE_DESC, &desc);
-- 
2.20.1

