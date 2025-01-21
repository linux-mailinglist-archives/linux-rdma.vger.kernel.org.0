Return-Path: <linux-rdma+bounces-7137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E70A17800
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 08:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59CF1630F0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC81F3FF7;
	Tue, 21 Jan 2025 06:57:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4431E9B3A;
	Tue, 21 Jan 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442664; cv=none; b=dQbcHovC5bxFLDqAtNhCGIrmNcWXPpdR4QFxl21EPPDthkT7TDn+lfa+DId9437quBsG0MO4kmV+PExYBEGYv1G0vCV+lnTLRfww/Afhf5fn2KYcFdEtGgQAuAYQ1W6N2QZa2dQkcsWjqxsPndaH9F2Odn5AHEHSdZ5VMZPQHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442664; c=relaxed/simple;
	bh=rcnh1ObECijeP1gO6p6MULduz0XxyvXO9hQO++xYpFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LC7J/XfpLrA0QTEQ9frGaU6o3jnnkQpyi8Q5k9G6lh2Wsq1FpNLyg1wlBntgs9VJvUE0EtAllAdgXaltpsOiBFtfGcTg/7O0KlVt1q5xO3WpewRTawwFx8qEkpofZ/OZw6Lel98gtr6d6MLe/uN/n5RUmArK+Os1BbBLRnTkO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YcdH335Wxz2FcWT;
	Tue, 21 Jan 2025 14:54:23 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FB21180042;
	Tue, 21 Jan 2025 14:57:41 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:41 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:39 +0800
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
Subject: [PATCH v1 15/21] hwmon: (scmi-hwmon) Fix the type of 'config' in struct hwmon_channel_info to u64
Date: Tue, 21 Jan 2025 14:45:13 +0800
Message-ID: <20250121064519.18974-16-lihuisong@huawei.com>
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
 drivers/hwmon/scmi-hwmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 364199b332c0..b4b43e200d2a 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -157,10 +157,10 @@ static const struct thermal_zone_device_ops scmi_hwmon_thermal_ops = {
 
 static int scmi_hwmon_add_chan_info(struct hwmon_channel_info *scmi_hwmon_chan,
 				    struct device *dev, int num,
-				    enum hwmon_sensor_types type, u32 config)
+				    enum hwmon_sensor_types type, u64 config)
 {
 	int i;
-	u32 *cfg = devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
+	u64 *cfg = devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
 
 	if (!cfg)
 		return -ENOMEM;
@@ -181,7 +181,7 @@ static enum hwmon_sensor_types scmi_types[] = {
 	[ENERGY] = hwmon_energy,
 };
 
-static u32 hwmon_attributes[hwmon_max] = {
+static u64 hwmon_attributes[hwmon_max] = {
 	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
 	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
 	[hwmon_curr] = HWMON_C_INPUT | HWMON_C_LABEL,
-- 
2.22.0


