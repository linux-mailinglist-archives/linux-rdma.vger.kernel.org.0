Return-Path: <linux-rdma+bounces-7138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CBA17811
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C317A0FFA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678141F4714;
	Tue, 21 Jan 2025 06:57:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BA1F37D4;
	Tue, 21 Jan 2025 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442668; cv=none; b=VgCsCDiW0w6/Iz+EOQipv0/eIXOhBjMZEkagS67E60FB+ielWinRbq+fb1BOy+hZ4I9F1kwG3AULV+w57wvkc760ghgUttKsei0ppv4JVSS8G4REhcHezJyVoRNYOQKLZcBodPQjJxZiaMJsZGtPB2nuX7Wi2UfaYUmfV1ealdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442668; c=relaxed/simple;
	bh=nZ4/J8KMNP6TkpAGFQdOyK4w82kRclTB6tDx4Bt52FM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kv3O7pT/d7L+TscprQDbj8dNPs7zkYjFLdTomv0sb/fb2dcfR1x9bDGpKMWmN8bmQ2UeQNEtv0kVKvfPiZvA/kNc4/l78P6iOD+FdVy2vWHTmAKMF2cB+5fH2105dYPo63imSpT3pvWe4msvV3DRdpWciRULSuFBZUfotSBpBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YcdJ270mszRlkD;
	Tue, 21 Jan 2025 14:55:14 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 1762D140155;
	Tue, 21 Jan 2025 14:57:44 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 Jan 2025 14:57:43 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:42 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-hwmon@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <arm-scmi@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<oss-drivers@corigine.com>, <linux-rdma@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux@roeck-us.net>, <jdelvare@suse.com>, <kernel@maidavale.org>,
	<pauk.denis@gmail.com>, <james@equiv.tech>, <sudeep.holla@arm.com>,
	<cristian.marussi@arm.com>, <matt@ranostay.sg>, <mchehab@kernel.org>,
	<irusskikh@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
	<louis.peens@corigine.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<kabel@kernel.org>, <W_Armin@gmx.de>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <alexandre.belloni@bootlin.com>,
	<krzk@kernel.org>, <jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 17/21] hwmon: (tmp421) Fix the type of 'config' in struct hwmon_channel_info to u64
Date: Tue, 21 Jan 2025 14:45:15 +0800
Message-ID: <20250121064519.18974-18-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250121064519.18974-1-lihuisong@huawei.com>
References: <20250121064519.18974-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The type of 'config' in struct hwmon_channel_info has been fixed to u64.
Modify the related code in driver to avoid compiling failure.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/tmp421.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 9537727aad9a..45bd04ec03b8 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -100,7 +100,7 @@ struct tmp421_channel {
 struct tmp421_data {
 	struct i2c_client *client;
 	struct mutex update_lock;
-	u32 temp_config[MAX_CHANNELS + 1];
+	u64 temp_config[MAX_CHANNELS + 1];
 	struct hwmon_channel_info temp_info;
 	const struct hwmon_channel_info *info[2];
 	struct hwmon_chip_info chip;
-- 
2.22.0


