Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA86475D5FB
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGUUvO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGUUvN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:13 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E74D30E2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a3ad1f39ebso2213344b6e.1
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972671; x=1690577471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6c0b63QWNURv57zuWgFkjRO3WOLWYqhIFu4BCOLKlg=;
        b=kmnAbSd+vtg0GhXoZcDkvrgx9Vquuva7SErkSDQEzNR22J1OXwub0vNBjVYK41r//T
         g7kbwjbsiP/yqQubQuvAvZFAFv23LXbCk1DZIMJT8KVFMcmKxaLSCojUF7lyItpQCRjZ
         AYORi/WQrH/JkWytX8RsyuNEClsLfc9VgbxnPXR0g6tN5SwPyOe1s8eHm6T56zjRVCwz
         7AUWUn62ZwfzrV1PTAFmvcuC8Y/82B2M1/hLVHHy3e5xKBuYBJAsvwgEIc3idbG/Yljc
         tvc2Z9dtnjpRAasmjobVYC8cquqYUBHpkyUYTAulEps21KgTeDEFg9aaBes9uIQwxb1J
         ckmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972671; x=1690577471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6c0b63QWNURv57zuWgFkjRO3WOLWYqhIFu4BCOLKlg=;
        b=aQUl+06BTtyz+GeOtYD4kHaLKe7LcvfLkM+xFKgx6wKkOcLUnccuyozILM7KMWfAQ7
         uX5jPBfbSs9NtHs+LnFfvdN+Lg58ZkytB1OAyNfoyX8hmq/A1cU8NNMhZ7yWBEbHCIvl
         rMLCbSAp5Fxxc3kwSc3/M4LzLe1SVVp3AxFcQSxsDGIP/k81uu8Ykm4pLBFUfDv70sL5
         r2NWNpOXT8eeVtlePqRzeLRDoD8fQfgtvvCyNasbtbu8xzMQOtfi22tKy56o7LvDrjl5
         FyOzPVZj41qtMLbLVspYi7FoG796AF47IMZv3bUSGteKR6IIUHZk6W2jEHGV5tvxQm2p
         sMVw==
X-Gm-Message-State: ABy/qLZdod7q7rloseRmrSD6wtVUSQGZUdCQpXpN1YTYWJBKimZIbVri
        FbZLy+XwTc46kECf1QsO0jk=
X-Google-Smtp-Source: APBJJlFM8hJ2k1sj3iyym6LGYueDgUoQJkbGX22oTLLdRpfi/SOd4E4aZ8k9UZUjoRepDhK9ogbwyQ==
X-Received: by 2002:a05:6808:2a5b:b0:3a1:e792:86f3 with SMTP id fa27-20020a0568082a5b00b003a1e79286f3mr2110611oib.2.1689972671400;
        Fri, 21 Jul 2023 13:51:11 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 6/9] RDMA/rxe: Delete unused field elem->list
Date:   Fri, 21 Jul 2023 15:50:19 -0500
Message-Id: <20230721205021.5394-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721205021.5394-1-rpearsonhpe@gmail.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

struct rxe_pool_elem field list is not used. This patch removes it.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index efef4b05d1ed..daef1ed72722 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -23,7 +23,6 @@ struct rxe_pool_elem {
 	struct rxe_pool		*pool;
 	void			*obj;
 	struct kref		ref_cnt;
-	struct list_head	list;
 	struct completion	complete;
 	struct rcu_head		rcu;
 	u32			index;
-- 
2.39.2

