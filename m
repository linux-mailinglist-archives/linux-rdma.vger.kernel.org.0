Return-Path: <linux-rdma+bounces-7130-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9ECA177CF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5147A45EB
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 06:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B451DED74;
	Tue, 21 Jan 2025 06:57:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6321B0426;
	Tue, 21 Jan 2025 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442658; cv=none; b=kEPPMk9cdwftq8Xm/menrMaoKj1QE2Gz3wb/Y8d5V/cNm03TO6zqBIyjqlGgIutB5eYQan+HrZEPFuh2NJZBz994DQyTEOwrD7UoQJcnq4M9eRR6WTEdKRYIYnc1pq3YP3rNDXQzXdZ9Pt7pQc38AT2HxqBze6fg/yLcQ33Obvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442658; c=relaxed/simple;
	bh=26KYzChB3hECJWOSy+Gbb0c0qlL5k0uZ8wlfZh/AObY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLdLGEp+FSIwJpaxKfy1yHYa2O1/CEHtAT6W9k4VM5EEepUswl8W5PkdQPLbbVK7ZbWfMi/ivTUEn81VcbbiQq4GV3+ERTrRNH4LHXNXMWzFgr0UaYTZgw2FSp3TjOdTAmBnjwolEkorRbV1rhVeBzhoUZ44C4gE2A5Cz0fGyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YcdHr40szz22lgr;
	Tue, 21 Jan 2025 14:55:04 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7940F180042;
	Tue, 21 Jan 2025 14:57:33 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:33 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:27 +0800
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
Subject: [PATCH v1 07/21] rtc: ab-eoz9: Use HWMON_CHANNEL_INFO macro to simplify code
Date: Tue, 21 Jan 2025 14:45:05 +0800
Message-ID: <20250121064519.18974-8-lihuisong@huawei.com>
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
 drivers/rtc/rtc-ab-eoz9.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-ab-eoz9.c b/drivers/rtc/rtc-ab-eoz9.c
index d2b60487d462..de002f7a39bf 100644
--- a/drivers/rtc/rtc-ab-eoz9.c
+++ b/drivers/rtc/rtc-ab-eoz9.c
@@ -426,29 +426,9 @@ static umode_t abeoz9_is_visible(const void *data,
 	}
 }
 
-static const u32 abeoz9_chip_config[] = {
-	HWMON_C_REGISTER_TZ,
-	0
-};
-
-static const struct hwmon_channel_info abeoz9_chip = {
-	.type = hwmon_chip,
-	.config = abeoz9_chip_config,
-};
-
-static const u32 abeoz9_temp_config[] = {
-	HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN,
-	0
-};
-
-static const struct hwmon_channel_info abeoz9_temp = {
-	.type = hwmon_temp,
-	.config = abeoz9_temp_config,
-};
-
 static const struct hwmon_channel_info * const abeoz9_info[] = {
-	&abeoz9_chip,
-	&abeoz9_temp,
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN),
 	NULL
 };
 
-- 
2.22.0


