Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C8C38281F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhEQJVF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhEQJUq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04529C061760
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so5995257edc.7
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gj0C0QwtaN1Rh//VX6cnQf70Ky35wzcTBtkiTbdkQaU=;
        b=CFQ5iqmCt6hpLhxstiYTWTkm2cFiV/0xysRllbdmfZqCnwNEHfqUIOjtAu8j1+7qVQ
         Yi3a5z1OWVmL+Jo+KHH/Mo9Jc4FsRe1pZ847hnynnJ/m3zVbRHfmPc2LjFbYnFlKbfU9
         DiB+OU9VoxGKTSog9BA8FckMQ2+M/ZVR0oxnp5roieGkpgJPr150L09XVQCN1UNgE5C9
         +OpnN1QOmzAL5TEEz7dLSwARke+z2uuog77hLIFVgEzUfYPeztSZtzxEAzUG80MKY6pp
         I0TY42qQIpVaJVXueGpQVRhLbYd75cugXBtsb38XUwcFFhniTzSStTji8zM+6PuJFghG
         z2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj0C0QwtaN1Rh//VX6cnQf70Ky35wzcTBtkiTbdkQaU=;
        b=o391QaJwqFQQ6bTXYvHSOUTxjwWN74LC5qppI3wPwhTuNnbDnZHKfEgh4fogKgLjCu
         LwXCOp3Jb/e1NsrJm4gYdg2RsruPIaIs/0V92v+E70sd4SHlXPKNsypc2e+swCBOfqvb
         Kg9JdKdmhs0VLNy3IqCOYGHl7Zo2dMEMNbUlwVF5uKA7topaL6cretzi/eMFBxlAsomt
         d1MEcxFNRnMpnB8uA3ss3q6Ajp0THEYut4xSmwTX0DeE9tK1EAxTOrOLBVKU+gcEtnLW
         O3vsb8F2cDM6ZU4RxClXjuR48jK+1gfrNki1hfwILjodBY9e6lKQ6qpsT6br1J1u1mtd
         QNZA==
X-Gm-Message-State: AOAM533X51xu01fxTHYaMLsFmAsI3lfx7LqwQq9Ve7RdHhbhRvgBflSB
        3HowjPAUbI0GVQnuQopA1AYjikYoT5mQgw==
X-Google-Smtp-Source: ABdhPJyDU/POmrCdAWlUvvQhxf4t+97iaGYuSSsp8YNBVcMmVao6N4L/Y/DQu4ZjfcOtwkniSNuRsQ==
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr70603306edu.359.1621243168629;
        Mon, 17 May 2021 02:19:28 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:28 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 17/19] RDMA/rtrs-srv: Fix memory leak when having multiple sessions
Date:   Mon, 17 May 2021 11:18:41 +0200
Message-Id: <20210517091844.260810-18-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Gioh notice memory leak below
unreferenced object 0xffff8880acda2000 (size 2048):
  comm "kworker/4:1", pid 77, jiffies 4295062871 (age 1270.730s)
  hex dump (first 32 bytes):
    00 20 da ac 80 88 ff ff 00 20 da ac 80 88 ff ff  . ....... ......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e85d85b5>] rtrs_srv_rdma_cm_handler+0x8e5/0xa90 [rtrs_server]
    [<00000000e31a988a>] cma_ib_req_handler+0xdc5/0x2b50 [rdma_cm]
    [<000000000eb02c5b>] cm_process_work+0x2d/0x100 [ib_cm]
    [<00000000e1650ca9>] cm_req_handler+0x11bc/0x1c40 [ib_cm]
    [<000000009c28818b>] cm_work_handler+0xe65/0x3cf2 [ib_cm]
    [<000000002b53eaa1>] process_one_work+0x4bc/0x980
    [<00000000da3499fb>] worker_thread+0x78/0x5c0
    [<00000000167127a4>] kthread+0x191/0x1e0
    [<0000000060802104>] ret_from_fork+0x3a/0x50
unreferenced object 0xffff88806d595d90 (size 8):
  comm "kworker/4:1H", pid 131, jiffies 4295062972 (age 1269.720s)
  hex dump (first 8 bytes):
    62 6c 61 00 6b 6b 6b a5                          bla.kkk.
  backtrace:
    [<000000004447d253>] kstrdup+0x2e/0x60
    [<0000000047259793>] kobject_set_name_vargs+0x2f/0xb0
    [<00000000c2ee3bc8>] dev_set_name+0xab/0xe0
    [<000000002b6bdfb1>] rtrs_srv_create_sess_files+0x260/0x290 [rtrs_server]
    [<0000000075d87bd7>] rtrs_srv_info_req_done+0x71b/0x960 [rtrs_server]
    [<00000000ccdf1bb5>] __ib_process_cq+0x94/0x100 [ib_core]
    [<00000000cbcb60cb>] ib_cq_poll_work+0x32/0xc0 [ib_core]
    [<000000002b53eaa1>] process_one_work+0x4bc/0x980
    [<00000000da3499fb>] worker_thread+0x78/0x5c0
    [<00000000167127a4>] kthread+0x191/0x1e0
    [<0000000060802104>] ret_from_fork+0x3a/0x50
unreferenced object 0xffff88806d6bb100 (size 256):
  comm "kworker/4:1H", pid 131, jiffies 4295062972 (age 1269.720s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 00 59 4d 86 ff ff ff ff  .........YM.....
  backtrace:
    [<00000000a18a11e4>] device_add+0x74d/0xa00
    [<00000000a915b95f>] rtrs_srv_create_sess_files.cold+0x49/0x1fe [rtrs_server]
    [<0000000075d87bd7>] rtrs_srv_info_req_done+0x71b/0x960 [rtrs_server]
    [<00000000ccdf1bb5>] __ib_process_cq+0x94/0x100 [ib_core]
    [<00000000cbcb60cb>] ib_cq_poll_work+0x32/0xc0 [ib_core]
    [<000000002b53eaa1>] process_one_work+0x4bc/0x980
    [<00000000da3499fb>] worker_thread+0x78/0x5c0
    [<00000000167127a4>] kthread+0x191/0x1e0
    [<0000000060802104>] ret_from_fork+0x3a/0x50

The problem is we increase device refcount by get_device in
process_info_req for each path, but only does put_deice for last path,
which lead to memory leak.

To fix it, it also calls put_device when dev_ref is not 0.

Fixes: e2853c49477d1 ("RDMA/rtrs-srv-sysfs: fix missing put_device")
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index a9288175fbb5..20efd44297fb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -208,6 +208,7 @@ rtrs_srv_destroy_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
 		device_del(&srv->dev);
 		put_device(&srv->dev);
 	} else {
+		put_device(&srv->dev);
 		mutex_unlock(&srv->paths_mutex);
 	}
 }
-- 
2.25.1

