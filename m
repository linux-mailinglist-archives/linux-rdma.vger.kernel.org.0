Return-Path: <linux-rdma+bounces-14428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5B1C51794
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 10:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13DE74E99A4
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF923002C1;
	Wed, 12 Nov 2025 09:35:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43CA2FF670
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940117; cv=none; b=H2bC0fgSRweq2PQFAvhreUcl041/Qkkj0KW1rQTvbS52CW4u0T0iqD0yjfRIIxf6LhQK/xZh3gQ/TagKVwhQ3x8PlyggibD8fv6h6vyO0+qZdpoBU9l/WeyBr5IIbEK+S/NrBCoLyMrqeZ0KK54jhsEHUvM4OTevMSAehRpteN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940117; c=relaxed/simple;
	bh=fdTpbiMmvrOTCvBezSyex6fVZRbG3848b+GjYp7dbBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ec6oWuaznbiu7vaB/DDzCUM6IZAg3RDkUmXmHoXobGQLFTB44gKxI3o33dG/lS2D32g6eXh4Sj/xhuuwv5GIeE1TgXSy9iPon4ZsPx+PK9e4iZKd0+Xs8HxeHlZY82mI17yPIwj0b4NPMMSS8wETnEops2XjO4r2WQZeK6zkRuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d5yrY6YlDz1cyQd;
	Wed, 12 Nov 2025 17:33:33 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id BBBC41A016C;
	Wed, 12 Nov 2025 17:35:13 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 17:35:13 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v3 for-next 8/8] RDMA/hns: Support reset recovery for bond
Date: Wed, 12 Nov 2025 17:35:10 +0800
Message-ID: <20251112093510.3696363-9-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251112093510.3696363-1-huangjunxian6@hisilicon.com>
References: <20251112093510.3696363-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Re-set bond configuration to HW after HW reset.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_bond.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.c b/drivers/infiniband/hw/hns/hns_roce_bond.c
index 0604ee55011e..cc85f3ce1f3e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.c
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.c
@@ -160,6 +160,15 @@ static void hns_roce_bond_get_active_slave(struct hns_roce_bond_group *bond_grp)
 	bond_grp->active_slave_map = active_slave_map;
 }
 
+static int hns_roce_recover_bond(struct hns_roce_bond_group *bond_grp,
+				 struct hns_roce_dev *hr_dev)
+{
+	bond_grp->main_hr_dev = hr_dev;
+	hns_roce_bond_get_active_slave(bond_grp);
+
+	return hns_roce_cmd_bond(bond_grp, HNS_ROCE_SET_BOND);
+}
+
 static void hns_roce_slave_uninit(struct hns_roce_bond_group *bond_grp,
 				  u8 func_idx)
 {
@@ -918,11 +927,22 @@ void hns_roce_dealloc_bond_grp(void)
 int hns_roce_bond_init(struct hns_roce_dev *hr_dev)
 {
 	struct net_device *net_dev = get_hr_netdev(hr_dev, 0);
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_bond_group *bond_grp;
 	u8 bus_num = get_hr_bus_num(hr_dev);
+	int ret;
 
 	bond_grp = hns_roce_get_bond_grp(net_dev, bus_num);
 
+	if (priv->handle->rinfo.reset_state == HNS_ROCE_STATE_RST_INIT) {
+		ret = hns_roce_recover_bond(bond_grp, hr_dev);
+		if (ret) {
+			dev_err(hr_dev->dev,
+				"failed to recover RoCE bond, ret = %d.\n", ret);
+			return ret;
+		}
+	}
+
 	return hns_roce_set_bond_netdev(bond_grp, hr_dev);
 }
 
-- 
2.33.0


