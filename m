Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809073AE3ED
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 09:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhFUHP1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 03:15:27 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:35878 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUHP1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 03:15:27 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 03:15:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=E8shh
        JWcwBpmHkBlEetPZriakHompEmmpzv94XAorH0=; b=AI0Rl1s8NJntRa+ZVmxrJ
        Pe/I7dLNBwnXZbIqcu4raReeNCN+UMiFe5obxUvd5FNpPvYN87FBHiYOu8ywhY0Q
        nBCVftaUN3Qw7QM7h9v9gaE3br9PraKISi9Y3bAYGJ9WAfvqbFgyrE/KbMnJBG6C
        5m7HQtqSAv2Jugn8uIFLmE=
Received: from localhost.localdomain (unknown [122.192.12.184])
        by smtp1 (Coremail) with SMTP id GdxpCgAHS71vONBgm5H6Fg--.154S2;
        Mon, 21 Jun 2021 14:57:54 +0800 (CST)
From:   ice_yangxiao@163.com
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, zyjzyj2000@gmail.com,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] RDMA/rxe: Don't overwrite errno from ib_umem_get()
Date:   Mon, 21 Jun 2021 14:57:49 +0800
Message-Id: <20210621065749.6596-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgAHS71vONBgm5H6Fg--.154S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr17uFy8AFy7Xr1kuF1xKrg_yoWDJrbEkF
        40qrs7GFWYkFnay39rKFZF9ry2kw48uw1FvanIq3W3Aw1Ygrn5CF93AFsYvrsxZr1FgF98
        Wr42gw1xGFWrAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8GXdUUUUUU==
X-Originating-IP: [122.192.12.184]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbBQxK4Xl++MEFzLwAAs7
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

rxe_mr_init_user() always returns the fixed -EINVAL when ib_umem_get()
fails so it's hard for user to know which actual error happens in
ib_umem_get().  For example, ib_umem_get() will return -EOPNOTSUPP
when trying to pin pages on a DAX file.

Return actual error as mlx4/mlx5 does.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
2.23.0

