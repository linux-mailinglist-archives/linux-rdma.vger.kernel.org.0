Return-Path: <linux-rdma+bounces-4388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD7954695
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 12:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE411C21C87
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738517BEA0;
	Fri, 16 Aug 2024 10:16:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018FB12BEBB;
	Fri, 16 Aug 2024 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803404; cv=none; b=bNi1tIOYBdEtaGfmZ5OoQAHxUqBQBQbwf8I0e9YMDtc6jzmJGb51IL6YTJQ7nac7Kbfzsk612+fQ7L4QX0DunlZEm49BGIHW1wVb5zizON56swmpYdyY5OBVCu1uMR+/dVHxJC0gOu4dBovYOWbTAzRxZOD3eeI307bU6ytqzFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803404; c=relaxed/simple;
	bh=908+/Ni0Cz5qXUJx7pkuFQX9zuFdBYpwqWwGm9IYaFA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A397sKwmDQX8VjActgadqOnLnhgpYRv00dTs5T+/5prwCekg1MWps8LQGyCG1kSgyvEJxVPDh0OQRmUy0JiV3gPUqTz9R5U6c+jEZznzj97uK3HLEakM58krtulu7izorSsoPGH15whSP8W5R9Ur0+H9/Cv7+NjprVMZKv7+9VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wld7w3rh6zQq1X;
	Fri, 16 Aug 2024 18:11:56 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 220531800FF;
	Fri, 16 Aug 2024 18:16:33 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 18:16:32 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <leon@kernel.org>, <jgg@ziepe.ca>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/mlx5: Remove two unused declarations
Date: Fri, 16 Aug 2024 18:13:58 +0800
Message-ID: <20240816101358.881247-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to
mlx5_ib_dereg_mr()") removed mlx5_ib_free_implicit_mr() but leave
the declaration. And commit d98995b4bf98 ("net/mlx5: Reimplement
write combining test") leave mlx5_ib_test_wc().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index be83a4d91a34..c0b1a9cd752b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1372,7 +1372,6 @@ int mlx5_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 int mlx5_ib_dealloc_mw(struct ib_mw *mw);
 struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     int access_flags);
-void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
 void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr);
 struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 				    u64 length, u64 virt_addr, int access_flags,
@@ -1653,8 +1652,6 @@ static inline void mlx5r_deref_wait_odp_mkey(struct mlx5_ib_mkey *mmkey)
 	wait_event(mmkey->wait, refcount_read(&mmkey->usecount) == 0);
 }
 
-int mlx5_ib_test_wc(struct mlx5_ib_dev *dev);
-
 static inline bool mlx5_ib_lag_should_assign_affinity(struct mlx5_ib_dev *dev)
 {
 	/*
-- 
2.34.1


