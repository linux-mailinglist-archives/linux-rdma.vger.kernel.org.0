Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70491652036
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Dec 2022 13:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLTML5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Dec 2022 07:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLTMLt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Dec 2022 07:11:49 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590B15A03;
        Tue, 20 Dec 2022 04:11:49 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x66so8378863pfx.3;
        Tue, 20 Dec 2022 04:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iqT075hnRTX9sxEK9bybY2wGmKzOFwkI+lpZrSw8cU=;
        b=nQpZPixpTkhHJ9tzM2er3cIgH65EF1oqkv9m79SZOfE3D3TUEAUPViwubl89wiSJbs
         TRPmoImnBCTYJ3rR/Vwd80OJ26UGUOa6CJmTKYsX3KsVFzuAcOKixQunUGwvSk+hd30Z
         qJ88zthuTbiwRMZYu1rZytSf2Q453q/TmuuaJupesf6qBRQdpv9DO+tUhym+asXpARUk
         /53+NwaxqpdCoZc5sFayIOSlc1mzijAOJHtRbK94aBDpUwArH4/w7MHyJCr5Rpa3LJrm
         wJ87qPoC6tzb6tUKSe8j7IB4bBzJKDnZX68V2DAgTxUsujqVZfTeidgFCNLamR3Ncqgf
         xvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iqT075hnRTX9sxEK9bybY2wGmKzOFwkI+lpZrSw8cU=;
        b=A46ZhXpRFm1WcpYO8J2HKCOiRQVCt21I72MBUn6Pbf6HaOZSBGiFhA087FDIFc8fx7
         3cXj8IUNWqrOJQ1qTabiAz0TRAOls5vQDoRDeLgcRz4KEI16DF+fUbiEOBby6FahnjSG
         tdLjRzrQblghO9j3qcmDBe5rooFqeim+hOPvSMTIHvx1ZFPW64A92N3BXxBQp25eFlIP
         Su5gNS2Ez1nIhwab39GMV74noCdxPPXR/THHLynMO237KQAUybMZeQeq6o2SaNC7JwKa
         N9YO/cLGuJyLckcE49fQK66GzepkiVdVtTWCISKH6eCjWLg//fITg/UTizEaprdyNKHk
         ke/Q==
X-Gm-Message-State: ANoB5pmf7fEYeSE3IhWKY64dpJiWy4tV4nByunqtJuwCXF03cMBLK7zw
        qJf+Vo2EibZpFU5CWQOViio=
X-Google-Smtp-Source: AA0mqf6Fgzevhw2zoVKDhk4kFhmaW5L6jIMMV7zJImvjgGh9BH0/al1KOQTgBFBcP4MaWejMkNLXFg==
X-Received: by 2002:aa7:81ce:0:b0:577:6264:9d0f with SMTP id c14-20020aa781ce000000b0057762649d0fmr45671401pfn.6.1671538308477;
        Tue, 20 Dec 2022 04:11:48 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id k18-20020aa79992000000b0056d7cc80ea4sm8525532pfh.110.2022.12.20.04.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:11:47 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] RDMA/erdma: Fix refcount leak in erdma_mmap
Date:   Tue, 20 Dec 2022 16:11:39 +0400
Message-Id: <20221220121139.1540564-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rdma_user_mmap_entry_get() take reference, we should release it when not
need anymore, add the missing rdma_user_mmap_entry_put() in the error
path to fix it.

Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 5dab1e87975b..9c30d78730aa 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1110,12 +1110,14 @@ int erdma_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
 		prot = pgprot_device(vma->vm_page_prot);
 		break;
 	default:
-		return -EINVAL;
+		err = -EINVAL;
+		goto put_entry;
 	}
 
 	err = rdma_user_mmap_io(ctx, vma, PFN_DOWN(entry->address), PAGE_SIZE,
 				prot, rdma_entry);
 
+put_entry:
 	rdma_user_mmap_entry_put(rdma_entry);
 	return err;
 }
-- 
2.25.1

