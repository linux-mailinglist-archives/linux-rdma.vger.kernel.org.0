Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148A831A007
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhBLNqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhBLNqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:46:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9B2C061786
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 05:45:30 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id y9so15639330ejp.10
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 05:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAQff2hwx9iIpwDmTdmR5w/iW0dPfr4Q8T7IMS7Gh+0=;
        b=TSsh7gMacTRmWc6XXduDybQy9/QjKry5mXGxa19oozrISMrrTJDS9gv5+uCfyxIcsC
         /J/YonJdLVUwMfVoN5fydYNakoNqF8YStcWQc5bnA+5zrX0x46yNEIPhqLnK+6C/LE+D
         KKMH6L6gZdLY9EIPBKWfJgVB2RUJYVJl+VbWdlXkF/uwAIR/C4Ey36pDEqBRmC3rE5ES
         adMNPd0/CH1zv1DEh6P9jG48y+jl/5FrtGvIA5amEYZYNv36sb+zUlxHoq6kWxWe773P
         Z5wXzuuPukFLe/2k1ZWxt0x9ewTiXyh1Y9TsbRit2zh0/2+5o01JbmAtMlhhS9UYtEvy
         CqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAQff2hwx9iIpwDmTdmR5w/iW0dPfr4Q8T7IMS7Gh+0=;
        b=MJEp3nu8tO8kaz3IncwY27H3fUgARV86wo0qXZUmW1swDAJLkeTOXUv4kAngaFGdl8
         /gB0dF0cb1qfAE7MrwSAsx5TP3CS+NeXaZHhfLtFTi5f8MQto728kM2J7nRiREKZdvZN
         SudSEFveo6ep9BMzlc+gYBuwe9Wd5ZvzX+VeJ9M+uzirZ8A4SIrKrDMjlqs2qaoR3kRu
         lz3fqHKxvYnIxv4/P0ZgXbPi/m7YNOlimOx2nIGC79+sYXjj8274j50vzY8+90M+Ei/k
         66vZUEaBbBPu+H2Lz2uuUv8/0i9gnbYnictFt5LTC7bvyXAju+xGfGFVKzR9jB1kJRlo
         yuoQ==
X-Gm-Message-State: AOAM530mCJc5a0DLR59W/fiB0uq/LDtvZwzYUuLvEWxYZgzlokmOOq7N
        QcQsxLam0+YivJkPMUhKBjuRLNBb7HyxaQ==
X-Google-Smtp-Source: ABdhPJy8qxu8K8xfdMJspzH3i7TAUGZxEcNLJvwnrXx8pczsQskEPL0o7q/+GcJmaw/wGhwJRr7drA==
X-Received: by 2002:a17:906:da1e:: with SMTP id fi30mr3045612ejb.151.1613137528918;
        Fri, 12 Feb 2021 05:45:28 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49fe:3100:e80f:dbb4:eac5:c974])
        by smtp.gmail.com with ESMTPSA id o4sm5856197edw.78.2021.02.12.05.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:45:28 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 3/4] RDMA/rtrs-srv: fix memory leak by missing kobject free
Date:   Fri, 12 Feb 2021 14:45:24 +0100
Message-Id: <20210212134525.103456-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212134525.103456-1-jinpu.wang@cloud.ionos.com>
References: <20210212134525.103456-1-jinpu.wang@cloud.ionos.com>
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
index fbe39360ff12..eb17c3a08810 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1475,10 +1475,12 @@ static bool __is_path_w_addr_exists(struct rtrs_srv *srv,
 
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

