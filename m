Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2803BA064
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jul 2021 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhGBMdJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jul 2021 08:33:09 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:57044 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhGBMdJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jul 2021 08:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gOwYy
        SPv8mzuPO5MlUX9RFo5AUOv7uwpovexlFnmoHc=; b=TKKi9XM1PsMDv0NURIOgv
        5maAdco3uABdfwnEkSTlhpnmBxQ8GEESyjDkMapopyfwExPsKA9iQgvS2TAZqkJf
        Gaw+2GE5Egh07Wngd1oXKMjy6vvAmj6nJ6xbB6qweFh+wOMi2V9tqspXtnU9Rg7N
        WKg99na7A6ZBF8K6Dud9no=
Received: from localhost.localdomain (unknown [122.194.0.182])
        by smtp1 (Coremail) with SMTP id GdxpCgAniFviBt9ghMygHQ--.120S2;
        Fri, 02 Jul 2021 20:30:27 +0800 (CST)
From:   ice_yangxiao@163.com
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Remove the repeated 'mr->umem = umem'
Date:   Fri,  2 Jul 2021 20:30:24 +0800
Message-Id: <20210702123024.37025-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgAniFviBt9ghMygHQ--.120S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7YL9UUUUU
X-Originating-IP: [122.194.0.182]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMwPDXlXl9afuWQAAs4
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xiao Yang <yangx.jy@fujitsu.com>

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 6aabcb4de235..487cefc015b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -122,7 +122,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		goto err1;
 	}
 
-	mr->umem = umem;
 	num_buf = ib_umem_num_pages(umem);
 
 	rxe_mr_init(access, mr);
-- 
2.26.2

