Return-Path: <linux-rdma+bounces-7131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03FA177D7
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB516BB21
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 06:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1AB1E98F1;
	Tue, 21 Jan 2025 06:57:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F891B043D;
	Tue, 21 Jan 2025 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442658; cv=none; b=fur7ULmUZumX/d+eHMyyZ1+BntfTxHdIJM/lisiC9/6WlYSYRRqOzo5j3N3UMcbY2mZQPHyDnGf0ua1I8szrz63NWREBC2NWyo19yioQCDfrYB8u2nCmLQK3QltseUuFVog9Vx5vHSoS7/NjWX8TUStkGH8dnV5k4gmsjIQCt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442658; c=relaxed/simple;
	bh=58yZtom8YkhzuN+i9B1U2m3skibCey3Ih9LllGAW7Rw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buQtow8WjL25nePAte+G/ucp3SEKmTDipCatOfppCEjvz3vRhtUlBRgxV0f5ENbhj4V+KMdwnAv+lwTRPn1K6z95IvuldlsHp2UwPUq/KJOEiggx4g2dGNHDbscy7WBQXzssrZhvYwfdB3RCwaNiJPBtdLcn0AUeRjegybHZpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YcdH53WRMzbp8P;
	Tue, 21 Jan 2025 14:54:25 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DE4A140203;
	Tue, 21 Jan 2025 14:57:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:33 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:32 +0800
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
Subject: [PATCH v1 10/21] net: phy: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
Date: Tue, 21 Jan 2025 14:45:08 +0800
Message-ID: <20250121064519.18974-11-lihuisong@huawei.com>
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
 drivers/net/phy/aquantia/aquantia_hwmon.c | 32 +++++------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_hwmon.c b/drivers/net/phy/aquantia/aquantia_hwmon.c
index 7b3c49c3bf49..02b7a2639bbb 100644
--- a/drivers/net/phy/aquantia/aquantia_hwmon.c
+++ b/drivers/net/phy/aquantia/aquantia_hwmon.c
@@ -172,33 +172,13 @@ static const struct hwmon_ops aqr_hwmon_ops = {
 	.write = aqr_hwmon_write,
 };
 
-static u32 aqr_hwmon_chip_config[] = {
-	HWMON_C_REGISTER_TZ,
-	0,
-};
-
-static const struct hwmon_channel_info aqr_hwmon_chip = {
-	.type = hwmon_chip,
-	.config = aqr_hwmon_chip_config,
-};
-
-static u32 aqr_hwmon_temp_config[] = {
-	HWMON_T_INPUT |
-	HWMON_T_MAX | HWMON_T_MIN |
-	HWMON_T_MAX_ALARM | HWMON_T_MIN_ALARM |
-	HWMON_T_CRIT | HWMON_T_LCRIT |
-	HWMON_T_CRIT_ALARM | HWMON_T_LCRIT_ALARM,
-	0,
-};
-
-static const struct hwmon_channel_info aqr_hwmon_temp = {
-	.type = hwmon_temp,
-	.config = aqr_hwmon_temp_config,
-};
-
 static const struct hwmon_channel_info * const aqr_hwmon_info[] = {
-	&aqr_hwmon_chip,
-	&aqr_hwmon_temp,
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT |
+			HWMON_T_MAX | HWMON_T_MIN |
+			HWMON_T_MAX_ALARM | HWMON_T_MIN_ALARM |
+			HWMON_T_CRIT | HWMON_T_LCRIT |
+			HWMON_T_CRIT_ALARM | HWMON_T_LCRIT_ALARM),
 	NULL,
 };
 
-- 
2.22.0


