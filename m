Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309B4588A7
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 19:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfF0Rhj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 13:37:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36989 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfF0Rhj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 13:37:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so1586304pfa.4;
        Thu, 27 Jun 2019 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZL4i/7KuhNkyeca/2ROxxthiCfU/kco2vnY/bQp+/Fg=;
        b=ROrG/UezuUfTdyR1QB2cPZkmypSfgcCkH4r2NSLZ9/gTrL16ht3OaFsaag82ayCVUf
         DIQgKHAjpmYSCdiCUTx6NM0DJubmFok5mQpxuUsZhc9CrYnxq/45+rIrnDmv69AUnm9U
         yh8UJacaxSylQ2RcVJmUm8Nz208Pnj8tZmWib3gj/OExyE+bX5SZqJAO+IMv2t9ELXFZ
         OihuAqLs5snYoV4aINibMybuzsJDj9faq0hFcDNSFcZJL++qEWjI3zFwnTlmGEEw1Uqk
         yGitGe1PCZMqzNgR6Aipa/XtU7srUX9U2Yov6PngRhkeI13fuSXmyIyAXB0k5TqbXHrd
         t5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZL4i/7KuhNkyeca/2ROxxthiCfU/kco2vnY/bQp+/Fg=;
        b=d6EAGxT2ztvOeDm7kidegQfonFZ6Z404k+UuuOIgNt5zbiHj8A0zeeg6RcocoqonQj
         ezFwMt76hQrdZHdXhAPiPgyMHhhIXORyQwJtTFdiq0/zuyEPd5XsJqhe2Wy+0Mdh3Fgb
         KCQXtJ1lR+fHc1Bwc/hxfak41B6+T9W/ld6zRRyjvHjj4qLI7jD7bNUsOKebTAf5Z0/s
         Gt3JyDRphXhJMre5J+KmCXEOGtB6NrSUN/cT+KN/3sMNT+jepBu5LbVol/2HyTI3/sge
         WXHVzFhjhEICggwuXmUzhyySfFQD9I+X5wh2CMiZcSBaR24RadDpwsDVHwsE0BHfuyDV
         7sGw==
X-Gm-Message-State: APjAAAV1qsUWYcPu6tZmrLPiuysjCI+6T6f6vm+TrN0aYFpAtsCEY9RD
        4Y2l7Wew6s1gSLnsTjMrIgs=
X-Google-Smtp-Source: APXvYqzU/gEOiq6kJE7kAKxAj1ulP/FsKNt//iFuo2fb4C//ZT0jnjdZQw/QbxqxBas8xV50VZdKBg==
X-Received: by 2002:a63:35c7:: with SMTP id c190mr4846333pga.445.1561657058752;
        Thu, 27 Jun 2019 10:37:38 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id v131sm3159902pgb.87.2019.06.27.10.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:37:38 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/87] infiniband: hns: Remove memset after dma_alloc_coherent in hns_roce_hw_v2.c
Date:   Fri, 28 Jun 2019 01:37:32 +0800
Message-Id: <20190627173732.3095-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b5392cb5b20f..a4a7c5962916 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1774,7 +1774,6 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 			goto err_alloc_buf_failed;
 
 		link_tbl->pg_list[i].map = t;
-		memset(link_tbl->pg_list[i].buf, 0, buf_chk_sz);
 
 		entry[i].blk_ba0 = (t >> 12) & 0xffffffff;
 		roce_set_field(entry[i].blk_ba1_nxt_ptr,
@@ -5387,8 +5386,6 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 		eq->cur_eqe_ba = eq->l0_dma;
 		eq->nxt_eqe_ba = 0;
 
-		memset(eq->bt_l0, 0, eq->entries * eq->eqe_size);
-
 		return 0;
 	}
 
-- 
2.11.0

