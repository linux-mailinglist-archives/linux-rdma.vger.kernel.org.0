Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A73DB92D
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhG3NSm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbhG3NSl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F7DC06175F
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k4so476784wrc.0
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+vkdV0HH1tgeL7gC1IU56T6CEYngD6yq5bmbkBJLK0=;
        b=cReyz2YqEOaOyTt8K8fIlWJbExcJjR9/OW7uxGNDrNvskUa1WsCM2lchm23H0wICjz
         5mYa9c9o+EKtQvU49ajq9/T8HtWSn+TXiIgf/Q1PyPuWAciiQ4EInoWwNMW7XW3xQxQc
         CCG1H34bv6Qo2ztdLSqBfnH7W9OJGNhCYO0PkP3jgtWEP20Z6dWaF6cPciNHq3wJNfa3
         e6aRB1yImN3PeegF5U2jFq+eLLq55tgyeZBa4qLf4pC9Xw0D2YJbdgCDxMzpJ+E2f6Wx
         mnBcoGAIHry0C+LNQATlC9TfKAy7W3qeYtVeBb5szz5jwzx8NjoDHkeiDw+b5oSVEKNs
         TpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+vkdV0HH1tgeL7gC1IU56T6CEYngD6yq5bmbkBJLK0=;
        b=XClpqdrs4BnZn6ymlGJpY+u4lvVUeY4HzRvKmiBaHtz43IRWwoaRae8OGX0N1LF3VS
         syav00mDqXe/ieaIbabRSIRf4B3aW2Orlg9VmW6SIc1qPuGX4FLVwuzJD/SLfzyhGQMz
         hn9xatJ/8ALMUM5cQhbWNj3knQJJV71dmq6x5oHUZg7hJqjtNwwtuqrezh4kxR9BGmHD
         F586gmCiQhNlt0L9PZ6dmmOlzBImOJ8xH2d88G+/7t845RM3eLiWV6njby7OT2ZiDCyE
         GIQy59T/GMyYDHrbCMLLJiJUkGuQUJbYArfIVg7Su/xIGSBKNeFfxTMCUEZBIg4BoFiR
         5Tsg==
X-Gm-Message-State: AOAM533F5+U89IJlJgFqDk/K8UdT3Huw1VzYN08G1iq8UVXmw/Jg75Qq
        h9mJsMWmh7Xth39NPOKh06UEsxi5fu1/WA==
X-Google-Smtp-Source: ABdhPJyojkSvo0gjiOVAI2gilWd9tFGjskosd0pXWw4JVKuWPQqWmPznOHnK/ZeIlNh5Q8LkqMJHNg==
X-Received: by 2002:adf:c5d2:: with SMTP id v18mr3034244wrg.386.1627651115466;
        Fri, 30 Jul 2021 06:18:35 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:35 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 02/10] RDMA/rtrs-srv: Prevent sysfs error with path name "ctl"
Date:   Fri, 30 Jul 2021 15:18:24 +0200
Message-Id: <20210730131832.118865-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730131832.118865-1-jinpu.wang@ionos.com>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

If the client tries to create a path with name "ctl",
the server tries to creates /sys/devices/virtual/rtrs-server/ctl/.
Then server generated below error because there is already ctl directory
which manages some setup of the server.

sysfs: cannot create duplicate filename '/devices/virtual/rtrs-server/ctl'
Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
Call Trace:
dump_stack+0x50/0x63
sysfs_warn_dup.cold+0x17/0x24
sysfs_create_dir_ns+0xb6/0xd0
kobject_add_internal+0xa6/0x2a0
kobject_add+0x7e/0xb0
? _cond_resched+0x15/0x30
device_add+0x121/0x640
rtrs_srv_create_sess_files+0x18f/0x1f0 [rtrs_server]
? __alloc_pages_nodemask+0x16c/0x2b0
? kmalloc_order+0x7c/0x90
? kmalloc_order_trace+0x1d/0xa0
? rtrs_iu_alloc+0x17e/0x1bf [rtrs_core]
rtrs_srv_info_req_done+0x417/0x5b0 [rtrs_server]
? __switch_to_asm+0x40/0x70
__ib_process_cq+0x76/0xd0 [ib_core]
ib_cq_poll_work+0x26/0x80 [ib_core]
process_one_work+0x1df/0x3a0
worker_thread+0x4a/0x3c0
kthread+0xfb/0x130
? process_one_work+0x3a0/0x3a0
? kthread_park+0x90/0x90
ret_from_fork+0x1f/0x40
kobject_add_internal failed for ctl with -EEXIST, don't try to register things with the same name in the same directory.
rtrs_server L178: device_add(): -17

This patch checks the path name and disconnect on server to prevent
the kernel error.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index cd9a4ccf4c28..b814a6052cf1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -758,6 +758,14 @@ static bool exist_sessname(struct rtrs_srv_ctx *ctx,
 	struct rtrs_srv_sess *sess;
 	bool found = false;
 
+	/*
+	 * Session name "ct" is not allowed because
+	 * /sys/devices/virtual/rtrs-server/ctl already exists
+	 * for setup management.
+	 */
+	if (!strcmp(sessname, "ctl"))
+		return true;
+
 	mutex_lock(&ctx->srv_mutex);
 	list_for_each_entry(srv, &ctx->srv_list, ctx_list) {
 		mutex_lock(&srv->paths_mutex);
-- 
2.25.1

