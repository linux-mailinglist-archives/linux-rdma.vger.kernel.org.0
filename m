Return-Path: <linux-rdma+bounces-1865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57689D4AD
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 10:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE69B21E7E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8B129E7A;
	Tue,  9 Apr 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="NeYbOX9J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB87F48A;
	Tue,  9 Apr 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651576; cv=none; b=AVUvAN/9EAWarATcCYc85aUsHIf/nveguSSLWI0XfxANvL6e1mhk9ToxozeZ4i61QJRDfs56vurEHOcxR2fEhyjplxSUMZb/N7zrnovmly0FElX/Qc2t0LwW5PjMiz/kWodpXiK0OUqZh/wh8lHZcMPPYm40wR3w/G+j6oJqhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651576; c=relaxed/simple;
	bh=xsCFOuHixbF08tK/svIdgM98daosy/MkzK3jUPi0R2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t34p+9ksdaZqrnN7azaWfLLgRxIrX1eEvnUedaAnWb3GD0tc0vyBMCmgOFRHy6Jt6qk9AeYkaaC4+uGJrXjL1X9yjEFQyXRxZ5FFN4LyxpbRPrF3VwEeBPn8bsJOUvDPOFg5Fwe68xXrvLv9KUnJderm9gpsW1T2vXj1wsCzp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=NeYbOX9J; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 4A872100002;
	Tue,  9 Apr 2024 11:32:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712651552; bh=d5ESxfrmcck3YAEVxs9SebH5mkjOsuyF4lxh4RUdU38=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NeYbOX9JsgIRo3E2AoCyKyhAe69EiIGnGgF29KylR7t0RDnlNHN82KxSFxST3SW4r
	 XyCLYI+uIZknyON35rPeYQ8TBOTogpMnkLN5OZl7YFSSFZadZHHe2KGK4py0U+XDLI
	 PXrAJxTagaqCd59cbIs7+nWsV4vUkeZv3m9RWmIPv0gNWWM1sESznDyRR6dbl3nu26
	 be4XHbFq0M6NQHlkH3Xz4lttlY58kR2Xu4HGI8Hkul3KKMhvhTjXIIyUXJ17t5oY1t
	 KgecUK8ILwX4z6rmCJMQwROpe50VFKXc3vMewzIuRD/N3aQZT022O3D9XP/53otZaT
	 19/VA9mGbHt+w==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  9 Apr 2024 11:31:23 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 11:31:03 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Wei Xu <xuwei5@hisilicon.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Chengchang Tang
	<tangchengchang@huawei.com>, Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Xi Wang
	<wangxi11@huawei.com>, Shengming Shu <shushengming1@huawei.com>, Weihang Li
	<liweihang@huawei.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] RDMA: hns: Fix possible null pointer dereference
Date: Tue, 9 Apr 2024 11:30:47 +0300
Message-ID: <20240409083047.15784-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184636 [Apr 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/09 06:51:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/09 07:19:00 #24714583
X-KSMG-AntiVirus-Status: Clean, skipped

In hns_roce_hw_v2_get_cfg() pci_match_id() may return
NULL which is later dereferenced. Fix this bug by adding NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0b567cde9d7a ("RDMA/hns: Enable RoCE on virtual functions")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ba7ae792d279..31a2093334d9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6754,7 +6754,7 @@ static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, hns_roce_hw_v2_pci_tbl);
 
-static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
+static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 				  struct hnae3_handle *handle)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
@@ -6763,6 +6763,9 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 
 	hr_dev->pci_dev = handle->pdev;
 	id = pci_match_id(hns_roce_hw_v2_pci_tbl, hr_dev->pci_dev);
+	if (!id)
+		return -ENXIO;
+
 	hr_dev->is_vf = id->driver_data;
 	hr_dev->dev = &handle->pdev->dev;
 	hr_dev->hw = &hns_roce_hw_v2;
@@ -6789,6 +6792,8 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 
 	hr_dev->reset_cnt = handle->ae_algo->ops->ae_dev_reset_cnt(handle);
 	priv->handle = handle;
+
+	return 0;
 }
 
 static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
@@ -6806,7 +6811,11 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 		goto error_failed_kzalloc;
 	}
 
-	hns_roce_hw_v2_get_cfg(hr_dev, handle);
+	ret = hns_roce_hw_v2_get_cfg(hr_dev, handle);
+	if (ret) {
+		dev_err(hr_dev->dev, "RoCE Engine cfg failed!\n");
+		goto error_failed_roce_init;
+	}
 
 	ret = hns_roce_init(hr_dev);
 	if (ret) {
-- 
2.30.2


