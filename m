Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCA2805DA
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbgJARtK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732940AbgJARtG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:06 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58AC0613E3
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:05 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x14so6476093oic.9
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igfUxFQ4CgEZ4GzuGjFQLf1aWZAvqukG+0VbuhxdjoY=;
        b=nmtwCFXwZzwLcTlmCpj+V82j4S4IYLxJHDQZLifq1JIGssjEkolGpJtsnVNVdPKGiK
         77+c/LpFdswiNxwe38RSq8t2P2AZpAJE/K3Z61ocGXxGKtQoz1q+8GesV+492tgDmWJ/
         /tykEH7hVckZeEoxwv9Ph0brngW2X8+NA6aIL6H8Onh214lJk4CeKZJy1awuy1f0aOnu
         cN/onq6homiORysRDSRnQaL+3w/jnpZVWehOB9lgLS0HkZRUTGfrxlc8TYt3UaHTHjLx
         +IcGD3+CkBB9Zxc3zwd3IpqRpzn3nHa+QzbkmBtY7lf3bugLzs6fS4X7Z/V8YbeJmn4U
         vuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igfUxFQ4CgEZ4GzuGjFQLf1aWZAvqukG+0VbuhxdjoY=;
        b=sMHZdYcQkoNlliBdxJ2Xnex0ZCfd8wAhbvrydb0/8YvwkChYI0AXDLmGuzQPxTkhpt
         zKNx3En2tyXzBzite7E3j+lfjPt5BZTkNqnBE+ULO1MQwY1O6ufd/TK10eRN/AT9Vc5G
         0pYjeuhOuZhWlPn46bjZo1xnELosAtm4RDgcg5pyHTvMh88i0ioxBMnTFxSWbsz9tqR/
         dgSp7ndRlvCW8Bf8ExeQi5Evnogpsyh9H2tUvXvcs/+x9gDp2xs/v2KULkegFpCx+xAF
         5ad5+/juTb22dYgVhge7vfDS6R5UDNhlKinW3QLedE9SqPVcD5676xOz4X08BRqSiihp
         yyyw==
X-Gm-Message-State: AOAM530WpSA9z+7zOu+5+xcPENYD90rFyP+S/cAsI6LFykfbTLoo9DRv
        MiaQWMXHxJdxsnrM8YTntOEFjqCzL6M=
X-Google-Smtp-Source: ABdhPJztfxyKxe2IT0rRg+M4ZdFqLlGuwlqZN1bhB0P70pUWTJfmRBIYNawF3NBnCNIr4+1YiY3NAA==
X-Received: by 2002:a05:6808:95:: with SMTP id s21mr738109oic.120.1601574544657;
        Thu, 01 Oct 2020 10:49:04 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id z16sm1365866oth.43.2020.10.01.10.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:04 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 12/19] rdma_rxe: Add support for extended QP operations
Date:   Thu,  1 Oct 2020 12:48:40 -0500
Message-Id: <20201001174847.4268-13-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add bits to user api command bitmask.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 6be0aa9cf1f3..4de263e41b07 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1188,6 +1188,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	dev->uverbs_ex_cmd_mask =
 	      BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_QP)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_QP)
 	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_CQ)
 	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ)
 	    ;
-- 
2.25.1

