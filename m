Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858AA31A008
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhBLNqM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhBLNqL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:46:11 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2028CC061788
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 05:45:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s11so10905502edd.5
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 05:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XXNFySI1c6woME8ic0sgKk+HsxZEKknY8MMJsef+DWA=;
        b=B87fsd+dxEkuunw/NfyxeQjcIZYCNUSXqE7vPjMbKG9ae8u4USHQcgpMFZC0zbDrU0
         k1tx6x689AI+ok5LtPlUfMe4vj9bEG0gRMEdV8mlEhExgrE4nR8P1UPLu9qj9ma5oMZ7
         zdMWBL9qY8pgOj5P9SU2s5/lbsOhobUX69/RggbJ7InCFTTnI/5sgq8+48b5AViyln3k
         fWksny3juUQWZZR8kOZoz7hjdSb0bvDWJBIQaPtp/xYGh079Zx2qtqHslGFHW8a/U1rx
         7lVQOMsXXSJCu/VlXnc+mtL1w+XUeylvtZ1oo2lLo4y/M9PhnyWr9eiY5+ZRkOarXszS
         ZDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XXNFySI1c6woME8ic0sgKk+HsxZEKknY8MMJsef+DWA=;
        b=iIBYEz+HohVt8onEPOjoH6VodPsQwk2DsgCSIKDvB1XZVTFpNaDf1DmlEt7x+7Gzfm
         +SXuHIo2bYSsNljx7WBrBkSrRvFazW8kCVU1sYkEc/8dq3Uf7qFi8n8M07G/64l0Lvch
         zO5s8ktjwr6ONcuoDLGYCsubc25tNjsr6z2JdHaTt7pypV+Qe2BKCq3OFOrvu3LyTSe4
         k8j9Iuw1OeDBI7Rc5S0642u6DeOUIYCsdmii+ddsxDSIVPh3U2uo9SN9wXFkUgbQlgu4
         UBSzM3FSyriu+P4ZDE2HROiO9wZjeVSkEkkXJtSwqUuvHwFg1OLlIvmHLQ9LU/rm7xq5
         t8Pw==
X-Gm-Message-State: AOAM531poYqj6pHvztt0tfhLK5tAzkgd2OA5uPPH14smNdoJ7VRbS2Q6
        KL4temcJG9FFywsWXG59E/AXN3X2SGSjyw==
X-Google-Smtp-Source: ABdhPJzSgXAPMeAC8VNMABEAesmmmOKPddRUDrp0SfZNiA5EDwB8FaNmhWUZXSeA/vo7XgT23ZkP0Q==
X-Received: by 2002:aa7:d6c2:: with SMTP id x2mr3425433edr.225.1613137529733;
        Fri, 12 Feb 2021 05:45:29 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49fe:3100:e80f:dbb4:eac5:c974])
        by smtp.gmail.com with ESMTPSA id o4sm5856197edw.78.2021.02.12.05.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:45:29 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCHv2 for-next 4/4] RDMA/rtrs-srv-sysfs: fix missing put_device
Date:   Fri, 12 Feb 2021 14:45:25 +0100
Message-Id: <20210212134525.103456-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212134525.103456-1-jinpu.wang@cloud.ionos.com>
References: <20210212134525.103456-1-jinpu.wang@cloud.ionos.com>
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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

