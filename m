Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E6F28B5E2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbgJLNSV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388135AbgJLNSU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD0C0613D1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e22so23151393ejr.4
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/Dc0j/lR+ShoZDY6ICFHErbzY6Y5dDxRujilMQ1QA0=;
        b=gYJZWf+Q5spXrfGtlPFs7Tg0SzygPVnf6C5ZYl8ScmiIAGbqaGu1r12eNDIuawd99A
         c1KqKHJ6sftS5w2c2MWOjUSLml9ZMzHi9qsZXSt1GUkgPdExGDh0eIATZmmQijYQ45uV
         F52TGsX7d1z1oM31HGL8+tmtUECRSoOp1rJ4YstIRVYs3locbnZWX7eqgCITfT6/wZK3
         5SuR/QOPYMg2thTs/Z0I4S1PNl8xjnkqGtt3AQC4AE9blEjTGHJCpVXdl+XZx0vBoDoc
         nTk5e9R4nPyQlUmFRAUajMxX8QN1g4nmE67lkU7nyGXgPxJXUvkKN/brTTFftmq3u0Wr
         IvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/Dc0j/lR+ShoZDY6ICFHErbzY6Y5dDxRujilMQ1QA0=;
        b=BnIBfvKK3O7FRwVvubBuIEKMjsze2SxDGqROUz4kQsPxO0I5AfuZKLYih0evN/N0Qc
         ys3meX0h/a+60H+zLg60VZiE1lx/UlR1Xi7rHOD1AwLkM6JfhRwLJeksq68jChjrWOut
         bZh36KHuPeuSN69WAcePma/hPcKYw/hFA6JECp0SkrtxZnqeBwhiyZp9ihIryPbM2mOE
         gk3h/7g1H3Nbg22RPsrT1YRZzohPcyqxSAJ4YBUSUxvoQLtfl/NfNNVkCQ6dBapmvd4v
         WePM+0anuotuMRu5Jryl/gmFkG9Y0Gi73othWQ3iY2NqX/Dh26Z++rBui9ZWuRlTLelK
         SCNA==
X-Gm-Message-State: AOAM533KPiYCXGU6dMfVEIPCteQpQXvhoK3c0vlo5UFcKynvgw31e0MM
        UDB1HzD6krw3PVkTcvXom9CVJiXfCzZYZw==
X-Google-Smtp-Source: ABdhPJyRedixULSJrm/+tLrM6LuLem8pI9PyUyH3sWmZOKIgJC6jfUM6cfqhFQd1juZqWOrBlL/Sxg==
X-Received: by 2002:a17:906:8610:: with SMTP id o16mr27927018ejx.209.1602508698129;
        Mon, 12 Oct 2020 06:18:18 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:17 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gioh.kim@cloud.ionos.com>
Subject: [PATCH for-next 02/13] RDMA/rtrs-clt: remove outdated comment in create_con_cq_qp
Date:   Mon, 12 Oct 2020 15:18:03 +0200
Message-Id: <20201012131814.121096-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As run destroy_con_cq_qp many times doesn't work, remove
the comments.

Suggested-by: Gioh Kim <gioh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 9980bb4a6f78..fb840b152b37 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1520,15 +1520,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	int err, cq_vector;
 	struct rtrs_msg_rkey_rsp *rsp;
 
-	/*
-	 * This function can fail, but still destroy_con_cq_qp() should
-	 * be called, this is because create_con_cq_qp() is called on cm
-	 * event path, thus caller/waiter never knows: have we failed before
-	 * create_con_cq_qp() or after.  To solve this dilemma without
-	 * creating any additional flags just allow destroy_con_cq_qp() be
-	 * called many times.
-	 */
-
 	if (con->c.cid == 0) {
 		/*
 		 * One completion for each receive and two for each send
-- 
2.25.1

