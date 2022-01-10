Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E771E48900A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 07:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiAJGMl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 01:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiAJGMl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 01:12:41 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1183C06173F;
        Sun,  9 Jan 2022 22:12:40 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id p37so9772903pfh.4;
        Sun, 09 Jan 2022 22:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=G0XQuPGpZl9vyVbKA/VASVbxw7UV1VGxrL0LODj5aMM=;
        b=JrNVxScedaJ1fTanQn8oKktRxHJNAz/XrEXXQOkzL7pgOARtT3tJMgPygFWwmLC/K9
         AYDRTHApbBrfKL7wNUUcKZfgFhq1eak2+vC9lp7idoz/p6JiJ6bterCbp38EOeD/CPAB
         RdbMCk6nXCF1caSU7VIrNjB1g7VKA+KyvJjvZkvWGwZAwAZFiHC5KswEqvNjuodUgnUG
         a0G893nc4DKq9KuWGVWxRmT2rB+ZxT7hrnv0q5+zWfLALt7XDB+UYTeIvhRQRBVWWRVv
         xmaGN1eFZU8czi5N3Owb+fmXgDQsKhOdqKrBUkbpMbgD5gbrn4HuSYeOGrZkoCz7rMX4
         M0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G0XQuPGpZl9vyVbKA/VASVbxw7UV1VGxrL0LODj5aMM=;
        b=jbsIiuzmxh0L2KTz8veyr4CTbTYJIrbBZsxPlyz5qYU4psNiZ0f1qptQJ3lPAZg5lx
         9CytrqS4EhWFCwY4lQy1S0D0JM/hhQ9DDIHKhI0KAVMrm9GOdO8AInBKCOH51auRxPfQ
         FhwWY102/xc/nBPhVRqncd+TmSvM0nQAiZiiCorD/2XK80S00zfEGa6CeZVEks7OmAfm
         YM8fb91iHqxTIcQ8OFWucldFG0Wy8MXLiydkYvOzPLQ4IeAj161/B8OtKfrGEC6w8zWW
         DGZ4muBIuA6zI2NPQOL3HC2oScAAcEvZaOZs5j1e4fTgNJhKidi3IfZ0PZOdiDnquCtc
         rMKg==
X-Gm-Message-State: AOAM532tpnfKFzkv8ETInGPPbuou5jwxDnyBSjEqsjcndfWYgX7JkQXe
        LSZKRuuHB3IJkXr6fibR8Hs=
X-Google-Smtp-Source: ABdhPJzBP770PAyxbRPOntNaZi3uec5k5SohXkL+nOW9GsDdHXbg9tkuJ3wtaOAsXyyD2mIOsNZKIw==
X-Received: by 2002:a63:7303:: with SMTP id o3mr7890360pgc.280.1641795160352;
        Sun, 09 Jan 2022 22:12:40 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id x4sm4728074pjn.56.2022.01.09.22.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 22:12:40 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Shaobo Xu <xushaobo2@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/hns: Fix missing put_device call in hns_roce_get_cfg
Date:   Mon, 10 Jan 2022 06:12:34 +0000
Message-Id: <20220110061234.28006-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore. And hns_roce_find_pdev() calls
bus_find_device_by_fwnode(), which calls bus_find_device().
We also need to drop the reference taken by bus_find_device.

Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index f4af3992ba95..1bffeba55304 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4545,6 +4545,7 @@ static int hns_roce_get_cfg(struct hns_roce_dev *hr_dev)
 				hr_dev->iboe.netdevs[port_cnt] = netdev;
 				hr_dev->iboe.phy_port[port_cnt] = phy_port;
 			} else {
+				put_device(&pdev->dev);
 				dev_err(dev, "no netdev found with pdev %s\n",
 					pdev->name);
 				return -ENODEV;
-- 
2.17.1

