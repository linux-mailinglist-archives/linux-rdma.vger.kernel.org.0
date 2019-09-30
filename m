Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9DDC2AB0
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfI3XRU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38393 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3XRU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so8243255pgi.5
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r7m6YScsy0R9Q7oVPrZM5vUGUw2WYUyTOdi6FlEBqQ4=;
        b=AiEO5lF7mIiRMMKWE9Rp3/45+NalyakPXXtCUqqEetM2hndvVT6gc9ji+qrBMICf3+
         u9z8GWJT4VIB5aQ3t0hKxboAe0LsJN+DbZlLoBg1VjNAOJtY0NtRc4wYv4bwGwC3lKen
         Kuj2YOfTo2nQHB0ISFN8wbmnA1h7IPtQXe2Omel0avmTdHbrANkAE9+rk9CdqaQN6Ll+
         1r3APwC5yZwQgJPWvokM/N6s68Qa3w5A97DEp8ervXs6UsdouBKaJwoLyATRhchbSuiS
         T05bEVniSiB8JZwJWqpoeIGebqLGb9jbFpzXYUzGxwX0WrUbVumsmaKSio2om3reAkmJ
         F0ag==
X-Gm-Message-State: APjAAAUh4aAijf8dD3TbexU0hONgC+aeqDuU/0CslhjWKJmtun/+skfY
        WF53O139jkldwNnwZb6zi+k=
X-Google-Smtp-Source: APXvYqyixEs8LdmnesVA5hr1pCHE0Q9FxQwgOy9rJ7uh43xIpKQowFOMend5u98X9vFaPkSrUI96tA==
X-Received: by 2002:a62:1d12:: with SMTP id d18mr24438990pfd.53.1569885439799;
        Mon, 30 Sep 2019 16:17:19 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 01/15] RDMA/ucma: Reduce the number of rdma_destroy_id() calls
Date:   Mon, 30 Sep 2019 16:16:53 -0700
Message-Id: <20190930231707.48259-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of calling rdma_destroy_id() after waiting for the context completion
finished, call rdma_destroy_id() from inside the ucma_put_ctx() function.
This patch reduces the number of rdma_destroy_id() calls but does not change
the behavior of this code.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/core/ucma.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 0274e9b704be..30c09864fd9e 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -160,8 +160,14 @@ static struct ucma_context *ucma_get_ctx(struct ucma_file *file, int id)
 
 static void ucma_put_ctx(struct ucma_context *ctx)
 {
-	if (atomic_dec_and_test(&ctx->ref))
-		complete(&ctx->comp);
+	if (!atomic_dec_and_test(&ctx->ref))
+		return;
+	/*
+	 * rdma_destroy_id() ensures that no event handlers are inflight
+	 * for that id before releasing it.
+	 */
+	rdma_destroy_id(ctx->cm_id);
+	complete(&ctx->comp);
 }
 
 /*
@@ -199,8 +205,6 @@ static void ucma_close_id(struct work_struct *work)
 	 */
 	ucma_put_ctx(ctx);
 	wait_for_completion(&ctx->comp);
-	/* No new events will be generated after destroying the id. */
-	rdma_destroy_id(ctx->cm_id);
 }
 
 static struct ucma_context *ucma_alloc_ctx(struct ucma_file *file)
@@ -628,7 +632,6 @@ static ssize_t ucma_destroy_id(struct ucma_file *file, const char __user *inbuf,
 		xa_unlock(&ctx_table);
 		ucma_put_ctx(ctx);
 		wait_for_completion(&ctx->comp);
-		rdma_destroy_id(ctx->cm_id);
 	} else {
 		xa_unlock(&ctx_table);
 	}
@@ -1756,10 +1759,6 @@ static int ucma_close(struct inode *inode, struct file *filp)
 			xa_unlock(&ctx_table);
 			ucma_put_ctx(ctx);
 			wait_for_completion(&ctx->comp);
-			/* rdma_destroy_id ensures that no event handlers are
-			 * inflight for that id before releasing it.
-			 */
-			rdma_destroy_id(ctx->cm_id);
 		} else {
 			xa_unlock(&ctx_table);
 		}
-- 
2.23.0.444.g18eeb5a265-goog

