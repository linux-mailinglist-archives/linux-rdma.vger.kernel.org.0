Return-Path: <linux-rdma+bounces-7139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0FA17816
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 08:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FDB1881329
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A11F4E33;
	Tue, 21 Jan 2025 06:57:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33991B218B;
	Tue, 21 Jan 2025 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442669; cv=none; b=rxO//DPbqtzHJ7S9elTdnWGQh5DTCsIGlrLnfQQX1GPrml37wAQld73MbFi0mu97XoDs1RJFlMqANCjHEHWCuH6KGnIhmVzCoatnFBVyXRB0djrBHdbbWOzDYWK1aucWM8HoeKgXGLGO2CRUp9kIceJslPNM7uW+0JNk3ubppAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442669; c=relaxed/simple;
	bh=3EkVz02jQnSqLYxB/Hwwe223CTvBiIcVa+DqBc+/ipY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYPVQi6PO2qSVsECMxccxZz+WHiiAcN1ZWFueWZccB2oe7fe07bI8hxiSQXyYMMLKlKHchJGonIS1h6xbrSzlvgpAte5lx6uvMVI+5zqXheaz7dQdamWyXdo8tzVJSHqdcEAr8Bs88JbFN3WQ/NlHVtv0GRgYSZpfWsIh4JLXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YcdHG4ZBczgbt5;
	Tue, 21 Jan 2025 14:54:34 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A2FE1800D1;
	Tue, 21 Jan 2025 14:57:45 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 Jan 2025 14:57:45 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:43 +0800
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
Subject: [PATCH v1 18/21] net/mlx5: Fix the type of 'config' in struct hwmon_channel_info to u64
Date: Tue, 21 Jan 2025 14:45:16 +0800
Message-ID: <20250121064519.18974-19-lihuisong@huawei.com>
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
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
index 353f81dccd1c..fe39b97d214e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
@@ -30,9 +30,9 @@ struct mlx5_hwmon {
 	struct mlx5_core_dev *mdev;
 	struct device *hwmon_dev;
 	struct hwmon_channel_info chip_info;
-	u32 chip_channel_config[CHIP_CONFIG_NUM + 1];
+	u64 chip_channel_config[CHIP_CONFIG_NUM + 1];
 	struct hwmon_channel_info temp_info;
-	u32 *temp_channel_config;
+	u64 *temp_channel_config;
 	const struct hwmon_channel_info *channel_info[CHANNELS_TYPE_NUM + 1];
 	struct hwmon_chip_info chip;
 	struct temp_channel_desc *temp_channel_desc;
@@ -233,14 +233,14 @@ static void mlx5_hwmon_channel_info_init(struct mlx5_hwmon *hwmon)
 	hwmon->channel_info[1] = &hwmon->temp_info;
 
 	hwmon->chip_channel_config[0] = HWMON_C_REGISTER_TZ;
-	hwmon->chip_info.config = (const u32 *)hwmon->chip_channel_config;
+	hwmon->chip_info.config = (const u64 *)hwmon->chip_channel_config;
 	hwmon->chip_info.type = hwmon_chip;
 
 	for (i = 0; i < hwmon->asic_platform_scount + hwmon->module_scount; i++)
 		hwmon->temp_channel_config[i] = HWMON_T_INPUT | HWMON_T_HIGHEST | HWMON_T_CRIT |
 					     HWMON_T_RESET_HISTORY | HWMON_T_LABEL;
 
-	hwmon->temp_info.config = (const u32 *)hwmon->temp_channel_config;
+	hwmon->temp_info.config = (const u64 *)hwmon->temp_channel_config;
 	hwmon->temp_info.type = hwmon_temp;
 }
 
-- 
2.22.0


