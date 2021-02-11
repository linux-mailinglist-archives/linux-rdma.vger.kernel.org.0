Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5460318577
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 07:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBKG4n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 01:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBKG4L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 01:56:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA4C061786
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so8329395ejf.11
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJb2fsoKJTO3z+iR59FGRhfpTNB+0/SYDQyyxz6omPs=;
        b=RwyRnJh71gqfjKi89K8dFxn3g4igmk/x/SlQjObbKks5AJty5YrKdPaoqt8fq23xIz
         bv8APY9qVl3+epm+9K+V5N5TLtLeh+YAE4qy0rc8+1tpKBgkb/PKX+QsHj8YFlKHOyBp
         LkSf7q8hd2N/gTD1u9LaGs4/5MtAPNv8la8q+ILQOhqaMkFIOa96M9Je0xt7kkzp/ewo
         JZGFOzP4G1f0/74GgWiwUKGsL80oRP0KKB00wWVUya0cfmn7BBjNQVn9q69h6pejy1QQ
         bcKGlrtSkHmuFYCUsIYsYpzu8xGBuEdDDZw1MVJyno8Pbg//HBS4qeBwUX6SE5DGPmh0
         hsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJb2fsoKJTO3z+iR59FGRhfpTNB+0/SYDQyyxz6omPs=;
        b=f4qbDU67/ZZK38Ua3ViPtyKAJGAZIuYQ4rcGXwL4HwBMjHNLPAaKClL686S+hI6JMG
         mK8Zz60bQ822l3ZNi4/9mVF93L6TSUabL2TIw7KHhfBgfmM+p3/xkm51P2aUtv91RLuN
         1Mm+ihjwVErpUyMXxp7cJQ0YZW36rYneIVA7IFmnM+rL3w0gCNWkcrO2URmP9EpDOOh3
         E07+atO27a7swI76ArPNnwy0JXrT/KtznpxrDzDakHcWPWcJ5pC9w03qQ3PknM4Ddy2h
         ys2qERaKekHDxnT2ZghaPrdCJ2/Dfqb2RN9vzYYHoKRVDcquq9ZJGMJzNdG6BNqK80yk
         apAA==
X-Gm-Message-State: AOAM533jRpmzEuEL9bDfkM3EoCQcUfcTxHw4L/YUDArjs+HZAFq12mPe
        AuoUCrI/oxpmlgBW/OlGuMDglqayqiBqkA==
X-Google-Smtp-Source: ABdhPJycEhFj97upDdlsnol7ZKxKqdVjob9UW9CboqOvWZ2Jng8HXhZIRnlHHHS6QEkwsQw1H7jNuA==
X-Received: by 2002:a17:906:7ca:: with SMTP id m10mr6586008ejc.257.1613026529912;
        Wed, 10 Feb 2021 22:55:29 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49a6:4a00:4d27:617f:73f7:3a8b])
        by smtp.gmail.com with ESMTPSA id v9sm3241486ejd.92.2021.02.10.22.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 22:55:29 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 3/4] RDMA/rtrs-srv: fix memory leak by missing kobject free
Date:   Thu, 11 Feb 2021 07:55:25 +0100
Message-Id: <20210211065526.7510-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

kmemleak reported an error as below:

unreferenced object 0xffff8880674b7640 (size 64):
  comm "kworker/4:1H", pid 113, jiffies 4296403507 (age 507.840s)
  hex dump (first 32 bytes):
    69 70 3a 31 39 32 2e 31 36 38 2e 31 32 32 2e 31  ip:192.168.122.1
    31 30 40 69 70 3a 31 39 32 2e 31 36 38 2e 31 32  10@ip:192.168.12
  backtrace:
    [<0000000054413611>] kstrdup+0x2e/0x60
    [<0000000078e3120a>] kobject_set_name_vargs+0x2f/0xb0
    [<00000000ca2be3ee>] kobject_init_and_add+0xb0/0x120
    [<0000000062ba5e78>] rtrs_srv_create_sess_files+0x14c/0x314 [rtrs_server]
    [<00000000b45b7217>] rtrs_srv_info_req_done+0x5b1/0x800 [rtrs_server]
    [<000000008fc5aa8f>] __ib_process_cq+0x94/0x100 [ib_core]
    [<00000000a9599cb4>] ib_cq_poll_work+0x32/0xc0 [ib_core]
    [<00000000cfc376be>] process_one_work+0x4bc/0x980
    [<0000000016e5c96a>] worker_thread+0x78/0x5c0
    [<00000000c20b8be0>] kthread+0x191/0x1e0
    [<000000006c9c0003>] ret_from_fork+0x3a/0x50

It is caused by the not-freed kobject of rtrs_srv_sess.
The kobject embedded in rtrs_srv_sess has ref-counter 2 after calling
process_info_req(). Therefore it must call kobject_put twice.
Currently it calls kobject_put only once at rtrs_srv_destroy_sess_files
because kobject_del removes the state_in_sysfs flag and then
kobject_put in free_sess() is not called.

This patch moves kobject_del() into free_sess() so that the kobject
of rtrs_srv_sess can be freed. And also this patch adds the missing
call of sysfs_remove_group() to clean-up the sysfs directory.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 0a3886629cae..94e3f3290500 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -305,7 +305,7 @@ void rtrs_srv_destroy_sess_files(struct rtrs_srv_sess *sess)
 	if (sess->kobj.state_in_sysfs) {
 		kobject_del(&sess->stats->kobj_stats);
 		kobject_put(&sess->stats->kobj_stats);
-		kobject_del(&sess->kobj);
+		sysfs_remove_group(&sess->kobj, &rtrs_srv_sess_attr_group);
 		kobject_put(&sess->kobj);
 
 		rtrs_srv_destroy_once_sysfs_root_folders(sess);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 2538a84fe5fc..3f1b4ce3c055 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1477,10 +1477,12 @@ static bool __is_path_w_addr_exists(struct rtrs_srv *srv,
 
 static void free_sess(struct rtrs_srv_sess *sess)
 {
-	if (sess->kobj.state_in_sysfs)
+	if (sess->kobj.state_in_sysfs) {
+		kobject_del(&sess->kobj);
 		kobject_put(&sess->kobj);
-	else
+	} else {
 		kfree(sess);
+	}
 }
 
 static void rtrs_srv_close_work(struct work_struct *work)
-- 
2.25.1

