Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE68318574
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 07:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhBKG4r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 01:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhBKG4M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 01:56:12 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0794CC0613D6
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c6so5858246ede.0
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtjHFgJyOAI8CFiugxz8482hixuVZ9qlunYFj8TLiyI=;
        b=OwP7uEnHZjEhZww+bDIX6/beS5yNrThppGmQsW4MXTqjtJCH+4jRtwL+kki6JAj8Gl
         0GcH/RMPZshiPbRqd1hTvT700E8HiGWATEh0pVSKYRndSgMmBocfrpNi/xxiktlPs9Wr
         oqdu9r8lX8I8m14JcNJiNeRvrdwmuOz0DWCqIPXqhNbkT0gWh23pYO64gz28pIS+FVlF
         OqEB3k4EeQAAdsB4RnyCsC9u6pmKy3sqFsmGWKl7+czEHkMd4nVkvyqDTDYga7InDFix
         Ko5CwQAG5V3MDx0/jwGrVjgM7gTVg8YUL1Ul/xk9hgRgDhw4SbTt3GaiI77D/Zarm4cp
         9Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtjHFgJyOAI8CFiugxz8482hixuVZ9qlunYFj8TLiyI=;
        b=C391XeOAFxenRqerRk8P2m4X7VJlbDsAGVgHbiBW4x8qXjbYkSj43tbBQWO09cL350
         mMTd4gR4W7Ey/xo0MAM69BhqvchG+5Xtoi8rxvHy5Kqx5pqvh6BGgFGYISolu/KrvH/i
         VLzUk9ilHmhumcOParwAnESJXUgexoQZaKhYserXvTXz4Hi9TCPX8HE7k5fUPxMgcQUG
         /uk3/kV5qGthPMcngVbKhcYwlMIrKuVBKL5ra3XpBRv7m/p27Ot5cKtlItfU4ld7YQGn
         4zLqdXzMafy+S+59mhTeWBPQATUbJVCW11FtWLLsWqLUyjoRqSOvVHeP2PUGwZZhW2rk
         repA==
X-Gm-Message-State: AOAM53087oEctuppVdKAz6F5LwceufFWTVJlyQfUh7cWCWxCPLIuF+jo
        hhu4DYp0ZcpxfHJCjJNSE7P8NhBbcp5dkg==
X-Google-Smtp-Source: ABdhPJz8hszfE/b9grHBG/X81CJccpt/E7kP3is+l2eco3ZjM/KvH4UdHvAUhRadL0oAtKz+ynqmmA==
X-Received: by 2002:a05:6402:35ca:: with SMTP id z10mr6955525edc.174.1613026530664;
        Wed, 10 Feb 2021 22:55:30 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49a6:4a00:4d27:617f:73f7:3a8b])
        by smtp.gmail.com with ESMTPSA id v9sm3241486ejd.92.2021.02.10.22.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 22:55:30 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 4/4] RDMA/rtrs-srv-sysfs: fix missing put_device
Date:   Thu, 11 Feb 2021 07:55:26 +0100
Message-Id: <20210211065526.7510-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

put_device() decreases the ref-count and then the device will
be cleaned-up, while at is also add missing put_device in
rtrs_srv_create_once_sysfs_root_folders

This patch solves a kmemleak error as below:

unreferenced object 0xffff88809a7a0710 (size 8):
  comm "kworker/4:1H", pid 113, jiffies 4295833049 (age 6212.380s)
  hex dump (first 8 bytes):
    62 6c 61 00 6b 6b 6b a5                          bla.kkk.
  backtrace:
    [<0000000054413611>] kstrdup+0x2e/0x60
    [<0000000078e3120a>] kobject_set_name_vargs+0x2f/0xb0
    [<00000000f1a17a6b>] dev_set_name+0xab/0xe0
    [<00000000d5502e32>] rtrs_srv_create_sess_files+0x2fb/0x314 [rtrs_server]
    [<00000000ed11a1ef>] rtrs_srv_info_req_done+0x631/0x800 [rtrs_server]
    [<000000008fc5aa8f>] __ib_process_cq+0x94/0x100 [ib_core]
    [<00000000a9599cb4>] ib_cq_poll_work+0x32/0xc0 [ib_core]
    [<00000000cfc376be>] process_one_work+0x4bc/0x980
    [<0000000016e5c96a>] worker_thread+0x78/0x5c0
    [<00000000c20b8be0>] kthread+0x191/0x1e0
    [<000000006c9c0003>] ret_from_fork+0x3a/0x50

Fixes: baa5b28b7a47 ("RDMA/rtrs-srv: Replace device_register with device_initialize and device_add")
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 94e3f3290500..126a96e75c62 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -183,6 +183,7 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
 		err = -ENOMEM;
 		pr_err("kobject_create_and_add(): %d\n", err);
 		device_del(&srv->dev);
+		put_device(&srv->dev);
 		goto unlock;
 	}
 	dev_set_uevent_suppress(&srv->dev, false);
@@ -208,6 +209,7 @@ rtrs_srv_destroy_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
 		kobject_put(srv->kobj_paths);
 		mutex_unlock(&srv->paths_mutex);
 		device_del(&srv->dev);
+		put_device(&srv->dev);
 	} else {
 		mutex_unlock(&srv->paths_mutex);
 	}
-- 
2.25.1

