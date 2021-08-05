Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745023E14AC
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 14:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhHEMZ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 08:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHEMZ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 08:25:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099D5C061765;
        Thu,  5 Aug 2021 05:25:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so14391484pjs.0;
        Thu, 05 Aug 2021 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJbk09k54JECCeJwupO/QMHjbng2VO6NZjwCFKC+4og=;
        b=vIiUOLk4ymGEs3kUO0OWcoeOACqc67F3aml1Sb5fmkRU07Owvljl4FI9i17uDQ+o3H
         MUNiCsgvqCGXkub+4h/T8GAjFUG5Qvssi3Cl2z6aS1LG638Fd+7L2x+ETRFF35WAF2MP
         MIy9wW8qqhCQjkP8V8s1qilD/Uv0tTK8Cs5l+E+0sJU1k5yYBPjL0eN3F/lSt8eFSiO2
         UONwmUHQ7fkOXIgEa71YlLWSOoKmgDyPTaxBvknMP1uV3+RuJ77S2Dm2rpnYDu0HQweV
         DR49upmccKgF5/fIxwbK1KMdBPk6z3HCiKdHWVFcnobHcCPz7af2Kh7HvmvWey65JlwI
         zLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJbk09k54JECCeJwupO/QMHjbng2VO6NZjwCFKC+4og=;
        b=svmDQX4KtNNDq+zyccH3C96P25HoeBxylKtVY1En60WwmiuMK8ZgAQeLEekfWUWwUE
         loes9gSuvm+0kPZlEK32pNjjyL6Ve7dmqBhKp6/7pSvG0woofi7AZ3Hc9JEw2fYv8ZBV
         nkmk4PSzLUV4ivgMv0COKvAVB8XJiyXScVKAjF5eGFfSAx4HPuvf8E/HmrR2t8xlUM+K
         lHf58xqeLEo0aOBxUZw6Y20p9Rla3Z/r9+1cPF9U/DCv8uOG1LziRMBKYVy/um6NEhfN
         rPGgPE3xDLONmHheQAh/0PhZiCW3JqgSgahKig3VtYYnSexi0UNlsYMYPZ7u6B0lhN+j
         DHCg==
X-Gm-Message-State: AOAM530RmezU4gRmHhE7opnntp3iZh7YiVQ4JrErMjpKfo1EMn7OgCoj
        L9GMT3kIC5Y0Qxb181DE2abWfIMaQyRSLg==
X-Google-Smtp-Source: ABdhPJwmkwA0iGRzHbQiSWzVXohzJrVc80mAqOSVmzENEENf11fckshBMIKix9T+tilGqhN3Qu8P/Q==
X-Received: by 2002:a17:90a:ca93:: with SMTP id y19mr15517752pjt.142.1628166341613;
        Thu, 05 Aug 2021 05:25:41 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.81])
        by smtp.gmail.com with ESMTPSA id o8sm5970906pjm.21.2021.08.05.05.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 05:25:41 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Tuo Li <islituo@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] IB/hfi1: Fix possible null-pointer dereference in _extend_sdma_tx_descs()
Date:   Thu,  5 Aug 2021 05:24:12 -0700
Message-Id: <20210805122412.130007-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

kmalloc_array() is called to allocate memory for tx->descp. If it fails, 
the function __sdma_txclean() is called:
  __sdma_txclean(dd, tx);

However, in the function __sdma_txclean(), tx-descp is dereferenced if 
tx->num_desc is not zero:
  sdma_unmap_desc(dd, &tx->descp[0]);

To fix this possible null-pointer dereference, assign 0 to tx->num_desc if
kmalloc_array() returns NULL.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/infiniband/hw/hfi1/sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index eb15c310d63d..00e29c3dfe96 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3079,8 +3079,10 @@ static int _extend_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 			MAX_DESC,
 			sizeof(struct sdma_desc),
 			GFP_ATOMIC);
-	if (!tx->descp)
+	if (!tx->descp) {
+		tx->num_desc = 0;
 		goto enomem;
+	}
 
 	/* reserve last descriptor for coalescing */
 	tx->desc_limit = MAX_DESC - 1;
-- 
2.25.1

