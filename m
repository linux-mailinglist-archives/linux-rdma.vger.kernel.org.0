Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F65A654CDA
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Dec 2022 08:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLWH3N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Dec 2022 02:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWH3M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Dec 2022 02:29:12 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7629DDF24;
        Thu, 22 Dec 2022 23:29:09 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so8089783pjp.1;
        Thu, 22 Dec 2022 23:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yw9A9yDRou+SgBuMxTAj1XCzlTZaZEsmvQlTnHCOqi8=;
        b=Za4UBmWPUBlUu8mceW2dmcOspKc5HL3FoyHS/DABwwdSM0V3Ome7WIEms7WjGXdT7f
         +g/+1g7iUj0NkGqmDG/yq1KOZ+lo2VthXmLaZUbtn0egbjBpHyH+yTuxz/9p4B0azEjr
         s6PwfXfS482oGDuVTrmAgrzGX/52vwGzIjW5/2G9GKxo6Qfii1bZSMyEweNMwcQJuB9q
         3V/v8Lb+yQrKyf5wgsVMFm6/CHeyKzUyK4ItUN6n3eOTMZKZyeMlCei6/8UNLkcprfd9
         tS/Tip/k+gs43hvU7QCH4oUIETmpNG1k6lz9vOBFqiH/ejJkN7zqPqdhGE4oU3q0TlzF
         KHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw9A9yDRou+SgBuMxTAj1XCzlTZaZEsmvQlTnHCOqi8=;
        b=6CfhcO4Eovj1HR8vOF74BIXL9ba8D4cZPWtCfyMIRR/uwOjh7QdXVAmO2a2hA1FBXJ
         ThPWdkVYkARQEqwvgV0W5kZeqfYrJt92KjGIEfc3y4bY2OngXJVPaiB2ECOwHSOK67H9
         JhKKRFUhdhVL9QOTPDxQqC3j+8Z5uuHbQXQEqKAkBMFgB8aCFfzgWCK1sPIDCTw7G3WO
         sZlQ687/2TwmxbOMOPp6H+h2TjsBuDypMO1G9apXAedH2p0A4dTnPRlGCjcteBu06E+T
         zUCKdh17BIDVHxh17lk3AMeY1c1kUQvJMksvFgxv7GxOAcCRd7DPGOqCLF8+/tzsaETz
         HnBw==
X-Gm-Message-State: AFqh2kr0jwvcOwIiC1DUHiVQWh88jSlo3s1DbMCjfE8T83pzWFjh2bsp
        7SF3W2vn0zbW3VvTV3Kp/NI=
X-Google-Smtp-Source: AMrXdXuxvFe0OV/SJTb5xKE40jcGUrHlgjqvgGyW2m/VD4Q/W0aRURLMwrwV2t3oIaI0viDooaxzTg==
X-Received: by 2002:a17:903:40ca:b0:192:4a7b:ee27 with SMTP id t10-20020a17090340ca00b001924a7bee27mr9390055pld.53.1671780548806;
        Thu, 22 Dec 2022 23:29:08 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id m12-20020a170902d18c00b00186bc66d2cbsm1722921plb.73.2022.12.22.23.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 23:29:08 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Yixing Liu <liuyixing1@huawei.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] RDMA/hns: Fix refcount leak in hns_roce_mmap
Date:   Fri, 23 Dec 2022 11:29:00 +0400
Message-Id: <20221223072900.802728-1-linmq006@gmail.com>
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

rdma_user_mmap_entry_get_pgoff() takes the reference.
Add missing rdma_user_mmap_entry_put() to release the reference.

Fixes: 0045e0d3f42e ("RDMA/hns: Support direct wqe of userspace")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
change in v2:
- use goto label to manage the release.
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8ba68ac12388..946ba1109e87 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -443,14 +443,15 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 		prot = pgprot_device(vma->vm_page_prot);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	ret = rdma_user_mmap_io(uctx, vma, pfn, rdma_entry->npages * PAGE_SIZE,
 				prot, rdma_entry);
 
+out:
 	rdma_user_mmap_entry_put(rdma_entry);
-
 	return ret;
 }
 
-- 
2.25.1

