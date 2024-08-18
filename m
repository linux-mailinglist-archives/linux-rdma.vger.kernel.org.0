Return-Path: <linux-rdma+bounces-4404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363E5955B1D
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 08:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FD7B21429
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 06:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219DEDF51;
	Sun, 18 Aug 2024 06:10:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F5BD51C
	for <linux-rdma@vger.kernel.org>; Sun, 18 Aug 2024 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723961417; cv=none; b=N1bccf0TtB4DEslZ/o3NcohNWncAyBn0Zp+P+LEqUQh1/uv5263ShPTOCTmuZuMxOZFF9RuQE/DQ6X3wiS2ACqfYyLji8vKQ1ldjJF0y205UL9V4eH6jaU6+ZTMgA1noF0yVl+m0iaE5hct8KYu+H9/+aBU69EgER3ajS5Sn918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723961417; c=relaxed/simple;
	bh=gadao8vcZkI8+pPHF8U41ilo8X/KpleSrJwK/1iGobM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0sXWqhMrAglqCW5AUgZlPDUPVOP2PXJrO7v4FEK0qmwb+pSzjuxGA6ICoJ6E+OXTVk4065Ljy5Qktgg3jWQL62FmCOphpo//dSg58jn5kTMz3MZvcX4ZX8/mkTPoduArPBGv7td/jM2jewXcQHpuQyHrUiMIkwFJrfIS8DDyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WmlgC2rhtzyQ6M;
	Sun, 18 Aug 2024 14:09:27 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D0FD1401F2;
	Sun, 18 Aug 2024 14:10:02 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 18 Aug
 2024 14:10:01 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <phaddad@nvidia.com>,
	<linux-rdma@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH net-next 2/2] RDMA/ipoib: Remove unused declarations
Date: Sun, 18 Aug 2024 13:57:02 +0800
Message-ID: <20240818055702.79547-3-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240818055702.79547-1-zhangzekun11@huawei.com>
References: <20240818055702.79547-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500003.china.huawei.com (7.202.181.241)

There are some declarations without function definition, which are
listed as below:

1. ipoib_ib_tx_timer_func() has also been removed since commit 8966e28d2e40
("IB/ipoib: Use NAPI in UD/TX flows")

2. ipoib_pkey_event() has been removed since commit ee1e2c82c245
("IPoIB: Refresh paths instead of flushing them on SM change events")

3. ipoib_mcast_dev_down() has been removed since commit 988bd50300ef
("IPoIB: Fix memory leak of multicast group structures")

4. ipoib_pkey_open() has been removed since commit dd57c9308aff ("IB/ipoib:
Avoid multicast join attempts with invalid P_key")

Let's remove these unused declarations.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 963e936da5e3..abe0522b7df4 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -509,12 +509,10 @@ struct net_device *ipoib_intf_alloc(struct ib_device *hca, u32 port,
 				    const char *format);
 int ipoib_intf_init(struct ib_device *hca, u32 port, const char *format,
 		    struct net_device *dev);
-void ipoib_ib_tx_timer_func(struct timer_list *t);
 void ipoib_ib_dev_flush_light(struct work_struct *work);
 void ipoib_ib_dev_flush_normal(struct work_struct *work);
 void ipoib_ib_dev_flush_heavy(struct work_struct *work);
 void ipoib_ib_tx_timeout_work(struct work_struct *work);
-void ipoib_pkey_event(struct work_struct *work);
 void ipoib_ib_dev_cleanup(struct net_device *dev);
 
 int ipoib_ib_dev_open_default(struct net_device *dev);
@@ -533,7 +531,6 @@ void ipoib_mcast_restart_task(struct work_struct *work);
 void ipoib_mcast_start_thread(struct net_device *dev);
 void ipoib_mcast_stop_thread(struct net_device *dev);
 
-void ipoib_mcast_dev_down(struct net_device *dev);
 void ipoib_mcast_dev_flush(struct net_device *dev);
 
 int ipoib_dma_map_tx(struct ib_device *ca, struct ipoib_tx_buf *tx_req);
@@ -610,7 +607,6 @@ int  ipoib_set_mode(struct net_device *dev, const char *buf);
 
 void ipoib_setup_common(struct net_device *dev);
 
-void ipoib_pkey_open(struct ipoib_dev_priv *priv);
 void ipoib_drain_cq(struct net_device *dev);
 
 void ipoib_set_ethtool_ops(struct net_device *dev);
-- 
2.17.1


