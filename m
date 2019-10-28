Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE61E75B4
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfJ1QAJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:00:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45972 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfJ1QAI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:00:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so10439366wrs.12
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hAZ2TrIIVcLEbxIdOVbHEBWi4WBUQuacFKnyYRaMGgU=;
        b=sgw7ru1DsRo0TyXW0gHHwXcUYoy+N9LoqhPn0HrKLDmEj5RMM9FC290GeyhCJarlTl
         xiZoM2i4JsCUz+EdoucSFIKFnYWchVGBqtgYvTTd3Cd8zzyrXJC67jFvyNGr+HxVA05M
         IzXeZfFgOrAGgEL85XuHE1T1xxwkO85YP/MSb6C/acfMwbMxENwqpl8Fg5tNG9GE0Tgm
         SNPDkZrj9scF2nNWboyabzcpTTW0mCYnT37yhDxLaQTU8WLxifKb4dMn2C+m7s1pub3T
         Thh679+YZ6ak0SZOSjuwZN9k9kQqovRn0BbXIrgCzrNvrLYrRaG1bs9epLXtSStLrnDL
         g2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAZ2TrIIVcLEbxIdOVbHEBWi4WBUQuacFKnyYRaMGgU=;
        b=BcBW/Sm0s3/q3Jr5r3m0ixy1QJIygTswFzptHAzc1ODXzZTdlwS7MfTvpVFxw0vw/1
         ARcRBHLkWffEAssfYdwFZwvNvjHKkLy775W9NM0nDQsVssXj8M5MmidYLhiMSD5tr1nC
         jgfz/EkgkN+odtAxKic5m5vNDHbgkiXnIuH+WLPc0EB9o5dQ8Orn+FF7x+kILbSo1HpK
         IOaRDr5Qu8pNspSRMqZB0R8fI+nUkxACzJNh5In0/ZUpoP9foSDO33W+QPkao8bwMjTm
         bLmFAIAQbzJZekM07kHLIHtSiZ8rVRDvYEAleNU4rFlCdin0tZMc6w7dIVc+zs9WuH/2
         UKgw==
X-Gm-Message-State: APjAAAWTs3ctVEuljsmm6LW/LIyY5gOWC028jrsGmRkEOj6iHFI0TJz6
        U4t1TCDwIYsRqd4yNZog9Ax/xp7ektw=
X-Google-Smtp-Source: APXvYqx/Qip1QWATRUNuH/1/EXxcoVRshNmsztmj4ogu45KgSTh6KHOmeZrQHWM5VJEegT4FnxCDuQ==
X-Received: by 2002:adf:e886:: with SMTP id d6mr3105482wrm.188.1572278405106;
        Mon, 28 Oct 2019 09:00:05 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id a2sm11871600wrv.39.2019.10.28.09.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:00:04 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [for-next v4 2/4] RDMA/hns: Remove unsupported modify_port callback
Date:   Mon, 28 Oct 2019 17:59:29 +0200
Message-Id: <20191028155931.1114-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028155931.1114-1-kamalheib1@gmail.com>
References: <20191028155931.1114-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b5d196c119ee..b241f74a7e3b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -301,12 +301,6 @@ static int hns_roce_modify_device(struct ib_device *ib_dev, int mask,
 	return 0;
 }
 
-static int hns_roce_modify_port(struct ib_device *ib_dev, u8 port_num, int mask,
-				struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
@@ -438,7 +432,6 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.get_port_immutable = hns_roce_port_immutable,
 	.mmap = hns_roce_mmap,
 	.modify_device = hns_roce_modify_device,
-	.modify_port = hns_roce_modify_port,
 	.modify_qp = hns_roce_modify_qp,
 	.query_ah = hns_roce_query_ah,
 	.query_device = hns_roce_query_device,
-- 
2.20.1

