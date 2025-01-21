Return-Path: <linux-rdma+bounces-7126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FD0A177BA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D8316B547
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 06:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5901B983E;
	Tue, 21 Jan 2025 06:57:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9411B0424;
	Tue, 21 Jan 2025 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442657; cv=none; b=KuikS32Bhk2Uu+VKcZOOi7KG+0C3Ucsd0FA7dIux0oMd3psW9IUV8jvEULVJrZ80Dg1Lmna1yqU1VqMvkfzbqjJUyQT1HuOMcgzHL9EZwZAen12xZ0N3jUdmVKq9PtylaO6MDPpKqDZ9eiBdptqpJ0fFmCoFL5IzOb7u2krsjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442657; c=relaxed/simple;
	bh=mWX/fp1URit59PoIjt60VZfGFkJQZLYn2jvxHT7rK+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJBY60LbnmI8EP3P9VRlxvk9MPmK/ZVIhFbqjDspeFhxAR581OhJmoNeVd7QQfZSlUi4a077XZbyFIjb3CtyaPPgX/hhwjhyZkk2Pqb7ZTHyei6dEI/4KU6CH9XWUX6a9SpDAZsayhcktfkCX3GkKaxcuTpXseJdQ17SGmGpGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YcdGv0jWZz2FcW9;
	Tue, 21 Jan 2025 14:54:15 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id CD2F41402C3;
	Tue, 21 Jan 2025 14:57:32 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:32 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:23 +0800
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
Subject: [PATCH v1 04/21] net: nfp: Use HWMON_CHANNEL_INFO macro to simplify code
Date: Tue, 21 Jan 2025 14:45:02 +0800
Message-ID: <20250121064519.18974-5-lihuisong@huawei.com>
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

Use HWMON_CHANNEL_INFO macro to simplify code.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 .../net/ethernet/netronome/nfp/nfp_hwmon.c    | 40 +++----------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_hwmon.c b/drivers/net/ethernet/netronome/nfp/nfp_hwmon.c
index 0d6c59d6d4ae..ea6a288c0d5e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_hwmon.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_hwmon.c
@@ -83,42 +83,12 @@ nfp_hwmon_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
 	return 0;
 }
 
-static u32 nfp_chip_config[] = {
-	HWMON_C_REGISTER_TZ,
-	0
-};
-
-static const struct hwmon_channel_info nfp_chip = {
-	.type = hwmon_chip,
-	.config = nfp_chip_config,
-};
-
-static u32 nfp_temp_config[] = {
-	HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT,
-	0
-};
-
-static const struct hwmon_channel_info nfp_temp = {
-	.type = hwmon_temp,
-	.config = nfp_temp_config,
-};
-
-static u32 nfp_power_config[] = {
-	HWMON_P_INPUT | HWMON_P_MAX,
-	HWMON_P_INPUT,
-	HWMON_P_INPUT,
-	0
-};
-
-static const struct hwmon_channel_info nfp_power = {
-	.type = hwmon_power,
-	.config = nfp_power_config,
-};
-
 static const struct hwmon_channel_info * const nfp_hwmon_info[] = {
-	&nfp_chip,
-	&nfp_temp,
-	&nfp_power,
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT),
+	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_MAX,
+			   HWMON_P_INPUT,
+			   HWMON_P_INPUT),
 	NULL
 };
 
-- 
2.22.0


