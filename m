Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D00588A5
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 19:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfF0Rhc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 13:37:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33205 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfF0Rhc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 13:37:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so1592691pfq.0;
        Thu, 27 Jun 2019 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BLMVUVWLfUSeBD9kki9dDCqM/hx+KKbWocCf5lMG6C0=;
        b=Xkc5fBvRkB1u4fFbIL+tQVZF311r9w6IqIAHoiu0U2g0O3KHu6+IaT0h/giIsZ25hA
         dFG/zFPsPrI5ipg8dOzOIMfkFwjAjntU66rUjL5GKE3HU2sJKnn51eLbgIAZQUyfGNFX
         6YY22zUArWKfvJ62yMNxXtU85FvjgC4m44isE95xeoAXDNvwsvTJDzUtZ2X5zyf+fAGW
         lpDP5K4XCHVnJ89xDYT8+Wb7NjHT6gnNfOKb0Rv3zd57i2D0JoQ4ol6vC5PM8VH13E7w
         unvyxK9LXXXIKQqqu9T/MvIAliatbfClP0bEJAucQeHCUJ1nYf8ieHsdN2guYKQrLfIh
         o5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BLMVUVWLfUSeBD9kki9dDCqM/hx+KKbWocCf5lMG6C0=;
        b=fq33WBwzCMLJvR/AnZRnAZA7m/b3kPqtgAzX1hWjUT/AsctBSIMU9YPax0bBmtCDV6
         2V+1ZxfukiRrg5aXEXSQOjlv2C1o+W7klQ6BEBbxyLSPThElS8UrIDVndEWI3biWiAlS
         vrNE0n1iZd7/7yXr0BSmKdeFJVpZ57GbGQCu45mdAh0LgF/T8tDh/nshtN/TdH+woU43
         hrrIqggyY14k72Hqlt9bdJeXptQoa00vnhdekn3PaRtsL3QvlLaJ2uDqvgtDVTvS27h/
         SFetxNvcWkU3C1wQe16unikirwBpb/PID3TMWYuvFUTOoytcjjsNNcqwuvZt7i4Vqh9O
         J92g==
X-Gm-Message-State: APjAAAW0lJiePtJHo3ERjnPonODlrn6/qXANxKVkC2pntfpaFPFvDhKA
        76RJ+6ZxrPZWFnEVX6PotdM=
X-Google-Smtp-Source: APXvYqzUIxmyTTIjwE/lm4VU9sDP6Lzn9UTBnothx84n2fC1nDEMxPFmoVz+4kBYdJnUzAlHVvksfg==
X-Received: by 2002:a65:50c3:: with SMTP id s3mr4806631pgp.177.1561657051178;
        Thu, 27 Jun 2019 10:37:31 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id x65sm3515087pfd.139.2019.06.27.10.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:37:30 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/87] infiniband: hns: Remove memset after dma_alloc_coherent in hns_roce_hw_v1.c
Date:   Fri, 28 Jun 2019 01:37:24 +0800
Message-Id: <20190627173724.3043-1-huangfq.daxian@gmail.com>
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
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index e068a02122f5..36d9dcaaa8f9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4265,7 +4265,6 @@ static int hns_roce_v1_create_eq(struct hns_roce_dev *hr_dev,
 		}
 
 		eq->buf_list[i].map = tmp_dma_addr;
-		memset(eq->buf_list[i].buf, 0, HNS_ROCE_BA_SIZE);
 	}
 	eq->cons_index = 0;
 	roce_set_field(tmp, ROCEE_CAEP_AEQC_AEQE_SHIFT_CAEP_AEQC_STATE_M,
-- 
2.11.0

