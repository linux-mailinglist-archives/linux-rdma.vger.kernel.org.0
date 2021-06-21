Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02183AE3EF
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 09:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUHRX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 03:17:23 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:54090 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUHRX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 03:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ALgTT
        lNyJohC/gelRUyFy9Y/e1ko7l4+17CX3OngbrI=; b=Ww0xhzjBZ0TerX1G/a2hM
        8MgIjIKBs56fW75osNZf7qknCraUzEy/iwbHhIPlVMRKace47dAYqwo173DX+l/c
        fdr5mfLYQCsP9kyYqMqWMjaoltACv8RcjCNit8H3nNx5nexFGxt0zVuZ8Er7jgIe
        SX70ZvnPJkf38hiB32k6dY=
Received: from localhost.localdomain (unknown [122.192.12.184])
        by smtp2 (Coremail) with SMTP id GtxpCgDn7ghyPNBgQ_tAGg--.106S2;
        Mon, 21 Jun 2021 15:15:00 +0800 (CST)
From:   ice_yangxiao@163.com
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, zyjzyj2000@gmail.com,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH RESEND] RDMA/rxe: Don't overwrite errno from ib_umem_get()
Date:   Mon, 21 Jun 2021 15:14:56 +0800
Message-Id: <20210621071456.4259-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDn7ghyPNBgQ_tAGg--.106S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWfGFyDWw43uw1DAw4fKrg_yoWfKFbEkF
        40qrs7JFWYkFnav39xKFZF9ry2kw409w1Fva1qq3W3Aw1Ygrn5CF93Ars5ZrsrZr1FgF98
        WrW2gw1xGFWrAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8GNt7UUUUU==
X-Originating-IP: [122.192.12.184]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqBS4Xlc7VCYLFQAAsa
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xiao Yang <yangx.jy@fujitsu.com>

rxe_mr_init_user() always returns the fixed -EINVAL when ib_umem_get()
fails so it's hard for user to know which actual error happens in
ib_umem_get(). For example, ib_umem_get() will return -EOPNOTSUPP
when trying to pin pages on a DAX file.

Return actual error as mlx4/mlx5 does.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 9f63947bab12..fe2b7d223183 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -135,7 +135,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	if (IS_ERR(umem)) {
 		pr_warn("err %d from rxe_umem_get\n",
 			(int)PTR_ERR(umem));
-		err = -EINVAL;
+		err = PTR_ERR(umem);
 		goto err1;
 	}
 
-- 
2.26.2

