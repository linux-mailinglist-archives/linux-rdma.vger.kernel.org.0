Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0074737148E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhECLte (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbhECLt3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0FC061342
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w3so7401277ejc.4
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C48jsCVmfkTDM5DV5smXobrPCRC+5kxD8HPV/APOlI0=;
        b=B+aE+tiLN8n+546vHrn+PuN545YQ8NkICNaFejSv9u5HggeRlxu8YYaswFgBpgKSjq
         QViN6Fbp/SrkLXEsVXY4IvJJ6WfXm20fiRZOZDIB+bqtvhp8ejTAINeq7NhUg8rdcBkD
         0X8J877he1ekDJklF/GU4LnTw4EikaKBXEZ2362CXDWM0hKqlPDy+WZcf62snna8sznY
         Qhw1e7JX1/yCEQ8N7E57cFVbmpi+W3Kz7//GzhDAzXjqwFOvhT0FT9kHSSWXeqhBgi5K
         MD+w9Q3hI/GoVlbmORXnIEy86tHnw9wX1qWcVfMTTgpgHZUq05dssNxHq0ofQ68mDzBM
         jKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C48jsCVmfkTDM5DV5smXobrPCRC+5kxD8HPV/APOlI0=;
        b=cGbE0I8uS2LBRApjSHv/Fn6ksVldINxZVSb3vRvuuphVcwxRUOla+wHuWL89abCPAX
         6EPmzQxzo6GANBAsOLInTgBtbj1N8OWZG9KbK/2uFufvAf1mOBw/1fktXBZWkD4qAiWr
         APN2B4Jwbef67/kgZ1/0vXEEgE7B+GdqhY0OWm1yGbMxNS/l1BluINP7O+K9rdgPSVk5
         VKWYD9DbdzZ3WHB9GKxv21wArXWXlpKBHNvGrWHZ17jz4kASYpSxZ61pJb2lzZx3p7eZ
         krYfZmN110NvaL2crR7AKqs5d/dInkXtl41XMzf73jSeF0nHg3gIvXJK/8j8FAxZS/hV
         7t9g==
X-Gm-Message-State: AOAM533Viu0GfiErIpmuKPBvp7+MViExfRMWq2NfHbSu8YYOUmnRYw69
        29HQyYuenvyb6amqFX6JjnUtHgEg/iX8EQ==
X-Google-Smtp-Source: ABdhPJzapNlcwdOZ8YA5cFcmOMAAxDEjxN5GhWQRNW8EKDvx8GMito21i0qHReD1hsvnQcCfxl6v0g==
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr16004366ejf.341.1620042515307;
        Mon, 03 May 2021 04:48:35 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:35 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 20/20] RDMA/rtrs-clt: Fix memory leak of not-freed sess->stats and stats->pcpu_stats
Date:   Mon,  3 May 2021 13:48:18 +0200
Message-Id: <20210503114818.288896-21-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

sess->stats and sess->stats->pcpu_stats objects are freed
when sysfs entry is removed. If something wrong happens and
session is closed before sysfs entry is created,
sess->stats and sess->stats->pcpu_stats objects are not freed.

This patch adds freeing of them at three places:
1. When client uses wrong address and session creation fails.
2. When client fails to create a sysfs entry.
3. When client adds wrong address via sysfs add_path.

Fixes: 215378b838df0 ("RDMA/rtrs: client: sysfs interface functions")
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index ec7055b8136b..136fb79355c7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2753,6 +2753,8 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		if (err) {
 			list_del_rcu(&sess->s.entry);
 			rtrs_clt_close_conns(sess, true);
+			free_percpu(sess->stats->pcpu_stats);
+			kfree(sess->stats);
 			free_sess(sess);
 			goto close_all_sess;
 		}
@@ -2761,6 +2763,8 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		if (err) {
 			list_del_rcu(&sess->s.entry);
 			rtrs_clt_close_conns(sess, true);
+			free_percpu(sess->stats->pcpu_stats);
+			kfree(sess->stats);
 			free_sess(sess);
 			goto close_all_sess;
 		}
@@ -3011,6 +3015,8 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 close_sess:
 	rtrs_clt_remove_path_from_arr(sess);
 	rtrs_clt_close_conns(sess, true);
+	free_percpu(sess->stats->pcpu_stats);
+	kfree(sess->stats);
 	free_sess(sess);
 
 	return err;
-- 
2.25.1

