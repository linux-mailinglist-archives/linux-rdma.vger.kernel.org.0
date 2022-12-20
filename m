Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42064651FB4
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Dec 2022 12:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiLTLbd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Dec 2022 06:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiLTLbK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Dec 2022 06:31:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA94219295;
        Tue, 20 Dec 2022 03:31:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso11838178pjh.1;
        Tue, 20 Dec 2022 03:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ue5drNbkBvKVzpPDG78ZMfbrHrE9A5Ia9TcUjCSfCo=;
        b=m5ESKvT3Lf0CT9weWsfxqVpy1q9ZvbcLvSundZywEFYQEH5yXW5k+2ZrrKlnPsgxK8
         +2SbLpoj+YfpyhPNVvVqFCsKkmctQLGIu6NzUdOYm7kbT9awps9bcn5VgcpjBXEyxvTc
         ovkKDmcHJ0Ifco/pZI+bxsQO8XfpkMg7QreIoU+tik2Lx7DFX+L6aTOr6qLj5XaysIo9
         gqvjojE7osPcGGc84kXE7KvYSM2lmv5GnyuvxqWM6Jxno//iKbgKL4wWE/AWy5K2NuVk
         6A/TqhOWZ5V1ej2FpGgXS116W/XsZ4m8saXKe205ZRWd6Ao1VamJzCdqnGQ65Awt1Iaw
         rThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ue5drNbkBvKVzpPDG78ZMfbrHrE9A5Ia9TcUjCSfCo=;
        b=hAqB66ZuxCQUVkuVE+H7NfnvjvKkY9/7NrC1aZVbR5Go3g/lBdtoFEMpWePRRkxNH1
         yEIdPrubLFiRLlfXYDXOc6G27DIjMT0mJkzrqLLTMLQpT17VkE8DzceKzdRH9Y+RGk4U
         Q3g95wra101D5N1rRyKF5eOxkDJJOuqN+l5YrbUUb6NziDYfsliXPIZy85XK3X7WdTwN
         TPZqUby9tiz4HBCjXdf3QWXz5oy2CQMr7yrQg8rz3JmDI5J+qHaWPgI+2vp2ylrQxenI
         oMpk8FiPixrbjRSrfz4nuu78zbGnPFqq1hd5UjLl/F/6NzdKGy/oFt4DHLWhCoF3P0JN
         kuug==
X-Gm-Message-State: ANoB5plr/xxtzlQzorEhQPKOg8l9hfmtkVPW2ktdOk6e7YlP0xX85DWa
        CjeiSIDmsmlqrl11hsl8++0=
X-Google-Smtp-Source: AA0mqf7DsevXhPH+pg5x4yR1bV/jgh97+nllSGVEptRsYXvX/5pCbpKmv2jrsggHJl6z4SFRO+8O9w==
X-Received: by 2002:a17:90a:f191:b0:21a:1b9b:139e with SMTP id bv17-20020a17090af19100b0021a1b9b139emr47606235pjb.8.1671535862337;
        Tue, 20 Dec 2022 03:31:02 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id om7-20020a17090b3a8700b001fde655225fsm1610785pjb.2.2022.12.20.03.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:31:01 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Yixing Liu <liuyixing1@huawei.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] RDMA/hns: Fix refcount leak in hns_roce_mmap
Date:   Tue, 20 Dec 2022 15:30:47 +0400
Message-Id: <20221220113047.1463078-1-linmq006@gmail.com>
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

rdma_user_mmap_entry_get_pgoff() takes reference.
Add missing rdma_user_mmap_entry_put() to release the reference.

Fixes: 0045e0d3f42e ("RDMA/hns: Support direct wqe of userspace")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8ba68ac12388..fbff8df9236d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -443,6 +443,7 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 		prot = pgprot_device(vma->vm_page_prot);
 		break;
 	default:
+		rdma_user_mmap_entry_put(rdma_entry);
 		return -EINVAL;
 	}
 
-- 
2.25.1

