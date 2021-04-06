Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36935540E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbhDFMgx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbhDFMgx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:36:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A442C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:36:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m3so6541733edv.5
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5rGQ4Ye7BBqUAo3iBZ2JE5l6vEu/0+M6kir8GchjX0=;
        b=NsPk7IBtWd4F96+dV+PRc1dGG2BbNDUlGzrRpYo6WjGMqPgneu6fmhoWdpE9nkUXT9
         CN/ZisaFuRtYcYAJgBsG93OkDgzUkXIawJFPsfUYxJQGC+rORmNhmFNkqKiddTwYtjcH
         NOFpk6xwAcwiDEMDmCUee3nfAeTGXj65cExPxFFBTqDrrS/Q07kfOqD/lt3TU80LU7dx
         8CwAJR7ipiajgxEa5+2KlNsFNopWqNQwNaiVvz2cVtsk5HExUYXtOpZTISZxGGLaYtYs
         gD04ofe8iIDmLmqqRfj3fPsI+NJfsP4NIAOYbT1I8NMnoSChO39LIPdQQxjeDnPmYkqS
         x5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5rGQ4Ye7BBqUAo3iBZ2JE5l6vEu/0+M6kir8GchjX0=;
        b=n+jy4+MGoL0NvUVX5rhTeVlCehKqSmm81TIoNT2Q9USWgfcq+KJqTKfTQ6OL7N87Ok
         0gl29wZla0mx9xSZY+Z+yXFX5RJj5Cjzzc1Bk3zbMEvYOaPKWWCGbUQiUE2vXn5bGX9T
         cLR+RjAc85mKjD4WHNJQMdN5or7MAjBDCXsco3VBSfjm8nuUMyZ3hTkhDkz1K5JKO9s7
         5Bk2yLJFp85hJht1PKjrQHumWPznXUwN1v9DFgQa6RCYJNlhL9DjhmYYJuNbRKJiviOF
         qYP82A5FNWKcbkYbf2BJspkiUJjOA+/bj9B0RM6jIx9QduOEmR62ocBj2IZ+6iGzHPOE
         ROLw==
X-Gm-Message-State: AOAM532X9DyTGCnGOGE5MziERpoAWQDEJi0BuRv1ld+S/B8lRjSSHE14
        A6PUrpDKSXwwy2ZDYkGql3kWMm5eQRHENwc7
X-Google-Smtp-Source: ABdhPJx4+94lCgfY3fzV+9Fs/dCWjamknC7/W7WFW/kJ3oyTGSNxFJ3JtVJirWfTRcSWYH+9H12wLw==
X-Received: by 2002:a05:6402:2038:: with SMTP id ay24mr8651875edb.240.1617712604013;
        Tue, 06 Apr 2021 05:36:44 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id p9sm13738384edu.79.2021.04.06.05.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:36:43 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 3/3] RDMA/rtrs-clt: Simplify error message
Date:   Tue,  6 Apr 2021 14:36:39 +0200
Message-Id: <20210406123639.202899-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406123639.202899-1-gi-oh.kim@ionos.com>
References: <20210406123639.202899-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Two error messages are only different message but have common
code to generate the path string.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index a534b2b09e13..4369e4cf13f0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2462,32 +2462,23 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 static int init_sess(struct rtrs_clt_sess *sess)
 {
 	int err;
+	char str[NAME_MAX];
+	struct rtrs_addr path = {
+		.src = &sess->s.src_addr,
+		.dst = &sess->s.dst_addr,
+	};
+
+	rtrs_addr_to_str(&path, str, sizeof(str));
 
 	mutex_lock(&sess->init_mutex);
 	err = init_conns(sess);
 	if (err) {
-		char str[NAME_MAX];
-		int err;
-		struct rtrs_addr path = {
-			.src = &sess->s.src_addr,
-			.dst = &sess->s.dst_addr,
-		};
-
-		rtrs_addr_to_str(&path, str, sizeof(str));
 		rtrs_err(sess->clt, "init_conns() failed: err=%d path=%s [%s:%u]\n",
 			 err, str, sess->hca_name, sess->hca_port);
 		goto out;
 	}
 	err = rtrs_send_sess_info(sess);
 	if (err) {
-		char str[NAME_MAX];
-		int err;
-		struct rtrs_addr path = {
-			.src = &sess->s.src_addr,
-			.dst = &sess->s.dst_addr,
-		};
-
-		rtrs_addr_to_str(&path, str, sizeof(str));
 		rtrs_err(sess->clt, "rtrs_send_sess_info() failed: err=%d path=%s [%s:%u]\n",
 			 err, str, sess->hca_name, sess->hca_port);
 		goto out;
-- 
2.25.1

