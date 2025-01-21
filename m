Return-Path: <linux-rdma+bounces-7127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB8A177C4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E1416B582
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5128E1BEF77;
	Tue, 21 Jan 2025 06:57:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F51B87F8;
	Tue, 21 Jan 2025 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442657; cv=none; b=LSDyFD9LJE/gKPJOgpULfMkujgA9F/HSoLv/s5uXpwCBGSXcr95rutesP8N22iIsbi+np+CUffAvPkXMBl55oNwmviX95jRMhikvj2xjXA9CYjrKacbCxxTEO2ln8wK8rlwVJDzd1Q+9YTJ7Cn66bH0detF6k303eXR5mYeMdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442657; c=relaxed/simple;
	bh=9R4EBb0QHSNQehDQA1zgOuXZJ9e4ixUJtG9sqepfvAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLeWeovm1sMUnwhQsbj+Kd1Jm66Ex3zV23eDuGzWE6WZa9KPwDLOtxJaqsHshp8pPFOmqHjM2YLVC59Hl4YP4zU/bbn8rOMHMIzzrz4iSNYpkPbYrd4BiOx6o+RPBG6iafhX5x9Bpk+KV8hb8AonOrOD2he31Lp2sFkDtGF5yT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YcdGv5HzSz1kygl;
	Tue, 21 Jan 2025 14:54:15 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AA851400D5;
	Tue, 21 Jan 2025 14:57:33 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:32 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:25 +0800
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
Subject: [PATCH v1 05/21] net: phy: marvell: Use HWMON_CHANNEL_INFO macro to simplify code
Date: Tue, 21 Jan 2025 14:45:03 +0800
Message-ID: <20250121064519.18974-6-lihuisong@huawei.com>
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
 drivers/net/phy/marvell.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 44e1927de499..dd254e36ca8a 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3124,33 +3124,13 @@ static umode_t marvell_hwmon_is_visible(const void *data,
 	}
 }
 
-static u32 marvell_hwmon_chip_config[] = {
-	HWMON_C_REGISTER_TZ,
-	0
-};
-
-static const struct hwmon_channel_info marvell_hwmon_chip = {
-	.type = hwmon_chip,
-	.config = marvell_hwmon_chip_config,
-};
-
 /* we can define HWMON_T_CRIT and HWMON_T_MAX_ALARM even though these are not
  * defined for all PHYs, because the hwmon code checks whether the attributes
  * exists via the .is_visible method
  */
-static u32 marvell_hwmon_temp_config[] = {
-	HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_MAX_ALARM,
-	0
-};
-
-static const struct hwmon_channel_info marvell_hwmon_temp = {
-	.type = hwmon_temp,
-	.config = marvell_hwmon_temp_config,
-};
-
 static const struct hwmon_channel_info * const marvell_hwmon_info[] = {
-	&marvell_hwmon_chip,
-	&marvell_hwmon_temp,
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_MAX_ALARM),
 	NULL
 };
 
-- 
2.22.0


