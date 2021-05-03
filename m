Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31737148C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhECLtc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhECLt2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71360C06138C
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id zg3so7373972ejb.8
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gj0C0QwtaN1Rh//VX6cnQf70Ky35wzcTBtkiTbdkQaU=;
        b=BK/n6Wb+/nwD0lLrx6CmCOBwcVj0rMxtB+tv5uzuEKkoMSQO+Vu2VFubxH9tciCytu
         jsKTU3diCzf4oswvMCEZ+8b2srAjVVeY7YAJFKxiF86mhVQfmHmI6F0XEsIBpfB88c+u
         RbRl/q1i0s0ehCIW/loT7hWXqrpZ0wPIJ4ddxSFJMVWGkc0NWgmaFz318c5owESwlgTs
         I8lVY2PG19k3lE5xDj+WIcXrNQpILgzWtEP3udWyYFkpmSWElJApITVsHZarvc+Jefhk
         Ihhl25f66jhqyiEyvyQF/uyxEDF/aH2smB2IQA/36q+M5fQXIEId5V2Nu0RBfR7CFYFw
         UjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj0C0QwtaN1Rh//VX6cnQf70Ky35wzcTBtkiTbdkQaU=;
        b=CaIEe33OG1af8BlsBWjDnS5PJdGknk+q2Ni6W8kLMSHLpQmiUxjS2gWiVf6iuF/Roh
         6UBbU8qULeHkZdzo0hIWHjzPYV524OFajMugP9q3i1uGDpFgXSML+Xkq//5r1FFjk9kD
         +nScuoFgGt45n76TftZCFMzlkR5qbHoh4qolZnDnIfLDXspHxAIWKBi0PepQL7q6xkRO
         9tNwQ0ndqFmG83C3DMNiHrqwm2yab3enK7kRtUotkLacSjEUzFt8sdjWG1kyXFx/7SJs
         b2dX5ujEAZF4tfXTnZhnUwQS/VNQn6CkhNuYq9GngW6UBzWHSDhl8M7km0I3C3a0roTn
         scKQ==
X-Gm-Message-State: AOAM531BWhooRUBO5cjdkx4TICwu/9APUs8ds+zQn0s1exGSStPagqwQ
        sRInDWFZ2CjwdPeFoBvCPtxnRHYB2cTNGw==
X-Google-Smtp-Source: ABdhPJwJDeGS1SJ/xq77A/hDx1J2fPKdC0bIuorY11+jp86AM8wDpH5Jz/RyO/kb5E6jhaVTiNHe4A==
X-Received: by 2002:a17:906:d7a2:: with SMTP id pk2mr16374697ejb.551.1620042514118;
        Mon, 03 May 2021 04:48:34 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:33 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 18/20] RDMA/rtrs-srv: Fix memory leak when having multiple sessions
Date:   Mon,  3 May 2021 13:48:16 +0200
Message-Id: <20210503114818.288896-19-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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

