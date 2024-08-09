Return-Path: <linux-rdma+bounces-4263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67B94CC42
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 10:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B39A1C21FF1
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 08:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93318F2C5;
	Fri,  9 Aug 2024 08:34:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1449172777;
	Fri,  9 Aug 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192445; cv=none; b=s6CadY7URLOQsfkGlkOtVaPjIvp+cfS3pqUi8uh9cUyP3vjPav0kwLCu3Nnrenb1biJ9XClqgOpCIUpszmVE4TGBdhAVUz/aNVTxiWHEHpbD133p2kmDWpA8dGL6RN8kvasotGXr3p+FIcIHDkP0hZ1rqvJzo3R7qw0bbMlVai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192445; c=relaxed/simple;
	bh=TX3HGDVxWuOflDsmvz9im7nGaQb1U7mshaR7GJs95eY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/n6D+h+TryUYsUllUkHdtxYjkSo68xKbqGMUE8noNN3LCGrtwBBew9EYoUhj5PmE4T4/XDdcqjoaWqhYLUtkfBxjQAnzh7NigtoJMrgYvctgT8PQlzIdxFUelQ7YNiY3HHSct+xK0Em7wBN9dp8a+eYNA2vZEahSbXw67sFur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WgHBz0dnXzQnS1;
	Fri,  9 Aug 2024 16:29:31 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id DAE3314022D;
	Fri,  9 Aug 2024 16:33:59 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200003.china.huawei.com
 (7.202.181.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 16:33:58 +0800
From: Liu Jian <liujian56@huawei.com>
To: <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <zyjzyj2000@gmail.com>,
	<wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<liujian56@huawei.com>
Subject: [PATCH net-next 1/4] rdma/device: export ib_device_get_netdev()
Date: Fri, 9 Aug 2024 16:31:45 +0800
Message-ID: <20240809083148.1989912-2-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809083148.1989912-1-liujian56@huawei.com>
References: <20240809083148.1989912-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200003.china.huawei.com (7.202.181.30)

Many drivers do not implement the ib_device_ops.get_netdev callback
function; for them, use the generic helper function ib_device_get_netdev()
enough. Therefore, this patch exports ib_device_get_netdev() helper allows
it to be used in other modules.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 drivers/infiniband/core/core_priv.h | 3 ---
 drivers/infiniband/core/device.c    | 1 +
 include/rdma/ib_verbs.h             | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index dd7715ba9fd1..693b3ded69e1 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -87,9 +87,6 @@ typedef void (*roce_netdev_callback)(struct ib_device *device, u32 port,
 typedef bool (*roce_netdev_filter)(struct ib_device *device, u32 port,
 				   struct net_device *idev, void *cookie);
 
-struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
-					u32 port);
-
 void ib_enum_roce_netdev(struct ib_device *ib_dev,
 			 roce_netdev_filter filter,
 			 void *filter_cookie,
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 0290aca18d26..d25923285447 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2263,6 +2263,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 
 	return res;
 }
+EXPORT_SYMBOL(ib_device_get_netdev);
 
 /**
  * ib_device_get_by_netdev - Find an IB device associated with a netdev
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6c5712ae559d..0fe252c32d60 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4453,6 +4453,8 @@ struct net_device *ib_get_net_dev_by_params(struct ib_device *dev, u32 port,
 					    const struct sockaddr *addr);
 int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 			 unsigned int port);
+struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
+					u32 port);
 struct ib_wq *ib_create_wq(struct ib_pd *pd,
 			   struct ib_wq_init_attr *init_attr);
 int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
-- 
2.34.1


