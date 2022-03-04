Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED75A4CCA89
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiCDAJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiCDAJc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:32 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05BF3EABB
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:45 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 40-20020a9d032b000000b005b02923e2e6so6065669otv.1
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DpoYd3T+Xyeu3qmtjQCLbWFZ5HK4VNygPWuSfJjk0Wc=;
        b=CzbGegeUOmw6a4xfZJpKJx2FZ7xqt4WsJ7HrCPvGy0sj4J59jSG1d05MvFmhxiOJMG
         yxjIuNIP1OmO3lFx2jmq7A+K9lWqzzSCS/riL/JpLU4Ppx9xGYkycCpZwtho5xGLSStH
         EZ4scv6skI2mEWSKuxAjNwUF9hgmWBGLm0f/qoQ+E00FGcTv5wrxcNogRVoj5hY1PzAo
         wIj7q09oeHdyH9TpGhqaG8XSEnusSphlCmjjIFDYIvu9MMizzHP85r8IenOGJr7Cr+2U
         wnxsRIl7IHezT6z69m8/iAqENeLuZC7XT5mrDnqstKrS2G/6AJkfJet2u6Ct0a8y+EOK
         8L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DpoYd3T+Xyeu3qmtjQCLbWFZ5HK4VNygPWuSfJjk0Wc=;
        b=5SQvGEtf2LMA8DO1VzweR4eacWhV8m5FCj0rYG0biI/7rfeira8NhfqtIp5dRh1HMu
         box6Vz65fyO9R282OD2H3pwXMayoAs6xfDxYboB81TM/W++acg7xGOwpJ8sL3i5qk3F2
         /ESuCc3GqvemKy2U3u6gN7YMz6mIFRiE+sfiDJLrBXPDed/Mgy3LF+MjayD7aTRs+L21
         9iDmzISSZHcMQtCWP2/EvDbEmLi2QlnYuw3NJguCsRUSuPJiw7FBnAH6rFb2UKyU0qaz
         tdiXV67r7g+lqw01Pr31s1Od0Fj7rpoUjijrmd8zLi+dDnr9dpVUHPTds/q2lgDQex45
         JNCw==
X-Gm-Message-State: AOAM530V0kpQ5AYtZvs0c9GhLd4oQ567X46Sv+mYeExTKZqEEmmoYziY
        ZZKxU7UZ9YjirT1LwX9h7IY=
X-Google-Smtp-Source: ABdhPJz6459WjgfE0BB8eGtT3A28l4CzrOz1APpLVv2vZbclIMQDEKqhRagjd3tef7gdpKSyM9PzMw==
X-Received: by 2002:a05:6830:4392:b0:5b0:3ec4:4309 with SMTP id s18-20020a056830439200b005b03ec44309mr9066760otv.111.1646352525276;
        Thu, 03 Mar 2022 16:08:45 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 05/13] RDMA/rxe: Replace obj by elem in declaration
Date:   Thu,  3 Mar 2022 18:08:01 -0600
Message-Id: <20220304000808.225811-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix a harmless typo replacing obj by elem in the cleanup fields.
This has no effect but is confusing.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
 drivers/infiniband/sw/rxe/rxe_pool.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 2e3543dde000..3b50fd3d9d70 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -12,7 +12,7 @@ static const struct rxe_type_info {
 	const char *name;
 	size_t size;
 	size_t elem_offset;
-	void (*cleanup)(struct rxe_pool_elem *obj);
+	void (*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 7fec5d96d695..a8582ad85b1e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -39,7 +39,7 @@ struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
-	void			(*cleanup)(struct rxe_pool_elem *obj);
+	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
-- 
2.32.0

